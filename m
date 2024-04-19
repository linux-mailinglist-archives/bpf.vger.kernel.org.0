Return-Path: <bpf+bounces-27219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A88AAEA3
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A6AB21BBE
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71998529A;
	Fri, 19 Apr 2024 12:38:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF753A1B5;
	Fri, 19 Apr 2024 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530280; cv=none; b=sJCZ++SWAsLJBUO9IT/ILL3GYkIxx6n+XYCxs3rwFjyUGc10OY8yMM3Tsa+nVMvSFV7V11+PbyLNFhvURJr4HFpQhwJZDSmb2DRHewP2p1iL0pPFFsfJP6W8wZI3aDilXT91rHSDG9cBglaLNJqZTgR35HEfVBSfPf3HcxtfVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530280; c=relaxed/simple;
	bh=CtvHFDck+w2iZroa+6jPORcjDAiRAeL3wYfx97pu67U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kWxtiT1GK0opQZ5ImohT0s2QP7Fwr+pQiV01cIa82qwoJn0Hw6vqj17XwrD0T2Y5DD6XjZ5Fh9nslJnX/+rsWmnTIGWP+P8vNXu3s7uQJ6NCrZxyGa2gkauzaMrbf8YJ1Frd5rYthnWGDenxrNloI/99KUYT8g4fn4RN8wLLjKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VLYxv0rYXz1R8P8;
	Fri, 19 Apr 2024 20:34:59 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 354B718007D;
	Fri, 19 Apr 2024 20:37:54 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 20:37:53 +0800
Subject: Re: [PATCH net-next v2 13/15] net: replace page_frag with
 page_frag_cache
To: Mat Martineau <martineau@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Eric Dumazet <edumazet@google.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>, <bpf@vger.kernel.org>,
	<mptcp@lists.linux.dev>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-14-linyunsheng@huawei.com>
 <c5a8eabb-1b46-1e9f-88c9-e707c3a086c4@kernel.org>
 <cb541985-a06d-7a71-9e6d-38827ccdf875@huawei.com>
 <83991c67-8e4a-c287-b4a5-5dbba8835947@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e1e7ebcf-8c7a-8ef4-c48a-3ddfa05d22bb@huawei.com>
Date: Fri, 19 Apr 2024 20:37:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <83991c67-8e4a-c287-b4a5-5dbba8835947@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/17 5:40, Mat Martineau wrote:
...

> I wasn't concerned as much about the direct cost of the inlined page_frag_alloc_commit() helper, it was that we could make fewer prepare calls if the commit was deferred as long as possible. As we discussed above, I see now that the prepare is not expensive when there is more space available in the current frag.
> 
>> Maybe what we could do is to do the prepare in the inline
>> helper instead of a function when cache is enough, so that
>> we can avoid a function call as the old code does, as an
>> inlined function requires less overhead and is generally
>> faster than a function call.
>>
>> But that requires more refactoring, as this patchset is bigger
>> enough now, I guess we try it later if it is possible.
> 
> A more generic (possible) optimization would be to inline some of page_frag_cache_refill(), but I'm not sure the code size tradeoff is worth it - would have to collect some data to find out for sure!

In my arm64 system, It seems inlining some of page_frag_cache_refill() results
in smaller kernel code size as below, has not done the performance test yet, but
the smaller code size seems odd here.

Without this patchset:
linyunsheng@ubuntu:~/ksize$ ./ksize.sh
Linux Kernel                          total |       text       data        bss
--------------------------------------------------------------------------------
vmlinux                            51974159 |   32238573   19087890     647696

With this patchset:
linyunsheng@ubuntu:~/ksize$ ./ksize.sh
Linux Kernel                          total |       text       data        bss
--------------------------------------------------------------------------------
vmlinux                            51970078 |   32234468   19087914     647696


With this patchset and below patch inlining some of page_frag_cache_refill():
linyunsheng@ubuntu:~/ksize$ ./ksize.sh
Linux Kernel                          total |       text       data        bss
--------------------------------------------------------------------------------
vmlinux                            51966078 |   32230468   19087914     647696




diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 529e7c040dad..3e1de20c8146 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -60,8 +60,33 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)

 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fragsz,
