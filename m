Return-Path: <bpf+bounces-856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9302F707996
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 07:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854A61C2102D
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 05:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEE8185E;
	Thu, 18 May 2023 05:26:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA01382
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 05:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54403C4339B;
	Thu, 18 May 2023 05:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684387568;
	bh=EDAfjVhXNNZTfw/0M4y8FYKGdj60FWofsOqnsedq2+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2Pm8s/4IGPi9m1yoZy+gC+p31qMwCnhEKZ2OCd0enD1DDBzJcJtdmq0YsTUPrBK3
	 afiQ+gCRuup3v+ud5wKibyVEGCnfVbk+I/Kn8IZ0RcOTBOOa3Q5FcxwLzk3q9QQGMs
	 KS3xIK31N58sJkhdRly2iHWTYTKxcxhQ/puFkGDLxSUlEcTovk0bj2d2j3w/C75x06
	 N7PdpYbBk4+aPEY5favUzvpv4zS1hUaMLrbd6FGDY11keVACeeiTe/DjbYBN1MYime
	 qUzJojnw+BwszSCS7n3oQ2UbnehiN71OiZ0AiGM3nRoTe590matws4eDaBdLn8QTzr
	 NgLlwFTNZuaXw==
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
	bpf@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v12 08/11] tracing/probes: Add BTF retval type support
Date: Thu, 18 May 2023 14:26:05 +0900
Message-ID:  <168438756494.1517340.8589120584247312702.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To:  <168438749373.1517340.14083401972478496211.stgit@mhiramat.roam.corp.google.com>
References:  <168438749373.1517340.14083401972478496211.stgit@mhiramat.roam.corp.google.com>
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

Check the target function has non-void retval type and set the correct
fetch type if user doesn't specify it.
If the function returns void, $retval is rejected as below;

 # echo 'f unregister_kprobes%return $retval' >> dynamic_events
sh: write error: No such file or directory
 # cat error_log
[   37.488397] trace_fprobe: error: This function returns 'void' type
  Command: f unregister_kprobes%return $retval
                                       ^

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v8:
 - Fix wrong indentation.
Changes in v7:
 - Introduce this as a new patch.
---
 kernel/trace/trace_probe.c |   69 ++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace_probe.h |    1 +
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1807eebefabe..8a6beb76a8de 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -371,15 +371,13 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
 	return NULL;
 }
 
-static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
-						   bool tracepoint)
+static const struct btf_type *find_btf_func_proto(const char *funcname)
 {
 	struct btf *btf = traceprobe_get_btf();
-	const struct btf_param *param;
 	const struct btf_type *t;
 	s32 id;
 
-	if (!btf || !funcname || !nr)
+	if (!btf || !funcname)
 		return ERR_PTR(-EINVAL);
 
 	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
@@ -396,6 +394,22 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 	if (!btf_type_is_func_proto(t))
 		return ERR_PTR(-ENOENT);
 
+	return t;
+}
+
+static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
+						   bool tracepoint)
+{
+	const struct btf_param *param;
+	const struct btf_type *t;
+
+	if (!funcname || !nr)
+		return ERR_PTR(-EINVAL);
+
+	t = find_btf_func_proto(funcname);
+	if (IS_ERR(t))
+		return (const struct btf_param *)t;
+
 	*nr = btf_type_vlen(t);
 	param = (const struct btf_param *)(t + 1);
 
@@ -462,6 +476,32 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
 	return find_fetch_type(typestr, ctx->flags);
 }
 
+static const struct fetch_type *parse_btf_retval_type(
+					struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+	const char *typestr = NULL;
+	const struct btf_type *t;
+
+	if (btf && ctx->funcname) {
+		t = find_btf_func_proto(ctx->funcname);
+		if (!IS_ERR(t))
+			typestr = type_from_btf_id(btf, t->type);
+	}
+
+	return find_fetch_type(typestr, ctx->flags);
+}
+
+static bool is_btf_retval_void(const char *funcname)
+{
+	const struct btf_type *t;
+
+	t = find_btf_func_proto(funcname);
+	if (IS_ERR(t))
+		return false;
+
+	return t->type == 0;
+}
 #else
 static struct btf *traceprobe_get_btf(void)
 {
@@ -480,8 +520,15 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 	return -EOPNOTSUPP;
 }
+
 #define parse_btf_arg_type(idx, ctx)		\
 	find_fetch_type(NULL, ctx->flags)
+
+#define parse_btf_retval_type(ctx)		\
+	find_fetch_type(NULL, ctx->flags)
+
+#define is_btf_retval_void(funcname)	(false)
+
 #endif
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
@@ -512,6 +559,11 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 
 	if (strcmp(arg, "retval") == 0) {
 		if (ctx->flags & TPARG_FL_RETURN) {
+			if ((ctx->flags & TPARG_FL_KERNEL) &&
+			    is_btf_retval_void(ctx->funcname)) {
+				err = TP_ERR_NO_RETVAL;
+				goto inval;
+			}
 			code->op = FETCH_OP_RETVAL;
 			return 0;
 		}
@@ -917,9 +969,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		goto fail;
 
 	/* Update storing type if BTF is available */
-	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
-	    !t && code->op == FETCH_OP_ARG)
-		parg->type = parse_btf_arg_type(code->param, ctx);
+	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
+		if (code->op == FETCH_OP_ARG)
+			parg->type = parse_btf_arg_type(code->param, ctx);
+		else if (code->op == FETCH_OP_RETVAL)
+			parg->type = parse_btf_retval_type(ctx);
+	}
 
 	ret = -EINVAL;
 	/* Store operation */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index b5f265819503..c13690b74d51 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -445,6 +445,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_EVENT_NAME,	"Event name must follow the same rules as C identifiers"), \
 	C(EVENT_EXIST,		"Given group/event name is already used by another event"), \
 	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
+	C(NO_RETVAL,		"This function returns 'void' type"),	\
 	C(BAD_STACK_NUM,	"Invalid stack number"),		\
 	C(BAD_ARG_NUM,		"Invalid argument number"),		\
 	C(BAD_VAR,		"Invalid $-valiable specified"),	\


