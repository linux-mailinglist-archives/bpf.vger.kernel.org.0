Return-Path: <bpf+bounces-73199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8168C27034
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CD064EF475
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DDB3128B1;
	Fri, 31 Oct 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oLsrPh48"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7131691D;
	Fri, 31 Oct 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945696; cv=none; b=RXLwm37mVbOp69qw8OVaYCP8oocnSjQZ6/qViJlvfiA3nvIIYILikIjnl9hozLx4TI3/YX8S3N1lZMsF3VCvkJAyJDIiojgbl4DvlcPsYllKBH4olhXAeE6VBL0MghnMGaI2HtpE50lY1ju8Q7usS3oR95sGzwof88lvJgXQOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945696; c=relaxed/simple;
	bh=piwuP1PyahjY1vzyzGp0lXn+fw2rVHNPOL3DafAFis8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfLYUgYU5QsLKHGDmqDtATcF2ynvxDPZMC2ln+vthhsdPiRAFOLjbx0tZDuR/vY1NnQSYmRPEo6bp8HgBuWXik3g/eQZwZLLEY13SDohzU8o70cqZU4SRg9g0T7iili6j7cfghjD7ElJ5XNO6gep4qrw+aFnqHxYmL23E5FMqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oLsrPh48; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5+YPvRExsWlB41HzBVjX2BvxQzWijzNsTAdC0v/boRU=; b=oLsrPh48+iH5fuO0/NBi6tg2bG
	m1bxG3AH+ipWpKzYEZhWxuI1Oc0Zkxs5cNCLJzAmQNBnEQ/DM8fjc42RlgCr8IbO+T3dpXFcT16Kc
	Fkn+4dW8y3uI0zywEKLy1Pi3UPhCA1uzZklNMFQ7z6DD6YTgMZWauVjOyiRKdZLkZk9vdJlry+9zC
	PqbUsysaBkfrCULVk6DynGs9ls5U05+cbavbTuocShGRqKVyw7+xTQlf5ZntR8UTg0MIZM+2So1RZ
	hV8k2QcKIi2UUyHXvv8r6hzK6IG6gXhWR1OI0fb9SyfjPwrLaaErlDQgF+787bJ3jbILni3G1K2bx
	snIXZEkg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYg-0005eS-2C;
	Fri, 31 Oct 2025 22:21:18 +0100
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
Subject: [PATCH net-next v4 12/14] netkit: Add netkit notifier to check for unregistering devices
Date: Fri, 31 Oct 2025 22:21:01 +0100
Message-ID: <20251031212103.310683-13-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27809/Fri Oct 31 10:42:21 2025)

Add a netdevice notifier in netkit to watch for NETDEV_UNREGISTER events.
If the target device is indeed NETREG_UNREGISTERING and was previously
peered to a netkit device, then collect the related netkit devices and
batch-unregister_netdevice_many() them.

If this would not be done, then the netkit device would hold a reference
on the peered physical device preventing it from going away. However, in
case of both io_uring zero-copy as well as AF_XDP this situation is
handled gracefully and the allocated resources as torn down.

In the case where mentioned infra is used through netkit, the applications
have a reference on netkit, and netkit in turn holds a reference on the
physical device. In order to have netkit release the reference on the
physical device, we need such watcher to then unregister the netkit ones.

