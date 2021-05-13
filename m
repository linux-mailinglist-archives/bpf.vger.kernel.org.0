Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C753537F725
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhEMLuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 07:50:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51642 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231410AbhEMLuE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 May 2021 07:50:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UYkXcdV_1620906489;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0UYkXcdV_1620906489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 May 2021 19:48:09 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH net-next 2/2] virtio-net: get build_skb() buf by data ptr
Date:   Thu, 13 May 2021 19:48:08 +0800
Message-Id: <20210513114808.120031-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210513114808.120031-1-xuanzhuo@linux.alibaba.com>
References: <20210513114808.120031-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the case of merge, the page passed into page_to_skb() may be a head
page, not the page where the current data is located. So when trying to
get the buf where the data is located, you should directly use the
pointer(p) to get the address corresponding to the page.

At the same time, the offset of the data in the page should also be
obtained using offset_in_page().

This patch solves this problem. But if you don’t use this patch, the
original code can also run, because if the page is not the page of the
current data, the calculated tailroom will be less than 0, and will not
enter the logic of build_skb() . The significance of this patch is to
modify this logical problem, allowing more situations to use
build_skb().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e46c12dde08..073fec4c0df1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -407,8 +407,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
 		 */
 		truesize = PAGE_SIZE;
-		tailroom = truesize - len - offset;
-		buf = page_address(page);
+
+		/* page maybe head page, so we should get the buf by p, not the
+		 * page
+		 */
+		tailroom = truesize - len - offset_in_page(p);
+		buf = (char *)((unsigned long)p & PAGE_MASK);
 	} else {
 		tailroom = truesize - len;
 		buf = p;
-- 
2.31.0

