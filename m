Return-Path: <bpf+bounces-63164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B04B03D61
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2257E16D06D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29153246BD3;
	Mon, 14 Jul 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPL9N5gi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F62246BA8;
	Mon, 14 Jul 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492526; cv=none; b=k8MtPgNV4aKpe2KTKVB7lWy2ZwR/C5mLFgFIw7zcxBuHLtIBkuOMVHN5BeAbtGyWAuCXYL1A8elrPL0MWqIAOdVMFw9p8FkS2DQ0M63OTxopbIlxNfmReFzEjDiS8xDcjzm4Xvq7PFh6RIvqVe1sQ0WNtLWWiUbC9fElxXO34Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492526; c=relaxed/simple;
	bh=RMYHc+ObSPhtvgoU30+nhJ+/1B089yKqJDNHnPpfSiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfwY5XFxJToveMzNWwYzYcVFHVjWe0CGSjCxwVItaUUP33SEudN4Q1PWdBrKHP3CLo/50bvOfW2DkEsBqMd8lRDWXE2BOR00dENuTG2CowSSv5ilrXWaqBufjbXLFqFkr+GBRECemGU8hzqaaAUbshwSR7wLbOjyNrqEm9UNbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPL9N5gi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so6416048a12.0;
        Mon, 14 Jul 2025 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752492523; x=1753097323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpkZoh52U9bMTsE5g44NKcdh3S3DqEjKpM/aPLPBEE0=;
        b=KPL9N5gibX5O+tUK48aMohFtZT/mcibS2Zlm1quoFjd3cFKr39F5VMaizHGC07v+HZ
         tpnUaS1hbU3NBEnYxv542i5pqg2US6TgsVnCzgEj53Pmt9YkOYcavqxNLQjx35R+uMtF
         aXMQilUrUrGNHS6YypieRfnRxrgZPnxX6fAVdLC98DdoFFf9MG2tBKhuqJxEeu1+9xct
         6VSe3EGlkJJ/TSwZ2GVDaGp9GT1zTzdDYxqgoY74efp1q06HEiH4ruJ4p6WqAoqBLYIY
         eKxfQEzKU++JZeJwfVxeo1I8xW7NKnErJY1SYZ9CDwF4d2FIoGkjXqw1w0NeCyMwWdWj
         dMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752492523; x=1753097323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpkZoh52U9bMTsE5g44NKcdh3S3DqEjKpM/aPLPBEE0=;
        b=Q7Ts2Ch5QDghF+C1VQvI9Y9ZmOfWSD3QJzLBCmNPsMz/0Fl7iZRf6LQmKRpXGNCyrQ
         alA+UyuQhTJarlstrzuHh0KvQbtNJOtiG8kja4nAMDv8tM8vZI+7wfI2KbOYFIporylU
         TC9HRj0GP3jIoCV7PFkMBpTyBxoACNITv609P1mjRqOplCXyVchpEoiLHPFWR/ASXfG2
         qiVUg8iGJeAEVOkCc1AVPQH5ByBEXi5bte+B68OtDn5twz95n4HpqzRDX3VE8Y0Bb4Qp
         AYLbWnffZFwiQXtZpMgjvC59jSibm3wZxuDLsb/1nR4V6LjbFUnIn+CVG25Fye2gl28F
         EpZA==
X-Forwarded-Encrypted: i=1; AJvYcCU4UZEdXzAPwot845guHGfCSaKZB2gq07XzCvZw7S9E81uIGBmt+Ko6Ukepo7SBJdM7YAU47IHN7NgE/iqE@vger.kernel.org, AJvYcCVEJ16HFd68XuteIXjznKBTvkYmUjFK7hjbJR/JhHlFmVgpjq2ws864jEqvi1YlIJgaDcCjm2Uo@vger.kernel.org, AJvYcCWPaqA5UP8c6heecq26AO4BfFltzjghPgiK6dn/2Nw+iE2rvIxGq0GUJq6X5ECpbHDW3xAGq7z/zvsEJg==@vger.kernel.org, AJvYcCXRtasJslatcC5EniOqW0kAuTtwqymfxRfOEa1WKAvssMhu0FuWq8JK4cf4REOoTUk9IOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUxb/9CihysOw2KaeuM5OeG2q1MATL3MVRywpcOcwVqIBWtYj
	7sSQXsOyXWMjVzTUlRnhH4qpPzFtjcCc9kNqnnti+qrxSTkPsLsqrx/L
