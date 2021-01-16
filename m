Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B406F2F8AD0
	for <lists+bpf@lfdr.de>; Sat, 16 Jan 2021 03:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbhAPCqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jan 2021 21:46:23 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38516 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbhAPCqW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Jan 2021 21:46:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0ULqwJa7_1610765093;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0ULqwJa7_1610765093)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 16 Jan 2021 10:44:53 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Meir Lichtinger <meirl@mellanox.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] xsk: build skb by page
Date:   Sat, 16 Jan 2021 10:44:53 +0800
Message-Id: <579fa463bba42ac71591540a1811dca41d725350.1610764948.git.xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch is used to construct skb based on page to save memory copy
overhead.

This has one problem:

We construct the skb by fill the data page as a frag into the skb. In
this way, the linear space is empty, and the header information is also
in the frag, not in the linear space, which is not allowed for some
network cards. For example, Mellanox Technologies MT27710 Family
[ConnectX-4 Lx] will get the following error message:

    mlx5_core 0000:3b:00.1 eth1: Error cqe on cqn 0x817, ci 0x8, qn 0x1dbb, opcode 0xd, syndrome 0x1, vendor syndrome 0x68
    00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000030: 00 00 00 00 60 10 68 01 0a 00 1d bb 00 0f 9f d2
    WQE DUMP: WQ size 1024 WQ cur size 0, WQE index 0xf, len: 64
    00000000: 00 00 0f 0a 00 1d bb 03 00 00 00 08 00 00 00 00
    00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000020: 00 00 00 2b 00 08 00 00 00 00 00 05 9e e3 08 00
    00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    mlx5_core 0000:3b:00.1 eth1: ERR CQE on SQ: 0x1dbb

I also tried to use build_skb to construct skb, but because of the
existence of skb_shinfo, it must be behind the linear space, so this
method is not working. We can't put skb_shinfo on desc->addr, it will be
exposed to users, this is not safe.

Finally, I added a feature NETIF_F_SKB_NO_LINEAR to identify whether the
network card supports the header information of the packet in the frag
and not in the linear space.

---------------- Performance Testing ------------

The test environment is Aliyun ECS server.
Test cmd:
```
xdpsock -i eth0 -t  -S -s <msg size>
```

Test result data:

size    64      512     1024    1500
copy    1916747 1775988 1600203 1440054
page    1974058 1953655 1945463 1904478
percent 3.0%    10.0%   21.58%  32.3%

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 drivers/net/virtio_net.c        |   2 +-
 include/linux/netdev_features.h |   5 +-
 net/ethtool/common.c            |   1 +
 net/xdp/xsk.c                   | 108 +++++++++++++++++++++++++++++++++-------
 4 files changed, 97 insertions(+), 19 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4ecccb8..841a331 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2985,7 +2985,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	/* Set up network device as normal. */
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
 	dev->netdev_ops = &virtnet_netdev;
