Return-Path: <bpf+bounces-6866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E7676EBFE
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8151C215DB
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368324196;
	Thu,  3 Aug 2023 14:06:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72921D4F
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:06:58 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AFE10D4
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:06:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb8a89b975so6897585ad.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071616; x=1691676416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owtOoOyNNyHXuBh5jsdR6sP92r7iqlMI4HArUfBEUKw=;
        b=Ghs/tD2bqRAzRE4qNjDbjZ2jqi4Aud2qJLVOS1R3Mn88/gE9N324cixR+sHK93osyp
         kISFnDgXvzvcrT9htphzgxZPqyDOOydh3MGFg0+3skcYy7YW0UgwejBFFqHoE510WuH4
         sFCXuh4V1WWmQnAyX2ZkAfhjFe6RKRym9yHoJyr/F9WBTvHWGi5Fk5PcjLbyqUFLQtxt
         /Mb2H98BsMj1+apKPqpzLhPSfVFPZyo8iu6ITI8us/EfGT2OT3+7ELiVbaLkQi8wj9lF
         mMxas9KXjr51l0KO8jbXfO/aY1egn8YB8+1ATEyujoYTK0aj92t+hL/hw7Db5hxZpLTj
         dLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071616; x=1691676416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owtOoOyNNyHXuBh5jsdR6sP92r7iqlMI4HArUfBEUKw=;
        b=hHYH14H4HjAsC9UxFWWEOuaOlVCMIaw8pJzON/qXqGcmXdH7NVfZ7U6OSdUvTQcIJV
         ZN0gXeikFdTw2P3BVopVNJFEzwu9SHob2Jsf0Oxkp64cCuWJaoJ/UMZISWpefFy+hHZ7
         ZA5DOyzxGMFV+5WMGz5XuGhEp+bYd3EFiU54kU98RC22HpG6r2q1aSf4szZdQmr5yQU5
         8e0WvliuFTYrdSDiCnLmKdbJLans9iFInj3SZgBPJu9hiI2A8sUhEmgrCd5h76L5KMY7
         85U4t2yS3TL44AdfwV7SNUrmG67lsMK4yQNaDQ9SD+0TVQPO41xzkiix8y/n8g27OBG8
         guJQ==
X-Gm-Message-State: ABy/qLZAJJSHZC8rF3FryvVBzjon2AWolBZBYLPuhymPDtS7xml61zRh
	MEVM4YCt7eJ/4AXLs5k9/dX1X+a0IO6p385ym+dXYQ==
X-Google-Smtp-Source: APBJJlG+Oba9iEBFPitGDkKbiUy3MmyaJzxquGm84pDzuTntAP0RERF/1d4Tz4lH4qyCZALpDbE4CA==
X-Received: by 2002:a17:902:f686:b0:1bb:673f:36ae with SMTP id l6-20020a170902f68600b001bb673f36aemr19669038plg.15.1691071616012;
        Thu, 03 Aug 2023 07:06:56 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:06:55 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 09/10] veth: support zero copy for af xdp
Date: Thu,  3 Aug 2023 22:04:35 +0800
Message-Id: <20230803140441.53596-10-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following conditions need to be satisfied to achieve zero-copy:
1. The tx desc has enough space to store the xdp_frame and skb_share_info.
2. The memory address pointed to by the tx desc is within a page.

test zero copy with libxdp
Performance:
		     |MSS (bytes) | Packet rate (PPS)
AF_XDP               | 1300       | 480k
AF_XDP with zero copy| 1300       | 540K

signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 207 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 178 insertions(+), 29 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 600225e27e9e..e4f1a8345f42 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -103,6 +103,11 @@ struct veth_xdp_tx_bq {
 	unsigned int count;
 };
 
+struct veth_seg_info {
+	u32 segs;
+	u64 desc[] ____cacheline_aligned_in_smp;
+};
+
 /*
  * ethtool interface
  */
@@ -645,6 +650,100 @@ static int veth_xdp_tx(struct veth_rq *rq, struct xdp_buff *xdp,
 	return 0;
 }
 
