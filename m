Return-Path: <bpf+bounces-67686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA70B48210
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 03:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F01C17C961
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7D1A76DE;
	Mon,  8 Sep 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkQHBTFU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA110F1
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294707; cv=none; b=RizzOoQM1h+baA5ZfKzRgK0rG0t5s77+mBFvGt9GH+CedK3AURVrWzlGrwNGQWbET6SIR5xQcBy7ICeb/14q+rkbxqHs4FR6DpTNeK+MsQ+mWHuI2k/Jdvd/OTzxKdp2iV1R4PqAIc692AY2+3prRbMQHKXzRvIMzZedNQURay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294707; c=relaxed/simple;
	bh=i1UBKeVCo0S01+2IKFgWiNf7CIWnr2cNRil8oV2DYKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt1+Miux4Xo17C4/hY6clMrPWoCChih91gz0Rp2Z/+/ph99FGjT1n9TPY1A0WtMyOuVi+AZgA4B0WLxbYy8aDsJNcDtAvVUqmVpGUN9fklnqnMLS8x17J22CPx8xbSqRiZfRaW9s139Nq5HDFQ6s30rWOYXc36FLKJO14XGu5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkQHBTFU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so2207406a12.3
        for <bpf@vger.kernel.org>; Sun, 07 Sep 2025 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757294705; x=1757899505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzw6hQQ7M5B5xk9kBfDEuQjeyMGC+VPV/lN83f90R+c=;
        b=BkQHBTFUZv2ePFy3nUgDP/zA/kfUUBletqdQGuZpIIsJJBuzD8fXvBHV1c8/fBObLS
         JnOMhpvEapT6rLiWGRlSjUmTHpKPqbz5A0CAOcNppm7EBvOpI/uiErgOAJyZTENSiX51
         aXo8jHS9YbvyohTdhb13IwEKyKWkh0pM32YH4HDRkrC/P8MMElO9NTYTT/9gj13GtdQP
         94KRvSQ2FNnv7yGbMlmurmDKXuTH67IRxSx7Z1ALHfIaMqHvWBCWvVi42UKZX/1ol/gG
         T21VUSD6PG//kClJCS3QVIDBntHWHz6RqSWzk4bawUHveIP14hw7bMp7uIv2l9hqmcC4
         RmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757294705; x=1757899505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uzw6hQQ7M5B5xk9kBfDEuQjeyMGC+VPV/lN83f90R+c=;
        b=t35CYlUOGnJwHZYCdWP6W5AG4ERhFbI8FHcdnMuETf1mbVshuc8elU1E7ZyvpYmaud
         8rPy9hcpoce49WJbRZSVd3eulglvnB74kqvu8cytceEW/7TCJMkqU5n3RCdeMF8pytsy
         iH4FGoDSmKUBjh5jQAl6TadmVA6AqYEqa2xYATbsx1D6iJC8S/wxArKTaI/zBeWRL7Xc
         Q9Y7jspKhCXgJNeFG8flZXps6gGgL9el0MlR+qfzQV7m84/PFEsOalhGWoZzsCX4hvZL
         FSu0CC5+sWyTVJQWO7XZsVC42SaHx9V5PAqn9LVCqfeqn9Vva+t8rrWFY647H4osmp/R
         +m/w==
X-Gm-Message-State: AOJu0YxMhOgrQHLQdfBKUE0Nmx6YXdqXTvw2E52DEwbId2GDAPuk6e08
	i32VFQjUU+5frD6ZMF2HEilJ1Dtv3XG8ezgm2jGRiCLMOazvclR50gBG
X-Gm-Gg: ASbGncvUxxsmpDaOrgNaMRomGug5xlG7inDroeAi1He8Sy8S8n1SL1xNTXbx3D0/6cU
	eGCrS0EZNbHKjmiIqaQxwFq2XTmcYX1KcM+ChyEJzmpQ5TLZgtYPDPKwDEdJy0VChOeLpI3a/my
	SLM1avgw4D7BV9lrGmPkP7M2RY1613YJ1fdpHaLBUVJDdmJCw8dwuz29+cCEVdKYsmjkjWW9XbU
	7RY9prBQwVpHj7p7MnFq+m8rNrX0WEIj9PGf4pf52DJjmJqwvMpYd7+y4Zb49QGRijefXkMua7B
	qHN1I771d9PvTS5jFGt8rEYAQTCLOrm391iOas+BLaY2lCY6D/YCfb/RHUbMncI8zTQePIIjY9u
	97u4Lj/3ZHyWJhD4SJ3b+RMmqqtPwe2UIBg1R8OW00CL9
X-Google-Smtp-Source: AGHT+IETyclgoC3/kP2x/Xtmcnc4HLt8X24CdhRyQ7WeY9046AXJnN9GiR46XdEO9ZMshU4kGunA6A==
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr100680835ad.11.1757294705193;
        Sun, 07 Sep 2025 18:25:05 -0700 (PDT)
Received: from ubuntu.. ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc56ec1sm94646545ad.59.2025.09.07.18.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:25:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] riscv, bpf: Sign extend struct ops return values properly
Date: Mon,  8 Sep 2025 01:24:48 +0000
Message-ID: <20250908012448.1695-1-hengqi.chen@gmail.com>
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
 arch/riscv/net/bpf_jit_comp64.c | 42 ++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 397968d6ee09..a860be52dc49 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -711,6 +711,39 @@ static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static int sign_extend(u8 rd, u8 rs, u8 sz, bool sign, struct rv_jit_context *ctx)
+{
+	if (!sign && (sz == 1 || sz == 2)) {
+		if (rd != rs)
+			emit_mv(rd, rs, ctx);
+		return 0;
+	}
+
+	switch (sz) {
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
+		if (rd != rs)
+			emit_mv(rd, rs, ctx);
+		break;
+	default:
+		pr_err("bpf-jit: invalid size %d for sign_extend\n", sz);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
 #define REG_DONT_CLEAR_MARKER	0	/* RV_REG_ZERO unused in pt_regmap */
@@ -1175,8 +1208,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
 
 	if (save_ret) {
-		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
 		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+		if (is_struct_ops) {
+			ret = sign_extend(RV_REG_A0, regmap[BPF_REG_0], m->ret_size,
+					  m->ret_flags & BTF_FMODEL_SIGNED_ARG, ctx);
+			if (ret)
+				goto out;
+		} else {
+			emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+		}
 	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
-- 
2.45.2


