Return-Path: <bpf+bounces-78771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF78D1BB65
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2766C3098BCF
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E24736C0A5;
	Tue, 13 Jan 2026 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nXil89pt"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB536BCC2;
	Tue, 13 Jan 2026 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346613; cv=none; b=CoOxpNKxY22zTNq0oXhZpgRfEk8/I3RwUnMVvXJWzRC0YcxmFlcINu1a1pOLLj5hdKPUB8dhkoJfX42ydbCrHrtYFQtFyabQot2YkNIqBjNx1KbBzrSZRMsZWCF0jEcnMMlPw6ygvAv6Gls4DNPGT1QJP/l6UtJxrtombhU328Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346613; c=relaxed/simple;
	bh=YgVCeNuTjCNfHPi09qiblJ/MV0p2xXcW9MKem+KAD3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk1Q8ILzbiZzTPTz5rVL4gU/EIsrHUDF4XtA/K0yYSNWphI/N4ad12ljILOMejlH34ygIInQfj1ZBT2Dr8acXA6cM/zVI8WpkIVc17pTDQ9uovKUFTF5DiRea5wT175ref3tIU5W3A5SKtoL4Q8iIjrKkfpAgd01MBU9UYs2mnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nXil89pt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GrpEnD3/Rfk9oiynyWXnpRfXwuSYE9j4LT8QABd9oqw=; b=nXil89ptw3aP7hkUGXjy2hw66f
	sBFnk2majJcCusvgCxiRadKMSYCZndmM8FLO4V/ZmBakjO+xQFs9sLxNDkkzVT2+lwePR+JV9DLBL
	QKxmkkc/DcAf1u4jzV7piKuOXH7I6wG+SHo1riKMiYaGXen8ER8zvAm26C+TBJ/BOHdrt+I+YqES/
	iCE+d5YOm2ZowVwuOjsDGhxNY7PqZ+XHZPvbQakDwVz+VQzIBdKUsff78+HQApt4ig2yu49tW0XJT
	5Mk2oVohD5sQq2In3jKLHDdjvC9gs5x0eeHkjWIcbr762alkX/v5/B4+veZRaeYsxgqkxxAflNmea
	bGjQTDVg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnjE-0003ZQ-0N;
	Wed, 14 Jan 2026 00:23:12 +0100
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
Subject: [PATCH net-next v6 11/16] netkit: Add netkit notifier to check for unregistering devices
Date: Wed, 14 Jan 2026 00:22:52 +0100
Message-ID: <20260113232257.200036-12-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113232257.200036-1-daniel@iogearbox.net>
References: <20260113232257.200036-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27879/Tue Jan 13 08:26:16 2026)

Add a netdevice notifier in netkit to watch for NETDEV_UNREGISTER events.
If the target device is indeed NETREG_UNREGISTERING and previously leased
a queue to a netkit device, then collect the related netkit devices and
batch-unregister_netdevice_many() them.

If this would not be done, then the netkit device would hold a reference
on the physical device preventing it from going away. However, in case of
both io_uring zero-copy as well as AF_XDP this situation is handled
gracefully and the allocated resources are torn down.

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
---
 drivers/net/netkit.c      | 57 ++++++++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h |  6 +++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 9d9d74a7e589..af7bc6c1a423 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -1037,6 +1037,48 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
+static void netkit_check_lease_unregister(struct net_device *dev)
+{
+	LIST_HEAD(list_kill);
+	u32 q_idx;
+
+	if (READ_ONCE(dev->reg_state) != NETREG_UNREGISTERING ||
+	    !dev->dev.parent)
+		return;
+
+	netdev_lock_ops(dev);
+	for (q_idx = 0; q_idx < dev->real_num_rx_queues; q_idx++) {
+		struct net_device *tmp = dev;
+		u32 tmp_q_idx = q_idx;
+
+		if (netif_rx_queue_lease_get_owner(&tmp, &tmp_q_idx)) {
+			if (tmp->netdev_ops != &netkit_netdev_ops)
+				continue;
+			/* A single phys device can have multiple queues leased
+			 * to one netkit device. We can only queue that netkit
+			 * device once to the list_kill. Queues of that phys
+			 * device can be leased with different individual netkit
+			 * devices, hence we batch via list_kill.
+			 */
+			if (unregister_netdevice_queued(tmp))
+				continue;
+			netkit_del_link(tmp, &list_kill);
+		}
+	}
+	netdev_unlock_ops(dev);
+	unregister_netdevice_many(&list_kill);
+}
+
+static int netkit_notifier(struct notifier_block *this,
+			   unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (event == NETDEV_UNREGISTER)
+		netkit_check_lease_unregister(dev);
+	return NOTIFY_DONE;
+}
+
 static size_t netkit_get_size(const struct net_device *dev)
 {
 	return nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_POLICY */
@@ -1113,18 +1155,31 @@ static struct rtnl_link_ops netkit_link_ops = {
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
index d99b0fbc1942..4d146c000e21 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3400,11 +3400,17 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
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


