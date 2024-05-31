Return-Path: <bpf+bounces-31040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D48D65F4
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C097728F49E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343171420C8;
	Fri, 31 May 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MC/trjpr"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91EC1C6AE;
	Fri, 31 May 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170131; cv=none; b=QNH7n8RQwVaFtu0T+71hZM8Qf6FBCueMMWuCLKOHWKszXHFfIN5QCbQmAMMs/D9DABTmAHsvhLU6Jw+twZcepdzBS+Y+5MLW/+koOmk8IISJidXrlGzyFjDPUtVlIiegC4tRhyGuVDKHdtPO2Bt6fS7Ws8LipyCdAiYq9WnM3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170131; c=relaxed/simple;
	bh=zoYd0gJpYdaAhfYqVtufyS9K393/+FrO9bwRAXPzseM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g20BQDgFztIFFD90WFKvRxOAjVOHsrbs7FNDkHg0s3Z/g3OCYR2Co7ZEWsCoQnNJCSQ9sWyhPqw6y/IAbPWn3FHSpLNAh5Ss8gHoG7MPgEkiIjDWAKkYQ4HhMfw3G9u19sPazVSyYObwfiRrBRM4EF7zpuc8gtOayVdN3mZsofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MC/trjpr; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QUasHQjiMDVL7F+S/wQSRjT4b/HaYFkd5OKHznJOtRA=; b=MC/trjprTKzybImHg4pb5wOwWE
	4iZs+ToFSJabe1TMgiTemQ1oruanqvYQkzAWiOKXBlE8I1SDqMbEc1qMrnqlSUI11aIQzVF3Q3eO7
	dIS/wnsEUtR9c+7nBP/78cZ7+g9Hc83vfrNREMc4+4Xf+lZ5ge7yt2of8YdqCzBwmI4W4LNHts+XO
	IfnBcbtD4CfhJm7wFfuWvAQwy3ObFmehQTkGC4fJu3vjQnRev1jX4/wwDXlPOMpy4IaW7dS5/Yuv/
	pjlJNftM3yuKBHFaBc4XXAh9jgLQ6GPu2TTFYWhOrK/k/waMJoAKVnmSaUxg9URLr0201QK9NUgk7
	4ACzq6Gw==;
Received: from 50.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.50] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sD4Ny-000KKH-M6; Fri, 31 May 2024 17:41:42 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Bauer <mail@david-bauer.net>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH net] vxlan: Fix regression when dropping packets due to invalid src addresses
Date: Fri, 31 May 2024 17:41:37 +0200
Message-Id: <20240531154137.26797-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27292/Fri May 31 10:31:14 2024)

Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
has been recently added to vxlan mainly in the context of source
address snooping/learning so that when it is enabled, an entry in the
FDB is not being created for an invalid address for the tunnel endpoint.

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
actually enabled in vxlan. With this change, the Cilium connectivity
test suite passes again for both tunnel flavors.

Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Bauer <mail@david-bauer.net>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f78dd0438843..7353f27b02dc 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1605,6 +1605,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 			  struct vxlan_sock *vs,
 			  struct sk_buff *skb, __be32 vni)
 {
+	bool learning = vxlan->cfg.flags & VXLAN_F_LEARN;
 	union vxlan_addr saddr;
 	u32 ifindex = skb->dev->ifindex;
 
@@ -1616,8 +1617,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
 		return false;
 
-	/* Ignore packets from invalid src-address */
-	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
+	/* Ignore packets from invalid src-address when in learning mode,
+	 * otherwise let them through e.g. when originating from NOARP
+	 * devices with all-zero mac, etc.
+	 */
+	if (learning && !is_valid_ether_addr(eth_hdr(skb)->h_source))
 		return false;
 
 	/* Get address from the outer IP header */
@@ -1631,7 +1635,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 #endif
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
+	if (learning &&
 	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
 		return false;
 
-- 
2.34.1


