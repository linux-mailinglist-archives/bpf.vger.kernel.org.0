Return-Path: <bpf+bounces-50736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB4A2B8FB
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70A11889645
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9618B47C;
	Fri,  7 Feb 2025 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1kpJZpm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207F18BC06;
	Fri,  7 Feb 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894862; cv=none; b=sAFuGilc1CwYy3XZgTvI168YeHClNx/h06PzyBYh6hVDy16YMLvM1rsAogLikuUwP654aMljCxH4aWNaokrAWSnOP6caQaB8F+7uCMmxm+O9loa3k5XZlaq7vJpG8nTeqQZD/f7WLI8ZNnS1GhX6SHADtMq+bM3DgSfjZlU9gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894862; c=relaxed/simple;
	bh=p2wQyxyXyuiNqbBS17Es146CFtqu/d73uiA8Sh84ems=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9axbWJk5O7WaFT8xaBSswVk4B7j+UuZbzwtFuZSpgHJv7fRIbgvch7Re6Rh8nzb4LGXL7eTiw0j1ilEwf+27s66c+0NUxSaxPb0cJRNbdRHCgWaNnUK/zqghPdAvlnsgQSp5AShKX+iaV0IB1E1PY2AzEIvswUVpBVAHoyDU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1kpJZpm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738894860; x=1770430860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p2wQyxyXyuiNqbBS17Es146CFtqu/d73uiA8Sh84ems=;
  b=L1kpJZpmnSqacbgzsGRQXG+tuUkGw/fc7tPWRitJmN8zSuLqhSmjNng7
   YI71TtHJCF7bhWEAeJa23CWkyBlsEZa6e9uSugjBUbVS2tK5plrojE+Ab
   Y8cU+XSkORhHrpAWFYkyOv7Y/Nh7vZGXihmkZ8HK5LSfvs1KAEiBzOVMx
   OUn1F9UAf6+iYcWswkd1n4N/WkNq184pF01Up12yT+Q1etXC2Y23+IFwk
   QTYaF2tjyZ1sE3xCellvsENhmE9pFmzM5ECFitddsJoGUBroXXkAVEBei
   0zqkssV9gzHjfmeBKEywNNdXtH6QaIaXAVdUZsKNHL+sxTVKT+uiXAWeh
   A==;
X-CSE-ConnectionGUID: 4XIeGv9VRxO64ARouM6cxg==
X-CSE-MsgGUID: YGXHdnPfTXW2qfiznaNbMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50917756"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="50917756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 18:20:59 -0800
X-CSE-ConnectionGUID: eQTw0hmUQiqbDQy6vOYrXw==
X-CSE-MsgGUID: teK3NF9XR/qEuai3RyXRNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148615629"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa001.jf.intel.com with ESMTP; 06 Feb 2025 18:20:47 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v10 5/5] igc: Add launch time support to XDP ZC
Date: Fri,  7 Feb 2025 10:19:43 +0800
Message-Id: <20250207021943.814768-6-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207021943.814768-1-yoong.siang.song@intel.com>
References: <20250207021943.814768-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Launch Time Control (LTC) support for XDP zero copy via XDP Tx
metadata framework.

This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metadata
on Intel I225-LM Ethernet controller. Below are the test steps and result.

Test 1: Send a single packet with the launch time set to 1 s in the future.

Test steps:
1. On the DUT, start the xdp_hw_metadata selftest application:
   $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000 -L 1

2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 9091
   of the DUT.

Result:
When the launch time is set to 1 s in the future, the delta between the
launch time and the transmit hardware timestamp is 0.016 us, as shown in
printout of the xdp_hw_metadata application below.
  0x562ff5dc8880: rx_desc[4]->addr=84110 addr=84110 comp_addr=84110 EoP
  rx_hash: 0xE343384 with RSS type:0x1
  HW RX-time:   1734578015467548904 (sec:1734578015.4675)
                delta to User RX-time sec:0.0002 (183.103 usec)
  XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
                 delta to User RX-time sec:0.0001 (80.309 usec)
  No rx_vlan_tci or rx_vlan_proto, err=-95
  0x562ff5dc8880: ping-pong with csum=561c (want c7dd)
                  csum_start=34 csum_offset=6
  HW RX-time:   1734578015467548904 (sec:1734578015.4675)
                delta to HW Launch-time sec:1.0000 (1000000.000 usec)
  0x562ff5dc8880: complete tx idx=4 addr=4018
  HW Launch-time:   1734578016467548904 (sec:1734578016.4675)
                    delta to HW TX-complete-time sec:0.0000 (0.016 usec)
  HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675)
                         delta to User TX-complete-time sec:0.0000
                         (32.546 usec)
  XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
                 delta to User TX-complete-time sec:0.9999
                 (999929.768 usec)
  HW RX-time:   1734578015467548904 (sec:1734578015.4675)
                delta to HW TX-complete-time sec:1.0000 (1000000.016 usec)
  0x562ff5dc8880: complete rx idx=132 addr=84110

