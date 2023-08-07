Return-Path: <bpf+bounces-7112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0BE771881
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6048D281115
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3681A;
	Mon,  7 Aug 2023 02:54:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66024642
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 02:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0335C433C7;
	Mon,  7 Aug 2023 02:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691376882;
	bh=KReumcvfAA7aUU41c/MWj+LowvbdvMSmvuGEweZl3FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tg71Pz8PGS+dfk2z61YpIk/EhCz2WG/LCITrji+JxAiJekXPFq+pqvMH/3B+aKPNy
	 vrx5wxFk1zpGIoDoEwyjZ3MOH/HOYy6QKFlrePCfrZj85J/lfG22Y95SDMCBNNDEh3
	 ZzMoAPJvrsozCqlceg2nup56x9MOFAB20tKAApTkr1kZU998DS7vh+7+fpcEyjq9m5
	 8iZbSUEetrebIVB9muNVuXja4mEk93MCdvU9t/CCNYDY4ZgDOd0Gy/eEKi75XnXMSB
	 BWU+yjT6LyYyRVIKqiG1oP+nBZCr1kxy5TOzyjmC9N7tUa5eojkFUi5pz9MqHEpiKl
	 F7b/KRCv7mvHQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v5 1/9] tracing/probes: Support BTF argument on module functions
Date: Mon,  7 Aug 2023 11:54:38 +0900
Message-Id: <169137687832.271367.4309899034400416156.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169137686814.271367.11218568219311636206.stgit@devnote2>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
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

Since the btf returned from bpf_get_btf_vmlinux() only covers functions in
the vmlinux, BTF argument is not available on the functions in the modules.
Use bpf_find_btf_id() instead of bpf_get_btf_vmlinux()+btf_find_name_kind()
so that BTF argument can find the correct struct btf and btf_type in it.
With this fix, fprobe events can use `$arg*` on module functions as below

 # grep nf_log_ip_packet /proc/kallsyms
ffffffffa0005c00 t nf_log_ip_packet	[nf_log_syslog]
ffffffffa0005bf0 t __pfx_nf_log_ip_packet	[nf_log_syslog]
 # echo 'f nf_log_ip_packet $arg*' > dynamic_events
 # cat dynamic_events
f:fprobes/nf_log_ip_packet__entry nf_log_ip_packet net=net pf=pf hooknum=hooknum skb=skb in=in out=out loginfo=loginfo prefix=prefix

To support the module's btf which is removable, the struct btf needs to be
ref-counted. So this also records the btf in the traceprobe_parse_context
and returns the refcount when the parse has done.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Newly added.
---
 include/linux/btf.h         |    1 
 kernel/bpf/btf.c            |    2 -
 kernel/trace/trace_eprobe.c |    4 --
 kernel/trace/trace_fprobe.c |    1 
 kernel/trace/trace_kprobe.c |    1 
 kernel/trace/trace_probe.c  |  100 +++++++++++++++++++++++++------------------
 kernel/trace/trace_probe.h  |   14 +++++-
 kernel/trace/trace_uprobe.c |    1 
 8 files changed, 75 insertions(+), 49 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index cac9f304e27a..dbfe41a09c4b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -211,6 +211,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
+s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 					       u32 id, u32 *res_id);
 const struct btf_type *btf_type_resolve_ptr(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 817204d53372..b9b0eb1189bb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -552,7 +552,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 	return -ENOENT;
 }
 
-static s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
+s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 {
 	struct btf *btf;
 	s32 ret;
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a0a704ba27db..09bac836d72b 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -807,13 +807,11 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 	int ret;
 
 	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], &ctx);
-	if (ret)
-		return ret;
-
 	/* Handle symbols "@" */
 	if (!ret)
 		ret = traceprobe_update_arg(&ep->tp.args[i]);
 
+	traceprobe_finish_parse(&ctx);
 	return ret;
 }
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index dfe2e546acdc..8f43f1f65b1b 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1096,6 +1096,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	}
 
 out:
+	traceprobe_finish_parse(&ctx);
 	trace_probe_log_clear();
 	kfree(new_argv);
 	kfree(symbol);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23dba01831f7..cc822f69bfe8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -907,6 +907,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	}
 
 out:
