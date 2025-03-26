Return-Path: <bpf+bounces-54739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00BA71286
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 09:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3043ADA4B
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C11A0B08;
	Wed, 26 Mar 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNTBkGM/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED471A3148
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977152; cv=none; b=cxb5c4vfRgBmbqEK9T4ad7PSV60axL3MbI+L624LVrYqbzERSBMbROjURf1QPnZ+mrIrJgtGH63k3ZROzMxG/CbtKyqy00qz5Yud30vHItyDVKE/kkJ/bXlr4X8mILnoPCGpWMcqEEHO2CYVwrr9HUTokvUUpmJJ+1dnlEEJ8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977152; c=relaxed/simple;
	bh=vSoD9pwpfcSbP4dGBoxGCSAK3A6a6LNtloWC3DjyTGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7DIlzBRIAsav5D5VOEvABEt1ARTYC9/iodVpO3E1Y67NlXHtXWJbF0wW/91an+E61ubasBEwlMubjyTtfxoj0zfDOB/XRex8rYfA03ga69ApkPM8WGJohcL89H0mx2/+z8xrUMcTCjT76VhNLtQIOgU+GrFeBb/OCY5FUhihsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNTBkGM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742977149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOTdxZD/uqiBEKSTfpgx9RU52PQylymJns53moyygZc=;
	b=MNTBkGM/Evr7ZSfEbjKyTbW0cCRlJAWrMmARFRzeoDt0HtKUfAIG5EGAaY1R8kMAMc41ku
	WFSeqHIS8rOy7SdO1+OVlz2GCh00rXXaeISweU4hJ481IelRkXk1J6P6bwYe2/bR0RQFxo
	RhMR+3LBf79wCcmaOYNXu6Ra09ndK/U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-qrtkpRlePlOEjmuTHWhn5w-1; Wed, 26 Mar 2025 04:18:59 -0400
X-MC-Unique: qrtkpRlePlOEjmuTHWhn5w-1
X-Mimecast-MFC-AGG-ID: qrtkpRlePlOEjmuTHWhn5w_1742977138
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e82390b87fso5353562a12.3
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 01:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977138; x=1743581938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOTdxZD/uqiBEKSTfpgx9RU52PQylymJns53moyygZc=;
        b=Pd1WGYJL4wmezihtofGu/25fv1CgDdik3A1roDZU3TCx+4HkaoZBfoPC6J91BE1g0w
         XTtTOqV7UrHWPNkiccCmqhHopXMW6QuKvoB4hnNlMrT4Z4xrzWATjr3FWdGuRk00cdZF
         zwiFfy/kIKepOvSuCQRVOawco3IKQs60OL8rAkiZTQlrWz58tV3UYGXdSGnCqk5Z6gOn
         jKUce47O2L8dqg9XjVoU1Dn020Ufjim+pGbczLPSFKQVoqLZPbS7b5jySVSr6jub5yvA
         xOwRqMv6nKtLKJ64SoeEgsjhSX2UYDUyzT7lS4G3XhrEALjzujK94HRznW1wSYww5750
         RtVg==
X-Forwarded-Encrypted: i=1; AJvYcCX18cOGpV96TnsHd0ZCtzr1r6KxgH80bFCUNgNddTXLwVZ1JH2O2u/klsQzfEOle28DFKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0QViIbzxvLNPecA4qgLmo3CyNdHDYABkkuEMaltyEvvtNSX3
	mRiKpPe20ecKipCi5HAmlcgoEHT9rbhLiURdw+ADp93BfpXxEvPX8+cx71PwQa3BIpUvHCbWMUc
	2Mr8whrA61maiDZeQvIX0ZGi+Yzn4UAyXQqo2xKPBNXmWJc2gvg==
X-Gm-Gg: ASbGncsV5y7UDaPRAun2xxtI3PS/+obgs/uCSJdwZey6IwaWsdGgOF/JzZ5fFICW37a
	mFzaRsnyCmYtjyfPM+AgMG30XxB0MHBHR2UHVZFrF2ms2lbdYFNlITyfQfw0iJ+A26mvpj+DaZy
	F8OG150PZsKyq3Z9LpKq05WeIu/ivxVfUAdxe3Uf9ghJsOxi3KHMlAH1mou85Szc4JSBEf82Zdy
	CAelNAd8X5xJ+xjfIgwDnv8i2Mo8deVb2rMnbM362ZDXE70QKdKulOt7kRXBK6u0TkM8R4ZzZkE
	RciGXQbNrEVudqf/cxFQTSjbpar0I30BRtHQnphe
X-Received: by 2002:a05:6402:2345:b0:5ed:1909:d422 with SMTP id 4fb4d7f45d1cf-5ed1909d5d6mr4532642a12.2.1742977137789;
        Wed, 26 Mar 2025 01:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbdeo79z8qV2b7AKSc5yQktiHryMqsZHBcfBd1BlUWJgmAJ39Ce+nU2q92PUFekHQpyPfq7Q==
X-Received: by 2002:a05:6402:2345:b0:5ed:1909:d422 with SMTP id 4fb4d7f45d1cf-5ed1909d5d6mr4532610a12.2.1742977137314;
        Wed, 26 Mar 2025 01:18:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfae189sm8870097a12.37.2025.03.26.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:18:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5291A18FC9CE; Wed, 26 Mar 2025 09:18:54 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 26 Mar 2025 09:18:39 +0100
Subject: [PATCH net-next v3 2/3] page_pool: Turn dma_sync into a full-width
 bool field
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-page-pool-track-dma-v3-2-8e464016e0ac@redhat.com>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
In-Reply-To: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
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
index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..fb32768a97765aacc7f1103bfee38000c988b0de 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -466,7 +466,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 

-- 
2.48.1


