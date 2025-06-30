Return-Path: <bpf+bounces-61852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A57AEE216
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4173AFA51
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4128EA7C;
	Mon, 30 Jun 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyn/i9ku"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCA28DB5D;
	Mon, 30 Jun 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296425; cv=none; b=NRe3aBKBNlgKV4GUXaOp0XvJXTQ4Xnn1IsCUN/gZWKIPKGLaa9p5SDZOKLFc5lE0lFeccEBf/KGt3RCfaAH/bmh5B9mRvMSsxYLDwlZUmaEVBj02Be/qnFPeNADXZDiNiUjK8w/IF9tZJus8upfEKS4gjzUd1B6QZD8qAs/NRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296425; c=relaxed/simple;
	bh=QgfXPfEJ1ko6gJfEVqi+dqAvLBbkYxXvmPhxmO6U4cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJMe4XoK9YRgYzgkmTZH50oWVz8chWTYatzp0ngsDCSPoWBeuaxJlLZSPqAchJG4Ftqyuy+MEpktmDP9Qn9JsbgoigZ+gqkNLH3HsSPCr7Q4wte5fKbaSu1Hbk7/4RHegms5x841Wvh+hKxW9qsjpSw8KvCyOsPEnhlu8Cux+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyn/i9ku; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3287708b3a.1;
        Mon, 30 Jun 2025 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296422; x=1751901222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgTzel6BYyrjmaJOOevkqrQDDDC9SFFWPVaFYPAwVp0=;
        b=Fyn/i9ku1CCY2CtFZAKudA2cbseOmEE8hnJj+aAY3RI/ZctniZQLVGyy2n73lS3h6l
         FcdJlPUHQTZDoOYn5/phfQ0X3YRO5++JrY95DIGK7NjhuMDYAOBgo/HGmqbrp4CphnNp
         BsOCYYefJa4bjyZPASo+gUrfHoVOQX/Ugp1M2u8Ut6BE8DcNZky/lcNdIEcEYRKT2D5F
         ak+f7Z+xoz5gyNXy/+jDBeazv28w7tBnOAvGwJuMw4yNwMkIervvnMge8d8suHYyUy6m
         3ogMkE5AE6f76Y9hK9t6e9v/38nsLLVzClnyIie6WMgVboB2nR0xYSVFij7gX6rMic9L
         HpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296422; x=1751901222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgTzel6BYyrjmaJOOevkqrQDDDC9SFFWPVaFYPAwVp0=;
        b=MYWTDyBAYA2cAbVxIDiLq/sG5M2/9UqbZ9jYVcb2Kl1gC/CMZtAnHYbihnUZ2XW05w
         3EpxL0VxrFPyjblwwbGcZbsEXupvsDJcmcB3eE5nGvemie9ZBZoN1Nm2snZ1SP40w7V/
         kBmbAjobjXe3TPkpoEiGufr9PQOmdEYlzpthlZh4DZ7vW6ufCMAtDyOmVtgCZlcdTKvg
         STONRFFF+GtWpND1DMqBbAn+pXfCPJBfqEXhHNhVYEgZgp6ZlX1MwVRW60Va201Swjn6
         1ctGfHhAivfZQuNFLNLxIuhtKR+Doh7yrZGCDCdAEDvLsH/jJZ1bBcL4W99UowORgj8Y
         KKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUVwa2RBEvrZkCjYvasfYtxRjd5a54pr9X+hiRcsnGlQ/1WQxinJURl+3SlOvIu3U9d7ysWxUZpg6ehGiD6@vger.kernel.org, AJvYcCUlrCDpK17JaUdTXAnqkC/jRSN9vn/Wf98Cs3I9ByxOBnreUY+EZpqY47Uoa7D8JkPoAR9Fnz8V@vger.kernel.org, AJvYcCVGkzcFHHFHBvMmRQvW3wnJ7lQsz7ylFhemMFl2fUrML00IF78QzkQv44xjg6KQNtHrg08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1XT8bOSw7boSAX9rJ/ON6FSPaHI9y9aYRvtaDBWg/cQUKBAG
	7QJZ2MOCtAWUflN/YNUR8l8DxZBc9yyPbGrtM4gyCDb3pFJPbR0ObYyoJfFH7Q==
X-Gm-Gg: ASbGnctJa2LOTe9jOEwsqhxFmGQV+KCQA8vI9qYdDxjj9SzrnZ9F9zgfbiL3GryKMwO
	vBK8HhCgNpmABNmyed+pUg4pSiBbi2O0xwZlwZC1PiAb4pCp+qUu5hqZQKx5E+wjwNhz9HzoEIt
	EJdbZ1KgPu1fl5p8NE8reRTSD6ykJPL/r/JpQYwkit1qFOhUJvD2OsGzdPSsFK/40jqAnXBS3u5
	kNpRZfysvJXqOjmsu5M44tqZNDvQ1QP7DnnhyFtO6mdRgphc/UMfY4SCqfjO71ZZ2vCUZujODw4
	WB2HvWrqTg7L7iayJYqRQU7oxsmT60ZidMS7Tx47G7ltAowZwBslD8OQ/9iQaOV7TVOAgR+/Bun
	2
X-Google-Smtp-Source: AGHT+IEsch+5tINjufS1E+TUAD5+k5BuyuOB3ndZxmFnJHJrghU2JPMJl3gnOuaCh+K3vDh16HFMEA==
X-Received: by 2002:a05:6a21:6e03:b0:21e:2b2c:8f4f with SMTP id adf61e73a8af0-2208d067850mr31572821637.7.1751296422446;
        Mon, 30 Jun 2025 08:13:42 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e31bea17sm8323340a12.46.2025.06.30.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:13:42 -0700 (PDT)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] virtio-net: xsk: rx: fix the frame's length check
Date: Mon, 30 Jun 2025 22:13:14 +0700
Message-ID: <20250630151315.86722-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630151315.86722-1-minhquangbui99@gmail.com>
References: <20250630151315.86722-1-minhquangbui99@gmail.com>
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

Cc: stable@vger.kernel.org
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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


