import Constants  from '../constants';

const Actions = {
  showForm: (show) => {
    return dispatch => {
      dispatch({
        type: Constants.CURRENT_BOARD_SHOW_FORM,
        show: show,
      });
    };
  },

  connectToChannel: (socket, boardId) => {
    return dispatch => {
      const channel = socket.channel(`boards:${boardId}`);

      dispatch({ type: Constants.CURRENT_BOARD_FETCHING });

      channel.join().receive('ok', (response) => {
        dispatch({
          type: Constants.BOARDS_SET_CURRENT_BOARD,
          board: response.board,
        });

        dispatch({
          type: Constants.CURRENT_BOARD_CONNECTED_TO_CHANNEL,
          channel: channel,
        });
      });

      channel.on('user:joined', (msg) => {
        dispatch({
          type: Constants.CURRENT_BOARD_CONNECTED_USERS,
          users: msg.users,
        });
      });

      channel.on('user:left', (msg) => {
        dispatch({
          type: Constants.CURRENT_BOARD_CONNECTED_USERS,
          users: msg.users,
        });
      });

      channel.on('list:created', (msg) => {
        dispatch({
          type: Constants.CURRENT_BOARD_LIST_CREATED,
          list: msg.list,
        });
      });
    };
  },

  leaveChannel: (channel) => {
    return dispatch => {
      channel.leave();
    };
  },

  showCardForm: (listId) => {
    return dispatch => {
      dispatch({
        type: Constants.CURRENT_BOARD_SHOW_CARD_FORM_FOR_LIST,
        listId: listId,
      });
    };
  },
};

export default Actions;
