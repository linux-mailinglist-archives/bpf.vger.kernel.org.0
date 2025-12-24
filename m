Return-Path: <bpf+bounces-77410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2BCCDC53B
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A3730BC2E4
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5AB33BBC5;
	Wed, 24 Dec 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwxUOFgU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3633B974
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581714; cv=none; b=U5OxnaygllBuGVGtE5YP+b+yVmjU10BSvEyDiljeDzpYZ5gTbIOtGfvNVwXcAqki7K8Ce5x4LTUAtMwVS32UxmxSm7PhSoLbkbOD3fCUqEJ0DNUtp/NNM/XWf66IRLRCzFxgY14LbtVv+ekDI9xd6KLfFWeJ2PRewgIir4FP/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581714; c=relaxed/simple;
	bh=OmpxSP1U88Co5VJkwTXEd6T5INcF4x1eikGmMC2/2wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1Ty1aGhik6cJlyOA8De03KEKJNhn8BTxooTadZi6UXhB4JHRQVQFyleJWjLljiXIfAE1KbWV9iC0G6ZDbAW7CUh/DmcIfXjvjcq3e1a2sQ5Hcp3cE+n012Y5DcRWIKg5g6GD+wZ2uXwsLu3CHEk2aVTF1D6ZW6yE56E2uBVUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwxUOFgU; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so4764302a91.1
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581712; x=1767186512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in+O3L4XwQY73b2AFr/2ULZjn29Dh1Oq68SSaU7L1pA=;
        b=EwxUOFgUdI5fW5GFVpMEz+HP8YHljIWVQJyrOWpp6k+tK5rt4oZwqxuIFQ8agT1mcB
         etbkSCDsJEOSR4VV0f2knkIzsdms3fkCm/rXK2cX/JQ1X8LPLeQfOjnq1W4VzmCstN7D
         /1Lk1uvxi4hS1u6ds53IFhf5UUAgesTl7Im4cLq9QMWSeb+QfrMBAK4CZisLlzXnrBat
         +eI8Rgt/RWvrNlY6LoCf1RJiM1vADl7HZ9xulFn8AD8SIOVsWVc9DyPshayoPVQqhTSK
         w3RpDhcus+K0+oUjSsswFgYcq9jflodLFK8C4FbAhHt0uzDDZbfw2ZQgZ/VSLtKAaI20
         Tp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581712; x=1767186512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=in+O3L4XwQY73b2AFr/2ULZjn29Dh1Oq68SSaU7L1pA=;
        b=h9WMf5uwl2LH9Yt7EBUsZl2y8np5qnUwLN4obZ2irQkI4Qk86wFSbaWaFtCLnTGml+
         A9V0UIkUKc6UFcw6DKExM1Zjmd/uIGriP4sGbYFIrH+UzKioXAqjiKXGa0eIQuGei7yC
         0UAsG0v7CuJ54WLQssUpzEKmODjbClCrv93aFO7mM7lDCW8en+ub0h/7Af7QzCXe2i1A
         /LHPHDkqxw98/W1HEyZbQ62pGEO467jx8Ay9q1w4+Z4biles1MUd7VcbVUuC5lmS8bn5
         hI15NIQb8RBxLqsREDG3nXE6l52hQ4/2TbsIW6WU/ZRTvjMKnoBXGzQ/4ZHO9GG6FA8j
         ie2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnksd3I4pp/iOkuTy+g+7TYphMkhIPEryNSOGoMTEf5wh/fs7atwZReZbheQ39w7HP3k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBsToiRa6DNsLsa7c+WPtEELacB6i/UbCG6CzeD82ljCU4nJp
	j62/aryxgvfGvxCI3Rg4g0ZRo3RVYCG4xFqV7vpfpmEBS6etxR++iKgS
X-Gm-Gg: AY/fxX7fDsh1CmOJsLyzGNzcyKYuXASXsnIuXj+sztLjiCziYiRTxJ9li4yToTgtwXo
	XMcyFQIo+lWsqcZIAXUBdwOo1SPxp/zX0heAs8xgm7A9YYREv+BZa5q3cg6EgreQY88Fw37ntp5
	MwsMAWp0soqGxGzLKLeovbEQ+B84/E2vRCGvg1TnMNSQuZDbx/vw9+K2bJZpkvsqNB517LcIAqQ
	MzlAw9pFA6jdPTqL05ANjfkPvuA1t+XgdxMFLNLkWgRVrpgx04RrZ5xjiWOflFi4HGkgjv/fgtV
	/VFaZv1zYMhz1jpJ2iEEqy1+P+NZ50mgtrMY7qA4FtqWu30f678VA0fNzBAuCBvYUyR45COu0XS
	Anq4JrwJylI+T1TgMWY1e/y89Lu6h0KgAs9oXztRVE6Hp6lAEd/DdnqFcmxxSvzn+UBeKQFCVKq
	IZf0cyezA=
X-Google-Smtp-Source: AGHT+IHsooDeoyyjHMV5oyHx0AmBp/Pzmm0oz9vs6l5WB68tOVKfc4IFwKrEI/dk8CS++6ElsKvHPw==
X-Received: by 2002:a17:90b:134d:b0:34c:aba2:dd95 with SMTP id 98e67ed59e1d1-34e921c700emr16409572a91.26.1766581711860;
        Wed, 24 Dec 2025 05:08:31 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:08:31 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 03/10] bpf: add the kfunc bpf_fsession_is_return
Date: Wed, 24 Dec 2025 21:07:28 +0800
Message-ID: <20251224130735.201422-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
ctx[-1] to store the "is_return" flag.

Introduce the kfunc bpf_fsession_is_return(), which is used to tell if it
is fexit currently. Meanwhile, inline it in the verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v4:
- split out the bpf_fsession_cookie() to another patch

v3:
- merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
  patch

v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/verifier.c    | 11 +++++++++-
 kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 63e1bc29485e..dc6b4109f0bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1213,6 +1213,9 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_M_NR_ARGS	0
+#define BPF_TRAMP_M_IS_RETURN	8
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a99e286a504d..8a5787e6ab0b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12380,6 +12380,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal_impl,
 	KF_bpf_task_work_schedule_resume_impl,
+	KF_bpf_fsession_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12454,6 +12455,7 @@ BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
+BTF_ID(func, bpf_fsession_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12508,7 +12510,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -22556,6 +22559,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_fsession_is_return]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 10c9992d2745..8a94a507bd51 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_fsession_is_return(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_fsession_is_return, KF_FASTCALL)
+BTF_KFUNCS_END(tracing_kfunc_set_ids)
+
+static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	if (!btf_id_set8_contains(&tracing_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_TRACING ||
+	    prog->expected_attach_type != BPF_TRACE_FSESSION)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &tracing_kfunc_set_ids,
+	.filter = bpf_tracing_filter,
+};
+
+static int __init bpf_trace_kfuncs_init(void)
+{
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_tracing_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.52.0


