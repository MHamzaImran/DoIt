import '../helpers/models/profile.dart';
import '../helpers/models/repositories/repository.dart';

class ProfileService {
  final Repository _repository = Repository();

  saveProfile(Profile profile) async {
    var result = await _repository.insertProfileData('profile', profile.profileMap());
    return result;
  }

  readProfile() async {
    return await _repository.readProfileData('profile');
  }

  deleteProfile() async {
    return await _repository.deleteProfileData('profile');
  }
}
