Return-Path: <bpf+bounces-760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DA7065EE
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 13:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FBF280CF2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E39171BD;
	Wed, 17 May 2023 10:59:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88438DDBA
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE18C433D2;
	Wed, 17 May 2023 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684321195;
	bh=8GEfIDxt0UrKcOLaZ46cHm9IOde+uxf8X/bIbn4/BQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ6Ss0DKidKm05CXvuP8NCOsx0UlWnKqruDXVL680D4crr0k9WiJF7c+imPS8Nux9
	 ZFbZLn09IrEWxC5/NrVM2w4CxpErq9/0jLCMGMEQhK6m0Nn2bWxFOAgS42wJ+WIm4/
	 C7hgMUJndNV2x2W/NxEuMovO/fBLk422JpyDrXHgaxByfzxhe/pyhitrWjddtRrFp1
	 MpDwuMAMiqcEMH/XKnLneR5bg6v3u+lYrwqFBaNdLo2PFKvRcsHRdeWWEMpR6q0NW9
	 95ACaWuRT+2mxtqnvF5xAXPSWnH+2kUKY71X0asUugKg3zuFgp+7AqKVHtnezFvRoW
	 2AxxOol47kvnQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH v11 07/11] tracing/probes: Add $arg* meta argument for all function args
Date: Wed, 17 May 2023 19:59:51 +0900
Message-ID:  <168432119162.1351929.7036126707115026799.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To:  <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
References:  <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
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

Add the '$arg*' meta fetch argument for function-entry probe events. This
will be expanded to the all arguments of the function and the tracepoint
using BTF function argument information.

e.g.
 #  echo 'p vfs_read $arg*' >> dynamic_events
 #  echo 'f vfs_write $arg*' >> dynamic_events
 #  echo 't sched_overutilized_tp $arg*' >> dynamic_events
 # cat dynamic_events
p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized

Also, single '$arg[0-9]*' will be converted to the BTF function argument.

NOTE: This seems like a wildcard, but a fake one at this moment. This
is just for telling user that this can be expanded to several arguments.
And it is not like other $-vars, you can not use this $arg* as a part of
fetch args, e.g. specifying name "foo=$arg*" and using it in dereferences
"+0($arg*)" will lead a parse error.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v11:
 - Change $args to $arg*.
 - Convert single '$arg[0-9]*' to BTF function argument.
 - Cleanup code.
Changes in v10:
 - Change $$args to $args so that user can use $$ for current task's pid.
Changes in v6:
 - update patch description.
---
 kernel/trace/trace_fprobe.c |   21 +++++
 kernel/trace/trace_kprobe.c |   23 +++++-
 kernel/trace/trace_probe.c  |  166 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h  |   11 +++
 4 files changed, 209 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 75130a5bdddc..6573e93e7631 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -925,14 +925,16 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_fprobe *tf = NULL;
-	int i, len, ret = 0;
+	int i, len, new_argc = 0, ret = 0;
 	bool is_return = false;
 	char *symbol = NULL, *tmp = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
+	const char **new_argv = NULL;
 	int maxactive = 0;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char sbuf[KSYM_NAME_LEN];
+	char abuf[MAX_BTF_ARGS_LEN];
 	bool is_tracepoint = false;
 	struct tracepoint *tpoint = NULL;
 	struct traceprobe_parse_context ctx = {
@@ -1038,9 +1040,22 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	} else
 		ctx.funcname = symbol;
 
+	argc -= 2; argv += 2;
+	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
+					       abuf, MAX_BTF_ARGS_LEN, &ctx);
+	if (IS_ERR(new_argv)) {
+		ret = PTR_ERR(new_argv);
+		new_argv = NULL;
+		goto out;
+	}
+	if (new_argv) {
+		argc = new_argc;
+		argv = new_argv;
+	}
+
 	/* setup a probe */
 	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
-				argc - 2, is_return);
+				argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
@@ -1052,7 +1067,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		tf->mod = __module_text_address(
 				(unsigned long)tf->tpoint->probestub);
 
-	argc -= 2; argv += 2;
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
 		trace_probe_log_set_index(i + 2);
@@ -1081,6 +1095,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 out:
 	trace_probe_log_clear();
+	kfree(new_argv);
 	kfree(symbol);
 	return ret;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aff6c1a5e161..2d7c0188c2b1 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -732,9 +732,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_kprobe *tk = NULL;
