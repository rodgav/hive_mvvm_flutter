abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
}

abstract class BaseViewModelInput {
  void start();

  void ending();

}

abstract class BaseViewModelOutput {

}