-                            gfp_t gfp_mask);
+void *__page_frag_cache_refill(struct page_frag_cache *nc, gfp_t gfp_mask);
+void *page_frag_cache_flush(struct page_frag_cache *nc, gfp_t gfp_mask);
+
+static inline void *page_frag_cache_refill(struct page_frag_cache *nc,
+                                          unsigned int fragsz, gfp_t gfp_mask)
+{
+       unsigned long size_mask;
+       void *va;
+
+       if (unlikely(!nc->va)) {
+               va = __page_frag_cache_refill(nc, gfp_mask);
+               if (likely(va))
+                       return va;
+       }
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+       /* if size can vary use size else just use PAGE_SIZE */
+       size_mask = nc->size_mask;
+#else
+       size_mask = PAGE_SIZE - 1;
+#endif
+
+       if (unlikely(nc->offset + fragsz > (size_mask + 1)))
+               return page_frag_cache_flush(nc, gfp_mask);
+
+       return (void *)((unsigned long)nc->va & ~size_mask);
+}

 /**
  * page_frag_alloc_va() - Alloc a page fragment.
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 8b1d35aafcc1..74f643d472fb 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -18,8 +18,7 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"

-static bool __page_frag_cache_refill(struct page_frag_cache *nc,
-                                    gfp_t gfp_mask)
+void *__page_frag_cache_refill(struct page_frag_cache *nc, gfp_t gfp_mask)
 {
        struct page *page = NULL;
        gfp_t gfp = gfp_mask;
@@ -40,7 +39,7 @@ static bool __page_frag_cache_refill(struct page_frag_cache *nc,

        if (unlikely(!page)) {
                nc->va = NULL;
-               return false;
+               return NULL;
        }

        nc->va = page_address(page);
@@ -57,8 +56,9 @@ static bool __page_frag_cache_refill(struct page_frag_cache *nc,

        nc->pfmemalloc = page_is_pfmemalloc(page);
        nc->offset = 0;
-       return true;
+       return nc->va;
 }
+EXPORT_SYMBOL(__page_frag_cache_refill);

 /**
  * page_frag_cache_drain - Drain the current page from page_frag cache.
@@ -83,20 +83,12 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);

-void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fragsz,
-                            gfp_t gfp_mask)
+void *page_frag_cache_flush(struct page_frag_cache *nc, gfp_t gfp_mask)
 {
        unsigned long size_mask;
-       unsigned int offset;
        struct page *page;
        void *va;

-       if (unlikely(!nc->va)) {
-refill:
-               if (!__page_frag_cache_refill(nc, gfp_mask))
-                       return NULL;
-       }
-
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
        /* if size can vary use size else just use PAGE_SIZE */
        size_mask = nc->size_mask;
@@ -105,41 +97,23 @@ void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fragsz,
 #endif

        va = (void *)((unsigned long)nc->va & ~size_mask);
-       offset = nc->offset;
-
-       if (unlikely(offset + fragsz > (size_mask + 1))) {
-               page = virt_to_page(va);
-
-               if (!page_ref_sub_and_test(page, nc->pagecnt_bias & size_mask))
-                       goto refill;
-
-               if (unlikely(nc->pfmemalloc)) {
-                       free_unref_page(page, compound_order(page));
-                       goto refill;
-               }
-
-               /* OK, page count is 0, we can safely set it */
-               set_page_count(page, size_mask);
-               nc->pagecnt_bias |= size_mask;
-
-               nc->offset = 0;
-               if (unlikely(fragsz > (size_mask + 1))) {
-                       /*
-                        * The caller is trying to allocate a fragment
-                        * with fragsz > PAGE_SIZE but the cache isn't big
-                        * enough to satisfy the request, this may
-                        * happen in low memory conditions.
-                        * We don't release the cache page because
-                        * it could make memory pressure worse
-                        * so we simply return NULL here.
-                        */
-                       return NULL;
-               }
+       page = virt_to_page(va);
+       if (!page_ref_sub_and_test(page, nc->pagecnt_bias & size_mask))
+               return __page_frag_cache_refill(nc, gfp_mask);
+
+       if (unlikely(nc->pfmemalloc)) {
+               free_unref_page(page, compound_order(page));
+               return __page_frag_cache_refill(nc, gfp_mask);
        }

+       /* OK, page count is 0, we can safely set it */
+       set_page_count(page, size_mask);
+       nc->pagecnt_bias |= size_mask;
+       nc->offset = 0;
+
        return va;
 }
-EXPORT_SYMBOL(page_frag_cache_refill);
+EXPORT_SYMBOL(page_frag_cache_flush);

 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.


> 
> Thanks,
> 
> Mat
> 
> .
> 

