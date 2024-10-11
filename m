Return-Path: <bpf+bounces-41729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BF1999F9B
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CD42873F0
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A120C49E;
	Fri, 11 Oct 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcgQRmz3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kr2BFcOV"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4801FC8;
	Fri, 11 Oct 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637274; cv=none; b=lJRAO8Wzywq2PFALPJMoJ0u4ciHxgdJllpSmayo4tmh/2Ypsmt24fN7hkh9laPnIHMixOu7Gvu2rDIdFMzF3Pg+laF74cEyqzmYEbiP+Yeh0mkftF41GDSvwmM4WHjwdnVeGOK76CAzuUK1xC8mYZGG6TeyC/PqGhdFlTJapJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637274; c=relaxed/simple;
	bh=cnoPgA7SLSxEZWHSxj93ibH/qjkwjNZBKjlWKfRTzFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ipn8nsCqy0NAPJHXNeaTSHpAjGo7hyLmgR/nk/Dp0cgiJYsovmF8fp81832XBLIBaxJaPXIkPuR1YqwiUpnAar/oTtaiDt6B6Nlj+P+FR/BA6Y/ZuRZZQY3varsQ0ZI8WEiuixhP75jz9JYXI8ASxYNDbuF6Vip+46Mm60Z8Xmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcgQRmz3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kr2BFcOV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728637270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YH+J2MPtO/wj9yAkFfnF7WQuIFDEVmwmmrLzdRgJhfU=;
	b=zcgQRmz3yjeDRWU+v26Pgu524arqcCovd6mjbvOEwFlQK8XHu8Kw/s0CotHaTnCiRhLC0y
	Ge0tZAvDN/Kh+xVV3tl0b9YXOLgHpy95dXJVqPyfCEgHxx0E4Gnm+7A3Sqrm0r6+wOMw1k
	N7mk9SyMcfmev8+D8+aMq3nsvdEFKDoLjwr1kp+seIJbT1AB2WNtUQ1MCKHrhkGi0vGzWb
	qNQK7ZMoAAXTjbL17ZMwP4BgTSq8rl6hIpZ8uZ7cVNMQdqozqAGWkhnve+xbJHa2GIJo/X
	fKKrLytPFvxR8l8reFYQ3qZcamriAWYUSLr9CfHfpqFwqEIadGwPAQrLrUbBCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728637270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YH+J2MPtO/wj9yAkFfnF7WQuIFDEVmwmmrLzdRgJhfU=;
	b=kr2BFcOVAv7lWZ8lWhEbe6mOsdsX8hoVOn5aDDHkD4OwyWo+P82Oes9J2oGPxudXyK9tV1
	8Hf4NQmMecMcSHCw==
Date: Fri, 11 Oct 2024 11:01:00 +0200
Subject: [PATCH iwl-next v8 2/6] igb: Introduce igb_xdp_is_enabled()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-b4-igb_zero_copy-v8-2-83862f726a9e@linutronix.de>
References: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
In-Reply-To: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=GFWHUeNYEWqXkX9ltUkdA/+XAecRGzYcafx3KgM4JRg=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnCOlSxONXEPtIMvuO76ImbomRU2Vai5eJW2pka
 kldZQFhhlqJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZwjpUgAKCRDBk9HyqkZz
 giNcD/4iH7SPuTFnahKrXLzU1qNRICyadFJRn3IZBBcgFDNPPXG4G03f+GXicds3W1U+MhLh4Kl
 wdoGyCANDwANu7qU3Qt7SZTzJTd3yEC3qPsJRQtj2sc5/SudTtCNYx+DtWjIkQnjnALwIwN60Sv
 QnCcfFxIEhGdHjUHbm8r6f2fGntcOwgJ6IZ4cLiJDUWlv/LADh3bWYa1RD1qQMHsqrcjzg/hvCC
 xYFN/kNCC7fSBOcrr4rmsJmihp4eARNqG3I4tT12Ez8dPBVuMp3ZYJcqXN8V9qpLMr19edzmNuq
 mm06dvAWuX/4W9GtYPYPuF9qIdU4IA9aAV57Doua3Jc5P3MT6KOdaDYoHtwcYeHC19VPKQNo7or
 jhrKwF57Mdw8KXmqRHB9g+AtmFL5Xh/RMegvU21dw5YV6Yma8+ePQjiselFTKVfjbVjbuAuyilp
 tvhd/oDHaA3WiQfMj9MnvX4qqPigGuftnFl+CchZMUn2CdwlsnYhqCF/2IOmi0BL4hIwOAMitar
 3Mwrjh8+66RgP+UzEwWo2q/Os99xtLhpqt1nXZ9XLXJH+w8G7+9dIzBRyyZ8KoYa73cHsTE7U/Y
 kZzJCYQ0hRUNIOVxE7P2y2rALXgA+w5MQa4uxgtb5ITjErTqj84KIx0HKvKdr0GAQOG57nDccMy
 CGvW6lAHwSS2I5w==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Introduce igb_xdp_is_enabled() to check if an XDP program is assigned to
the device. Use that wherever xdp_prog is read and evaluated.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Split patches and use READ_ONCE()]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      | 5 +++++
 drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1bfe703e73d9..6e2b61ecff68 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -826,6 +826,11 @@ static inline struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adap
 	return adapter->tx_ring[r_idx];
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
index 5a44867bcb26..fc30966282c5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2926,7 +2926,8 @@ int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
 	/* During program transitions its possible adapter->xdp_prog is assigned
 	 * but ring has not been configured yet. In this case simply abort xmit.
 	 */
-	tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
+	tx_ring = igb_xdp_is_enabled(adapter) ?
+		igb_xdp_tx_queue_mapping(adapter) : NULL;
 	if (unlikely(!tx_ring))
 		return IGB_XDP_CONSUMED;
 
@@ -2959,7 +2960,8 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 	/* During program transitions its possible adapter->xdp_prog is assigned
 	 * but ring has not been configured yet. In this case simply abort xmit.
 	 */
-	tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
+	tx_ring = igb_xdp_is_enabled(adapter) ?
+		igb_xdp_tx_queue_mapping(adapter) : NULL;
 	if (unlikely(!tx_ring))
 		return -ENXIO;
 
@@ -6593,7 +6595,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
 
-	if (adapter->xdp_prog) {
+	if (igb_xdp_is_enabled(adapter)) {
 		int i;
 
 		for (i = 0; i < adapter->num_rx_queues; i++) {

-- 
2.39.5


