Return-Path: <bpf+bounces-44570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC299C4BD7
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE321F23C5F
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC720A5DA;
	Tue, 12 Nov 2024 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m5vjJkm1"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0A20968D;
	Tue, 12 Nov 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374988; cv=none; b=I4LfKlFgoMN4NMVEq4JEZ6hfSmpsg/ltD2jGfz2ZqdkmaYDV05eyESBwjsLai3S/AmR5UrCQHAYfXpCzQc4ZeqZ30PJbFl7/CdzrcZw07tw5i2a0YXvpqC1aN9c0vgNgxL+QTCzebEd9a5hiUcn3DxXUf56+JcLHW/88yWgLndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374988; c=relaxed/simple;
	bh=YxkHsvXk+bzgVLc2OrOMQvOOz4cz/TNQbCvj2xW+xgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8IEcT3tMM5BtQgptK14xpVCqY4GEkRH6Ru7Z6KgF7TwcRSOkPia2Vka1aKH8kDsNW4NeYX/LnQ3tTSuwIngngCyj4HEDeCbYXxZzPN67Ime3FnghtV4aUoPlC6e4WMdKji98jrKVinDMLeQrybIbq8dMuk+WZgyY27QzXLKpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m5vjJkm1; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731374982; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pWWtXK+RGYyRwzv6/Hi5nS9Zd2ZpWrf6lzPwZQ8jhQE=;
	b=m5vjJkm1PSBiPKdl5JJYDWYJWFU36a1LOFudwz0IxVE/MpRpJiZRHp0Z/fBPXWlctjMR4bhA1BfzkuODIPk1m3wtiJPQjPMbIVZzAkayTbry7vSiMiAtE4Et7ia/5qRwB6JBbS3S8M/j354ZhWWaaf2ppmU7yNVSZ4/OvG7IGFg=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJF6aSs_1731374981 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:29:41 +0800
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
Subject: [PATCH net-next v4 12/13] virtio_net: update tx timeout record
Date: Tue, 12 Nov 2024 09:29:27 +0800
Message-Id: <20241112012928.102478-13-xuanzhuo@linux.alibaba.com>
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

If send queue sent some packets, we update the tx timeout
record to prevent the tx timeout.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 57642bd83b7b..7db586770249 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1509,6 +1509,13 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		check_sq_full_and_disable(vi, vi->dev, sq);
 
+	if (sent) {
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


