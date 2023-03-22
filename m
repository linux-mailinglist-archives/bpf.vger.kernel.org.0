Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31B6C40B6
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 04:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCVDDZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 23:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCVDDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 23:03:20 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4B15C99;
        Tue, 21 Mar 2023 20:03:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VeOqVjh_1679454194;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VeOqVjh_1679454194)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 11:03:15 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH net-next 6/8] virtio_net: auto release xdp shinfo
Date:   Wed, 22 Mar 2023 11:03:06 +0800
Message-Id: <20230322030308.16046-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 7e9e1372f356
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

virtnet_build_xdp_buff_mrg() and virtnet_xdp_handler() auto
release xdp shinfo then the caller no need to careful the xdp shinfo.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a3f2bcb3db27..136131a7868a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -833,14 +833,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		stats->xdp_tx++;
 		xdpf = xdp_convert_buff_to_frame(xdp);
 		if (unlikely(!xdpf))
-			return VIRTNET_XDP_RES_DROP;
+			goto drop;
 
 		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
 		if (unlikely(!err)) {
 			xdp_return_frame_rx_napi(xdpf);
 		} else if (unlikely(err < 0)) {
 			trace_xdp_exception(dev, xdp_prog, act);
-			return VIRTNET_XDP_RES_DROP;
+			goto drop;
 		}
 
 		*xdp_xmit |= VIRTIO_XDP_TX;
@@ -850,7 +850,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		stats->xdp_redirects++;
 		err = xdp_do_redirect(dev, xdp, xdp_prog);
 		if (err)
-			return VIRTNET_XDP_RES_DROP;
+			goto drop;
 
 		*xdp_xmit |= VIRTIO_XDP_REDIR;
 		return VIRTNET_XDP_RES_CONSUMED;
@@ -862,8 +862,12 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		trace_xdp_exception(dev, xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
-		return VIRTNET_XDP_RES_DROP;
+		goto drop;
 	}
+
+drop:
+	put_xdp_frags(xdp);
+	return VIRTNET_XDP_RES_DROP;
 }
 
 static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
@@ -1199,7 +1203,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				 dev->name, *num_buf,
 				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
 			dev->stats.rx_length_errors++;
-			return -EINVAL;
+			goto err;
 		}
 
 		stats->bytes += len;
@@ -1218,7 +1222,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
 			dev->stats.rx_length_errors++;
-			return -EINVAL;
+			goto err;
 		}
 
 		frag = &shinfo->frags[shinfo->nr_frags++];
@@ -1233,6 +1237,10 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 
 	*xdp_frags_truesize = xdp_frags_truesz;
 	return 0;
+
+err:
+	put_xdp_frags(xdp);
+	return -EINVAL;
 }
 
 static void *mergeable_xdp_prepare(struct virtnet_info *vi,
@@ -1361,7 +1369,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
 						 &num_buf, &xdp_frags_truesz, stats);
 		if (unlikely(err))
-			goto err_xdp_frags;
+			goto err_xdp;
 
 		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
 
@@ -1369,7 +1377,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		case VIRTNET_XDP_RES_PASS:
 			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 			if (unlikely(!head_skb))
-				goto err_xdp_frags;
+				goto err_xdp;
 
 			rcu_read_unlock();
 			return head_skb;
@@ -1379,11 +1387,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto xdp_xmit;
 
 		case VIRTNET_XDP_RES_DROP:
-			goto err_xdp_frags;
+			goto err_xdp;
 		}
-err_xdp_frags:
-		put_xdp_frags(&xdp);
-		goto err_xdp;
 	}
 	rcu_read_unlock();
 
-- 
2.32.0.3.g01195cf9f

