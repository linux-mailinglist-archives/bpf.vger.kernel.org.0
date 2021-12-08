Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0446DC4E
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhLHTgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 14:36:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235700AbhLHTgt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 14:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638991997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cx+yJegDwBpl3wViaAwchRadzEEW+mjKNeRXewrtknw=;
        b=VRhdV6lyaSngzUNIbcVKkeo8lrvC0WAH0G3Ky73q1uO5MhIXaSwkw5+949W2ANQ9ce6kHa
        un/54juNe0q2j73kd1/dLcab0xX4HMUzJTpXNYh1VYHIpxGGCsCQq1KEXA4RlqCHmMi+xi
        mDc2bb0DnbtrEROLHqxmWGPLVnPCphU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-VEVFGJcuPtOicihGo73T7g-1; Wed, 08 Dec 2021 14:33:16 -0500
X-MC-Unique: VEVFGJcuPtOicihGo73T7g-1
Received: by mail-wm1-f69.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso1797423wmc.5
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 11:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx+yJegDwBpl3wViaAwchRadzEEW+mjKNeRXewrtknw=;
        b=lWoneMSMtfJUMtwUa6LIWFjaxCk0uHLlG6sHtmLPvZcDkmXh0jPP1vIFhA/vJ/8O/5
         atg68vB8sx2ZqpJ/sN9xZ3opgxyBDpok4prGnKUF+oPL53ZUv/teD2bJa6lPDebLLYl8
         2MjhkTvqaPNgjo1/W/WCDAZd9fsDlS2/FVGHRn/JTzyj6we6VvZl38xG1Czu0OurSjxI
         3QlgGYH+/Z7WhLLf0/1SypLhIFS5KJG5cxo5iR90TJRjmJZuQxADp5omny2fHoCe9vVu
         LzayRWd4tGL5cmcSRXTJMiS+9CfciIOjuHe271+1RCn9gyORAEQxjNGWh6Hj6YX4Z+0G
         XmAQ==
X-Gm-Message-State: AOAM533lA1x1YCKs4Mnn+a0HvDNDFcN+Y3yIw4RsK/So/u08DB+M9L/u
        +Wn3w3wZ1NUtaVl4Qn372fwRTjyArgjI2xUOxgBgoTELt8bI4U/eHRcO+1mk2NRQMNnc7Sv4YlC
        TmWmvbI4ClwhX
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr801070wmj.156.1638991993581;
        Wed, 08 Dec 2021 11:33:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8usV0Hd60k0Y7roHTPIVqwnqOVMdjvbtgdAwkwNnfwRT2BwSZqrgGEllZPbFEuVznf2Yk2A==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr801014wmj.156.1638991993208;
        Wed, 08 Dec 2021 11:33:13 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m7sm3468611wml.38.2021.12.08.11.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:33:12 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCHv2 bpf-next 4/5] bpf: Add get_func_[arg|ret|arg_cnt] helpers
Date:   Wed,  8 Dec 2021 20:32:44 +0100
Message-Id: <20211208193245.172141-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208193245.172141-1-jolsa@kernel.org>
References: <20211208193245.172141-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding following helpers for tracing programs:

Get n-th argument of the traced function:
  long bpf_get_func_arg(void *ctx, u32 n, u64 *value)

Get return value of the traced function:
  long bpf_get_func_ret(void *ctx, u64 *value)

Get arguments count of the traced function:
  long bpf_get_func_arg_cnt(void *ctx)

The trampoline now stores number of arguments on ctx-8
address, so it's easy to verify argument index and find
return value argument's position.

Moving function ip address on the trampoline stack behind
the number of functions arguments, so it's now stored on
ctx-16 address if it's needed.

All helpers above are inlined by verifier.

