Return-Path: <bpf+bounces-34718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03430930321
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 03:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724D71F22F68
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0189175BF;
	Sat, 13 Jul 2024 01:52:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B011CBD;
	Sat, 13 Jul 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835579; cv=none; b=GNBoUAdAOwuGpx4k61r86Cp+oqRzFYgsThq+4+bfO1EMyRYgzDPR0QFRZSGWD6MBKTC6EUoH73OrZv4uO5ez1STCPItzS04Y37y1rAh6tCOjrp2j8/ETT8Zfiy6i2TdhiEwtqvY0rO8D9P7rdT6ZaDl2yuoM4hPl+/bUobpu0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835579; c=relaxed/simple;
	bh=W5VJoxSGczTiAnEP68n18OhmSGDECGkcFAAZLan4nPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqZBWPmujBh02qyWJnyc/NqhYrCqxuii6HoWoLsG/RELvGLM0cZa5vIilqReT32N6vMEoTIqQTm/dZoz93Zn65OUiU9rgoTFF4ef2Cs8Mlr8AiHi57gJc+1b95J+CEojjK/ElS0DfX+vBDjQgTuGyzIXhwU9MON8pV6L8GcC7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c97aceb6e4so2019741a91.2;
        Fri, 12 Jul 2024 18:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720835576; x=1721440376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAI/weA0jkHtN1q01eCeQ+AOz9HOvjKM1sFLTjEfVw4=;
        b=CPUWSac+UzVO3AjrOtXt+ccd//+Vg21rc7Y16xqInuHjjRfmDanFhRYPMHDM5qt5yj
         4wXrbKxulIhlvUeBB9QqdGU0S1FKmQj0KXEYV4nHdZiuA8E8D/uxjg0d0uWHLg6tQYDR
         a2A6ZdDJT1PVAcyYS8MH1VDM4i5I7kJZmZ0WT8Z1sdbf6yegfOPfGKhv4AampxGR5mGa
         dBcHQ5LWoV4fCPnQWEOxZdBen9nWy6I6HdwG050BM+lavA9v7qRLjy+8Z2POzax3l0Im
         QXVwNzCXRd7CuIz8fipuYLzGdNPAWMwtvAWsvWEghkxWcnFWCyH52bXAfgVaaA9w49VN
         NViw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3RVLUZW0pv/8T+uiqV7i61Su8Trh2OFA1O7j5ksJVNKcnPjyvY7fTRzezv7j5hg9GV+qlhoVHtGhH/JxVy8e1aV3Hadb
X-Gm-Message-State: AOJu0YwwrPdsKQsM916+W6A1mZ+Z4bOqn+j8vGE3dy99ovgQ6O651HI/
	VJfmuy94cLXbW7UUg5CLFMsr2oB8JTe9/XJbm0HqMODAoL+llUiGhu41KKo=
X-Google-Smtp-Source: AGHT+IFiDODodfvec3oVwzSPZZEIQm2eJaBtETv3CKPMWdN8fOoU1s6I5l2UkcYEeSb7mn/gW4a4AQ==
X-Received: by 2002:a17:90b:257:b0:2ca:d1dc:47e2 with SMTP id 98e67ed59e1d1-2cad1dc4b8fmr2215777a91.33.1720835576273;
        Fri, 12 Jul 2024 18:52:56 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedbdb402sm180579a91.3.2024.07.12.18.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 18:52:55 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	Julian Schindel <mail@arctic-alpaca.de>,
	Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: [PATCH bpf 1/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
Date: Fri, 12 Jul 2024 18:52:51 -0700
Message-ID: <20240713015253.121248-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713015253.121248-1-sdf@fomichev.me>
References: <20240713015253.121248-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Julian reports that commit 341ac980eab9 ("xsk: Support tx_metadata_len")
can break existing use cases which don't zero-initialize xdp_umem_reg
padding. Introduce new XDP_UMEM_TX_METADATA_LEN to make sure we
interpret the padding as tx_metadata_len only when being explicitly
asked.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Reported-by: Julian Schindel <mail@arctic-alpaca.de>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/xsk-tx-metadata.rst | 16 ++++++++++------
 include/uapi/linux/if_xdp.h                  |  4 ++++
 net/xdp/xdp_umem.c                           |  9 ++++++---
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index bd033fe95cca..e76b0cfc32f7 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -11,12 +11,16 @@ metadata on the receive side.
 General Design
 ==============
 
-The headroom for the metadata is reserved via ``tx_metadata_len`` in
-``struct xdp_umem_reg``. The metadata length is therefore the same for
-every socket that shares the same umem. The metadata layout is a fixed UAPI,
-refer to ``union xsk_tx_metadata`` in ``include/uapi/linux/if_xdp.h``.
-Thus, generally, the ``tx_metadata_len`` field above should contain
-``sizeof(union xsk_tx_metadata)``.
+The headroom for the metadata is reserved via ``tx_metadata_len`` and
+``XDP_UMEM_TX_METADATA_LEN`` flag in ``struct xdp_umem_reg``. The metadata
+length is therefore the same for every socket that shares the same umem.
+The metadata layout is a fixed UAPI, refer to ``union xsk_tx_metadata`` in
+``include/uapi/linux/if_xdp.h``. Thus, generally, the ``tx_metadata_len``
+field above should contain ``sizeof(union xsk_tx_metadata)``.
+
+Note that in the original implementation the ``XDP_UMEM_TX_METADATA_LEN``
+flag was not required. Applications might attempt to create a umem
+with a flag first and if it fails, do another attempt without a flag.
 
 The headroom and the metadata itself should be located right before
 ``xdp_desc->addr`` in the umem frame. Within a frame, the metadata
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index d31698410410..42ec5ddaab8d 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -41,6 +41,10 @@
  */
 #define XDP_UMEM_TX_SW_CSUM		(1 << 1)
 
+/* Request to reserve tx_metadata_len bytes of per-chunk metadata.
+ */
+#define XDP_UMEM_TX_METADATA_LEN	(1 << 2)
+
 struct sockaddr_xdp {
 	__u16 sxdp_family;
 	__u16 sxdp_flags;
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index caa340134b0e..9f76ca591d54 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -151,6 +151,7 @@ static int xdp_umem_account_pages(struct xdp_umem *umem)
 #define XDP_UMEM_FLAGS_VALID ( \
 		XDP_UMEM_UNALIGNED_CHUNK_FLAG | \
 		XDP_UMEM_TX_SW_CSUM | \
+		XDP_UMEM_TX_METADATA_LEN | \
 	0)
 
 static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
@@ -204,8 +205,11 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
 		return -EINVAL;
 
-	if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
-		return -EINVAL;
+	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
+		if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
+			return -EINVAL;
+		umem->tx_metadata_len = mr->tx_metadata_len;
+	}
 
 	umem->size = size;
 	umem->headroom = headroom;
@@ -215,7 +219,6 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->pgs = NULL;
 	umem->user = NULL;
 	umem->flags = mr->flags;
-	umem->tx_metadata_len = mr->tx_metadata_len;
 
 	INIT_LIST_HEAD(&umem->xsk_dma_list);
 	refcount_set(&umem->users, 1);
-- 
2.45.2


