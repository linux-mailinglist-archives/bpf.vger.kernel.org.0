Return-Path: <bpf+bounces-3633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCEB7408C8
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 05:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EA7281190
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8346A7;
	Wed, 28 Jun 2023 03:05:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16D1C37;
	Wed, 28 Jun 2023 03:05:12 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CF51730;
	Tue, 27 Jun 2023 20:05:10 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm7vXNi_1687921506;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vm7vXNi_1687921506)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 11:05:07 +0800
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
Subject: [PATCH net-next v4 0/2] virtio-net: avoid conflicts between XDP and GUEST_CSUM
Date: Wed, 28 Jun 2023 11:05:04 +0800
Message-Id: <20230628030506.2213-1-hengqi@linux.alibaba.com>
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
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

virtio-net needs to clear the VIRTIO_NET_F_GUEST_CSUM feature when
loading XDP. The main reason for doing this is that received packets
marked with VIRTIO_NET_HDR_F_NEEDS_CSUM are not compatible with
XDP programs, that is, we cannot guarantee that the csum_{start, offset}
fields are correct after XDP processing.

There is also an existing problem, in the same host vm-vm (eg
[vm]<->[ovs vhost-user]<->[vm]) scenario, loading XDP will cause packet loss.

To solve the above problems, we have discussed in the [1] proposal, and
now try to solve it through the method of reprobing fields suggested
by Jason.

[1] https://lists.oasis-open.org/archives/virtio-dev/202305/msg00318.html

---
v3->v4:
  - Rewrite some comments for patch [1/2].

v2->v3:
  - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp(). @Jason Wang

v1->v2:
  - Squash v1's patch [1/4] and patch [2/4] into v2's patch [1/3]. @Michael S. Tsirkin
  - Some minor modifications.

Heng Qi (2):
  virtio-net: support coexistence of XDP and GUEST_CSUM
  virtio-net: remove GUEST_CSUM check for XDP

 drivers/net/virtio_net.c | 86 ++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 16 deletions(-)

-- 
2.19.1.6.gb485710b


