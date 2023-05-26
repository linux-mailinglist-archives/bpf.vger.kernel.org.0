Return-Path: <bpf+bounces-1274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B13711EC4
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F429281048
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017523AD;
	Fri, 26 May 2023 04:18:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F11C26
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0121C433EF;
	Fri, 26 May 2023 04:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685074734;
	bh=mbOvZG4uzh5ehodhV8yVAELsRZMpwSHPDk125wF83mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUzD2t17bDjEDeXAnlylyfKtvsmJPdYiU7EOU0rZ6gZM6s1buOi5RwgNMUqG57t/X
	 aEznQp0N6RqCl/cB1NU0/lbuiXKR43qar6zZczqoHkhR1bjRGehyJ9UA70ZQ0iH9TV
	 37AIhIP/kesI6aTOEV0hPxbTAJ17YkndDwXLV2DwZxfmi6IwrI5n/Dgwmw4DjLSZpC
	 mMH6hivlPWLZ8M0PUisikCEUn0KKJdjfUYwKiUJo+0M71kBTm4NfboPsSIPccBmOED
	 gcu+kQqu9MpT7YhdpuSyz79UyVfsvhHHGyxD0MBdaoOk8OWNX0XtLvVUrG+8yeiL7x
	 xknfN6RHwzK2w==
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
Subject: [PATCH v13 06/12] tracing/probes: Move event parameter fetching code to common parser
Date: Fri, 26 May 2023 12:18:49 +0800
Message-ID:  <168507472950.913472.2812253181558471278.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
References:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
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

Move trace event parameter fetching code to common parser in
trace_probe.c. This simplifies eprobe's trace-event variable fetching
code by introducing a parse context data structure.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v10:
  - Cleanup code to handle errors consistency way.
---
 kernel/trace/trace_eprobe.c |   44 +--------
 kernel/trace/trace_fprobe.c |    4 +
 kernel/trace/trace_kprobe.c |    4 +
 kernel/trace/trace_probe.c  |  218 ++++++++++++++++++++++++++-----------------
 kernel/trace/trace_probe.h  |    9 ++
 kernel/trace/trace_uprobe.c |    8 +-
 6 files changed, 155 insertions(+), 132 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index fd64cd5d5745..cb0077ba2b49 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -227,37 +227,6 @@ static struct trace_eprobe *alloc_event_probe(const char *group,
 	return ERR_PTR(ret);
 }
 
-static int trace_eprobe_tp_arg_update(struct trace_eprobe *ep, int i)
-{
-	struct probe_arg *parg = &ep->tp.args[i];
-	struct ftrace_event_field *field;
-	struct list_head *head;
-	int ret = -ENOENT;
-
-	head = trace_get_fields(ep->event);
-	list_for_each_entry(field, head, link) {
-		if (!strcmp(parg->code->data, field->name)) {
-			kfree(parg->code->data);
-			parg->code->data = field;
-			return 0;
-		}
-	}
-
-	/*
-	 * Argument not found on event. But allow for comm and COMM
-	 * to be used to get the current->comm.
-	 */
-	if (strcmp(parg->code->data, "COMM") == 0 ||
-	    strcmp(parg->code->data, "comm") == 0) {
-		parg->code->op = FETCH_OP_COMM;
-		ret = 0;
-	}
-
-	kfree(parg->code->data);
-	parg->code->data = NULL;
-	return ret;
-}
-
 static int eprobe_event_define_fields(struct trace_event_call *event_call)
 {
 	struct eprobe_trace_entry_head field;
@@ -817,19 +786,16 @@ find_and_get_event(const char *system, const char *event_name)
 
 static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[], int i)
 {
-	unsigned int flags = TPARG_FL_KERNEL | TPARG_FL_TEVENT;
+	struct traceprobe_parse_context ctx = {
+		.event = ep->event,
+		.flags = TPARG_FL_KERNEL | TPARG_FL_TEVENT,
+	};
 	int ret;
 
-	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], flags);
+	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], &ctx);
 	if (ret)
 		return ret;
 
-	if (ep->tp.args[i].code->op == FETCH_OP_TP_ARG) {
-		ret = trace_eprobe_tp_arg_update(ep, i);
-		if (ret)
-			trace_probe_log_err(0, BAD_ATTACH_ARG);
-	}
-
 	/* Handle symbols "@" */
 	if (!ret)
 		ret = traceprobe_update_arg(&ep->tp.args[i]);
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index aa71ccb4205c..7d144e4a3fb6 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1047,8 +1047,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+		struct traceprobe_parse_context ctx = { .flags = flags };
+
 		trace_probe_log_set_index(i + 2);
