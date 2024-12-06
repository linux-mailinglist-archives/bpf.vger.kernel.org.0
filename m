Return-Path: <bpf+bounces-46280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A519E748A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F1916D281
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373720E337;
	Fri,  6 Dec 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QTgt0pxR"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1D20E326;
	Fri,  6 Dec 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499287; cv=none; b=EJpo4fgwuvQLX209zMpeVDKtnZK/XFWlcjhSxPdmuJDzxdBjTDppWRsLI/Sak+RK5NNs8qXiUzHZBNhJX73w66qr7oIJCJ8yjQbzDGxsY7+IXIyuboT6Iz+Ijm7TpnYMl1ysayuAUXecKrCj+3NntW/onjDxGgym/Z7UIUkmfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499287; c=relaxed/simple;
	bh=Ml9fPtqpS2jX04AGKx5b27f6hYa1vg7okrZl7lM86Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I07JVsqmD7+Hljyx7VcoglQ5RSm49Ah6H+A0Ss1qr1dFjmVonXJQgg+KvnWBAGSa3z4qfXI2MM9ziIJ+DrtpFIQE+ie0d8plZsVQn7YnM3lLbhVyVbZ2lEFSXzFZyKrdhUa72/eYbxAumA1N35mccCXeLCAu/m5Ysg0Z89epNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QTgt0pxR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=M4rJE/PwlxUmiB0Axf+gy2W+JpmH655/hsr3pi3m+rE=; b=QTgt0pxRQq3FzppCfrTov62nvV
	N1LumNrb/jlNeZOHRaZmZKI74eOzC63W2itwmixXU7YkaNawqyOxuSCI4OSVk7mRUrDkCxGRQp5Do
	oepCtLTFh0V7Mh8TfZPAvM6W1qQbivmSZmPVPsNmTeVPjE/zbHvmWDU3I6FWY36fC9L1U0FKpcAaL
	MAW4HLoWassiMn8Ue0j3jUUFrzGISCz3iksDGasq82ePy7dFlzkaDerDyxnXNe6C3KU7nrDZcBbdJ
	2eme5UxGJhW9MkUsRs1E6MkESGHqJGiIJRt6J0YHPRKcxboY/HySSKl8i3IWePRN1N9PkGkPhe/tT
	w2S1RQPA==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tJaLY-000ERv-7Y; Fri, 06 Dec 2024 16:34:24 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	leitao@debian.org,
	martin.lau@linux.dev,
	peilin.ye@bytedance.com,
	kuba@kernel.org,
	Youlun Zhang <zhangyoulun@bytedance.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.1 2/3] bpf: Fix dev's rx stats for bpf_redirect_peer traffic
Date: Fri,  6 Dec 2024 16:34:02 +0100
Message-ID: <20241206153403.273068-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206153403.273068-1-daniel@iogearbox.net>
References: <20241206153403.273068-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27479/Fri Dec  6 10:40:14 2024)

From: Peilin Ye <peilin.ye@bytedance.com>

[ Upstream commit 024ee930cb3c9ae49e4266aee89cfde0ebb407e1 ]

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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20231114004220.6495-6-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/dev.c    | 8 ++++++++
 net/core/filter.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5151f69dd724..2ee1a535b3cb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9995,6 +9995,14 @@ static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
 {
 	void __percpu *v;
 
+	/* Drivers implementing ndo_get_peer_dev must support tstat
+	 * accounting, so that skb_do_redirect() can bump the dev's
+	 * RX stats upon network namespace switch.
+	 */
+	if (dev->netdev_ops->ndo_get_peer_dev &&
+	    dev->pcpu_stat_type != NETDEV_PCPU_STAT_TSTATS)
+		return -EOPNOTSUPP;
+
 	switch (dev->pcpu_stat_type) {
 	case NETDEV_PCPU_STAT_NONE:
 		return 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index 2f6fef5f5864..e766e66ef62a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2491,6 +2491,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
 		skb->dev = dev;
+		dev_sw_netstats_rx_add(dev, skb->len);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-- 
2.43.0


