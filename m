Return-Path: <bpf+bounces-66195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80506B2F7AB
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F423AC8BA
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658E1E9B08;
	Thu, 21 Aug 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/A10jQl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF53C19
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778616; cv=none; b=a/OIiCic8pPboUNTfufMoarEX254ZErVljp0BvcH/RPln8tczklBJqjrdExYcYETma94qULdRS6UGqH1kyya2xCyNI4Bl66aSjvz6imoH/1RwwL7603Cvbex71WNDVIX4xVIN28Xad+/1OvMQ2x2fmqT0sIdI/R+yldpcQC+Gh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778616; c=relaxed/simple;
	bh=JQDXMFvPcMYCXT1HO2om+5Pr2frOt1z1iQIaaWYLM4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLwX5kPB51pkqvuRbdYNhUq0jIbbOrErE2Kg9xRHVREjvxEMh0de+n/tRbrh/A/2s+Iezbb60lizjT5wnot/0zQx462NlU8N2HkM5iRQhvJ9GKSrr9SsIrbPYCBownNzMClQN+QJQvCwJkyt8n+j5GqYqUD/G0Z8gModYkDSkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/A10jQl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2460757107bso4985535ad.2
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755778614; x=1756383414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvMUEjmvT4pmoXC0sNPb0RUMTP4b3u1zXLwmgoKlvX0=;
        b=O/A10jQlOUbn/mUpgsMQUV7NuAdih2MSlfUUz9uDPyWlKVZ05S6sGMRbw/q0M/Oosm
         rjoU1mc0eXIZMI4yPhLHoaL9WGf8Y/+pWKMNBPCoNGWWpkIceqpRPZ4moWwOOObeM0fk
         lBqlzCjP7eYhGLycKY0cbRqWP5PRPEuTxf3+ZPR9qbFOakGfZ9yqlvY38zw+6Teyom3t
         /o9TBhs1El+UHJrzgiGfLycDAcH8sj5L+jcDhFcBnqoT0PeKYMDfiE1hz5vuAfdcb/SX
         1n58dliRMFKC0C4r3NeLZs8fgco+330/DIWSgVtKEIb9YE5NC64Cig9BYbBDt0WdYUkc
         FQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778614; x=1756383414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvMUEjmvT4pmoXC0sNPb0RUMTP4b3u1zXLwmgoKlvX0=;
        b=AAWcJ/iUNjiOVhh7JnEaHVOelKcuOyDjMUqBENLL7k7cwlS177K/Xwzo0pxXBvFlY0
         TucKMq5x8Dj+9lXfYjYEzjKlh8zgw/VaAtZP0tc74C1Lb+TZcsLUKkGLWHfUAvnHY7wW
         eeiA6nPEzD62gL4KWAzt3PEAQRGsj7HO2emx8n3maZ5Hit906su2rBbXc1Mg+TxdUQCC
         OR6qMbpcYkZ2fybkbneJCl5zsTsiyJkOUOI3njmCYFfhNKOiyyOATmEKDp6y2qko8MHW
         P4lLBJHEtDZ9M4yHyyfEw/N7rie3ApWVEkUPOx6V7r8nWSRRL1qhlh1dOBfxtJhAkOHE
         0xSA==
X-Gm-Message-State: AOJu0YxK7SNz52zlzaBPbdDhdbGT39dWkABN4yPN/0biqzGa6Ldyu7kN
	vI/d9doOUHB9CzctDuwHFlAlCqLT1KWXneQV9ljhuK2dkVoxL1cEpGjj
X-Gm-Gg: ASbGncsOPHIgiqfbZZYD52RjIbhTQhueInmKR53YXtNQOMq/l1h20pLD04PhIpmLaF/
	fPPZm0iH5ts0puYR3JjXSqvyyCJ0nEVE//3k091MwOwYdAU6/qpQNy3RzZuAeMwZuhToGb17XVE
	ruo58a/J7/aqnBIrh53JAny6Qp4+ROkOq+SIdKhQPFMnlE7OnoyZrmoig8DJ8XSGC3YMxdT6t/d
	KNha9bQcPghVxePi1l94xQRitqoL+ePegrciphBSCdiNdPL7hq5GPQBLH8FCVM04odXLA3Glxq0
	4iA3kxzt6RjlMMKu47Xdf4hq0Kcblut0hpeosV0HgGTMSCCQg1Pi4DccH3h8lp8tOkKCsmOy4Bl
	8RGRoSd+jn21E+6heYPe/pQPzF0nRYqCBHV5/zlTX