+	traceprobe_finish_parse(&ctx);
 	trace_probe_log_clear();
 	kfree(new_argv);
 	kfree(symbol);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c68a72707852..ecbe28f8d676 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -304,16 +304,6 @@ static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
 
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 
-static struct btf *traceprobe_get_btf(void)
-{
-	struct btf *btf = bpf_get_btf_vmlinux();
-
-	if (IS_ERR_OR_NULL(btf))
-		return NULL;
-
-	return btf;
-}
-
 static u32 btf_type_int(const struct btf_type *t)
 {
 	return *(u32 *)(t + 1);
@@ -371,42 +361,49 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
 	return NULL;
 }
 
-static const struct btf_type *find_btf_func_proto(const char *funcname)
+static const struct btf_type *find_btf_func_proto(const char *funcname,
+						  struct btf **btf_p)
 {
-	struct btf *btf = traceprobe_get_btf();
 	const struct btf_type *t;
+	struct btf *btf = NULL;
 	s32 id;
 
-	if (!btf || !funcname)
+	if (!funcname)
 		return ERR_PTR(-EINVAL);
 
-	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
+	id = bpf_find_btf_id(funcname, BTF_KIND_FUNC, &btf);
 	if (id <= 0)
 		return ERR_PTR(-ENOENT);
 
 	/* Get BTF_KIND_FUNC type */
 	t = btf_type_by_id(btf, id);
 	if (!t || !btf_type_is_func(t))
-		return ERR_PTR(-ENOENT);
+		goto err;
 
 	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
 	t = btf_type_by_id(btf, t->type);
 	if (!t || !btf_type_is_func_proto(t))
-		return ERR_PTR(-ENOENT);
+		goto err;
 
+	*btf_p = btf;
 	return t;
+
+err:
+	btf_put(btf);
+	return ERR_PTR(-ENOENT);
 }
 
 static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
-						   bool tracepoint)
+						   struct btf **btf_p, bool tracepoint)
 {
 	const struct btf_param *param;
 	const struct btf_type *t;
+	struct btf *btf;
 
 	if (!funcname || !nr)
 		return ERR_PTR(-EINVAL);
 
-	t = find_btf_func_proto(funcname);
+	t = find_btf_func_proto(funcname, &btf);
 	if (IS_ERR(t))
 		return (const struct btf_param *)t;
 
@@ -419,29 +416,37 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 		param++;
 	}
 
-	if (*nr > 0)
+	if (*nr > 0) {
+		*btf_p = btf;
 		return param;
-	else
-		return NULL;
+	}
+
+	btf_put(btf);
+	return NULL;
+}
+
+static void clear_btf_context(struct traceprobe_parse_context *ctx)
+{
+	if (ctx->btf) {
+		btf_put(ctx->btf);
+		ctx->btf = NULL;
+		ctx->params = NULL;
+		ctx->nr_params = 0;
+	}
 }
 
 static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 			 struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = traceprobe_get_btf();
 	const struct btf_param *params;
 	int i;
 
