Return-Path: <bpf+bounces-19945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5224B83318B
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097C0281AB3
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D25A78D;
	Fri, 19 Jan 2024 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khJTWXx/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A359167;
	Fri, 19 Jan 2024 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707077; cv=none; b=qRTKq3tUOK6zMG7EIzwEHrc/WhuEoVsNUAZE9ffYcgKpOMxw+uvCOb0vIN+dfd1IvW3dC3eG/zEB8TjsckjWp9kXVx7CdbU9xBgmc5xpvtXg6E+n7sbVEE5bNsPDmXi7w3J0wAPMAeNgy529txV69G+DzPGsHTq+2bVuJACK7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707077; c=relaxed/simple;
	bh=uk1v+YmAz1abmrXNSE2Dm4Tyo3Zhodkm59mXrvTrAN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSVG/aQ9kymBSZyKxSgTFBSkV2rj7JEgesBQpnaujjdq/6s54jI80aGHvAA4KjqkDMMrZ+yLQviqaQsk6+M3WlXwpJnUxS6Hu7jLaAE982wK1ti/lZQDD4QqKjp6OtsnKNewYbxUw42A++ffW5mn9RUaczmtyUiT8WcBmc1z+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khJTWXx/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707075; x=1737243075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uk1v+YmAz1abmrXNSE2Dm4Tyo3Zhodkm59mXrvTrAN0=;
  b=khJTWXx/ZEkJfIdZHj0qMWV0fP22z8D3aZ/k0FbhrTWmGFiRCdnGLkuK
   svmJDImHQ8DqWpkXjqKV9ikOZeIhwP/cgOv1dg8BqDKCqwDu+0lYBwg4D
   a4zrcyvciQ71nLA8xQcfAE/xGmb4nrwsW0oYDOrJ8w4oiaGZg9MfIEpkG
   hFr8o99oKDAcDPWl7rZnS51x0Gz3JIKMaq7fV4y9xB6ZyJ7Y04dVIKtDL
   qjFKsq5W3DwT8APi7lsYwLbLECVAjKJpLYys93Jcbhihk8GBEHjSmPcgS
   8V/g8Bw36fz3jT3jANV8Xp3YZ3kOd5c8jyNqUBykGlQHMlniZ9TBvB+dc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771645"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771645"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:31:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277444"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277444"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:31:12 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com
Subject: [PATCH v4 bpf 08/11] ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
Date: Sat, 20 Jan 2024 00:30:34 +0100
Message-Id: <20240119233037.537084-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ice driver correctly sets up frag_size in xdp_rxq_info, let us
make it work for ZC multi-buffer as well. ice_rx_ring::rx_buf_len for ZC
is being set via xsk_pool_get_rx_frame_size() and this needs to be
propagated up to xdp_rxq_info.

Use a bigger hammer and instead of unregistering only xdp_rxq_info's
memory model, unregister it altogether and register it again and have
xdp_rxq_info with correct frag_size value.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b25b7f415965..df174c1c3817 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -564,10 +564,15 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 
 		ring->xsk_pool = ice_xsk_pool(ring);
 		if (ring->xsk_pool) {
-			xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 
 			ring->rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
+			/* coverity[check_return] */
+			__xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					   ring->q_index,
+					   ring->q_vector->napi.napi_id,
+					   ring->rx_buf_len);
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 							 MEM_TYPE_XSK_BUFF_POOL,
 							 NULL);
-- 
2.34.1


