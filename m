Return-Path: <bpf+bounces-46510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DD79EB2DF
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FAB169074
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D731AAA35;
	Tue, 10 Dec 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZapmCc7A"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913291AAA16;
	Tue, 10 Dec 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839980; cv=none; b=PEjkVgy91hEMn2LR6Pq79TelmyEnlDeDOPWVEqlZQDkJOJBFFyyGOmKmzCt/ezVdBw8RjBkaDLaYgOiT7TDK+ehnOFB2v/fIRaz0g/vQawDxNjbZYXGJK2fCvqdZ3wDi8Ag7qaNoaO/8zCc3cr9Usfb3P5u7IHkaNb7ikbanv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839980; c=relaxed/simple;
	bh=Gqy1cO8kzYjNqYASuqlTqRoNVTgBvuWhGXTo7oU4TSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ig7wVT7g1ctUg7iQh7UpXfoXlrnILvaP/FiUWmBQOva1ErTtIHs9grhn61F0/W8GwWUlUYoDKjvOHQEfD9Hp3aM58fIWBjOgxMN6mKeDzetwblow06zorYk4i/vMHa24uIZbqmZkFV3iNPB2A0nnqj+mOlSdTY+KvgjTP4cZE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZapmCc7A; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MMgtaFpnKy53Gq3CYekdZmnl9n6mn/hR4Zipw2JM5yc=; b=ZapmCc7AMibXhx97+LYgD9Bb01
	POfog218cQoFK/k9+PU+jnSG48ygjuBHvAAHsAPopflBuesmf8gpaUi9EHneaApVmUGOq0gvlIGJJ
	X7qwLDwM0Y8jKjaQTuJWLiT6vlOgZ81/T+E3qJnvWSW3HisHk9g6rbmqAPFmZrOH5sl94gF5BudFt
	vwtkeKLug5qYtKcyC/idyslqE9QJ8ucpbkpoyouKc0psq4a/bL5Ew7DV81UV9yYMoAlyTQjr/I4S3
	d5BB2KisS4d53c1+aPFViLAwhI/4nnZ9AYPqlbUh1L348VfbKnGHgaxemueFWeVw2/X7Httgdxi4W
	esU96ssg==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tL0yl-000JgP-Cy; Tue, 10 Dec 2024 15:12:47 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net 3/5] bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
Date: Tue, 10 Dec 2024 15:12:43 +0100
Message-ID: <20241210141245.327886-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
References: <20241210141245.327886-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27483/Tue Dec 10 10:38:50 2024)

Drivers like mlx5 expose NIC's vlan_features such as
NETIF_F_GSO_UDP_TUNNEL & NETIF_F_GSO_UDP_TUNNEL_CSUM which are
later not propagated when the underlying devices are bonded and
a vlan device created on top of the bond.

Right now, the more cumbersome workaround for this is to create
the vlan on top of the mlx5 and then enslave the vlan devices
to a bond.

To fix this, add NETIF_F_GSO_ENCAP_ALL to BOND_VLAN_FEATURES
such that bond_compute_features() can probe and propagate the
vlan_features from the slave devices up to the vlan device.

Given the following bond:

  # ethtool -i enp2s0f{0,1}np{0,1}
  driver: mlx5_core
  [...]

  # ethtool -k enp2s0f0np0 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: on
  rx-udp-gro-forwarding: off

  # ethtool -k enp2s0f1np1 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: on
  rx-udp-gro-forwarding: off

  # ethtool -k bond0 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: off [fixed]
  rx-udp-gro-forwarding: off

Before:

  # ethtool -k bond0.100 | grep udp
  tx-udp_tnl-segmentation: off [requested on]
  tx-udp_tnl-csum-segmentation: off [requested on]
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: off [fixed]
  rx-udp-gro-forwarding: off

After:

  # ethtool -k bond0.100 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: off [fixed]
  rx-udp-gro-forwarding: off

Various users have run into this reporting performance issues when
configuring Cilium in vxlan tunneling mode and having the combination
of bond & vlan for the core devices connecting the Kubernetes cluster
to the outside world.

Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 320dd71392ef..7b78c2bada81 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1534,6 +1534,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 
 #define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_ENCAP_ALL | \
 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-- 
2.43.0


