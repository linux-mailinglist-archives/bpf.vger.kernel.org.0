Return-Path: <bpf+bounces-67426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1006B438F4
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7277D58831A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02B2FB982;
	Thu,  4 Sep 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIapNyfs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDB2ECD14
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982301; cv=none; b=D1DjaTszqP1zwLHUPqUkiWzN5DZesVbGh9g0RB6Wi024A7bxz5dtMBsfkMwJXqk0pkJi3mm3Sl0/MKnpKLwPOflyV2RlyigNJzGW/yHyHERjhwl0VwPxjYHaS5airHMCss8XtduntW3i4729FJ+3Xn3TzKgui3Zoaqv1pat+us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982301; c=relaxed/simple;
	bh=S7wAkGPdGeXKmcPRSjImMd5XnLL+0sP7L4aBdzFV02A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MC0kYQopisqokPrWIL2LlYAm3bs6H1kCAvyICnSdqeUZsHAA9k3iGFwnQSg3GFqVFuJ3A5nnwpRy+PlVFGwGfQA/4DljIDM6lcbCYEYX9sS0P/hXmZXqv9B5IQR0UiyJJSg141TrVhL/TgccmdlnGYEjEsbKaOfJVI3S1KXlt+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIapNyfs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244580523a0so10102845ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756982299; x=1757587099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktLj96eC6qDTAhpOr75D7Fncxnep+JLnT4FtcC40JJM=;
        b=QIapNyfs0H7/8sICQibv62o7Qh/M056MGTrzuVsSgUpg9ryWL/1NIZ4dDpsuZmafvp
         PbQ3EuIuSj4Is4dNQU2gINNZBNEFd7q3XUnQPpL+j0Ti/+l0mv4lDljrwuyd+dNFqW5Z
         1vhXpEPwbqpguNDiX7D3pXC9q9BKM3nXUqBXPIWfQAW9k5TYoemZBiz7/bLPlfGWD/HW
         Y9jaFDJNhxmPmxJe6ysMe4iK2nil9cAFy5nwmj+X/qe1KVbXqAdKM/WIOlzxWYtnhbOd
         dxDktM5Wh8LXX+yRScaX1NKqj/jSTTo9Dccpyh+tx9qE+X+/jIB0B4VDH1V5vWZOLVfI
         xMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982299; x=1757587099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktLj96eC6qDTAhpOr75D7Fncxnep+JLnT4FtcC40JJM=;
        b=Q05KRWQdtTkDG+cek3D9Vp/yD3jc1OuhS3wn2Uak8Mfo/wGReHHQYf5J2Erew/9agJ
         Y1jG/RZXpSz5rVfRvBbK6T9TVcJANC7K46G9T7nrA/acAeKK4h/vaL2McCnV6FdrcYgx
         3oudiCZBfXkPALAA+XCRcEndMC4mVkDl2lMz3hk5I47tEzu+ctUdqaCQqF3mW96r6T8C
         i4A0gljYbPN0DycHyalM22rgRgLDZ87KBXDJkOQRBtCzh37tCglHtz/cpD98o1vP9Zzn
         M5YmGWGpzAG5zmFEVmPY6A6Gu687HoWTna2p5LXbjqi7KIbn/iezsC7Q8X9pd9udbkr5
         5N/Q==
X-Gm-Message-State: AOJu0Yzsz48CTD5hLShjQT/x/ME9iDuVXSbVDWQFmZvS82xN7yxi834V
	sX9H6I/kuV7m4+uk+tlaVcoYfXXYpm7Yc6cyB2WF5Fe9npeLu82by4te
X-Gm-Gg: ASbGncubYNe7mHjKCy9NsVhJ5fZa7NvmuwlWsO2v8vpSUlCc+i23sT3pNhgiDrLn63C
	+ah/Zhw9j+7xYMyJrNvJqX2AG0Pc2rvDgAM2XMu4ANI1WK+sblHID/FcRzIk7cDzNKK0oOKxJ6z
	jYPWft7VzEyYMn24xvSQjceYVhY44PpBC2gXu9OR0qrUDzGrxW3KW3b0M+vTBAl4FgKB2d5B4Iu
	hmnBz/rASyml1hRh4zcHqaaOEsrjUygcRU84pZYSysmVlHXJ/MPrOLDogXrOJEdXZBjkYKhoZaM
	gvliQqyR701fZuSLCuM1iiQoYIciVWeTZ0huwXLvJ+jOue0OUjQFz52nMsRA24Qyk5DhG3jq9hh
	1s86LZIz3Iixr9aIr24g4WF56HIz33XN/gcp7PNsnfV9bA8ms8I6HPdkoSIinAw==
X-Google-Smtp-Source: AGHT+IF9aIk2Z0pYg1hmNIhs1ASNOseLkrqCWdDHEovVy0k8v3ZcvjJUkYiMeYUhSYJyHVnI5ta6nA==
X-Received: by 2002:a17:903:37cb:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-24944b73618mr248272765ad.55.1756982298763;
        Thu, 04 Sep 2025 03:38:18 -0700 (PDT)