X-Gm-Gg: ASbGnctBAF4vGqtn2BH/OSre6s2IpiGI6g/rwCIFkT/V7CKbh8vuPuiI/QLzKl3j/K+
	f27ShtUZxlYT1rHeW2FXGbf1nix8baMaRldhBtuWLwGEbrIAkzwn4FwyXqHD1CulZKKdFSjXiMp
	mM5/B3yDXQHWqFckFWdif8Z9mwwVwzMaeoeTa6Qk8XAnThYrCg4BGvWUZ6hBBSVfk+Z6vZxRtGJ
	u8an3zZq+rUGfVKoo0sofEGw2nRdDGgvin2+g2o07mH+Cf+Hn1hjtO/IDKLSgBfmcZHaT4wcHw/
	8RKVluMw8Xv6t7+Y0yuErwqG2u3lfhJh6RHaJG+MwP1ADj24Og03BFRprrvZqUt4z33JMJQwiiP
	LP0a50Ln3UUiuxhddsOp9ZycTo6U0K5mCbqs=
X-Google-Smtp-Source: AGHT+IHnrlaIgYieOJlbcldc8fhthk66yxfXBj+Mky+hwKDEqFFpNcHQod+MaMIOkC9i5kv/5aVVPA==
X-Received: by 2002:a17:906:6a1d:b0:ae3:4f99:a5a5 with SMTP id a640c23a62f3a-ae6fc6a82c8mr1252959766b.6.1752492522653;
        Mon, 14 Jul 2025 04:28:42 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:f749])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4553sm819721866b.51.2025.07.14.04.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 04:28:41 -0700 (PDT)
Message-ID: <a7bd1e6f-b854-4172-a29a-3f0662c6fd6e@gmail.com>
Date: Mon, 14 Jul 2025 12:30:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/8] netmem: introduce struct netmem_desc
 mirroring struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, almasrymina@google.com, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-2-byungchul@sk.com>
 <b1f80514-3bd8-4feb-b227-43163b70d5c4@gmail.com>
 <20250714042346.GA68818@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250714042346.GA68818@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 05:23, Byungchul Park wrote:
> On Sat, Jul 12, 2025 at 03:39:59PM +0100, Pavel Begunkov wrote:
>> On 7/10/25 09:28, Byungchul Park wrote:
>>> To simplify struct page, the page pool members of struct page should be
>>> moved to other, allowing these members to be removed from struct page.
>>>
>>> Introduce a network memory descriptor to store the members, struct
>>> netmem_desc, and make it union'ed with the existing fields in struct
>>> net_iov, allowing to organize the fields of struct net_iov.
>>
>> FWIW, regardless of memdesc business, I think it'd be great to have
>> this patch, as it'll help with some of the netmem casting ugliness and
>> shed some cycles as well. For example, we have a bunch of
>> niov -> netmem -> niov casts in various places.
> 
> If Jakub agrees with this, I will re-post this as a separate patch so
> that works that require this base can go ahead.

I think it'd be a good idea. It's needed to clean up netmem handling,
and I'll convert io_uring and get rid of the union in niov.

The diff below should give a rough idea of what I want to use it for.
It kills __netmem_clear_lsb() to avoid casting struct page * to niov.
And saves some masking for zcrx, see page_pool_get_dma_addr_nmdesc(),
and there are more places like that.


diff --git a/include/net/netmem.h b/include/net/netmem.h
index 535cf17b9134..41f3a3fd6b6c 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -247,6 +247,8 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
  	return page_to_pfn(netmem_to_page(netmem));
  }
  
+#define pp_page_to_nmdesc(page)	((struct netmem_desc *)(page))
+
  /* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
   * common fields.
   * @netmem: netmem reference to extract as net_iov.
@@ -262,11 +264,18 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
   *
   * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
   */
-static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
+static inline struct net_iov *__netmem_to_niov(netmem_ref netmem)
  {
  	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
  }
  
