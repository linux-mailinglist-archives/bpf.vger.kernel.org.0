Return-Path: <bpf+bounces-40714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD39F98C674
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530121F25204
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F031CDFC7;
	Tue,  1 Oct 2024 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY4lbjy0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B31B86E6
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813179; cv=none; b=e0AnumAtYM7bBCe6yIES+MeVm3bWLjly/b+/T/Kyh401V5wqVcaO+G6kv33V8VM1AruOYCFOSnXXvfKmTXyyN8nPtiWN6oTZv4H14t8+R9rk1YdGMSuBr4Hy7+tmv1ZKEHxFi2s6jqOzKrWdfovcH73ZCeIO2bx/yir8IDE3FSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813179; c=relaxed/simple;
	bh=RY+PxXab3MagvLOKzFyC5jgnBeo0dCSgJ2+vTJM0BlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGWt0sWsyYaqa0EjCcln9A11NHPEDRBjys5cdICCVaQXkXgJcSInJOIuzff+HFdVM7+C6jbknJEFIkORcHWJFcYaN7KZIn/xeBdug+ttUeG/qsrHy1GmbbqYR9Op69mfxmDixMzhXMgPBS0MS97jxAKrmQ3FgpJx7MXWY/e7qxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY4lbjy0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727813177; x=1759349177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RY+PxXab3MagvLOKzFyC5jgnBeo0dCSgJ2+vTJM0BlQ=;
  b=iY4lbjy0DJuKCtGAIFyfMrocqiARQZe2Nu4ERq7HEPubuRjXathXbGsd
   W0NYgLHUfgNMJS1tq7XhF+S4glAs4n7PTa5P5FrvONgIAaQ1fjCQ7ysjG
   9UiuQW+vWa+pNLaO5jJJGQ/wRf67VqWQGZLcWg6HFUrd1IqHjd5WjGK+6
   /JILLSsYbk3wflt+5fTyhBjlYfA3MFbxkkjgNm4x7Tle07dnzLB+WK0pk
   5oejCql7LOfmI6VzGTpA5mPDpMEB+ffMOWzRuu4OvXy1l0LAqtnMd0WAe
   S7ZeIiwy5o2iWfHsoIrILStEQdj9MtvFCTAWYbBvrDHS1tOz7ljtNo3rw
   w==;
X-CSE-ConnectionGUID: +SbPdKdvR8KpA3cTMO6B5Q==
X-CSE-MsgGUID: peZM7HiSS6OzLmzAIOmpzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26429776"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26429776"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:06:17 -0700
X-CSE-ConnectionGUID: FIgZM/T4TLizs5SXUrZimw==
X-CSE-MsgGUID: Jvd50jImR8q5YigiYVfD7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="74581742"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 01 Oct 2024 13:06:15 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next] bpf: remove unused macro
Date: Tue,  1 Oct 2024 22:06:05 +0200
Message-Id: <20241001200605.249526-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7aebfa1b3885 ("bpf: Support narrow loads from
bpf_sock_addr.user_port") removed one and only
SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD callsite but kept the macro.

Remove it to clean up the code base. Found while getting lost in the bpf
code.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/core/filter.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8c520634043d..a333620cb68f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10284,10 +10284,6 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 		}							       \
 	} while (0)
 
-#define SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD(S, NS, F, NF, TF)		       \
-	SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD_SIZE_OFF(			       \
-		S, NS, F, NF, BPF_FIELD_SIZEOF(NS, NF), 0, TF)
-
 static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
 					const struct bpf_insn *si,
 					struct bpf_insn *insn_buf,
-- 
2.34.1


