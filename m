Return-Path: <bpf+bounces-30361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB1F8CCB02
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 05:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6EB1B21177
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD613A41E;
	Thu, 23 May 2024 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRZhpxJW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458618E11;
	Thu, 23 May 2024 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434133; cv=none; b=Z5tod9Ub2Hs0t5zeTBqFD3QA3g0mMM++/d2XZPLiYbFQfvmQBIIXdIYL8byKTf734g53MeJuTTGmpj6W9VwUELPTLmkAYcW5x9ziiJ8btzTE/xthZr0Es2md6s3FxuxioEPSVnd64MFiJMCiKDXaguTvMykF5o6s9b2M9lO5kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434133; c=relaxed/simple;
	bh=mnc3vPUa53ZuitOW/W9PdnOeYFxVvgU0shbAspLPL5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i5ZUMwl8MN2pRaorjipROnDRniXl/1xggcIw89zyR0nCXbIvcyJ2EQmQ6hbzM603pP98QHgf2mVDx+scRI8kuUv+8ojm5jrxhiGHePiGF8EFR+NbrquqNk61T6SlCloPVULjlPBO1jHtNi1hvK9t+b5NGHNOTPmLGdyzIi3tmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRZhpxJW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716434132; x=1747970132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mnc3vPUa53ZuitOW/W9PdnOeYFxVvgU0shbAspLPL5Y=;
  b=IRZhpxJWo3xQUYEsy0g7XPyU5lovhZJVkeYNqYukeRKL5col0Vio3nPR
   P755f5N3YftpmrmtW2m9o39xeEVuj0Qn6yUmz6uhoj5BT3L1wTqO9tSRa
   dAvuQgYtkIW+2b0rUZWLteWXipNcIsUgdy5B0dtLTge+0O5U4oK83W7B/
   UGoAV8DXiU58p0uk3bib6mNR3JEnCusuzWSED78ggRpaPEY65zaKHk96L
   igw63KdA8CANzMRb9QN14Armi47XL21dSkWYIjGrQwosDNE63tKAa4CH9
   +lIzYiKPry//RDms21y0lcGcEX+hwPMLMqdJshOyANiOsJhFG/4frtidQ
   Q==;
X-CSE-ConnectionGUID: lxc6ThHLSlGQuTAGTDhDhQ==
X-CSE-MsgGUID: l1bhAR7mRVShYfiYwupXxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16514486"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16514486"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 20:15:30 -0700
X-CSE-ConnectionGUID: BBZrUNMUQzqvWJRz7huJ/w==
X-CSE-MsgGUID: eBTIAcpCRK2wCOLPuCcgWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="34056639"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by orviesa008.jf.intel.com with ESMTP; 22 May 2024 20:15:24 -0700
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
Subject: [PATCH v2] riscv, bpf: Use STACK_ALIGN macro for size rounding up
Date: Thu, 23 May 2024 11:18:35 +0800
Message-Id: <20240523031835.3977713-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro STACK_ALIGN that is defined in asm/processor.h for stack size
rounding up, just like bpf_jit_comp32.c does.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
v2:
* The patch targets bpf-next tree, rather than riscv-next. (Lehui)
---
 arch/riscv/net/bpf_jit_comp64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 79a001d5533e..c21a0ff23415 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -868,7 +868,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 8;
 	sreg_off = stack_size;
 
-	stack_size = round_up(stack_size, 16);
+	stack_size = round_up(stack_size, STACK_ALIGN);
 
 	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
@@ -1960,7 +1960,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
 
-	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
+	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
 	if (bpf_stack_adjust)
 		mark_fp(ctx);
 
@@ -1982,7 +1982,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 	if (ctx->arena_vm_start)
 		stack_adjust += 8;
 
-	stack_adjust = round_up(stack_adjust, 16);
+	stack_adjust = round_up(stack_adjust, STACK_ALIGN);
 	stack_adjust += bpf_stack_adjust;
 
 	store_offset = stack_adjust - 8;
-- 
2.25.1


