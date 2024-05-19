Return-Path: <bpf+bounces-30016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9DF8C9370
	for <lists+bpf@lfdr.de>; Sun, 19 May 2024 07:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406C51C209C7
	for <lists+bpf@lfdr.de>; Sun, 19 May 2024 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4810EADA;
	Sun, 19 May 2024 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9a8la5A"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624C4C7D;
	Sun, 19 May 2024 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716094919; cv=none; b=TEdOmZJRqDGjF1DoGmDSr/AmStbdX68yFCjgjt2H/eEBgLP90k2x7v6NP6qiDsuwjPXav1FLH3Gk6gbsaIg82SnBVeL+3A4o//luzer+vCcvwpITHl5xpioLxotmg/bSwwFIl0tKF7fOPB/gJCyw9CngGaFkdtDfaRvG9yE+K/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716094919; c=relaxed/simple;
	bh=JOXyQnL/Rd4T3+2ptcou/ugUznzFoHrhbhcuHxJtPgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxeYRGz3ErzkDRH5hB5qtivOs6GZ30zEuIYK5ibZCTqB+usQCthP9CowJQkByQNrzLtGUKb5oHL/CfxIUFe7grjMJZS3KtnicBXnJWjnr9DoG4oK0ibCS9TpJkUbLPJLP9qSNZRLS7LOsLBBAD65xzSLHwjB1JGnepkLynbx8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9a8la5A; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716094918; x=1747630918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JOXyQnL/Rd4T3+2ptcou/ugUznzFoHrhbhcuHxJtPgI=;
  b=i9a8la5AyLwCoYrleumy0KiRFJ5OZi2hcnYMLCPcUi4dvYEa0YxJZBPw
   uNk5govzlfm+fU7jiZaYh+1K3TEZn0vBcSHgoY2KatEkOO592YxYTVB/h
   dTslMkqizUJ3C9G3xtQ5o7+a6uxFYRn9TP/fOiQ0BXkAiWYtmlfavN5w5
   fKmY/LgKSNtGvP0WmztLaxc9fRty+bViLPYzsgn4StHukOozqIny7xCGh
   JYwwHK7TwPT7jSfwEdo3MvEQAHr+8imn62qLOBKY7Oob8LUUGd0aj29Lo
   lk/5s/X3xyrHDPpokvaJxA+8UNEFdJ1/wqvGsfgbyjH6EYVrb6HWbigVc
   Q==;
X-CSE-ConnectionGUID: pI4ZDnG2T5e3HTVNifWIDw==
X-CSE-MsgGUID: CGqVs2yLTFyDVMcQKPtErw==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12182837"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="12182837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 22:01:57 -0700
X-CSE-ConnectionGUID: VMTxTzD9SMe76W4d80VeWw==
X-CSE-MsgGUID: Mf1dO27hTISmu4yA6Z9XBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="32110053"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa007.fm.intel.com with ESMTP; 18 May 2024 22:01:51 -0700
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
Subject: [PATCH] riscv, bpf: try RVC for reg move within BPF_CMPXCHG JIT
Date: Sun, 19 May 2024 13:05:07 +0800
Message-Id: <20240519050507.2217791-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We could try to emit compressed insn for reg move operation during CMPXCHG
JIT, the instruction compression has no impact on the jump offsets of
following forward and backward jump instructions.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index aac190085472..c134aaec4295 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -531,8 +531,10 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 	/* r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg); */
 	case BPF_CMPXCHG:
 		r0 = bpf_to_rv_reg(BPF_REG_0, ctx);
-		emit(is64 ? rv_addi(RV_REG_T2, r0, 0) :
-		     rv_addiw(RV_REG_T2, r0, 0), ctx);
+		if (is64)
+			emit_mv(RV_REG_T2, r0, ctx);
+		else
+			emit_addiw(RV_REG_T2, r0, 0, ctx);
 		emit(is64 ? rv_lr_d(r0, 0, rd, 0, 0) :
 		     rv_lr_w(r0, 0, rd, 0, 0), ctx);
 		jmp_offset = ninsns_rvoff(8);
-- 
2.25.1


