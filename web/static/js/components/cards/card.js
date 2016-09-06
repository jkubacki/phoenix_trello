import React, {PropTypes}       from 'react';
import { push }                 from 'react-router-redux';
import ReactGravatar            from 'react-gravatar';
import classnames               from 'classnames';

import Actions                  from '../../actions/current_board';
// import CardActions              from '../../actions/current_card';

export default class Card extends React.Component {
  _handleClick(e) {
    const { dispatch, id, boardId } = this.props;

    dispatch(push(`/boards/${boardId}/cards/${id}`));
  }

  render() {
    const { id, name } = this.props;

    return (
      <div id={`card_${id}`} className="card" style={{display: "block"}} onClick={::this._handleClick}>
        <div className="card-content">
          {name}
        </div>
      </div>
    )
  }
}

Card.propTypes = {
};
