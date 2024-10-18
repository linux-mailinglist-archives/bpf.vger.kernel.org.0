Return-Path: <bpf+bounces-42379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8E9A38CC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B46D281E2E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8B18F2EF;
	Fri, 18 Oct 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ul76rvv8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydfW1WGW"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9C18E76B;
	Fri, 18 Oct 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240811; cv=none; b=qYpDZK6ODgC1CWj6hPW03r1XSyKMvHgvJUb+XRj7Ma7/sTIISNYb/ggJS9HLzxrVuoNGL+vNhpqEKzbz+NEjPRO03M4EhZnw7Nv+zrf0PchqlDcs5k5YIWZg4Z+4QfAOZcFFaf5lqV/pwv5+Oapv15PaS1hDyeXkodFQfDUVryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240811; c=relaxed/simple;
	bh=cnoPgA7SLSxEZWHSxj93ibH/qjkwjNZBKjlWKfRTzFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFUWkF7hgtI77Wybg205bgjVIkuZBBbbB/dBog6iMhVZTTMsNcwdlY9m99cA9wUq9ExIRH18mCa1QiZJliVSxAeFA3RFxAkWJghZRoNwKcSdkPvWp2s3rWT4zNZfVipU5tuem5DfuPoTOhpg0uRWwZirQYos1Zk+vPbM7I+S2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ul76rvv8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydfW1WGW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729240807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YH+J2MPtO/wj9yAkFfnF7WQuIFDEVmwmmrLzdRgJhfU=;
	b=Ul76rvv8zjvvP8ySRMZtT1vB3tIc/lBHZQSlhmC0/dlKwzc9vry6sekg4Qagq4XeIocK7M
	AD/kHS/Y9Hcl7dd7zLLRAFHil969q6LbvCqyq9D43JB90nDR5CgoqgGWhP8Faewn8uDOTa
	RVOGEjiB6676arPFGRn3Zo8wTYJMbBa16VM1qx17NntYXZnmeKmBhoMKB8BHXS38VqQV59
	PUNRgeeRMzuXZVL6BH6iXeLWgzjCP+gs0psnp4vtCxK+rsTHEpK2jiB4us8FyUU4GEyLas
	UMamHiN3yauPwzlzCEPMXz8/SZML31+oCV+9NUrZRd7eYjrCi8L5OOiik4gB9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729240807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YH+J2MPtO/wj9yAkFfnF7WQuIFDEVmwmmrLzdRgJhfU=;
	b=ydfW1WGWqoDHjYkVZjC9fVwV0E+mmkilU1Nr6xJ2xpwFEjDcb8XDLHu+7goJ2XqzexHwiv
	KxMJKEWtxRJ8jvDQ==
Date: Fri, 18 Oct 2024 10:39:58 +0200
Subject: [PATCH iwl-next v9 2/6] igb: Introduce igb_xdp_is_enabled()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-b4-igb_zero_copy-v9-2-da139d78d796@linutronix.de>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
In-Reply-To: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
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
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnEh7iWBdazRMU4JURD596qWrbLmuPTJe7KgyMh
 Tu9nC75nSCJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZxIe4gAKCRDBk9HyqkZz
 gkY5D/0fRgM3Umiqa9cGgZY5jznEMK0Vx3JNKoex2Ak4YPeDVWWO5g6hI16zZQN03+CI3yj9iLR
 biwP1yl2TnsAvMB4nzY126PdamU1BTlOtdQZB5u2uJkUg3InecXIEjQEQP639KtkxPTICsM6pDQ
 RtKxhUZ3pGhfqBPtktEPWA1XQjzMjr7E4r4SaEkyP1zAcYQVNx2FJJBtEimLs6EEjtuUS+TFwh4
 3VSehfshNCyDQ2lVqaUAWEhcIS7A7TVtYgJ1oTXASkVaiPJ75vogCcR/B47Z2fU7jVFuNIyTs/z
 G50M3Neo1H++WJgMkDDo4gO8lunuQ4ZFLp86XMAD/MY+CEDuCTdpJG/KqUzVmyDMVCNqw9fGhoz
 QnLGk22mx8deJW2MkbrZKi3picLY5W1ozdOKarxe521tzfUlqzMgogKs3kG43h5kGwo2QiO48Mx
 sb+/EiG2GkR0yQIi6eYCOC6pQ+i1hAA3GeI63qlXO0BL7GwBwqlGT4omU8CQClSRQ1Jy64gVB1t
 XqfmFZufJbmRT0Cv1VKQmkNS3KlYq1apnXL6sCd7+Y6HfwhiXEVDVjTgnjbSVf5N0YbbXL77jIU
 4P0BrkTiK3r4R5jjwp7aDGK03egJ6gq5YDXxOhzncl1Vjr/p4cKpHfT44d2Ky5MGU7XmZZcWboL
 IB8LOlfZHmfwMdQ==
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


