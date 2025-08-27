Return-Path: <bpf+bounces-66656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CDFB381E3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 14:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C6E5E5C32
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AF2F7475;
	Wed, 27 Aug 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGzD8sX6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D8156F20
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296245; cv=none; b=q6JNpOx3Hj3YwNDDRDSiwVQaTWjukhAqy/SVyZGV2DhYHIuSsifAIggJnFTs+HJsgsIcmpHa3JXpkNsCp3juJNZP666/ydpApfnklHRQukJ6AE+KpS+UQGAgzZbpg2abfw9riSY2WRUBUp5NZJd6DUs/XexiQzHlgaq1YRZJK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296245; c=relaxed/simple;
	bh=qjZRoY9VHkS7R31pMzbRO+c7ndgvV7bgJrKPV4wawrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYnfdd/zi+J0eNhD/p6F/iUHg2SLlWaeO1ikZQjmmEaQM2/BOYzjtTU6/HAFrVhZ1JHXyYbQ/U3JRdwt7cUZe1P79tME2bmZhNdVi9WMIvN5vhdJzRixVaHAolmylH1sAWoqXlbKCVkYlpSdQOv03Q1oPg/ztfP2b5pEjnB7Wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGzD8sX6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b10c1abfe4so99369041cf.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756296243; x=1756901043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh7qX3heP82/xvGRdFcTI045iSa1lfxsBF6MYN2KcOw=;
        b=LGzD8sX6JXCdez/P4waUtRIA0Zc5teIRqBmKj/twa4urnS2wjpdMMuCAfH7ffjsdPu
         zCJmuSqkR6K2nzqL9nRoKTbHfPfWX7yC7X4v7FYgn08RvqZAb+805S994r6+iK9GRHEu
         eHnHQrqwEiTIQx5MWBeU7Fc7fxoTN6gYemCDV8f+ybjjsCWnCzeoX4n/4ll3Om4wlusD
         JqO+yajPlReLAsEVugsqHXlFFBpuCKOAwYluCNe33kPfdSGz/JE8OulioojP94OQcxr0
         7nvorqk5ZqHO+9LKQzWin5HWvrmzMi+1uyqka+no3OgBb15E4UkZt56z/TW62KjBEWoO
         IMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296243; x=1756901043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh7qX3heP82/xvGRdFcTI045iSa1lfxsBF6MYN2KcOw=;
        b=c8R++lBWoQVvuxyLnOEnKHooCEQ/lsNbXW+YK9xdzxlT2agYqcF+XqlpWoLkAyvHbT
         H0OUzAKUXX834e/QbSxoVenPyoR0xRAXYCel0mYxNnJeKU7n9hanqNufw7s1d1bi3rqd
         g/k0TLu05XX+ltV+QDg0i3CXOB8VleK1FdP4X+dne9aSUghOnH4fnQGR1skobwJyC4ND
         WH6ijnjNsYDOC/4ctrLP15fdvN58zFg8+2aWasxm3Artvqk261JnfYVNDgEsBMcyZMIJ
         yDi0B0dP+nm2mqiddcb/6MDPrBFoScfdB/YrUKrNTpDT+Wk4jpsB4C6ftfsY4rBVK2k+
         7XfQ==
X-Gm-Message-State: AOJu0Yyz5tPjDmRfDjlovolLLsslAPMQpyVGluCKagkkvKVwCDRlvvTg
	YiUVBV2njy5zyO4sHl8a76lJdFlcc/weNF+DigRZrpte+LnmMcQt6QWDBgj5uXyOjR0=
X-Gm-Gg: ASbGncsFw5iIJCCRyJfLyFtQNBLcttT2eeAtwcndmQzm3tgVi2LFYvVw7/L2XCSkenF
	hC7EzGj9xVIyj21IGK4+DNqg6I0SO46ultIK0dIVIxaZmDnz5ULuVqLbLyGXVrvOCVFHvKX8wyq
	dm9ARNkZMnQ/bBh/lcEHCo6K13SHDYlq/w36qnoxvx6TIXGEvVITFr6CAUCyWAaZVHfMg3B5p7F
	0CVGgwS/zZGZd7JceckOggCUMHVpFyshNUMjJPjxhlfY7tEr4YvCyk10ZG6UpDd7FnQiiTsJWb7
	A5tSmULhzYmNzouzgQY/mqo7J14vuDNbycz/+u1XPxsT92eMIpABz1Cn7+1CjRptcVcpvKhjvDo
	Y3bVIONHQafxKSZGmbOFWaY7Qdp1SMdAbhgiM+T/B
X-Google-Smtp-Source: AGHT+IEkreAUdFea/dTdA/eLgslTv14Osti7kTMUmukoBVeQqTVBjgPGnMV/CBIaXJPNaKk1CQBCjg==
X-Received: by 2002:ac8:5e07:0:b0:4b0:6228:b3e7 with SMTP id d75a77b69052e-4b2aab4abf4mr197233561cf.43.1756296242625;
        Wed, 27 Aug 2025 05:04:02 -0700 (PDT)
Received: from ubuntu.. ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c61acfsm92067921cf.7.2025.08.27.05.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:04:02 -0700 (PDT)
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
Subject: [PATCH] riscv, bpf: Sign extend struct ops return values properly
Date: Wed, 27 Aug 2025 12:03:44 +0000
Message-ID: <20250827120344.6796-1-hengqi.chen@gmail.com>
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
the return value spec in function model.

Fixes: 25ad10658dc1 ("riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace framework")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 549c3063c7f1..11ca56320a3f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -954,6 +954,33 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	return ret;
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static int sign_extend(struct rv_jit_context *ctx, int r, u8 size)
+{
+	switch (size) {
+	case 1:
+		emit_slli(r, r, 56, ctx);
+		emit_srai(r, r, 56, ctx);
+		break;
+	case 2:
+		emit_slli(r, r, 48, ctx);
+		emit_srai(r, r, 48, ctx);
+		break;
+	case 4:
+		emit_addiw(r, r, 0, ctx);
+		break;
+	case 8:
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
@@ -1177,6 +1204,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
 		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+		if (is_struct_ops) {
+			emit_mv(RV_REG_A0, regmap[BPF_REG_0], ctx);
+			ret = sign_extend(ctx, RV_REG_A0, m->ret_size);
+			if (ret)
+				goto out;
+		}
 	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
-- 
2.45.2


