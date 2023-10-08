Return-Path: <bpf+bounces-11659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47A7BCC53
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461AE2820AB
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49570440A;
	Sun,  8 Oct 2023 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vwi2J1cY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F621FD5
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:23:01 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510ED8
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:22:59 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so2546481a34.0
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742578; x=1697347378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdDWVt4lpIJYL5Xl2mxJffHYtHkpJSxptvcjLCGS28w=;
        b=vwi2J1cYT7UODUfB1N5XD/TP+QyK/UcEqkxxo9199A/yEs724R1p2bibfEUUF6GpqX
         5XRzBuZ3UNoxs/0zafYT7bDF2KZTGqqWlivxcvc2KWaMLEmAt6v4rBj3b7C+EBdsDX+R
         wIvNZx8i3tbz6+ZOjp7mLlmXytOB2QhWJes9WAWvjLJhfDV3uYK7lk7c4haA1WYoht2r
         eVpYwAnKnIfEbnBb8yn1IM2EQN3b/XVK+pNGfFoFtZmHTIs6jwJkkMkEiMkh4RPPHA4j
         GFtzn0+zrWE7Q5VuZI5C6x8by1YCKKrFRTFwOjVvjtLfQNDdaor70GaZDNBC1hTGOfgK
         47iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742578; x=1697347378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdDWVt4lpIJYL5Xl2mxJffHYtHkpJSxptvcjLCGS28w=;
        b=cw2MZC5DbgkUz0srPySIxlPG3R2y/fcT+CdK9fSxIAQx2nPR+LnqJUY+T+sGHurWMK
         47vxY4O0LVt9/gsJvgDPXdyeX+oOsHNY51USc3hnK9aYv5QV+j8JxDNBKZBUhcOY8eRb
         sz+0ZBlvDD9vQv4BFl/huFORqmr/thkPCida2CGpLmvSJAQBdWS4hirriHz4n7cihcgH
         HGbaP+dbp02QuUCf8Tm9DnSafQ8CUbNOBS6p7g4Go9A4VvyjwOJGMc0DzT+NECVveC+9
         69RRx0xcqUq2CsD6Birx8G+nXOD2Antg7yHOIGYON4GADqpJvo8e8LwM8Z6X0KVy2hsZ
         zEfQ==
X-Gm-Message-State: AOJu0YwggW5yqEXIJKh1rKsFv0905NN1tNxkCJ4306FByq00P9GqHEpx
	S3f7yQm3wDonuRn97UryLx6EhQ==
X-Google-Smtp-Source: AGHT+IFmz0Csm/McUo7epY/hvuuEc7olif/dP1uLse9ltuNTbzOKdI+TI+qxxYbYUL4vOkxFlEeQWA==
X-Received: by 2002:a05:6870:40d0:b0:1d6:96f9:66fa with SMTP id l16-20020a05687040d000b001d696f966famr15377523oal.54.1696742578366;
        Sat, 07 Oct 2023 22:22:58 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id h18-20020a170902eed200b001c627413e87sm6772511plb.290.2023.10.07.22.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:22:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo Shuah Khan <"xuanzhuo@linux.alibaba.comshuah"@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
	gustavoars@kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
	decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com,
	elver@google.com, pabeni@redhat.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 7/7] vhost_net: Support VIRTIO_NET_F_HASH_REPORT
Date: Sun,  8 Oct 2023 14:20:51 +0900
Message-ID: <20231008052101.144422-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052101.144422-1-akihiko.odaki@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f2ed7167c848..6a31d450fae2 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,6 +73,7 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			 (1ULL << VIRTIO_NET_F_HASH_REPORT) |
 			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
@@ -1634,10 +1635,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
 
-	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			       (1ULL << VIRTIO_F_VERSION_1))) ?
-			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-			sizeof(struct virtio_net_hdr);
+	if (features & (1ULL << VIRTIO_NET_F_HASH_REPORT))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			     (1ULL << VIRTIO_F_VERSION_1)))
+		hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	else
+		hdr_len = sizeof(struct virtio_net_hdr);
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
@@ -1718,6 +1722,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
+		if ((features & ((1ULL << VIRTIO_F_VERSION_1) |
+				 (1ULL << VIRTIO_NET_F_HASH_REPORT))) ==
+		    (1ULL << VIRTIO_NET_F_HASH_REPORT))
+			return -EINVAL;
 		return vhost_net_set_features(n, features);
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;
-- 
2.42.0


