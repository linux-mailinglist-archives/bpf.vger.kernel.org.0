Return-Path: <bpf+bounces-37356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A66195456A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD3B1F23B0E
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B6144D39;
	Fri, 16 Aug 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="POsw0eHq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Om9ccw7"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181A13F428;
	Fri, 16 Aug 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800256; cv=none; b=UIMEAYhTkdNhtpHgwUG69jYyIy/OE1/J5Fn70ne6GauFqfikJlIsSF8iHijjAU6ZxyFcI180Xj91lPFhM+6ZzOsueJFncG2XNISTWIo77RDLeARgl6MNdhuDc1EWKy8TkwhYW+86DZeXZLoBnTf8elXAfbNjG3ulIhNc3p3FlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800256; c=relaxed/simple;
	bh=cgdjYkD6a4jg5Bm1eLGelKxrpHdkfMFAk04EW5Zt90E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyf4Yr0e5+qn5LwCMzXcFmaPGwtrCAX9fGNFE6ieufNd80uiOZrjm+CXrB9lK6hSQQzZBY19ifX0hapn79UDihjZodJJ9OG0XG0uyu3aLH5mWWuALOs/x39+2OuLTXNkdErKlf8AzoSMtZ7+++01273vVUhWEQBoM12rwBgk2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=POsw0eHq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Om9ccw7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723800246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+fPaZ+j1KtvWllGwHu58X7smPAoZP18kh5OqiYAz+I=;
	b=POsw0eHq5BHj6AfCKZPeS1oRq9IAT+LmaHOofJHg1bIOO0k1EJYVHG312hbSRv4nH+y4F0
	z+NzFS1WCdpji0Najvab2NTxrKNOsPR4/9LfImwZLFP9bwmw0gPqRlwTDPiA509LZdZy5h
	jKY4IIt7WGAJDoqdenCsRgqEA+KdmH1dZSEllWQ/3dFzIFLVwC8nVYT29zUJXX+tSHQ0cM
	n+R+5URQjum5dMAFE05nIPGTumDOMt7OC29x+4gud1URPyTOlbWbee1UI35fPvMjtcbzFd
	gqd1sfIJEVosul0Gqx07t9+UHM4Q7fwGiS2pianJZL+7y6GanNdMJICfNA8rhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723800246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+fPaZ+j1KtvWllGwHu58X7smPAoZP18kh5OqiYAz+I=;
	b=4Om9ccw7A03ClFUtdIkCKEbmRJ39+oj3Pl01XhyQVkA33BanIi2BCeZh8la8yqB2kd66on
	Jty1PokyvTf1xQCw==
Date: Fri, 16 Aug 2024 11:24:02 +0200
Subject: [PATCH iwl-next v6 3/6] igb: Introduce igb_xdp_is_enabled()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-igb_zero_copy-v6-3-4bfb68773b18@linutronix.de>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Benjamin Steinke <benjamin.steinke@woks-audio.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2635; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=diD1pMkZnZRJQC5ME9B282Jyhc0fUmv3nNbZJfwcJuk=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmvxqySlt8QUGbkalaDsiIfloKTu54OvXAvkQ67
 GTTfmmJ7hSJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZr8asgAKCRDBk9HyqkZz
 ghLDD/9RpfDyD+574KnaAjvfzZfpdrRNgysAj7c/E8OKLS1Q1r/yTvNR8F+Wu+YhDU2pzrV9kIw
 xVAcke9A01wViooZYToFx4igoegyIwyUdiGvDAL5tORl9NkkqKkWL4hph/MQ/lMTlBRyon1RUrm
 q3NfBl5LUc1HvXuQTEMeRTecxLxxX751x5WbLQWKfg+OC1WgyzPlC+vqPmhox3vWU5qAQlHjnjX
 EXbn8jIjtxw3DOIqvvGnQxEQxQVWhKqICueHiShQ+S4JpTrfy1P7JTO73aLngbmoSYlItq3lU0I
 p6N21xTUR59jJxWBlcjyYSuNOOfE4V0QXKuow7dT/8XJxhV554YBRdCqa/4dubVDYoOKQAPzBYr
 B2nZQD2sj3PYt5Q3kIXNxXGixEDd68re482QAmdz09+MdZanj0EvlQkZIpStoes7aueL+wpnQ+i
 2el5F2DpZyx4pJEL5ayQRzNc3lklvjmClU3ksZDWExiU/k1hHaoO7/F9REuJtTyYsXsWIMeTUuh
 KSCsiJKA/v9xh/WWFozUWda5ff/dXoJuj75R8dpcMD+dONrvN6NRFpnBm09stasWHh7pBCsujJf
 UloxP020z0Z5BvlCELsn+hqK7FiDTwnzD697zvrxGFhSrchd7LOR0tF/TTRMVdPmglO1YyjYKu+
 ZYetxNiiVLAo9Hg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Introduce igb_xdp_is_enabled() to check if an XDP program is assigned to
the device. Use that wherever xdp_prog is read and evaluated.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Split patches and use READ_ONCE()]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      | 5 +++++
 drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c718e3d14401..dbba193241b9 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -805,6 +805,11 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
 	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
 }
 
+static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
+{
+	return !!READ_ONCE(adapter->xdp_prog);
+}
+
 int igb_add_filter(struct igb_adapter *adapter,
 		   struct igb_nfc_filter *input);
 int igb_erase_filter(struct igb_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 0b81665b2478..db1598876424 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2946,7 +2946,8 @@ int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
 	/* During program transitions its possible adapter->xdp_prog is assigned
 	 * but ring has not been configured yet. In this case simply abort xmit.
 	 */
-	tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
+	tx_ring = igb_xdp_is_enabled(adapter) ?
+		igb_xdp_tx_queue_mapping(adapter) : NULL;
 	if (unlikely(!tx_ring))
 		return IGB_XDP_CONSUMED;
 
@@ -2979,7 +2980,8 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 	/* During program transitions its possible adapter->xdp_prog is assigned
 	 * but ring has not been configured yet. In this case simply abort xmit.
 	 */
-	tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
+	tx_ring = igb_xdp_is_enabled(adapter) ?
+		igb_xdp_tx_queue_mapping(adapter) : NULL;
 	if (unlikely(!tx_ring))
 		return -ENXIO;
 
@@ -6612,7 +6614,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
 
-	if (adapter->xdp_prog) {
+	if (igb_xdp_is_enabled(adapter)) {
 		int i;
 
 		for (i = 0; i < adapter->num_rx_queues; i++) {

-- 
2.39.2