X-Google-Smtp-Source: AGHT+IGsRutbFNcD/vVxMYnjXNXxntsxG1mdq1WK7tx+U95NZ1J3jn+Zp8lIho27pPyXCgcn8S9XUw==
X-Received: by 2002:a17:903:3c6f:b0:234:d292:be95 with SMTP id d9443c01a7336-245fedd1f8cmr27545915ad.42.1755778614176;
        Thu, 21 Aug 2025 05:16:54 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2c48337sm1745442a91.25.2025.08.21.05.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:16:53 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH 2/3] LoongArch: BPF: Sign extend struct ops return values properly
Date: Thu, 21 Aug 2025 09:10:02 +0000
Message-ID: <20250821091003.404870-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821091003.404870-1-hengqi.chen@gmail.com>
References: <20250821091003.404870-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ns_bpf_qdisc selftest triggers a kernel panic:

    CPU 0 Unable to handle kernel paging request at virtual address 0000000000741d58, era == 90000000851b5ac0, ra == 90000000851b5aa4
    Oops[#1]:
    CPU: 0 UID: 0 PID: 449 Comm: test_progs Tainted: G           OE       6.16.0+ #3 PREEMPT(full)
    Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
    Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
    pc 90000000851b5ac0 ra 90000000851b5aa4 tp 90000001076b8000 sp 90000001076bb600
    a0 0000000000741ce8 a1 0000000000000001 a2 90000001076bb5c0 a3 0000000000000008
    a4 90000001004c4620 a5 9000000100741ce8 a6 0000000000000000 a7 0100000000000000
    t0 0000000000000010 t1 0000000000000000 t2 9000000104d24d30 t3 0000000000000001
    t4 4f2317da8a7e08c4 t5 fffffefffc002f00 t6 90000001004c4620 t7 ffffffffc61c5b3d
    t8 0000000000000000 u0 0000000000000001 s9 0000000000000050 s0 90000001075bc800
    s1 0000000000000040 s2 900000010597c400 s3 0000000000000008 s4 90000001075bc880
    s5 90000001075bc8f0 s6 0000000000000000 s7 0000000000741ce8 s8 0000000000000000
       ra: 90000000851b5aa4 __qdisc_run+0xac/0x8d8
      ERA: 90000000851b5ac0 __qdisc_run+0xc8/0x8d8
     CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
     PRMD: 00000004 (PPLV0 +PIE -PWE)
     EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
     ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
    ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
     BADV: 0000000000741d58
     PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
    Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
    Process test_progs (pid: 449, threadinfo=000000009af02b3a, task=00000000e9ba4956)
    Stack : 0000000000000000 90000001075bc8ac 90000000869524a8 9000000100741ce8
            90000001075bc800 9000000100415300 90000001075bc8ac 0000000000000000
            900000010597c400 900000008694a000 0000000000000000 9000000105b59000
            90000001075bc800 9000000100741ce8 0000000000000050 900000008513000c
            9000000086936000 0000000100094d4c fffffff400676208 0000000000000000
            9000000105b59000 900000008694a000 9000000086bf0dc0 9000000105b59000
            9000000086bf0d68 9000000085147010 90000001075be788 0000000000000000
            9000000086bf0f98 0000000000000001 0000000000000010 9000000006015840
            0000000000000000 9000000086be6c40 0000000000000000 0000000000000000
            0000000000000000 4f2317da8a7e08c4 0000000000000101 4f2317da8a7e08c4
            ...
    Call Trace:
    [<90000000851b5ac0>] __qdisc_run+0xc8/0x8d8
    [<9000000085130008>] __dev_queue_xmit+0x578/0x10f0
    [<90000000853701c0>] ip6_finish_output2+0x2f0/0x950
    [<9000000085374bc8>] ip6_finish_output+0x2b8/0x448
    [<9000000085370b24>] ip6_xmit+0x304/0x858
    [<90000000853c4438>] inet6_csk_xmit+0x100/0x170
    [<90000000852b32f0>] __tcp_transmit_skb+0x490/0xdd0
    [<90000000852b47fc>] tcp_connect+0xbcc/0x1168
    [<90000000853b9088>] tcp_v6_connect+0x580/0x8a0
    [<90000000852e7738>] __inet_stream_connect+0x170/0x480
    [<90000000852e7a98>] inet_stream_connect+0x50/0x88
    [<90000000850f2814>] __sys_connect+0xe4/0x110
    [<90000000850f2858>] sys_connect+0x18/0x28
    [<9000000085520c94>] do_syscall+0x94/0x1a0
    [<9000000083df1fb8>] handle_syscall+0xb8/0x158

    Code: 4001ad80  2400873f  2400832d <240073cc> 001137ff  001133ff  6407b41f  001503cc  0280041d

    ---[ end trace 0000000000000000 ]---

The bpf_fifo_dequeue prog returns a skb which is a pointer.
The pointer is treated as a 32bit value and sign extend to
64bit in epilogue. This behavior is right for most bpf prog
types but wrong for struct ops which requires LoongArch ABI.

So let's sign extend struct ops return values according to
the return value spec in function model.

Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for trampoline")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 45 ++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index b646c6b73014..6754e5231ece 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1361,7 +1361,8 @@ static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
 }
 
 static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
