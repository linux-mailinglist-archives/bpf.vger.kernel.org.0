Return-Path: <bpf+bounces-22080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682885644B
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 14:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC85F2896FA
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704A130ADD;
	Thu, 15 Feb 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJ5ovC8y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404212FF88
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003604; cv=none; b=i1kJMBjxxHiR7UbT88f1oemAiw9xwpobbqHHRkf9wUKDTcKXH9hgWSmO3Q6ETLKLGzb0XRjqMGVdv9X2e1YKf8XHjA3b2tpW4atV9YVo+mhZQfzFoQTvd7aR74dIvmqMHE9XfXeRd+NZNnf+atu5fKCQEQ+185alhyFZkh6iUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003604; c=relaxed/simple;
	bh=z+o5iOnXAyRBzVGt5Tc6uCVeHlkYoqCfK8Ac6jiEb6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avG32fwHpTIhksHSPsffE8IyxF+iBlCZTFM9yYYkJmp3H/NSlegVoIRI/EZoAsVU4CSwRJj3tRTKsRJCUCRRyOL/+jfu0dUXEs/vZiiGD3VwVgorq7LLvQFSTwAwNRIB8x9G4nR9wN3sO2AgNMM19Q46V4UQFZTkCNpxmAd+y78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJ5ovC8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708003601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tv8iEvuALyULMFKYPzlVkSrmB4LE1yRmY8GywglSPNM=;
	b=aJ5ovC8yhtUd4LaTAWMXJwBIRoM0UGP7N4V2LiyM1ugPcrIGCrB8YRQMDRJO1ocqA5+FU2
	+wuzwZJ/wxNXHk2w6Q2YBmdIjmHE8c8k5WiNYzsc1678ltoFjnpEOaxEQHfZOPxnPsYiuA
	GT4WErhu0yPHU06J8I0lr9KX389QBsI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-gKNbBUZ6ND2KH7AIDBZVDw-1; Thu, 15 Feb 2024 08:26:40 -0500
X-MC-Unique: gKNbBUZ6ND2KH7AIDBZVDw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-559391de41bso639172a12.3
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 05:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003599; x=1708608399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv8iEvuALyULMFKYPzlVkSrmB4LE1yRmY8GywglSPNM=;
        b=WSBNQtTe3YQhRShS2oUAi6Jvvhu6U2vZShjSZw4Io89qM3rb6VkSj4igI3nRqMp/Zl
         jyzdnvw2WEy95l8EZBX5pCaPoAoIXtZyg7rAQF01WueEMJhRec2XhUKxWT1yzODASqT5
         cf3S5VWv2gB8enQyxb+uZ83GV5cQ9dIOrt5IE2/1CUTe2lpC7neLIoFI+qo3R8hior1J
         rLmBl2Y+Hk4wzyrcwuoBBlRFQEAqvtzPjPOVVzZCa5VdTQaV0zSScolPyIOBKeer5qx8
         dmXsSLx+vmtjQzOKUqA7KZR9hnYvQWJx3ji5UDd6VbxB+ju69+ZGY8xiyNn76L9/OjAb
         hYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1raaBXvoDpaHE15LsBzhsNS8XAi6DxUIT1GcPGuA0NGGl2MVc52wFIDgF/jpnhfjhjbQJX4M6BXKrBPo6QDynxwVj
X-Gm-Message-State: AOJu0YyTuYUB4zTCVHpBZyKDJWt2TEUmGbQITwRsE8nhkgL5TNN1zViX
	dfJjokqG/wjtN1kzfcD2i0lF6cJRidGFI7Va4CaKWnJlRjSaXQ+X20CK2DvoGYYxmsoi9ab0mSZ
	+BDblAQf5uExjmlTxkTHI57QMcvF5gVUFt5ODdPUfMl2Yw3+eVA==
X-Received: by 2002:a05:6402:1a42:b0:562:71:8105 with SMTP id bf2-20020a0564021a4200b0056200718105mr1175805edb.11.1708003599257;
        Thu, 15 Feb 2024 05:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPf/ND7jD6kLW9EkMyz5hznD/WCdWi9FJ5Pk1ElHBJ0YDMzOQcRFnXqZQMypPf5OuMvSf+UA==
X-Received: by 2002:a05:6402:1a42:b0:562:71:8105 with SMTP id bf2-20020a0564021a4200b0056200718105mr1175796edb.11.1708003599040;
        Thu, 15 Feb 2024 05:26:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id de8-20020a056402308800b00562149c7bf4sm534659edb.48.2024.02.15.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:26:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 025BC10F59B9; Thu, 15 Feb 2024 14:26:37 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 1/3] net: Register system page pool as an XDP memory model
Date: Thu, 15 Feb 2024 14:26:30 +0100
Message-ID: <20240215132634.474055-2-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215132634.474055-1-toke@redhat.com>
References: <20240215132634.474055-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To make the system page pool usable as a source for allocating XDP
frames, we need to register it with xdp_reg_mem_model(), so that page
return works correctly. This is done in preparation for using the system
page pool for the XDP live frame mode in BPF_TEST_RUN; for the same
reason, make the per-cpu variable non-static so we can access it from
the test_run code as well.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c541550b0e6e..e1dfdf0c4075 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3345,6 +3345,7 @@ static inline void input_queue_tail_incr_save(struct softnet_data *sd,
 }
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DECLARE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
 
 static inline int dev_recursion_level(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index d8dd293a7a27..cdb916a647e7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -428,7 +428,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
+DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
 
 #ifdef CONFIG_LOCKDEP
 /*
@@ -11739,12 +11739,20 @@ static int net_page_pool_create(int cpuid)
 		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
 		.nid = NUMA_NO_NODE,
 	};
+	struct xdp_mem_info info;
 	struct page_pool *pp_ptr;
+	int err;
 
 	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
 	if (IS_ERR(pp_ptr))
 		return -ENOMEM;
 
+	err = xdp_reg_mem_model(&info, MEM_TYPE_PAGE_POOL, pp_ptr);
+	if (err) {
+		page_pool_destroy(pp_ptr);
+		return err;
+	}
+
 	per_cpu(system_page_pool, cpuid) = pp_ptr;
 #endif
 	return 0;
@@ -11834,12 +11842,15 @@ static int __init net_dev_init(void)
 out:
 	if (rc < 0) {
 		for_each_possible_cpu(i) {
+			struct xdp_mem_info mem = { .type = MEM_TYPE_PAGE_POOL };
 			struct page_pool *pp_ptr;
 
 			pp_ptr = per_cpu(system_page_pool, i);
 			if (!pp_ptr)
 				continue;
 
+			mem.id = pp_ptr->xdp_mem_id;
+			xdp_unreg_mem_model(&mem);
 			page_pool_destroy(pp_ptr);
 			per_cpu(system_page_pool, i) = NULL;
 		}
-- 
2.43.0


