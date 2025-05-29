Return-Path: <bpf+bounces-59254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170ADAC7657
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217B3A42F3E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9925DCF9;
	Thu, 29 May 2025 03:11:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69A253B59;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488275; cv=none; b=IB8YWyOIWTXHfhIE72WExxz6Z4Mn0TI76B4c5xBBmm6/UoaqG1TyOjkmX9RWdFZ75Clrahp6/hOi2lkBouMG9+LD6bUjDn2/+vhdrKKBfVIrrXI0Pcge7PxRnGxMm38R9Wp+REQJ/GtZ7J1vHkYnFn0oJo6LDclH3EG/zxM9q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488275; c=relaxed/simple;
	bh=tZsloLl0JEwlcpS7yHBiZsfV8cQCi3VTGJb67s+qCH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q3ZrEeNGwsAY/q8xckdGcrtUsBWpai8hJUe2zCVlw0RSpne7I52mX7mVaOF0QPx6pBCwxQu2S70aqrunpuC/evv553wbcyzJl66Z7ZpE46eHEyWpqge4LulqCsk2adU+Erb+m926kY+yd5cUxrrDirH6BJse0vxZY0hRPbHwn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-71-6837d042c18c
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
Subject: [RFC v3 17/18] mt76: use netmem descriptor and APIs for page pool
Date: Thu, 29 May 2025 12:10:46 +0900
Message-Id: <20250529031047.7587-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRTH/e3e3T1ydF2iN4uigUWGmmZ6wFKhiEt/ZPaAMMOG3tryyeZM
	i2hOwVq6QlPKZsyi+azFFJ0hknP4oIc2s2YvbTYlSEuXS51RuvK/D99zzuccOFxMaMEDuNLM
	HEaWKU4XEXycP+VdE7xvMEqyc6iZAK2hiYDG+TyoHTOxQdvQiuDnwnsOOC29BNyvcWGgHSjC
	Yc6wiIGjx86BUf0EDh3FbRjYr/cRUFrkxkBlqmPBYKuGDTcXH2DQphzjwNATLQGfmv6wYcJc
	ikN/VT0Oo5o46NH5gevZNwQWQxsLXCXVBJRbdQSMF40isHbbcbhToEFg6LSxwT2vJeK20C31
	Iyy6veojh9YZFXRzXRCttlkx2thwlaCNs2Uc+sObDoLuu+XG6XaTk0WXFk4T9IzjHU5/7xwm
	aEPLME4/11k4tNO46TCZyN+TyqRLcxlZaMxpvqRiWo2yx0PyHC/YSjS1VY14XIqMoPr0S6xV
	/mFuwVeYILdRNtsCtsK+ZBjltPcu53wuRk6zKYfW7RlYRx6kClsGPIyTgdRXVSFaYQG5m6oo
	0OH/pJupxsdPPSLecl7ZXOnpFy4vu63uIlakFDnDoYw9v/9fsZ7qqrPhN5BAh7wakFCamZsh
	lqZHhEjyM6V5ISlZGUa0/Fv9paWTJjQ7eNSMSC4SeQv6UJREyBbnyvMzzIjiYiJfgSo2UiIU
	pIrzLzCyrGSZIp2Rm9EGLi7yF4S7zqcKybPiHCaNYbIZ2WqVxeUFKNEOhYV1LeHYxobi+Nd+
	ZCDPFWqdNeQkJe8d+9L9UN6NnYm86HuZn9KUsCYJtfe+/byrvdo1/Cc+0L1waPJKkf/LOdXa
	SZ97uv3liaoj5HaJQi0+oI15ZSz1UpbxwtNihXrzo5Hg8uieuNSSU+GoKuxcv9nn+N3oil9Y
	7QlNHMskwuUScVgQJpOL/wKgLIMr1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF++3e3c3V6DpNLwZJgzSkfICPLyhm/tNVKKp/irBy6KUN57Rt
	mgbW1EG08pUpZjMWkm+azaFTRHIuH5Uo08nK1DWZKJhaM/EFtRn99+Gcwzl/HC4maMaDuBKZ
	kpHLRFIhwcN5l+JLzyZPxokjO1WxoNV3ENC+XQDNDhMbtG3dCDZ3ZjngtowQ0Ph6CwPthBqH
	3/pdDFzDTg4sNC3h0P+oBwNnxSgBZeo9DEpMLSwYahhjw2R3ORue777BoEfl4MBUn5aA+Y4/
	bFgyl+EwVt+Kw0J5EgzrAmDr0yoCi76HBVtPGwiotuoIWFQvILAOOXF4WVyOQD9gZ8PetpZI
	EtLG1i8surd+jkPrDHl0V0sYrbFbMdrQ9pigDb+ecehvM/0EPVq3h9O9JjeLLitdI+ifrq84
	vT5gI+jG5Q0WrTfacPqzzsK57HuDl5DJSCX5jDwiMZ0nrlnToNzF8ALXOFuFfoRokA+XIqOp
	DbMR9zJBhlJ2+w7mZX8yinI7Rzw6j4uRa2zKpd1jeQ0/MpUqNU4cME6eolZKSpGX+WQMVVOs
	w/+VBlPtne8Pinw8em1X7UFe4Bl7oRkkKhFPhw61IX+JLD9bJJHGhCuyxIUySUF4Rk62AXnu
	ayrarzKhzakLZkRykfAIfxTFiQVsUb6iMNuMKC4m9OeXnIsVC/iZosL7jDzntjxPyijM6DgX
	FwbyU68x6QLyjkjJZDFMLiP/77K4PkEqdGXkQcH3+ZnRjJu24lcp6tDh6g/Ls4HzdX6J+pND
	V+XLuUu2nBBbBF8fnPSwpRLSK2650rSiYN/kwWPW7jOOjCq3Yj3trbLqXd50uzZypmh8MNmS
	t3s46klAvHRF13c38PTcquvjNOvefnjVxeiaYF+lOCF1eSfzvOz6UceJjRQhrhCLosIwuUL0
	F4/aMci6AgAA
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