+static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return &__netmem_to_niov(netmem)->desc;
+	return pp_page_to_nmdesc(__netmem_to_page(netmem));
+}
+
  /**
   * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
   * @netmem: netmem reference to get the pointer from
@@ -280,17 +289,17 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
   */
  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
  {
-	return __netmem_to_page(netmem)->pp;
+	return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
  }
  
  static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
  {
-	return __netmem_clear_lsb(netmem)->pp;
+	return netmem_to_nmdesc(netmem)->pp;
  }
  
  static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
  {
-	return &__netmem_clear_lsb(netmem)->pp_ref_count;
+	return &netmem_to_nmdesc(netmem)->pp_ref_count;
  }
  
  static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
@@ -355,7 +364,7 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
  
  static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
  {
-	return __netmem_clear_lsb(netmem)->dma_addr;
+	return netmem_to_nmdesc(netmem)->dma_addr;
  }
  
  void get_netmem(netmem_ref netmem);
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index db180626be06..002858f3bcb3 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -425,9 +425,9 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  	page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
  }
  
-static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
+static inline dma_addr_t page_pool_get_dma_addr_nmdesc(struct netmem_desc *desc)
  {
-	dma_addr_t ret = netmem_get_dma_addr(netmem);
+	dma_addr_t ret = desc->dma_addr;
  
  	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
  		ret <<= PAGE_SHIFT;
@@ -435,6 +435,13 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
  	return ret;
  }
  
+static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
+{
+	struct netmem_desc *desc = netmem_to_nmdesc(netmem);
+
+	return page_pool_get_dma_addr_nmdesc(desc);
+}
+
  /**
   * page_pool_get_dma_addr() - Retrieve the stored DMA address.
   * @page:	page allocated from a page pool
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 085eeed8cd50..2e80692d9ee1 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -290,7 +290,7 @@ static void io_zcrx_sync_for_device(const struct page_pool *pool,
  	if (!dma_dev_need_sync(pool->p.dev))
  		return;
  
-	dma_addr = page_pool_get_dma_addr_netmem(net_iov_to_netmem(niov));
+	dma_addr = page_pool_get_dma_addr_nmdesc(&niov->desc);
  	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
  				     PAGE_SIZE, pool->p.dma_dir);
  #endif
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index cd95394399b4..97d4beda9174 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -5,19 +5,21 @@
  
  static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
  {
-	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
+	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
  }
  
  static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
  {
-	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
+	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
  }
  
  static inline void netmem_clear_pp_magic(netmem_ref netmem)
  {
-	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
+	struct netmem_desc *desc = netmem_to_nmdesc(netmem);
  
-	__netmem_clear_lsb(netmem)->pp_magic = 0;
+	WARN_ON_ONCE(desc->pp_magic & PP_DMA_INDEX_MASK);
+
+	desc->pp_magic = 0;
  }
  
  static inline bool netmem_is_pp(netmem_ref netmem)
@@ -27,13 +29,13 @@ static inline bool netmem_is_pp(netmem_ref netmem)
  
  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
  {
-	__netmem_clear_lsb(netmem)->pp = pool;
+	netmem_to_nmdesc(netmem)->pp = pool;
  }
  
  static inline void netmem_set_dma_addr(netmem_ref netmem,
  				       unsigned long dma_addr)
  {
-	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
+	netmem_to_nmdesc(netmem)->dma_addr = dma_addr;
  }
  
  static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
@@ -43,7 +45,7 @@ static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
  	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
  		return 0;
  
-	magic = __netmem_clear_lsb(netmem)->pp_magic;
+	magic = netmem_to_nmdesc(netmem)->pp_magic;
  
  	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
  }
@@ -51,12 +53,12 @@ static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
  static inline void netmem_set_dma_index(netmem_ref netmem,
  					unsigned long id)
  {
-	unsigned long magic;
+	struct netmem_desc *desc;
  
  	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
  		return;
  
-	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
-	__netmem_clear_lsb(netmem)->pp_magic = magic;
+	desc = netmem_to_nmdesc(netmem);
+	desc->pp_magic |= id << PP_DMA_INDEX_SHIFT;
  }
  #endif


