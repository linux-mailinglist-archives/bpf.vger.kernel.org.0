Return-Path: <bpf+bounces-2795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F2733FF2
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 11:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592012818A1
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0785E747C;
	Sat, 17 Jun 2023 09:47:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3E747B
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 09:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3CCC433C0;
	Sat, 17 Jun 2023 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686995240;
	bh=xuogGb7rV3OR5mTY5x/kVEP90kY4oCcvhU0IrpGAk1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLzGxA4qB2mn3c+bhmXxbeRenqE+jTL1VIi1LV0Az/YyY9J0dnc7dx5922Dphv1qO
	 9K+EKQ67dHSgzOzs3i8QDYOlXZuqQHVPi5mZuL7GNS+BLLyhmgcHVIiUHqnSSr45a2
	 5MNk8EAAUZ62y7UfLkNCFZptRKcIkMAcKoENV4oLBSMex0beUD7VpT2MH7hJ+CQR8m
	 ZRc6ftcr9rX/mJpcuGyVBGjVuTB/PaaN9ATz6xplopx9BQXMS4XmOAFc+WyxGUdiQ0
	 /weAGIEiOxBX+V057hxt7T0CDuL65DVRqMLKSYNgTEN9zV5zKkGXalCeoZQMxdt3ts
	 8baAL2IbB5C2A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH 2/5] tracing/probes: Support BTF field access from retval
Date: Sat, 17 Jun 2023 18:47:16 +0900
Message-ID:  <168699523643.528797.2114547152033345802.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
References:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
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

Introduce 'retval' (Not '$retval') BTF argument for function return events
including kretprobe and fprobe for accessing the return value. This also
allows user to access its fields if the return value is a pointer of a
data structure.

E.g.
 # echo 'f getname_flags%return +0(retval->name):string' \
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
 kernel/trace/trace_probe.c |   54 +++++++++++++++++---------------------------
 kernel/trace/trace_probe.h |    7 ++++++
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1f05c819633f..0149d0abb5fd 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -585,6 +585,21 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (ctx->flags & TPARG_FL_RETURN) {
+		if (strcmp(varname, "retval") != 0) {
+			trace_probe_log_err(ctx->offset, NO_BTFARG);
+			return -ENOENT;
+		}
+		type = find_btf_func_proto(ctx->funcname);
+		if (type->type == 0) {
+			trace_probe_log_err(ctx->offset, NO_RETVAL);
+			return -ENOENT;
+		}
+		code->op = FETCH_OP_RETVAL;
+		tid = type->type;
+		goto found;
+	}
+
 	if (!ctx->params) {
 		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
 					     ctx->flags & TPARG_FL_TPOINT);
@@ -605,7 +620,6 @@ static int parse_btf_arg(char *varname,
 				code->param = i + 1;
 			else
 				code->param = i;
-
 			tid = params[i].type;
 			goto found;
 		}
@@ -630,7 +644,7 @@ static int parse_btf_arg(char *varname,
 	return 0;
 }
 
-static const struct fetch_type *parse_btf_arg_type(
+static const struct fetch_type *find_fetch_type_from_btf_type(
 					struct traceprobe_parse_context *ctx)
 {
 	struct btf *btf = traceprobe_get_btf();
@@ -642,26 +656,6 @@ static const struct fetch_type *parse_btf_arg_type(
 	return find_fetch_type(typestr, ctx->flags);
 }
 
-static const struct fetch_type *parse_btf_retval_type(
-					struct traceprobe_parse_context *ctx)
-{
-	struct btf *btf = traceprobe_get_btf();
-	const char *typestr = NULL;
-	const struct btf_type *type;
-	s32 tid;
-
-	if (btf && ctx->funcname) {
-		type = find_btf_func_proto(ctx->funcname);
-		if (!IS_ERR(type)) {
-			type = btf_type_skip_modifiers(btf, type->type, &tid);
-			if (type)
-				typestr = fetch_type_from_btf_type(btf, type, ctx);
-		}
-	}
-
-	return find_fetch_type(typestr, ctx->flags);
-}
-
 static int parse_btf_bitfield(struct fetch_insn **pcode,
 			      struct traceprobe_parse_context *ctx)
 {
@@ -721,10 +715,7 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return -EOPNOTSUPP;
 }
 
-#define parse_btf_arg_type(ctx)		\
-	find_fetch_type(NULL, ctx->flags)
-
-#define parse_btf_retval_type(ctx)		\
+#define find_fetch_type_from_btf_type(ctx)		\
 	find_fetch_type(NULL, ctx->flags)
 
 #define is_btf_retval_void(funcname)	(false)
@@ -1010,7 +1001,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
-			if (!tparg_is_function_entry(ctx->flags)) {
+			if (!tparg_is_btf_available(ctx->flags)) {
 				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 				return -EINVAL;
 			}
@@ -1167,12 +1158,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
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
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 050909aaaa1b..7aae50633819 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -381,6 +381,13 @@ static inline bool tparg_is_function_entry(unsigned int flags)
 	return (flags & TPARG_FL_LOC_MASK) == (TPARG_FL_KERNEL | TPARG_FL_FENTRY);
 }
 
+/* BTF is available at the kernel function entry and exit */
+static inline bool tparg_is_btf_available(unsigned int flags)
+{
+	return (flags & TPARG_FL_KERNEL) &&
+		(flags & (TPARG_FL_FENTRY | TPARG_FL_RETURN));
+}
+
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
 	const struct btf_param *params;


