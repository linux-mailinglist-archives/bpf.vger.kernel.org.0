Return-Path: <bpf+bounces-40224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86294983ADD
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 03:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EC528390D
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1778E28379;
	Tue, 24 Sep 2024 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wAsk+TJn"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540F8BFC;
	Tue, 24 Sep 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141538; cv=none; b=nbiXmjd/tXiSmJVu6I6q1Fnm39Nau0FKqqfVgceSH7Mr8hlI/Ta8zknZBm0D2rvExHRQ4sVc16vcHoSTO5/UxWChvM4TnV1Vja1PJhLV2JfVkLAjSvL12tglcJNSTsqxHJ8vKzBZ+K+2m/Cm7y3b2GvNhyI9cyry5hL5mm4HQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141538; c=relaxed/simple;
	bh=0xBuClzLtPEZUdcC3D/BctrxFt19ykyV2iK4rFqKSag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gl3znlsuiqgOGxfZ1/CfZ3U6Yf3fLMJXOfMiZxCA0g3RuhUHnJdl6ni4EFdq1gj3DPDHplKf2DSHiGaHjdzF3xiTIhw0bs23fhQ7/j7Ln9znZeimzBC6NKrCCKtGAtBESXbt7rKiJ9ISWdoQOP8NFYJY+Mu026hWGK5rQblRv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wAsk+TJn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727141533; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UobHEiaweT0402S1orrUBD6B73dHrbBYqy5w2v3FypE=;
	b=wAsk+TJnSi0GvS7RRW2A+L/opFUlNCNFUUzXZHYSfXy1RS/GiezjSkNuqRz5kiwH7zjor1r8fRBHfJJQjwfI8/CwMmPgjE+t5Q20LmVfrMANM8jBvnBLmfrK8rx04KpRCmZ0YMs4uwOUjfHAvQyXVh28+6/UWCcTvgdAGEVKHn0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFdtE4K_1727141532)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 09:32:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
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
Subject: [RFC net-next v1 09/12] virtio_net: xsk: prevent disable tx napi
Date: Tue, 24 Sep 2024 09:32:01 +0800
Message-Id: <20240924013204.13763-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 83bb687d4b73
Content-Transfer-Encoding: 8bit

Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
we must stop tx napi from being disabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7c379614fd22..3ad4c6e3ef18 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5017,7 +5017,7 @@ static int virtnet_set_coalesce(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, queue_number, napi_weight;
+	int ret, queue_number, napi_weight, i;
 	bool update_napi = false;
 
 	/* Can't change NAPI weight if the link is up */
@@ -5046,6 +5046,14 @@ static int virtnet_set_coalesce(struct net_device *dev,
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


