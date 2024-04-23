Return-Path: <bpf+bounces-27535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C1C8AE403
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62201B2390A
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558784DFF;
	Tue, 23 Apr 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i4SDtJuD"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EC84A40;
	Tue, 23 Apr 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871916; cv=none; b=h1ZE2Q5ioHmys1S3yiwe7N57hW2N1IOBeYkXnYVZzIvhi0mBNOuIGmii78reUkXEMfEf5ROX0iKkW6YHxd+OjA39UjyQt7Mhza+Tok6CbMUShKzERzxK+eISemPyk+jNTaZDdXJquIfKLwa3Q9RZ8rSHBal/Z0qIk8I4Jm7uofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871916; c=relaxed/simple;
	bh=q3ZyIgBmElYvqwygrKxU4CkdF4eQJwLkLTU61XautEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDXEJEC6ErAQf4TuIQBQWD1lbUIr7SgBK5OEuxLvQuDsjb6YxKLulfTX+7C/nXiBGXFY+xQQSYn3VeBQ+mxRYjHvPcKK6dzF5C1R7FypeXWv/5NvPymTLbDAx3WgQlcBr3sETLdvx0Mp1Dprs0Vy7yWJMAsZ24yyaKrQbJzk9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i4SDtJuD; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871906; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NQb2rLSJ5HIC9zF/pW9mQ/XcCiSAq+Fis1uUOTIBIAM=;
	b=i4SDtJuDVeLK2oPzZxsXP2I4wPwXYFP/89ys8wlE/SUmFL10bCMxbYC8U1395wE1mUKKsHrLaPOkwdz2FVsw94COMIaHB9wVV2TGYxgCBc32id0nv8D+kkZBZFKUK3Z90NrzwREkbYUBQWGcSZhyMXfcC0BcLBfNCwHznC4Uu0c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W591Z6W_1713871904;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W591Z6W_1713871904)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:45 +0800
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
Subject: [PATCH net-next v6 2/8] virtio_net: remove "_queue" from ethtool -S
Date: Tue, 23 Apr 2024 19:31:35 +0800
Message-Id: <20240423113141.1752-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 75c95ace5f2d
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
index 921b2254594f..bd90f9d3d9b7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3278,13 +3278,13 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
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


