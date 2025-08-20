Return-Path: <bpf+bounces-66079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0803B2DC11
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 14:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE804A01554
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7A2E7165;
	Wed, 20 Aug 2025 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Flaz5c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A121507F
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691576; cv=none; b=GvCKKJRwZafXgwJItYGqVym35JWhIPKLrX9mCLCeW17/+A6WrcRXU5uhn19CjoeK93L+ABJN5Lrf8Ol63kkhJKuIOcnzrN9x963yYI+xktd9VcCgCh8l0U6SwLENmJ4aBRLjEfs3AXqYt4RAtQCrFsKOcnkdpbkRrd6q/O+9DRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691576; c=relaxed/simple;
	bh=O6ai/fx4wQl5BDBuPEYlVMZTT+qbL9xmTYvF7l31v9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJnXDTWUY9zyEbmom4D836EG+nqrkddZCSKlBvBiJfnZnRlHHP7jvokQzBrk6PJy2R+Ts7Cn0qEE2T90Rp5oXDShKntIfEtzvvF7CxtiokNQGu/1UCl/IEy2LE/G/EKcHQdKchhFdD+NEv5wVLVQWzDvP+6Em8Uzvd+5b3LrILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Flaz5c; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326de9f4eso5452509a91.2
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755691574; x=1756296374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2i3tAyKE9jE1j2KIYTj9vxEXRS2G/2vf0yN8gaJWpY=;
        b=A4Flaz5c25ojdfMhs1r+u2Hze1JIsKdGeRokSQHpfu6pmFbvEZAnZyoy1XVwqYCqFZ
         4P2n5uiBUMHuzVmhVJz0egQtIuF9lRJPHZZ9+NMUmaO+77PdC0ZSeLzYyU/fVrF46H+t
         rbwbXUz2vuI0K/MBJDMRu5Ds7MyVYWSmP5pgk9pTcbAcLGmPz9il+HdC+DPDf70n91Qg
         fEVoyHtmhUeNSVs3Y6kDeJX6uE57RjM1wnPd+0Qqr9TZoO6b7S7ZSwIEvNcc5nRC4bly
         JF1qt0motGORtCc76btFh5Iq9ebIxqyEgn8hSyxxQzcfc4jKRSob8ZWuPWlxhMihHbYq
         U0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755691574; x=1756296374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2i3tAyKE9jE1j2KIYTj9vxEXRS2G/2vf0yN8gaJWpY=;
        b=d/cLqUwvnBiw8UYqi67fLKeQM8muq1JYDpbHNydtOluZIMkK3RVaKbiTs1Go9LArZi
         Z2EmNvOzhFAcECKaa+BG+Xdep2+1SPryZ+NECHzNPEcqNvhIKILb8yKRKMx8tMntYf2l
         +qGnRVBd34sV7vCwHu8NpW8QACaggRnfNRLPmDJM2V0C2YW4hqehARPrimERHeO7Hm0d
         g1zF632cpaowKJOdwA3/p/7S2b3Ki7zCDDeR7mU0fJc4b01pjOV8o6Mh7ZPjwe4jnpNF
         VtGaBnKGV4tcgfNk1fGVw+NoGjBKAHfW3nXxx5pgC8/GvX8bS5WOcehtm5NktXNO400O
         UEAA==
X-Gm-Message-State: AOJu0Yz9AtaeTKReZIPygtg5h75yfffJCD0oIHnPWsGRBHZvMdcC3wCk
	y80/yNn7D7SWbqV1YViKZftqN30ik+ilwAd/Qfc+zvnrVbls75RQkHjj
X-Gm-Gg: ASbGncuLuTY1hJSPA+O5aDZOb21Z9OHGv9yetQD0RV/eAPQef5+u77IiKFlJ6XibDe2
	7HHvMPhOcEoa/akgJcusUnyrPzltjkldF7gd1pqOswSZcmr3HJdLmt/YDaRq1SL/FUpn4zNMPEZ
	JpCXdDZo/5lprIxMUTeNsUMPEc32GeWkIePstFgBYVZ5ocPrzuRsDw2Zxf/3VTlMscuET/afRPc
	dtFPfMn+tVk0xsDfCXVZqmWcxxmsLYEVDFLJVSDWqu95PdMgwxoXGVHicZdKngXLo7KXNFDdf44
	3EwKSfO9abEFE5t9EffxGJY2gG9zT/UsvLzzx5LY3EaIP9QQUrddq8q+jzZNPpDiv4TKsZa+s3w
	8cqeW3BZHJsh69SMwvSWQEMpRMuMfJyshpFTRecgV
