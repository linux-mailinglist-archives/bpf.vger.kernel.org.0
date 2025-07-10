Return-Path: <bpf+bounces-62900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B39AFFC5B
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15018586B15
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20629E0E4;
	Thu, 10 Jul 2025 08:28:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F0B28DF02;
	Thu, 10 Jul 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136113; cv=none; b=Th0RVsbpEc7lO970eBkcCzn0J/lOcS3aF7YoyXMTc28nd1S+83dEZfBJYAh3jZu3VcL7cBLfCzCLWBBrZ7xkUKb3LpnTxJ4zIGIb1AKDpSvUKO2W2JH7jNk1s3y18mQOkzTnX6ngOt0aTb23U5D1D3rn9AbpRXSjYZpLDovQ/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136113; c=relaxed/simple;
	bh=KGvAREPhUrp895kNDrUTdRSaFOyhw7lsB5taMcJAD94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NmG5PtXZQdZaFk4yQrTGVkmkZqQ13N98t8kymXfVOa/zoAmNNLTbhTgvbBem8U9nHxEYMUCqIfbXBHZRbS9bitf5wDnRGA1h1BGhNhvHbfwurFxaro0t1xNTMciaJPd+/QVv5GlHHmuYbG8Win2y/XtNmq9lAtGKSYINhe3O8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-24-686f79a2b94b
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v9 8/8] mt76: use netmem descriptor and APIs for page pool
Date: Thu, 10 Jul 2025 17:28:07 +0900
Message-Id: <20250710082807.27402-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTYRyG+3a+nXNcjY5r1MmMYN1A1O71K6KECL5CIbAgirKRBzea06aZ
	0wotYym5rnTRJbPwNpXptLmsRs2lhoLLspZmyiQh0iJXpi6oLem/h/d9ef55WUr2Gkewam2m
	oNMqNQpagiXj88pj7uvTVGtbroWDyVpHQ+1UNlQNO8RgstgR/JgeYMDv7qDhQfkkBaaeAgw/
	rTMUfGr3MVBrS4ChylEMTwwtFPiudNJQXBCg4On0VwbOO6pF4LEbxXBzpoKClrxhBl63mmj4
	WPdHDKOuYgwvS2owDBnjoN28ECa7xhC4rS0imLx8j4YbvWYaRgqGEPS2+TCU5hsRWJ1eMQSm
	go7SFx+ZuBWkbewbRZpr3ovIo5JBhphtp0hTdRQp8vZSxGYppIlt4jpDPrx9QpPOOwFMHjn8
	IlJ84StNvn/qx+Sbs48m1uY+TLrNbmZf+CHJ9mRBo84SdGt2HJOo+svcKH0kNrvR3CHOQ+Or
	ilAYy3Mb+ef1DeL/7OoqE4WY5lbzXu80FWI5t473+zpwEZKwFFdP8+66ASZULOASeefgQxxi
	zK3k/cMBFGIpt4l/c6UTz0qX8bUNz4Iilg3jNvOOkdxQLAtOAn1F/5w8V8jybb4a0ex+Mf+8
	2ouvIqkZzbEgmVqblapUazbGqvRadXbs8bRUGwpeXXn292EHmvAkuhDHIsU8qSdFq5KJlVkZ
	+lQX4llKIZdOHdSoZNJkpT5H0KUl6U5phAwXWsJixSLp+snTyTIuRZkpnBCEdEH3vxWxYRF5
	6MCt74Z4W0xqXK98R8qXwsjjPfPTydk9MfKsVwZt381fFT9nMocvliw/ssuQk7tN4LZ0G/Ob
	ThieJs2Vb114tCdC8fmuf87iy57RKknp0nxPBP2+9fGGH5Hane/23wu73Wqy50zcccYPIos9
	IToBzpyMtDt3Rzvr9/ovqSJV5xq3K3CGSrkuitJlKP8C6pGvpuYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG++/8d3a2HByW1cECYWiCkam5+EFWUh86BFYgZPShGnlww23K
	pua6gKUQrpxZQaJTVuHyMlstyxlqNafOJCxvmJWueSnKXKnpdHZxRN8e3vfl+fJShOQxDqOU
	mmxOq5GrpKQIiw7tKth2R5+piP1VhsBks5JQ78+Dex4HH0x1TxDML70TwJyri4S7txcIMPUW
	YvhpWyZgstMrgHp7MoxZpjC0XG4iwFviJqG4MEBA69KMAC45anjQXtnNh9dPjHy4uVxNQFO+
	RwD9T00kjFr/8GHKWYyhu7wWw5gxCTrNG2ChZxqBy9bEg4WrlSTc6DOTMF44hqCv3Yuh4qIR
	ga1tmA8B/6qjomNUkBTJtk/7CLax9i2PbS7/IGDN9hz2UU00axjuI1h7XRHJ2mevC9j3Qy0k
	6y4LYLbZMcdjiwtmSPbH5AhmfW2DJHv383cea2scxEckx0WJaZxKmctpt+85JVKMVLlQ1nhM
	3kNzFz8ffdtiQEKKoRMYZ08VL8gkHcUMDy8RQQ6l45g5bxc2IBFF0A0k47K+EwSLdXQK0/bh
	MQ4ypiOZOU8ABVlMy5iBEjf+Jw1n6h88XxVRlJDeyTjGzwVjyeokMGjA15DIjNbUoVClJlct
	V6pkMboMhV6jzIs5nam2o9UzLRdWSh1ovv+AE9EUkoaIX6drFBK+PFenVzsRQxHSULH/mEoh
	EafJ9Wc5beZJbY6K0znRJgpLN4oPpnKnJHS6PJvL4LgsTvu/5VHCsHykuiWbdne8TEAvqpwp
	uZYxLqxfSURbot7Mrt987s+z6f6Js8aQkAZp55d9pdU/Td6tjZH79cYBdezRuvB9PtnvV917
	Pbs/3T89tGFHWmLC4STDYmq8UD3hOpEx2quLL2+5s/g1uai1pJ5cXHteOnglQmb3W86slG36
	GOGs8VnFQinWKeRx0YRWJ/8Lpda2gsgCAAA=
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
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
 .../net/wireless/mediatek/mt76/sdio_txrx.c    | 24 +++++++++----------
 drivers/net/wireless/mediatek/mt76/usb.c      | 10 ++++----
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 35b4ec91979e..41b529b95877 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -820,10 +820,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 	int nr_frags = shinfo->nr_frags;
 
 	if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
-		struct page *page = virt_to_head_page(data);
-		int offset = data - page_address(page) + q->buf_offset;
+		netmem_ref netmem = virt_to_head_netmem(data);
+		int offset = data - netmem_address(netmem) + q->buf_offset;
 
-		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
+		skb_add_rx_frag_netmem(skb, nr_frags, netmem, offset, len, q->buf_size);
 	} else {
 		mt76_put_page_pool_buf(data, allow_direct);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 14927a92f9d1..5fbc15a8cb06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1796,21 +1796,21 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
 int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q);
 static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
 {
-	struct page *page = virt_to_head_page(buf);
+	netmem_ref netmem = virt_to_head_netmem(buf);
 
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
index 0a927a7313a6..b1d89b6f663d 100644
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
+		netmem = virt_to_head_netmem(data);
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
index f9e67b8c3b3c..1ea80c87a839 100644
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
+		netmem = virt_to_head_netmem(data);
+		skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
+				       netmem, data - netmem_address(netmem),
+				       len - MT_SKB_HEAD_LEN, buf_size);
 
 		return skb;
 	}
-- 
2.17.1


