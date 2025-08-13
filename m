Return-Path: <bpf+bounces-65507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44BB24853
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A1F724214
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362C2F1FE2;
	Wed, 13 Aug 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNPBd8HS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C912B93;
	Wed, 13 Aug 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083862; cv=none; b=becUVrBpZAH5vTYqWgeR4G+NNA1Wwq7z36zGmu8+a8Z8rVRXp1p+zmoLe6ccVwWM0Sxu17x3WJ0HQX8HRAcwXcKVax9gzzsh/uMXJNqjwn+fLmQGH2CTTGEzFxWu4E5XBopTWxxrYLZgUTB3iWSU4iN99ktLeTzGhp9aoqyjPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083862; c=relaxed/simple;
	bh=eVoP0GJ+9HmCfKlC722pmE7GPahDYY96hNhGD7nU1UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCwqsgZgVfVSP4RB5gL9UtQq8oztMlrZw7NG5jxWkrgqnJ7vx3otgAVNbnL1FSPS5KhCj6T1CS62NXq0pUVPRY4I1XAK9QIk7YnfSDSawxScuE6r0QZ65HrzixJ0HyLHB46mct+aNIMSdElxuPVf0qWemaM9w/OW1YLax1PX4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNPBd8HS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so6591503f8f.1;
        Wed, 13 Aug 2025 04:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755083859; x=1755688659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlWkB4mdDNZC/cn5UpFz36ZU1sYh8iUkH7z054OQZUg=;
        b=QNPBd8HSFE50n1p6eQk4NEL48dEMf+1qTHV5rrJZIC3x/LnSzwSKeFo0A9cS+eye42
         B+pJC9N/TY50wmaGV4BXWtXgt3MameR2tw2lfxOvn3VZQXF5KPv+1eN6QUtbO+KpcbAD
         xMQlMYHywDM5SjazA0VJR+yxZn0gSQ1mjgcjQ7+li8VTc6pwYLHefaDfs19WUxz7gtCC
         ddLrmA5V4cL9NjHMGwDfd4VRdAslmfHz7rSNl9aLkuWR2GyPpEVPjy/hQ0V01mpNIFDq
         kapq/MO43hPlGgWf8woqLXlEa47TwASagUdYriqJSIqQTOODo3feJIPoXFF74Fsml5zB
         sYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083859; x=1755688659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlWkB4mdDNZC/cn5UpFz36ZU1sYh8iUkH7z054OQZUg=;
        b=eSfa41P4nNuPRS7TVLGzLHWnH3/qZxKedfLb2/BiNZSchtIv9Bryg3nndlehOIScN2
         lDgPf7C/GZd9V0R5g6z5Q0mMPO5ngMB/wS2ORMsEsirKQHl8/kOHtZEd7gAqxz6sC7wS
         ERc0B6MlC5ijGi/F5CxVHfFRsFDrPtKDUoogxWI4NDpi0k95aVxB/VksA0AALtsPBopy
         i6M05sqc6JfT2bk41slAWq4dan3yiq7qrBfZF46DAEsqF0qYU7k7QcSNdfJIN03PH+vb
         uk7LIlRTXwyx90VGReSm3a9uTrAXPr8zjWo44Ythw7HUnUPLqVWWiEkyseyI8N9KzJ50
         xIpw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ36TDoP3T9RMSVUlUOgpuRgKMMI4kUL5jV5TEJf50a0Dx99dHj8Co+D0gq2FVLfawFLJTuMrf@vger.kernel.org, AJvYcCVhJeeCwR8sFk4hw5yX3eZzFNqUS36xs+uk+pEHQ4jOj3mOdwvJL+uQAAzzaxEESxZd7NIoqjQmykRQtA==@vger.kernel.org, AJvYcCVn3R8dROKKkPuMgVE5d3EwzcK8C3/6bh+0mq+UZoVaYuqCea3xd66W4BXk3y1ba1BakIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfJGBCDSB1FEyG1RakuUXv6r0f8jghU5+7A5gNdUA0XGfhslr
	phmJPJvbIc2BoGYM9hbsXCSecXnpgWriDCbWWf9s7vV5Og/1PwefuAqR
X-Gm-Gg: ASbGncteJXgftMNCzhie3vOMBcuLxltBHRY7mat/UPL/3/HJ1ujHPh8kg0YsLAR9TFQ
	76VTEmuj09ChDLpD98PC8XZ3pGPG80HeJ6fdZbgX37Me5DKU78kFro3CNBaBU43SH+dxAolC3Jm
	vpioTsRPtDh2osfK6UGyg2zTarEaaIQXZGGWChTduD7OvrYbhn6McxfS+dFgL5PN5Z/xGNMx08t
	CsZTtZuVqZ75Eeujr1RyyYoRne7C1LmXTPVhddq3BJhrP+/sTb2hD3+85iZ4DWeNspfVN3Ot+uN
	jmvdXLptnGrWLb+C9ojIIA9xgUAAbhDxMgv7y7+zGs/heMU2x7zej5N0Tw8/vvZGdtnQ16tWWtw
	V99Bj+XTjsFGJSd8RTxEIU7qr8zf0xLmBmyk=