Also bit unrelated small change - using newly added function
bpf_prog_has_trampoline in check_get_func_ip.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c    | 15 ++++++-
 include/linux/bpf.h            |  5 +++
 include/uapi/linux/bpf.h       | 28 +++++++++++++
 kernel/bpf/trampoline.c        |  8 ++++
 kernel/bpf/verifier.c          | 77 +++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c       | 55 +++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++
 7 files changed, 209 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 10fab8cb3fb5..4bbcded07415 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1941,7 +1941,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				void *orig_call)
 {
 	int ret, i, nr_args = m->nr_args;
-	int regs_off, ip_off, stack_size = nr_args * 8;
+	int regs_off, ip_off, args_off, stack_size = nr_args * 8;
 	struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
@@ -1968,6 +1968,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *                 [ ...             ]
 	 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
 	 *
+	 * RBP - args_off  [ args count      ]  always
+	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 */
 
@@ -1978,6 +1980,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
 	regs_off = stack_size;
 
+	/* args count  */
+	stack_size += 8;
+	args_off = stack_size;
+
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8; /* room for IP address argument */
 
@@ -1996,6 +2002,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
 	EMIT1(0x53);		 /* push rbx */
 
+	/* Store number of arguments of the traced function:
+	 *   mov rax, nr_args
+	 *   mov QWORD PTR [rbp - args_off], rax
+	 */
+	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -args_off);
+
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
 		 * mov rax, QWORD PTR [rbp + 8]
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8bbf08fbab66..cb76f9fb638d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -776,6 +776,7 @@ void bpf_ksym_add(struct bpf_ksym *ksym);
 void bpf_ksym_del(struct bpf_ksym *ksym);
 int bpf_jit_charge_modmem(u32 pages);
 void bpf_jit_uncharge_modmem(u32 pages);
+bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 #else
 static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
 					   struct bpf_trampoline *tr)
@@ -804,6 +805,10 @@ static inline bool is_bpf_image_address(unsigned long address)
 {
 	return false;
 }
