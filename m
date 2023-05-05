Return-Path: <bpf+bounces-153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F626F8B36
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B1F281111
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABB5DF5C;
	Fri,  5 May 2023 21:40:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051E4C99
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272CEC433EF;
	Fri,  5 May 2023 21:40:34 +0000 (UTC)
Date: Fri, 5 May 2023 17:40:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 05/11] tracing/probes: Move event parameter
 fetching code to common parser
Message-ID: <20230505174032.052cbc7c@gandalf.local.home>
In-Reply-To: <168299388376.3242086.1033501163178915960.stgit@mhiramat.roam.corp.google.com>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
	<168299388376.3242086.1033501163178915960.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 May 2023 11:18:03 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -283,27 +283,53 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  	return 0;
>  }
>  
> +static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
> +				 struct traceprobe_parse_context *ctx)
> +{
> +	struct ftrace_event_field *field;
> +	struct list_head *head;
> +
> +	head = trace_get_fields(ctx->event);
> +	list_for_each_entry(field, head, link) {
> +		if (!strcmp(arg, field->name)) {
> +			code->op = FETCH_OP_TP_ARG;
> +			code->data = field;
> +			return 0;
> +		}
> +	}
> +	return -ENOENT;
> +}
> +
>  #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
>  
>  static int parse_probe_vars(char *arg, const struct fetch_type *t,
> -			struct fetch_insn *code, unsigned int flags, int offs)
> +			    struct fetch_insn *code,
> +			    struct traceprobe_parse_context *ctx)
>  {
>  	unsigned long param;
>  	int ret = 0;
>  	int len;
>  
> -	if (flags & TPARG_FL_TEVENT) {
> +	if (ctx->flags & TPARG_FL_TEVENT) {
>  		if (code->data)
>  			return -EFAULT;
> -		code->data = kstrdup(arg, GFP_KERNEL);
> -		if (!code->data)
> -			return -ENOMEM;
> -		code->op = FETCH_OP_TP_ARG;
> -	} else if (strcmp(arg, "retval") == 0) {
> -		if (flags & TPARG_FL_RETURN) {
> +		ret = parse_trace_event_arg(arg, code, ctx);
> +		if (!ret)
> +			return 0;
> +		if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
> +			code->op = FETCH_OP_COMM;
> +			return 0;
> +		}
> +		/* backward compatibility */
> +		ctx->offset = 0;
> +		goto inval_var;
> +	}

So this is a bit inconsistent in this function. We have here an if
statement that returns 0 on success, and jumps to inval_var if it reaches
the end.

The rest of the if statements below, also goes to inval_var, or returns
error, or just falls through the if statement to return ret. It's somewhat
random.

This should be cleaned up (see patch at the end).

> +
> +	if (strcmp(arg, "retval") == 0) {
> +		if (ctx->flags & TPARG_FL_RETURN) {
>  			code->op = FETCH_OP_RETVAL;
>  		} else {
> -			trace_probe_log_err(offs, RETVAL_ON_PROBE);
> +			trace_probe_log_err(ctx->offset, RETVAL_ON_PROBE);
>  			ret = -EINVAL;
>  		}
>  	} else if ((len = str_has_prefix(arg, "stack"))) {
> @@ -313,9 +339,9 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
>  			ret = kstrtoul(arg + len, 10, &param);
>  			if (ret) {
>  				goto inval_var;
> -			} else if ((flags & TPARG_FL_KERNEL) &&
> +			} else if ((ctx->flags & TPARG_FL_KERNEL) &&
>  				    param > PARAM_MAX_STACK) {
> -				trace_probe_log_err(offs, BAD_STACK_NUM);
> +				trace_probe_log_err(ctx->offset, BAD_STACK_NUM);
>  				ret = -EINVAL;
>  			} else {
>  				code->op = FETCH_OP_STACK;
> @@ -326,13 +352,13 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
>  	} else if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
>  		code->op = FETCH_OP_COMM;
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> -	} else if (tparg_is_function_entry(flags) &&
> +	} else if (tparg_is_function_entry(ctx->flags) &&
>  		   (len = str_has_prefix(arg, "arg"))) {
>  		ret = kstrtoul(arg + len, 10, &param);
>  		if (ret) {
>  			goto inval_var;
>  		} else if (!param || param > PARAM_MAX_STACK) {
> -			trace_probe_log_err(offs, BAD_ARG_NUM);
> +			trace_probe_log_err(ctx->offset, BAD_ARG_NUM);
>  			return -EINVAL;
>  		}
>  		code->op = FETCH_OP_ARG;
> @@ -341,7 +367,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
>  		 * The tracepoint probe will probe a stub function, and the
>  		 * first parameter of the stub is a dummy and should be ignored.
>  		 */
> -		if (flags & TPARG_FL_TPOINT)
> +		if (ctx->flags & TPARG_FL_TPOINT)
>  			code->param++;
>  #endif
>  	} else
> @@ -350,7 +376,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
>  	return ret;
>  
>  inval_var:
> -	trace_probe_log_err(offs, BAD_VAR);
> +	trace_probe_log_err(ctx->offset, BAD_VAR);
>  	return -EINVAL;
>  }
>  


diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 84a9f0446390..a30aab8cef7f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -307,6 +307,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			    struct traceprobe_parse_context *ctx)
 {
 	unsigned long param;
+	int err = BAD_VAR;
 	int ret = 0;
 	int len;
 
@@ -322,45 +323,61 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 		}
 		/* backward compatibility */
 		ctx->offset = 0;
