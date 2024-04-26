Return-Path: <bpf+bounces-27882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1FA8B2F19
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBE6B21A7D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538F7AE43;
	Fri, 26 Apr 2024 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L/YHtgJ/"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E878C84;
	Fri, 26 Apr 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102779; cv=none; b=aPeCcFExNmOwDbZZdL7GaqqYuiwvTIqCo9ZwX7gaHF96cso24MECFhZTe5lPPCmHrENj93YTkne83q64XqIyhpcUbpRUkWm4cYvtdmWyZqwlY/GLwwM/pOohpVhCE8UvUb84J3RUO3AJXc1tZVY21fFiduZEIj2sAJzf9wZ6AQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102779; c=relaxed/simple;
	bh=xLtm8dXxF6BJ1LExmMurLPtBZcyitBt5lsiSWVTnbJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ldSUL1r7otc7rbaQVxcw1+oExoJfxY+aNdKW38yGiYd22TtSmzKx7LNy11+9Io95IPbSYdHkInUAYGyVtcKqzOLY+dneYIc/B6G5MYuDTVkqK8/M6k+u6Aae3sVNGD+PCMHimoXMytmS3elI+H3RRYFkO/VKcR1JlfzVuchec0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L/YHtgJ/; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714102775; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Xa9VbW5IwfAC2YERlSMaByqxHGgwyE2WfygYL/+cYAw=;
	b=L/YHtgJ/CX18MqMaclNAw7LCFgykJXspv+AvrsDR1I6gZfqtoRMNFJ5gXr0HOaE+qC9eLy7zk7+ZdBBQUA0nyjQnXeHzCSyEvLz9ddf5hh9lJ7tNYIH5DgL8s9t071RJmuqcPGg5/UrdQPZkBzUVnu0aqHVtnbzb7SrJCKN0HZk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5Hk9dF_1714102773;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5Hk9dF_1714102773)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 11:39:34 +0800
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
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 3/8] virtio_net: remove "_queue" from ethtool -S
Date: Fri, 26 Apr 2024 11:39:23 +0800
Message-Id: <20240426033928.77778-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
References: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 435b736161fa
Content-Transfer-Encoding: 8bit

The key size of ethtool -S is controlled by this macro.

ETH_GSTRING_LEN 32

That includes the \0 at the end. So the max length of the key name must
is 31. But the length of the prefix "rx_queue_0_" is 11. If the queue
num is larger than 10, the length of the prefix is 12. So the
key name max is 19. That is too short. We will introduce some keys
such as "gso_packets_coalesced". So we should change the prefix
to "rx0_".

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3bc9b1e621db..8aa03625ab6c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3317,13 +3317,13 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	case ETH_SS_STATS:
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
+				ethtool_sprintf(&p, "rx%u_%s", i,
 						virtnet_rq_stats_desc[j].desc);
 		}
 
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
+				ethtool_sprintf(&p, "tx%u_%s", i,
 						virtnet_sq_stats_desc[j].desc);
 		}
 		break;
-- 
2.32.0.3.g01195cf9f


