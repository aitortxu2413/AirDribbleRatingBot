# Bot Commands

This document describes all available commands of the bot.

## Administrator commands

### `/set-settings`

Set the needed settings for the bot to work.


| Parameter       | Type      | Required | Description                                            |
| --------------- | --------- | -------- | ------------------------------------------------------ |
| `channel`       | `channel` | ✅       | Set the moderator channel to receive players' submits. |
| `grounddweller` | `role`    | ✅       | Set the Ground Dweller role to use.                    |
| `beginner`      | `role`    | ✅       | Set the Beginner role to use.                          |
| `apprentice`    | `role`    | ✅       | Set the Apprentice role to use.                        |
| `intermediate`  | `role`    | ✅       | Set the Intermediate role to use.                      |
| `advanced`      | `role`    | ✅       | Set the Advanced role to use.                          |
| `expert`        | `role`    | ✅       | Set the Expert role to use.                            |
| `master`        | `role`    | ✅       | Set the Master role to use.                            |
| `legend`        | `role`    | ✅       | Set the Legend role to use.                            |
| `mythic`        | `role`    | ✅       | Set the Mythic role to use.                            |
| `demigod`       | `role`    | ✅       | Set the Demigod role to use.                           |
| `airdribblegod` | `role`    | ✅       | Set the Air Dribble God role to use.                   |

---

### `/challenge-create`

Create a new challenge.

#### Subcommands

##### `normal`

Create a normal challenge.


| Parameter     | Type     | Required | Description                    |
| ------------- | -------- | -------- | ------------------------------ |
| `name`        | `string` | ✅       | Challenge's name.              |
| `rank`        | `string` | ✅       | Challenge's rank               |
| `rating`      | `number` | ✅       | Rating value.                  |
| `description` | `string` | ✅       | Description.                   |
| `url1`        | `string` | ✅       | First example's url.           |
| `url2`        | `string` | ❌       | Optional second example's url. |

##### `bonus`

Create a bonus challenge.


| Parameter     | Type     | Required | Description                    |
| ------------- | -------- | -------- | ------------------------------ |
| `name`        | `string` | ✅       | Challenge's name.              |
| `rating`      | `number` | ✅       | Rating value.                  |
| `description` | `string` | ✅       | Description.                   |
| `url1`        | `string` | ✅       | First example's url.           |
| `url2`        | `string` | ❌       | Optional second example's url. |

---

### `/challenge-edit`

Edit an existing challenges.

#### **SubcommandGroup**

##### `normal`

Edit or delete a normal challenge.

##### **Subcommands**

##### `edit`

Edit a normal challenge.


| Parameter     | Type      | Required | Description                         |
| ------------- | --------- | -------- | ----------------------------------- |
| `number`      | `number`  | ✅       | Number of the challenge to edit.    |
| `name`        | `string`  | ❌       | Edit challenge's name.              |
| `rank`        | `string`  | ❌       | Edit challenge's rank               |
| `rating`      | `number`  | ❌       | Edit rating value.                  |
| `description` | `string`  | ❌       | Edit description.                   |
| `url1`        | `string`  | ❌       | Edit first example's url.           |
| `url2`        | `string`  | ❌       | Edit optional second example's url. |
| `deleteUrl2`  | `boolean` | ❌       | Delete the second url.              |

##### `delete`

Delete a normal challenge.


| Parameter | Type     | Required | Description                        |
| --------- | -------- | -------- | ---------------------------------- |
| `number`  | `number` | ✅       | Number of the challenge to delete. |

#### **SubcommandGroup**

##### `bonus`

Edit or delete a bonus challenge.

##### **Subcommands**

##### `edit`

Edit a normal challenge.


