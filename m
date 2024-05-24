Return-Path: <bpf+bounces-30475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373C8CE1CF
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFBA1C2074A
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195F91292D1;
	Fri, 24 May 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMRyxJ57"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785A6FCC;
	Fri, 24 May 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537185; cv=none; b=dmLZnzLwbPyUgBtJxKkzf9DqrKVpDf4MTfkDwoUq1fHWfmsf/lGSsctLSCAikeb3wqjwHO2U4/9ld2uNFylHNkAbcZZpBL5S8JSBJr4cPwgoNzjtCZNzu10FikBKYAEIiBgqIqoLanuPc7ICLo0PvBvrCgFElojbl87n+HU+Wpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537185; c=relaxed/simple;
	bh=wpFG1s8PYSDhqQqyrDF/Dhz/I5KMqnXKfyAlTsU7BRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wss8aT9yrwoNALmU8p5FANuf10Uu2YTX441MlFpMLPWBgNe5CLf0aSHzTcfeGhd0+vvt+GJLjd+mOIIAlecStbd9clXwSpJIJi9mZpb369l4c9taQEZjgS3WrEx4CZDxNNy9cKBoWJXpswUGJw3yM4wPZvEvlqFojFplsSFy+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMRyxJ57; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716537184; x=1748073184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpFG1s8PYSDhqQqyrDF/Dhz/I5KMqnXKfyAlTsU7BRU=;
  b=XMRyxJ57DwksGW2DhT8ARpG3FMuR5Lvko9DgIkcTapdF7e2qOTg0U4Xj
   SMVuV0KDasgC3tc9G5ITthcTMoJEswymktqBYslLj82n8Jt8/nXcHXX+k
   fBfpIn4pIWn9VJSS176Puf04dN8JR+/u7/KzmfRMgV7WYLoCyaFCh1ca9
   Mu6rWtXQz+vftVY1iPqkFa+tBwSIb9fpnBs46mWn2LBjUdqxRhsBAXJp+
   k5osvaP+Jg4BycGjAqUxQ+ScBrM8SuC1EqJlnhNhRIcn8aNf7ry7B2ObP
   cFi0F0MwEd5MoMW0pL9u9IFs81LwAcG2t+u97GWL4GuCVhJzUdcg6duV5
   w==;
X-CSE-ConnectionGUID: VF3PFR59QpSCPY5JVvIulQ==
X-CSE-MsgGUID: xiY+2LERRu+8J5b/06HCvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="15845973"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="15845973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:53:03 -0700
X-CSE-ConnectionGUID: QITdRlzlQFaoqJqCkVS2Kg==
X-CSE-MsgGUID: grYXd3QZSkuU+OC9LrVvUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="33953910"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa006.fm.intel.com with ESMTP; 24 May 2024 00:52:57 -0700
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
	Xiao Wang <xiao.w.wang@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH bpf-next v4 1/2] riscv, bpf: Optimize zextw insn with Zba extension
Date: Fri, 24 May 2024 15:55:42 +0800
Message-Id: <20240524075543.4050464-2-xiao.w.wang@intel.com>
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

The Zba extension provides add.uw insn which can be used to implement
zext.w with rs2 set as ZERO.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/Kconfig       | 12 ++++++++++++
 arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..a117adff5810 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -593,6 +593,18 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
 	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
 	depends on AS_HAS_OPTION_ARCH
 
+config RISCV_ISA_ZBA
+	bool "Zba extension support for bit manipulation instructions"
+	default y
+	help
+	   Add support for enabling optimisations in the kernel when the Zba
+	   extension is detected at boot.
+
+	   The Zba extension provides instructions to accelerate the generation
+	   of addresses that index into arrays of basic data types.
+
+	   If you don't know what to do here, say Y.
+
 config RISCV_ISA_ZBB
 	bool "Zbb extension support for bit manipulation instructions"
 	depends on TOOLCHAIN_HAS_ZBB
diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index fdbf88ca8b70..97041b58237a 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
 	return IS_ENABLED(CONFIG_RISCV_ISA_C);
 }
 
+static inline bool rvzba_enabled(void)
+{
+	return IS_ENABLED(CONFIG_RISCV_ISA_ZBA) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBA);
+}
+
 static inline bool rvzbb_enabled(void)
 {
 	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
@@ -939,6 +944,14 @@ static inline u16 rvc_sdsp(u32 imm9, u8 rs2)
 	return rv_css_insn(0x7, imm, rs2, 0x2);
 }
 
+/* RV64-only ZBA instructions. */
+
+static inline u32 rvzba_zextw(u8 rd, u8 rs1)
+{
+	/* add.uw rd, rs1, ZERO */
+	return rv_r_insn(0x04, RV_REG_ZERO, rs1, 0, rd, 0x3b);
+}
+
 #endif /* __riscv_xlen == 64 */
 
 /* Helper functions that emit RVC instructions when possible. */
@@ -1161,6 +1174,11 @@ static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
 
 static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
+	if (rvzba_enabled()) {
+		emit(rvzba_zextw(rd, rs), ctx);
+		return;
+	}
+
 	emit_slli(rd, rs, 32, ctx);
 	emit_srli(rd, rd, 32, ctx);
 }
-- 
2.25.1


