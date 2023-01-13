Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B28668FEC
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 09:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbjAMICm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 03:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjAMIBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 03:01:22 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229BC6D51C;
        Fri, 13 Jan 2023 00:00:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VZTope9_1673596824;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VZTope9_1673596824)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 16:00:24 +0800
From:   Heng Qi <hengqi@linux.alibaba.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v4 08/10] virtio-net: build skb from multi-buffer xdp
Date:   Fri, 13 Jan 2023 16:00:14 +0800
Message-Id: <20230113080016.45505-9-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230113080016.45505-1-hengqi@linux.alibaba.com>
References: <20230113080016.45505-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This converts the xdp_buff directly to a skb, including
multi-buffer and single buffer xdp. We'll isolate the
construction of skb based on xdp from page_to_skb().

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fee9ce31f6c7..87d65b7a5033 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -952,6 +952,55 @@ static struct sk_buff *receive_big(struct net_device *dev,
 	return NULL;
 }
 
+/* Why not use xdp_build_skb_from_frame() ?
+ * XDP core assumes that xdp frags are PAGE_SIZE in length, while in
+ * virtio-net there are 2 points that do not match its requirements:
+ *  1. The size of the prefilled buffer is not fixed before xdp is set.
+ *  2. xdp_build_skb_from_frame() does more checks that we don't need,
+ *     like eth_type_trans() (which virtio-net does in receive_buf()).
+ */
+static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
+					       struct virtnet_info *vi,
+					       struct xdp_buff *xdp,
+					       unsigned int xdp_frags_truesz)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	unsigned int headroom, data_len;
+	struct sk_buff *skb;
+	int metasize;
+	u8 nr_frags;
+
+	if (unlikely(xdp->data_end > xdp_data_hard_end(xdp))) {
+		pr_debug("Error building skb as missing reserved tailroom for xdp");
+		return NULL;
+	}
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		nr_frags = sinfo->nr_frags;
+
+	skb = build_skb(xdp->data_hard_start, xdp->frame_sz);
+	if (unlikely(!skb))
+		return NULL;
+
+	headroom = xdp->data - xdp->data_hard_start;
+	data_len = xdp->data_end - xdp->data;
+	skb_reserve(skb, headroom);
+	__skb_put(skb, data_len);
+
+	metasize = xdp->data - xdp->data_meta;
+	metasize = metasize > 0 ? metasize : 0;
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		xdp_update_skb_shared_info(skb, nr_frags,
+					   sinfo->xdp_frags_size,
+					   xdp_frags_truesz,
+					   xdp_buff_is_frag_pfmemalloc(xdp));
+
+	return skb;
+}
+
 /* TODO: build xdp in big mode */
 static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				      struct virtnet_info *vi,
-- 
2.19.1.6.gb485710b

