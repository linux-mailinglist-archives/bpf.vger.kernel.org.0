Return-Path: <bpf+bounces-59629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BEACD62F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E982165CEF
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D325C815;
	Wed,  4 Jun 2025 02:53:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C3239E76;
	Wed,  4 Jun 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005595; cv=none; b=WAT9UuyHQdjFZ9ysf4ueYSXHIYD0e9WQ2pGLQPVFTsl8DMvFpTAY2kQJfhp3Anxt4vMyTNDr06YixovT+B9XJxeydw7/y92bi0MwUUFdYF9+bQOY1XXV+ntQCjpbPDrJD9Xsc6IxQXXTmoidFZ3G+lDt5YGJypigBxVhMLnbqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005595; c=relaxed/simple;
	bh=tZsloLl0JEwlcpS7yHBiZsfV8cQCi3VTGJb67s+qCH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SvPRiZN+obsSac+YkO5VBpOaWwjp/Ef5E3rr1jnwKOx0yLoS8ekzcJ4JrHEdmqrz+j2KP4xxpLZgiWeqdcphvg9hDwmxrC3ICcs60ykTZaPUu05dFffekt55O59hBDhvYm8bMidYj4ePiDa7b4cLNQLVP65Q51UZEGUUHEUZfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-65-683fb50ad98e
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
Subject: [RFC v4 17/18] mt76: use netmem descriptor and APIs for page pool
Date: Wed,  4 Jun 2025 11:52:45 +0900
Message-Id: <20250604025246.61616-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/e+cnTOHi8MSO1l5WRdRaKlo/YxSezAOvRSFEvaQQw9teWXq
	cpGwVJKGmlmR6KSZaPPGbHmZJlZqU7PyXis1RZlEeUGn5o3KrXz78P3y/bx8eZiwE3flyRJS
	WHmCJE5E8HH+nFPpUX5DiNT3V/FJ0OhrCKheS4Nnk0YuaKoaESyvj5Jg7ewioKx0FQNNXxYO
	K/oNDCymKRImKmZwaM1uwmDqXjcBuVmbGGQYdRzob8zjwsONcgyaVJMkDLVoCPhW84cLM+25
	OPQUVeIwkRcKJq0LrPbOIujUN3FgNaeEgAeDWgKmsyYQDHZM4VB8Ow+Bvs3Mhc01DRHqydRX
	fuEwzUXjJKM1pDIvdD6M2jyIMYaquwRjWCogmbFPrQTTXbiJM81GK4fJzZwnmEXLV5xZaBsh
	GH39CM6813aSjNXgdoGK5J+KYeNkClZ+LDiKL300r0ZJ0+I0yweuCs0dUSNHHk0F0Jmz/dwd
	Hr8zh9mYoLxos3ndzs6UH22d6sLViM/DqHkubdFscmzFbuocvaV9SdoYpw7TlY09dpGAOk6X
	fraS/6TudHXda7vIcTsfm39s3wqpQDrXOIzZpDS1SNJmS/3/wV76jc6M5yOBFjlUIaEsQREv
	kcUFiKXKBFmaODox3oC2v61I37piREv9l9oRxUMiJ4FxLFgq5EoUycr4dkTzMJGzwN17OxLE
	SJQ3WXniVXlqHJvcjvbxcNEegf/qjRghdU2SwsaybBIr32k5PEdXFQo8H/7OLeiV21MVENLR
	g4XKZcNyS2JDpOlJ32x+X5DoY/qCx/OzP3qtOSFhsfShXs8z90mxduXyW4VThH/TdPjowC5B
	Bxs2UFfgm6+JnlbU1h64laFLcikrF5tKhuTXXXSBKrVX9NZ3dcR+h4unT0T81PREDYuym3/3
	BEo9vMdFeLJU4ueDyZMlfwGFNgbr1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/e9cNpeL05I86YM5TFFoJmr8QDERwZMP0UtEveTIQ1tuUzYd
	TopWWuJqs4t20UkTSd1UJst0XqkpXqgwNGuaN2YTCbVME3WGOaO3D58v3+/Ll4cJ6/FgnkyZ
	x6qUErmI5OP8s4lFJ/ivT0tPfjOFgcnWRELjZgHUzzkIMFnbEKxvfeXCWv8gCbU1GxiYRopx
	+G3bxsAz4ObCbN0CDt0l7Ri4y4ZIMBR7MbjtaOBAX/UwAR/bjASUb7/EoF03x4WxThMJM027
	BCw4DTgMV1pwmDWmwID5CGy8W0LQb2vnwMb9ahIej5pJmC+eRTDa58ah6pYRga3XRYB300Sm
	iJhWywSH6aic5jJmez7zqiGa0btGMcZuLSUZ+69HXGbqczfJDD3z4kyHY43DGIpWSGbVM4kz
	P3rHSaZ28SeHsbWO48x7cz/33KFL/KQsVi7TsKqY5Ey+tGJFj3LnxQWeD4QOLUfokT+PpuLp
	6bvLmI9JKpJ2ubb2OZCKpdfcg7ge8XkYtULQHpOX4wsOUxn0jrmL62OcOk5b2oYJHwuoU3TN
	lzXuv9FQurHlzf6Q/56fWnm63xVSCbTB8Ql7gPhm5GdFgTKlRiGRyRPE6mypVikrEF/JUdjR
	3n11N3YeOtD6WLoTUTwkChA4ppKlQkKiUWsVTkTzMFGgIDRqTwmyJNpCVpVzWZUvZ9VOFMLD
	RUGCjAtsppC6Ksljs1k2l1X9Tzk8/2AdGlmN0zzvabjpvR4dEtwWYi/tbpEXL3jMmoz0tCXF
	k+qYt9265GtTu7pLKUuLrqjUuIGyAqQ9WnpPW2I5GHagc0ZYGF5pVTqNdanNk0EdPcry1vQu
	4bGttMj4M/OxIAotZc+LvvObFRdbJGm7vd4QP3VS4p+ygPCKqgjxxIs7IlwtlcRGYyq15C95
	mtG/ugIAAA==
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
index 5f8d81cda6cd..16d09b6d8270 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1795,21 +1795,21 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
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


