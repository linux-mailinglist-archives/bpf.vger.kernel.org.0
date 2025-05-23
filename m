Return-Path: <bpf+bounces-58804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55373AC1A7D
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D4C178289
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177A24BBEC;
	Fri, 23 May 2025 03:26:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533B2DCC00;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970787; cv=none; b=Z49mEnLjkltMOMdCVQYjenLEWkarsncmaGRlQ4iuQUnkNl4KQajjdTdkbS31NtLO5AIRnAFFutkyyd5aaXFiS5PngZ1Gzolh/q0Xr5U9gAxwaTjfZEgtRWQDDO0NN5PLgV5evXvdjLl8wWJw0EDX4PpV+kiksDOvzXj3V3Zu+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970787; c=relaxed/simple;
	bh=uStT/gutBpHMd4R5hxyLlH4K3wJO3kyyyE21WC/nwKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iMAD7TDilVYqMm3JHOvAt1C1LmAzXla8ScQcxa1h1zIJeSZgUq7fRgiO74EM1biaFXxahOZQbp++FrNm/iwrYfIdEVutDx/yexalXIFt6YEyi1lQUBqZfn94sky2YegYz8Ccip+ANs6xknzD1ORhi54NviQjzUqjSkKobCUV3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-75-682feadb19ae
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [PATCH 01/18] netmem: introduce struct netmem_desc struct_group_tagged()'ed on struct net_iov
Date: Fri, 23 May 2025 12:25:52 +0900
Message-Id: <20250523032609.16334-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTYRwGcN+ds3OOw9VxiR7NihZRKWqKyktE2Jd4hYLIQDKsZp7acF6Y
	zhsJy8TS8oJGhE6dabaptFjmZoqkzUsXUJbGNHU2m2V5QZfLW5iX/PaD//M8X/4UJjDiXpQk
	IYWVJYikQoKH82Zcqv1GfgaIj/+xYVCpbSRgw1I6fDZu4EJlfTOAv5e/kNBu7CFgTbVjI9GX
	g8NF7QoGbd1WElrqJnHYdlePQWtRLwELclYxmG1Qc2B/cyEXPlx5ikG9YpyEn14rCTjWuM6F
	k50FOHxXpsGhpTAMdqvcoePDNIBGrZ4DHQ8qCFhqUhFwIscCoOmtFYfltwsB1LabuXB1SUmE
	HURNmiEOaikbJZFKJ0cv1T4o32zCkK4+j0C6hRISjXxuI1Dv41UctRjsHFRwZ5ZA87ZhHM21
	DxJI2zSIo48qI4nsuv3n6SjeyVhWKkllZQGnrvHEi3l2MmnII71r7gmhAKOu+cCZYuhgRlNS
	yNlxTtF97qYJ+ghjNi9jm3ajAxm7tQfPBzwKo2e5jE25ulXYQ99gOhyWrQJOH2ZyLVP4pvl0
	CPP+e9n/0QNMw4s3W0POdChTPLZIbFqwkWkdGCa3M/MkM1OUsW1PpkNtxosBXwWc6oFAkpAa
	L5JIg/3FGQmSdP/rifE6sPHbuqy1ywaw0B/RCWgKCF34Bl6AWMAVpSZnxHcChsKEbvyuSX+x
	gB8ryshkZYlXZXIpm9wJ9lK40IMf5EiLFdA3RSlsHMsmsbKdK4dy9lIAQezR8WKJ0nX34KyT
	0Ds3qib614kwm7PyldfZytORlRVFa1lT2d5/Q02q5lrsx5l7veF9vhXyC4Gea8FYJtrlq5lY
	ULTEXSotd3cLnIhp25c0YB5t6S4tN31NCRHpq6pqI6MPhTeo5RfTznHXWylrzDdlTNCViOlT
	twKe++mPPRLiyWJRoA8mSxb9A8uQcBvXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGfc959545Ghyn1aE+BDMvSGpCxj+KiD7Ui4QUFZIJOfPUhle2
	XC4orKRS85KGhk5YSt5h5XVeEO93sDRjljpZzS6GVl4wF1Qz+vaD3/M8Xx4pq6jCu6SaxGui
	NlEVryQyLAs/fDfw3Zdg9f6urEAwmusI1G6kQuW8RQLGmmYEqz/fcbDSN0ig/Ok6C8bxdAxr
	5k0WHAN2DmwVCxg67rewYM8dIpCd7mThjqWKgd7SYQm8bM6RwOPNZyy0pM1zMNlmJDBX91sC
	Cz3ZGIaLqzHYco7BgGkHrI9+RdBnbmFg/WEpgYIJE4H36TYEE712DCW3cxCYO60ScG4YyTEl
	bayeZmhr8SxHTfUptKEqgGZaJ1haX5NBaP2PfI7OvOkgdOiJE9NWywpDs+8uEfrd8RbT5c4p
	Qss/fWOouXEK0zFTH3faI1J2JFaM1+hFbfDRaJl6LWOFS57emdq/XEbS0KxHJnKXCvwBIT03
	S+JiwvsJVutP1sVefIiwYh/EmUgmZfklieAwOhmX8OSvCN3rtq0C5n2Ee7bP2MVyPlQY+VjM
	/BvdI9Q+79oacucPCnlza8TFir+Z9tdvuTwkMyG3GuSlSdQnqDTxoUG6OLUhUZMadDkpoR79
	/a/i5q9HFrQ6ebIH8VKk3Cb3TwhWKyQqvc6Q0IMEKav0kvcvBKkV8liV4YaoTbqkTYkXdT1o
	txQrd8rDIsRoBX9VdU2ME8VkUfvfMlL3XWlIPtBgX8z96NGGfHw6bBdLbx4qwHM0ib4qt0VE
	cXaNcDwGZ0Uaok6NI1v3iQsB+ZF6b/81IazIWui98eLW8sjekH1N3u0RRx4UnW+aqWwvY37N
	FzvOkEN6A+l2jp7TRnr6vnBcP+tb4m6ZdQvTTT3czs72fUj7FBPutzhWOKbEOrUqJIDV6lR/
	AFlN4ZS7AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the page pool members of struct page should be
