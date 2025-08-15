Return-Path: <bpf+bounces-65791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E162B2874C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 22:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA1D568CA9
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC542D0C93;
	Fri, 15 Aug 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmUJt88j"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881F2BEFE6;
	Fri, 15 Aug 2025 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290535; cv=none; b=FbnFAu3GGF0mexpbswX9oHgKttP9M2fK06Of+ev2dFsn+bnh0pfiJuY6S9H/LkiVIA/1oOi7M0lgX/BYeUIF1PeCqtjFk4Hn/RIRA6ZUbMhM7jhnoWnmmtiQS0tlN9v5pf7uOjhYkSBWg+iw7PBW7J2u8raK7P/wF3b9mIc5qKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290535; c=relaxed/simple;
	bh=lEexlMAJtMs2SOV8xPbcfflc9KbjIYTxqL6E+qzFfAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6ivRcv/GRNjJ7+m9EPbZygN+erfjadvhLfW6c1RtsmXLCDpG1er+llbwrUCthPpDQ7HmejLvwGPPOGU8edDOK2nJkkqguUdL6T+l4w2wiAFPVpvvd4Ce864U0nkuc/GjYzgY/bf6cSN4ou0d4D0xjnXLKItU9CkcYuRFk2aO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmUJt88j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755290533; x=1786826533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEexlMAJtMs2SOV8xPbcfflc9KbjIYTxqL6E+qzFfAI=;
  b=PmUJt88jcbQY6lH4PBooQVrB42jg0LWalBCW9oj7xmMEUoR7qyP+zIFH
   L/UUfJ4AGhGBVIUjlkmmbn+t7GLJymb8rvpxkWSTLr8i6zNpavgM29Glh
   DZfzpNAqruoh8r0Ks04H69t0fB3wzeE7Yi7MIHpaDv0g61cNjxMO7cV6D
   nhN767qGi2pcOtptVnhPcVMom1wF/wmFYvIEmJbYB1pSKplqAU1Txabaf
   5/E1wNA4B3opDC73LzpSVS7kGyAiWK6Yc9DdYx9nkrEfK6mEmVFTJqREB
   CC1SWI2BSKhwdRahdODwIqKrr62dQPoaNrngh2sgM5qg2BrbqT765mBQE
   g==;
X-CSE-ConnectionGUID: np1+/UzuRpGt+FnCkh0Q8A==
X-CSE-MsgGUID: sQpKSDe8TnGtlRbq1sbvcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68320317"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68320317"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:42:11 -0700
X-CSE-ConnectionGUID: NogNVJfLSf2GUQcrXhasbw==
X-CSE-MsgGUID: qK6cxTOCRES1EDEIeGZRgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198084323"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2025 13:42:10 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 4/6] ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc
Date: Fri, 15 Aug 2025 13:42:00 -0700
Message-ID: <20250815204205.1407768-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
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