| Parameter     | Type      | Required | Description                         |
| ------------- | --------- | -------- | ----------------------------------- |
| `number`      | `number`  | ✅       | Number of the challenge to edit.    |
| `name`        | `string`  | ❌       | Edit challenge's name.              |
| `rating`      | `number`  | ❌       | Edit rating value.                  |
| `description` | `string`  | ❌       | Edit description.                   |
| `url1`        | `string`  | ❌       | Edit first example's url.           |
| `url2`        | `string`  | ❌       | Edit optional second example's url. |
| `deleteUrl2`  | `boolean` | ❌       | Delete the second url.              |

##### `delete`

Delete a normal challenge.


| Parameter | Type     | Required | Description                        |
| --------- | -------- | -------- | ---------------------------------- |
| `number`  | `number` | ✅       | Number of the challenge to delete. |

---

### `/complete-challenge`

Mark as completed a challenge for someone. Just for admins.


| Parameter | Type      | Required | Description                                          |
| --------- | --------- | -------- | ---------------------------------------------------- |
| `player`  | `user`    | ✅       | The player whose challenge is going to be completed. |
| `bonus`   | `boolean` | ✅       | Choose between a normal or bonus challenge.          |
| `number`  | `number`  | ✅       | The number of the challenge.                         |
| `url`     | `string`  | ✅       | Url of the video.                                    |

---

### `/derank`

Derank a player by one rank each time.


| Parameter | Type   | Required | Description                         |
| --------- | ------ | -------- | ----------------------------------- |
| `player`  | `user` | ✅       | The player to derank just one rank. |

---

### `/completed-challenge-remove`

Delete a player's normal or bonus completed challenge


| Parameter | Type      | Required | Description                            |
| --------- | --------- | -------- | -------------------------------------- |
| `player`  | `user`    | ✅       | The player whose rank will be deleted. |
| `bonus`   | `boolean` | ✅       | Choose a bonus or normal challenge.    |
| `number`  | `number`  | ✅       | Number of the challenge to delete.     |

## User commands

### `/check-ranking`

Show player rankings with optional filters.


| Parameter | Type      | Required | Description                                            |
| --------- | --------- | -------- | ------------------------------------------------------ |
| (none)    | -         | -        | Show the normal ranking.                               |
| `bonus`   | `boolean` | ❌       | Show the bonus ranking.                                |
| `rank`    | `string`  | ❌       | Filter by rank name (for example,`"Air Dribble God"`). |

---

### `/challenge-list`

Paginated list of challenges.


| Parameter | Type      | Required | Description                                         |
| --------- | --------- | -------- | --------------------------------------------------- |
| (none)    | -         | -        | Show all the normal challenges.                     |
| `bonus`   | `boolean` | ❌       | Lists the bonus challenges.                         |
| `rank`    | `string`  | ❌       | Filter challenges by rank.                          |
| `number`  | `number`  | ❌       | Show all the information from a specific challenge. |

---

### `/submit`

Submit a completed challenge.


| Parameter | Type      | Required | Description                            |
| --------- | --------- | -------- | -------------------------------------- |
| `bonus`   | `boolean` | ✅       | Submit for bonus or normal challenge.  |
| `number`  | `number`  | ✅       | The number of the challenge to submit. |
| `url`     | `string`  | ✅       | Url of the video.                      |
| `notes`   | `string`  | ❌       | Notes for moderators.                  |

---

### `/profile-stats`

See someone's profile. It shows name, rank, position in the normal and bonus leaderboard and rating on both.


| Parameter | Type   | Required | Description                            |
| --------- | ------ | -------- | -------------------------------------- |
| (none)    | -      | -        | Show own stats.                        |
| `player`  | `user` | ❌       | The player whose stats will be showed. |

---

### `/profile-challenges`

See someone's completed challenges.


| Parameter | Type      | Required | Description                                           |
| --------- | --------- | -------- | ----------------------------------------------------- |
| (none)    | -         | -        | Show own completed challenges.                        |
| `player`  | `user`    | ❌       | The player whose completed challenges will be showed. |
| `bonus`   | `boolean` | ❌       | Switch between bonus and normal challenges            |