Return-Path: <bpf+bounces-60688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A469ADA24A
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8118903EF
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036A2690ED;
	Sun, 15 Jun 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euCHD4Vv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF625D21B;
	Sun, 15 Jun 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750000490; cv=none; b=bYpJ3t6HN1pejR8slsQ5nWM7QcLRS5d27ZCKCb6kTj6d3fw0LemtwHAw3iHzgtMv3LWs3FLeLq9L497P2fYcs/inz71RVK44kFacFhnOBhQMAieDh/aKpRxuOrg9KUiRCoQdK4DD8PSUfFXdPbS5k6rVsgmIJl0m79W9CQRbbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750000490; c=relaxed/simple;
	bh=HVGg2b4dETfvRRMS1KObnnYIH8VqBEDJ75o3UiizCng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQGaeakgq1XbIVnrvwerHTCUD9Pp+s51pquVNO/wQPC+WIXv00XSJqti6h4WrMb7mD0dVC6G7bcODfHZq63WzMjM+/Q9e6zTnEJ/DyhPUKKnzbUtLiveO+jDhWMevcBNj93z1BcJ7rVpgZQbGl2RXu80s//dN/+leM6U6m710z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euCHD4Vv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c035f2afso2449364b3a.2;
        Sun, 15 Jun 2025 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750000488; x=1750605288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2XHfduxkI50goUmbRh0tLs3//lxjQzHdD0tvUgOrco=;
        b=euCHD4Vvzxn2H/1vH7GtH78H4Rg7sqhLxlaRT4QQCrIsNRkTZ51MNMrxdG7SEsJ1Jr
         DRvu8MYJDHbYdYQDGSfOLFduiJBph4rIcc1NN2rXn/ha3iK8CqXPK8GEu5Cy4UlxS0Je
         kRJOC9z4haB9Toeuhc/wU3y/QjlsG0Ex3wUEZAdhlZs7HEJ6jp5LwWNmrB6gjtnuR8tI
         Tfs0bfJexCAH+qoCdTocy+58l7DCEIH8INf/mLozQYgG0ZBtJBVLq1q7gYIKo/LYMPGq
         3hDqflA9XyYsLMQ6hH+MI7VCbMp9OyCs6RGqnOX8jbhdB4fzqsy7ElBsHVmm1uBikRvG
         rPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750000488; x=1750605288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2XHfduxkI50goUmbRh0tLs3//lxjQzHdD0tvUgOrco=;
        b=q7TujhO7uXSpxqMcyE3kQxMrYXf91G43kVAdovKazTNuJ+bpZ/G8gIob/YzBIyP1qc
         TrwXaIxY4L0821fqaCW1b8xS1bW57+3iulG8C786tO7vEgvNkjbMkR9akMf0e0CSCucO
         wUWwTMjS2i8sMOmvRWziQudQjAKwiGDbaKpbog09xztG1s3xge5Aj2AcD/Hq3QOgfh42
         +CCd8s70MvZgQSNb0Bgz7F492SYMOzv5A4JYuwS9U1oBbLlntzF2T+9E9od9FyW3uuph
         f0C0Mf1oeklbL+xwSoeAGwqQMTUem8vZmU0a8/b7Csohs+op9Z1vPJU3o+74M5bq9F8c
         xi7g==
X-Forwarded-Encrypted: i=1; AJvYcCU8dap7hsELoPfSHNY/6CuYUK5SD0tsvoKzLgjiCsZHx8AAeTIAPbgtl0T0+RsO5Acx4DokeHX8zFFfU7vJ@vger.kernel.org, AJvYcCVFfnRmXEGx7rpPcjvfr0ujiOm7/TJK9S+OhDu24ST9Q8lE3mW4/9h1ECG6VzP/4sTOxd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzp0ZwzJH1L6b/uxnBc3kNfTpWDjZ+sbk2+PlN5zp+65lh9fYh
	y1QCuACr32sPiWTws3fY9mpCDNfmI5anDI6Es1glP32LYcRrMFLsbwKHfB6a2g==
X-Gm-Gg: ASbGncv5c13SI20L0PgsYGsj5A52NR7QDNVXysBcg0cPuv11Fq8CBDw+C+nMGGSwC7V
	POn1hbtX2MpH6YNSGmbuHGVSVTPFKHbgJYvcnavZnMNUdyQ45zO5f8TEhr5pr173o3QjGlmJQR2
	6g/QNhMNGudzN9xqFAK1EWd/ElW5yIC3q4rKxyt/FhqvP9OagPJaDIvartwqIBm0COT7054/5GD
	Ok2HCA6GXNv0FvpBTk/8J9y2xKlTK8zmUuGMwBKRM3lxwMECvN4K3DLY5SrAsXbwPqZCu7ABKKV
	HsPf1QwOJIdKZky2pbhtHNMYIdTYmAp7nnhc25FJDjUOYTXidgNy8DMFvhFRLrAc+UWBasl84Pj
	A+Q==
X-Google-Smtp-Source: AGHT+IGq1OjC4mhUydkSvko7Z0RIr7FJnfDd6BfxHT+hxc75Ge2cUYCLom9mvffce4tass46LGxFYg==
X-Received: by 2002:a05:6a00:b8b:b0:747:b043:41e5 with SMTP id d2e1a72fcca58-7489cfc785cmr9029961b3a.16.1750000487602;
        Sun, 15 Jun 2025 08:14:47 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:482b:a929:1381:df12])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-748900b219csm4950022b3a.129.2025.06.15.08.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:14:47 -0700 (PDT)
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
Subject: [PATCH net 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Sun, 15 Jun 2025 22:13:33 +0700
Message-ID: <20250615151333.10644-3-minhquangbui99@gmail.com>
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

This commit does not do any functional changes. It moves xdp->data
adjustment for buffer other than first buffer to buf_to_xdp() helper so
that the xdp_buff adjustment does not scatter over different functions.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7c9cf5ed1827..678502aefddd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1167,7 +1167,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 		return NULL;
 	}
 
-	xsk_buff_set_size(xdp, len);
+	if (first_buf) {
+		xsk_buff_set_size(xdp, len);
+	} else {
+		/* This is the same as xsk_buff_set_size but with the adjusted
+		 * xdp->data.
+		 */
+		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
+		xdp->data -= vi->hdr_len;
+		xdp->data_meta = xdp->data;
+		xdp->data_end = xdp->data + len;
+		xdp->flags = 0;
+	}
+
 	xsk_buff_dma_sync_for_cpu(xdp);
 
 	return xdp;
@@ -1292,7 +1304,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0


