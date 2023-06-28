Return-Path: <bpf+bounces-3634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A90E7408CA
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C11E1C20B3E
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0635243;
	Wed, 28 Jun 2023 03:05:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2464C92;
	Wed, 28 Jun 2023 03:05:17 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812F91984;
	Tue, 27 Jun 2023 20:05:13 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm7vFYF_1687921508;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vm7vFYF_1687921508)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 11:05:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v4 2/2] virtio-net: remove GUEST_CSUM check for XDP
Date: Wed, 28 Jun 2023 11:05:06 +0800
Message-Id: <20230628030506.2213-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230628030506.2213-1-hengqi@linux.alibaba.com>
References: <20230628030506.2213-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

XDP and GUEST_CSUM no longer conflict now, so we remove the
check for GUEST_CSUM for XDP loading/unloading.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v3->v4:
  - 'removed' -> 'remove'

v1->v2:
  - Rewrite the commit log.

 drivers/net/virtio_net.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a47342f972b5..bd387f3c5d35 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -60,7 +60,6 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
 	VIRTIO_NET_F_GUEST_UFO,
-	VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GUEST_USO4,
 	VIRTIO_NET_F_GUEST_USO6,
 	VIRTIO_NET_F_GUEST_HDRLEN
@@ -3433,10 +3432,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
-		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
-		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
+		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW, disable GRO_HW first");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.19.1.6.gb485710b


