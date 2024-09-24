Return-Path: <bpf+bounces-40218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8070983ACA
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238AF1C227DB
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545248BFF;
	Tue, 24 Sep 2024 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lPbDA93v"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAE8C06;
	Tue, 24 Sep 2024 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141535; cv=none; b=EG4yAm2X1ekPGrdyQu4tJEyP49F8HPIX382pzbZQkdKmqxU5o4ThA8zS2jxHKRUXNlwKjNDNhbSvraB2HvYNWeNUwh4mCLqvKBgWBokGyDXtNrJ4mMse1b9hEQV2pw37tBpV6quWaEup4s+zWwuy3VMyzDViKnQhI8iJDnXcBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141535; c=relaxed/simple;
	bh=29C6WbemHO/IUo0X/xF2BepT7iQI1w13+Rp8ycWp/OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auCKBLUc91DNXhZmrEnAZypBBgnrUQCs8OwtSRE6tt7E7vfDtR/n0qwXBfiMcwog8EeVMnNKVKTM8GhUfTwvlfbPEePRbVTuraY1PVjHZc0q/3OPKg90Z6FO5zR7AcpAA6zd4RObRYTxNqREZrgu7ViKkkth4/EWL95J/Hd2pBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lPbDA93v; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727141530; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bIPCybpAiLH86Az7VN7vanBKwfxsdDKfSfylgUGk9hs=;
	b=lPbDA93vjJ3UKhjiqWTUJzTmCqdO6ySYArSI/y/W5A+ASZBAofSdvz0j4Hp9YHsRrycHgJqw0zRR33cPtnEL7RoWB6oGA/iT2Lqv3DLM4Ru3US6EFciqiYK7AriPmaphHKc88i338N4MlLpZEFAa+WW5mJmdnDoedS4fVhT0MmM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFe1FhN_1727141529)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 09:32:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC net-next v1 05/12] virtio-net: rq submits premapped per-buffer
Date: Tue, 24 Sep 2024 09:31:57 +0800
Message-Id: <20240924013204.13763-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 83bb687d4b73
Content-Transfer-Encoding: 8bit

virtio-net rq submits premapped per-buffer by setting sg page to NULL;

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f4781ec2b36..630e5b21ad69 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -542,6 +542,13 @@ static struct sk_buff *ptr_to_skb(void *ptr)
 	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
 }
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg_assign_page(sg, NULL);
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
 static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			    bool in_napi, struct virtnet_sq_free_stats *stats)
 {
@@ -915,8 +922,7 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	addr = dma->addr - sizeof(*dma) + offset;
 
 	sg_init_table(rq->sg, 1);
-	rq->sg[0].dma_address = addr;
-	rq->sg[0].length = len;
+	sg_fill_dma(&rq->sg[0], addr, len);
 }
 
 static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
@@ -1068,12 +1074,6 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
-static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
-{
-	sg->dma_address = addr;
-	sg->length = len;
-}
-
 static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 				   struct receive_queue *rq, void *buf, u32 len)
 {
-- 
2.32.0.3.g01195cf9f


