Return-Path: <bpf+bounces-63118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D11B02B15
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BFA7ADD92
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD93278E40;
	Sat, 12 Jul 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjUfHVYN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B37278750;
	Sat, 12 Jul 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328621; cv=none; b=KDM8wtj9dY+wTxj4DiTZWDlWDnvpWhcHNnYo9XHESro/W4wZWGbGxl8qVtXzMHTqQakEAqefXk5tsbkSuVkPl/DoC9fztC08R7ndLC3MbcqY+FbN4mwu+hw+anU+TA7MAz86nIQ8jVYm4sNTBOqdImLqDBNhuJBN0Gm3CDHGseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328621; c=relaxed/simple;
	bh=mgsx5jC7xnI3Zxh5tPhOMQw9jgbuPq6Xaw6JfhhLOKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f71mmlDxepQC9WwbYuKEbn27yDK96zzplAtqxpneKJaB0oJbD3ydeUAkEBAC52vRF7bSXcMNXV2iMrZGMTCNXaG+sz46ggSYNtlhHARRZEZVeVVTbXgfm5iA1NoRRCfr14YSTt/YdznUiemd4VNSpTD4MwyIn5MtwZ11uFKl0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjUfHVYN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so607674066b.1;
        Sat, 12 Jul 2025 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752328618; x=1752933418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWT0gpnYa11KRjN6//9ilbj19qNJCuSNe5kuXlg66Eg=;
        b=jjUfHVYNG/cKdX3ZHWXgJd02BgG04780Acja2xKXPhu9MFc7/9eMavUeNfv+tZC8fv
         ouILZoWHvikcHCKFE9iTjWkDhUGoe0AP+B8sg8utobw2ksqHtsPHRH3/fAx9zAutkuwa
         qe/6cf0DLdHSdsbygFDlKowFyzV4gHii3ncFVQKKvSuuycP9UbHd1cDEYDYy4DLt8eSf
         Fp0Eg25ZREqEHRDQQJuz23cloE9FCLz/+AFkWk6DnbSyOVCHmfmYwCce5Z0r1MTw5Aos
         moC2F+TKawL4AsI9GBpOpwD7dVsx4jWpHJArsbVQTCwpg+9yBwpNl8+BzJjAg2k0cBM5
         ZXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752328618; x=1752933418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWT0gpnYa11KRjN6//9ilbj19qNJCuSNe5kuXlg66Eg=;
        b=WxiiodYjra0yFctXDYqQZqgjIbgZ9dRqJRoZBZzY78KcCMYbJNiPhYXE/8/XpIr00J
         p/rnIAAHkiD69CuzaOgph1xytK4/TpjzVEUoenqulsg5TAvTDi1zqsgtWb9PIvutuZnj
         suVrf8Bf1HvnnRL74c+qfDqoWvFUEfVgBaSU7y1Jb/+UvnvbLHzDXO61SjmgRdRjdoIy
         b4F7tPofkXY2MrWpqtZlieB4wwy6ZnUjMhjXfv/v8eNbK4ZU4iQEvoXcUk1XUNbMCV64
         zd8t+QmBQpajS9Mc5T1mvwU8pizYcNwbU3ET4O+DnqD+C6n4YyeFSGPxzVV0Qt5suN05
         6B1w==
X-Forwarded-Encrypted: i=1; AJvYcCUDbKHZ2w6OjS2S0x7FQC/HLYFXBKxc6LUZf/D5yGQHwwhlN650EF5K7VdsxgB2TPHCWxU=@vger.kernel.org, AJvYcCUqgWaoziNVDYUxaGGsm/tNNN0t/TbG93caBl3/RQ91btA1327v6MM8S25Hdm+5Vv71KRAZQoXoylylsaBO@vger.kernel.org, AJvYcCW9nyray9g6w3am4oNhiKoFce7SSPs6eU2gYN+f1yLiXYoMq+FibrHxGILQzxUOlLcCLlI+5n1rONr/tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzupAwSmtApd5/pSk2gs5y7O/Zezct7M56/92XEUstwH+y49gZO
	54iTMdINOcIFfXIeYhUPK3melOJM5Q2IDFLd0rdAQ2IuHy85tvSEY8vY
X-Gm-Gg: ASbGnctroJncDZOfH+LnGIo8DSKaxcmtU3daKjXpvRcVEC/hHnU3O6Y/jXQ+vWTvqNH
	cSgCE7amjE1V9P54cOI2chWkO5n5IGw00XlJZfgAGGpC/7I0AlkFL7QVo3QbQjOBNW9NsUZ3UfU
	9pDcLhXfZotZXcK24BhtUwqgvWMMLBXOwvqLPp8+bQh3t23gvnxqVxPQdlLhMeVr5SpFQFyUuHe
	+agaFYzO+7Sh0PdUvhUQmYFjlsSfUKRsWqmxvnB3E2BZlbz/PzPvdHIL9tDACsE2HStZr5o7MYn
	kx7doRHPLEp8lyn6sAbOtiz4zBLtfaXjrkzyt93B6yzljq4oV9MKUw0YcI3vmb849x7AK9hib4J
	ascxumROP3jNTSR4phvYmp/smyZuixAKE/hY=
X-Google-Smtp-Source: AGHT+IHPBpXdo4+Kf06SYR/uX0tK1lNZqoC5zzneXzKAVwNs+13swe0gxWXk5ow4jkTd10LBb7qjpA==
X-Received: by 2002:a17:907:94c8:b0:ae3:74e1:81a3 with SMTP id a640c23a62f3a-ae6fca02479mr620885266b.8.1752328617862;
        Sat, 12 Jul 2025 06:56:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:b2ad])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826462bsm492380166b.104.2025.07.12.06.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 06:56:57 -0700 (PDT)
