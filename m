Return-Path: <bpf+bounces-51184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06CDA3180C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE667A280B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41D268C71;
	Tue, 11 Feb 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBO1IAZV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7C263F3F;
	Tue, 11 Feb 2025 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310235; cv=none; b=daqoCDGfr1m1O/cDwVtszo06GFZBvTie1aBNy+j8sQnj5frs4y5hj5Nqa6KOcjyEN8AQFhaT2UT6ltPIpnQ3pPp+8DJXH+qLh4FQvUBJdNGUQuEZmZtIUXtgYyq/8TV7t0MxpcVKHMQ9Ep3W+BbtiHxdsepgYs3pz2FRlB7tJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310235; c=relaxed/simple;
	bh=U/UHenFl0UILNVEOoSUdTTH1ha9BJCNFmKk+4XYtxW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDB3CPxlf1tReRKW0jD/a1O9HYJHN2BVs3UrLVVDI63GCN43+y8M96e70GmQrXwuR2xoIFCtmmC7IJ+F553hWn3OdRoQDzvz/AS6wclfOCnt8TMNh8cc3PG8FkpTC8TpuZ+Oen9jH/qP5PiX0Aepv2ciV/f4hxHMXTUN0j3QbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBO1IAZV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310233; x=1770846233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/UHenFl0UILNVEOoSUdTTH1ha9BJCNFmKk+4XYtxW4=;
  b=bBO1IAZVTqdC7GgGduo7C6wiRJJvPBFsFLEulWjsQWrQ5xilLA5bHVAo
   PXXXByTqXCYUMUOYO2+/ejKdz8ZN4f9Tbag3JKd5m1fhTjz+UPt/uS+cN
   U0zY/+K12rZRCGbiPaibHuokVIT/qnDnKYrCsM0xZtfA5tAA8vzWEDpfO
   KFqCht7NgWP1K8/0b6A4ktH2xb1Q8w9hXU2Q+x8cGFbe8QIrPXKN62Khm
   pUbO0tJDZHPv+23y9MiZ1Jceb0qQ4w6C5k0OdoGO7bXup+ffycFx9vfnb
   5bPsNb7xQR/gjxxrhLKSspP4BkgMfBYC4/SmvxJSJQ8DXOyjrmHMgrne9
   A==;
X-CSE-ConnectionGUID: bkLdVgK2Q7GkwQREa4SzrQ==
X-CSE-MsgGUID: L93tV3LdTTG1nbu/dnMgqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39185243"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39185243"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:49 -0800
X-CSE-ConnectionGUID: u7ez2ZUqRYmugVfQGi6bQg==
X-CSE-MsgGUID: OP/XXeu4RcORaUJdENUXCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143478678"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 13:43:49 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	horms@kernel.org,
	yuehaibing@huawei.com,
	dan.carpenter@linaro.org,
	Saritha Sanigani <sarithax.sanigani@intel.com>
Subject: [PATCH net 4/6] ixgbe: Fix possible skb NULL pointer dereference
Date: Tue, 11 Feb 2025 13:43:35 -0800
Message-ID: <20250211214343.4092496-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
References: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
encoding. Propagate this logic to the ixgbe_put_rx_buffer().

The commit also relaxed the skb NULL pointer check - caught by Smatch.
Restore this check.

Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/intel-wired-lan/2c7d6c31-192a-4047-bd90-9566d0e14cc0@stanley.mountain/
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Saritha Sanigani <sarithax.sanigani@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20c9a30..467f81239e12 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2105,7 +2105,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
+		if (skb && IXGBE_CB(skb)->dma == rx_buffer->dma) {
 			/* the page has been released from the ring */
 			IXGBE_CB(skb)->page_released = true;
 		} else {
-- 
2.47.1