-	if (!btf) {
-		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
-		return -EOPNOTSUPP;
-	}
-
 	if (WARN_ON_ONCE(!ctx->funcname))
 		return -EINVAL;
 
 	if (!ctx->params) {
-		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
+		params = find_btf_func_param(ctx->funcname,
+					     &ctx->nr_params, &ctx->btf,
 					     ctx->flags & TPARG_FL_TPOINT);
 		if (IS_ERR_OR_NULL(params)) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
@@ -452,7 +457,7 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 		params = ctx->params;
 
 	for (i = 0; i < ctx->nr_params; i++) {
-		const char *name = btf_name_by_offset(btf, params[i].name_off);
+		const char *name = btf_name_by_offset(ctx->btf, params[i].name_off);
 
 		if (name && !strcmp(name, varname)) {
 			code->op = FETCH_OP_ARG;
@@ -470,7 +475,7 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 static const struct fetch_type *parse_btf_arg_type(int arg_idx,
 					struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = traceprobe_get_btf();
+	struct btf *btf = ctx->btf;
 	const char *typestr = NULL;
 
 	if (btf && ctx->params) {
@@ -485,14 +490,17 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
 static const struct fetch_type *parse_btf_retval_type(
 					struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = traceprobe_get_btf();
 	const char *typestr = NULL;
 	const struct btf_type *t;
+	struct btf *btf;
 
-	if (btf && ctx->funcname) {
-		t = find_btf_func_proto(ctx->funcname);
-		if (!IS_ERR(t))
+	if (ctx->funcname) {
+		/* Do not use ctx->btf, because it must be used with ctx->param */
+		t = find_btf_func_proto(ctx->funcname, &btf);
+		if (!IS_ERR(t)) {
 			typestr = type_from_btf_id(btf, t->type);
+			btf_put(btf);
+		}
 	}
 
 	return find_fetch_type(typestr, ctx->flags);
@@ -501,21 +509,25 @@ static const struct fetch_type *parse_btf_retval_type(
 static bool is_btf_retval_void(const char *funcname)
 {
 	const struct btf_type *t;
+	struct btf *btf;
+	bool ret;
 
-	t = find_btf_func_proto(funcname);
+	t = find_btf_func_proto(funcname, &btf);
 	if (IS_ERR(t))
 		return false;
 
-	return t->type == 0;
+	ret = (t->type == 0);
+	btf_put(btf);
+	return ret;
 }
 #else
-static struct btf *traceprobe_get_btf(void)
+static void clear_btf_context(struct traceprobe_parse_context *ctx)
 {
-	return NULL;
+	ctx->btf = NULL;
 }
 
 static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
-						   bool tracepoint)
+						   struct btf **btf_p, bool tracepoint)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -1231,7 +1243,6 @@ static int sprint_nth_btf_arg(int idx, const char *type,
 			      char *buf, int bufsize,
 			      struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = traceprobe_get_btf();
 	const char *name;
 	int ret;
 
@@ -1239,7 +1250,7 @@ static int sprint_nth_btf_arg(int idx, const char *type,
 		trace_probe_log_err(0, NO_BTFARG);
 		return -ENOENT;
 	}
-	name = btf_name_by_offset(btf, ctx->params[idx].name_off);
+	name = btf_name_by_offset(ctx->btf, ctx->params[idx].name_off);
 	if (!name) {
 		trace_probe_log_err(0, NO_BTF_ENTRY);
 		return -ENOENT;
@@ -1271,7 +1282,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 		return NULL;
 	}
 
-	params = find_btf_func_param(ctx->funcname, &nr_params,
+	params = find_btf_func_param(ctx->funcname, &nr_params, &ctx->btf,
 				     ctx->flags & TPARG_FL_TPOINT);
 	if (IS_ERR_OR_NULL(params)) {
 		if (args_idx != -1) {
@@ -1337,6 +1348,11 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	return ERR_PTR(ret);
 }
 
+void traceprobe_finish_parse(struct traceprobe_parse_context *ctx)
+{
+	clear_btf_context(ctx);
+}
+
 int traceprobe_update_arg(struct probe_arg *arg)
 {
 	struct fetch_insn *code = arg->code;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 01ea148723de..4dc91460a75d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -383,9 +383,11 @@ static inline bool tparg_is_function_entry(unsigned int flags)
 
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
-	const struct btf_param *params;
-	s32 nr_params;
-	const char *funcname;
+	/* BTF related parameters */
+	const char *funcname;		/* Function name in BTF */
+	const struct btf_param *params;	/* Parameter of the function */
+	s32 nr_params;			/* The number of the parameters */
+	struct btf *btf;		/* The BTF to be used */
 	unsigned int flags;
 	int offset;
 };
@@ -400,6 +402,12 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
+/*
+ * If either traceprobe_parse_probe_arg() or traceprobe_expand_meta_args() is called,
+ * this MUST be called for clean up the context and return a resource.
+ */
+void traceprobe_finish_parse(struct traceprobe_parse_context *ctx);
+
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 				char *buf, int offset);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 688bf579f2f1..9790f8f0a32d 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -693,6 +693,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 		trace_probe_log_set_index(i + 2);
 		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], &ctx);
+		traceprobe_finish_parse(&ctx);
 		if (ret)
 			goto error;
 	}


