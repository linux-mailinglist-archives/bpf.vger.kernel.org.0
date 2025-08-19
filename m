Return-Path: <bpf+bounces-66046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D9B2CF47
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 00:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47582586DC3
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945731DD95;
	Tue, 19 Aug 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J19HPxIm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DB308F16;
	Tue, 19 Aug 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642009; cv=none; b=fttHCtH9X8nCsYp9fu2hi/aihoy6szz05tU/743iy7has1PprDejgYrpp3+16NXRkLQnMvkeGb19doUHkn70AzEySkmHiQ/BBAmfThkiWOKCLRPl+qj/40YXc+16uuGSwy1ME++lrhJ0T/7LjoC33Wedff6qBYMkgyjODwMT4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642009; c=relaxed/simple;
	bh=Y1gJcmKzAjtJHlZtBlefjGpXGCoJCpipKjcg2/uVoSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2bYOYUx/C38rJWYjjlwbZszvIq3yw1o/knwR+hxiFRncCRgsFRVsYaILe24q9Wkcuyypu+BFZi29v8dx18VGlfk6YDKghk0cE3djcGzESqMvoMS2gWeT3Bg5SUW0jOZYFvEq0IDQVhxkvkgPqJBsxs/PPp2SMVtSWNkO8502Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J19HPxIm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755642008; x=1787178008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1gJcmKzAjtJHlZtBlefjGpXGCoJCpipKjcg2/uVoSE=;
  b=J19HPxImtQCT6dLsI/hMtciiTiGTejZ5ghslSyB87ZvPRPShXaZu4SvG
   Yta6XfK2zHVZXkw0jesgXboF9WJdyTTugVN0SiTz1Ria5KeHL8d9f501s
   NBId3pgts0RuWnGk1b/P+Hmw3yOEzRZj02Lo24sJUHs8cNuzx3VkSni3r
   UZ+cRWW1/sTog9SPk/x49SPEzhIadMYBMcCrJO79y75gTYlGMDUJefy9L
   hl9ikx3pNqejiwFBxSuZEIE51nfYQLC2S7uaAt8wFpUiugzoqdAZmAekp
   2v+J0hsjkXltT+yRtKoo5uEywx/dNnJiB6+OCS4jVPsLS+YEBjOGeqDEg
   Q==;
X-CSE-ConnectionGUID: 5TOLoNnBTWuZIg7P4UqgNw==
X-CSE-MsgGUID: iBU/RNLwRzuNYQTSIUY3nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57829564"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57829564"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:20:06 -0700
X-CSE-ConnectionGUID: PmUl2fZBQ6eDjAoVq+SFYA==
X-CSE-MsgGUID: fOeTSmGYTx6jpR/CinDBVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173202845"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 19 Aug 2025 15:20:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	bjorn@kernel.org,
	przemyslaw.kitszel@intel.com,
	larysa.zaremba@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Priya Singh <priyax.singh@intel.com>
Subject: [PATCH net v2 3/5] ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc
Date: Tue, 19 Aug 2025 15:19:57 -0700
Message-ID: <20250819222000.3504873-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Resolve the budget negative overflow which leads to returning true in
ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.

Before this patch, when the budget is decreased to zero and finishes
sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
and enter into the while() statement to see if it should keep processing
packets, but in the meantime it unexpectedly decreases the value again to
'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
true, showing 'we complete cleaning the budget'. That also means
'clean_complete = true' in ixgbe_poll.

The true theory behind this is if that budget number of descs are consumed,
it implies that we might have more descs to be done. So we should return
false in ixgbe_xmit_zc to tell napi poll to find another chance to start
polling to handle the rest of descs. On the contrary, returning true here
means job done and we know we finish all the possible descs this time and
we don't intend to start a new napi poll.

It is apparently against our expectations. Please also see how
ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
to make sure the budget can be decreased to zero at most and the negative
overflow never happens.

The patch adds 'likely' because we rarely would not hit the loop condition
since the standard budget is 256.

Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Priya Singh <priyax.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index ac58964b2f08..7b941505a9d0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (budget-- > 0) {
+	while (likely(budget)) {
 		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
@@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
 			xdp_ring->next_to_use = 0;
+
+		budget--;
 	}
 
 	if (tx_desc) {
-- 
2.47.1


