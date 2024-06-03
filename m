Return-Path: <bpf+bounces-31182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAF8D7DFA
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 10:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5100E1C211BD
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F60B7829C;
	Mon,  3 Jun 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="M5BF7/K2"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF723BBF3;
	Mon,  3 Jun 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405178; cv=none; b=Ao3o9Np9YP7ieg6x3aYAtiJ2u+vZdnEafderQ3EqVBVxsHQwuRhxGqji8mVey0F4XZfFl756OAyjhVqrNqLuodzlhPPG+BSCwg8MYPyQDxftHhaWL2Ca+yGOGLjxxX+EToAaXGjwxSvLBcpgmmKBRGMJ/FY22GEIWYHn1C58Sgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405178; c=relaxed/simple;
	bh=YjhSDpAWleEs9BPBmEs280DWm8Awk83Zv7R9WMe2Id8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OAiTViMdhGUNVZDYzLjRATFHRg7OU67WQ6P/+C532JNkO3hEjOqF42hFGQPevbmx2rcvhtjjtkO+XUiZjDcnGkn0WS/J7VRoKHFqfir8etmf/Rd93DuH3rF4wGAXehIVAWRV8xJqH+wZR4ugYWdPeLWjYWMOnFoUuWOyCr7zYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=M5BF7/K2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=lZ/LyNdtSnF0AiaJ6+PvIy76nSDZwJ0+Z/JHxOAO9DQ=; b=M5BF7/K2A184RnFJzHueA9mDru
	rX8SVtiHZ1xVwZofAb2afV0qoqzuJieMKY3CkILYyWRrEWH4G9QDiEkzQxXZBOrkaKJzUPIQCECG5
	EuOOLLiLiJG/gl6zsEVhBrw7ZmrY2fKqwHrF3zLvxiY9rPkRYl8oGcCkbVqMFw6pO2jXhdvWE+nkB
	Q8ANhfYeLYTDblfUmhy++TosElRq89n1mT19UtTcFiXtPuxvigAWNkdbighP3VFCbTwzu854Sptwo
	eW2gj0k+jmy5xD8ZyvMaruhRxV6GfNIx3EJbPYsLKKa3cRKfLcYjHzKO2HYUbYFNcDtmrVoF/kwDK
	0fCNCYdg==;
Received: from 29.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.29] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sE3XN-000LW6-En; Mon, 03 Jun 2024 10:59:29 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Bauer <mail@david-bauer.net>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v2 net] vxlan: Fix regression when dropping packets due to invalid src addresses
Date: Mon,  3 Jun 2024 10:59:26 +0200
Message-Id: <20240603085926.7918-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27294/Sun Jun  2 10:29:37 2024)

Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
has recently been added to vxlan mainly in the context of source
address snooping/learning so that when it is enabled, an entry in the
FDB is not being created for an invalid address for the corresponding
tunnel endpoint.

Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
that it passed through whichever macs were set in the L2 header. It
turns out that this change in behavior breaks setups, for example,
Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
passing before the change in f58f45c1e5b9 for both vxlan and geneve.
After mentioned change it is only passing for geneve as in case of
vxlan packets are dropped due to vxlan_set_mac() returning false as
source and destination macs are zero which for E/W traffic via tunnel
is totally fine.

Fix it by only opting into the is_valid_ether_addr() check in
vxlan_set_mac() when in fact source address snooping/learning is
actually enabled in vxlan. This is done by moving the check into
vxlan_snoop(). With this change, the Cilium connectivity test suite
passes again for both tunnel flavors.

Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Bauer <mail@david-bauer.net>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 v1 -> v2:
  - Moved is_valid_ether_addr into vxlan_snoop, thanks Ido!

 drivers/net/vxlan/vxlan_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f78dd0438843..567cb3faab70 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1446,6 +1446,10 @@ static bool vxlan_snoop(struct net_device *dev,
 	struct vxlan_fdb *f;
 	u32 ifindex = 0;
 
+	/* Ignore packets from invalid src-address */
+	if (!is_valid_ether_addr(src_mac))
+		return true;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
 	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
@@ -1616,10 +1620,6 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
 		return false;
 
-	/* Ignore packets from invalid src-address */
-	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
-		return false;
-
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
 		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
-- 
2.34.1