X-Google-Smtp-Source: AGHT+IHIJckFdgjZWss16Tz9qU5LS3EozEf9NXM4Mc+MLVLT3sIzNz2MSxyepzxFt0CjL8IQUdHUsg==
X-Received: by 2002:a05:6000:178e:b0:3a4:e68e:d33c with SMTP id ffacd0b85a97d-3b917ec3ecbmr2043703f8f.47.1755083858415;
        Wed, 13 Aug 2025 04:17:38 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:aa85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b90d147485sm9666355f8f.19.2025.08.13.04.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:17:37 -0700 (PDT)
Message-ID: <6bbf6ca2-0c46-43b7-82d8-b990f01ae5dd@gmail.com>
Date: Wed, 13 Aug 2025 12:18:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
To: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org,
 kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, linux-mm@kvack.org,
 netdev@vger.kernel.org
References: <20250729110210.48313-1-byungchul@sk.com>
 <20250813060901.GA9086@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250813060901.GA9086@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 07:09, Byungchul Park wrote:
> On Tue, Jul 29, 2025 at 08:02:10PM +0900, Byungchul Park wrote:
...>> For net_iov, use ->pp to identify if it's pp, with making sure that ->pp
>> is NULL for non-pp net_iov.
>>
>> This work was inspired by the following link:
>>
>> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>>
>> While at it, move the sanity check for page pool to on free.
> 
> Hi, Andrew and Jakub
> 
> I will spin the next one with some modified, once the following patch,
> [1], gets merged.
> 
>     [1] https://lore.kernel.org/all/a8643abedd208138d3d550db71631d5a2e4168d1.1754929026.git.asml.silence@gmail.com/
> 
> This is about both mm and network.  I have no idea which tree should I
> aim at between mm tree and network tree?  I prefer the network tree tho.
> 
> However, it's totally fine regardless of what it would be.  Suggestion?

It should go to net, there will be enough of conflicts otherwise.
mm maintainers, do you like it as a shared branch or can it just
go through the net tree?


It'd also be better to split mm and net changes into a separate
patches. A patch I had before, it might need a rebase though.

From: Pavel Begunkov <asml.silence@gmail.com>
Date: Thu, 17 Jul 2025 11:46:21 +0100
Subject: [PATCH] mm: introduce a page type for page pool

Page pool currently uses ->pp_magic aliased with lru.next to check
whether a page belongs to it. Add a new page type, a later patch will
convert page pool to use it.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
  include/linux/mm.h         | 20 --------------------
  include/linux/page-flags.h |  6 ++++++
  mm/page_alloc.c            |  7 +++----
  3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0d4ee569aa6b..21db02e92b33 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4205,26 +4205,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
  				  PP_DMA_INDEX_SHIFT)
  
-/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
- * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
- * the head page of compound page and bit 1 for pfmemalloc page, as well as the
- * bits used for the DMA index. page_is_pfmemalloc() is checked in
- * __page_pool_put_page() to avoid recycling the pfmemalloc page.
- */
-#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
-
-#ifdef CONFIG_PAGE_POOL
-static inline bool page_pool_page_is_pp(const struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
-}
-#else
-static inline bool page_pool_page_is_pp(const struct page *page)
-{
-	return false;
-}
-#endif
-
  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8d3fa3a91ce4..0afdf2ee3fbd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -933,6 +933,7 @@ enum pagetype {
  	PGTY_zsmalloc		= 0xf6,
  	PGTY_unaccepted		= 0xf7,
  	PGTY_large_kmalloc	= 0xf8,
+	PGTY_net_pp		= 0xf9,
  
  	PGTY_mapcount_underflow = 0xff
  };
@@ -1077,6 +1078,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
  
+/*
+ * Marks pages allocated by page_pool. See (see net/core/page_pool.c)
+ */
+PAGE_TYPE_OPS(Net_pp, net_pp, net_pp)
+
  /**
   * PageHuge - Determine if the page belongs to hugetlbfs
   * @page: The page to test.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..67dfd6d8a124 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page *page,
  #ifdef CONFIG_MEMCG
  			page->memcg_data |
  #endif
-			page_pool_page_is_pp(page) |
  			(page->flags & check_flags)))
  		return false;
  
@@ -1069,8 +1068,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
  	if (unlikely(page->memcg_data))
  		bad_reason = "page still charged to cgroup";
  #endif
-	if (unlikely(page_pool_page_is_pp(page)))
-		bad_reason = "page_pool leak";
  	return bad_reason;
  }
  
@@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct page *page,
  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
  		folio->mapping = NULL;
  	}
-	if (unlikely(page_has_type(page)))
+	if (unlikely(page_has_type(page))) {
+		WARN_ON_ONCE(PageNet_pp(page));
  		/* Reset the page_type (which overlays _mapcount) */
  		page->page_type = UINT_MAX;
+	}
  
  	if (is_check_pages_enabled()) {
  		if (free_page_is_bad(page))

-- 
Pavel Begunkov


