Return-Path: <bpf+bounces-30020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B559A8C992E
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 09:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D8E1C20980
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388118C3B;
	Mon, 20 May 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMOTm4/k"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F717C67;
	Mon, 20 May 2024 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716189205; cv=none; b=QMP/Zx9p5pdwUOgT2gxRD3C3qsT7A7SjYPBFUekmnarbRcyuzqhKb9YC5ho1RLywFeov0kOFAglJdmLp+D8YFSQ7H3vJqRCN8420KvXVaM+RlAckRkmAoooFXpU6NV/MbJJ7/6Ty6hiETk+IFUzf7OlbcCgjI0+pty0+hbx9qZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716189205; c=relaxed/simple;
	bh=HaN3uDDCs7rsYuOeFc7Bo7CtrGnS/xMq3UMxX8UPGd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ufUxmk1dDAKixSZKzV58847eecCJl+H7roV6AOmpTBQ8g17js0IFet7oS5WKJ8qZIWY44LPnUgojynJChdwV2f0XiDQDgVGB+0yyY9dUVstgMy9irKoeHgweKyEhZStp3YK9o4m7qhdUobxOo/CaeXZy72g3c640pOyFXb0p7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMOTm4/k; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716189203; x=1747725203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HaN3uDDCs7rsYuOeFc7Bo7CtrGnS/xMq3UMxX8UPGd8=;
  b=OMOTm4/kbqJmJxZrpYW96ACXyZOVLnLzVAlgC37n+KWkEwHko487PpMp
   g6rtprh9SFYkHHXnqM0WL3ZB49w1sIe8ZX3snK6VZI85tr/pJmBR2+NaX
   PZqz4pxvl/UGe/qcCkTZEktDVZdnUyAIHOvSh5VF3k2OiS/NrNWffp+dD
   9pg8pPJr6k5mBekCqK4gtc5oobyhd7G/aW33KPS2uF79LDCYd+XhMqrB2
   G1Jejp/cr8iOMTabS40ltb7fOLJOMV47P6b7j3gjm72RFRAoOayNrmJY0
   kz0TtEa84aTERoEdjbEshy/T7wKVfRfIiAOUOm33NW12zeHL4wMICGJan
   Q==;
X-CSE-ConnectionGUID: pGKvNW4RRPGM8MFyH/lG8g==
X-CSE-MsgGUID: aNAcF+SUTpSCIZf6zZl1SQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23707105"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="23707105"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 00:13:22 -0700
X-CSE-ConnectionGUID: ZcexixZXStuP6prl3x1rZQ==
X-CSE-MsgGUID: B6Pcj36/QT+24AjOgrQ8ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="55667841"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa002.fm.intel.com with ESMTP; 20 May 2024 00:13:16 -0700
From: Xiao Wang <xiao.w.wang@intel.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	bjorn@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pulehui@huawei.com,
	haicheng.li@intel.com,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv, bpf: Introduce shift add helper with Zba optimization
Date: Mon, 20 May 2024 15:16:31 +0800
Message-Id: <20240520071631.2980798-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zba extension is very useful for generating addresses that index into array
of basic data types. This patch introduces sh2add and sh3add helpers for
RV32 and RV64 respectively, to accelerate pointer array addressing.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/net/bpf_jit.h        | 33 +++++++++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp32.c |  3 +--
 arch/riscv/net/bpf_jit_comp64.c |  3 +--
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 18a7885ba95e..efe51821c463 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -740,6 +740,17 @@ static inline u16 rvc_swsp(u32 imm8, u8 rs2)
 	return rv_css_insn(0x6, imm, rs2, 0x2);
 }
 
+/* RVZBA instrutions. */
+static inline u32 rvzba_sh2add(u8 rd, u8 rs1, u8 rs2)
+{
+	return rv_r_insn(0x10, rs2, rs1, 0x4, rd, 0x33);
+}
+
+static inline u32 rvzba_sh3add(u8 rd, u8 rs1, u8 rs2)
+{
+	return rv_r_insn(0x10, rs2, rs1, 0x6, rd, 0x33);
+}
+
 /* RVZBB instrutions. */
 static inline u32 rvzbb_sextb(u8 rd, u8 rs1)
 {
@@ -1093,6 +1104,28 @@ static inline void emit_sw(u8 rs1, s32 off, u8 rs2, struct rv_jit_context *ctx)
 		emit(rv_sw(rs1, off, rs2), ctx);
 }
 
+static inline void emit_sh2add(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
+{
+	if (rvzba_enabled()) {
+		emit(rvzba_sh2add(rd, rs1, rs2), ctx);
+		return;
+	}
+
+	emit_slli(rd, rs1, 2, ctx);
+	emit_add(rd, rd, rs2, ctx);
+}
+
+static inline void emit_sh3add(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
+{
+	if (rvzba_enabled()) {
+		emit(rvzba_sh3add(rd, rs1, rs2), ctx);
+		return;
+	}
+
+	emit_slli(rd, rs1, 3, ctx);
+	emit_add(rd, rd, rs2, ctx);
+}
+
 /* RV64-only helper functions. */
 #if __riscv_xlen == 64
 
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index f5ba73bb153d..592dd86fbf81 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -811,8 +811,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	 * if (!prog)
 	 *   goto out;
 	 */
-	emit(rv_slli(RV_REG_T0, lo(idx_reg), 2), ctx);
-	emit(rv_add(RV_REG_T0, RV_REG_T0, lo(arr_reg)), ctx);
+	emit_sh2add(RV_REG_T0, lo(idx_reg), lo(arr_reg), ctx);
 	off = offsetof(struct bpf_array, ptrs);
 	if (is_12b_check(off, insn))
 		return -1;
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index aac190085472..39149ad002da 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -374,8 +374,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	 * if (!prog)
 	 *     goto out;
 	 */
-	emit_slli(RV_REG_T2, RV_REG_A2, 3, ctx);
-	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_A1, ctx);
+	emit_sh3add(RV_REG_T2, RV_REG_A2, RV_REG_A1, ctx);
 	off = offsetof(struct bpf_array, ptrs);
 	if (is_12b_check(off, insn))
 		return -1;

base-commit: 92cce91949a497a8a4615f9ba5813b03f7a1f1d5
prerequisite-patch-id: f2b95de7f0f5ff170ecdf723154da7a61e1fc77e
-- 
2.25.1


