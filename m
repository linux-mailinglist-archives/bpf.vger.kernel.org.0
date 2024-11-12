Return-Path: <bpf+bounces-44569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C7A9C4BD0
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7C51F22181
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F65209F2A;
	Tue, 12 Nov 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hp6+qksR"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FC207A0B;
	Tue, 12 Nov 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374985; cv=none; b=ro4Lru5488Tr4qUbGmsFDGYM1LI8f0XtDQIsU95gMdKN25MFviGfzEbGviLo0SJT68Ouq8H4AOJt1HOwwA6kUj/+fls3NbHzU64avFLYMmtT2sxqXSqGclGtkD2ypd1jRGkBUVOyj3dn4AVRKumtPRYOcK1vm2YZmw0cfKdK1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374985; c=relaxed/simple;
	bh=U/E57uu8IQwXQqah9pjwBXXdVdvy+9QDhc9uIDQvHJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0z93gN3wll2Dhxo6a6Owt8gfObQN1gMqevd5OxJMFPTgSyEqCb7zGmDwltH95KwDWJlZAwVRNJ3e30JqlUw2qpf0tJoViA4ZtU8Lhk8QccFjSPM8/INsT3Py7orW4gOSRt6sye/0F1p6wG7HTPXcJLV/XsXhjB6IafoAU2C6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hp6+qksR; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731374981; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kr0MELyfbJj58j/hXBg7jaOtViO1UOcnsHukFQ0/Mfo=;
	b=hp6+qksROpTvKuvmvFl1o11NIQmNCW/0MLkyDmv17Q3gc0x0ORz0LY5ZDF1MBlCiUkoeU2vPigTDmNJrnoktid0DGQLkj63MzCHGVnjdXIclSR1SQv4e11ktdy9h0z7uOze6dLBuKkZ0ULY+LNNYOsrm7iOUZhilcMN0wfEr9lc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJF8TBc_1731374979 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:29:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 10/13] virtio_net: xsk: prevent disable tx napi
Date: Tue, 12 Nov 2024 09:29:25 +0800
Message-Id: <20241112012928.102478-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
References: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ee9bd377a389
Content-Transfer-Encoding: 8bit

Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
we must stop tx napi from being disabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6cd9fdb23b8a..d5b8567f77d0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5090,7 +5090,7 @@ static int virtnet_set_coalesce(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, queue_number, napi_weight;
+	int ret, queue_number, napi_weight, i;
 	bool update_napi = false;
 
 	/* Can't change NAPI weight if the link is up */
@@ -5119,6 +5119,14 @@ static int virtnet_set_coalesce(struct net_device *dev,
 		return ret;
 
 	if (update_napi) {
+		/* xsk xmit depends on the tx napi. So if xsk is active,
+		 * prevent modifications to tx napi.
+		 */
+		for (i = queue_number; i < vi->max_queue_pairs; i++) {
+			if (vi->sq[i].xsk_pool)
+				return -EBUSY;
+		}
+
 		for (; queue_number < vi->max_queue_pairs; queue_number++)
 			vi->sq[queue_number].napi.weight = napi_weight;
 	}
-- 
2.32.0.3.g01195cf9f


