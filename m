Return-Path: <bpf+bounces-12280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB17CA7B1
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8221C20864
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E628E24;
	Mon, 16 Oct 2023 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C228DD1;
	Mon, 16 Oct 2023 12:01:02 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971F8E;
	Mon, 16 Oct 2023 05:00:57 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuINq5E_1697457653;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuINq5E_1697457653)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 20:00:54 +0800
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
Subject: [PATCH net-next v1 17/19] virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
Date: Mon, 16 Oct 2023 20:00:31 +0800
Message-Id: <20231016120033.26933-18-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 9790cc452aab
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since this will be called in other circumstances(freeze), we must check
whether it is xsk's buffer in this function. It cannot be judged outside
this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 003dd67ab707..ac62d0955c13 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -3904,8 +3904,21 @@ void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
+	struct xsk_buff_pool *pool;
 	int i = vq2rxq(vq);
 
+	rcu_read_lock();
+	pool = rcu_dereference(vi->rq[i].xsk.pool);
+	if (pool) {
+		struct xdp_buff *xdp;
+
+		xdp = (struct xdp_buff *)buf;
+		xsk_buff_free(xdp);
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
 	if (vi->mergeable_rx_bufs)
 		put_page(virt_to_head_page(buf));
 	else if (vi->big_packets)
-- 
2.32.0.3.g01195cf9f


