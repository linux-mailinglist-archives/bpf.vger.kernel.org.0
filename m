Return-Path: <bpf+bounces-18860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D9822AC4
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31932285640
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033318E33;
	Wed,  3 Jan 2024 09:57:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED21865E;
	Wed,  3 Jan 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T4lV63cQSz29jY1;
	Wed,  3 Jan 2024 17:56:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D65C14025A;
	Wed,  3 Jan 2024 17:57:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 17:57:24 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: [PATCH net-next 4/6] vhost/net: remove vhost_net_page_frag_refill()
Date: Wed, 3 Jan 2024 17:56:47 +0800
Message-ID: <20240103095650.25769-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240103095650.25769-1-linyunsheng@huawei.com>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

The page frag in vhost_net_page_frag_refill() uses the
'struct page_frag' from skb_page_frag_refill(), but it's
implementation is similar to page_frag_alloc_align() now.

This patch removes vhost_net_page_frag_refill() by using
'struct page_frag_cache' instead of 'struct page_frag',
and allocating frag using page_frag_alloc_align().

The added benefit is that not only unifying the page frag
implementation a little, but also having about 0.5% performance
boost testing by using the vhost_net_test introduced in the
last patch.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 93 ++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 64 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index e574e21cc0ca..805e11d598e4 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -141,10 +141,8 @@ struct vhost_net {
 	unsigned tx_zcopy_err;
 	/* Flush in progress. Protected by tx vq lock. */
 	bool tx_flush;
-	/* Private page frag */
-	struct page_frag page_frag;
-	/* Refcount bias of page frag */
-	int refcnt_bias;
+	/* Private page frag cache */
+	struct page_frag_cache pf_cache;
 };
 
 static unsigned vhost_net_zcopy_mask __read_mostly;
@@ -655,41 +653,6 @@ static bool tx_can_batch(struct vhost_virtqueue *vq, size_t total_len)
 	       !vhost_vq_avail_empty(vq->dev, vq);
 }
 
-static bool vhost_net_page_frag_refill(struct vhost_net *net, unsigned int sz,
-				       struct page_frag *pfrag, gfp_t gfp)
-{
-	if (pfrag->page) {
-		if (pfrag->offset + sz <= pfrag->size)
-			return true;
-		__page_frag_cache_drain(pfrag->page, net->refcnt_bias);
-	}
-
-	pfrag->offset = 0;
-	net->refcnt_bias = 0;
-	if (SKB_FRAG_PAGE_ORDER) {
-		/* Avoid direct reclaim but allow kswapd to wake */
-		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
-					  __GFP_COMP | __GFP_NOWARN |
-					  __GFP_NORETRY | __GFP_NOMEMALLOC,
-					  SKB_FRAG_PAGE_ORDER);
-		if (likely(pfrag->page)) {
-			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
-			goto done;
-		}
-	}
-	pfrag->page = alloc_page(gfp);
-	if (likely(pfrag->page)) {
-		pfrag->size = PAGE_SIZE;
-		goto done;
-	}
-	return false;
-
-done:
-	net->refcnt_bias = USHRT_MAX;
-	page_ref_add(pfrag->page, USHRT_MAX - 1);
-	return true;
-}
-
 #define VHOST_NET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
 
 static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
@@ -699,7 +662,6 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	struct vhost_net *net = container_of(vq->dev, struct vhost_net,
 					     dev);
 	struct socket *sock = vhost_vq_get_backend(vq);
-	struct page_frag *alloc_frag = &net->page_frag;
 	struct virtio_net_hdr *gso;
 	struct xdp_buff *xdp = &nvq->xdp[nvq->batched_xdp];
 	struct tun_xdp_hdr *hdr;
@@ -710,6 +672,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	int sock_hlen = nvq->sock_hlen;
 	void *buf;
 	int copied;
+	int ret;
 
 	if (unlikely(len < nvq->sock_hlen))
 		return -EFAULT;
@@ -719,18 +682,17 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 		return -ENOSPC;
 
 	buflen += SKB_DATA_ALIGN(len + pad);
-	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
-	if (unlikely(!vhost_net_page_frag_refill(net, buflen,
-						 alloc_frag, GFP_KERNEL)))
+	buf = page_frag_alloc_align(&net->pf_cache, buflen, GFP_KERNEL,
+				    SMP_CACHE_BYTES);
+	if (unlikely(!buf))
 		return -ENOMEM;
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-	copied = copy_page_from_iter(alloc_frag->page,
-				     alloc_frag->offset +
-				     offsetof(struct tun_xdp_hdr, gso),
-				     sock_hlen, from);
-	if (copied != sock_hlen)
-		return -EFAULT;
+	copied = copy_from_iter(buf + offsetof(struct tun_xdp_hdr, gso),
+				sock_hlen, from);
+	if (copied != sock_hlen) {
+		ret = -EFAULT;
+		goto err;
+	}
 
 	hdr = buf;
 	gso = &hdr->gso;
@@ -743,27 +705,30 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 			       vhost16_to_cpu(vq, gso->csum_start) +
 			       vhost16_to_cpu(vq, gso->csum_offset) + 2);
 
-		if (vhost16_to_cpu(vq, gso->hdr_len) > len)
-			return -EINVAL;
+		if (vhost16_to_cpu(vq, gso->hdr_len) > len) {
+			ret = -EINVAL;
+			goto err;
+		}
 	}
 
 	len -= sock_hlen;
-	copied = copy_page_from_iter(alloc_frag->page,
-				     alloc_frag->offset + pad,
-				     len, from);
-	if (copied != len)
-		return -EFAULT;
+	copied = copy_from_iter(buf + pad, len, from);
+	if (copied != len) {
+		ret = -EFAULT;
+		goto err;
+	}
 
 	xdp_init_buff(xdp, buflen, NULL);
 	xdp_prepare_buff(xdp, buf, pad, len, true);
 	hdr->buflen = buflen;
 
-	--net->refcnt_bias;
-	alloc_frag->offset += buflen;
-
 	++nvq->batched_xdp;
 
 	return 0;
+
+err:
+	page_frag_free(buf);
+	return ret;
 }
 
 static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
@@ -1353,8 +1318,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 			vqs[VHOST_NET_VQ_RX]);
 
 	f->private_data = n;
-	n->page_frag.page = NULL;
-	n->refcnt_bias = 0;
+	n->pf_cache.va = NULL;
 
 	return 0;
 }
@@ -1422,8 +1386,9 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
 	kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
 	kfree(n->dev.vqs);
-	if (n->page_frag.page)
-		__page_frag_cache_drain(n->page_frag.page, n->refcnt_bias);
+	if (n->pf_cache.va)
+		__page_frag_cache_drain(virt_to_head_page(n->pf_cache.va),
+					n->pf_cache.pagecnt_bias);
 	kvfree(n);
 	return 0;
 }
-- 
2.33.0


