Return-Path: <bpf+bounces-3430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B8E73DE6B
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EF01C2087C
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEC8C1F;
	Mon, 26 Jun 2023 12:03:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6154847A;
	Mon, 26 Jun 2023 12:03:09 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F836E43;
	Mon, 26 Jun 2023 05:03:06 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm05AbG_1687780981;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vm05AbG_1687780981)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 20:03:02 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net-next v3 0/2] virtio-net: avoid conflicts between XDP and GUEST_CSUM
Date: Mon, 26 Jun 2023 20:02:59 +0800
Message-Id: <20230626120301.380-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

virtio-net needs to clear the VIRTIO_NET_F_GUEST_CSUM feature when
loading XDP. The main reason for doing this is because
VIRTIO_NET_F_GUEST_CSUM allows to receive packets marked as
VIRTIO_NET_HDR_F_NEEDS_CSUM. Such packets are not compatible with
XDP programs, because we cannot guarantee that the csum_{start, offset}
fields are correct after XDP modifies the packets.

There is also an existing problem, in the same host vm-vm (eg
[vm]<->[ovs vhost-user]<->[vm]) scenario, loading XDP will cause packet loss.

To solve the above problems, we have discussed in the [1] proposal, and
now try to solve it through the method of reprobing fields suggested
by Jason.

[1] https://lists.oasis-open.org/archives/virtio-dev/202305/msg00318.html

---
v2->v3:
  - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp().
    The two operations are different, skb_checksum_setup() operates as
    skb->data==>iphdr, and virtnet_flow_dissect_udp_tcp() operates as
    skb->data==>ethhdr. Essentially equivalent. @Jason Wang

v1->v2:
  - Squash v1's patch [1/4] and patch [2/4] into v2's patch [1/3]. @Michael S. Tsirkin
  - Some minor modifications.

Heng Qi (2):
  virtio-net: support coexistence of XDP and GUEST_CSUM
  virtio-net: remove GUEST_CSUM check for XDP

 drivers/net/virtio_net.c | 90 +++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 16 deletions(-)

-- 
2.19.1.6.gb485710b


