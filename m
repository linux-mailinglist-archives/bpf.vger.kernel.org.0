Return-Path: <bpf+bounces-70988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0ABDEE41
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 476A8357AF6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0BE2620E4;
	Wed, 15 Oct 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Fk2yojXh"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA0257854;
	Wed, 15 Oct 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536930; cv=none; b=LSnAeupus774LDVgK50WtnC/yByKBXYKPLqOBf/SGJTf2M+bfIiNkrroruMMof8l9lzqU4kKsFxxi/u8VWvcTK3MEXYHoVkjDHzINXL4HkLNu8Waf0C4YsHJC7IHELZZmbjIl57IySRMeh/X1p/1gX7pBp0tM2wv9J5Wmk0H2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536930; c=relaxed/simple;
	bh=IRQQwv3rZa/3BwVGaxQkE/wPBX4G8aUTl9Ce2CC+nqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOhp9nXS6ECzbggpfMkNCsJnmNwx2pi1hqmwjLOzVBjV8NnPEGW1vlPkygt0bsQ9cpVB4LhChkL4Kw+O6ypNxM6VZRvprjd9MaBL4rqBZQvNfmt6C0tLQew777OtJGFFwDpcITK4E2nH6PviODW+O1LgwB+gWNxHourHLC7xb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Fk2yojXh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=W7stEHj/iyk/0U+ga81vQNdoV5lY2i50FXa4d53DvwA=; b=Fk2yojXhd9jvTzazhku0PTM7sM
	oytd8uX78YlFcIUoR6O+uOWk8KZyLcTB0kG/i1UpfAsp999f7pwz0IRjWfzrZpB4Xq3xCc0Vmna7Z
	wXBJC7vsLyuRYUODHLGqGIkrc/riAoj28JDQJxGrJwxs9r/zwedUS+hR8oIzYtHJ9yHQwp6FOgXUB
	Gpp0oKWTsd8wK1aOWjeQoqJSy7DZ/ZNlbWxovAiPCsMXxOgO+iE42zhCpcl+g0hV+I3qrpeBDIt8/
	DvZ7Zn3WQKrdTpZdOKvJ0QJPQnhflCFSnnWcYncbcxxW5E5DSoo0JdWoEBA5rYCvVW0yLyQjTCHQT
	ZfqLQVGg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v924T-000H5s-2U;
	Wed, 15 Oct 2025 16:01:41 +0200
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
Subject: [PATCH net-next v2 00/15] netkit: Support for io_uring zero-copy and AF_XDP
Date: Wed, 15 Oct 2025 16:01:25 +0200
Message-ID: <20251015140140.62273-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27793/Wed Oct 15 11:29:40 2025)

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

Daniel Borkmann (9):
  net, ethtool: Disallow peered real rxqs to be resized
  xsk: Move NETDEV_XDP_ACT_ZC into generic header
  xsk: Move pool registration into single function
  xsk: Add small helper xp_pool_bindable
  xsk: Change xsk_rcv_check to check netdev/queue_id from pool
  xsk: Proxy pool management for mapped queues
  netkit: Add single device mode for netkit
  netkit: Document fast vs slowpath members via macros
  netkit: Add xsk support for af_xdp applications

David Wei (6):
  net: Add bind-queue operation
  net: Implement netdev_nl_bind_queue_doit
  net: Add peer info to queue-get response
  net: Proxy net_mp_{open,close}_rxq for mapped queues
  netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
  netkit: Add io_uring zero-copy support for TCP

 Documentation/netlink/specs/netdev.yaml |  84 +++++++
 drivers/net/netkit.c                    | 314 ++++++++++++++++++++----
 include/linux/ethtool.h                 |   1 +
 include/net/netdev_queues.h             |   5 +
 include/net/netdev_rx_queue.h           |  39 ++-
 include/net/page_pool/memory_provider.h |   4 +-
 include/net/xdp_sock_drv.h              |   8 +-
 include/uapi/linux/if_link.h            |   6 +
 include/uapi/linux/netdev.h             |  22 ++
 net/core/netdev-genl-gen.c              |  25 ++
 net/core/netdev-genl-gen.h              |   1 +
 net/core/netdev-genl.c                  | 177 ++++++++++++-
 net/core/netdev_rx_queue.c              | 124 ++++++++--
 net/ethtool/channels.c                  |  12 +-
 net/ethtool/common.c                    |  10 +-
 net/ethtool/ioctl.c                     |   4 +-
 net/xdp/xsk.c                           |  44 +++-
 net/xdp/xsk.h                           |   5 +-
 net/xdp/xsk_buff_pool.c                 |  18 +-
 tools/include/uapi/linux/netdev.h       |  22 ++
 20 files changed, 816 insertions(+), 109 deletions(-)

-- 
2.43.0


