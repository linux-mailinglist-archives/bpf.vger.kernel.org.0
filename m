Return-Path: <bpf+bounces-5105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F487567CB
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62232812BA
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAACBA27;
	Mon, 17 Jul 2023 15:24:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A9AD26
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC055C433C8;
	Mon, 17 Jul 2023 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607441;
	bh=6fmjmQFY0f+lFuunAgeTFkf6Os4EuVkND2LlVKd924M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVoNV+JjHeYw0yJfPYyIPz/SBw8QYymGfTRD4EFXK6FOZTEOjNL4djzpMFq09k+UH
	 uiRd8xGONWdUc/cwsqts6tnpxI8xmEJBMgrutqt8KCyB9EVGV3qflzJn8GEsX565lv
	 XCHLzh96VKVl0jR51f8oH4/61kHGu+y/eDLyWWu6NMSYDdwYtWD/6HZ8nDnOYOWvSN
	 xMXU0RJM0g1Xdj7V7k/uioEqSZc6rAP+7KWSbybXPIkC2Vw74nFdEtIAOQS3wmF09E
	 VgydjE5St0h35xEJXBUtygC3i9Ax7nYiWBDlDnfT8Kw/idXq2hdaKo5VRiZgYmsBJU
	 BmKqQXjZ9iqpg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 4/9] tracing/probes: Support BTF based data structure field access
Date: Tue, 18 Jul 2023 00:23:57 +0900
Message-Id: <168960743715.34107.15965496586942658628.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
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

Using BTF to access the fields of a data structure. You can use this
for accessing the field with '->' or '.' operation with BTF argument.

 # echo 't sched_switch next=next->pid vruntime=next->se.vruntime' \
   > dynamic_events
 # echo 1 > events/tracepoints/sched_switch/enable
 # head -n 40 trace | tail
          <idle>-0       [000] d..3.   272.565382: sched_switch: (__probestub_sched_switch+0x4/0x10) next=26 vruntime=956533179
      kcompactd0-26      [000] d..3.   272.565406: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0
          <idle>-0       [000] d..3.   273.069441: sched_switch: (__probestub_sched_switch+0x4/0x10) next=9 vruntime=956533179
     kworker/0:1-9       [000] d..3.   273.069464: sched_switch: (__probestub_sched_switch+0x4/0x10) next=26 vruntime=956579181
      kcompactd0-26      [000] d..3.   273.069480: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0
          <idle>-0       [000] d..3.   273.141434: sched_switch: (__probestub_sched_switch+0x4/0x10) next=22 vruntime=956533179
    kworker/u2:1-22      [000] d..3.   273.141461: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0
          <idle>-0       [000] d..3.   273.480872: sched_switch: (__probestub_sched_switch+0x4/0x10) next=22 vruntime=956585857
    kworker/u2:1-22      [000] d..3.   273.480905: sched_switch: (__probestub_sched_switch+0x4/0x10) next=70 vruntime=959533179
              sh-70      [000] d..3.   273.481102: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Use new BTF API for finding the member.
---
 kernel/trace/trace_probe.c |  229 +++++++++++++++++++++++++++++++++++++++-----
 kernel/trace/trace_probe.h |   11 ++
 2 files changed, 213 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cd89fc1ebb42..dd646d35637d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -319,16 +319,14 @@ static u32 btf_type_int(const struct btf_type *t)
 	return *(u32 *)(t + 1);
 }
 
-static const char *type_from_btf_id(struct btf *btf, s32 id)
+static const char *fetch_type_from_btf_type(struct btf *btf,
+					const struct btf_type *type,
+					struct traceprobe_parse_context *ctx)
 {
-	const struct btf_type *t;
 	u32 intdata;
-	s32 tid;
 
 	/* TODO: const char * could be converted as a string */
-	t = btf_type_skip_modifiers(btf, id, &tid);
-
-	switch (BTF_INFO_KIND(t->info)) {
+	switch (BTF_INFO_KIND(type->info)) {
 	case BTF_KIND_ENUM:
 		/* enum is "int", so convert to "s32" */
 		return "s32";
@@ -341,7 +339,7 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
 		else
 			return "x32";
 	case BTF_KIND_INT:
-		intdata = btf_type_int(t);
+		intdata = btf_type_int(type);
 		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
 			switch (BTF_INT_BITS(intdata)) {
 			case 8:
@@ -364,6 +362,10 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
 			case 64:
 				return "u64";
 			}
+			/* bitfield, size is encoded in the type */
+			ctx->last_bitsize = BTF_INT_BITS(intdata);
+			ctx->last_bitoffs += BTF_INT_OFFSET(intdata);
+			return "u64";
 		}
 	}
 	/* TODO: support other types */
@@ -401,12 +403,120 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 		return NULL;
 }
 
