Return-Path: <bpf+bounces-68979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96BB8B577
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC25A73ED
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BDA2D46AC;
	Fri, 19 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JUZ/vuyz"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1529BDAD;
	Fri, 19 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317530; cv=none; b=Gcvic9Oc0HOPg8Ldy0R8ZUsxHt2sOxzQXv8yVy+jiIYY7NsUyiW/i/Mf+1x+yly6JhEuQLq3T2q6RH6Cgu2CYwMyse3BLEn9H+HZ3F5oucYt5OT6TABwZEw7MCV4o+s69SJRDJwmQSQDgBRsbkbiOhLGBm7UdOYP2MFJL8nBxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317530; c=relaxed/simple;
	bh=1zLJrqegpzA8usYuymvT/Lt9C1d4kpC+uKnAo9UESAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUT4AgFOtovXrroO12JkevrD1k9FyqO0T90Wf832KAfJWv87J80gGnCUsWaoG9BvvOJ6hHi53/h1YSCT/7LehAaGs0shm5sZUc0CP6xxqz5Gw7oL+37s35/BZynNBA2eCckEB6ZxAXfOtSLrpkFQNrUOwwldjH2azxe/ZisR90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JUZ/vuyz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ofVTDNaeXlFfj4t9Mgc6jAqO2rL3ttz6rKTuuSKot3g=; b=JUZ/vuyzVIIEfN6UvA2WD7cijd
	Hp7aoLJWqXyOWjnwXiDD9As8Dw5nPQUwo0N7krYWvVc5p/mQOwt4roKbMYePQ0P8/khn2g5GTo4sm
	AfQkRW73295G11eXwnhj2jk+COT9W6m4Ilkhe3Sh1Kag2xPhpjT7WH1gwkNz9Zx6HkT5yxp8sk5pe
	WU6FgIhywt1K20vu5cOOzQmr5gQzDeIz6gvmNZqlnVDANEHTK/2jI/N3GeUlHNcv2EdOWXzrip5ot
	BuAGu3xuslG6gHv5cL6dHFhvRWPTekGEpMs0DYCadnnAi5jyagcNbb/ttv07T8FbrQCKk5P67/F4h
	n88/J3Sg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzihu-000NpU-0a;
	Fri, 19 Sep 2025 23:31:54 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com
Subject: [PATCH net-next 00/20] netkit: Support for io_uring zero-copy and AF_XDP
Date: Fri, 19 Sep 2025 23:31:33 +0200
Message-ID: <20250919213153.103606-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

Containers use virtual netdevs to route traffic from a physical netdev
in the host namespace. They do not have access to the physical netdev
in the host and thus can't use memory providers or AF_XDP that require
reconfiguring/restarting queues in the physical netdev.

This patchset adds the concept of queue peering to virtual netdevs that
allow containers to use memory providers and AF_XDP at _native speed_!
These mapped queues are bound to a real queue in a physical netdev and
act as a proxy.

Memory providers and AF_XDP operations takes an ifindex and queue id,
so containers would pass in an ifindex for a virtual netdev and a queue
id of a mapped queue, which then gets proxied to the underlying real
queue. Peered queues are created and bound to a real queue atomically
through a generic ynl netdev operation.

We have implemented support for this concept in netkit and tested the
latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
(bnxt_en) 100G NICs. For more details see the individual patches.

Daniel Borkmann (10):
  net: Add ndo_{peer,unpeer}_queues callback
  net, ethtool: Disallow mapped real rxqs to be resized
  xsk: Move NETDEV_XDP_ACT_ZC into generic header
  xsk: Move pool registration into single function
  xsk: Add small helper xp_pool_bindable
  xsk: Change xsk_rcv_check to check netdev/queue_id from pool
  xsk: Proxy pool management for mapped queues
  netkit: Add single device mode for netkit
  netkit: Document fast vs slowpath members via macros
  netkit: Add xsk support for af_xdp applications

David Wei (10):
  net, ynl: Add bind-queue operation
  net: Add peer to netdev_rx_queue
  net: Add ndo_queue_create callback
  net, ynl: Implement netdev_nl_bind_queue_doit
  net, ynl: Add peer info to queue-get response
  net: Proxy net_mp_{open,close}_rxq for mapped queues
  netkit: Implement rtnl_link_ops->alloc
  netkit: Implement ndo_queue_create
  netkit: Add io_uring zero-copy support for TCP
  tools, ynl: Add queue binding ynl sample application

 Documentation/netlink/specs/netdev.yaml |  54 ++++
 drivers/net/netkit.c                    | 362 ++++++++++++++++++++----
 include/linux/netdevice.h               |  15 +-
 include/net/netdev_queues.h             |   1 +
 include/net/netdev_rx_queue.h           |  55 ++++
 include/net/xdp_sock_drv.h              |   8 +-
 include/uapi/linux/if_link.h            |   6 +
 include/uapi/linux/netdev.h             |  20 ++
 net/core/netdev-genl-gen.c              |  14 +
 net/core/netdev-genl-gen.h              |   1 +
 net/core/netdev-genl.c                  | 144 +++++++++-
 net/core/netdev_rx_queue.c              |  15 +-
 net/ethtool/channels.c                  |  10 +-
 net/xdp/xsk.c                           |  27 +-
 net/xdp/xsk.h                           |   5 +-
 net/xdp/xsk_buff_pool.c                 |  29 +-
 tools/include/uapi/linux/netdev.h       |  20 ++
 tools/net/ynl/samples/bind.c            |  56 ++++
 18 files changed, 750 insertions(+), 92 deletions(-)
 create mode 100644 tools/net/ynl/samples/bind.c

-- 
2.43.0


