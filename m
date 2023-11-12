Return-Path: <bpf+bounces-14954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB257E92A4
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 21:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D3CB20B07
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83AE1BDF7;
	Sun, 12 Nov 2023 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TKctWSjz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BB19BD9;
	Sun, 12 Nov 2023 20:30:52 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57492591;
	Sun, 12 Nov 2023 12:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=O//B7vzpUYGv9/Sg7vGtQAuoxPZDY/KV6EnYeizveiQ=; b=TKctWSjz1xTaaBRnM1NB1pUYd/
	JOG8lsalmWs34thTcwl4d7Br1btQOhD6I8IFAyej9ilKc4MicBB/zky71NtEHr4+JDm6uYMyjseVL
	StpTrOlaUC+khYCUYSjEBuIyIav1RaORE/sKK7io+yyjbEtCSDHv5PPdvHrs48g24ltC6KEJzGbgN
	ayvCFQ5lGZajBFMD2APekXawUiBzAInTpm+ap1+7r8BThW0fcz70VicexaA1e4FfFsIKPfEWjlQlZ
	0SgD8OOMe2KOBne26Da6k6OWETtSN3DaEMVM4tPFsUtvHPg17qPDNQu13aRGBr6aX2M/HR/Tc3oEj
	9U8RB+rA==;
Received: from mob-194-230-158-57.cgn.sunrise.net ([194.230.158.57] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2H6X-0002WM-B0; Sun, 12 Nov 2023 21:30:50 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	razor@blackwall.org,
	sdf@google.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Peilin Ye <peilin.ye@bytedance.com>,
	Youlun Zhang <zhangyoulun@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 5/8] bpf: Fix dev's rx stats for bpf_redirect_peer traffic
Date: Sun, 12 Nov 2023 21:30:06 +0100
Message-Id: <20231112203009.26073-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231112203009.26073-1-daniel@iogearbox.net>
References: <20231112203009.26073-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27091/Sun Nov 12 09:38:11 2023)

From: Peilin Ye <peilin.ye@bytedance.com>

Traffic redirected by bpf_redirect_peer() (used by recent CNIs like Cilium)
is not accounted for in the RX stats of supported devices (that is, veth
and netkit), confusing user space metrics collectors such as cAdvisor [0],
as reported by Youlun.

Fix it by calling dev_sw_netstats_rx_add() in skb_do_redirect(), to update
RX traffic counters. Devices that support ndo_get_peer_dev _must_ use the
@tstats per-CPU counters (instead of @lstats, or @dstats).

To make this more fool-proof, error out when ndo_get_peer_dev is set but
@tstats are not selected.

  [0] Specifically, the "container_network_receive_{byte,packet}s_total"
      counters are affected.

Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
Reported-by: Youlun Zhang <zhangyoulun@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/dev.c    | 8 ++++++++
 net/core/filter.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 75db81496db5..5c9ab37298ac 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10053,6 +10053,14 @@ static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
 {
 	void __percpu *v;
 
+	/* Drivers implementing ndo_get_peer_dev must support tstat
+	 * accounting, so that skb_do_redirect() can bump the dev's
+	 * RX stats upon network namespace switch.
+	 */
+	if (dev->netdev_ops->ndo_get_peer_dev &&
+	    dev->pcpu_stat_type != NETDEV_PCPU_STAT_TSTATS)
+		return -EINVAL;
+
 	switch (dev->pcpu_stat_type) {
 	case NETDEV_PCPU_STAT_NONE:
 		return 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index 383f96b0a1c7..cca810987c8d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2492,6 +2492,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
 		skb->dev = dev;
+		dev_sw_netstats_rx_add(dev, skb->len);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-- 
2.34.1