Test 2: Send 1000 packets with a 10 ms interval and the launch time set to
        500 us in the future.

Test steps:
1. On the DUT, start the xdp_hw_metadata selftest application:
   $ sudo chrt -f 99 ./xdp_hw_metadata enp2s0 -l 500000 -L 1 > \
     /dev/shm/result.log

2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
   VLAN priority 1 to port 9091 of the DUT.

Result:
When the launch time is set to 500 us in the future, the average delta
between the launch time and the transmit hardware timestamp is 0.016 us,
as shown in the analysis of /dev/shm/result.log below. The XDP launch time
works correctly in sending 1000 packets continuously.
  Min delta: 0.005 us
  Avr delta: 0.016 us
  Max delta: 0.031 us
  Total packets forwarded: 1000

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 61 ++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index b8111ad9a9a8..cd1d7b6c1782 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -579,6 +579,7 @@ struct igc_metadata_request {
 	struct xsk_tx_metadata *meta;
 	struct igc_ring *tx_ring;
 	u32 cmd_type;
+	u16 used_desc;
 };
 
 struct igc_q_vector {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1bfa71545e37..3044392e8ded 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2971,9 +2971,48 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
 	return *(u64 *)_priv;
 }
 
+static void igc_xsk_request_launch_time(u64 launch_time, void *_priv)
+{
+	struct igc_metadata_request *meta_req = _priv;
+	struct igc_ring *tx_ring = meta_req->tx_ring;
+	__le32 launch_time_offset;
+	bool insert_empty = false;
+	bool first_flag = false;
+	u16 used_desc = 0;
+
+	if (!tx_ring->launchtime_enable)
+		return;
+
+	launch_time_offset = igc_tx_launchtime(tx_ring,
+					       ns_to_ktime(launch_time),
+					       &first_flag, &insert_empty);
+	if (insert_empty) {
+		/* Disregard the launch time request if the required empty frame
+		 * fails to be inserted.
+		 */
+		if (igc_insert_empty_frame(tx_ring))
+			return;
+
+		meta_req->tx_buffer =
+			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
+		/* Inserting an empty packet requires two descriptors:
+		 * one data descriptor and one context descriptor.
+		 */
+		used_desc += 2;
+	}
+
+	/* Use one context descriptor to specify launch time and first flag. */
+	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
+	used_desc += 1;
+
+	/* Update the number of used descriptors in this request */
+	meta_req->used_desc += used_desc;
+}
+
 const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
 	.tmo_request_timestamp		= igc_xsk_request_timestamp,
 	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
+	.tmo_request_launch_time	= igc_xsk_request_launch_time,
 };
 
 static void igc_xdp_xmit_zc(struct igc_ring *ring)
@@ -2996,7 +3035,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
-	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
+	/* Packets with launch time require one data descriptor and one context
+	 * descriptor. When the launch time falls into the next Qbv cycle, we
+	 * may need to insert an empty packet, which requires two more
+	 * descriptors. Therefore, to be safe, we always ensure we have at least
+	 * 4 descriptors available.
+	 */
+	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
 		struct igc_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		struct igc_tx_buffer *bi;
@@ -3017,9 +3062,19 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		meta_req.tx_ring = ring;
 		meta_req.tx_buffer = bi;
 		meta_req.meta = meta;
+		meta_req.used_desc = 0;
 		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
 					&meta_req);
 
+		/* xsk_tx_metadata_request() may have updated next_to_use */
+		ntu = ring->next_to_use;
+
+		/* xsk_tx_metadata_request() may have updated Tx buffer info */
+		bi = meta_req.tx_buffer;
+
+		/* xsk_tx_metadata_request() may use a few descriptors */
+		budget -= meta_req.used_desc;
+
 		tx_desc = IGC_TX_DESC(ring, ntu);
 		tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);
 		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
@@ -3037,9 +3092,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		ntu++;
 		if (ntu == ring->count)
 			ntu = 0;
+
+		ring->next_to_use = ntu;
+		budget--;
 	}
 
-	ring->next_to_use = ntu;
 	if (tx_desc) {
 		igc_flush_tx_descriptors(ring);
 		xsk_tx_release(pool);
-- 
2.34.1


