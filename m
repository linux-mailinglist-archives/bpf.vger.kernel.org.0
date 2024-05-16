Return-Path: <bpf+bounces-29843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD58C735C
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99ECB1C22946
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2619142E9A;
	Thu, 16 May 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlKtWInJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1A2D054;
	Thu, 16 May 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850080; cv=none; b=QsZoJUqSGaVIyrOsci8KM5R9nRijjQPEAfiPAC2fkdCquXjJ5Jjt2lWSZYJ6RRbrV786+didAKwYjfNHPFPeptdroDaBhrxF95sQhJ3Hn7p92wIaKOiEy/xN8MJU3nbCee05l9l7No+HsW4r3qXQoMwoApSvAEkDy9ngQFIm0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850080; c=relaxed/simple;
	bh=Qs2BtB30x40JRIKZiOWFcq+R7jv/plwfGPgi4oxWEg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mndi0xL6+T6fRl6RsoM8MeyI+nZcLVo/u7TQEdDf8P6oJrGX9Zl9a9qa64rp8MGVTi4VhsJATVEjGkz7BDRVwgrZv+C9a1e1A7wuEzMz3nRQlkuIE8fN3wpu4ZG/E3jHJwJXaEgdAEiTTCjlnUVuMfcGdn7aMy45CRdDzylcKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlKtWInJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715850079; x=1747386079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qs2BtB30x40JRIKZiOWFcq+R7jv/plwfGPgi4oxWEg4=;
  b=nlKtWInJUsiIC+udSr649/bJLdlitdABCJUbrX+ImQIoD7GVEXGRKtxt
   QL7781ol4TBOCO3voN9N/Eb/MakYBu3wVRU77Nm9V545Vvab3afHZ8X3d
   Z6b07638sRRCwTh7U9WutZmWulF2ev9I8ZoF5HgvW9wcKVoZlAeRHHayz
   bhce2Tezuc5MFu1RKvKYBok3qGYeVAFzmTppllPA2oEz07GG/HJDnbRup
   LEhyl+NtQkJIurqgahsfroER+2oQPMyG5fFBW2t1TXHscFHGYRh3dHRLV
   /dkmW71AqhwrTuuj8Xdo55TYWTWLAnfea4A+rJiEIpLSODsWEYvVV8k6v
   A==;
X-CSE-ConnectionGUID: l93px67XQEeXn4AN267HSw==
X-CSE-MsgGUID: ZrT26cqIQGqivcUY6Q6Udg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12058086"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="12058086"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:01:18 -0700
X-CSE-ConnectionGUID: rG8UIvklSymxZx+v86dtFA==
X-CSE-MsgGUID: prHw5wvCS5CmQDvFAFg7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31932782"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2024 02:01:13 -0700
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
	ben.dooks@codethink.co.uk,
	ajones@ventanamicro.com,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v3] riscv, bpf: Optimize zextw insn with Zba extension
Date: Thu, 16 May 2024 17:04:30 +0800
Message-Id: <20240516090430.493122-1-xiao.w.wang@intel.com>
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
v3:
* Remove the Kconfig dependencies on TOOLCHAIN_HAS_ZBA and
  RISCV_ALTERNATIVE. (Andrew)
v2:
* Add Zba description in the Kconfig. (Lehui)
* Reword the Kconfig help message to make it clearer. (Conor)
---
 arch/riscv/Kconfig       | 12 ++++++++++++
 arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6bec1bce6586..b64d55dc929f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -601,6 +601,18 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
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