+static struct sk_buff *veth_build_skb(void *head, int headroom, int len,
+				      int buflen)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(head, buflen);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, len);
+
+	return skb;
+}
+
+static void veth_xsk_destruct_skb(struct sk_buff *skb)
+{
+	struct veth_seg_info *seg_info = (struct veth_seg_info *)skb_shinfo(skb)->destructor_arg;
+	struct xsk_buff_pool *pool = (struct xsk_buff_pool *)skb_shinfo(skb)->destructor_arg_xsk_pool;
+	unsigned long flags;
+	u32 index = 0;
+	u64 addr;
+
+	/* release cq */
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	for (index = 0; index < seg_info->segs; index++) {
+		addr = (u64)(long)seg_info->desc[index];
+		xsk_tx_completed_addr(pool, addr);
+	}
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
+
+	kfree(seg_info);
+	skb_shinfo(skb)->destructor_arg = NULL;
+	skb_shinfo(skb)->destructor_arg_xsk_pool = NULL;
+}
+
+static struct sk_buff *veth_build_skb_zerocopy(struct net_device *dev, struct xsk_buff_pool *pool,
+					      struct xdp_desc *desc)
+{
+	struct veth_seg_info *seg_info;
+	struct sk_buff *skb;
+	struct page *page;
+	void *hard_start;
+	u32 len, ts;
+	void *buffer;
+	int headroom;
+	u64 addr;
+	u32 index;
+
+	addr = desc->addr;
+	len = desc->len;
+	buffer = xsk_buff_raw_get_data(pool, addr);
+	ts = pool->unaligned ? len : pool->chunk_size;
+
+	headroom = offset_in_page(buffer);
+
+	/* offset in umem pool buffer */
+	addr = buffer - pool->addrs;
+
+	/* get the page of the desc */
+	page = pool->umem->pgs[addr >> PAGE_SHIFT];
+
+	/* in order to avoid to get freed by kfree_skb */
+	get_page(page);
+
+	hard_start = page_to_virt(page);
+
+	skb = veth_build_skb(hard_start, headroom, len, ts);
+	seg_info = (struct veth_seg_info *)kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS), GFP_KERNEL);
+	if (!seg_info)
+	{
+		printk("here must to deal with\n");
+	}
+
+	/* later we will support gso for this */
+	index = skb_shinfo(skb)->gso_segs;
+	seg_info->desc[index] = desc->addr;
+	seg_info->segs = ++index;
+
+	skb->truesize += ts;
+	skb->dev = dev;
+	skb_shinfo(skb)->destructor_arg = (void *)(long)seg_info;
+	skb_shinfo(skb)->destructor_arg_xsk_pool = (void *)(long)pool;
+	skb->destructor = veth_xsk_destruct_skb;
+
+	/* set the mac header */
+	skb->protocol = eth_type_trans(skb, dev);
+
+	/* to do, add skb to sock. may be there is no need to do for this
+	*  refcount_add(ts, &xs->sk.sk_wmem_alloc);
+	*/
+	return skb;
+}
+
 static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 					  struct xdp_frame *frame,
 					  struct veth_xdp_tx_bq *bq,
@@ -1063,6 +1162,20 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
+/*  if buffer contain in a page */
+static inline bool buffer_in_page(void *buffer, u32 len)
+{
+	u32 offset;
+
+	offset = offset_in_page(buffer);
+
+	if(PAGE_SIZE - offset >= len) {
+		return true;
+	} else {
+		return false;
+	}
+}
+
 static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
 {
 	struct veth_priv *priv, *peer_priv;
@@ -1073,6 +1186,9 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 	struct veth_xdp_tx_bq bq;
 	struct xdp_desc desc;
 	void *xdpf;
+	struct sk_buff *skb = NULL;
+	bool zc = xsk_pool->umem->zc;
+	u32 xsk_headroom = xsk_pool->headroom;
 	int done = 0;
 
 	bq.count = 0;
@@ -1102,12 +1218,6 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 			break;
 		}
 
-		/*
-		* Get a xmit addr
-		* desc.addr is a offset, so we should to convert to real virtual address
-		*/
-		addr = xsk_buff_raw_get_data(xsk_pool, desc.addr);
-
 		/* can not hold all data in a page */
 		truesize =  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) + desc.len + sizeof(struct xdp_frame);
 		if (truesize > PAGE_SIZE) {
@@ -1116,16 +1226,39 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 			continue;
 		}
 
