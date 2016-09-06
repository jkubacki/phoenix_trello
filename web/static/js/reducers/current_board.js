import Constants  from '../constants';

const initialState = {
  channel: null,
  fetching: true,
  connectedUsers: [],
};

export default function reducer(state = initialState, action = {}) {
  let lists;

  switch (action.type) {
    case Constants.CURRENT_BOARD_FETHING:
      return { ...state, fetching: true };

    case Constants.BOARDS_SET_CURRENT_BOARD:
      return { ...state, fetching: false, ...action.board };

    case Constants.CURRENT_BOARD_CONNECTED_TO_CHANNEL:
      return { ...state, channel: action.channel };

    case Constants.CURRENT_BOARD_CONNECTED_USERS:
      return { ...state, connectedUsers: action.users };

    case Constants.CURRENT_BOARD_LIST_CREATED:
      lists = state.lists;
      lists.push(action.list);

      return { ...state, lists: lists, showForm: false };


    default:
      return state;
  }
}
