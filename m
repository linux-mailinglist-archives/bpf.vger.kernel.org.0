Return-Path: <bpf+bounces-6413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4842B768EC7
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F226A28161D
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C763A0;
	Mon, 31 Jul 2023 07:30:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF44612C
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0A1C433C7;
	Mon, 31 Jul 2023 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690788658;
	bh=MEwRLs52A6mbWMV633WSoZvf7gtbSq9T0CrWmcVCrQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYSSDeeab7dS/kZ4Db9OMxQn35b8l2tqXf8H6VCsP/YZtH2eseldsfv0ZUTDu1Voj
	 LWbuWGxSEpb1ypo6UVXSiAnlhHqpR1/0nhdoE2SRbTD38VVpND+Hukg20gj1sO0JZ4
	 x1s9+SthzuX/Igv3doVhONPZcjRmw+c9y6IMkCzE75cZ3BzuBhNzR4rbwCBrxwsahy
	 xKA6kZMpklAmD4Sz9yv/8S7+5BA9vsN7D3mKltjIvydOqUt64TGHHVsK12uUzq9PGm
	 5RH39ywrFExEHqL+XKfpjNDfsR3ipibOgX+hQzsevZLKHZXPOfTmJZ3xgJYonuqsmP
	 nDaRcmpNDABaw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 5/9] tracing/probes: Support BTF field access from $retval
Date: Mon, 31 Jul 2023 16:30:54 +0900
Message-Id: <169078865417.173706.16364911655090306732.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169078860386.173706.3091034523220945605.stgit@devnote2>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Support BTF argument on '$retval' for function return events including
kretprobe and fprobe for accessing the return value.
This also allows user to access its fields if the return value is a
pointer of a data structure.

E.g.
 # echo 'f getname_flags%return +0($retval->name):string' \
   > dynamic_events
 # echo 1 > events/fprobes/getname_flags__exit/enable
 # ls > /dev/null
 # head -n 40 trace | tail
              ls-87      [000] ...1.  8067.616101: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./function_profile_enabled"
              ls-87      [000] ...1.  8067.616108: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./trace_stat"
              ls-87      [000] ...1.  8067.616115: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_notrace"
              ls-87      [000] ...1.  8067.616122: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_function"
              ls-87      [000] ...1.  8067.616129: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace"
              ls-87      [000] ...1.  8067.616135: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_filter"
              ls-87      [000] ...1.  8067.616143: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./touched_functions"
              ls-87      [000] ...1.  8067.616237: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./enabled_functions"
              ls-87      [000] ...1.  8067.616245: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./available_filter_functions"
              ls-87      [000] ...1.  8067.616253: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace_pid"


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Use '$retval' instead of 'retval' because it is confusing.
 Changes in v3:
  - Introduce query_btf_context() to cache the btf related data (function
    prototype) for using common field analyzing code with function
    parameters.
 Changes in v3.1:
  - Return int error code from query_btf_context() if !CONFIG_PROBE_EVENTS_BTF_ARGS
 Changes in v4:
  - Fix wrong BTF access if query_btf_context() is failed in parse_btf_arg().
  - Return error if $retval accesses a field but BTF is not found.
---
 kernel/trace/trace_probe.c |  187 ++++++++++++++++++++------------------------
 kernel/trace/trace_probe.h |    1 
 2 files changed, 86 insertions(+), 102 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index f6b855de4256..8ce7d8f04849 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -363,38 +363,46 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 	return NULL;
 }
 