X-Google-Smtp-Source: AGHT+IFFO41Ewu0qXcpl3C5a1UHXMWGJWLOk/xmuv5VLCpKt/PIG39Z2vJZOoSO1MfJj37642tBkXQ==
X-Received: by 2002:a17:90b:4a03:b0:311:9c9a:58ca with SMTP id 98e67ed59e1d1-324e12e4b38mr3406763a91.8.1755691573461;
        Wed, 20 Aug 2025 05:06:13 -0700 (PDT)
Received: from devbox.. ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3244235e3edsm2271919a91.3.2025.08.20.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:06:13 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	jianghaoran@kylinos.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH] LoongArch: BPF: Sign extend struct ops return values properly
Date: Wed, 20 Aug 2025 10:39:56 +0000
Message-ID: <20250820103956.394955-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ns_bpf_qdisc selftest triggers a kernel panic:

    [ 2738.595309] CPU 0 Unable to handle kernel paging request at virtual address 0000000000741d58, era == 90000000851b5ac0, ra == 90000000851b5aa4
    [ 2738.596716] Oops[#1]:
    [ 2738.596980] CPU: 0 UID: 0 PID: 449 Comm: test_progs Tainted: G           OE       6.16.0+ #3 PREEMPT(full)
    [ 2738.597184] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
    [ 2738.597265] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
    [ 2738.597386] pc 90000000851b5ac0 ra 90000000851b5aa4 tp 90000001076b8000 sp 90000001076bb600
    [ 2738.597484] a0 0000000000741ce8 a1 0000000000000001 a2 90000001076bb5c0 a3 0000000000000008
    [ 2738.597577] a4 90000001004c4620 a5 9000000100741ce8 a6 0000000000000000 a7 0100000000000000
    [ 2738.597682] t0 0000000000000010 t1 0000000000000000 t2 9000000104d24d30 t3 0000000000000001
    [ 2738.597835] t4 4f2317da8a7e08c4 t5 fffffefffc002f00 t6 90000001004c4620 t7 ffffffffc61c5b3d
    [ 2738.597997] t8 0000000000000000 u0 0000000000000001 s9 0000000000000050 s0 90000001075bc800
    [ 2738.598097] s1 0000000000000040 s2 900000010597c400 s3 0000000000000008 s4 90000001075bc880
    [ 2738.598196] s5 90000001075bc8f0 s6 0000000000000000 s7 0000000000741ce8 s8 0000000000000000
    [ 2738.598313]    ra: 90000000851b5aa4 __qdisc_run+0xac/0x8d8
    [ 2738.598553]   ERA: 90000000851b5ac0 __qdisc_run+0xc8/0x8d8
    [ 2738.598629]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
    [ 2738.598991]  PRMD: 00000004 (PPLV0 +PIE -PWE)
    [ 2738.599065]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
    [ 2738.599160]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
    [ 2738.599278] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
    [ 2738.599364]  BADV: 0000000000741d58
    [ 2738.599429]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
    [ 2738.599513] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
    [ 2738.599724] Process test_progs (pid: 449, threadinfo=000000009af02b3a, task=00000000e9ba4956)
    [ 2738.599916] Stack : 0000000000000000 90000001075bc8ac 90000000869524a8 9000000100741ce8
    [ 2738.600065]         90000001075bc800 9000000100415300 90000001075bc8ac 0000000000000000
    [ 2738.600170]         900000010597c400 900000008694a000 0000000000000000 9000000105b59000
    [ 2738.600278]         90000001075bc800 9000000100741ce8 0000000000000050 900000008513000c
    [ 2738.600381]         9000000086936000 0000000100094d4c fffffff400676208 0000000000000000
    [ 2738.600482]         9000000105b59000 900000008694a000 9000000086bf0dc0 9000000105b59000
    [ 2738.600585]         9000000086bf0d68 9000000085147010 90000001075be788 0000000000000000
    [ 2738.600690]         9000000086bf0f98 0000000000000001 0000000000000010 9000000006015840
    [ 2738.600795]         0000000000000000 9000000086be6c40 0000000000000000 0000000000000000
    [ 2738.600901]         0000000000000000 4f2317da8a7e08c4 0000000000000101 4f2317da8a7e08c4
    [ 2738.601007]         ...
    [ 2738.601062] Call Trace:
    [ 2738.601135] [<90000000851b5ac0>] __qdisc_run+0xc8/0x8d8
    [ 2738.601396] [<9000000085130008>] __dev_queue_xmit+0x578/0x10f0
    [ 2738.601482] [<90000000853701c0>] ip6_finish_output2+0x2f0/0x950
    [ 2738.601568] [<9000000085374bc8>] ip6_finish_output+0x2b8/0x448
    [ 2738.601646] [<9000000085370b24>] ip6_xmit+0x304/0x858
    [ 2738.601711] [<90000000853c4438>] inet6_csk_xmit+0x100/0x170
    [ 2738.601784] [<90000000852b32f0>] __tcp_transmit_skb+0x490/0xdd0
    [ 2738.601863] [<90000000852b47fc>] tcp_connect+0xbcc/0x1168
    [ 2738.601934] [<90000000853b9088>] tcp_v6_connect+0x580/0x8a0
    [ 2738.602019] [<90000000852e7738>] __inet_stream_connect+0x170/0x480
    [ 2738.602103] [<90000000852e7a98>] inet_stream_connect+0x50/0x88
    [ 2738.602175] [<90000000850f2814>] __sys_connect+0xe4/0x110
    [ 2738.602244] [<90000000850f2858>] sys_connect+0x18/0x28
    [ 2738.602320] [<9000000085520c94>] do_syscall+0x94/0x1a0
    [ 2738.602399] [<9000000083df1fb8>] handle_syscall+0xb8/0x158
    [ 2738.602502]
    [ 2738.602546] Code: 4001ad80  2400873f  2400832d <240073cc> 001137ff  001133ff  6407b41f  001503cc  0280041d
    [ 2738.602724]
    [ 2738.602916] ---[ end trace 0000000000000000 ]---
    [ 2738.603210] Kernel panic - not syncing: Fatal exception in interrupt
    [ 2738.603548] Kernel relocated by 0x83bb0000
    [ 2738.603622]  .text @ 0x9000000083db0000
    [ 2738.603699]  .data @ 0x9000000085690000
    [ 2738.603753]  .bss  @ 0x9000000087491e00
    [ 2738.603900] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

The bpf_fifo_dequeue prog returns a skb which is a pointer.
The pointer is treated as a 32bit value and sign extend to
64bit in epilogue. This behavior is right for most bpf prog
types but wrong for struct ops which requires LoongArch ABI.

So let's sign extend struct ops return values according to
the return value spec in function model.

Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for trampoline")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 47 ++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..4077565c9934 100644
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
@@ -1448,6 +1450,30 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static int sign_extend(struct jit_ctx *ctx, int r, u8 size)
+{
+	switch (size) {
+	case 1:
+		emit_insn(ctx, sllid, r, r, 56);
+		emit_insn(ctx, sraid, r, r, 56);
+		return 0;
+	case 2:
+		emit_insn(ctx, sllid, r, r, 48);
+		emit_insn(ctx, sraid, r, r, 48);
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
@@ -1602,8 +1628,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	for (i = 0; i < fentry->nr_links; i++) {
-		ret = invoke_bpf_prog(ctx, fentry->links[i], args_off, retval_off,
-				      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
+		ret = invoke_bpf_prog(ctx, fentry->links[i], m, args_off, retval_off,
+			      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
 		if (ret)
 			return ret;
 	}
@@ -1612,7 +1638,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		if (!branches)
 			return -ENOMEM;
 
-		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off, run_ctx_off, branches);
+		invoke_bpf_mod_ret(ctx, fmod_ret, m, args_off, retval_off, run_ctx_off, branches);
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -1638,7 +1664,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	for (i = 0; i < fexit->nr_links; i++) {
-		ret = invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off, run_ctx_off, false);
+		ret = invoke_bpf_prog(ctx, fexit->links[i], m, args_off,
+				      retval_off, run_ctx_off, false);
 		if (ret)
 			goto out;
 	}
@@ -1657,6 +1684,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
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