moved to other, allowing these members to be removed from struct page.

Introduce a network memory descriptor to store the members, struct
netmem_desc, reusing struct net_iov that already mirrored struct page.

While at it, relocate _pp_mapping_pad to group struct net_iov's fields.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h |  2 +-
 include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07edd01f9..873e820e1521 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -120,13 +120,13 @@ struct page {
 			unsigned long private;
 		};
 		struct {	/* page_pool used by netstack */
+			unsigned long _pp_mapping_pad;
 			/**
 			 * @pp_magic: magic value to avoid recycling non
 			 * page_pool allocated pages.
 			 */
 			unsigned long pp_magic;
 			struct page_pool *pp;
-			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
 			atomic_long_t pp_ref_count;
 		};
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..08e9d76cdf14 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -31,12 +31,41 @@ enum net_iov_type {
 };
 
 struct net_iov {
-	enum net_iov_type type;
-	unsigned long pp_magic;
-	struct page_pool *pp;
-	struct net_iov_area *owner;
-	unsigned long dma_addr;
-	atomic_long_t pp_ref_count;
+	/*
+	 * XXX: Now that struct netmem_desc overlays on struct page,
+	 * struct_group_tagged() should cover all of them.  However,
+	 * a separate struct netmem_desc should be declared and embedded,
+	 * once struct netmem_desc is no longer overlayed but it has its
+	 * own instance from slab.  The final form should be:
+	 *
+	 *    struct netmem_desc {
+	 *	   unsigned long pp_magic;
+	 *	   struct page_pool *pp;
+	 *	   unsigned long dma_addr;
+	 *	   atomic_long_t pp_ref_count;
+	 *    };
+	 *
+	 *    struct net_iov {
+	 *	   enum net_iov_type type;
+	 *	   struct net_iov_area *owner;
+	 *	   struct netmem_desc;
+	 *    };
+	 */
+	struct_group_tagged(netmem_desc, desc,
+		/*
+		 * only for struct net_iov
+		 */
+		enum net_iov_type type;
+		struct net_iov_area *owner;
+
+		/*
+		 * actually for struct netmem_desc
+		 */
+		unsigned long pp_magic;
+		struct page_pool *pp;
+		unsigned long dma_addr;
+		atomic_long_t pp_ref_count;
+	);
 };
 
 struct net_iov_area {
@@ -51,9 +80,9 @@ struct net_iov_area {
 /* These fields in struct page are used by the page_pool and net stack:
  *
  *        struct {
+ *                unsigned long _pp_mapping_pad;
  *                unsigned long pp_magic;
  *                struct page_pool *pp;
- *                unsigned long _pp_mapping_pad;
  *                unsigned long dma_addr;
  *                atomic_long_t pp_ref_count;
  *        };
-- 
2.17.1


