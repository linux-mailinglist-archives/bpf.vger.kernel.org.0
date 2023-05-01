Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D86F3014
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjEAKME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEAKMD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 06:12:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C87E6;
        Mon,  1 May 2023 03:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F8E160C7E;
        Mon,  1 May 2023 10:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A2AC433EF;
        Mon,  1 May 2023 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682935921;
        bh=h0t6NLf28prZTTjCPR1Idcg/q0s9kcDfK8NqSvKf9Wg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dEaWyI/CIBFupTdf6wvte2v2hgOI6xJANFSpjayG1ygaBG28VelaFIbxGEYuVkspv
         6Ro8HmET4h5E0O+UDLGAW9jPImuxYW+CsXljIuBUB1wIQzxpMYQigLhrlaLo9UihR1
         MkwRbZn+TDa32ap06T1+J9zpOLXQKGegiNAJfPKtELKVU/xnaR1i/I8YSMZQnR8MaY
         eP2iEz6DaFO/7aa9rRX7vUYWQ/cCMdd9XLhHbf9UppoZC1QYcS5n+q0tIpdH+28SYg
         Vota32l8bgPMkxZDSsZFx+GlKVju0+embUiRRb3bu34xy9UfKx6msvKUu93eRlRRgk
         CP8ILqYJaF7Zg==
Date:   Mon, 1 May 2023 19:11:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v7 08/11] tracing/probes: Add BTF retval type support
Message-Id: <20230501191157.fc28453f345f415ae76bb82c@kernel.org>
In-Reply-To: <168255834145.2565678.12184411713423630481.stgit@mhiramat.roam.corp.google.com>
References: <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
        <168255834145.2565678.12184411713423630481.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Apr 2023 10:19:01 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Check the target function has non-void retval type and set the correct
> fetch type if user doesn't specify it.
> If the function returns void, $retval is rejected as below;
> 
>  # echo 'f unregister_kprobes%return $retval' >> dynamic_events
> sh: write error: No such file or directory
>  # cat error_log
> [   37.488397] trace_fprobe: error: This function returns 'void' type
>   Command: f unregister_kprobes%return $retval
>                                        ^
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v7:
>  - Introduce this as a new patch.
> ---
>  kernel/trace/trace_probe.c |   65 +++++++++++++++++++++++++++++++++++++++++---
>  kernel/trace/trace_probe.h |    1 +
>  2 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 4c3c70862a9a..16d8edfe3d15 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -371,13 +371,13 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
>  	return NULL;
>  }
>  
> -static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr)
> +static const struct btf_type *find_btf_func_proto(const char *funcname)
>  {
>  	struct btf *btf = traceprobe_get_btf();
>  	const struct btf_type *t;
>  	s32 id;
>  
> -	if (!btf || !funcname || !nr)
> +	if (!btf || !funcname)
>  		return ERR_PTR(-EINVAL);
>  
>  	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> @@ -394,6 +394,20 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
>  	if (!btf_type_is_func_proto(t))
>  		return ERR_PTR(-ENOENT);
>  
> +	return t;
> +}
> +
> +static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr)
> +{
> +	const struct btf_type *t;
> +
> +	if (!funcname || !nr)
> +		return ERR_PTR(-EINVAL);
> +
> +	t = find_btf_func_proto(funcname);
> +	if (IS_ERR(t))
> +		return (const struct btf_param *)t;
> +
>  	*nr = btf_type_vlen(t);
>  
>  	if (*nr)
> @@ -452,6 +466,32 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
>  	return find_fetch_type(typestr, ctx->flags);
>  }
>  
> +static const struct fetch_type *parse_btf_retval_type(
> +					struct traceprobe_parse_context *ctx)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	const char *typestr = NULL;
> +	const struct btf_type *t;
> +
> +	if (btf && ctx->funcname) {
> +		t = find_btf_func_proto(ctx->funcname);
> +		if (!IS_ERR(t))
> +			typestr = type_from_btf_id(btf, t->type);
> +	}
> +
> +	return find_fetch_type(typestr, ctx->flags);
> +}
> +
> +static bool is_btf_retval_void(const char *funcname)
> +{
> +	const struct btf_type *t;
> +
> +	t = find_btf_func_proto(funcname);
> +	if (IS_ERR(t))
> +		return false;
> +
> +	return t->type == 0;
> +}
>  #else
>  static struct btf *traceprobe_get_btf(void)
>  {
> @@ -469,8 +509,15 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
>  	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
>  	return -EOPNOTSUPP;
>  }
> +
>  #define parse_btf_arg_type(idx, ctx)		\
>  	find_fetch_type(NULL, ctx->flags)
> +
> +#define parse_btf_retval_type(ctx)		\
> +	find_fetch_type(NULL, ctx->flags)
> +
> +#define is_btf_retval_void(funcname)	(false)
> +
>  #endif
>  
>  #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
> @@ -500,7 +547,12 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
>  
>  	if (strcmp(arg, "retval") == 0) {
>  		if (ctx->flags & TPARG_FL_RETURN) {
> -			code->op = FETCH_OP_RETVAL;
> +			if ((ctx->flags & TPARG_FL_KERNEL) &&
> +			    is_btf_retval_void(ctx->funcname)) {
> +				trace_probe_log_err(ctx->offset, NO_RETVAL);
> +				ret = -ENOENT;
> +			} else
> +				code->op = FETCH_OP_RETVAL;
>  		} else {
>  			trace_probe_log_err(ctx->offset, RETVAL_ON_PROBE);
>  			ret = -EINVAL;
> @@ -887,9 +939,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  		goto fail;
>  
>  	/* Update storing type if BTF is available */
> -	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
> -	    !t && code->op == FETCH_OP_ARG)
> +	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
> +	    if (code->op == FETCH_OP_ARG)
>  		parg->type = parse_btf_arg_type(code->param, ctx);
> +	    else if (code->op == FETCH_OP_RETVAL)
> +		parg->type = parse_btf_retval_type(ctx);
> +	}

Oops, here are wrong indents. I have to fix this.

Thanks,

>  
>  	ret = -EINVAL;
>  	/* Store operation */
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 8c5b029c5d62..3eb7c37c0984 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -444,6 +444,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(BAD_EVENT_NAME,	"Event name must follow the same rules as C identifiers"), \
>  	C(EVENT_EXIST,		"Given group/event name is already used by another event"), \
>  	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
> +	C(NO_RETVAL,		"This function returns 'void' type"),	\
>  	C(BAD_STACK_NUM,	"Invalid stack number"),		\
>  	C(BAD_ARG_NUM,		"Invalid argument number"),		\
>  	C(BAD_VAR,		"Invalid $-valiable specified"),	\
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
