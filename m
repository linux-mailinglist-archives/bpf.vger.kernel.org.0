Return-Path: <bpf+bounces-67286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16685B41E5C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15C817DB49
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F332DFF1D;
	Wed,  3 Sep 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNzPQyGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7F2FD7D7
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901176; cv=none; b=IiGNi/n48nP2KwuHhrbLPt063bvq++G5MIym1c1vhBbS5xwZgbe9aeu25OPHoPzuZwuj7IqVe7sK2qwbNFJi09qdLXNXPVEM3slP5vSYDV2J26o/lI/hYjBSqtD5Ue+1WX8+XAmTM1MeYCNcYfN+29yF43H4kAR0w1D6+hSfypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901176; c=relaxed/simple;
	bh=i/cGLH1uq/UafzJ6JgsIw+BcbLxPPp8ARJILGja/g+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBklFGiRDOfD2sHnRIfJnzUHAz1YhJSRbWXcGq8LMO6rH21uWMxnEJq2N5y8hDyolzcsdUgHIIkrvipxG3KHPnk9mFSnf/ymRAfuWG5H9iwJ2pn88jPibidlUQYeG+0bobwlrhkp1rI1pz0fDh7ijVaINvy/b0Bzjnsbjf2NLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNzPQyGw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7724df82cabso3936998b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901174; x=1757505974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDw1E1z/FlfgNIxQZyKYv0LpcZi6UtUYL8AOcxGMX2w=;
        b=eNzPQyGwRzu97gwzCMQ6LvJQUf8s0KLuikOxjAIFnhxeYG4x6hBHinuA9/Nk28XrRd
         xvZ95IVQWxv4LhrexEkc25lw4M+Wo2eNNaDb5mICkL7e5/CRxT15MDsXkZqqyObzq87A
         jt01XlxVaL7MpgX0IMx+NybO2yikFRfV2GjODqCKe3agjo4esngAQVvXOJ80zFGIEt/i
         ciEf/7U7o4RHnDXE2nIHnvb5BLxejOwVJ+JADskD1RMPr0fnofJaQxByOUv8Ug2rueo3
         85pXoTaZtHYcmEdRjRp+P3WLMMYtfBxgVcqknBYTxbYe0bZnFmrGY6eHvF/VGXaXSv/I
         h9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901174; x=1757505974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDw1E1z/FlfgNIxQZyKYv0LpcZi6UtUYL8AOcxGMX2w=;
        b=VQ7nVg7bI4tiqMxNKvQ36YnlGw7kIAEhI33qRxeisEHTcq2Qxs+qq8aTnp7KHDuQuN
         S0u7XpWwIy38nl2+CD8iX9GpylVS5dpo6SbjSPAFfyBmIpGR88NLpVuGl+m9s6WoKC8H
         er6TCBMnLZ610KbGUmpwqvWE5/PQRktuh+Ff0xymUPJsP3S3s/bCZYqYASo0N+UqC4XT
         o5T9X3LCb8hQsbBm4ChMH02VNHp1FHEqljpnibTRVY0kDzYo6x0tzreMIwpLfZEM3sJb
         c6wg4tb6CRaVLvZP/Ola7NaN7o8oklFNAKTmSYbkDUnKMySvXPtO1ZyrS7tSSJWMQ8zh
         IrnA==
X-Forwarded-Encrypted: i=1; AJvYcCV3p6cMhcZ7VXMgVSQoh0LUkGJrd9+M3SsYRHBhVJyjZIY98uTm7GxV40a1KpBTL5oJf9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNPW0lXJAk64wv70N9dNwkFxAqq3vVkfehjwhHSAGr1jKyhnI
	gXYweQZYzuLXoiqyJHdzj1KoWErNnUeQBelIvYUolL0ZwQKri10oTAcl
X-Gm-Gg: ASbGncuzqkT2phJCedBPhN5WuJ2eL2IS3+Xu1rmfikHDmw6uLv3rH9ssx/Uci9GokJH
	gAelo0L/ML+garPTMqn+Y59vE3H4OPKl6DBFHjPJhe0Ah+/n7s4FSYr9fJwJZmwRun18/lnmoyE
	6vUz/QJuDU8Cj+bXfjJXRxmVtvkkGiK2Ii1e2mbp85FYXCFF7nGpZWPivKJbXEB+njapUG8SqEn
	K/ZmQemiv/4onWR0IDgAK6WWn1+ZoELjJs9/YUngNRXWLhYG5PcOzFsyFP0h/HF9G4yits7ugma
	jMLXnW+IFATdLeSJHVxX0P1UnKOI+kbl5mEY0rHYRdK08DFEzEhkwVsuS7w5bvvac5kcaXNtdsx
	n0MR3HlBrx4dJnATTcV5qDU0kHM6TGasPj+DHDmSKraFeAta2a7tIq8FKZS5Heg==
X-Google-Smtp-Source: AGHT+IEPYWws7h8Ojv8b8CgrnGne71pr0CQ548eTgFlMz21JEoWksXMEmjy+AWKFDcVbJHVXJxM4RQ==
X-Received: by 2002:a05:6a20:258f:b0:243:d26c:4807 with SMTP id adf61e73a8af0-243d6dcab42mr23218355637.8.1756901174289;
        Wed, 03 Sep 2025 05:06:14 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:13 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 8/8] LoongArch: BPF: Sign extend struct ops return values properly
Date: Wed,  3 Sep 2025 07:01:13 +0000
Message-ID: <20250903070113.42215-9-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903070113.42215-1-hengqi.chen@gmail.com>
References: <20250903070113.42215-1-hengqi.chen@gmail.com>
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
the LoongArch ABI ([0]) and return value spec in function model.

  [0]: https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html

Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for trampoline")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 6dba407c202f..583a540ff7f5 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1451,6 +1451,32 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static void sign_extend(struct jit_ctx *ctx, int rd, int rj, u8 size, u8 flags)
+{
+	if (!(flags & BTF_FMODEL_SIGNED_ARG) && size != 8)
+		return;
+
+	switch (size) {
+	case 1:
+		emit_insn(ctx, extwb, rd, rj);
+		break;
+	case 2:
+		emit_insn(ctx, extwh, rd, rj);
+		break;
+	case 4:
+		emit_insn(ctx, addiw, rd, rj, 0);
+		break;
+	case 8:
+		move_reg(ctx, rd, rj);
+		break;
+	default:
+		pr_warn("bpf_jit: invalid size %d for sign_extend\n", size);
+	}
+}
+
 static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 					 const struct btf_func_model *m, struct bpf_tramp_links *tlinks,
 					 void *func_addr, u32 flags)
@@ -1659,8 +1685,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		restore_args(ctx, m->nr_args, args_off);
 
 	if (save_ret) {
-		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
 		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
+		if (is_struct_ops)
+			sign_extend(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0],
+				    m->ret_size, m->ret_flags);
+		else
+			emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
 	}
 
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
-- 
2.43.5