+static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
+{
+	return false;
+}
 #endif
 
 struct bpf_func_info_aux {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c26871263f1f..1999713354db 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4983,6 +4983,31 @@ union bpf_attr {
  *	Return
  *		The number of loops performed, **-EINVAL** for invalid **flags**,
  *		**-E2BIG** if **nr_loops** exceeds the maximum number of loops.
+ *
+ * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
+ *	Description
+ *		Get **n**-th argument (zero based) of the traced function (for tracing programs)
+ *		returned in **value**.
+ *
+ *	Return
+ *		0 on success.
+ *		**-EINVAL** if n >= arguments count of traced function.
+ *
+ * long bpf_get_func_ret(void *ctx, u64 *value)
+ *	Description
+ *		Get return value of the traced function (for tracing programs)
+ *		in **value**.
+ *
+ *	Return
+ *		0 on success.
+ *		**-EOPNOTSUPP** for tracing programs other than BPF_TRACE_FEXIT or BPF_MODIFY_RETURN.
+ *
+ * long bpf_get_func_arg_cnt(void *ctx)
+ *	Description
+ *		Get number of arguments of the traced function (for tracing programs).
+ *
+ *	Return
+ *		The number of arguments of the traced function.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5167,6 +5192,9 @@ union bpf_attr {
 	FN(kallsyms_lookup_name),	\
 	FN(find_vma),			\
 	FN(loop),			\
+	FN(get_func_arg),		\
+	FN(get_func_ret),		\
+	FN(get_func_arg_cnt),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e98de5e73ba5..4b6974a195c1 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -27,6 +27,14 @@ static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline_table */
 static DEFINE_MUTEX(trampoline_mutex);
 
+bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
+{
+	enum bpf_attach_type eatype = prog->expected_attach_type;
+
+	return eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
+	       eatype == BPF_MODIFY_RETURN;
+}
+
 void *bpf_jit_alloc_exec_page(void)
 {
 	void *image;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1126b75fe650..5488d8a290a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6379,13 +6379,11 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 
 static int check_get_func_ip(struct bpf_verifier_env *env)
 {
-	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 	int func_id = BPF_FUNC_get_func_ip;
 
 	if (type == BPF_PROG_TYPE_TRACING) {
-		if (eatype != BPF_TRACE_FENTRY && eatype != BPF_TRACE_FEXIT &&
-		    eatype != BPF_MODIFY_RETURN) {
+		if (!bpf_prog_has_trampoline(env->prog)) {
 			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
 				func_id_name(func_id), func_id);
 			return -ENOTSUPP;
@@ -12974,6 +12972,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
 static int do_misc_fixups(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
+	enum bpf_attach_type eatype = prog->expected_attach_type;
 	bool expect_blinding = bpf_jit_blinding_enabled(prog);
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 	struct bpf_insn *insn = prog->insnsi;
@@ -13344,11 +13343,79 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+		/* Implement bpf_get_func_arg inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_arg) {
+			/* Load nr_args from ctx - 8 */
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
+			insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
+			insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[7] = BPF_JMP_A(1);
+			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+			cnt = 9;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
+		/* Implement bpf_get_func_ret inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_ret) {
+			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_MODIFY_RETURN) {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+				insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+				insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+				insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
+				insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
+				cnt = 6;
+			} else {
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
+				cnt = 1;
+			}
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
+		/* Implement get_func_arg_cnt inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
+			/* Load nr_args from ctx - 8 */
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
 		/* Implement bpf_get_func_ip inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ip) {
-			/* Load IP address from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			/* Load IP address from ctx - 16 */
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 			if (!new_prog)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 77f13de6f9f9..ab4139eec076 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1012,7 +1012,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 BPF_CALL_1(bpf_get_func_ip_tracing, void *, ctx)
 {
 	/* This helper call is inlined by verifier. */
-	return ((u64 *)ctx)[-1];
+	return ((u64 *)ctx)[-2];
 }
 
 static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
@@ -1091,6 +1091,53 @@ static const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
+{
+	/* This helper call is inlined by verifier. */
+	u64 nr_args = ((u64 *)ctx)[-1];
+
+	if ((u64) n >= nr_args)
+		return -EINVAL;
+	*value = ((u64 *)ctx)[n];
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_get_func_arg_proto = {
+	.func		= get_func_arg,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_LONG,
+};
+
+BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
+{
+	/* This helper call is inlined by verifier. */
+	u64 nr_args = ((u64 *)ctx)[-1];
+
+	*value = ((u64 *)ctx)[nr_args];
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_get_func_ret_proto = {
+	.func		= get_func_ret,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_LONG,
+};
+
+BPF_CALL_1(get_func_arg_cnt, void *, ctx)
+{
+	/* This helper call is inlined by verifier. */
+	return ((u64 *)ctx)[-1];
+}
+
+static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
+	.func		= get_func_arg_cnt,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1631,6 +1678,12 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		       NULL;
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
+	case BPF_FUNC_get_func_arg:
+		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
+	case BPF_FUNC_get_func_ret:
+		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
+	case BPF_FUNC_get_func_arg_cnt:
+		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
 	default:
 		fn = raw_tp_prog_func_proto(func_id, prog);
 		if (!fn && prog->expected_attach_type == BPF_TRACE_ITER)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c26871263f1f..1999713354db 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4983,6 +4983,31 @@ union bpf_attr {
  *	Return
  *		The number of loops performed, **-EINVAL** for invalid **flags**,
  *		**-E2BIG** if **nr_loops** exceeds the maximum number of loops.
+ *
+ * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
+ *	Description
+ *		Get **n**-th argument (zero based) of the traced function (for tracing programs)
+ *		returned in **value**.
+ *
+ *	Return
+ *		0 on success.
+ *		**-EINVAL** if n >= arguments count of traced function.
+ *
+ * long bpf_get_func_ret(void *ctx, u64 *value)
+ *	Description
+ *		Get return value of the traced function (for tracing programs)
+ *		in **value**.
+ *
+ *	Return
+ *		0 on success.
+ *		**-EOPNOTSUPP** for tracing programs other than BPF_TRACE_FEXIT or BPF_MODIFY_RETURN.
+ *
+ * long bpf_get_func_arg_cnt(void *ctx)
+ *	Description
+ *		Get number of arguments of the traced function (for tracing programs).
+ *
+ *	Return
+ *		The number of arguments of the traced function.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5167,6 +5192,9 @@ union bpf_attr {
 	FN(kallsyms_lookup_name),	\
 	FN(find_vma),			\
 	FN(loop),			\
+	FN(get_func_arg),		\
+	FN(get_func_ret),		\
+	FN(get_func_arg_cnt),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.33.1