-static int parse_btf_arg(const char *varname, struct fetch_insn *code,
+/* Return 1 if the field separater is arrow operator ('->') */
+static int split_next_field(char *varname, char **next_field,
+			    struct traceprobe_parse_context *ctx)
+{
+	char *field;
+	int ret = 0;
+
+	field = strpbrk(varname, ".-");
+	if (field) {
+		if (field[0] == '-' && field[1] == '>') {
+			field[0] = '\0';
+			field += 2;
+			ret = 1;
+		} else if (field[0] == '.') {
+			field[0] = '\0';
+			field += 1;
+		} else {
+			trace_probe_log_err(ctx->offset + field - varname, BAD_HYPHEN);
+			return -EINVAL;
+		}
+		*next_field = field;
+	}
+
+	return ret;
+}
+
+/*
+ * Parse the field of data structure. The @type must be a pointer type
+ * pointing the target data structure type.
+ */
+static int parse_btf_field(char *fieldname, const struct btf_type *type,
+			   struct fetch_insn **pcode, struct fetch_insn *end,
+			   struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+	struct fetch_insn *code = *pcode;
+	const struct btf_member *field;
+	u32 bitoffs;
+	char *next;
+	int is_ptr;
+	s32 tid;
+
+	do {
+		/* Outer loop for solving arrow operator ('->') */
+		if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
+			trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
+			return -EINVAL;
+		}
+		/* Convert a struct pointer type to a struct type */
+		type = btf_type_skip_modifiers(btf, type->type, &tid);
+		if (!type) {
+			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+			return -EINVAL;
+		}
+
+		bitoffs = 0;
+		do {
+			/* Inner loop for solving dot operator ('.') */
+			next = NULL;
+			is_ptr = split_next_field(fieldname, &next, ctx);
+			if (is_ptr < 0)
+				return is_ptr;
+
+			field = btf_find_struct_member(btf, type, fieldname);
+			if (!field) {
+				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
+				return -ENOENT;
+			}
+
+			/* Accumulate the bit-offsets of the dot-connected fields */
+			if (btf_type_kflag(type)) {
+				bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
+				ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
+			} else {
+				bitoffs += field->offset;
+				ctx->last_bitsize = 0;
+			}
+
+			type = btf_type_skip_modifiers(btf, field->type, &tid);
+			if (!type) {
+				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+				return -EINVAL;
+			}
+
+			ctx->offset += next - fieldname;
+			fieldname = next;
+		} while (!is_ptr && fieldname);
+
+		if (++code == end) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+			return -EINVAL;
+		}
+		code->op = FETCH_OP_DEREF;	/* TODO: user deref support */
+		code->offset = bitoffs / 8;
+		*pcode = code;
+
+		ctx->last_bitoffs = bitoffs % 8;
+		ctx->last_type = type;
+	} while (fieldname);
+
+	return 0;
+}
+
+static int parse_btf_arg(char *varname,
+			 struct fetch_insn **pcode, struct fetch_insn *end,
 			 struct traceprobe_parse_context *ctx)
 {
 	struct btf *btf = traceprobe_get_btf();
+	struct fetch_insn *code = *pcode;
 	const struct btf_param *params;
-	int i;
+	const struct btf_type *type;
+	char *field = NULL;
+	int i, is_ptr;
+	u32 tid;
 
 	if (!btf) {
 		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
@@ -416,6 +526,16 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 	if (WARN_ON_ONCE(!ctx->funcname))
 		return -EINVAL;
 
+	is_ptr = split_next_field(varname, &field, ctx);
+	if (is_ptr < 0)
+		return is_ptr;
+	if (!is_ptr && field) {
+		/* dot-connected field on an argument is not supported. */
+		trace_probe_log_err(ctx->offset + field - varname,
+				    NOSUP_DAT_ARG);
+		return -EOPNOTSUPP;
+	}
+
 	if (!ctx->params) {
 		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
 					     ctx->flags & TPARG_FL_TPOINT);
@@ -436,24 +556,39 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 				code->param = i + 1;
 			else
 				code->param = i;
-			return 0;
+
+			tid = params[i].type;
+			goto found;
 		}
 	}
 	trace_probe_log_err(ctx->offset, NO_BTFARG);
 	return -ENOENT;
+
+found:
+	type = btf_type_skip_modifiers(btf, tid, &tid);
+	if (!type) {
+		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+		return -EINVAL;
+	}
+	/* Initialize the last type information */
+	ctx->last_type = type;
+	ctx->last_bitoffs = 0;
+	ctx->last_bitsize = 0;
+	if (field) {
+		ctx->offset += field - varname;
+		return parse_btf_field(field, type, pcode, end, ctx);
+	}
+	return 0;
 }
 