Message-ID: <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
Date: Sat, 12 Jul 2025 14:58:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>,
 David Hildenbrand <david@redhat.com>,
 "willy@infradead.org" <willy@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250711011435.GC40145@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 02:14, Byungchul Park wrote:
...>>> +#ifdef CONFIG_PAGE_POOL
>>> +/* XXX: This would better be moved to mm, once mm gets its way to
>>> + * identify the type of page for page pool.
>>> + */
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +       struct netmem_desc *desc = page_to_nmdesc(page);
>>> +
>>> +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>> +}
>>
>> pages can be pp pages (where they have pp fields inside of them) or
>> non-pp pages (where they don't have pp fields inside them, because
>> they were never allocated from the page_pool).
>>
>> Casting a page to a netmem_desc, and then checking if the page was a
>> pp page doesn't makes sense to me on a fundamental level. The
>> netmem_desc is only valid if the page was a pp page in the first
>> place. Maybe page_to_nmdesc should reject the cast if the page is not
>> a pp page or something.
> 
> Right, as you already know, the current mainline code already has the
> same problem but we've been using the werid way so far, in other words,
> mm code is checking if it's a pp page or not by using ->pp_magic, but
> it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.
> 
> Both the mainline code and this patch can make sense *only if* it's
> actually a pp page.  It's unevitable until mm provides a way to identify
> the type of page for page pool.  Thoughts?
Question to mm folks, can we add a new PGTY for page pool and use
that to filter page pool originated pages? Like in the incomplete
and untested diff below?


commit 8fc2347fb3ff4a3fc7929c70a5a21e1128935d4a
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Sat Jul 12 14:29:52 2025 +0100

     net/mm: use PGTY for tracking page pool pages
     
     Currently, we use page->pp_magic to determine whether a page belongs to
     a page pool. It's not ideal as the field is aliased with other page
     types, and thus needs to to rely on elaborated rules to work. Add a new
     page type for page pool.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..975a013f1f17 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4175,7 +4175,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  #ifdef CONFIG_PAGE_POOL
  static inline bool page_pool_page_is_pp(struct page *page)
  {
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+	return PageNetpp(page);
  }
  #else
  static inline bool page_pool_page_is_pp(struct page *page)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4fe5ee67535b..9bd1dfded2fc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -957,6 +957,7 @@ enum pagetype {
  	PGTY_zsmalloc		= 0xf6,
  	PGTY_unaccepted		= 0xf7,
  	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
  
  	PGTY_mapcount_underflow = 0xff
  };
@@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
  
+/*
+ * Marks page_pool allocated pages
+ */
+PAGE_TYPE_OPS(Netpp, netpp, netpp)
+
  /**
   * PageHuge - Determine if the page belongs to hugetlbfs
   * @page: The page to test.
diff --git a/include/net/netmem.h b/include/net/netmem.h
index de1d95f04076..20f5dbb08149 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -113,6 +113,8 @@ static inline bool netmem_is_net_iov(const netmem_ref netmem)
   */
  static inline struct page *__netmem_to_page(netmem_ref netmem)
  {
+	DEBUG_NET_WARN_ON_ONCE(netmem_is_net_iov(netmem));
+
  	return (__force struct page *)netmem;
  }
  
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index cd95394399b4..e38c64da1a78 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -13,16 +13,11 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
  	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
  }
  
-static inline void netmem_clear_pp_magic(netmem_ref netmem)
-{
-	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
-
-	__netmem_clear_lsb(netmem)->pp_magic = 0;
-}
-
  static inline bool netmem_is_pp(netmem_ref netmem)
  {
-	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+	if (netmem_is_net_iov(netmem))
+		return true;
+	return page_pool_page_is_pp(netmem_to_page(netmem));
  }
  
  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 05e2e22a8f7c..52120e2912a6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -371,6 +371,13 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
  }
  EXPORT_SYMBOL(page_pool_create);
  
+static void page_pool_set_page_pp_info(struct page_pool *pool,
+				       struct page *page)
+{
+	__SetPageNetpp(page);
+	page_pool_set_pp_info(page_to_netmem(page));
+}
+
  static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem);
  
  static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
@@ -534,7 +541,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
  	}
  
  	alloc_stat_inc(pool, slow_high_order);
-	page_pool_set_pp_info(pool, page_to_netmem(page));
+	page_pool_set_page_pp_info(pool, page);
  
  	/* Track how many pages are held 'in-flight' */
  	pool->pages_state_hold_cnt++;
@@ -579,7 +586,7 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
  			continue;
  		}
  
-		page_pool_set_pp_info(pool, netmem);
+		page_pool_set_page_pp_info(pool, __netmem_to_page(netmem));
  		pool->alloc.cache[pool->alloc.count++] = netmem;
  		/* Track how many pages are held 'in-flight' */
  		pool->pages_state_hold_cnt++;
@@ -654,7 +661,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
  {
  	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
  
  	/* Ensuring all pages have been split into one fragment initially:
  	 * page_pool_set_pp_info() is only called once for every page when it
@@ -669,7 +675,6 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
  
  void page_pool_clear_pp_info(netmem_ref netmem)
  {
-	netmem_clear_pp_magic(netmem);
  	netmem_set_pp(netmem, NULL);
  }
  
@@ -730,8 +735,11 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
  	trace_page_pool_state_release(pool, netmem, count);
  
  	if (put) {
+		struct page *page = netmem_to_page(netmem);
+
  		page_pool_clear_pp_info(netmem);
-		put_page(netmem_to_page(netmem));
+		__ClearPageNetpp(page);
+		put_page(page);
  	}
  	/* An optimization would be to call __free_pages(page, pool->p.order)
  	 * knowing page is not part of page-cache (thus avoiding a

-- 
Pavel Begunkov


