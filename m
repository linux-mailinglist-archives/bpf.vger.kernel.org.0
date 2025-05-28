Return-Path: <bpf+bounces-59072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2271AC5F94
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F61A216AC
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030621CA16;
	Wed, 28 May 2025 02:29:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA901F5402;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399372; cv=none; b=InmqW0g+AQ/CIevGQBvKIKCkHJJWn1RWd82x2gYNYFXBuqbmwU4rer3MdzuTsM1F8XtNPWQmirwgqQ2QNr9Qt0SnzLZeL9MA2qHH9y8Mgeu9IjCn5xS2CQDhQYeqQt/YV/3F41+k6pwSLT4XnS8YAVOC5ksBOWsOEcglBnsNqFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399372; c=relaxed/simple;
	bh=lGq2UipE9ii+VzBIB1OV2LQ7d/+hzx80uOFRSAhCtik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B6Kew11xUlELwhfbaexPs8kkv6zBa5i+PDh6yQ6YA70mj6Z7YlDK8XOyFuyhLieQeveMSIIdsLb9I5lDu7SQoVknp9o2K0l1EhVrBddPj8UhXs4TuC708h1+tJpV7aDqfYAdaEDk+KGtCcXojy45Zz4L0PJMLqIWpNzkM9o1WyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-bd-683675021852
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [PATCH v2 16/16] mt76: use netmem descriptor and APIs for page pool
Date: Wed, 28 May 2025 11:29:11 +0900
Message-Id: <20250528022911.73453-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/e+cnR2Hy8PSOhrdJikJ3krXjzCTHur/kCH4lg829NSWusm8
	NIVgXkic08R8CJ0085K3nCzxUsvykloKyVJZpSmKRuQFnZq6zJzR24fP98fn5UcT4j7Sm1Yo
	0zi1UpYkoYSkcMmtKoCXLpUH62qkYDA1U9C0pYFnM518MDS2I1jf/ioAe/8gBdVVmwQYPuaR
	sGHaIWB+YFYA03ULJFjyOwiYfThEQVGeg4CcznoejLYX86Fsp5aADu2MAD69NFDwrXmPDwu9
	RSS8L28gYbo4EgaMR2BzeBFBv6mDB5v6SgoeWY0UzOVNI7D2zZJQkV2MwNRt44Njy0BFnsZt
	DZ95uKt8SoCN5nT8ot4f62xWApsbCyhsXisV4MkJC4WHHjtI3NVp5+Gi3GUKr85/IfFK9ziF
	TW3jJB4x9guw3XwimrkpDE/gkhQZnDoo4pZQXrO0glJWAzVLr/cEWqT10yFXmmVC2fnvtXwd
	og94yH7DqSnGj7XZtgknezAhrH12kNQhIU0wy3x23uDgOYfDzHX2g60COZlkzrDZ+r0DFjFS
	di5nmPrXP8k2tb4lnH3Xff9uMt6pxUwYu1JoQs4my2wIWIduifh378X21NvIEiQyIpdGJFYo
	M5JliqTQQHmmUqEJjFclm9H+a+vu/47tRGujMb2IoZHETYRbw+RiviwjNTO5F7E0IfEQ5VyW
	ysWiBFlmFqdWxanTk7jUXnSMJiVHRec27yWImTuyNC6R41I49f+VR7t6a1HshPt0y06Qy0XV
	+dKrFaq46jF/fbSr8GlhS+jGGx+rNYpW50sTfJoCItYPbb2y1P2aOitbKbrt5dnXICwoXizQ
	PZi6cPdnT3+U5/M5/amY3LIr2ilL8O6f4/q+ymqNZcSUkuXrrlMlKulLvmz4ribXVPckZ+za
	j3VRSXriXJ5NQqbKZSH+hDpV9hcG4DUc1gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRyHe3fOzo7DyXGJHkwIF6ZYmkban5SSinypkD4VFJVLj224TdlU
	vJDNC0nzVtmH0gkL8zYXExUvYRbTvGRQqJNl3thS/JBT00SdYS7o28PzwO/LjybEDaQ/LVdl
	cGqVVCGhhKQwIaYojJcZLYto3g0BvdlEQctWNjTOd/NBb+xEsLH9XQDrA0MU1L3aJED/pZiE
	3+YdAhYG7QKYa1gkobekiwB75TAF5cUuAgq7m3jQXzvCh6+dFXx4vlNPQJd2XgDjb/UUzJr2
	+LBoKSdhpLqZhLmKOBg0+MLm6E8EA+YuHmyW1VJQNWagwFE8h2Cs305CTUEFAnOfjQ+uLT0V
	J8Edzd94uKd6RoANbZm4vSkU62xjBG4zPqZw269nAjw92Uvh4RcuEvd0r/NweZGTwmsLUyRe
	6bNSuG5plYfNHVYSfzYMCK553xTGJnMKeRanPnE2USh7vbyC0tfCs5ff7Qm0SBusQzTNMqfY
	4fUEHfKgKSaYtdm2CTf7MJHsun2I1CEhTTBOPrugd/Hc4SBzlf1kq0FuJpkgtqBs7x+LmGjW
	UThKuZllDrMtrR8I977Hvv84neTWYiaKXSk1oydIaEAHjMhHrspSSuWKqHBNqixHJc8OT0pT
	tqH99xoe7D7tRhvj8RbE0EjiKcKtUTIxX5qlyVFaEEsTEh9R4blomViULM3J5dRpd9WZCk5j
	QYdoUuInunyDSxQz96UZXCrHpXPq/5VHe/hrUV57WpV13CtzeuJhUHBNxG7KrbywCVeLJz4d
	8dIUaBo1BTqvpNzxTQm4PqDJNxaWRpy8GBh64YjL4shNrW86aju+vBsbMs+cDxU1+pt/aOOr
	YsL+lCRPWtMvzR0T6O/NTs8kmLwDVI5Gv0czU86AzjNL/bcbTe/zW3wn3yi9VislpEYmjQwl
	1BrpX5Rf9Ya5AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to separate its own descriptor from
