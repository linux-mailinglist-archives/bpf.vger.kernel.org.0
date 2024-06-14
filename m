Return-Path: <bpf+bounces-32169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B19083D8
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5C01C23047
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745561836DB;
	Fri, 14 Jun 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m7DvQlHE"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB52148858;
	Fri, 14 Jun 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347187; cv=none; b=q91nCZMT8INHJuKIGS8CWqzY7WwS5EODtdw/97RHEFhslSMf4ubJP9cg9GOY0aRxXBPK3CaqpS8pOKMvwWpya0I3poCLvhKNPWOpO5koJf1zc1qNxRuYOvezvXHA00SZhbg3gHI4GB0VL/xeYNo980gUmqV1IX30DVcyaLB1BRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347187; c=relaxed/simple;
	bh=MVqiUbhM36USFb1zK5vYprnbNEY0Ueo+8g2JG0pei8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+zVSI1dhyahHgnXLhbnKynR5cax+nWDuDQI+Nl8uhQwpetM36+M+TaPfECCrM/0Y5tm59WQQJr7KMcrLtTKIba6PC47Us0YpXnKSIpybG4DK8g4BVtcMOZWSVIB/uehOz4WGNii5ixiu381Ett25+ht6a7wG7uscnlKoY70wM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m7DvQlHE; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347183; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=r4/jhH2IhiUj+1EGMSxVzby5BQcjGc1Wbn9DmT0Kewc=;
	b=m7DvQlHEYzwlhA2yvtJF9pddUaqyJ94wciD8DFj8q+7LwIGJJuNYF4haopy9UYXsZQSR6RnC2jmqH0dymc3MnsuFAtcKvZAYFCsnNHXPSG2QHLU2Z5M9TYpqy4+eNQsOK720HE/ecapGY1cQlDA98/VLnf586NsLach2tbVcUzw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8QEkB4_1718347182;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8QEkB4_1718347182)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:43 +0800
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
Subject: [PATCH net-next v5 10/15] virtio_net: xsk: prevent disable tx napi
Date: Fri, 14 Jun 2024 14:39:28 +0800
Message-Id: <20240614063933.108811-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e008fb4a0943
Content-Transfer-Encoding: 8bit

Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
we must stop tx napi from being disabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 35fd8bca7fcf..2767338dc060 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4738,7 +4738,7 @@ static int virtnet_set_coalesce(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, queue_number, napi_weight;
+	int ret, queue_number, napi_weight, i;
 	bool update_napi = false;
 
 	/* Can't change NAPI weight if the link is up */
@@ -4767,6 +4767,14 @@ static int virtnet_set_coalesce(struct net_device *dev,
 		return ret;
 
 	if (update_napi) {
+		/* xsk xmit depends on the tx napi. So if xsk is active,
+		 * prevent modifications to tx napi.
+		 */
+		for (i = queue_number; i < vi->max_queue_pairs; i++) {
+			if (vi->sq[i].xsk.pool)
+				return -EBUSY;
+		}
+
 		for (; queue_number < vi->max_queue_pairs; queue_number++)
 			vi->sq[queue_number].napi.weight = napi_weight;
 	}
-- 
2.32.0.3.g01195cf9f


