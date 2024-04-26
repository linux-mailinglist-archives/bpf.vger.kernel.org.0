Return-Path: <bpf+bounces-27880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F5E8B2F12
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227591F22E98
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 03:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8260678C7B;
	Fri, 26 Apr 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mWkE6KKK"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5D76F17;
	Fri, 26 Apr 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102777; cv=none; b=neZnSHKFInmUFOR6L10s5jEgpo8Kfp6KHYZNHVtLhT/MXQ94vRd2kUKCUgJpbzUXR24D5q7/PIHqoXTcSeHMfzELuY0BRKTGK3J5id0Hw21QHcEC/+hl9JMGNO0ivWxKR10AAoNrwc1wedq3k/75w8RjRtC3PIfhxzKW4d+RKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102777; c=relaxed/simple;
	bh=f7zuDwq06y2vEJ0fdAcDlG761FlkFQ8aQNlAH74VCHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijckEa8/yHFGkNOGeoi7EoTrupnuiMeLk4c/lrabC+jSE4bBGXYXPxFhYJNlHaaXM2SnOdo9DYXIW2VXLEqeNnLn5Eu21+/4VN+Rf7oRTP/UVcn4Dl9aewaXNPu+XS9GSBUgcxKP9jupjb6OU+e+hRKQMIa9T6cZFvvF2o5S6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mWkE6KKK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714102772; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EX3Qq7xpF3WOXbmhm0tM6kiKbW6MqecAXHC1vOLplsg=;
	b=mWkE6KKK0DfG5oOFAD/fWxbesC8jxByLRYeonUT3STCBOq8XtT7eSrCGig5XrpfDjPXkKUHBACz76q4YE/3DfTl5NKbQ89CxP5mzfqpRPqIvsLewkCfVd51jluslKvu6Na2RTVDsjFV+aQzQMlMAaB0+12cNklF+sWKfjMt4qJA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5HjR7b_1714102769;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5HjR7b_1714102769)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 11:39:31 +0800
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
Subject: [PATCH net-next v7 1/8] virtio_net: introduce ability to get reply info from device
Date: Fri, 26 Apr 2024 11:39:21 +0800
Message-Id: <20240426033928.77778-2-xuanzhuo@linux.alibaba.com>
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

As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

Based on the description provided in the above specification, we have
enabled the virtio-net driver to support acquiring some response
information from the device via the CVQ (Control Virtqueue).

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7176b956460b..3bc9b1e621db 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
  * supported by the hypervisor, as indicated by feature bits, should
  * never fail unless improperly formatted.
  */
-static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
-				 struct scatterlist *out)
+static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd,
+				       struct scatterlist *out,
+				       struct scatterlist *in)
 {
-	struct scatterlist *sgs[4], hdr, stat;
-	unsigned out_num = 0, tmp;
+	struct scatterlist *sgs[5], hdr, stat;
+	u32 out_num = 0, tmp, in_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 
 	/* Add return status. */
 	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
-	sgs[out_num] = &stat;
+	sgs[out_num + in_num++] = &stat;
 
-	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
+	if (in)
+		sgs[out_num + in_num++] = in;
+
+	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_warn(&vi->vdev->dev,
 			 "Failed to add sgs for command vq: %d\n.", ret);
@@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
+static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
+				 struct scatterlist *out)
+{
+	return virtnet_send_command_reply(vi, class, cmd, out, NULL);
+}
+
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-- 
2.32.0.3.g01195cf9f


