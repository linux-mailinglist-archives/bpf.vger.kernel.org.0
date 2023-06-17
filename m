Return-Path: <bpf+bounces-2796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC76733FF3
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 11:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5311C2096E
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659E56FD9;
	Sat, 17 Jun 2023 09:47:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30D747B
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 09:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64846C433C0;
	Sat, 17 Jun 2023 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686995248;
	bh=vJO4M0HM7FCevR0pjwlrbpVfGQ59SezS/bPy03sX8pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyGEQgw4Q2w72iPZXh5b1bxNwyXW4JXDynPgp5zWd1ABzGpYi9g3u045HfMzERpy3
	 2h2xEsvd0jbDYSVJagz/twLhNVin8adIAlIxLubOBAJf01Tz/cQTi0RTbCImjTkRQC
	 GAQ0k69BDhz86FrmQhgCmPPjwZJ2Md/cTf/Hv57JgBu25br7YhCflm1tjsBJaBdFPr
	 sB7lT8yMIqBXt4/ELvJIMoup5ntDsyLcvnZbvhw+WI2qUbFX6rKEf+O64uHWBOLS3M
	 F/7mhU3ZOqCvVr7MAD090JsCaEEcKLE2LPZhKGfbyT1LwxyEOnjXrlceH04rGBIIO1
	 Qm1vZe1NMEKFQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH 3/5] tracing/probes: Add string type check with BTF
Date: Sat, 17 Jun 2023 18:47:25 +0900
Message-ID:  <168699524550.528797.10869028703938811455.stgit@mhiramat.roam.corp.google.com>
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

Add a string type checking with BTF information if possible.
This will check whether the given BTF argument (and field) is
signed char array or pointer to signed char. If not, it reject
the 'string' type. If it is pointer to signed char, it adds
a dereference opration so that it can correctly fetch the
string data from memory.

 # echo 'f getname_flags%return retval->name:string' >> dynamic_events
 # echo 't sched_switch next->comm:string' >> dynamic_events

The above cases, 'struct filename::name' is 'char *' and
'struct task_struct::comm' is 'char []'. But in both case,
user can specify ':string' to fetch the string data.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   89 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h |    3 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 0149d0abb5fd..85c9c939424c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -319,6 +319,77 @@ static u32 btf_type_int(const struct btf_type *t)
 	return *(u32 *)(t + 1);
 }
 
+static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
+{
+	const struct btf_type *real_type;
+	u32 intdata;
+	s32 tid;
+
+	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
+	if (!real_type)
+		return false;
+
+	if (BTF_INFO_KIND(real_type->info) != BTF_KIND_INT)
+		return false;
+
+	intdata = btf_type_int(real_type);
+	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
+		&& BTF_INT_BITS(intdata) == 8;
+}
+
+static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
+{
+	const struct btf_type *real_type;
+	const struct btf_array *array;
+	u32 intdata;
+	s32 tid;
+
+	if (BTF_INFO_KIND(type->info) != BTF_KIND_ARRAY)
+		return false;
+
+	array = (const struct btf_array *)(type + 1);
+
+	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+
+	intdata = btf_type_int(real_type);
+	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
+		&& BTF_INT_BITS(intdata) == 8;
+}
+
+static int check_prepare_btf_string_fetch(char *typename,
+				struct fetch_insn **pcode,
+				struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+
+	if (!btf || !ctx->last_type)
+		return 0;
+
+	/* char [] does not need any change. */
+	if (btf_type_is_char_array(btf, ctx->last_type))
+		return 0;
+
+	/* char * requires dereference the pointer. */
+	if (btf_type_is_char_ptr(btf, ctx->last_type)) {
+		struct fetch_insn *code = *pcode + 1;
+
+		if (code->op == FETCH_OP_END) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+			return -E2BIG;
+		}
+		if (typename[0] == 'u')
+			code->op = FETCH_OP_UDEREF;
+		else
+			code->op = FETCH_OP_DEREF;
+		code->offset = 0;
+		*pcode = code;
+		return 0;
+	}
+	/* Other types are not available for string */
+	trace_probe_log_err(ctx->offset, BAD_TYPE4STR);
+	return -EINVAL;
+}
+
 static const char *fetch_type_from_btf_type(struct btf *btf,
 					const struct btf_type *type,
 					struct traceprobe_parse_context *ctx)
@@ -720,6 +791,13 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 
 #define is_btf_retval_void(funcname)	(false)
 
+static int check_prepare_btf_string_fetch(char *typename,
+				struct fetch_insn **pcode,
+				struct traceprobe_parse_context *ctx)
+{
+	return 0;
+}
+
 #endif
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
@@ -1159,8 +1237,15 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	/* Update storing type if BTF is available */
 	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
-	    !t && ctx->last_type)
-		parg->type = find_fetch_type_from_btf_type(ctx);
+	    ctx->last_type) {
+		if (!t) {
+			parg->type = find_fetch_type_from_btf_type(ctx);
+		} else if (strstr(t, "string")) {
+			ret = check_prepare_btf_string_fetch(t, &code, ctx);
+			if (ret)
+				goto fail;
+		}
+	}
 
 	ret = -EINVAL;
 	/* Store operation */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 7aae50633819..c6da67afa62c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -511,7 +511,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
 	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
 	C(NO_BTF_FIELD,		"This field is not found."),	\
-	C(BAD_BTF_TID,		"Failed to get BTF type info."),
+	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
+	C(BAD_TYPE4STR,		"This type does not fit for string."),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


