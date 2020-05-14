Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8F1D2D67
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgENKvA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 06:51:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgENKu7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 06:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589453457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P35P1tB2Ow397ehqgn4RyF1fDnfw1KPzt3vs7aSB/Xo=;
        b=K48mMCirGAlrqlGQTeZpIQh+3a5F/EZwO6p3Pz7ieTgrXm6UBbFUkQpWfgVioSAZnFNNmB
        1EZztxTNMFELUH+pOQy2zl4JDylHwhFlWgTT2REE1+mtKaa8acOSClZ211aTv0snsQBfKu
        4QuLA7GGC21ctCpHjxodGH0l3/JUwlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-FVrpKdT2MZuBUxyXYPEWnw-1; Thu, 14 May 2020 06:50:53 -0400
X-MC-Unique: FVrpKdT2MZuBUxyXYPEWnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACFA48014D7;
        Thu, 14 May 2020 10:50:51 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 764396E718;
        Thu, 14 May 2020 10:50:45 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 6D27A300020FC;
        Thu, 14 May 2020 12:50:44 +0200 (CEST)
Subject: [PATCH net-next v4 21/33] virtio_net: add XDP frame size in two code
 paths
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Date:   Thu, 14 May 2020 12:50:44 +0200
Message-ID: <158945344436.97035.9445115070189151680.stgit@firesoul>
In-Reply-To: <158945314698.97035.5286827951225578467.stgit@firesoul>
References: <158945314698.97035.5286827951225578467.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The virtio_net driver is running inside the guest-OS. There are two
XDP receive code-paths in virtio_net, namely receive_small() and
receive_mergeable(). The receive_big() function does not support XDP.

In receive_small() the frame size is available in buflen. The buffer
backing these frames are allocated in add_recvbuf_small() with same
size, except for the headroom, but tailroom have reserved room for
skb_shared_info. The headroom is encoded in ctx pointer as a value.

In receive_mergeable() the frame size is more dynamic. There are two
basic cases: (1) buffer size is based on a exponentially weighted
moving average (see DECLARE_EWMA) of packet length. Or (2) in case
virtnet_get_headroom() have any headroom then buffer size is
PAGE_SIZE. The ctx pointer is this time used for encoding two values;
the buffer len "truesize" and headroom. In case (1) if the rx buffer
size is underestimated, the packet will have been split over more
buffers (num_buf info in virtio_net_hdr_mrg_rxbuf placed in top of
buffer area). If that happens the XDP path does a xdp_linearize_page
operation.

V3: Adjust frame_sz in receive_mergeable() case, spotted by Jason Wang.

The code is really hard to follow, so some hints to reviewers.
The receive_mergeable() case gets frames that were allocated in
add_recvbuf_mergeable() which uses headroom=virtnet_get_headroom(),
and 'buf' ptr is advanced this headroom.  The headroom can only
be 0 or VIRTIO_XDP_HEADROOM, as virtnet_get_headroom is really
simple:

  static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  {
	return vi->xdp_queue_pairs ? VIRTIO_XDP_HEADROOM : 0;
  }

As frame_sz is an offset size from xdp.data_hard_start, reviewers
should notice how this is calculated in receive_mergeable():

  int offset = buf - page_address(page);
  [...]
  data = page_address(xdp_page) + offset;
  xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM + vi->hdr_len;

The calculated offset will always be VIRTIO_XDP_HEADROOM when
reaching this code.  Thus, xdp.data_hard_start will be page-start
address plus vi->hdr_len.  Given this xdp.frame_sz need to be
reduced with vi->hdr_len size.

IMHO a followup patch should cleanup this code to make it easier
to maintain and understand, but it is outside the scope of this
patchset.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 11f722460513..9e1b5d748586 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -689,6 +689,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		xdp.data_end = xdp.data + len;
 		xdp.data_meta = xdp.data;
 		xdp.rxq = &rq->xdp_rxq;
+		xdp.frame_sz = buflen;
 		orig_data = xdp.data;
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		stats->xdp_packets++;
@@ -797,10 +798,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	int offset = buf - page_address(page);
 	struct sk_buff *head_skb, *curr_skb;
 	struct bpf_prog *xdp_prog;
-	unsigned int truesize;
+	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
-	int err;
 	unsigned int metasize = 0;
+	unsigned int frame_sz;
+	int err;
 
 	head_skb = NULL;
 	stats->bytes += len - vi->hdr_len;
@@ -821,6 +823,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		if (unlikely(hdr->hdr.gso_type))
 			goto err_xdp;
 
+		/* Buffers with headroom use PAGE_SIZE as alloc size,
+		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
+		 */
+		frame_sz = headroom ? PAGE_SIZE : truesize;
+
 		/* This happens when rx buffer size is underestimated
 		 * or headroom is not enough because of the buffer
 		 * was refilled before XDP is set. This should only
@@ -834,6 +841,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 						      page, offset,
 						      VIRTIO_XDP_HEADROOM,
 						      &len);
+			frame_sz = PAGE_SIZE;
+
 			if (!xdp_page)
 				goto err_xdp;
 			offset = VIRTIO_XDP_HEADROOM;
@@ -850,6 +859,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		xdp.data_end = xdp.data + (len - vi->hdr_len);
 		xdp.data_meta = xdp.data;
 		xdp.rxq = &rq->xdp_rxq;
+		xdp.frame_sz = frame_sz - vi->hdr_len;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		stats->xdp_packets++;
@@ -924,7 +934,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	}
 	rcu_read_unlock();
 
-	truesize = mergeable_ctx_to_truesize(ctx);
 	if (unlikely(len > truesize)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 			 dev->name, len, (unsigned long)ctx);


