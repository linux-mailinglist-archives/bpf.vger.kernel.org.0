Return-Path: <bpf+bounces-28797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E08BE0BE
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA667280FD9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B11514FA;
	Tue,  7 May 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUQOJyOc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B591514E0;
	Tue,  7 May 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080380; cv=none; b=Wtkd7ZAPK3bdRu8R3WNEMuROe4PCKKQuSx62HfsQT+sFUh1aAJaHu1ekpExNfbjBKvfy3VKNGkj2j54O91ylCkowEqH2GL0Kw3wJtOFxhMqpRWn+ofsTbXZgJZjIHPkx43zYs90nQXxTuINUCuEMgqFZVrS82JEL/yxOoRPe2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080380; c=relaxed/simple;
	bh=vZwwfPun+jcrJFXKdn0WPiO85JreSPpf8VyM/d3hF3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TnlCVIwWbGZjUHt/idI4jTbu/JVXZtHJW3EiKMn2gtTTYZCOwl6qRUBBDQCSDJGtzDd30oCE9RvBLgrEokP0TXJNBqgRVMbFR0S9AoPT1fXA9WQSCAxY5jUlNzvugEWtvkZDGiHB6DNVK46eKf6705Hq4koySsee3DN/BE1JLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUQOJyOc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080379; x=1746616379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vZwwfPun+jcrJFXKdn0WPiO85JreSPpf8VyM/d3hF3Q=;
  b=aUQOJyOcXuk0xQj101q6BoaPUfOByJZh+GytipbSZR+Zj/W5nO9XlSTe
   p+T8Kke7C3/0S3f5sUFvyEJ1YWt6gT9e90O5qOsTJ9GErylYQYluTkOol
   F+MZqaFLzSqOiZjmiw3HNbMG5Sg1VU7VGuhaOQ1cZdLHZs2B/6t27IgbF
   QlDEom3460hxFO7N/2OJAw5aMRzLDIlSkLGLYVYNwOJ8dx65hm403SJAt
   bHQzvu1eKeBjntIKAFsy0lGHgbGBxUfgz1QG+oldnqji1xYvBtCp79sfh
   13FsLzAr2YmOvFfFpN6yQ0OI9l4TKjx/1Nx7EUhL0nFUc9LGc9WcRDViO
   Q==;
X-CSE-ConnectionGUID: OxbJEHk3SEmeJnD0JtWWug==
X-CSE-MsgGUID: 9m2p3pxSRraXkSvZVj495g==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10721233"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10721233"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:12:58 -0700
X-CSE-ConnectionGUID: shxD1AQuTimRHOLMV3dpFw==
X-CSE-MsgGUID: X6ObiS9hTta/WxyGh3BG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="28462880"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa009.fm.intel.com with ESMTP; 07 May 2024 04:12:53 -0700
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
Subject: [PATCH] riscv, bpf: Fix typo in comment
Date: Tue,  7 May 2024 19:16:18 +0800
Message-Id: <20240507111618.437121-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can use either "instruction" or "insn" in the comment.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/net/bpf_jit.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 18a7885ba95e..c1b6b44a2f49 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -611,7 +611,7 @@ static inline u32 rv_nop(void)
 	return rv_i_insn(0, 0, 0, 0, 0x13);
 }
 
-/* RVC instrutions. */
+/* RVC instructions. */
 
 static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
 {
@@ -740,7 +740,7 @@ static inline u16 rvc_swsp(u32 imm8, u8 rs2)
 	return rv_css_insn(0x6, imm, rs2, 0x2);
 }
 
-/* RVZBB instrutions. */
+/* RVZBB instructions. */
 static inline u32 rvzbb_sextb(u8 rd, u8 rs1)
 {
 	return rv_i_insn(0x604, rs1, 1, rd, 0x13);
-- 
2.25.1