-		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], flags);
+		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
 		if (ret)
 			goto error;	/* This can be -ENOMEM */
 	}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b7a4409674b3..1a3497719ada 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -867,8 +867,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+		struct traceprobe_parse_context ctx = { .flags = flags };
+
 		trace_probe_log_set_index(i + 2);
-		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
+		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
 		if (ret)
 			goto error;	/* This can be -ENOMEM */
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dffbed2ddae9..30eeac5e9b61 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -283,74 +283,114 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 	return 0;
 }
 
+static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
+				 struct traceprobe_parse_context *ctx)
+{
+	struct ftrace_event_field *field;
+	struct list_head *head;
+
+	head = trace_get_fields(ctx->event);
+	list_for_each_entry(field, head, link) {
+		if (!strcmp(arg, field->name)) {
+			code->op = FETCH_OP_TP_ARG;
+			code->data = field;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
 static int parse_probe_vars(char *arg, const struct fetch_type *t,
-			struct fetch_insn *code, unsigned int flags, int offs)
+			    struct fetch_insn *code,
+			    struct traceprobe_parse_context *ctx)
 {
 	unsigned long param;
+	int err = TP_ERR_BAD_VAR;
 	int ret = 0;
 	int len;
 
-	if (flags & TPARG_FL_TEVENT) {
+	if (ctx->flags & TPARG_FL_TEVENT) {
 		if (code->data)
 			return -EFAULT;
-		code->data = kstrdup(arg, GFP_KERNEL);
-		if (!code->data)
-			return -ENOMEM;
-		code->op = FETCH_OP_TP_ARG;
-	} else if (strcmp(arg, "retval") == 0) {
-		if (flags & TPARG_FL_RETURN) {
+		ret = parse_trace_event_arg(arg, code, ctx);
+		if (!ret)
+			return 0;
+		if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
+			code->op = FETCH_OP_COMM;
+			return 0;
+		}
+		/* backward compatibility */
+		ctx->offset = 0;
+		goto inval;
+	}
+
+	if (strcmp(arg, "retval") == 0) {
+		if (ctx->flags & TPARG_FL_RETURN) {
 			code->op = FETCH_OP_RETVAL;
-		} else {
-			trace_probe_log_err(offs, RETVAL_ON_PROBE);
-			ret = -EINVAL;
+			return 0;
 		}
-	} else if ((len = str_has_prefix(arg, "stack"))) {
+		err = TP_ERR_RETVAL_ON_PROBE;
+		goto inval;
+	}
+
+	len = str_has_prefix(arg, "stack");
+	if (len) {
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
-			} else if ((flags & TPARG_FL_KERNEL) &&
-				    param > PARAM_MAX_STACK) {
-				trace_probe_log_err(offs, BAD_STACK_NUM);
-				ret = -EINVAL;
-			} else {
-				code->op = FETCH_OP_STACK;
-				code->param = (unsigned int)param;
+			if (ret)
+				goto inval;
+
+			if ((ctx->flags & TPARG_FL_KERNEL) &&
+			    param > PARAM_MAX_STACK) {
+				err = TP_ERR_BAD_STACK_NUM;
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
-	} else if (tparg_is_function_entry(flags) &&
-		   (len = str_has_prefix(arg, "arg"))) {
+	len = str_has_prefix(arg, "arg");
+	if (len && tparg_is_function_entry(ctx->flags)) {
 		ret = kstrtoul(arg + len, 10, &param);
-		if (ret) {
-			goto inval_var;
-		} else if (!param || param > PARAM_MAX_STACK) {
-			trace_probe_log_err(offs, BAD_ARG_NUM);
-			return -EINVAL;
+		if (ret)
+			goto inval;
+
+		if (!param || param > PARAM_MAX_STACK) {
+			err = TP_ERR_BAD_ARG_NUM;
+			goto inval;
 		}
+
 		code->op = FETCH_OP_ARG;
 		code->param = (unsigned int)param - 1;
 		/*
 		 * The tracepoint probe will probe a stub function, and the
 		 * first parameter of the stub is a dummy and should be ignored.
 		 */
-		if (flags & TPARG_FL_TPOINT)
+		if (ctx->flags & TPARG_FL_TPOINT)
 			code->param++;
+		return 0;
+	}
 #endif
-	} else
-		goto inval_var;
 
-	return ret;
-
-inval_var:
-	trace_probe_log_err(offs, BAD_VAR);
+inval:
+	__trace_probe_log_err(ctx->offset, err);
 	return -EINVAL;
 }
 
@@ -383,7 +423,7 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
 static int
 parse_probe_arg(char *arg, const struct fetch_type *type,
 		struct fetch_insn **pcode, struct fetch_insn *end,
-		unsigned int flags, int offs)
+		struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
@@ -394,13 +434,13 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	switch (arg[0]) {
 	case '$':
-		ret = parse_probe_vars(arg + 1, type, code, flags, offs);
+		ret = parse_probe_vars(arg + 1, type, code, ctx);
 		break;
 
 	case '%':	/* named register */
-		if (flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
+		if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
 			/* eprobe and fprobe do not handle registers */
-			trace_probe_log_err(offs, BAD_VAR);
+			trace_probe_log_err(ctx->offset, BAD_VAR);
 			break;
 		}
 		ret = regs_query_register_offset(arg + 1);
@@ -409,14 +449,14 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->param = (unsigned int)ret;
 			ret = 0;
 		} else
-			trace_probe_log_err(offs, BAD_REG_NAME);
+			trace_probe_log_err(ctx->offset, BAD_REG_NAME);
 		break;
 
 	case '@':	/* memory, file-offset or symbol */
 		if (isdigit(arg[1])) {
 			ret = kstrtoul(arg + 1, 0, &param);
 			if (ret) {
-				trace_probe_log_err(offs, BAD_MEM_ADDR);
+				trace_probe_log_err(ctx->offset, BAD_MEM_ADDR);
 				break;
 			}
 			/* load address */
@@ -424,13 +464,13 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->immediate = param;
 		} else if (arg[1] == '+') {
 			/* kprobes don't support file offsets */
-			if (flags & TPARG_FL_KERNEL) {
-				trace_probe_log_err(offs, FILE_ON_KPROBE);
+			if (ctx->flags & TPARG_FL_KERNEL) {
+				trace_probe_log_err(ctx->offset, FILE_ON_KPROBE);
 				return -EINVAL;
 			}
 			ret = kstrtol(arg + 2, 0, &offset);
 			if (ret) {
-				trace_probe_log_err(offs, BAD_FILE_OFFS);
+				trace_probe_log_err(ctx->offset, BAD_FILE_OFFS);
 				break;
 			}
 
@@ -438,8 +478,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->immediate = (unsigned long)offset;  // imm64?
 		} else {
 			/* uprobes don't support symbols */
-			if (!(flags & TPARG_FL_KERNEL)) {
-				trace_probe_log_err(offs, SYM_ON_UPROBE);
+			if (!(ctx->flags & TPARG_FL_KERNEL)) {
+				trace_probe_log_err(ctx->offset, SYM_ON_UPROBE);
 				return -EINVAL;
 			}
 			/* Preserve symbol for updating */
@@ -448,7 +488,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			if (!code->data)
 				return -ENOMEM;
 			if (++code == end) {
-				trace_probe_log_err(offs, TOO_MANY_OPS);
+				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
 				return -EINVAL;
 			}
 			code->op = FETCH_OP_IMM;
@@ -456,7 +496,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		}
 		/* These are fetching from memory */
 		if (++code == end) {
-			trace_probe_log_err(offs, TOO_MANY_OPS);
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
 			return -EINVAL;
 		}
 		*pcode = code;
@@ -475,36 +515,38 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			arg++;	/* Skip '+', because kstrtol() rejects it. */
 		tmp = strchr(arg, '(');
 		if (!tmp) {
-			trace_probe_log_err(offs, DEREF_NEED_BRACE);
+			trace_probe_log_err(ctx->offset, DEREF_NEED_BRACE);
 			return -EINVAL;
 		}
 		*tmp = '\0';
 		ret = kstrtol(arg, 0, &offset);
 		if (ret) {
-			trace_probe_log_err(offs, BAD_DEREF_OFFS);
+			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
 			break;
 		}
-		offs += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
+		ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
 		arg = tmp + 1;
 		tmp = strrchr(arg, ')');
 		if (!tmp) {
-			trace_probe_log_err(offs + strlen(arg),
+			trace_probe_log_err(ctx->offset + strlen(arg),
 					    DEREF_OPEN_BRACE);
 			return -EINVAL;
 		} else {
-			const struct fetch_type *t2 = find_fetch_type(NULL, flags);
+			const struct fetch_type *t2 = find_fetch_type(NULL, ctx->flags);
+			int cur_offs = ctx->offset;
 
 			*tmp = '\0';
-			ret = parse_probe_arg(arg, t2, &code, end, flags, offs);
+			ret = parse_probe_arg(arg, t2, &code, end, ctx);
 			if (ret)
 				break;
+			ctx->offset = cur_offs;
 			if (code->op == FETCH_OP_COMM ||
 			    code->op == FETCH_OP_DATA) {
-				trace_probe_log_err(offs, COMM_CANT_DEREF);
+				trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
 				return -EINVAL;
 			}
 			if (++code == end) {
-				trace_probe_log_err(offs, TOO_MANY_OPS);
+				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
 				return -EINVAL;
 			}
 			*pcode = code;
@@ -515,7 +557,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 	case '\\':	/* Immediate value */
 		if (arg[1] == '"') {	/* Immediate string */
-			ret = __parse_imm_string(arg + 2, &tmp, offs + 2);
+			ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
 			if (ret)
 				break;
 			code->op = FETCH_OP_DATA;
@@ -523,7 +565,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		} else {
 			ret = str_to_immediate(arg + 1, &code->immediate);
 			if (ret)
-				trace_probe_log_err(offs + 1, BAD_IMM);
+				trace_probe_log_err(ctx->offset + 1, BAD_IMM);
 			else
 				code->op = FETCH_OP_IMM;
 		}
@@ -531,7 +573,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 	}
 	if (!ret && code->op == FETCH_OP_NOP) {
 		/* Parsed, but do not find fetch method */
-		trace_probe_log_err(offs, BAD_FETCH_ARG);
+		trace_probe_log_err(ctx->offset, BAD_FETCH_ARG);
 		ret = -EINVAL;
 	}
 	return ret;
@@ -576,12 +618,13 @@ static int __parse_bitfield_probe_arg(const char *bf,
 
 /* String length checking wrapper */
 static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
-		struct probe_arg *parg, unsigned int flags, int offset)
+					   struct probe_arg *parg,
+					   struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code, *scode, *tmp = NULL;
 	char *t, *t2, *t3;
-	char *arg;
 	int ret, len;
+	char *arg;
 
 	arg = kstrdup(argv, GFP_KERNEL);
 	if (!arg)
@@ -590,10 +633,10 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	ret = -EINVAL;
 	len = strlen(arg);
 	if (len > MAX_ARGSTR_LEN) {
-		trace_probe_log_err(offset, ARG_TOO_LONG);
+		trace_probe_log_err(ctx->offset, ARG_TOO_LONG);
 		goto out;
 	} else if (len == 0) {
-		trace_probe_log_err(offset, NO_ARG_BODY);
+		trace_probe_log_err(ctx->offset, NO_ARG_BODY);
 		goto out;
 	}
 
@@ -611,23 +654,24 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			*t2++ = '\0';
 			t3 = strchr(t2, ']');
 			if (!t3) {
-				offset += t2 + strlen(t2) - arg;
-				trace_probe_log_err(offset,
+				int offs = t2 + strlen(t2) - arg;
+
+				trace_probe_log_err(ctx->offset + offs,
 						    ARRAY_NO_CLOSE);
 				goto out;
 			} else if (t3[1] != '\0') {
-				trace_probe_log_err(offset + t3 + 1 - arg,
+				trace_probe_log_err(ctx->offset + t3 + 1 - arg,
 						    BAD_ARRAY_SUFFIX);
 				goto out;
 			}
 			*t3 = '\0';
 			if (kstrtouint(t2, 0, &parg->count) || !parg->count) {
-				trace_probe_log_err(offset + t2 - arg,
+				trace_probe_log_err(ctx->offset + t2 - arg,
 						    BAD_ARRAY_NUM);
 				goto out;
 			}
 			if (parg->count > MAX_ARRAY_LEN) {
-				trace_probe_log_err(offset + t2 - arg,
+				trace_probe_log_err(ctx->offset + t2 - arg,
 						    ARRAY_TOO_BIG);
 				goto out;
 			}
@@ -638,17 +682,17 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	 * Since $comm and immediate string can not be dereferenced,
 	 * we can find those by strcmp. But ignore for eprobes.
 	 */
-	if (!(flags & TPARG_FL_TEVENT) &&
+	if (!(ctx->flags & TPARG_FL_TEVENT) &&
 	    (strcmp(arg, "$comm") == 0 || strcmp(arg, "$COMM") == 0 ||
 	     strncmp(arg, "\\\"", 2) == 0)) {
 		/* The type of $comm must be "string", and not an array. */
 		if (parg->count || (t && strcmp(t, "string")))
 			goto out;
-		parg->type = find_fetch_type("string", flags);
+		parg->type = find_fetch_type("string", ctx->flags);
 	} else
-		parg->type = find_fetch_type(t, flags);
+		parg->type = find_fetch_type(t, ctx->flags);
 	if (!parg->type) {
-		trace_probe_log_err(offset + (t ? (t - arg) : 0), BAD_TYPE);
+		trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0), BAD_TYPE);
 		goto out;
 	}
 	parg->offset = *size;
@@ -670,7 +714,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
-			      flags, offset);
+			      ctx);
 	if (ret)
 		goto fail;
 
@@ -681,7 +725,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
 			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
-				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+				trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
 						    BAD_SYMSTRING);
 				goto fail;
 			}
@@ -689,7 +733,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
 			    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
 			    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
-				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+				trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
 						    BAD_STRING);
 				goto fail;
 			}
@@ -708,7 +752,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 */
 			code++;
 			if (code->op != FETCH_OP_NOP) {
-				trace_probe_log_err(offset, TOO_MANY_OPS);
+				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
 				goto fail;
 			}
 		}
@@ -731,7 +775,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	} else {
 		code++;
 		if (code->op != FETCH_OP_NOP) {
-			trace_probe_log_err(offset, TOO_MANY_OPS);
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
 			goto fail;
 		}
 		code->op = FETCH_OP_ST_RAW;
@@ -742,7 +786,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	if (t != NULL) {
 		ret = __parse_bitfield_probe_arg(t, parg->type, &code);
 		if (ret) {
-			trace_probe_log_err(offset + t - arg, BAD_BITFIELD);
+			trace_probe_log_err(ctx->offset + t - arg, BAD_BITFIELD);
 			goto fail;
 		}
 	}
@@ -752,13 +796,13 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		if (scode->op != FETCH_OP_ST_MEM &&
 		    scode->op != FETCH_OP_ST_STRING &&
 		    scode->op != FETCH_OP_ST_USTRING) {
-			trace_probe_log_err(offset + (t ? (t - arg) : 0),
+			trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
 					    BAD_STRING);
 			goto fail;
 		}
 		code++;
 		if (code->op != FETCH_OP_NOP) {
-			trace_probe_log_err(offset, TOO_MANY_OPS);
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
 			goto fail;
 		}
 		code->op = FETCH_OP_LP_ARRAY;
@@ -807,7 +851,7 @@ static int traceprobe_conflict_field_name(const char *name,
 }
 
 int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
-				unsigned int flags)
+			       struct traceprobe_parse_context *ctx)
 {
 	struct probe_arg *parg = &tp->args[i];
 	const char *body;
@@ -842,9 +886,9 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 		trace_probe_log_err(0, USED_ARG_NAME);
 		return -EINVAL;
 	}
+	ctx->offset = body - arg;
 	/* Parse fetch argument */
-	return traceprobe_parse_probe_arg_body(body, &tp->size, parg, flags,
-					       body - arg);
+	return traceprobe_parse_probe_arg_body(body, &tp->size, parg, ctx);
 }
 
 void traceprobe_free_probe_arg(struct probe_arg *arg)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 7a0703c00a7d..aa0991349c59 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -378,8 +378,15 @@ static inline bool tparg_is_function_entry(unsigned int flags)
 	return (flags & TPARG_FL_LOC_MASK) == (TPARG_FL_KERNEL | TPARG_FL_FENTRY);
 }
 
+struct traceprobe_parse_context {
+	struct trace_event_call *event;
+	unsigned int flags;
+	int offset;
+};
+
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
-				const char *argv, unsigned int flags);
+				      const char *argv,
+				      struct traceprobe_parse_context *ctx);
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b92e34ff0c8..fa09b33ee731 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -686,10 +686,12 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+		struct traceprobe_parse_context ctx = {
+			.flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER,
+		};
+
 		trace_probe_log_set_index(i + 2);
-		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i],
-					(is_return ? TPARG_FL_RETURN : 0) |
-					TPARG_FL_USER);
+		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], &ctx);
 		if (ret)
 			goto error;
 	}