-	dev->features = NETIF_F_HIGHDMA;
+	dev->features = NETIF_F_HIGHDMA | NETIF_F_SKB_NO_LINEAR;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 934de56..8dd28e2 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -85,9 +85,11 @@ enum {
 
 	NETIF_F_HW_MACSEC_BIT,		/* Offload MACsec operations */
 
+	NETIF_F_SKB_NO_LINEAR_BIT,	/* Allow skb linear is empty */
+
 	/*
 	 * Add your fresh new feature above and remember to update
-	 * netdev_features_strings[] in net/core/ethtool.c and maybe
+	 * netdev_features_strings[] in net/ethtool/common.c and maybe
 	 * some feature mask #defines below. Please also describe it
 	 * in Documentation/networking/netdev-features.rst.
 	 */
@@ -157,6 +159,7 @@ enum {
 #define NETIF_F_GRO_FRAGLIST	__NETIF_F(GRO_FRAGLIST)
 #define NETIF_F_GSO_FRAGLIST	__NETIF_F(GSO_FRAGLIST)
 #define NETIF_F_HW_MACSEC	__NETIF_F(HW_MACSEC)
+#define NETIF_F_SKB_NO_LINEAR	__NETIF_F(SKB_NO_LINEAR)
 
 /* Finds the next feature with the highest number of the range of start till 0.
  */
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 24036e3..2f3d309 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -68,6 +68,7 @@
 	[NETIF_F_HW_TLS_RX_BIT] =	 "tls-hw-rx-offload",
 	[NETIF_F_GRO_FRAGLIST_BIT] =	 "rx-gro-list",
 	[NETIF_F_HW_MACSEC_BIT] =	 "macsec-hw-offload",
+	[NETIF_F_SKB_NO_LINEAR_BIT] =	 "skb-no-linear",
 };
 
 const char
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 8037b04..94d17dc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -430,6 +430,95 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 
+static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
+					      struct xdp_desc *desc)
+{
+	u32 len, offset, copy, copied;
+	struct sk_buff *skb;
+	struct page *page;
+	char *buffer;
+	int err, i;
+	u64 addr;
+
+	skb = sock_alloc_send_skb(&xs->sk, 0, 1, &err);
+	if (unlikely(!skb))
+		return NULL;
+
+	addr = desc->addr;
+	len = desc->len;
+
+	buffer = xsk_buff_raw_get_data(xs->pool, addr);
+	offset = offset_in_page(buffer);
+	addr = buffer - (char *)xs->pool->addrs;
+
+	for (copied = 0, i = 0; copied < len; ++i) {
+		page = xs->pool->umem->pgs[addr >> PAGE_SHIFT];
+
+		get_page(page);
+
+		copy = min((u32)(PAGE_SIZE - offset), len - copied);
+
+		skb_fill_page_desc(skb, i, page, offset, copy);
+
+		copied += copy;
+		addr += copy;
+		offset = 0;
+	}
+
+	skb->len += len;
+	skb->data_len += len;
+	skb->truesize += len;
+
+	refcount_add(len, &xs->sk.sk_wmem_alloc);
+
+	return skb;
+}
+
+static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+				     struct xdp_desc *desc, int *err)
+{
+	struct sk_buff *skb;
+
+	if (xs->dev->features & NETIF_F_SKB_NO_LINEAR) {
+		skb = xsk_build_skb_zerocopy(xs, desc);
+		if (unlikely(!skb)) {
+			*err = -ENOMEM;
+			return NULL;
+		}
+	} else {
+		char *buffer;
+		u64 addr;
+		u32 len;
+		int err;
+
+		len = desc->len;
+		skb = sock_alloc_send_skb(&xs->sk, len, 1, &err);
+		if (unlikely(!skb)) {
+			*err = -ENOMEM;
+			return NULL;
+		}
+
+		skb_put(skb, len);
+		addr = desc->addr;
+		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
+		err = skb_store_bits(skb, 0, buffer, len);
+
+		if (unlikely(err)) {
+			kfree_skb(skb);
+			*err = -EINVAL;
+			return NULL;
+		}
+	}
+
+	skb->dev = xs->dev;
+	skb->priority = xs->sk.sk_priority;
+	skb->mark = xs->sk.sk_mark;
+	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
+	skb->destructor = xsk_destruct_skb;
+
+	return skb;
+}
+
 static int xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
@@ -446,43 +535,28 @@ static int xsk_generic_xmit(struct sock *sk)
 		goto out;
 
 	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
-		char *buffer;
-		u64 addr;
-		u32 len;
-
 		if (max_batch-- == 0) {
 			err = -EAGAIN;
 			goto out;
 		}
 
-		len = desc.len;
-		skb = sock_alloc_send_skb(sk, len, 1, &err);
+		skb = xsk_build_skb(xs, &desc, &err);
 		if (unlikely(!skb))
 			goto out;
 
-		skb_put(skb, len);
-		addr = desc.addr;
-		buffer = xsk_buff_raw_get_data(xs->pool, addr);
-		err = skb_store_bits(skb, 0, buffer, len);
 		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
 		spin_lock_irqsave(&xs->pool->cq_lock, flags);
-		if (unlikely(err) || xskq_prod_reserve(xs->pool->cq)) {
+		if (xskq_prod_reserve(xs->pool->cq)) {
 			spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
 			kfree_skb(skb);
 			goto out;
 		}
 		spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
 
-		skb->dev = xs->dev;
-		skb->priority = sk->sk_priority;
-		skb->mark = sk->sk_mark;
-		skb_shinfo(skb)->destructor_arg = (void *)(long)desc.addr;
-		skb->destructor = xsk_destruct_skb;
-
 		err = __dev_direct_xmit(skb, xs->queue_id);
 		if  (err == NETDEV_TX_BUSY) {
 			/* Tell user-space to retry the send */
-- 
1.8.3.1

