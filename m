Return-Path: <bpf+bounces-47024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5408C9F2B0C
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 08:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871CE163CF8
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C41F7563;
	Mon, 16 Dec 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUXQpUct"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5E1F754D;
	Mon, 16 Dec 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334765; cv=none; b=Gni8kgDURNrhsr21F3W2+qJfsLQ29qTHbpRs9EGqnKHkA660RnYJuLZLgkgAAoK8DsMWlOXzdGyrLx80WKRzYMLZA8GxGuaTKMlOLwxyD3mCJXhz1Hit+yuZl0Czy02mjMZXpxuj3k2tQJcUQu0TWTI+pHQFxHTcnzjfRobd7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334765; c=relaxed/simple;
	bh=/1pRwMyhAu53D4zyYWPWDy+g1KgzaQejdNtkuChrOf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IF89Iir0S5zaAPN5aQKnoSv8WRmIx7EAc/yiZSSwcdbY2m4qv8PcIfYHZW4eiUNa8R85VfpYrCVIDbeKF/SZJhY5xBYdrBdtD8tJVhNGCjxTjNb0icXNOTaBzXSYUOKGUYBl5MZAx/j3XK5XmE4BkKuKkZXACLdnJeEnG4eLsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUXQpUct; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734334763; x=1765870763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/1pRwMyhAu53D4zyYWPWDy+g1KgzaQejdNtkuChrOf0=;
  b=OUXQpUctrmRZD2QwYwNnQnYVO9Ze29jpPsy8OsB2nsjVaOqnbwWvONk/
   zLXpM4W25RMo04zxugmLszx2S+IaRKK5c4QC3F4sIsS4UDai7HoNgKs94
   Tf1FbCy6NlibP7gt+bFffqlKI3jjjm5O7xPSeoMbdg6foGHFOjLNpslWn
   e/UlFzhNzu+zTs/443D8uIqbjhtTTfIqRb7nn4w0deCn93QudRZRnYZ0E
   CLb3ZN4HqkpxpKSaNFFoxA8ZEBSVEFjRkIS5r7xOpS6vxsXUAwnAmB4zs
   0q0yBfk527Qe9DkvVQEJsqVw8Rno6PMe+Yk8RRLL2ZuxDoc6cyt4fobN/
   w==;
X-CSE-ConnectionGUID: sAkfE1tETUKZxNrz/Dp2Ww==
X-CSE-MsgGUID: +hK5ka+oR4CFWorS+Hbq4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34031550"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34031550"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:39:21 -0800
X-CSE-ConnectionGUID: NIAxqjGWQx2PdsAJhtchiA==
X-CSE-MsgGUID: 89X1mMOdQOa0bGLXvb7B9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134447920"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa001.jf.intel.com with ESMTP; 15 Dec 2024 23:39:18 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v3 1/1] igc: Avoid unnecessary link down event in XDP_SETUP_PROG process
Date: Mon, 16 Dec 2024 15:38:49 +0800
Message-Id: <20241216073849.3555825-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The igc_close()/igc_open() functions are too drastic for installing a new
XDP prog because they cause undesirable link down event and device reset.

To avoid delays in Ethernet traffic, improve the XDP_SETUP_PROG process by
using the same sequence as igc_xdp_setup_pool(), which performs only the
necessary steps, as follows:
 1. stop the traffic and clean buffer
 2. stop NAPI
 3. install the XDP program
 4. resume NAPI
 5. allocate buffer and resume the traffic

This patch has been tested using the 'ip link set xdpdrv' command to attach
a simple XDP prog that always returns XDP_PASS.

