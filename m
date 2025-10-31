Return-Path: <bpf+bounces-73192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D7C27028
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7C4F5802
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC5329376;
	Fri, 31 Oct 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="m91tSO/a"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0E3101AD;
	Fri, 31 Oct 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945694; cv=none; b=PWmYQEuZxev1bTcUys7L5780S1hrH3+kyU0ILvkpWx6ZwW9L3Ri3gd4BMBpJl3vUKvy2NKderUTPtg6EHnypK9JVTnkrdg3sM9BGRLugpavOIYwE2oJRKjPlzvyQcTcBqhZnL+sM+2hIhGu3AsE7Fro8Az1BlGzLIWnJ5kdYCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945694; c=relaxed/simple;
	bh=NXiimyZ/1wmiaRxewp9gBjgM4HRGvjrz57yUXqX3E+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0WguVMG0WgDGbulaGpNIJm/Z4pYLKsHftqWTm8cZsdCUmTErxzyQpxU1tXwOusCel5koG0UsRXif5a+jbclJr7AALsF9SYnvTPnpfbNwepe7HNtNXav/qZ6DyHGx8MZ10mEZNVo7SjolCZRumff5LhccTFpC2kqMw7VfgQxXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=m91tSO/a; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=q5mSQy0BwAr9p1sNCsFF4z0UVqOo6GWUlXQYejBoQe0=; b=m91tSO/am+rc90qpXiYt8LKzKc
	5ql3yvKY5UN+ZAtkPEhWRrrAP980jknQyPiwHpFvJBxzQRG8TzPHBfI7T8Zf43o6H62n6lp19M35K
	3sgOtESJASOB2ff4IjVefOCIGGipuJ/3Rmzng+/MDYBGnBliSGDV0sjPgN4PQOFo096QAqEd+k1wN
	hkP+LZ/SLuL5XfWxfWPx53SM3lfC8lWXtiRDDuYSSNPaRcDnknnKD+aQ+Wx03Qlwvbfw6U1p6P8rd
	kKyjtFg/Gr0qAx5/3U4lVIRrhnjSDYo2e7Ljl2XdC+T/TeCNErt6TV+fiYv7YQhX9wbfhYxn1HBnm
	MDm7W2KA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYS-0005bu-2r;
	Fri, 31 Oct 2025 22:21:04 +0100
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
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy and AF_XDP
Date: Fri, 31 Oct 2025 22:20:49 +0100
Message-ID: <20251031212103.310683-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27809/Fri Oct 31 10:42:21 2025)

Containers use virtual netdevs to route traffic from a physical netdev
in the host namespace. They do not have access to the physical netdev
in the host and thus can't use memory providers or AF_XDP that require
reconfiguring/restarting queues in the physical netdev.

This patchset adds the concept of queue peering to virtual netdevs that
allow containers to use memory providers and AF_XDP at native speed.
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

v3->v4:
 - ndo_queue_create store dst queue via arg (Nikolay)
 - Small nits like a spelling issue + rev xmas (Nikolay)
 - admin-perm flag in bind-queue spec (Jakub)
 - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
 - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
 - New patch (12/14) to handle the underlying device going away (Jakub)
 - Improve commit message on queue-get (Jakub)
 - Do not expose phys dev info from container on queue-get (Jakub)
 - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
 - Rework xsk handling to simplify the code and drop a few patches
 - Rebase and retested everything with mlx5 + bnxt_en
v2->v3:
 - Use netdev_ops_assert_locked instead of netdev_assert_locked (syzbot)
 - Add missing netdev_lockdep_set_classes in netkit
v1->v2:
 - Removed bind sample ynl code (Stan)
 - Reworked netdev locking to have consistent order (Stan, Kuba)
 - Return 'not supported' in API patch (Stan)
 - Improved ynl documentation (Kuba)
 - Added 'max: s32-max' in ynl spec for ifindex (Kuba)
 - Added also queue type in ynl to have user specify rx to make
   it obvious (Kuba)
 - Use of netdev_hold (Kuba)
 - Avoid static inlines from another header (Kuba)
 - Squashed some commits (Kuba, Stan)
 - Removed ndo_{peer,unpeer}_queues callback and simplified
   code (Kuba)
 - Improved commit messages (Toke, Kuba, Stan, zf)
 - Got rid of locking genl_sk_priv_get (Stan)
 - Removed af_xdp cleanup churn (Maciej)
 - Added netdev locking asserts (Stan)
 - Reject ethtool ioctl path queue resizing (Kuba)
 - Added kdoc for ndo_queue_create (Stan)
 - Uninvert logic in netkit single dev mode (Jordan)
 - Added binding support for multiple queues

Daniel Borkmann (8):
  net, ethtool: Disallow peered real rxqs to be resized
  xsk: Move NETDEV_XDP_ACT_ZC into generic header
  xsk: Extend xsk_rcv_check validation
  xsk: Proxy pool management for mapped queues
  netkit: Add single device mode for netkit
  netkit: Document fast vs slowpath members via macros
  netkit: Add netkit notifier to check for unregistering devices
  netkit: Add xsk support for af_xdp applications

David Wei (6):
  net: Add bind-queue operation
  net: Implement netdev_nl_bind_queue_doit
  net: Add peer info to queue-get response
  net: Proxy net_mp_{open,close}_rxq for mapped queues
  netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
  netkit: Add io_uring zero-copy support for TCP

 Documentation/netlink/specs/netdev.yaml |  85 +++++
 drivers/net/netkit.c                    | 393 ++++++++++++++++++++----
 include/linux/ethtool.h                 |   1 +
 include/linux/netdevice.h               |   6 +
 include/net/netdev_queues.h             |   7 +
 include/net/netdev_rx_queue.h           |  45 ++-
 include/net/page_pool/memory_provider.h |   4 +-
 include/net/xdp_sock_drv.h              |   4 +
 include/uapi/linux/if_link.h            |   6 +
 include/uapi/linux/netdev.h             |  22 ++
 net/core/dev.h                          |   7 +
 net/core/netdev-genl-gen.c              |  25 ++
 net/core/netdev-genl-gen.h              |   1 +
 net/core/netdev-genl.c                  | 187 ++++++++++-
 net/core/netdev_rx_queue.c              | 129 ++++++--
 net/ethtool/channels.c                  |  12 +-
 net/ethtool/common.c                    |  10 +-
 net/ethtool/ioctl.c                     |   4 +-
 net/xdp/xsk.c                           |  71 ++++-
 net/xdp/xsk_buff_pool.c                 |   6 +-
 tools/include/uapi/linux/netdev.h       |  22 ++
 21 files changed, 938 insertions(+), 109 deletions(-)

-- 
2.43.0


