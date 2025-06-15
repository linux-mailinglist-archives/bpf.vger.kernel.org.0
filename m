Return-Path: <bpf+bounces-60687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45532ADA245
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA7A1890583
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774D260564;
	Sun, 15 Jun 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k18tlfeP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A517A2F0;
	Sun, 15 Jun 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750000480; cv=none; b=mQZKhS8g1GjU/6n+6R1abxCx6znUTPj/wWzjJ4iqItI53pg+YewgmD4NV50mE31aJWcaJ8WDa0D1oZBg1QbBGsPzfpNgght/RXKq6EEL2q38NSQLabE/RP0/k/dccG14vulZvUHZB7VE3XJ4dqnORL3xLS/lbqMQKD5ymvG2Agw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750000480; c=relaxed/simple;
	bh=ND9xpjO/EgzVkVrG+j9hpH3tRTi52jjvodovOmf6J/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHtFZaNBcujuYFsbGldi7mQ0/bls9eNthLuWECcv828JvR12GUQj3Q8/jF5d2NQNT4cEvwz+pDR3MDEVaMOrX8SH9Zo2yC3Qr+GNwuPStLgY3SKdGmTCRxh2Cn3cSgMDhYfv01F6cH92ESS5/s/Go1xP9KEVXtwBr35AlRoDhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k18tlfeP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3192eab3c9so969646a12.3;
        Sun, 15 Jun 2025 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750000477; x=1750605277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqZXoccd5enL7c4ScDfrc/L3+vhJGMt2m7+g5f2BwpM=;
        b=k18tlfePl8yShhkC+9xAu/E7seCRV9akqMoS+YtAgyDDztBfoMHLnJ12zYoC5Ol9j9
         VgBHuKWpRs16Op6QXHWWjl6apnmG/bM+z3iT90sjFJe/skQXAnmknglj+QMw8tnvworz
         urTW/HOmDZ3S0E+O0XVY7/DDH4TWUrbtp84n15QSz1z09GlSF5toW+cw4p8RbRbtTvmU
         XTtlle3w1dfFIbDSgqZwe2LAZnylLRhBdtKtj31g1DmWibmkB0tP5PvO22bcP79TMUsr
         +RE8tYU7mwYAssabeC3arY9W/I9s2CBPcynjDXgGi24bjaQ1r1P1uGuU/QrxOKMcqTJZ
         W4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750000477; x=1750605277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqZXoccd5enL7c4ScDfrc/L3+vhJGMt2m7+g5f2BwpM=;
        b=KKGOUExYRDtMdkUZ8xZVvF7ioGRHteazNBP6vhoQ5urd4koP69P4t4Z8nSfXhpzdKL
         /SHeLCpwLWS9uPKdZ99JQXaQ+UVitvQH4OR4+nwP9uezdvsgOtncksT2g9FR4PSh1Lj8
         +SKSUN2uW9KgObuAFKRJnU4fcy8GYW+L0DuIN6v6pXlpglE4F2Gy4oO8Ko1PAStyCQtA
         Yr4h9tDTWFRaEYglRrx+D8ikynSqfM5LlDC2S+zyjmFuluCsZuxchjXl7wJGVHt/X+Zt
         BCH3W9iSL/wi6oydDXvOhxdtOt2lbcS4wUCfffEyckqmmXTxiObuD3ZvIoxyl1AHgRtt
         UATw==
X-Forwarded-Encrypted: i=1; AJvYcCWHpIaZueswagdD7HQ8jN4uTVGbbnnvFw+TWdVb5exKBriJWQZe69V1aHhFbujNOG9TwzY=@vger.kernel.org, AJvYcCWtQPbmollmrIYgdACnsx8lLraxsKGXQRJMmy8NDQ/1mkbLQ1emmiwqUCqY5WIy8Dje6Jij97HZW7VFVEp4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dWLITnAY5/OhGqXfVhakbeE0PPXyGXHFHsBlYtKfiDwmzv+N
	Bb3hY95Dvr/0vz82Ys20m5Fbw404NKopfKZdn7P+NmGzs85Q8fVqPfTgkRLkGQ==
