Return-Path: <bpf+bounces-41115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8137E992BD3
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067A01F23400
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0C218BB89;
	Mon,  7 Oct 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPy1SnLs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Im5AlMQC"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738691D2708;
	Mon,  7 Oct 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304295; cv=none; b=YvbkVx3OuYU26VadBopjfv1vwVqAq2mDBNcFQVbUL5ZM4h8svWQzsF9dZC7ouxzVbRSJ+qn/GU1yx2skw6blb9sYNQ7JjBkbbdRwNxwKiESYmJSBAO8C+uxsESBZopO+IP2krw62qemCVdY3EXo6dpSfHgK4EjYLOk/RUbXL+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304295; c=relaxed/simple;
	bh=8MICWi3FRgvhhnO/TvY43Pe+hFDIQEkgGoxxPBd4tlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAlHIyI798277teu9pFowgMH93+RWxWRn8qjGk2NwneQaw1ECJu0Xxq0ja7kR6oPZmptQCQCCQ3IM54K8Gwl+WFQlPySCUxmkk0NJVyjq7AuMf9ezi2O0oRYTXhzZ6ThLSjgHwDzLGfqE91zFrShhrmEMCjBTUEVLzjME02U29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPy1SnLs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Im5AlMQC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728304291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghMwZtaMDneSHodyZdYQuHFHRR3/IaH3buOGb+HJs9Q=;
	b=LPy1SnLs3WgToFhpzG8K4YpdJpBAtSgvVMgWL1NXq5SDFQJvhYswB4js2Ys8b0d7pLjrxv
	VmNVqMncZDhxEFC7s1/ANgqb+EwkxM4NdGvok1sgOn+dR0JRNyb9cgZGRr/do3AKTDh8ZT
	FzVg0Db5BliibhqvTlaXn80TI7RXlR+55CDPwNCbyJx4rUUzQHROfM7LB0Dwbv/yvYvwTp
	LE5MbvrQwE0At+y6cvwk+0RXSSVX199TPpoogDFFfVDo8swjl5qqITxLYBruFuNm1NKdTP
	ITkQdOY1d0eTC57y09M64zCWwB7KR1pYQQKJBR/5142fJpXViREsK87PQ7iaUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728304291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghMwZtaMDneSHodyZdYQuHFHRR3/IaH3buOGb+HJs9Q=;
	b=Im5AlMQCz+eVAAQ4yDhC+nUhUPqEfXd/gXR4QNQL+1qUkDMfvnP72iKZDbJVhqNaYUm8wL
	L6Mw9ka5Ow7JDLBw==
Date: Mon, 07 Oct 2024 14:31:24 +0200
Subject: [PATCH iwl-next v7 2/5] igb: Introduce igb_xdp_is_enabled()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-igb_zero_copy-v7-2-23556668adc6@linutronix.de>
References: <20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de>
In-Reply-To: <20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de>
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
 h=from:subject:message-id; bh=P27UEKCtJR0md9g63pfwA7XxMrHb2hJUetl3/hadzuo=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnA9SfmHq3fUFvj2DJBb7Cm4eF0/fp1NJWb1Rzb
 ONZ7URKo22JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZwPUnwAKCRDBk9HyqkZz
 gtrAEACZTpqev+q5mvlBTkzNaDmFgvNAJQwLDpIDG2AILQVY7oUBD75SFAuik7VyLp9fFj+GJpt
 Qtne7tFkReZUSNZuNI5Ol3qD2q08xAuzf0EgmdCHnuLinpN80Zg7DQMkbN5ezoqRI97mLnwL/8l
 bkhmhgHpQasC71pBVoWtIqtD+n53ApOHvSIGCRX8snz0qLfuHpdE5XYQjizA6PGSkZcqFjnxK8b
 K2XFlceviRouhRYhaZBYsMWoEFXMgBoMssNzPRMB+Y+vLzAwPDMPDpPn185wJuFPX6bW1L5mG1L
 MUYTemfEwrSXZ6l/fWZu/SEUNBhkwhI9MAG6bKFgeL5D1Z8NfGlHLcruUl/kKUMPeaS/Ube0dJF
 B/ciwh6jkl0xow2nW4yhWDWsGR/a0HdXPqEoAOctTtSXlYKORY8eFFqOqoJShgp8zceU5FHG+dP
 0TO80NPT1ufSP8vBEaIA1W/r6BpPuQ/8VgDNKluIzgtdGsYh52+oaKIWmJtvRpoUPAXKe8Wfe7c
 1MqOPiKhVXKNRKhwGJ48nL/Osvox6X33YzeN4NcOJT8UXQ/sxH5ez1tlOTNEA6lnrBLzutvTMxO
 Mjk7PnqA0J0wB5x3vTA+LnJs/LYKqi+m1cC7HclZiOLPnygDzkRC+vsIQLMUyc31tFEh+3jjncR
 X1nOEjkPLnQsQWQ==
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
index 71addc0eac96..34a3f172d86c 100644
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


