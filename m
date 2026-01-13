Return-Path: <bpf+bounces-78762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 777BCD1BB1D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1C63038F75
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618BC36B06D;
	Tue, 13 Jan 2026 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jI/zYN/s"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4538241690;
	Tue, 13 Jan 2026 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346602; cv=none; b=aURmNYTO6u42TmZecblMJf26BpW6e79Nzdu9Xc0VTHZVcC5FpZJcJ1wm+7YDhvCM2OzBeqhDjnj1XbNOMSRBYqRGoSGbgWEhtbPXthQ7VDoREfq4Pfh6K1Y1rGX/q6ECqSA1y7V1aHFZAuV6oPJ0WGgunUV9sPKiHUQJvKYq9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346602; c=relaxed/simple;
	bh=KDCbhLq0dGTObzOl9kd7FyC+CNGXDffNYcsegK7M3v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWeUb1Ch9VWa9oQXrMCBRZg9vRLUdkd+10khYuVbZq34cd4euT1oIOab147EtnF7YXvZLJ04rMw/G13kICQ+kb26P8d8txiy2jnz91hOXq5J2+p4j0oPKaVo5w/KW2hwwoQzXKNIzLaAOsSuNbv+HStawSVzoMUxB/8NZFHxykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jI/zYN/s; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+3Wc1zE3FbV1o3OPptrIsJUG/DAOQPGqS4QpYdY+NCQ=; b=jI/zYN/sIBAO/uzel0Sct2ZtjV
	CQISgcPJtlshBL2d2oH+UPp8XHomkseQKV5x99OC0aWFxyVhARMGAcurswTJ4eHbDFRgBq7fMmw1N
	kSBcT7iFaq/tOzY6TDF70hq67YQ52BOZ4/QsWCh0e2SX61CHmk6tEOss8wmrehInsPdHq9AZCYg4P
	OVY9x759Ft4Z2IUysARtTZol7aOnaLbBp07vf9vlEvTwqLRmsYgTp7sKWVEoZ2LStfTnY0wGZFsqI
	dG7NKo6ao1dJpsbhMTa/0tYFMkY3kPoJZv1EyVlzkseHflF/vO3AlV0iokbUYDZxCjYpnbqPypWFI
	B1UxKZHA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnj1-0003VG-0Z;
	Wed, 14 Jan 2026 00:22:59 +0100
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
Subject: [PATCH net-next v6 00/16] netkit: Support for io_uring zero-copy and AF_XDP
Date: Wed, 14 Jan 2026 00:22:41 +0100
Message-ID: <20260113232257.200036-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27879/Tue Jan 13 08:26:16 2026)

Containers use virtual netdevs to route traffic from a physical netdev
in the host namespace. They do not have access to the physical netdev
in the host and thus can't use memory providers or AF_XDP that require
reconfiguring/restarting queues in the physical netdev.

This patchset adds the concept of queue leasing to virtual netdevs that
allow containers to use memory providers and AF_XDP at native speed.
Leased queues are bound to a real queue in a physical netdev and act
as a proxy.

Memory providers and AF_XDP operations take an ifindex and queue id,
so containers would pass in an ifindex for a virtual netdev and a queue
id of a leased queue, which then gets proxied to the underlying real
queue.

We have implemented support for this concept in netkit and tested the
latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
(bnxt_en) 100G NICs. For more details see the individual patches.

v5->v6:
 - Fix nest_queue test in netdev_nl_queue_fill_one (Jakub/AI bot)
 - Fix netdev notifier locking leak (Jakub/AI bot)
 - Drop NETREG_UNREGISTERING WARN_ON_ONCE to avoid confusion (Stan)
 - Remove slipped-in .gitignore cruft in net selftest (Stan)
 - Fix Pylint warnings in net selftest (Jakub)
v4->v5:
 - Rework of the core API into queue-create op (Jakub)
 - Rename from queue peering to queue leasing (Jakub)
 - Add net selftests for queue leasing (Stan, Jakub)
 - Move netkit_queue_get_dma_dev into core (Jakub)
 - Dropped netkit_get_channels (Jakub)
 - Moved ndo_queue_create back to return index or error (Jakub)
 - Inline __netdev_rx_queue_{peer,unpeer} helpers (Jakub)
 - Adding helpers in patches where they are used (Jakub)
 - Undo inline for netdev_put_lock (Jakub)
 - Factoring out checks whether device can lease (Jakub)
 - Fix up return codes in netdev_nl_bind_queue_doit (Jakub)
 - Reject when AF_XDP or mp already bound (Jakub)
 - Switch some error cases to NL_SET_BAD_ATTR() (Jakub)
 - Rebase and retested everything with mlx5 + bnxt_en
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

Daniel Borkmann (9):
  net: Add queue-create operation
  net: Implement netdev_nl_queue_create_doit
  net: Add lease info to queue-get response
  net, ethtool: Disallow leased real rxqs to be resized
  xsk: Extend xsk_rcv_check validation
  xsk: Proxy pool management for leased queues
  netkit: Add single device mode for netkit
  netkit: Add netkit notifier to check for unregistering devices
  netkit: Add xsk support for af_xdp applications

David Wei (7):
  net: Proxy net_mp_{open,close}_rxq for leased queues
  net: Proxy netdev_queue_get_dma_dev for leased queues
  netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
  selftests/net: Add bpf skb forwarding program
  selftests/net: Add env for container based tests
  selftests/net: Make NetDrvContEnv support queue leasing
  selftests/net: Add netkit container tests

 Documentation/netlink/specs/netdev.yaml       |  44 +++
 drivers/net/netkit.c                          | 358 +++++++++++++++---
 include/linux/netdevice.h                     |   6 +
 include/net/netdev_queues.h                   |  19 +-
 include/net/netdev_rx_queue.h                 |  21 +-
 include/net/page_pool/memory_provider.h       |   4 +-
 include/net/xdp_sock_drv.h                    |   2 +-
 include/uapi/linux/if_link.h                  |   6 +
 include/uapi/linux/netdev.h                   |  11 +
 net/core/dev.c                                |   7 +
 net/core/dev.h                                |   2 +
 net/core/netdev-genl-gen.c                    |  20 +
 net/core/netdev-genl-gen.h                    |   2 +
 net/core/netdev-genl.c                        | 185 +++++++++
 net/core/netdev_queues.c                      |  74 +++-
 net/core/netdev_rx_queue.c                    | 169 +++++++--
 net/ethtool/channels.c                        |  12 +-
 net/ethtool/ioctl.c                           |   9 +-
 net/xdp/xsk.c                                 |  73 +++-
 tools/include/uapi/linux/netdev.h             |  11 +
 .../testing/selftests/drivers/net/README.rst  |   7 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 +++
 .../selftests/drivers/net/hw/nk_netns.py      |  23 ++
 .../selftests/drivers/net/hw/nk_qlease.py     |  55 +++
 .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
 .../selftests/drivers/net/lib/py/env.py       | 157 +++++++-
 28 files changed, 1224 insertions(+), 118 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py

-- 
2.43.0


