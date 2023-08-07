Return-Path: <bpf+bounces-7118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B1771893
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0871C2096C
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59F138C;
	Mon,  7 Aug 2023 02:55:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519051388
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 02:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C84C433CC;
	Mon,  7 Aug 2023 02:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691376933;
	bh=nbJctgHoWt1eNQqxV3NpXqVI8hkS5eFFrSto2wUxsec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLg6CDNpqCyPp5VkNpDaLZ8nPaquE5ZOqUnkPfqTk1uuYaOXr5OK0kEqrYFhnkAR1
	 VHD0Uj6qkaNhALIJx7T0046QO2hW12Rw1JOWboIr5KkZRKD8KJ3cAe5FlOH54K7pEu
	 EV5UFE08w0CJoL0c7+34CM0V/00xlKyEOG7W+2kdoZNTNdmxAMM8ZkCEg4HXedNcqP
	 q9vpybnkxwgIOOPAAsvGYxoSvCfcQBJ0aMLUma5f8Qy/PAr6jGvcvkDRbaeeft82OU
	 Wqt+hZVEvSVIl/a5Z5DcMBkm+c0DUx3AjmBGVsv789u2F+kxK0x1y3TziCU5aXjGTk
	 exEZ4sjOd/k6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v5 6/9] tracing/probes: Add string type check with BTF
Date: Mon,  7 Aug 2023 11:55:28 +0900
Message-Id: <169137692859.271367.1246073860610569505.stgit@devnote2>
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
 Changes in v3:
  - Use ctx->btf instead of traceprobe_get_btf().
---
 kernel/trace/trace_probe.c |   89 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h |    3 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 7345e1af4db2..4dc74d73fc1d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -310,6 +310,77 @@ static u32 btf_type_int(const struct btf_type *t)
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
+	struct btf *btf = ctx->btf;
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
@@ -675,6 +746,13 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 #define find_fetch_type_from_btf_type(ctx)		\
 	find_fetch_type(NULL, ctx->flags)
 
+static int check_prepare_btf_string_fetch(char *typename,
+				struct fetch_insn **pcode,
+				struct traceprobe_parse_context *ctx)
+{
+	return 0;
+}
+
 #endif
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
@@ -1117,8 +1195,15 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
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
index 9184c84833f8..7f929482e8d4 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -513,7 +513,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
 	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
 	C(NO_BTF_FIELD,		"This field is not found."),	\
-	C(BAD_BTF_TID,		"Failed to get BTF type info."),
+	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
+	C(BAD_TYPE4STR,		"This type does not fit for string."),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