-static const struct fetch_type *parse_btf_arg_type(int arg_idx,
+static const struct fetch_type *parse_btf_arg_type(
 					struct traceprobe_parse_context *ctx)
 {
 	struct btf *btf = traceprobe_get_btf();
 	const char *typestr = NULL;
 
-	if (btf && ctx->params) {
-		if (ctx->flags & TPARG_FL_TPOINT)
-			arg_idx--;
-		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
-	}
+	if (btf && ctx->last_type)
+		typestr = fetch_type_from_btf_type(btf, ctx->last_type, ctx);
 
 	return find_fetch_type(typestr, ctx->flags);
 }
@@ -463,17 +598,43 @@ static const struct fetch_type *parse_btf_retval_type(
 {
 	struct btf *btf = traceprobe_get_btf();
 	const char *typestr = NULL;
-	const struct btf_type *t;
+	const struct btf_type *type;
+	s32 tid;
 
 	if (btf && ctx->funcname) {
-		t = btf_find_func_proto(btf, ctx->funcname);
-		if (!IS_ERR_OR_NULL(t))
-			typestr = type_from_btf_id(btf, t->type);
+		type = btf_find_func_proto(btf, ctx->funcname);
+		if (!IS_ERR_OR_NULL(type)) {
+			type = btf_type_skip_modifiers(btf, type->type, &tid);
+			if (!IS_ERR_OR_NULL(type))
+				typestr = fetch_type_from_btf_type(btf, type, ctx);
+		}
 	}
 
 	return find_fetch_type(typestr, ctx->flags);
 }
 
+static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *code = *pcode;
+
+	if ((ctx->last_bitsize % 8 == 0) && ctx->last_bitoffs == 0)
+		return 0;
+
+	code++;
+	if (code->op != FETCH_OP_NOP) {
+		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+		return -EINVAL;
+	}
+	*pcode = code;
+
+	code->op = FETCH_OP_MOD_BF;
+	code->lshift = 64 - (ctx->last_bitsize + ctx->last_bitoffs);
+	code->rshift = 64 - ctx->last_bitsize;
+	code->basesize = 64 / 8;
+	return 0;
+}
+
 static bool is_btf_retval_void(const char *funcname)
 {
 	struct btf *btf = traceprobe_get_btf();
@@ -500,14 +661,22 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static int parse_btf_arg(const char *varname, struct fetch_insn *code,
+static int parse_btf_arg(char *varname,
+			 struct fetch_insn **pcode, struct fetch_insn *end,
 			 struct traceprobe_parse_context *ctx)
 {
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 	return -EOPNOTSUPP;
 }
 
-#define parse_btf_arg_type(idx, ctx)		\
+static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      struct traceprobe_parse_context *ctx)
+{
+	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+	return -EOPNOTSUPP;
+}
+
+#define parse_btf_arg_type(ctx)		\
 	find_fetch_type(NULL, ctx->flags)
 
 #define parse_btf_retval_type(ctx)		\
@@ -775,6 +944,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 			code->op = deref;
 			code->offset = offset;
+			/* Reset the last type if used */
+			ctx->last_type = NULL;
 		}
 		break;
 	case '\\':	/* Immediate value */
@@ -798,7 +969,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 				return -EINVAL;
 			}
-			ret = parse_btf_arg(arg, code, ctx);
+			ret = parse_btf_arg(arg, pcode, end, ctx);
 			break;
 		}
 	}
@@ -944,6 +1115,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		goto out;
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
+	ctx->last_type = NULL;
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
 			      ctx);
 	if (ret)
@@ -951,9 +1123,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	/* Update storing type if BTF is available */
 	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
-		if (code->op == FETCH_OP_ARG)
-			parg->type = parse_btf_arg_type(code->param, ctx);
-		else if (code->op == FETCH_OP_RETVAL)
+		if (ctx->last_type)
+			parg->type = parse_btf_arg_type(ctx);
+		else if (ctx->flags & TPARG_FL_RETURN)
 			parg->type = parse_btf_retval_type(ctx);
 	}
 
@@ -1028,6 +1200,11 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			trace_probe_log_err(ctx->offset + t - arg, BAD_BITFIELD);
 			goto fail;
 		}
+	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
+		   ctx->last_type) {
+		ret = parse_btf_bitfield(&code, ctx);
+		if (ret)
+			goto fail;
 	}
 	ret = -EINVAL;
 	/* Loop(Array) operation */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 01ea148723de..050909aaaa1b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -384,6 +384,9 @@ static inline bool tparg_is_function_entry(unsigned int flags)
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
 	const struct btf_param *params;
+	const struct btf_type *last_type;
+	u32 last_bitoffs;
+	u32 last_bitsize;
 	s32 nr_params;
 	const char *funcname;
 	unsigned int flags;
@@ -495,7 +498,13 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),\
 	C(NOFENTRY_ARGS,	"$arg* can be used only on function entry"),	\
 	C(DOUBLE_ARGS,		"$arg* can be used only once in the parameters"),	\
-	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),
+	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),	\
+	C(ARGIDX_2BIG,		"$argN index is too big"),		\
+	C(NO_PTR_STRCT,		"This is not a pointer to union/structure."),	\
+	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
+	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
+	C(NO_BTF_FIELD,		"This field is not found."),	\
+	C(BAD_BTF_TID,		"Failed to get BTF type info."),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


