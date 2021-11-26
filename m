Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B045EE44
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhKZMuP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 07:50:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:44583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347449AbhKZMsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 07:48:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="299062024"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="299062024"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 04:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="598507114"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2021 04:37:31 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc:     bpf@vger.kernel.org, anthony.l.nguyen@intel.com,
        alexandr.lobakin@intel.com, magnus.karlsson@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net] ice: xsk: clear status_error0 for each allocated desc
Date:   Fri, 26 Nov 2021 15:38:48 +0100
Message-Id: <20211126143848.17490-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a bug in which the receiving of packets can stop in the zero-copy
driver. Ice HW ignores 3 lower bits from QRX_TAIL register, which means
that tail is bumped only on intervals of 8. Currently with XSK RX
batching in place, ice_alloc_rx_bufs_zc() clears the status_error0 only
of the last descriptor that has been allocated/taken from the XSK buffer
pool. status_error0 includes DD bit that is looked upon by the
ice_clean_rx_irq_zc() to tell if a descriptor can be processed.

The bug can be triggered when driver updates the ntu but not the
QRX_TAIL, so HW wouldn't have a chance to write to the ready
descriptors. Later on driver moves the ntc to the mentioned set of
descriptors and interprets them as a ready to be processed, since
corresponding DD bits were not cleared nor any writeback has happened
that would clear it. This can then lead to ntc == ntu case which means
that ring is empty and no further packet processing.

Fix the XSK traffic hang that can be observed when l2fwd scenario from
xdpsock is used by making sure that status_error0 is cleared for each
descriptor that is fed to HW and therefore we are sure that driver will
not processed non-valid DD bits. This will also prevent the driver from
processing the descriptors that were allocated in favor of the
previously processed ones, but writeback didn't happen yet.

Fixes: db804cfc21e9 ("ice: Use the xsk batched rx allocation interface")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index ff55cb415b11..bb9a80847298 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -383,6 +383,7 @@ bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
 	while (i--) {
 		dma = xsk_buff_xdp_get_dma(*xdp);
 		rx_desc->read.pkt_addr = cpu_to_le64(dma);
+		rx_desc->wb.status_error0 = 0;
 
 		rx_desc++;
 		xdp++;
-- 
2.31.1

