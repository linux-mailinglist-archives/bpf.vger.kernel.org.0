Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9013B78A7
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 21:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhF2Tc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 15:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234180AbhF2TcZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 15:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624994997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7POGsUdxxXzK+4ImUmkSrNYlLw4tFmtrg6J6zcZB3co=;
        b=DWLp1l4kgZBpgu0BSB/NimwUp/RtXGiu7gLXLofy0OYIJKOo6On+RG3EJJhrUF/ia2PnOm
        ZoAk7gwo6cPcXGfdG7gDl+6ACQ4N6T1pTdU4owT3wQfQtQle0NrBUWT2FZGZrBJDSBjMNa
        yEF/BSwOnjF/St1knsq6lsmTkzMulyY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-_68f7rR0OqSI7AGR1uzXkA-1; Tue, 29 Jun 2021 15:29:56 -0400
X-MC-Unique: _68f7rR0OqSI7AGR1uzXkA-1
Received: by mail-ed1-f72.google.com with SMTP id n13-20020a05640206cdb029039589a2a771so479692edy.5
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 12:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7POGsUdxxXzK+4ImUmkSrNYlLw4tFmtrg6J6zcZB3co=;
        b=VlpRNY2AacTEt0W6wYA8JW1bAaVqDWE0w8kv3O8U8cIJ7l96FCCKMqcxslKsaQulGX
         GuC6MxLW73Ba4X+5/8iLRsZHbn0+VNeBEcheTuvl/xI9ewvihIR4ZfsBWZc5l5SjhKcD
         202W2QMPi/peOgI6SjPRzL+/Q0S/EUlMdjSgDyejHbsoynZFsCf+kSLXyJCOSqvCe8Qn
         C5PfQ+IpppA5nYC4cO76Kjfxs6n+ET7I3Vl2FutYmbeiRBxRcdac2l2Q1aT5yzuHWUwi
         JrEbeG1OvQiIjBliTF4uPsmtWW9HVQrxInptCJX90cliQZBkPy8SHAIHRi/fWAIHAc/f
         DKkQ==
X-Gm-Message-State: AOAM530/eyamTbmxRla51zfVRV0A8vYXphDANodfByIpNzVa3+90FEUr
        VlC+11D4KwcrBecLYPQDdesDq6mBSkhZk3YGvslMcdaBBVk2BONtvGqyJIPyUfBuqGHwtyyFT7l
        haOF6deWDUKem
X-Received: by 2002:a17:906:3d3:: with SMTP id c19mr30851640eja.202.1624994995074;
        Tue, 29 Jun 2021 12:29:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw23NIpSXqFpaqDGHPNVNZiDYiZzRVkvF/Ui1ls7XbzLlUZgCjf3IWzZlcShrGYuCb8MruN3Q==
X-Received: by 2002:a17:906:3d3:: with SMTP id c19mr30851628eja.202.1624994994878;
        Tue, 29 Jun 2021 12:29:54 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id n22sm472559eje.3.2021.06.29.12.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:29:54 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 3/5] bpf: Add bpf_get_func_ip helper for tracing programs
Date:   Tue, 29 Jun 2021 21:29:43 +0200
Message-Id: <20210629192945.1071862-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629192945.1071862-1-jolsa@kernel.org>
References: <20210629192945.1071862-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_get_func_ip helper for BPF_PROG_TYPE_TRACING programs,
specifically for all trampoline attach types.