Received: from ubuntu.. ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77236d7eb7fsm17257854b3a.54.2025.09.04.03.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:38:18 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org
Cc: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next] riscv, bpf: Sign extend struct ops return values properly
Date: Thu,  4 Sep 2025 10:38:06 +0000
Message-ID: <20250904103806.18937-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ns_bpf_qdisc selftest triggers a kernel panic:

    Unable to handle kernel paging request at virtual address ffffffffa38dbf58
    Current test_progs pgtable: 4K pagesize, 57-bit VAs, pgdp=0x00000001109cc000
    [ffffffffa38dbf58] pgd=000000011fffd801, p4d=000000011fffd401, pud=000000011fffd001, pmd=0000000000000000
    Oops [#1]
    Modules linked in: bpf_testmod(OE) xt_conntrack nls_iso8859_1 dm_mod drm drm_panel_orientation_quirks configfs backlight btrfs blake2b_generic xor lzo_compress zlib_deflate raid6_pq efivarfs [last unloaded: bpf_testmod(OE)]
    CPU: 1 UID: 0 PID: 23584 Comm: test_progs Tainted: G        W  OE       6.17.0-rc1-g2465bb83e0b4 #1 NONE
    Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
    Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2024.01+dfsg-1ubuntu5.1 01/01/2024
    epc : __qdisc_run+0x82/0x6f0
     ra : __qdisc_run+0x6e/0x6f0
    epc : ffffffff80bd5c7a ra : ffffffff80bd5c66 sp : ff2000000eecb550
     gp : ffffffff82472098 tp : ff60000096895940 t0 : ffffffff8001f180
     t1 : ffffffff801e1664 t2 : 0000000000000000 s0 : ff2000000eecb5d0
     s1 : ff60000093a6a600 a0 : ffffffffa38dbee8 a1 : 0000000000000001
     a2 : ff2000000eecb510 a3 : 0000000000000001 a4 : 0000000000000000
     a5 : 0000000000000010 a6 : 0000000000000000 a7 : 0000000000735049
     s2 : ffffffffa38dbee8 s3 : 0000000000000040 s4 : ff6000008bcda000
     s5 : 0000000000000008 s6 : ff60000093a6a680 s7 : ff60000093a6a6f0
     s8 : ff60000093a6a6ac s9 : ff60000093140000 s10: 0000000000000000
     s11: ff2000000eecb9d0 t3 : 0000000000000000 t4 : 0000000000ff0000
     t5 : 0000000000000000 t6 : ff60000093a6a8b6
    status: 0000000200000120 badaddr: ffffffffa38dbf58 cause: 000000000000000d
    [<ffffffff80bd5c7a>] __qdisc_run+0x82/0x6f0
    [<ffffffff80b6fe58>] __dev_queue_xmit+0x4c0/0x1128
    [<ffffffff80b80ae0>] neigh_resolve_output+0xd0/0x170
    [<ffffffff80d2daf6>] ip6_finish_output2+0x226/0x6c8
    [<ffffffff80d31254>] ip6_finish_output+0x10c/0x2a0
    [<ffffffff80d31446>] ip6_output+0x5e/0x178
    [<ffffffff80d2e232>] ip6_xmit+0x29a/0x608
    [<ffffffff80d6f4c6>] inet6_csk_xmit+0xe6/0x140
    [<ffffffff80c985e4>] __tcp_transmit_skb+0x45c/0xaa8
    [<ffffffff80c995fe>] tcp_connect+0x9ce/0xd10
    [<ffffffff80d66524>] tcp_v6_connect+0x4ac/0x5e8
    [<ffffffff80cc19b8>] __inet_stream_connect+0xd8/0x318
    [<ffffffff80cc1c36>] inet_stream_connect+0x3e/0x68
    [<ffffffff80b42b20>] __sys_connect_file+0x50/0x88
    [<ffffffff80b42bee>] __sys_connect+0x96/0xc8
    [<ffffffff80b42c40>] __riscv_sys_connect+0x20/0x30
    [<ffffffff80e5bcae>] do_trap_ecall_u+0x256/0x378
    [<ffffffff80e69af2>] handle_exception+0x14a/0x156
    Code: 892a 0363 1205 489c 8bc1 c7e5 2d03 084a 2703 080a (2783) 0709
    ---[ end trace 0000000000000000 ]---

The bpf_fifo_dequeue prog returns a skb which is a pointer.
The pointer is treated as a 32bit value and sign extend to
64bit in epilogue. This behavior is right for most bpf prog
types but wrong for struct ops which requires RISC-V ABI.

So let's sign extend struct ops return values according to
the function model and RISC-V ABI([0]).

  [0]: https://riscv.org/wp-content/uploads/2024/12/riscv-calling.pdf

Fixes: 25ad10658dc1 ("riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace framework")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 38 ++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 549c3063c7f1..c7ae4d0a8361 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -954,6 +954,35 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	return ret;
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static int sign_extend(int rd, int rs, u8 size, u8 flags, struct rv_jit_context *ctx)
+{
+	if (!(flags & BTF_FMODEL_SIGNED_ARG) && (size == 1 || size == 2))
+		return 0;
+
+	switch (size) {
+	case 1:
+		emit_sextb(rd, rs, ctx);
+		break;
+	case 2:
+		emit_sexth(rd, rs, ctx);
+		break;
+	case 4:
+		emit_sextw(rd, rs, ctx);
+		break;
+	case 8:
+		emit_mv(rd, rs, ctx);
+		break;
+	default:
+		pr_err("bpf-jit: invalid size %d for sign_extend\n", size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 					 const struct btf_func_model *m,
 					 struct bpf_tramp_links *tlinks,
@@ -1175,8 +1204,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
 
 	if (save_ret) {
-		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
 		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+		if (is_struct_ops) {
+			ret = sign_extend(RV_REG_A0, regmap[BPF_REG_0],
+					  m->ret_size, m->ret_flags, ctx);
+			if (ret)
+				goto out;
+		} else {
+			emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+		}
 	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
-- 
2.45.2


