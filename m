Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B360738CABE
	for <lists+bpf@lfdr.de>; Fri, 21 May 2021 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhEUQRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 May 2021 12:17:23 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39463 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhEUQRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 May 2021 12:17:22 -0400
Received: by mail-ed1-f53.google.com with SMTP id h16so23913754edr.6;
        Fri, 21 May 2021 09:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXxhNsSA0w48JzABDCQS0aHG0R3WQuhO/gqWHcWbvcI=;
        b=T7sRSbMZgCMxZ8xMfZ4Ky+e3YYdBJ5yeY5JxS3yiC2JK86fCOr3pfui5UxCoNLMcke
         ZyusgyR2XNw0NC3riR85L2q2FnDlANOcnbp4bItkOnlcRtHNkrv8VYYl8wopnlxSSt+J
         WPULU5wr57UA/sdAzshGET/GhlwTnKBpBaZ3i99BNwdYr3d4TSqFYfFWhacO35TW/4rJ
         SG5bBK3eAGbxiFlzPFQ3MBOw+DG8hB/3CGeJF7FeOi1Ku6kE/HgZAw3izRltqhmxHuY/
         5u67CkGkDI8QMrSlXM8Ma1go161UYB1QBzXQnMibFiAaBPH5EiR64Wcz3bxOXRj+Yurz
         eu4g==
X-Gm-Message-State: AOAM533bM4ImnDiOMiZRRBeaCjMknSwN81+MuiLD/GU6pVNz65fluYFM
        Vv9ItitugBgef3auiUePieoIgJa0ApZo+aps
X-Google-Smtp-Source: ABdhPJxRc9Ga5LqRj6nwh7Mr+guSRZr+lRmCRE14vxiMJsfZdVWzw12VMBMeg/7HCeFfhIUc2orrng==
X-Received: by 2002:a50:fd13:: with SMTP id i19mr12078450eds.386.1621613757321;
        Fri, 21 May 2021 09:15:57 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id f7sm3871644ejz.95.2021.05.21.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 09:15:56 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     netdev@vger.kernel.org, linux-mm@kvack.org
Cc:     Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>,
        Kevin Hao <haokexin@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>
Subject: [PATCH net-next v6 1/5] mm: add a signature in struct page
Date:   Fri, 21 May 2021 18:15:23 +0200
Message-Id: <20210521161527.34607-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521161527.34607-1-mcroce@linux.microsoft.com>
References: <20210521161527.34607-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

This is needed by the page_pool to avoid recycling a page not allocated
via page_pool.

The page->signature field is aliased to page->lru.next and
page->compound_head, but it can't be set by mistake because the
signature value is a bad pointer, and can't trigger a false positive
in PageTail() because the last bit is 0.

Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 include/linux/mm.h       | 12 +++++++-----
 include/linux/mm_types.h | 12 +++++++++++-
 include/linux/poison.h   |  3 +++
 net/core/page_pool.c     |  6 ++++++
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 322ec61d0da7..4ecfd8472a17 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1668,10 +1668,12 @@ struct address_space *page_mapping(struct page *page);
 static inline bool page_is_pfmemalloc(const struct page *page)
 {
 	/*
-	 * Page index cannot be this large so this must be
-	 * a pfmemalloc page.
+	 * This is not a tail page; compound_head of a head page is unused
+	 * at return from the page allocator, and will be overwritten
+	 * by callers who do not care whether the page came from the
+	 * reserves.
 	 */
-	return page->index == -1UL;
+	return page->compound_head & BIT(1);
 }
 
 /*
@@ -1680,12 +1682,12 @@ static inline bool page_is_pfmemalloc(const struct page *page)
  */
 static inline void set_page_pfmemalloc(struct page *page)
 {
-	page->index = -1UL;
+	page->compound_head = BIT(1);
 }
 
 static inline void clear_page_pfmemalloc(struct page *page)
 {
-	page->index = 0;
+	page->compound_head = 0;
 }
 
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c10a45..09f90598ff63 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -96,6 +96,13 @@ struct page {
 			unsigned long private;
 		};
 		struct {	/* page_pool used by netstack */
+			/**
+			 * @pp_magic: magic value to avoid recycling non
+			 * page_pool allocated pages.
+			 */
+			unsigned long pp_magic;
+			struct page_pool *pp;
+			unsigned long _pp_mapping_pad;
 			/**
 			 * @dma_addr: might require a 64-bit value on
 			 * 32-bit architectures.
@@ -130,7 +137,10 @@ struct page {
 			};
 		};
 		struct {	/* Tail pages of compound page */
-			unsigned long compound_head;	/* Bit zero is set */
+			/* Bit zero is set
+			 * Bit one if pfmemalloc page
+			 */
+			unsigned long compound_head;
 
 			/* First tail page only */
 			unsigned char compound_dtor;
diff --git a/include/linux/poison.h b/include/linux/poison.h
index aff1c9250c82..d62ef5a6b4e9 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -78,4 +78,7 @@
 /********** security/ **********/
 #define KEY_DESTROY		0xbd
 
+/********** net/core/page_pool.c **********/
+#define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
+
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3c4c4c7a0402..e1321bc9d316 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -17,6 +17,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
 #include <linux/mm.h> /* for __put_page() */
+#include <linux/poison.h>
 
 #include <trace/events/page_pool.h>
 
@@ -221,6 +222,8 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 		return NULL;
 	}
 
+	page->pp_magic |= PP_SIGNATURE;
+
 	/* Track how many pages are held 'in-flight' */
 	pool->pages_state_hold_cnt++;
 	trace_page_pool_state_hold(pool, page, pool->pages_state_hold_cnt);
@@ -263,6 +266,7 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 			put_page(page);
 			continue;
 		}
+		page->pp_magic |= PP_SIGNATURE;
 		pool->alloc.cache[pool->alloc.count++] = page;
 		/* Track how many pages are held 'in-flight' */
 		pool->pages_state_hold_cnt++;
@@ -341,6 +345,8 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
 			     DMA_ATTR_SKIP_CPU_SYNC);
 	page_pool_set_dma_addr(page, 0);
 skip_dma_unmap:
+	page->pp_magic = 0;
+
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
 	 */
-- 
2.31.1

