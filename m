Return-Path: <bpf+bounces-3729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5AF74255B
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5D0280E05
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B7414286;
	Thu, 29 Jun 2023 12:05:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E9D51C;
	Thu, 29 Jun 2023 12:05:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356B3AAC;
	Thu, 29 Jun 2023 05:05:11 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QsHC26D4kzLnP3;
	Thu, 29 Jun 2023 20:02:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 20:04:56 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Alexander
 Duyck <alexander.duyck@gmail.com>, Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
	<edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>
Subject: [PATCH v5 RFC 6/6] net: veth: use newly added page pool API for veth with xdp
Date: Thu, 29 Jun 2023 20:02:26 +0800
Message-ID: <20230629120226.14854-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230629120226.14854-1-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use page_pool[_cache]_alloc() API to allocate memory with
least memory utilization and performance penalty.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/veth.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..d3dc754ba7f8 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -736,10 +736,11 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
 	    skb_shinfo(skb)->nr_frags ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		u32 size, len, max_head_size, off;
+		u32 size, len, max_head_size, off, truesize, page_offset;
 		struct sk_buff *nskb;
 		struct page *page;
 		int i, head_off;
+		void *data;
 
 		/* We need a private copy of the skb and data buffers since
 		 * the ebpf program can modify it. We segment the original skb
@@ -752,14 +753,17 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 		if (skb->len > PAGE_SIZE * MAX_SKB_FRAGS + max_head_size)
 			goto drop;
 
+		size = min_t(u32, skb->len, max_head_size);
+		truesize = size;
+
 		/* Allocate skb head */
-		page = page_pool_dev_alloc_pages(rq->page_pool);
-		if (!page)
+		data = page_pool_dev_cache_alloc(rq->page_pool, &truesize);
+		if (!data)
 			goto drop;
 
-		nskb = napi_build_skb(page_address(page), PAGE_SIZE);
+		nskb = napi_build_skb(data, truesize);
 		if (!nskb) {
-			page_pool_put_full_page(rq->page_pool, page, true);
+			page_pool_cache_free(rq->page_pool, data, true);
 			goto drop;
 		}
 
@@ -767,7 +771,6 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 		skb_copy_header(nskb, skb);
 		skb_mark_for_recycle(nskb);
 
-		size = min_t(u32, skb->len, max_head_size);
 		if (skb_copy_bits(skb, 0, nskb->data, size)) {
 			consume_skb(nskb);
 			goto drop;
@@ -782,14 +785,17 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 		len = skb->len - off;
 
 		for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
-			page = page_pool_dev_alloc_pages(rq->page_pool);
+			size = min_t(u32, len, PAGE_SIZE);
+			truesize = size;
+
+			page = page_pool_dev_alloc(rq->page_pool, &page_offset,
+						   &truesize);
 			if (!page) {
 				consume_skb(nskb);
 				goto drop;
 			}
 
-			size = min_t(u32, len, PAGE_SIZE);
-			skb_add_rx_frag(nskb, i, page, 0, size, PAGE_SIZE);
+			skb_add_rx_frag(nskb, i, page, page_offset, size, truesize);
 			if (skb_copy_bits(skb, off, page_address(page),
 					  size)) {
 				consume_skb(nskb);
-- 
2.33.0


