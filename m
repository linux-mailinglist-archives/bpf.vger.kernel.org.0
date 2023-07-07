Return-Path: <bpf+bounces-4431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1B74B2DA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D279B1C21001
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1CD50B;
	Fri,  7 Jul 2023 14:12:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB10C135
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 14:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90D7C433C7;
	Fri,  7 Jul 2023 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688739141;
	bh=xKI4tJjFwB2inCEEimsopT5TgiFdgHAOO7kacDEX0Zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0IdHISGjGsWRx49yYNiXBaeszm77RxZs94VsAK1AjPyUQt7kYJ43l7l1XQIC6cw4
	 F/N+9Jt6YLXBOcqaiEIU4wQOhEssDB8HLzOb4TeBD8AZKYDco8m8tDQqwf0tuZj7Ob
	 aMF6QUip7T+DfTIlrBkQEmIoeArHXnBOhyeT9MH7X2WPPALZLbUR+CW4o07pQg8cYm
	 YvDQApfh0vMoGCuq3olqv6uKf+EJ69ra5/4uKCpR9WT0SVq20rGQY6UJ6+InHznhZw
	 jXP1LK2FEqUnT3plEtSo5vEsk8dd797RVC/wypoGsNcgTdoVKAHeZ4HHjdgmomLzSd
	 UXD4/N60w5IkQ==
Date: Fri, 7 Jul 2023 23:12:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <pengdonglin@sangfor.com.cn>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 linux-trace-kernel@vger.kernel.org, Ding Hui <dinghui@sangfor.com.cn>,
 huangcun@sangfor.com.cn
