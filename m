Return-Path: <bpf+bounces-61233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB566AE299A
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43FF1897B47
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09A20C47A;
	Sat, 21 Jun 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2J/hVPz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA248182D0;
	Sat, 21 Jun 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517491; cv=none; b=XrDBgTAXIvFGLfpEa2MgGaQYsjKPsfC/dDExGXIkxeYm02Me5GYrj9G05fsIp2BlYip68lgilWTscC9jwd5TByNKO/q7MhA6iaLQjnR9lV2Zn0qhjwZSCJ4WnwvUrpupBgZVXvPTfz2cmJIHGEw4cVk0t86aaxuJ2J9P9CtSCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517491; c=relaxed/simple;
	bh=WUV9Kwec4xAVLQG+1Bo69YOw+1iyc2NdSdFVT9fP7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCg3ufI2H+JHvyz0CfkufxcN1+95sEZkpHFav31DCr1JfwYJlsWJ93XADTQ/hGfZ2xE0Cfe590kJRtkyB+j7exjO1C2Euhhd6TTbMROya3+SAbSD/thpZApTjHaModvd17qr98/Vyolc2PYoCjQ8eMrVtwU4bjyiGRXUmiC0yIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2J/hVPz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3149747b3a.2;
        Sat, 21 Jun 2025 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750517489; x=1751122289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up6zSBk/y+q3zd8AI4YQGat3uz9aOy8LOrfGnCsBQQ0=;
        b=D2J/hVPz8hEazDVR4Yqnynvp9juErC8Ras664nP21ohwhYnFFFjr+3Bmgi5l8rFp+j
         f2o/yIoq+qHaIKubjrMmWyZyd9iL9qMuksbLtfytDB1VVcEy6PvzskX3rDHALUUQKWrJ
         ArR/tNfTNbS3k8YHZ3WzdFXUGEBNNAixfpDYedwVfysZ0FPqyPzfxyyRZjAIqKTs46ja
         d72XByf/pC96OmzIBTx5oReGWoF0htWPz3KVzYhl4u6du0Ko8MTUhZv341mUiJniORUK
         ZBDYAIvgrWsxpRi1KPyxKBWuyaEFFso7EP8odcgkQT3ODYqX7Fy+lE6KoyBcjH/7R+ed
         lbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750517489; x=1751122289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up6zSBk/y+q3zd8AI4YQGat3uz9aOy8LOrfGnCsBQQ0=;
        b=AnLfD0mjFskciYh1yf/YCQ1OPRhM9/VTTl2FB/mGbRPwIhelCOgIhYXvbGxnHtYQqh
         SRVwnfVvAGuLt8awo1s89sVg0oULunYFR/bjBZJJ5XqCHHLpW7sGVNcFAnawLw5iJ4QF
         PBR9hDmoxlZW0H52/WdrnEKoKLS6hWkerKg04vx8pkntn0cE3auAI0ZU8oZMbMoolWVJ
         XYRD0udGQ0uXVEqJNRT30IV0q0Z2CIs//5DlENuEOJFp6cBz6zsfl95pwzIcNPZ/6xga
         zvzoA+UK7oPL/++1efdgvSrVfW7pSKLVQ36FO7kESrhh2t0+ExzD6lWoKtCcO5JFHF0b
         QRCA==
X-Forwarded-Encrypted: i=1; AJvYcCULogvBp+9crIYNkIVe9kcbQdt0CNh5Fd3HIdEHPt/6DCMIPg/7bal/MVOds7Ke6NyKpPlcEsBNdrMYZBJs@vger.kernel.org, AJvYcCWZEyqrodzoumXlo4rT6v3axxOEbE26Dvfz4HGgCNAwmW6xryJ7XACsdhRJzxJvZGl9UoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIokptC2a6LFIPZ0sQjcJnOYqb+NsLW6X5IoDIviWUO3F5rrl
	BY1JgG20SXBNpP722sqDqwSK53a+KVxhw81E73wOyEm/NjHiyucRtaj9UIFM01iQ
X-Gm-Gg: ASbGnctCzARBSso20Vi4tDwHsXGAceKFm9uXn5dEtfigb5Z0PxDOnB/SWmz6KE7VVk/
	CSXrmqpld4SuFJJi33TC1hEvAgyjGc0SG51NX5NI2zqt84Of8uU53NHq1/px+JRDj9zHOArto52
	GoACMhMmPQugY4PbzsajyIHxd38u47mk45E8VwGotke/650GBJRnY7L8btgieFNVZHtxQuqLUeV
	x9Be/ELqlk93egCvOBJRo/rIFwjOb7Es60vCpHZdxgZubntPMiRnc/+eruRvfQxobuWin7V8+SS
	UxTSD/fmaxV5+VQGmQln6GCmc9ZTzE5aoTV2ZtryETT0lJOdvR1YtgCMkTDZ0NXDsIZ/9J7Igrh
	y/g==
X-Google-Smtp-Source: AGHT+IETi27TeBNcP7Wim+YmhsbCm01nbJd/oUEKhx0FHnAVaswF5F4Iuv0tVHyJ0xkSdH1X0Q0tzw==
X-Received: by 2002:a05:6a00:3e0b:b0:747:bd28:1ca1 with SMTP id d2e1a72fcca58-7490d663700mr11428892b3a.3.1750517488811;
        Sat, 21 Jun 2025 07:51:28 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:fea9:d2f2:6451:ed3b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a46acf4sm4493490b3a.11.2025.06.21.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:51:28 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sat, 21 Jun 2025 21:49:51 +0700
Message-ID: <20250621144952.32469-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621144952.32469-1-minhquangbui99@gmail.com>
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
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
 drivers/net/virtio_net.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..1eb237cd5d0b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1127,15 +1127,29 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
+/* Note that @len is the length of received data without virtio header */
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
@@ -1260,7 +1274,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		u64_stats_add(&stats->bytes, len);
 
-		xdp = buf_to_xdp(vi, rq, buf, len);
+		xdp = buf_to_xdp(vi, rq, buf, len, false);
 		if (!xdp)
 			goto err;
 
@@ -1358,7 +1372,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	u64_stats_add(&stats->bytes, len);
 
-	xdp = buf_to_xdp(vi, rq, buf, len);
+	xdp = buf_to_xdp(vi, rq, buf, len, true);
 	if (!xdp)
 		return;
 
-- 
2.43.0


