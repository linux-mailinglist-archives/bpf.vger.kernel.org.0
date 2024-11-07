Return-Path: <bpf+bounces-44210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4365D9C0099
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3361B215AC
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158061DDC18;
	Thu,  7 Nov 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="STvTHmlZ"
X-Original-To: bpf@vger.kernel.org
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F11DE2AC;
	Thu,  7 Nov 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969724; cv=none; b=Aju6Ly7yjp7SOVjJTMShwFrfw8NWFjIT7iDQqY24zxeJDluMxLfaPvlRVIYi+zxN6hv1uZS6vuSY8tSrukYFqINYMJfmlf958YTmHBXR09EcaHHbxbXazLRwhb/KADTYwcZx0N9Lzry8p8oMjUol8eiqVV9s+FhPAFkEKybb4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969724; c=relaxed/simple;
	bh=tYUpUMepL8g3xLEKnwfyJW63bgd+WSzKy6LlhDXLJOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8/Ok4zahBfVYH+8Hq0IXkwciRr50mxWUULvWHWnvOwvvoIQMccjYpfHVGXSBJkCoMOA+XRZiwnntYRshWVXr3bHX73fM5snb0QeB8q0ee0TWUS/bV22DGUrPnmGd6dMEQ2sHJdv2qc56Rg0Uanoz3hEMfKdRsBq5k3ob8go8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=STvTHmlZ; arc=none smtp.client-ip=47.90.199.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730969715; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4KGUXzxzW+IjEN+VFcH1aOBn0GRSlPDc0U3O+l2wGFY=;
	b=STvTHmlZwK9f8O2j1ka62Xu2vxEAlXQTQdwiMGtZyvaH+dhZpAAX3gAzL5QRuds55UugCUFrQoOZt/1K6la905lvl1GPstd7rqmkRVn8o1GckBEUG4/MwOnEv5XaGGT3r27n91HSwPSJW2KLrwGcTiZzWxVnd2bpbva0RldIt08=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIux-9C_1730969714 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:55:15 +0800
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
Subject: [PATCH net-next v3 10/13] virtio_net: xsk: prevent disable tx napi
Date: Thu,  7 Nov 2024 16:55:01 +0800
Message-Id: <20241107085504.63131-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2634baada01d
Content-Transfer-Encoding: 8bit

Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
we must stop tx napi from being disabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a6becdc762cd..3fc8e71cfba9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5029,7 +5029,7 @@ static int virtnet_set_coalesce(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, queue_number, napi_weight;
+	int ret, queue_number, napi_weight, i;
 	bool update_napi = false;
 
 	/* Can't change NAPI weight if the link is up */
@@ -5058,6 +5058,14 @@ static int virtnet_set_coalesce(struct net_device *dev,
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


