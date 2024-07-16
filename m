Return-Path: <bpf+bounces-34888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB89320A9
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592A81C2185A
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D56CDC8;
	Tue, 16 Jul 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QKHIRbeB"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701937165;
	Tue, 16 Jul 2024 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112404; cv=none; b=fLFgfk0puu2GxXCKDNV1F71UZw54q+yGJPGAPu4/mt0w7Fu7BjbhBl3BRGXLGL/g2iRuTnXrEAp9YyIKpg9AqYcFnogNeccqqP92uWWOB04nBktd0uEQvkVIttNVqZgteePqMTcQhGzJOos/5dWDvdLVob4hIeo4zheEVpghWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112404; c=relaxed/simple;
	bh=AwWTdD3g8fjefujmou3OCOk06OrarqWBGNWppryTigo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8BPBXxx6gxRX5SjvWjybjuKQqTiIsdDytj1qQ/2xOCD38MNFvgcvzZmxrHw8E+cPX3yLMhS8xoJ7NYxLX9BUYLCMO6PLD81rEA6d0y7P2pFL0chXHAZ+1kmoEUSKsYYL+IlHBu39IkvTiSCirbrV198GO06gVOpbsj5U6yuuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QKHIRbeB; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112400; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yiCOhmhFBRs0pws3fbKmQFX9Az2kdIsOs7vf0zpw8Dc=;
	b=QKHIRbeBMM5CiKwuEYDmpORaKymKes67Ty6hETfeQoGZ1ZMrmb+KI5kwI+4iYK4rng5V6p278BeCZZppUOS9u9U8OdRIB10Aycd7lkylibp+yLfSyB4RAT+/6gwlWW035w9KYMoSQEx2JqTNfMvNCkl3b1re+WRqi+nJiSq/t9o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WAgSzlG_1721112399;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAgSzlG_1721112399)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:39 +0800
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
Subject: [RFC net-next 12/13] virtio_net: update tx timeout record
Date: Tue, 16 Jul 2024 14:46:27 +0800
Message-Id: <20240716064628.1950-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: d3e48bf059c8
Content-Transfer-Encoding: 8bit

If send queue sent some packets, we update the tx timeout
record to prevent the tx timeout.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 700d080d8c5b..38af9f0b632e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1478,6 +1478,13 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		check_sq_full_and_disable(vi, vi->dev, sq);
 
+	if (stats.packets) {
+		struct netdev_queue *txq;
+
+		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
+		txq_trans_cond_update(txq);
+	}
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	u64_stats_add(&sq->stats.packets, stats.packets);
 	u64_stats_add(&sq->stats.bytes,   stats.bytes);
-- 
2.32.0.3.g01195cf9f


