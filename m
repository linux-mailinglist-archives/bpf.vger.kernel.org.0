Return-Path: <bpf+bounces-30476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB78CE1D1
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D731F210B4
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6341292FF;
	Fri, 24 May 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFGme1kC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E86FCC;
	Fri, 24 May 2024 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537191; cv=none; b=DagKg1EkS3VZRoBuyqaqUDgj1Scir6B4BZvP8z5CBug5IdAULvdtFLWMCi9G/PiovKHFbdfnNbxpjHN2+OzJRt1MUpWW61+J9GA69KZQSCI171kEXlN3u+7J54O6QJ3M1lZC4+nXd2T3SzA6zzFElmVJapk2if0T35zzbjzPdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537191; c=relaxed/simple;
	bh=24rp/WrT9pHPUaGJNcHcPwIVsZW4SZ2btnKiehAt6f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfwuUhGPmjtzoCx5o1ZG14KylSDXqj9JEvDGUt7eGR5Ir48N6jJTZQ6lwqijquJVIDPBpBtGe8/SUOWXSWfB3z5P2EjKnYZ86v4aSjPe0zzNX21nx9+zcyHT2MtK3ZEfVtmGZnlIfQjrA4SZQ/Gfbxb4VHWARvR0n81v71U0OCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFGme1kC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716537189; x=1748073189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=24rp/WrT9pHPUaGJNcHcPwIVsZW4SZ2btnKiehAt6f4=;
  b=mFGme1kCTEgr37ucOTwq0YBFHzic8yNSmlti0hKEJkjVVl85JRV6Y61J
   yoz9jnm0XpPS1ocXSH7dYff4u8IY7X+NTxqc383DgyELMnxYSHSgvc6nC
   w8Jw37m48/VGqbPEAYHnJwEo78XFcSjAElgsNp42xOlM6mrHNw5/86SvA
   VOIISl6uyrC4z7w/R2HOd/d6UIIulUx+KTe0QbJL/c37rr5QJyaOopNQo
   3SpIMItZ0DyHOth6TwWgFyZnOe2Igt918GM1gDQsUx3wFaeQ5RhrhKUK/
   NWSPIVbPve7fd1RWeNwgsaCUZzlW9fdlgPNuPv8nlRfHgbB9HBAphIphK
   g==;
X-CSE-ConnectionGUID: WjAKBFm+SlKo7dKMQL3hXQ==
X-CSE-MsgGUID: +ydOb32yQW+zygMRWTJ9hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="15846002"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="15846002"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:53:09 -0700
X-CSE-ConnectionGUID: hoI+mS1CT/i21woqbc6A6w==
X-CSE-MsgGUID: ZE0unwlWR/KX39Mr84rR0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="33953931"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa006.fm.intel.com with ESMTP; 24 May 2024 00:53:03 -0700
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
	puranjay@kernel.org,
	haicheng.li@intel.com,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH bpf-next v4 2/2] riscv, bpf: Introduce shift add helper with Zba optimization
Date: Fri, 24 May 2024 15:55:43 +0800
Message-Id: <20240524075543.4050464-3-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240524075543.4050464-1-xiao.w.wang@intel.com>
References: <20240524075543.4050464-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zba extension is very useful for generating addresses that index into array
of basic data types. This patch introduces sh2add and sh3add helpers for
RV32 and RV64 respectively, to accelerate addressing for array of unsigned
long data.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/net/bpf_jit.h        | 33 +++++++++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp32.c |  3 +--
 arch/riscv/net/bpf_jit_comp64.c |  9 +++------
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 97041b58237a..1d1c78d4cff1 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -742,6 +742,17 @@ static inline u16 rvc_swsp(u32 imm8, u8 rs2)
 	return rv_css_insn(0x6, imm, rs2, 0x2);
 }
 
+/* RVZBA instructions. */
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
 /* RVZBB instructions. */
 static inline u32 rvzbb_sextb(u8 rd, u8 rs1)
 {
@@ -1095,6 +1106,28 @@ static inline void emit_sw(u8 rs1, s32 off, u8 rs2, struct rv_jit_context *ctx)
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
index 79a001d5533e..30ede3ce42d1 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -380,8 +380,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	 * if (!prog)
 	 *     goto out;
 	 */
-	emit_slli(RV_REG_T2, RV_REG_A2, 3, ctx);
-	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_A1, ctx);
+	emit_sh3add(RV_REG_T2, RV_REG_A2, RV_REG_A1, ctx);
 	off = offsetof(struct bpf_array, ptrs);
 	if (is_12b_check(off, insn))
 		return -1;
@@ -1097,12 +1096,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			/* Load current CPU number in T1 */
 			emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
-			/* << 3 because offsets are 8 bytes */
-			emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
 			/* Load address of __per_cpu_offset array in T2 */
 			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
-			/* Add offset of current CPU to  __per_cpu_offset */
-			emit_add(RV_REG_T1, RV_REG_T2, RV_REG_T1, ctx);
+			/* Get address of __per_cpu_offset[cpu] in T1 */
+			emit_sh3add(RV_REG_T1, RV_REG_T1, RV_REG_T2, ctx);
 			/* Load __per_cpu_offset[cpu] in T1 */
 			emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
 			/* Add the offset to Rd */
-- 
2.25.1