This is generally quite similar to the dependency handling in case of
tunnels (e.g. vxlan bound to a underlying netdev) where the tunnel device
gets removed along with the physical device.

  # ip a
  [...]
  4: enp10s0f0np0: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN group default qlen 1000
      link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
      inet 10.0.0.2/24 scope global enp10s0f0np0
         valid_lft forever preferred_lft forever
  [...]
  8: nk@NONE: <BROADCAST,MULTICAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
  [...]

  # rmmod mlx5_ib
  # rmmod mlx5_core

  [  309.261822] mlx5_core 0000:0a:00.0 mlx5_0: Port: 1 Link DOWN
  [  344.235236] mlx5_core 0000:0a:00.1: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.246948] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.463754] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.770155] mlx5_core 0000:0a:00.1: E-Switch: cleanup
  [  345.345709] mlx5_core 0000:0a:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  345.357524] mlx5_core 0000:0a:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  350.995989] mlx5_core 0000:0a:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  351.574396] mlx5_core 0000:0a:00.0: E-Switch: cleanup

  # ip a
  [...]
  [ both enp10s0f0np0 and nk gone ]
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c      | 57 ++++++++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h |  6 +++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 92a65350f389..2871d8b08f6d 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -1050,6 +1050,48 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
+static void netkit_check_peer_unregister(struct net_device *dev)
+{
+	LIST_HEAD(list_kill);
+	u32 q_idx;
+
+	if (READ_ONCE(dev->reg_state) != NETREG_UNREGISTERING ||
+	    !dev->dev.parent)
+		return;
+
+	for (q_idx = 0; q_idx < dev->real_num_rx_queues; q_idx++) {
+		struct net_device *peer = dev;
+		u32 peer_q_idx = q_idx;
+
+		if (__netif_get_rx_queue_peer(&peer, &peer_q_idx,
+					      NETIF_PHYS_TO_VIRT)) {
+			if (peer->netdev_ops != &netkit_netdev_ops)
+				continue;
+			/* A single phys device can have multiple queues peered
+			 * to one netkit device. We can only queue that netkit
+			 * device once to the list_kill. Queues of that phys
+			 * device can be peered with different individual netkit
+			 * devices, hence we batch via list_kill.
+			 */
+			if (unregister_netdevice_queued(peer))
+				continue;
+			netkit_del_link(peer, &list_kill);
+		}
+	}
+
+	unregister_netdevice_many(&list_kill);
+}
+
+static int netkit_notifier(struct notifier_block *this,
+			   unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (event == NETDEV_UNREGISTER)
+		netkit_check_peer_unregister(dev);
+	return NOTIFY_DONE;
+}
+
 static size_t netkit_get_size(const struct net_device *dev)
 {
 	return nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_POLICY */
@@ -1126,18 +1168,31 @@ static struct rtnl_link_ops netkit_link_ops = {
 	.maxtype	= IFLA_NETKIT_MAX,
 };
 
+static struct notifier_block netkit_netdev_notifier = {
+	.notifier_call	= netkit_notifier,
+};
+
 static __init int netkit_mod_init(void)
 {
+	int ret;
+
 	BUILD_BUG_ON((int)NETKIT_NEXT != (int)TCX_NEXT ||
 		     (int)NETKIT_PASS != (int)TCX_PASS ||
 		     (int)NETKIT_DROP != (int)TCX_DROP ||
 		     (int)NETKIT_REDIRECT != (int)TCX_REDIRECT);
 
-	return rtnl_link_register(&netkit_link_ops);
+	ret = rtnl_link_register(&netkit_link_ops);
+	if (ret)
+		return ret;
+	ret = register_netdevice_notifier(&netkit_netdev_notifier);
+	if (ret)
+		rtnl_link_unregister(&netkit_link_ops);
+	return ret;
 }
 
 static __exit void netkit_mod_exit(void)
 {
+	unregister_netdevice_notifier(&netkit_netdev_notifier);
 	rtnl_link_unregister(&netkit_link_ops);
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9c1e5042c5e7..efc3c9fb4567 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3385,11 +3385,17 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
 void unregister_netdevice_many(struct list_head *head);
+
 static inline void unregister_netdevice(struct net_device *dev)
 {
 	unregister_netdevice_queue(dev, NULL);
 }
 
+static inline bool unregister_netdevice_queued(const struct net_device *dev)
+{
+	return !list_empty(&dev->unreg_list);
+}
+
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
 
-- 
2.43.0