-static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
-						   struct btf **btf_p, bool tracepoint)
+static int query_btf_context(struct traceprobe_parse_context *ctx)
 {
 	const struct btf_param *param;
-	const struct btf_type *t;
+	const struct btf_type *type;
 	struct btf *btf;
+	s32 nr;
 
-	if (!funcname || !nr)
-		return ERR_PTR(-EINVAL);
+	if (ctx->btf)
+		return 0;
 
-	t = btf_find_func_proto(funcname, &btf);
-	if (!t)
-		return (const struct btf_param *)t;
+	if (!ctx->funcname)
+		return -EINVAL;
 
-	param = btf_get_func_param(t, nr);
-	if (IS_ERR_OR_NULL(param))
-		goto err;
+	type = btf_find_func_proto(ctx->funcname, &btf);
+	if (!type)
+		return -ENOENT;
 
-	/* Hide the first 'data' argument of tracepoint */
-	if (tracepoint) {
-		(*nr)--;
-		param++;
+	ctx->btf = btf;
+	ctx->proto = type;
+
+	/* ctx->params is optional, since func(void) will not have params. */
+	nr = 0;
+	param = btf_get_func_param(type, &nr);
+	if (!IS_ERR_OR_NULL(param)) {
+		/* Hide the first 'data' argument of tracepoint */
+		if (ctx->flags & TPARG_FL_TPOINT) {
+			nr--;
+			param++;
+		}
 	}
 
-	if (*nr > 0) {
-		*btf_p = btf;
-		return param;
+	if (nr > 0) {
+		ctx->nr_params = nr;
+		ctx->params = param;
+	} else {
+		ctx->nr_params = 0;
+		ctx->params = NULL;
 	}
 
-err:
-	btf_put(btf);
-	return NULL;
+	return 0;
 }
 
 static void clear_btf_context(struct traceprobe_parse_context *ctx)
@@ -402,6 +410,7 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
 	if (ctx->btf) {
 		btf_put(ctx->btf);
 		ctx->btf = NULL;
+		ctx->proto = NULL;
 		ctx->params = NULL;
 		ctx->nr_params = 0;
 	}
@@ -517,7 +526,7 @@ static int parse_btf_arg(char *varname,
 	const struct btf_param *params;
 	const struct btf_type *type;
 	char *field = NULL;
-	int i, is_ptr;
+	int i, is_ptr, ret;
 	u32 tid;
 
 	if (WARN_ON_ONCE(!ctx->funcname))
@@ -533,17 +542,37 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
-	if (!ctx->params) {
-		params = find_btf_func_param(ctx->funcname,
-					     &ctx->nr_params, &ctx->btf,
-					     ctx->flags & TPARG_FL_TPOINT);
-		if (IS_ERR_OR_NULL(params)) {
+	if (ctx->flags & TPARG_FL_RETURN) {
+		if (strcmp(varname, "$retval") != 0) {
+			trace_probe_log_err(ctx->offset, NO_BTFARG);
+			return -ENOENT;
+		}
+		code->op = FETCH_OP_RETVAL;
+		/* Check whether the function return type is not void */
+		if (query_btf_context(ctx) == 0) {
+			if (ctx->proto->type == 0) {
+				trace_probe_log_err(ctx->offset, NO_RETVAL);
+				return -ENOENT;
+			}
+			tid = ctx->proto->type;
+			goto found;
+		}
+		if (field) {
+			trace_probe_log_err(ctx->offset + field - varname,
+					    NO_BTF_ENTRY);
+			return -ENOENT;
+		}
+		return 0;
+	}
+
+	if (!ctx->btf) {
+		ret = query_btf_context(ctx);
+		if (ret < 0 || ctx->nr_params == 0) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
 			return PTR_ERR(params);
 		}
-		ctx->params = params;
-	} else
-		params = ctx->params;
+	}
+	params = ctx->params;
 
 	for (i = 0; i < ctx->nr_params; i++) {
 		const char *name = btf_name_by_offset(ctx->btf, params[i].name_off);
@@ -554,7 +583,6 @@ static int parse_btf_arg(char *varname,
 				code->param = i + 1;
 			else
 				code->param = i;
-
 			tid = params[i].type;
 			goto found;
 		}
@@ -579,7 +607,7 @@ static int parse_btf_arg(char *varname,
 	return 0;
 }
 
-static const struct fetch_type *parse_btf_arg_type(
+static const struct fetch_type *find_fetch_type_from_btf_type(
 					struct traceprobe_parse_context *ctx)
 {
 	struct btf *btf = ctx->btf;
@@ -591,27 +619,6 @@ static const struct fetch_type *parse_btf_arg_type(
 	return find_fetch_type(typestr, ctx->flags);
 }
 
-static const struct fetch_type *parse_btf_retval_type(
-					struct traceprobe_parse_context *ctx)
-{
-	const char *typestr = NULL;
-	const struct btf_type *type;
-	struct btf *btf;
-
-	if (ctx->funcname) {
-		/* Do not use ctx->btf, because it must be used with ctx->param */
-		type = btf_find_func_proto(ctx->funcname, &btf);
-		if (type) {
-			type = btf_type_skip_modifiers(btf, type->type, NULL);
-			if (!IS_ERR_OR_NULL(type))
-				typestr = fetch_type_from_btf_type(btf, type, ctx);
-			btf_put(btf);
-		}
-	}
-
-	return find_fetch_type(typestr, ctx->flags);
-}
-
 static int parse_btf_bitfield(struct fetch_insn **pcode,
 			      struct traceprobe_parse_context *ctx)
 {
@@ -634,30 +641,15 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return 0;
 }
 
-static bool is_btf_retval_void(const char *funcname)
-{
-	const struct btf_type *t;
-	struct btf *btf;
-	bool ret;
-
-	t = btf_find_func_proto(funcname, &btf);
-	if (!t)
-		return false;
-
-	ret = (t->type == 0);
-	btf_put(btf);
-	return ret;
-}
 #else
 static void clear_btf_context(struct traceprobe_parse_context *ctx)
 {
 	ctx->btf = NULL;
 }
 
-static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
-						   struct btf **btf_p, bool tracepoint)
+static int query_btf_context(struct traceprobe_parse_context *ctx)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static int parse_btf_arg(char *varname,
@@ -675,24 +667,23 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return -EOPNOTSUPP;
 }
 
-#define parse_btf_arg_type(ctx)		\
-	find_fetch_type(NULL, ctx->flags)
-
-#define parse_btf_retval_type(ctx)		\
+#define find_fetch_type_from_btf_type(ctx)		\
 	find_fetch_type(NULL, ctx->flags)
 
-#define is_btf_retval_void(funcname)	(false)
-
 #endif
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
-static int parse_probe_vars(char *arg, const struct fetch_type *t,
-			    struct fetch_insn *code,
+/* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
+static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
+			    struct fetch_insn **pcode,
+			    struct fetch_insn *end,
 			    struct traceprobe_parse_context *ctx)
 {
-	unsigned long param;
+	struct fetch_insn *code = *pcode;
 	int err = TP_ERR_BAD_VAR;
+	char *arg = orig_arg + 1;
+	unsigned long param;
 	int ret = 0;
 	int len;
 
@@ -711,18 +702,17 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 		goto inval;
 	}
 
-	if (strcmp(arg, "retval") == 0) {
-		if (ctx->flags & TPARG_FL_RETURN) {
-			if ((ctx->flags & TPARG_FL_KERNEL) &&
-			    is_btf_retval_void(ctx->funcname)) {
-				err = TP_ERR_NO_RETVAL;
-				goto inval;
-			}
+	if (str_has_prefix(arg, "retval")) {
+		if (!(ctx->flags & TPARG_FL_RETURN)) {
+			err = TP_ERR_RETVAL_ON_PROBE;
+			goto inval;
+		}
+		if (!(ctx->flags & TPARG_FL_KERNEL) ||
+		    !IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS)) {
 			code->op = FETCH_OP_RETVAL;
 			return 0;
 		}
-		err = TP_ERR_RETVAL_ON_PROBE;
-		goto inval;
+		return parse_btf_arg(orig_arg, pcode, end, ctx);
 	}
 
 	len = str_has_prefix(arg, "stack");
@@ -824,7 +814,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	switch (arg[0]) {
 	case '$':
-		ret = parse_probe_vars(arg + 1, type, code, ctx);
+		ret = parse_probe_vars(arg, type, pcode, end, ctx);
 		break;
 
 	case '%':	/* named register */
@@ -1121,12 +1111,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		goto fail;
 
 	/* Update storing type if BTF is available */
-	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
-		if (ctx->last_type)
-			parg->type = parse_btf_arg_type(ctx);
-		else if (ctx->flags & TPARG_FL_RETURN)
-			parg->type = parse_btf_retval_type(ctx);
-	}
+	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
+	    !t && ctx->last_type)
+		parg->type = find_fetch_type_from_btf_type(ctx);
 
 	ret = -EINVAL;
 	/* Store operation */
@@ -1415,7 +1402,6 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	const struct btf_param *params = NULL;
 	int i, j, n, used, ret, args_idx = -1;
 	const char **new_argv = NULL;
-	int nr_params;
 
 	ret = argv_has_var_arg(argc, argv, &args_idx, ctx);
 	if (ret < 0)
@@ -1426,9 +1412,8 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 		return NULL;
 	}
 
-	params = find_btf_func_param(ctx->funcname, &nr_params, &ctx->btf,
-				     ctx->flags & TPARG_FL_TPOINT);
-	if (IS_ERR_OR_NULL(params)) {
+	ret = query_btf_context(ctx);
+	if (ret < 0 || ctx->nr_params == 0) {
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);
@@ -1437,8 +1422,6 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 		*new_argc = argc;
 		return NULL;
 	}
-	ctx->params = params;
-	ctx->nr_params = nr_params;
 
 	if (args_idx >= 0)
 		*new_argc = argc + ctx->nr_params - 1;
@@ -1453,7 +1436,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	for (i = 0, j = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
 		if (i == args_idx) {
-			for (n = 0; n < nr_params; n++) {
+			for (n = 0; n < ctx->nr_params; n++) {
 				ret = sprint_nth_btf_arg(n, "", buf + used,
 							 bufsize - used, ctx);
 				if (ret < 0)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 6111f1ffca6c..9184c84833f8 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -385,6 +385,7 @@ struct traceprobe_parse_context {
 	struct trace_event_call *event;
 	/* BTF related parameters */
 	const char *funcname;		/* Function name in BTF */
+	const struct btf_type  *proto;	/* Prototype of the function */
 	const struct btf_param *params;	/* Parameter of the function */
 	s32 nr_params;			/* The number of the parameters */
 	struct btf *btf;		/* The BTF to be used */