X-Gm-Gg: ASbGnct93uXbg7BbtOHuzPlmuthITNeVNnEppt7Ef++H0j/V4K1Icj1q9vObqONd9x1
	MulW5m0VX7gy2we481hRRncr86FvDnyOFAROJiR/wMZg4nZCHXJlIDTKrbLONknYwg77UggPIxT
	dX4UE3RhL5Uwh/H5/1v2lFcWwd8t4NGdqKNl3rSYB+uj+Q8RWy/Bn+SHCdz/gNtE9/9hTVphCP/
	19QB3gsSYWZgweKIQ692PgvouFu5WkkqUz5f7n4s4BFFDXKYkHwltYnfH4A6/X6tSl3uvKO9wxf
	63koc3a3z1CYjIPjx+bvX06u1laQoM7jsrJdrdic7/9QCWv7RUAu5JCry2fTobCcvtWURvv5YKP
	nEWvdz7YDT0u5
X-Google-Smtp-Source: AGHT+IETaVvpcg0giznYrwd0REXTX1eTC798GSd0+9LFucKtPuDvNmFiIeU9L0x1qEGvknJT9744Lg==
X-Received: by 2002:a05:6a20:cd92:b0:219:935a:6e1e with SMTP id adf61e73a8af0-21fbd559011mr8729424637.26.1750000477212;
        Sun, 15 Jun 2025 08:14:37 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:482b:a929:1381:df12])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-748900b219csm4950022b3a.129.2025.06.15.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:14:36 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
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
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 1/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sun, 15 Jun 2025 22:13:32 +0700
Message-ID: <20250615151333.10644-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250615151333.10644-1-minhquangbui99@gmail.com>
References: <20250615151333.10644-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling buf_to_xdp, the len argument is the frame data's length
without virtio header's length (vi->hdr_len). We check that len with

	xsk_pool_get_rx_frame_size() + vi->hdr_len

to ensure the provided len does not larger than the allocated chunk
size. The additional vi->hdr_len is because in virtnet_add_recvbuf_xsk,
we use part of XDP_PACKET_HEADROOM for virtio header and ask the vhost
to start placing data from

	hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
not
	hard_start + XDP_PACKET_HEADROOM

But the first buffer has virtio_header, so the maximum frame's length in
the first buffer can only be

	xsk_pool_get_rx_frame_size()
not
	xsk_pool_get_rx_frame_size() + vi->hdr_len

like in the current check.

This commit adds an additional argument to buf_to_xdp differentiate
between the first buffer and other ones to correctly calculate the maximum
frame's length.

Fixes: a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..7c9cf5ed1827 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1127,15 +1127,37 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
+/**
+ * buf_to_xdp() - convert the @buf context to xdp_buff
+ * @vi: virtnet_info struct
+ * @rq: the receive queue struct
+ * @buf: the xdp_buff pointer that is passed to virtqueue_add_inbuf_premapped in
+ *       virtnet_add_recvbuf_xsk
+ * @len: the length of received data without virtio header's length
+ * @first_buf: this buffer is the first one or not
+ */
 static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
-				   struct receive_queue *rq, void *buf, u32 len)
+				   struct receive_queue *rq, void *buf,
+				   u32 len, bool first_buf)
 {
 	struct xdp_buff *xdp;
 	u32 bufsize;
 
 	xdp = (struct xdp_buff *)buf;
 
-	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_len;
+	/* In virtnet_add_recvbuf_xsk, we use part of XDP_PACKET_HEADROOM for
+	 * virtio header and ask the vhost to fill data from
+	 *         hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
+	 * The first buffer has virtio header so the remaining region for frame
+	 * data is
+	 *         xsk_pool_get_rx_frame_size()
+	 * While other buffers than the first one do not have virtio header, so
+	 * the maximum frame data's length can be
+	 *         xsk_pool_get_rx_frame_size() + vi->hdr_len
+	 */
+	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool);
+	if (!first_buf)
+		bufsize += vi->hdr_len;
 
 	if (unlikely(len > bufsize)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
@@ -1260,7 +1282,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		u64_stats_add(&stats->bytes, len);
 
-		xdp = buf_to_xdp(vi, rq, buf, len);
+		xdp = buf_to_xdp(vi, rq, buf, len, false);
 		if (!xdp)
 			goto err;
 
@@ -1358,7 +1380,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	u64_stats_add(&stats->bytes, len);
 
-	xdp = buf_to_xdp(vi, rq, buf, len);
+	xdp = buf_to_xdp(vi, rq, buf, len, true);
 	if (!xdp)
 		return;
 
-- 
2.43.0