-			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
+			   const struct btf_func_model *m, int args_off,
+			   int retval_off, int run_ctx_off, bool save_ret)
 {
 	int ret;
 	u32 *branch;
@@ -1425,13 +1426,14 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 }
 
 static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
-			       int args_off, int retval_off, int run_ctx_off, u32 **branches)
+			       const struct btf_func_model *m, int args_off,
+			       int retval_off, int run_ctx_off, u32 **branches)
 {
 	int i;
 
 	emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval_off);
 	for (i = 0; i < tl->nr_links; i++) {
-		invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off, run_ctx_off, true);
+		invoke_bpf_prog(ctx, tl->links[i], m, args_off, retval_off, run_ctx_off, true);
 		emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -retval_off);
 		branches[i] = (u32 *)ctx->image + ctx->idx;
 		emit_insn(ctx, nop);
@@ -1448,6 +1450,28 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static int sign_extend(struct jit_ctx *ctx, int r, u8 size)
+{
+	switch (size) {
+	case 1:
+		emit_insn(ctx, extwb, r, r);
+		return 0;
+	case 2:
+		emit_insn(ctx, extwh, r, r);
+		return 0;
+	case 4:
+		emit_insn(ctx, addiw, r, r, 0);
+		return 0;
+	case 8:
+		return 0;
+	default:
+		return -1;
+	}
+}
+
 static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 					 const struct btf_func_model *m, struct bpf_tramp_links *tlinks,
 					 void *func_addr, u32 flags)
@@ -1599,8 +1623,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	for (i = 0; i < fentry->nr_links; i++) {
-		ret = invoke_bpf_prog(ctx, fentry->links[i], args_off, retval_off,
-				      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
+		ret = invoke_bpf_prog(ctx, fentry->links[i], m, args_off, retval_off,
+			      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
 		if (ret)
 			return ret;
 	}
@@ -1609,7 +1633,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		if (!branches)
 			return -ENOMEM;
 
-		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off, run_ctx_off, branches);
+		invoke_bpf_mod_ret(ctx, fmod_ret, m, args_off, retval_off, run_ctx_off, branches);
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -1635,7 +1659,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	for (i = 0; i < fexit->nr_links; i++) {
-		ret = invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off, run_ctx_off, false);
+		ret = invoke_bpf_prog(ctx, fexit->links[i], m, args_off,
+				      retval_off, run_ctx_off, false);
 		if (ret)
 			goto out;
 	}
@@ -1654,6 +1679,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	if (save_ret) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
 		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
+		if (is_struct_ops) {
+			move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
+			ret = sign_extend(ctx, LOONGARCH_GPR_A0, m->ret_size);
+			if (ret)
+				goto out;
+		}
 	}
 
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
-- 
2.43.5



