export default class BaseAPI {
  static sendAjax(callback, options) {
    BaseAPI.requestNumber = BaseAPI.requestNumber || 0;
    BaseAPI.requestNumber++;

    options.success = (response) => {
      if (callback) {
        callback(response.status, response.data);
      }
    }

    options.error = (xhr) => {
      if (xhr.status == 422 || xhr.status == 401) {
        return false;
      }

      if (callback) {
        callback(false);
      }
    }

    options.complete = () => {
      BaseAPI.requestNumber--;
    }

    options.url = "/api/" + options.url;
    $.ajax(options);
  }
}