-	int i, len, ret = 0;
+	int i, len, new_argc = 0, ret = 0;
 	bool is_return = false;
 	char *symbol = NULL, *tmp = NULL;
+	const char **new_argv = NULL;
 	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
 	enum probe_print_type ptype;
 	int maxactive = 0;
@@ -742,6 +743,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
+	char abuf[MAX_BTF_ARGS_LEN];
 	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
@@ -854,19 +856,31 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		event = buf;
 	}
 
+	argc -= 2; argv += 2;
+	ctx.funcname = symbol;
+	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
+					       abuf, MAX_BTF_ARGS_LEN, &ctx);
+	if (IS_ERR(new_argv)) {
+		ret = PTR_ERR(new_argv);
+		new_argv = NULL;
+		goto out;
+	}
+	if (new_argv) {
+		argc = new_argc;
+		argv = new_argv;
+	}
+
 	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
-				argc - 2, is_return);
+				argc, is_return);
 	if (IS_ERR(tk)) {
 		ret = PTR_ERR(tk);
 		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
 		goto out;	/* We know tk is not allocated */
 	}
-	argc -= 2; argv += 2;
 
 	/* parse arguments */
-	ctx.funcname = symbol;
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
 		trace_probe_log_set_index(i + 2);
 		ctx.offset = 0;
@@ -894,6 +908,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 
 out:
 	trace_probe_log_clear();
+	kfree(new_argv);
 	kfree(symbol);
 	return ret;
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 525341c42851..1807eebefabe 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -371,9 +371,11 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
 	return NULL;
 }
 
-static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr)
+static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
+						   bool tracepoint)
 {
 	struct btf *btf = traceprobe_get_btf();
+	const struct btf_param *param;
 	const struct btf_type *t;
 	s32 id;
 
@@ -395,9 +397,16 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 		return ERR_PTR(-ENOENT);
 
 	*nr = btf_type_vlen(t);
+	param = (const struct btf_param *)(t + 1);
 
-	if (*nr)
-		return (const struct btf_param *)(t + 1);
+	/* Hide the first 'data' argument of tracepoint */
+	if (tracepoint) {
+		(*nr)--;
+		param++;
+	}
+
+	if (*nr > 0)
+		return param;
 	else
 		return NULL;
 }
@@ -418,7 +427,8 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 		return -EINVAL;
 
 	if (!ctx->params) {
-		params = find_btf_func_param(ctx->funcname, &ctx->nr_params);
+		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
+					     ctx->flags & TPARG_FL_TPOINT);
 		if (IS_ERR(params)) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
 			return PTR_ERR(params);
@@ -451,12 +461,19 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
 
 	return find_fetch_type(typestr, ctx->flags);
 }
+
 #else
 static struct btf *traceprobe_get_btf(void)
 {
 	return NULL;
 }
 
