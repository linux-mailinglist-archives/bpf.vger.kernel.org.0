Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61862558DC0
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 04:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiFXC4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 22:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiFXC4p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 22:56:45 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8F95DF03;
        Thu, 23 Jun 2022 19:56:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0VHEuVuB_1656039397;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VHEuVuB_1656039397)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 10:56:38 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        kangjie.xu@linux.alibaba.com
Subject: [PATCH v10 07/41] virtio_ring: split vring_virtqueue
Date:   Fri, 24 Jun 2022 10:55:47 +0800
Message-Id: <20220624025621.128843-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: fef800c86cd2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Separate the two inline structures(split and packed) from the structure
vring_virtqueue.

In this way, we can use these two structures later to pass parameters
and retain temporary variables.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 122 ++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9338c01df1bf..973892606144 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -85,6 +85,67 @@ struct vring_desc_extra {
 	u16 next;			/* The next desc state in a list. */
 };
 
+struct vring_virtqueue_split {
+	/* Actual memory layout for this queue. */
+	struct vring vring;
+
+	/* Last written value to avail->flags */
+	u16 avail_flags_shadow;
+
+	/*
+	 * Last written value to avail->idx in
+	 * guest byte order.
+	 */
+	u16 avail_idx_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_split *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t queue_dma_addr;
+	size_t queue_size_in_bytes;
+};
+
+struct vring_virtqueue_packed {
+	/* Actual memory layout for this queue. */
+	struct {
+		unsigned int num;
+		struct vring_packed_desc *desc;
+		struct vring_packed_desc_event *driver;
+		struct vring_packed_desc_event *device;
+	} vring;
+
+	/* Driver ring wrap counter. */
+	bool avail_wrap_counter;
+
+	/* Device ring wrap counter. */
+	bool used_wrap_counter;
+
+	/* Avail used flags. */
+	u16 avail_used_flags;
+
+	/* Index of the next avail descriptor. */
+	u16 next_avail_idx;
+
+	/*
+	 * Last written value to driver->flags in
+	 * guest byte order.
+	 */
+	u16 event_flags_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_packed *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t ring_dma_addr;
+	dma_addr_t driver_event_dma_addr;
+	dma_addr_t device_event_dma_addr;
+	size_t ring_size_in_bytes;
+	size_t event_size_in_bytes;
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -119,67 +180,10 @@ struct vring_virtqueue {
 
 	union {
 		/* Available for split ring */
-		struct {
-			/* Actual memory layout for this queue. */
-			struct vring vring;
-
-			/* Last written value to avail->flags */
-			u16 avail_flags_shadow;
-
-			/*
-			 * Last written value to avail->idx in
-			 * guest byte order.
-			 */
-			u16 avail_idx_shadow;
-
-			/* Per-descriptor state. */
-			struct vring_desc_state_split *desc_state;
-			struct vring_desc_extra *desc_extra;
-
-			/* DMA address and size information */
-			dma_addr_t queue_dma_addr;
-			size_t queue_size_in_bytes;
-		} split;
+		struct vring_virtqueue_split split;
 
 		/* Available for packed ring */
-		struct {
-			/* Actual memory layout for this queue. */
-			struct {
-				unsigned int num;
-				struct vring_packed_desc *desc;
-				struct vring_packed_desc_event *driver;
-				struct vring_packed_desc_event *device;
-			} vring;
-
-			/* Driver ring wrap counter. */
-			bool avail_wrap_counter;
-
-			/* Device ring wrap counter. */
-			bool used_wrap_counter;
-
-			/* Avail used flags. */
-			u16 avail_used_flags;
-
-			/* Index of the next avail descriptor. */
-			u16 next_avail_idx;
-
-			/*
-			 * Last written value to driver->flags in
-			 * guest byte order.
-			 */
-			u16 event_flags_shadow;
-
-			/* Per-descriptor state. */
-			struct vring_desc_state_packed *desc_state;
-			struct vring_desc_extra *desc_extra;
-
-			/* DMA address and size information */
-			dma_addr_t ring_dma_addr;
-			dma_addr_t driver_event_dma_addr;
-			dma_addr_t device_event_dma_addr;
-			size_t ring_size_in_bytes;
-			size_t event_size_in_bytes;
-		} packed;
+		struct vring_virtqueue_packed packed;
 	};
 
 	/* How to notify other side. FIXME: commonalize hcalls! */
-- 
2.31.0

