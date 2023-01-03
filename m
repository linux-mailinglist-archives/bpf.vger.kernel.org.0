Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF80665BAB2
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 07:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjACGkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 01:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjACGkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 01:40:21 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9171136;
        Mon,  2 Jan 2023 22:40:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VYiqoEn_1672728014;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VYiqoEn_1672728014)
          by smtp.aliyun-inc.com;
          Tue, 03 Jan 2023 14:40:14 +0800
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
Subject: [PATCH v3 1/9] virtio-net: disable the hole mechanism for xdp
Date:   Tue,  3 Jan 2023 14:40:04 +0800
Message-Id: <20230103064012.108029-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230103064012.108029-1-hengqi@linux.alibaba.com>
References: <20230103064012.108029-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

XDP core assumes that the frame_size of xdp_buff and the length of
the frag are PAGE_SIZE. The hole may cause the processing of xdp to
fail, so we disable the hole mechanism when xdp is set.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9cce7dec7366..443aa7b8f0ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1419,8 +1419,11 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 		/* To avoid internal fragmentation, if there is very likely not
 		 * enough space for another buffer, add the remaining space to
 		 * the current buffer.
+		 * XDP core assumes that frame_size of xdp_buff and the length
+		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
 		 */
-		len += hole;
+		if (!headroom)
+			len += hole;
 		alloc_frag->offset += hole;
 	}
 
-- 
2.19.1.6.gb485710b