+static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
+						   bool tracepoint)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 			 struct traceprobe_parse_context *ctx)
 {
@@ -535,6 +552,11 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	len = str_has_prefix(arg, "arg");
 	if (len && tparg_is_function_entry(ctx->flags)) {
+		if (strcmp(arg, "args") == 0) {
+			err = TP_ERR_BAD_VAR_ARGS;
+			goto inval;
+		}
+
 		ret = kstrtoul(arg + len, 10, &param);
 		if (ret)
 			goto inval;
@@ -1094,6 +1116,142 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
 	kfree(arg->fmt);
 }
 
+static int argv_has_var_arg(int argc, const char *argv[], int *args_idx,
+			    struct traceprobe_parse_context *ctx)
+{
+	int i, found = 0;
+
+	for (i = 0; i < argc; i++)
+		if (str_has_prefix(argv[i], "$arg")) {
+			trace_probe_log_set_index(i + 2);
+
+			if (!tparg_is_function_entry(ctx->flags)) {
+				trace_probe_log_err(0, NOFENTRY_ARGS);
+				return -EINVAL;
+			}
+
+			if (isdigit(argv[i][4])) {
+				found = 1;
+				continue;
+			}
+
+			if (argv[i][4] != '*') {
+				trace_probe_log_err(0, BAD_VAR);
+				return -EINVAL;
+			}
+
+			if (*args_idx >= 0 && *args_idx < argc) {
+				trace_probe_log_err(0, DOUBLE_ARGS);
+				return -EINVAL;
+			}
+			found = 1;
+			*args_idx = i;
+		}
+
+	return found;
+}
+
+static int sprint_nth_btf_arg(int idx, const char *type,
+			      char *buf, int bufsize,
+			      struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+	const char *name;
+	int ret;
+
+	if (idx >= ctx->nr_params) {
+		trace_probe_log_err(0, NO_BTFARG);
+		return -ENOENT;
+	}
+	name = btf_name_by_offset(btf, ctx->params[idx].name_off);
+	if (!name) {
+		trace_probe_log_err(0, NO_BTF_ENTRY);
+		return -ENOENT;
+	}
+	ret = snprintf(buf, bufsize, "%s%s", name, type);
+	if (ret >= bufsize) {
+		trace_probe_log_err(0, ARGS_2LONG);
+		return -E2BIG;
+	}
+	return ret;
+}
+
+/* Return new_argv which must be freed after use */
+const char **traceprobe_expand_meta_args(int argc, const char *argv[],
+					 int *new_argc, char *buf, int bufsize,
+					 struct traceprobe_parse_context *ctx)
+{
+	const struct btf_param *params = NULL;
+	int i, j, n, used, ret, args_idx = -1;
+	const char **new_argv = NULL;
+	int nr_params;
+
+	ret = argv_has_var_arg(argc, argv, &args_idx, ctx);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (!ret) {
+		*new_argc = argc;
+		return NULL;
+	}
+
+	params = find_btf_func_param(ctx->funcname, &nr_params,
+				     ctx->flags & TPARG_FL_TPOINT);
+	if (IS_ERR(params)) {
+		trace_probe_log_err(0, NOSUP_BTFARG);
+		return (const char **)params;
+	}
+	ctx->params = params;
+	ctx->nr_params = nr_params;
+
+	*new_argc = argc - 1 + ctx->nr_params;
+
+	new_argv = kcalloc(*new_argc, sizeof(char *), GFP_KERNEL);
+	if (!new_argv)
+		return ERR_PTR(-ENOMEM);
+
+	used = 0;
+	for (i = 0, j = 0; i < argc; i++) {
+		trace_probe_log_set_index(i + 2);
+		if (i == args_idx) {
+			for (n = 0; n < nr_params; n++) {
+				ret = sprint_nth_btf_arg(n, "", buf + used,
+							 bufsize - used, ctx);
+				if (ret < 0)
+					goto error;
+
+				new_argv[j++] = buf + used;
+				used += ret + 1;
+			}
+			continue;
+		}
+
+		if (str_has_prefix(argv[i], "$arg")) {
+			char *type;
+
+			n = simple_strtoul(argv[i] + 4, &type, 10);
+			if (*type != ':') {
+				trace_probe_log_err(0, BAD_VAR);
+				ret = -ENOENT;
+				goto error;
+			}
+			ret = sprint_nth_btf_arg(n, type, buf + used,
+						 bufsize - used, ctx);
+			if (ret < 0)
+				goto error;
+			new_argv[j++] = buf + used;
+			used += ret + 1;
+		} else
+			new_argv[j++] = argv[i];
+	}
+
+	return new_argv;
+
+error:
+	kfree(new_argv);
+	return ERR_PTR(ret);
+}
+
 int traceprobe_update_arg(struct probe_arg *arg)
 {
 	struct fetch_insn *code = arg->code;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9ea5c7e8753f..b5f265819503 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -33,7 +33,9 @@
 #define MAX_ARGSTR_LEN		63
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
+#define MAX_BTF_ARGS_LEN	128
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -387,6 +389,9 @@ struct traceprobe_parse_context {
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				      const char *argv,
 				      struct traceprobe_parse_context *ctx);
+const char **traceprobe_expand_meta_args(int argc, const char *argv[],
+					 int *new_argc, char *buf, int bufsize,
+					 struct traceprobe_parse_context *ctx);
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
@@ -481,7 +486,11 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
 	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
 	C(NO_BTFARG,		"This variable is not found at this probe point"),\
-	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),
+	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),	\
+	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),\
+	C(NOFENTRY_ARGS,	"$arg* can be used only on function entry"),	\
+	C(DOUBLE_ARGS,		"$arg* can be used only once in the parameters"),	\
+	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