Subject: Re: [PATCH v13 09/12] tracing/probes: Add BTF retval type support
Message-Id: <20230707231214.2787a24ac36d41f7edc5e94a@kernel.org>
In-Reply-To: <cb07ac16-cc0f-7e8d-6271-cde2e02e739d@sangfor.com.cn>
References: <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
	<168507476195.913472.16290308831790216609.stgit@mhiramat.roam.corp.google.com>
	<cb07ac16-cc0f-7e8d-6271-cde2e02e739d@sangfor.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jun 2023 15:29:00 +0800
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> On 2023/5/26 12:19, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Check the target function has non-void retval type and set the correct
> > fetch type if user doesn't specify it.
> > If the function returns void, $retval is rejected as below;
> > 
> >   # echo 'f unregister_kprobes%return $retval' >> dynamic_events
> > sh: write error: No such file or directory
> >   # cat error_log
> > [   37.488397] trace_fprobe: error: This function returns 'void' type
> >    Command: f unregister_kprobes%return $retval
> >                                         ^
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> > Changes in v8:
> >   - Fix wrong indentation.
> > Changes in v7:
> >   - Introduce this as a new patch.
> > ---
> >   kernel/trace/trace_probe.c |   69 ++++++++++++++++++++++++++++++++++++++++----
> >   kernel/trace/trace_probe.h |    1 +
> >   2 files changed, 63 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 7318642aceb3..dfe3e1823eec 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -371,15 +371,13 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
> >   	return NULL;
> >   }
> >   
> > -static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> > -						   bool tracepoint)
> > +static const struct btf_type *find_btf_func_proto(const char *funcname)
> >   {
> >   	struct btf *btf = traceprobe_get_btf();
> > -	const struct btf_param *param;
> >   	const struct btf_type *t;
> >   	s32 id;
> >   
> > -	if (!btf || !funcname || !nr)
> > +	if (!btf || !funcname)
> >   		return ERR_PTR(-EINVAL);
> >   
> >   	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> > @@ -396,6 +394,22 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
> >   	if (!btf_type_is_func_proto(t))
> >   		return ERR_PTR(-ENOENT);
> >   
> > +	return t;
> > +}
> > +
> > +static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> > +						   bool tracepoint)
> > +{
> > +	const struct btf_param *param;
> > +	const struct btf_type *t;
> > +
> > +	if (!funcname || !nr)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	t = find_btf_func_proto(funcname);
> > +	if (IS_ERR(t))
> > +		return (const struct btf_param *)t;
> > +
> >   	*nr = btf_type_vlen(t);
> >   	param = (const struct btf_param *)(t + 1);
> >   
> > @@ -462,6 +476,32 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
> >   	return find_fetch_type(typestr, ctx->flags);
> >   }
> >   
> > +static const struct fetch_type *parse_btf_retval_type(
> > +					struct traceprobe_parse_context *ctx)
> > +{
> 
> Can we make this a common interface so that the funcgraph-retval can
>   also use it to get the return type?

It is possible to expose BTF part as an independent file so that
other ftrace tracers reuse it.
But you might need to store the result for each function somewhere
in the kernel. Would you have any idea?

Thank you,

> 
> -- Donglin Peng
> 
> > +	struct btf *btf = traceprobe_get_btf();
> > +	const char *typestr = NULL;
> > +	const struct btf_type *t;
> > +
> > +	if (btf && ctx->funcname) {
> > +		t = find_btf_func_proto(ctx->funcname);
> > +		if (!IS_ERR(t))
> > +			typestr = type_from_btf_id(btf, t->type);
> > +	}
> > +
> > +	return find_fetch_type(typestr, ctx->flags);
> > +}
> > +
> > +static bool is_btf_retval_void(const char *funcname)
> > +{
> > +	const struct btf_type *t;
> > +
> > +	t = find_btf_func_proto(funcname);
> > +	if (IS_ERR(t))
> > +		return false;
> > +
> > +	return t->type == 0;
> > +}
> >   #else
> >   static struct btf *traceprobe_get_btf(void)
> >   {
> > @@ -480,8 +520,15 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> >   	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> >   	return -EOPNOTSUPP;
> >   }
> > +
> >   #define parse_btf_arg_type(idx, ctx)		\
> >   	find_fetch_type(NULL, ctx->flags)
> > +
> > +#define parse_btf_retval_type(ctx)		\
> > +	find_fetch_type(NULL, ctx->flags)
> > +
> > +#define is_btf_retval_void(funcname)	(false)
> > +
> >   #endif
> >   
> >   #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
> > @@ -512,6 +559,11 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
> >   
> >   	if (strcmp(arg, "retval") == 0) {
> >   		if (ctx->flags & TPARG_FL_RETURN) {
> > +			if ((ctx->flags & TPARG_FL_KERNEL) &&
> > +			    is_btf_retval_void(ctx->funcname)) {
> > +				err = TP_ERR_NO_RETVAL;
> > +				goto inval;
> > +			}
> >   			code->op = FETCH_OP_RETVAL;
> >   			return 0;
> >   		}
> > @@ -912,9 +964,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
> >   		goto fail;
> >   
> >   	/* Update storing type if BTF is available */
> > -	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
> > -	    !t && code->op == FETCH_OP_ARG)
> > -		parg->type = parse_btf_arg_type(code->param, ctx);
> > +	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
> > +		if (code->op == FETCH_OP_ARG)
> > +			parg->type = parse_btf_arg_type(code->param, ctx);
> > +		else if (code->op == FETCH_OP_RETVAL)
> > +			parg->type = parse_btf_retval_type(ctx);
> > +	}
> >   
> >   	ret = -EINVAL;
> >   	/* Store operation */
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index c864e6dea10f..eb43bea5c168 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -449,6 +449,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
> >   	C(BAD_EVENT_NAME,	"Event name must follow the same rules as C identifiers"), \
> >   	C(EVENT_EXIST,		"Given group/event name is already used by another event"), \
> >   	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
> > +	C(NO_RETVAL,		"This function returns 'void' type"),	\
> >   	C(BAD_STACK_NUM,	"Invalid stack number"),		\
> >   	C(BAD_ARG_NUM,		"Invalid argument number"),		\
> >   	C(BAD_VAR,		"Invalid $-valiable specified"),	\
> > 
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