struct page is required and the work for page pool is on going.

Use netmem descriptor and APIs for page pool in mt76 code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
 .../net/wireless/mediatek/mt76/sdio_txrx.c    | 24 +++++++++----------
 drivers/net/wireless/mediatek/mt76/usb.c      | 10 ++++----
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 35b4ec91979e..cceff435ec4a 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -820,10 +820,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 	int nr_frags = shinfo->nr_frags;
 
 	if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
-		struct page *page = virt_to_head_page(data);
-		int offset = data - page_address(page) + q->buf_offset;
+		netmem_ref netmem = netmem_compound_head(virt_to_netmem(data));
+		int offset = data - netmem_address(netmem) + q->buf_offset;
 
-		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
+		skb_add_rx_frag_netmem(skb, nr_frags, netmem, offset, len, q->buf_size);
 	} else {
 		mt76_put_page_pool_buf(data, allow_direct);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5f8d81cda6cd..f075c1816554 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1795,21 +1795,21 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
 int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q);
 static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
 {
-	struct page *page = virt_to_head_page(buf);
+	netmem_ref netmem = netmem_compound_head(virt_to_netmem(buf));
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, allow_direct);
 }
 
 static inline void *
 mt76_get_page_pool_buf(struct mt76_queue *q, u32 *offset, u32 size)
 {
-	struct page *page;
+	netmem_ref netmem;
 
-	page = page_pool_dev_alloc_frag(q->page_pool, offset, size);
-	if (!page)
+	netmem = page_pool_dev_alloc_netmem(q->page_pool, offset, &size);
+	if (!netmem)
 		return NULL;
 
-	return page_address(page) + *offset;
+	return netmem_address(netmem) + *offset;
 }
 
 static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 0a927a7313a6..8663070191a1 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -68,14 +68,14 @@ mt76s_build_rx_skb(void *data, int data_len, int buf_len)
 
 	skb_put_data(skb, data, len);
 	if (data_len > len) {
-		struct page *page;
+		netmem_ref netmem;
 
 		data += len;
-		page = virt_to_head_page(data);
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				page, data - page_address(page),
-				data_len - len, buf_len);
-		get_page(page);
+		page = netmem_compound_head(virt_to_netmem(data));
+		skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
+				       netmem, data - netmem_address(netmem),
+				       data_len - len, buf_len);
+		get_netmem(netmem);
 	}
 
 	return skb;
@@ -88,7 +88,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	struct mt76_queue *q = &dev->q_rx[qid];
 	struct mt76_sdio *sdio = &dev->sdio;
 	int len = 0, err, i;
-	struct page *page;
+	netmem_ref netmem;
 	u8 *buf, *end;
 
 	for (i = 0; i < intr->rx.num[qid]; i++)
@@ -100,11 +100,11 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	if (len > sdio->func->cur_blksize)
 		len = roundup(len, sdio->func->cur_blksize);
 
-	page = __dev_alloc_pages(GFP_KERNEL, get_order(len));
-	if (!page)
+	netmem = page_to_netmem(__dev_alloc_pages(GFP_KERNEL, get_order(len)));
+	if (!netmem)
 		return -ENOMEM;
 
-	buf = page_address(page);
+	buf = netmem_address(netmem);
 
 	sdio_claim_host(sdio->func);
 	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
@@ -112,7 +112,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 
 	if (err < 0) {
 		dev_err(dev->dev, "sdio read data failed:%d\n", err);
-		put_page(page);
+		put_netmem(netmem);
 		return err;
 	}
 
@@ -140,7 +140,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		}
 		buf += round_up(len + 4, 4);
 	}
-	put_page(page);
+	put_netmem(netmem);
 
 	spin_lock_bh(&q->lock);
 	q->head = (q->head + i) % q->ndesc;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index f9e67b8c3b3c..03f0d35981c9 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -478,7 +478,7 @@ mt76u_build_rx_skb(struct mt76_dev *dev, void *data,
 
 	head_room = drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
 	if (SKB_WITH_OVERHEAD(buf_size) < head_room + len) {
-		struct page *page;
+		netmem_ref netmem;
 
 		/* slow path, not enough space for data and
 		 * skb_shared_info
@@ -489,10 +489,10 @@ mt76u_build_rx_skb(struct mt76_dev *dev, void *data,
 
 		skb_put_data(skb, data + head_room, MT_SKB_HEAD_LEN);
 		data += head_room + MT_SKB_HEAD_LEN;
-		page = virt_to_head_page(data);
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				page, data - page_address(page),
-				len - MT_SKB_HEAD_LEN, buf_size);
+		netmem = netmem_compound_head(virt_to_netmem(data));
+		skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
+				       netmem, data - netmem_address(netmem),
+				       len - MT_SKB_HEAD_LEN, buf_size);
 
 		return skb;
 	}
-- 
2.17.1


