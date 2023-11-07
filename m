Return-Path: <bpf+bounces-14369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E707E3405
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7F6280F93
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 03:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00D12E72;
	Tue,  7 Nov 2023 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B27476;
	Tue,  7 Nov 2023 03:12:59 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69459D6E;
	Mon,  6 Nov 2023 19:12:55 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvsNijc_1699326769;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VvsNijc_1699326769)
          by smtp.aliyun-inc.com;
          Tue, 07 Nov 2023 11:12:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 19/21] virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
Date: Tue,  7 Nov 2023 11:12:25 +0800
Message-Id: <20231107031227.100015-20-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 59a160d210e8
Content-Transfer-Encoding: 8bit

Since this will be called in other circumstances(freeze), we must check
whether it is xsk's buffer in this function. It cannot be judged outside
this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 095f4acb0577..42c7dbf53e63 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -3948,6 +3948,14 @@ void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
+	if (rq->xsk.pool) {
+		struct xdp_buff *xdp;
+
+		xdp = (struct xdp_buff *)buf;
+		xsk_buff_free(xdp);
+		return;
+	}
+
 	if (rq->do_dma_unmap)
 		virtnet_rq_unmap(rq, buf, 0);
 
-- 
2.32.0.3.g01195cf9f


