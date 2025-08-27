Return-Path: <bpf+bounces-66648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3FB380B9
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EA31B265FA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F134DCF5;
	Wed, 27 Aug 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEedbXyT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55034DCE3
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293587; cv=none; b=EesL3sKnhKw39u2QHyEilEGgi/DXboZGglnlHSoN3rVpPGcsXsOanpDKyEOtbMshWitjOzabtym0HP4XQlR1rWxk8awiTgVJ9or1eSbU20AC5XAALc/JoQdRQnUZW11pAqWUaUenEJ6AqnB2PK+nGa6wxbky0kuNlq7/2i5dSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293587; c=relaxed/simple;
	bh=ltYS2QOn/5zkyHWiC96blfmcGl9cf4ZferaS1apQjUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjH7fD5r9qIp62Eb6swL9bEO4I2+veN9liztmFK3jIlPu+5KvwB48l+10Of0OeEoOdHJwmZJAvby0c4kU8OM+afqQfxTgZzMcP+pXnGXln7067kLLfvOzclXF2oYyrSj7L6yc+KOtEtOWm7QfAEmrZqTty/xnQOU4zLB7YLymNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEedbXyT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-324fb2bb099so5064762a91.3
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756293585; x=1756898385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N56x/PK4IopNz9cbwZEZJpWMxCF6ZLggsQFAooEkPd0=;
        b=GEedbXyTZvtpD3HPA/u/LS6AaogdaCspu/2xACpVHbdmhZWDIVVXn4iRkM6gUATC1l
         8Ii1K64yT77TVtbLnB/oReKF9oc7Nh+ZCQuPpDIjSIuUrTZ7qZKSk7f5yNN/dgT+qK1Z
         N1Tes7Auz3nE0v8/o145F69dMOU0n+cFT9bXUjJhVS0IAS3eecWiGGtCeX/78qaFEkq4
         mf0XohGvtQys7rMskflGp/EFDmxuhJuftIgft7YLytaqFkj1n2C6HUzCfqYttet5GKlA
         d63fq8Bl+RTt3O4gx/rzZ5neEVMkP/40rNjxR7Dk5BW6nTRdRcDFvVe+L0c5jq/R5fZW
         x4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756293585; x=1756898385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N56x/PK4IopNz9cbwZEZJpWMxCF6ZLggsQFAooEkPd0=;
        b=Ba2WlbkBprnK9W17pMgC2XrkIfYzKbx7mcBNXbGM7/NgwEvZccx4n8JmZh0QvCkGT1
         pr/MGCq2iuHGJFw/08rcDYlr1eCD2LokMB2vwGXQXcH1sE06cGZI1yaQtbmdiyHV+chw
         DU3palhKqNcSAvPZKHIziLi3Pqwc/kf/o2z6eVIn4Csqh33XsK1alEAd7VTpvErzwZpY
         MG/YtEuoEsm0RnIhOEKV77RDo9THZCitNp4iKBIa8kYe3CIeODhJbgQJvj93Ioi9Ahzm
         Cn8s0OR5+DWI/76xDwW5fLk0LtUxCQlNwPIoP2vPyTc3g/kumsKehMcu62DcQBDRUYCZ
         wAUw==
X-Gm-Message-State: AOJu0YwoPufQbDj3TMKsZHxqvpn+2WyOgtVEqBseki5ER3rpKUx2fUUk
	pg3Q+egnS8PAA9AYEdFpo31fciL/zGLiO+SkaNL0IBHUC0DumrO4ozOJ
X-Gm-Gg: ASbGncuXKJHyHwLVFRejqN8MTpePbwojI1X+eBA19raB5bgd2xhFE8kQ7eIeVAVI+Dh
	lpfnmuMCwsYPacLF/I4Yuw5wNlJhiMdIcmXOJbQFKpfNwq89wzfi0vazXaEV2PrhOUfIPvD48RR
	JnoermGzwb2i+xOh/VySUceQNuDiRBJVsq/vNB5wWQDkB/vY1CftckWDJ29Su7VaV4CYbaqxfs9
	SXPxA4AE5LVhxEMicIjFu7ilQRZcw6wTCNsVFsZb2kYnNxo72fzW3hrx3xLeWBo5H2z3PHvs/94
	P1c6gauXi7U+hMFAVy6AmXuaMeBuheWp9fHHRwLg7vZvA91J76C+M+PfhV9AAE+WCJNzfL0bSg+
	a5mBuypAZE9NyBmAk0PLIM1iJMTaWi5x4HaroI7ir
X-Google-Smtp-Source: AGHT+IGlp/WS+KoJo65YB3dx5lC2D3A6/fIHq1VCh47XTGTq4ZHX3GWlF7i0uB8rmnhH8bly4XtPxg==
X-Received: by 2002:a17:90b:2686:b0:327:5d06:4d8 with SMTP id 98e67ed59e1d1-3275d060767mr5033570a91.31.1756293585171;
        Wed, 27 Aug 2025 04:19:45 -0700 (PDT)
Received: from devbox.. ([43.132.141.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f8a3335sm1829729a91.13.2025.08.27.04.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:19:44 -0700 (PDT)
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
Subject: [PATCH v2 2/3] LoongArch: BPF: Sign extend struct ops return values properly
Date: Wed, 27 Aug 2025 09:47:32 +0000
Message-ID: <20250827094733.426839-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827094733.426839-1-hengqi.chen@gmail.com>
References: <20250827094733.426839-1-hengqi.chen@gmail.com>
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
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Vincent Li <vincent.mc.li@gmail.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index b646c6b73014..c239e5ed0c92 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1448,6 +1448,28 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static void sign_extend(struct jit_ctx *ctx, int r, u8 size)
+{
+	switch (size) {
+	case 1:
+		emit_insn(ctx, extwb, r, r);
+		break;
+	case 2:
+		emit_insn(ctx, extwh, r, r);
+		break;
+	case 4:
+		emit_insn(ctx, addiw, r, r, 0);
+		break;
+	case 8:
+		break;
+	default:
+		pr_warn("bpf_jit: invalid size %d for sign_extend\n", size);
+	}
+}
+
 static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 					 const struct btf_func_model *m, struct bpf_tramp_links *tlinks,
 					 void *func_addr, u32 flags)
@@ -1654,6 +1676,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	if (save_ret) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
 		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
+		if (is_struct_ops) {
+			move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
+			sign_extend(ctx, LOONGARCH_GPR_A0, m->ret_size);
+		}
 	}
 
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
-- 
2.43.5



