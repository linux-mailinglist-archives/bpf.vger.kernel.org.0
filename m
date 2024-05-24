Return-Path: <bpf+bounces-30481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B58CE598
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70E21F22339
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B305A126F1D;
	Fri, 24 May 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hp9eDLM2"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866884FAC;
	Fri, 24 May 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555691; cv=none; b=HAycNA4ZDG9NEuvkHZQuGshESAFuJoot4IdlAgLSTC2JVy2ibPz+fVcYn7bMHpJd0mIpSNifTtXYSqGiBAj9MTDmFcesbGKDoTZs7vhgYjbEZrdJ1xhsiCdNt2AQmKW5f3XXMGsJzLXQVx5MN1uqPqYZovlG3h0xsZ1TcHZLg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555691; c=relaxed/simple;
	bh=hYW1/cqIcD5LBvUJ08aWdLFpetim3VIaLDRVOOzPZ84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gWhL7B6dJ7Ghvu+cUCx4PfqRkn3XLtiSsBMAUil6I3T6KyVOLmppL3DOIKnxxiLVPEdxc/76CzF3AnI/DdrjXuPB7jImRQsPgdtNa6zyGbo0lUUHq8TGd8llh0DoUG1ShSRuWk+23gow+AAfhnBKmePoA7/v7rDEm/DYfpGTMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hp9eDLM2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OK7s9URNCmjrxmOTsy4gTfe0fIefzAHPZJiRC3NvSI8=; b=hp9eDLM2ie7z38xQrzrGp+lUeB
	9nh6qs/kbcmh5APE8d1p1ymCzFg6bIeLr5kKVUWcy6P4+aFa5NjxH08RPI/qoXFKYSY/swk3+oj3Z
	BplDG5J5htfot1uhE/B1cmHVWWMJDsCbZnoy7LfmGS1PlzWZkYAPLZj1GxejaFAcAF0ZizgKmhDJK
	ompE/iS4XAMhSZ3GfErqXXcbKufr+6ItCdeuVHcv5jAU08F16/OxP313JRoUYASgJTNoDtfDdBXQQ
	AT7so0iUfApi3wDEAQkUJQoO1773rh1DzLYvpbh93yTGiKeJgv+lf3e98nP06I1vnbqF+Xq2uiB5v
	h+6cC3/g==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAUXy-000K5D-1O; Fri, 24 May 2024 15:01:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Joe Stringer <joe@cilium.io>
Subject: [PATCH bpf 3/5] netkit: Fix syncing peer device mtu with primary
Date: Fri, 24 May 2024 15:01:13 +0200
Message-Id: <20240524130115.9854-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240524130115.9854-1-daniel@iogearbox.net>
References: <20240524130115.9854-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

Implement the ndo_change_mtu callback in netkit in order to align the MTU
to the primary device. This is needed in order to sync MTUs to the latter
from the control plane (e.g. Cilium) which does not have access into the
Pod's netns.

Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Joe Stringer <joe@cilium.io>
---
 drivers/net/netkit.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 16789cd446e9..ead7097c224b 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -167,6 +167,25 @@ static int netkit_set_macaddr(struct net_device *dev, void *sa)
 	return eth_mac_addr(dev, sa);
 }
 
+static int netkit_set_mtu(struct net_device *dev, int new_mtu)
+{
+	struct netkit *nk = netkit_priv(dev);
+	struct net_device *peer;
+
+	rcu_read_lock();
+	peer = rcu_dereference(nk->peer);
+	if (unlikely(!peer))
+		goto out;
+	if (!nk->primary)
+		new_mtu = READ_ONCE(peer->mtu);
+	else
+		WRITE_ONCE(peer->mtu, new_mtu);
+out:
+	WRITE_ONCE(dev->mtu, new_mtu);
+	rcu_read_unlock();
+	return 0;
+}
+
 static void netkit_set_headroom(struct net_device *dev, int headroom)
 {
 	struct netkit *nk = netkit_priv(dev), *nk2;
@@ -211,6 +230,7 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_set_rx_mode	= netkit_set_multicast,
 	.ndo_set_rx_headroom	= netkit_set_headroom,
 	.ndo_set_mac_address	= netkit_set_macaddr,
+	.ndo_change_mtu		= netkit_set_mtu,
 	.ndo_get_iflink		= netkit_get_iflink,
 	.ndo_get_peer_dev	= netkit_peer_dev,
 	.ndo_get_stats64	= netkit_get_stats,
-- 
2.34.1