-		goto inval_var;
+		goto inval;
 	}
 
 	if (strcmp(arg, "retval") == 0) {
 		if (ctx->flags & TPARG_FL_RETURN) {
 			code->op = FETCH_OP_RETVAL;
-		} else {
-			trace_probe_log_err(ctx->offset, RETVAL_ON_PROBE);
-			ret = -EINVAL;
+			return 0;
 		}
-	} else if ((len = str_has_prefix(arg, "stack"))) {
+		err = RETVAL_ON_PROBE;
+		ret = -EINVAL;
+		goto inval;
+	}
+
+	if ((len = str_has_prefix(arg, "stack"))) {
+
 		if (arg[len] == '\0') {
 			code->op = FETCH_OP_STACKP;
-		} else if (isdigit(arg[len])) {
+			return 0;
+		}
+
+		if (isdigit(arg[len])) {
 			ret = kstrtoul(arg + len, 10, &param);
-			if (ret) {
-				goto inval_var;
-			} else if ((ctx->flags & TPARG_FL_KERNEL) &&
-				    param > PARAM_MAX_STACK) {
-				trace_probe_log_err(ctx->offset, BAD_STACK_NUM);
+			if (ret)
+				goto inval;
+
+			if ((ctx->flags & TPARG_FL_KERNEL) &&
+			    param > PARAM_MAX_STACK) {
+				err = BAD_STACK_NUM;
 				ret = -EINVAL;
-			} else {
-				code->op = FETCH_OP_STACK;
-				code->param = (unsigned int)param;
+				goto inval;
 			}
-		} else
-			goto inval_var;
-	} else if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
+			code->op = FETCH_OP_STACK;
+			code->param = (unsigned int)param;
+			return 0;
+		}
+		goto inval;
+	}
+
+	if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
 		code->op = FETCH_OP_COMM;
+		return 0;
+	}
+
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	} else if (tparg_is_function_entry(ctx->flags) &&
-		   (len = str_has_prefix(arg, "arg"))) {
+	if (tparg_is_function_entry(ctx->flags) &&
+	    (len = str_has_prefix(arg, "arg"))) {
 		ret = kstrtoul(arg + len, 10, &param);
-		if (ret) {
-			goto inval_var;
-		} else if (!param || param > PARAM_MAX_STACK) {
-			trace_probe_log_err(ctx->offset, BAD_ARG_NUM);
-			return -EINVAL;
+		if (ret)
+			goto inval;
+
+		if (!param || param > PARAM_MAX_STACK) {
+			err = BAD_ARG_NUM;
+			goto inval;
 		}
+
 		code->op = FETCH_OP_ARG;
 		code->param = (unsigned int)param - 1;
 		/*
@@ -369,14 +386,11 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 		 */
 		if (ctx->flags & TPARG_FL_TPOINT)
 			code->param++;
+		return 0;
 #endif
-	} else
-		goto inval_var;
-
-	return ret;
 
-inval_var:
-	trace_probe_log_err(ctx->offset, BAD_VAR);
+inval:
+	trace_probe_log_err(ctx->offset, err);
 	return -EINVAL;
 }
 

