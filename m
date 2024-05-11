Return-Path: <bpf+bounces-29581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C68C2F0F
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 04:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D27F1F22F60
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43772208E;
	Sat, 11 May 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZM+XpWx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903B17571;
	Sat, 11 May 2024 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394684; cv=none; b=rJM5qdfUpL2aLizI5FksGuYi+hv4AmP1XhpOlW0x5FoCkvD5SGmnMWNMttxbO2JlM7fmsCti8YfW4kMALA5l3iaafT7GlGkh1igrQYWeKwETc5PRuOEHUUMxj+TGDg1VU+W+EB9H3H/5v2hbP7PnvYU6mACEnmdKZ0NC27HGTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394684; c=relaxed/simple;
	bh=zOqj5z27hn5Ja+9Hiogv2yU6ck56jE/mAfjwUewOMc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDWcespbbSSxJPgbVBIRdpaQFumjZDVLTKcS9E/SR6LiTe1EgtPHMeKnxPkFZPZywLEwKkqz+im+3f+0M9TTtM7Kxdd8EXXQcLrg1vvF/uGn9FQYvAcyP7f2kb0bnz4uhTm/jshkxv94sMmnEAo1KetaVbMo6IEEenirYkrnr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZM+XpWx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715394682; x=1746930682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zOqj5z27hn5Ja+9Hiogv2yU6ck56jE/mAfjwUewOMc8=;
  b=gZM+XpWx1hPVbs3UBNsx6ksP14Z/vrP0ygDDbnsQ3p82hxrzEZRkSfDf
   sUH3r0l9R8QyxC4q5w1Lc2+/Kg+5YW+iHZCjH9IyuwH3jcff8FK8ST+CN
   DdylvODsM+Vh//oLdKqZh3hI101OtsAXXjWrTlvgZT1Q3+SFfzqhpkho4
   n6gwRW5pPXpNmiMrxbTyNVrCIKhT4LLpTdAXfNxAQqNJewVlh0vy34IVT
   hh4iKNLqdz3/7Lb3+iADcbqoEXpc3LnznafA4tOIt/PoWJB6UBwWuOCt4
   eCjiA1heH7A0iAUgX5XJVwB7Hbi0hvGejYulKNPYA37+yESIghc1xyZlh
   Q==;
X-CSE-ConnectionGUID: xISefGm2TDOJ+NRiJ7RQyA==
X-CSE-MsgGUID: xNLJXQUwQsKlo7aDiO1GTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11532824"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="11532824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 19:31:21 -0700
X-CSE-ConnectionGUID: 9UgOqJBlSziTAnLQ3DxYtw==
X-CSE-MsgGUID: 50XnkUn5TWqBlry7JtN2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="29867299"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa010.fm.intel.com with ESMTP; 10 May 2024 19:31:15 -0700
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
	conor@kernel.org,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Date: Sat, 11 May 2024 10:34:36 +0800
Message-Id: <20240511023436.3282285-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
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
---
v2:
* Add Zba description in the Kconfig. (Lehui)
* Reword the Kconfig help message to make it clearer. (Conor)
---
 arch/riscv/Kconfig       | 22 ++++++++++++++++++++++
 arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6bec1bce6586..e262a8668b41 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
 	  preemption. Enabling this config will result in higher memory
 	  consumption due to the allocation of per-task's kernel Vector context.
 
+config TOOLCHAIN_HAS_ZBA
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
@@ -601,6 +609,20 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
 	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
 	depends on AS_HAS_OPTION_ARCH
 
+config RISCV_ISA_ZBA
+	bool "Zba extension support for bit manipulation instructions"
+	depends on TOOLCHAIN_HAS_ZBA
+	depends on RISCV_ALTERNATIVE
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
index f4b6b3b9edda..18a7885ba95e 100644
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
@@ -937,6 +942,14 @@ static inline u16 rvc_sdsp(u32 imm9, u8 rs2)
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
@@ -1159,6 +1172,11 @@ static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
 
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


