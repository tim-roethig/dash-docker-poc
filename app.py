import logging
import dash
from dash import html, dcc
from dash.dependencies import Input, Output, State
from flask import request, current_app

# init app
app = dash.Dash()

# def server
server = app.server

# set logging
log = logging.getLogger('werkzeug')
log.setLevel(logging.DEBUG)

# init cache
with server.app_context():
    current_app.rfq = None


@server.route('/post_rfq', methods=['POST'])
def post_rfq():
    current_app.rfq = request.headers.get('X-rfq')
    print('set:', current_app.rfq)

    return '204'


# def popup
app.layout = html.Div(
    children=[
        html.Div(id='content', children=['empty']),
        dcc.Interval(id='interval', interval=1000),
        dcc.Store(id='stored-rfq'),
    ]
)


@app.callback(
    Output('stored-rfq', 'data'),
    Input('interval', 'n_intervals'),
    State('stored-rfq', 'data')
)
def listen_for_rfq(_, stored_rfq):
    if stored_rfq != current_app.rfq:
        return current_app.rfq
    else:
        return dash.no_update


@app.callback(
    Output('content', 'children'),
    Input('stored-rfq', 'data')
)
def update_popup(stored_rfq):
    return stored_rfq


if __name__ == '__main__':
    app.run_server(debug=True, host='0.0.0.0', port=REST_PORT)