-		page = dev_alloc_page();
-		if (!page) {
-			/*
-			* error , release xdp frame and increase drops
-			*/
-			xsk_tx_completed_addr(xsk_pool, desc.addr);
-			stats.xdp_drops++;
-			break;
+		/*
+		* Get a xmit addr
+		* desc.addr is a offset, so we should to convert to real virtual address
+		*/
+		addr = xsk_buff_raw_get_data(xsk_pool, desc.addr);
+
+		/*
+		 * in order to support zero copy, headroom must have enough space to hold xdp_frame
+		 */
+		if (zc && (xsk_headroom < sizeof(struct xdp_frame)))
+			zc = false;
+
+		/*
+		 * if desc not contain in a page, also do not support zero copy
+		*/
+		if (!buffer_in_page(addr, desc.len))
+			zc = false;
+
+		if (zc) {
+			/* headroom is reserved for xdp_frame */
+			new_addr = addr - sizeof(struct xdp_frame);
+		} else {
+			page = dev_alloc_page();
+			if (!page) {
+				/*
+				* error , release xdp frame and increase drops
+				*/
+				xsk_tx_completed_addr(xsk_pool, desc.addr);
+				stats.xdp_drops++;
+				break;
+			}
+			new_addr = page_to_virt(page);
 		}
-		new_addr = page_to_virt(page);
 
 		p_frame = new_addr;
 		new_addr += sizeof(struct xdp_frame);
@@ -1137,19 +1270,37 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 		 */
 		p_frame->headroom = 0;
 		p_frame->metasize = 0;
-		p_frame->frame_sz = PAGE_SIZE;
 		p_frame->flags = 0;
-		p_frame->mem.type = MEM_TYPE_PAGE_SHARED;
-		memcpy(p_frame->data, addr, p_frame->len);
-		xsk_tx_completed_addr(xsk_pool, desc.addr);
-
-		/* if peer have xdp prog, if it has ,just send to peer */
-		p_frame = veth_xdp_rcv_one(peer_rq, p_frame, &bq, &peer_stats);
-		/* if no xdp with this queue, convert to skb to xmit*/
-		if (p_frame) {
-			xdpf = p_frame;
-			veth_xdp_rcv_bulk_skb(peer_rq, &xdpf, 1, &bq, &peer_stats);
-			p_frame = NULL;
+
+		if (zc) {
+			p_frame->frame_sz = xsk_pool->frame_len;
+			/* to do: if there is a xdp, how to recycle the tx desc */
+			p_frame->mem.type = MEM_TYPE_XSK_BUFF_POOL_TX;
+			/* no need to copy address for af+xdp */
+			p_frame = veth_xdp_rcv_one(peer_rq, p_frame, &bq, &peer_stats);
+			if (p_frame) {
+				skb = veth_build_skb_zerocopy(peer_dev, xsk_pool, &desc);
+				if (skb) {
+					napi_gro_receive(&peer_rq->xdp_napi, skb);
+					skb = NULL;
+				} else {
+					xsk_tx_completed_addr(xsk_pool, desc.addr);
+				}
+			}
+		} else {
+			p_frame->frame_sz = PAGE_SIZE;
+			p_frame->mem.type = MEM_TYPE_PAGE_SHARED;
+			memcpy(p_frame->data, addr, p_frame->len);
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+
+			/* if peer have xdp prog, if it has ,just send to peer */
+			p_frame = veth_xdp_rcv_one(peer_rq, p_frame, &bq, &peer_stats);
+			/* if no xdp with this queue, convert to skb to xmit*/
+			if (p_frame) {
+				xdpf = p_frame;
+				veth_xdp_rcv_bulk_skb(peer_rq, &xdpf, 1, &bq, &peer_stats);
+				p_frame = NULL;
+			}
 		}
 
 		stats.xdp_bytes += desc.len;
@@ -1163,8 +1314,6 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 		xsk_tx_release(xsk_pool);
 	}
 
-
-
 	/* just for peer rq */
 	if (peer_stats.xdp_tx > 0)
 		veth_xdp_flush(peer_rq, &bq);
-- 
2.20.1


