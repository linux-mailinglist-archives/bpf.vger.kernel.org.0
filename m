Return-Path: <bpf+bounces-54805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED0A72E0C
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 11:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB95417A3D8
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE49211466;
	Thu, 27 Mar 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc/A5T/A"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1B20CCFD
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072279; cv=none; b=nOnsmf4NocOrxcuVKfE5ffkA9adVlPOHmhMIl+ikRixNolE8laNyYuofBDJOJQkHOxz38BP2kBdYQjHe4FxroGUk7NeM/8bdd6mODQdwrLaiKQZkp7op7v5y7e6yDVUWEf+pMMmnfjLMwyp+Ada5R9K4+VX7ZyQkQd2DX3+7ceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072279; c=relaxed/simple;
	bh=jU4n6IWZA16UVAMHXvziKTv++8RigMQc/gkO65H7mmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9W3U/EO2yYTtZnB8zEIV7TgxQW41PsSC2HPhsW7WlN4ncznednDQIB582WQdEI7vxQboR5/U3tlWNPx7zaxn0lgY9EaCgU1mrQQOXEGegczvDMysBfe4hH++bP/0khOziItcB8zW7+qCRE2DXeWIYOyxC0I5SaD+fujT6MLk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc/A5T/A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743072275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9t4W5dGLSES67cAKB6/mNTM9c41OeoyQ+4Jai1EE1rk=;
	b=Xc/A5T/AyHYyqqSWETK7SKkQih0DBsWMD/RMNVlf/xB/sef9jeeavHkKWOvI9RvYV8lXJl
	gmyaSAlnnFDtcEq6IXgLgdWgCVmxHvXgtAC5/NR4YTxN3d4EV9PjNh3jO49lJ3e0hOR5ct
	M01k3FDabqqoQNiOfVUWNbtLwIWhKhQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-dYxMwqF-NgCN1Qnmx415zg-1; Thu, 27 Mar 2025 06:44:34 -0400
X-MC-Unique: dYxMwqF-NgCN1Qnmx415zg-1
X-Mimecast-MFC-AGG-ID: dYxMwqF-NgCN1Qnmx415zg_1743072273
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5eb195f01so777523a12.1
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 03:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743072273; x=1743677073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9t4W5dGLSES67cAKB6/mNTM9c41OeoyQ+4Jai1EE1rk=;
        b=ryoH3Q+/WyDl69+xrKdIVtUkEvgxDpOVsy2mX4GHIc/nUHV3sRMXuT3yySndShQlif
         s1MFC8Lxr24TVfXh5AId3zJSoZQuV+Vqar77rv///KZ7jMSILKljRdpMIAN7bFoFpBn5
         VHvQFKDNNSAdxp9nTsvGbLrFFBge1x295FqGz7CzqT8Cz8jjVejjM8Vu0RzVRVq74vAm
         H166X/TF2Cyt+wVr9jknuMOasXkCL5ULGpgiz2MRDN2Xa9XYBRcfeaMTZlZNmd8Ksuwe
         IppcofQtl4PASeRwH1BB4QIDVBe8mKKAHymvsOheBykvNQc4Dqa8lQS7ZCCGr+u55u4l
         8OZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrbv0/2iRS0ErVVOo9AB2r879pI3lMHaKXn6wRj41n0U58fY3xCzxF35cvN0qDy58QQL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxWv8edVYKt/urcVhwe1lz5czTVeq/mzVkaYuZ54wPsdEQD2Z+
	TupUjRcF0O6sdhxZra2pc2+0RmX7HHyshZjZSO52+RGRjmcI6rwsW3Jp/MoGFaFrC1pVW3PfpLc
	GuIRF+14oU0XgVdNfekYCI8BL9g5tL2fXPtRHHcc10/h7LlVrMA==
X-Gm-Gg: ASbGncvx11ssrKlb5TRlAuOI843OzAyvVStmaCYDLlIvrKnGVzpy8jSHMHTJ25OjbKZ
	OuoyBFQKtE/P8vjWwjUYNzmfikHH6EudB6Hq1sO21I5jC9k5GiDPz4qClCQsNX54hPlxvO4jICN
	AFosOPFsH8kvFHzj7w6MGqrsNQyfEcopgNd9TFZ8ot1bKls2P02CFihsbtebmSeEoul2K5/FWeA
	5XUIzunMaByyfqEN1xfZb2KQRbTgHnstOpJ5YqiTJF+PbP6ST5Eawhzhz10hc1mgAfRYLyofDoF
	EqtXAwQCF+eq
X-Received: by 2002:a17:907:9445:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ac6fb0fd646mr282330766b.37.1743072273063;
        Thu, 27 Mar 2025 03:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5W/lqNkHafWShe6vkN9vTaP1afnDzl/apRQY9StJ2QLIsUkjICNTeJVHXqSm6f8TF9xUcTw==
X-Received: by 2002:a17:907:9445:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ac6fb0fd646mr282327066b.37.1743072272623;
        Thu, 27 Mar 2025 03:44:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd45594sm1193278166b.160.2025.03.27.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:44:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B20B918FCBFD; Thu, 27 Mar 2025 11:44:30 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 27 Mar 2025 11:44:12 +0100
Subject: [PATCH net-next v4 2/3] page_pool: Turn dma_sync into a full-width
 bool field
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-page-pool-track-dma-v4-2-b380dc6706d0@redhat.com>
References: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
In-Reply-To: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Change the single-bit boolean for dma_sync into a full-width bool, so we
can read it as volatile with READ_ONCE(). A subsequent patch will add
writing with WRITE_ONCE() on teardown.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool/types.h | 6 +++---
 net/core/page_pool.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index df0d3c1608929605224feb26173135ff37951ef8..d6c93150384fbc4579bb0d0afb357ebb26c564a3 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -173,10 +173,10 @@ struct page_pool {
 	int cpuid;
 	u32 pages_state_hold_cnt;
 
-	bool has_init_callback:1;	/* slow::init_callback is set */
+	bool dma_sync;				/* Perform DMA sync for device */
+	bool dma_sync_for_cpu:1;		/* Perform DMA sync for cpu */
 	bool dma_map:1;			/* Perform DMA mapping */
-	bool dma_sync:1;		/* Perform DMA sync for device */
-	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
+	bool has_init_callback:1;	/* slow::init_callback is set */
 #ifdef CONFIG_PAGE_POOL_STATS
 	bool system:1;			/* This is a global percpu pool */
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7745ad924ae2d801580a6760eba9393e1cf67b01..c75d2add42b887f9a3a74e3fb1b3b8dc34ea72b1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -463,7 +463,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 

-- 
2.48.1