Before this patch, attaching xdp program will cause ptp4l to lose sync for
few seconds, as shown in ptp4l log below:
  ptp4l[198.082]: rms    4 max    8 freq   +906 +/-   2 delay    12 +/-   0
  ptp4l[199.082]: rms    3 max    4 freq   +906 +/-   3 delay    12 +/-   0
  ptp4l[199.536]: port 1 (enp2s0): link down
  ptp4l[199.536]: port 1 (enp2s0): SLAVE to FAULTY on FAULT_DETECTED (FT_UNSPECIFIED)
  ptp4l[199.600]: selected local clock 22abbc.fffe.bb1234 as best master
  ptp4l[199.600]: port 1 (enp2s0): assuming the grand master role
  ptp4l[199.600]: port 1 (enp2s0): master state recommended in slave only mode
  ptp4l[199.600]: port 1 (enp2s0): defaultDS.priority1 probably misconfigured
  ptp4l[202.266]: port 1 (enp2s0): link up
  ptp4l[202.300]: port 1 (enp2s0): FAULTY to LISTENING on INIT_COMPLETE
  ptp4l[205.558]: port 1 (enp2s0): new foreign master 44abbc.fffe.bb2144-1
  ptp4l[207.558]: selected best master clock 44abbc.fffe.bb2144
  ptp4l[207.559]: port 1 (enp2s0): LISTENING to UNCALIBRATED on RS_SLAVE
  ptp4l[208.308]: port 1 (enp2s0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
  ptp4l[208.933]: rms  742 max 1303 freq   -195 +/- 682 delay    12 +/-   0
  ptp4l[209.933]: rms  178 max  274 freq   +387 +/- 243 delay    12 +/-   0

After this patch, attaching xdp program no longer cause ptp4l to lose sync,
as shown in ptp4l log below:
  ptp4l[201.183]: rms    1 max    3 freq   +959 +/-   1 delay     8 +/-   0
  ptp4l[202.183]: rms    1 max    3 freq   +961 +/-   2 delay     8 +/-   0
  ptp4l[203.183]: rms    2 max    3 freq   +958 +/-   2 delay     8 +/-   0
  ptp4l[204.183]: rms    3 max    5 freq   +961 +/-   3 delay     8 +/-   0
  ptp4l[205.183]: rms    2 max    4 freq   +964 +/-   3 delay     8 +/-   0

Besides, before this patch, attaching xdp program will causes flood ping to
lose 10 packets, as shown in ping statistics below:
  --- 169.254.1.2 ping statistics ---
  100000 packets transmitted, 99990 received, +6 errors, 0.01% packet loss, time 34001ms
  rtt min/avg/max/mdev = 0.028/0.301/3104.360/13.838 ms, pipe 10, ipg/ewma 0.340/0.243 ms

After this patch, attaching xdp program no longer cause flood ping to loss
any packets, as shown in ping statistics below:
  --- 169.254.1.2 ping statistics ---
  100000 packets transmitted, 100000 received, 0% packet loss, time 32326ms
  rtt min/avg/max/mdev = 0.027/0.231/19.589/0.155 ms, pipe 2, ipg/ewma 0.323/0.322 ms

On the other hand, this patch has been tested with tools/testing/selftests/
bpf/xdp_hw_metadata app to make sure AF_XDP zero-copy is working fine with
XDP Tx and Rx metadata. Below is the result of last packet after received
10000 UDP packets with interval 1 ms:
  poll: 1 (0) skip=0 fail=0 redir=10000
  xsk_ring_cons__peek: 1
  0x55881c7ef7a8: rx_desc[9999]->addr=8f110 addr=8f110 comp_addr=8f110 EoP
  rx_hash: 0xFB9BB6A3 with RSS type:0x1
  HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (43.280 usec)
  XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (31.664 usec)
  No rx_vlan_tci or rx_vlan_proto, err=-95
  0x55881c7ef7a8: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
  0x55881c7ef7a8: complete tx idx=9999 addr=f010
  HW TX-complete-time:   1733923136269591637 (sec:1733923136.2696) delta to User TX-complete-time sec:0.0001 (108.571 usec)
  XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User TX-complete-time sec:0.0002 (217.726 usec)
  HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to HW TX-complete-time sec:0.0001 (120.771 usec)
  0x55881c7ef7a8: complete rx idx=10127 addr=8f110

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
V2: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20241211134532.3489335-1-yoong.siang.song@intel.com/
V1: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20241204120233.3148482-1-yoong.siang.song@intel.com/

V3 changelog:
 - Change commit title to be more specific. (Paul)
 - Use unsigned int, instead of int, for array elements. (Paul)
 - Fix grammar mistakes on commit message. (Paul)
 - Explain why igc_close()/igc_open() are not needed in commit message. (Paul)
V2 changelog:
 - shows some examples of problem in commit message. (Vinicius)
 - igc_close()/igc_open() are too big a hammer for installing a new XDP
   program. Only do we we really need. (Vinicius)
---
 drivers/net/ethernet/intel/igc/igc_xdp.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 869815f48ac1..9eb47b4beb06 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -14,6 +14,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	bool if_running = netif_running(dev);
 	struct bpf_prog *old_prog;
 	bool need_update;
+	unsigned int i;
 
 	if (dev->mtu > ETH_DATA_LEN) {
 		/* For now, the driver doesn't support XDP functionality with
@@ -24,8 +25,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	}
 
 	need_update = !!adapter->xdp_prog != !!prog;
-	if (if_running && need_update)
-		igc_close(dev);
+	if (if_running && need_update) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			igc_disable_rx_ring(adapter->rx_ring[i]);
+			igc_disable_tx_ring(adapter->tx_ring[i]);
+			napi_disable(&adapter->rx_ring[i]->q_vector->napi);
+		}
+	}
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
 	if (old_prog)
@@ -36,8 +42,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	else
 		xdp_features_clear_redirect_target(dev);
 
-	if (if_running && need_update)
-		igc_open(dev);
+	if (if_running && need_update) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			napi_enable(&adapter->rx_ring[i]->q_vector->napi);
+			igc_enable_tx_ring(adapter->tx_ring[i]);
+			igc_enable_rx_ring(adapter->rx_ring[i]);
+		}
+	}
 
 	return 0;
 }
-- 
2.34.1


