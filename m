Return-Path: <bpf+bounces-30262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D68CBAC2
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 07:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9ED6B21757
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 05:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC177106;
	Wed, 22 May 2024 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQ3HWlPd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB726F067;
	Wed, 22 May 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716356521; cv=none; b=VtxjhhGNKuyZDLnvJ60BX5FPboGUSnxFhYG1f1DWYKEpUOfu2RhUpwEON0MtMggxIAFYOQpFMc7HvXi+Rsd9tdJtXWHE5q3xYXtCDztd4mwTcajqOmUkrh1xCAgCwuWVf9yR6Puu90TPmKE4wtlwMDfLyNayvGkHkm2WQn5sabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716356521; c=relaxed/simple;
	bh=DNOmOODdlXynNw2098gR2o08KbJJt+rlhW8xtv8itE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gGCW4Igyt+GhQ/pNCa9mDLkZ0rMC6Cq/1uZNCxfL2baT5UqschOBz0txwR6F9C/ONJ7ay9h6aIZpk7URMeJyTnCwQCI7Kas+FrT4a2tn3HGQ0ITjyIGLi9b7X2ysLqXrfrveM2AgQbLU6dni1auo8/bWqjEjT7wGwjwOSIU3xCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQ3HWlPd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716356519; x=1747892519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DNOmOODdlXynNw2098gR2o08KbJJt+rlhW8xtv8itE8=;
  b=FQ3HWlPdyxJTbTchvKnNfCMPaf2vSTWPaaGE4b2Ah8KIDYC7xd5FzPDf
   2WPEVpIMdoZX4cYJHxHc0Q3VVFZXFNeeFMIUTGTh9gHrhiocmLqeXWfhJ
   unGpbIG8+N6JlyTl9ehFp9vVyhUXqv3xKVglptmn+CytLcfjZiP2Oz0oS
   HWMLLXJtS28J/go/CQKck2BqQjd3hfwIcWinOWuI8qpCt+7Ch+2/mSasz
   ZXlBKx/G3M9mRNA1Jvd07WVeaBTf+Jy80UG2YAuThyndNBRGGFYKSzUnb
   1J6ha+Q9dsWv50Nt6rrpbwpfF5BSOiLOShRNPu4R4MJXlGbUpKz4azetr
   w==;
X-CSE-ConnectionGUID: 9NssqFZyQGK3E6IhAgUfSA==
X-CSE-MsgGUID: 0ZqYTFTiSg+ChrA3oDz/Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23990822"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="23990822"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 22:41:58 -0700
X-CSE-ConnectionGUID: 2Q1tF3BvQ9S+lXXvTMhpug==
X-CSE-MsgGUID: ms7XDvyHTui40I7vtTbvbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37922008"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by orviesa003.jf.intel.com with ESMTP; 21 May 2024 22:41:53 -0700
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
Subject: [PATCH] riscv, bpf: Use STACK_ALIGN macro for size rounding up
Date: Wed, 22 May 2024 13:45:07 +0800
Message-Id: <20240522054507.3941595-1-xiao.w.wang@intel.com>
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
---
 arch/riscv/net/bpf_jit_comp64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 39149ad002da..bd869d41612f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -858,7 +858,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 8;
 	sreg_off = stack_size;
 
-	stack_size = round_up(stack_size, 16);
+	stack_size = round_up(stack_size, STACK_ALIGN);
 
 	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
@@ -1723,7 +1723,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
 
-	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
+	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
 	if (bpf_stack_adjust)
 		mark_fp(ctx);
 
@@ -1743,7 +1743,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 	if (seen_reg(RV_REG_S6, ctx))
 		stack_adjust += 8;
 
-	stack_adjust = round_up(stack_adjust, 16);
+	stack_adjust = round_up(stack_adjust, STACK_ALIGN);
 	stack_adjust += bpf_stack_adjust;
 
 	store_offset = stack_adjust - 8;
-- 
2.25.1


