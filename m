Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB86F3296
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjEAPKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjEAPKf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 11:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC210E9;
        Mon,  1 May 2023 08:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D61AD61090;
        Mon,  1 May 2023 15:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1C7C433EF;
        Mon,  1 May 2023 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682953791;
        bh=8mniL9+4FrB6k7OubdeD6PkVGGfKPDXaTg619EQY+6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3W99S+Kebonz2Fr8RCco6sseFLpNxS9uPzExEdlbcbg4nz/ApgOoU4JIS9AIVVyQ
         +6d1GbNxD78qu4UlQiCUo6BSopMqynW0Zxesmp40+9z6+NCJ9fmRqHCmv6TE7G5pnz
         2WlN27ilmamAE3tvr9Zc9sUsMge/CQVbgUvNXFHsx42W9lc8LxI7wUekC0YkptFMnm
         Pz/BfahFtCA6LVkfJvdSWnezlKuoGD5aMzrSX0uvVAhTQfEbh6eCToR8A3LWnWFsFc
         PRkKQ5pWPoxqfo/PkQTprkZgA/FuY4/LYroRAx4P0LXdQgUMo3oiMOtH7r6AspJFdz
         TIx6qpKjo1ZIA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v9 07/11] tracing/probes: Add $$args meta argument for all function args
Date:   Tue,  2 May 2023 00:09:47 +0900
Message-ID:  <168295378775.3157983.11834761936789897301.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To:  <168295372484.3157983.731333785390494141.stgit@mhiramat.roam.corp.google.com>
References:  <168295372484.3157983.731333785390494141.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add the '$$args' meta fetch argument for function-entry probe events. This
will be expanded to the all arguments of the function and the tracepoint
using BTF function argument information.

e.g.
 #  echo 'p vfs_read $$args' >> dynamic_events
 #  echo 'f vfs_write $$args' >> dynamic_events
 #  echo 't sched_overutilized_tp $$args' >> dynamic_events
 # cat dynamic_events
p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - update patch description.
---
 kernel/trace/trace_fprobe.c |   21 ++++++++--
 kernel/trace/trace_kprobe.c |   23 +++++++++--
 kernel/trace/trace_probe.c  |   93 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |    9 ++++
 4 files changed, 138 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index a34081113fa8..aa3e4ac9c259 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -924,14 +924,16 @@ static int __trace_fprobe_create(int argc, const char *argv[])
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
@@ -1037,9 +1039,22 @@ static int __trace_fprobe_create(int argc, const char *argv[])
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
@@ -1051,7 +1066,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		tf->mod = __module_text_address(
 				(unsigned long)tf->tpoint->probestub);
 
-	argc -= 2; argv += 2;
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
 		trace_probe_log_set_index(i + 2);
@@ -1080,6 +1094,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
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
index 346673e9dfd4..4c3c70862a9a 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -451,12 +451,18 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
 
 	return find_fetch_type(typestr, ctx->flags);
 }
+
 #else
 static struct btf *traceprobe_get_btf(void)
 {
 	return NULL;
 }
 
+static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 			 struct traceprobe_parse_context *ctx)
 {
@@ -1080,6 +1086,93 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
 	kfree(arg->fmt);
 }
 
+/* Return new_argv which must be freed after use */
+const char **traceprobe_expand_meta_args(int argc, const char *argv[],
+					 int *new_argc, char *buf, int bufsize,
+					 struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+	const struct btf_param *params = NULL;
+	int i, j, used, ret, args_idx = -1;
+	const char **new_argv = NULL;
+	int nr_skipped;
+
+	/* The first argument of tracepoint should be skipped. */
+	nr_skipped = ctx->flags & TPARG_FL_TPOINT ? 1 : 0;
+	for (i = 0; i < argc; i++)
+		if (!strcmp(argv[i], "$$args")) {
+			trace_probe_log_set_index(i + 2);
+
+			if (!tparg_is_function_entry(ctx->flags)) {
+				trace_probe_log_err(0, NOFENTRY_ARGS);
+				return ERR_PTR(-EINVAL);
+			}
+
+			if (args_idx >= 0) {
+				trace_probe_log_err(0, DOUBLE_ARGS);
+				return ERR_PTR(-EINVAL);
+			}
+
+			args_idx = i;
+			params = find_btf_func_param(ctx->funcname, &ctx->nr_params);
+			if (IS_ERR(params)) {
+				trace_probe_log_err(0, NOSUP_BTFARG);
+				return (const char **)params;
+			}
+			ctx->params = params;
+		}
+
+	/* If target has no arguments, return NULL and the original argc. */
+	if (args_idx < 0 || ctx->nr_params < nr_skipped) {
+		*new_argc = argc;
+		return NULL;
+	}
+
+	*new_argc = argc - 1 + ctx->nr_params - nr_skipped;
+
+	new_argv = kcalloc(*new_argc, sizeof(char *), GFP_KERNEL);
+	if (!new_argv)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < args_idx; i++)
+		new_argv[i] = argv[i];
+
+	used = 0;
+	trace_probe_log_set_index(args_idx + 2);
+	for (i = 0; i < ctx->nr_params - nr_skipped; i++) {
+		const char *name;
+
+		name = btf_name_by_offset(btf, params[i + nr_skipped].name_off);
+		if (!name) {
+			trace_probe_log_err(0, NO_BTF_ENTRY);
+			ret = -ENOENT;
+			goto error;
+		}
+		ret = snprintf(buf + used, bufsize - used, "%s", name);
+		if (ret >= bufsize - used) {
+			trace_probe_log_err(0, ARGS_2LONG);
+			ret = -E2BIG;
+			goto error;
+		}
+		new_argv[args_idx + i] = buf + used;
+		used += ret + 1; /* include null byte */
+	}
+
+	/* Note: we have to skip $$args */
+	j = args_idx + ctx->nr_params - nr_skipped;
+	for (i = args_idx + 1; i < argc; i++, j++) {
+		if (WARN_ON(j >= *new_argc))
+			goto error;
+		new_argv[j] = argv[i];
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
index 9ea5c7e8753f..8c5b029c5d62 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -33,6 +33,7 @@
 #define MAX_ARGSTR_LEN		63
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
+#define MAX_BTF_ARGS_LEN	128
 #define MAX_STRING_SIZE		PATH_MAX
 
 /* Reserved field names */
@@ -387,6 +388,9 @@ struct traceprobe_parse_context {
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				      const char *argv,
 				      struct traceprobe_parse_context *ctx);
+const char **traceprobe_expand_meta_args(int argc, const char *argv[],
+					 int *new_argc, char *buf, int bufsize,
+					 struct traceprobe_parse_context *ctx);
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
@@ -481,7 +485,10 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
 	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
 	C(NO_BTFARG,		"This variable is not found at this probe point"),\
-	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),
+	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),	\
+	C(NOFENTRY_ARGS,	"$$args can be used only on function entry"),	\
+	C(DOUBLE_ARGS,		"$$args can be used only once in the parameter"),	\
+	C(ARGS_2LONG,		"$$args failed because the argument is too long"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