The trampoline's caller IP address is stored in (ctx - 8) address.
so there's no reason to actually call the helper, but rather fixup
the call instruction and return [ctx - 8] value directly (suggested
by Alexei).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  7 +++++
 kernel/bpf/verifier.c          | 53 ++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       | 15 ++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++
 4 files changed, 82 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bf9252c7381e..83e87ffdbb6e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4780,6 +4780,12 @@ union bpf_attr {
  * 		Execute close syscall for given FD.
  * 	Return
  * 		A syscall result.
+ *
+ * u64 bpf_get_func_ip(void *ctx)
+ * 	Description
+ * 		Get address of the traced function (for tracing programs).
+ * 	Return
+ * 		Address of the traced function.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4951,6 +4957,7 @@ union bpf_attr {
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
 	FN(sys_close),			\
+	FN(get_func_ip),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e04e33893cff..701ff7384fa7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5149,6 +5149,11 @@ static bool allow_tail_call_in_subprogs(struct bpf_verifier_env *env)
 	return env->prog->jit_requested && IS_ENABLED(CONFIG_X86_64);
 }
 
+static bool allow_get_func_ip_tracing(struct bpf_verifier_env *env)
+{
+	return env->prog->jit_requested && IS_ENABLED(CONFIG_X86_64);
+}
+
 static int check_map_func_compatibility(struct bpf_verifier_env *env,
 					struct bpf_map *map, int func_id)
 {
@@ -5955,6 +5960,32 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	return err;
 }
 
+static bool has_get_func_ip(struct bpf_verifier_env *env)
+{
+	enum bpf_attach_type eatype = env->prog->expected_attach_type;
+	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	int func_id = BPF_FUNC_get_func_ip;
+
+	if (type == BPF_PROG_TYPE_TRACING) {
+		if (eatype != BPF_TRACE_FENTRY && eatype != BPF_TRACE_FEXIT &&
+		    eatype != BPF_MODIFY_RETURN) {
+			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
+				func_id_name(func_id), func_id);
+			return -ENOTSUPP;
+		}
+		if (!allow_get_func_ip_tracing(env)) {
+			verbose(env, "func %s#%d for tracing programs supported only for JITed x86_64\n",
+				func_id_name(func_id), func_id);
+			return -ENOTSUPP;
+		}
+		return 0;
+	}
+
+	verbose(env, "func %s#%d not supported for program type %d\n",
+		func_id_name(func_id), func_id, type);
+	return -ENOTSUPP;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -6225,6 +6256,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (func_id == BPF_FUNC_get_stackid || func_id == BPF_FUNC_get_stack)
 		env->prog->call_get_stack = true;
 
+	if (func_id == BPF_FUNC_get_func_ip) {
+		if (has_get_func_ip(env))
+			return -ENOTSUPP;
+		env->prog->call_get_func_ip = true;
+	}
+
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
@@ -12367,6 +12404,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	bool expect_blinding = bpf_jit_blinding_enabled(prog);
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 	struct bpf_insn *insn = prog->insnsi;
 	const struct bpf_func_proto *fn;
 	const int insn_cnt = prog->len;
@@ -12700,6 +12738,21 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+		/* Implement bpf_get_func_ip inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_ip) {
+			/* Load IP address from ctx - 8 */
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			if (!new_prog)
+				return -ENOMEM;
+
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
 patch_call_imm:
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 64bd2d84367f..9edd3b1a00ad 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -948,6 +948,19 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_1(bpf_get_func_ip_tracing, void *, ctx)
+{
+	/* Stub, the helper call is inlined in the program. */
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
+	.func		= bpf_get_func_ip_tracing,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1058,6 +1071,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_snprintf:
 		return &bpf_snprintf_proto;
+	case BPF_FUNC_get_func_ip:
+		return &bpf_get_func_ip_proto_tracing;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bf9252c7381e..83e87ffdbb6e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4780,6 +4780,12 @@ union bpf_attr {
  * 		Execute close syscall for given FD.
  * 	Return
  * 		A syscall result.
+ *
+ * u64 bpf_get_func_ip(void *ctx)
+ * 	Description
+ * 		Get address of the traced function (for tracing programs).
+ * 	Return
+ * 		Address of the traced function.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4951,6 +4957,7 @@ union bpf_attr {
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
 	FN(sys_close),			\
+	FN(get_func_ip),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.31.1

