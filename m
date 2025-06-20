Return-Path: <bpf+bounces-61153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE708AE1243
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F60B1BC3B3A
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB7226865;
	Fri, 20 Jun 2025 04:12:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ECE20F091;
	Fri, 20 Jun 2025 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392762; cv=none; b=eGym4RdicnyaCY9e88M/bprBUQmVCTGnwqiJLQ4GrXx6LPleTFNgB0dCscUl+Arq5csZO+N3YWUd3JHlYrNXCCFM6QoQw566Ev5XWphsynTufKK8mP9QC+GF21mX3plikiWl521r7FyBWtOU0unN1udAboOuN67tQoZPnH/kljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392762; c=relaxed/simple;
	bh=U9kNZ4KQWukp+r3D0S/rVCQsFQLd6WWxLM0MODxbwtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M48wa7GeoMjU/7cMKWc69W1l0QqyyPMudYeZ5C7TrxtVI4kT1+JioalruLFpAS2ulzNR5khuB/OWeNcVx9kAHATc2QCtanfsYIpKxtS8ru5wgPc//7w/uSxoVLuC+wEdC+ce+NgGhfVKbBOaefMIKYGgt9LS3ngj1JbZC2HelMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ad-6854dfb3dbab
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through struct netmem_desc in page_pool_page_is_pp()
Date: Fri, 20 Jun 2025 13:12:24 +0900
Message-Id: <20250620041224.46646-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250620041224.46646-1-byungchul@sk.com>
References: <20250620041224.46646-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURiFvb3TmaFaHSrRER+IdYsSUYzLnwiG6Mto1GgwavQBG5nQhlKw
	ZdUYyxKNFVBxQdtiisgiYGrq0qJASq3IopFA1CqrRfRBxEARy2K0hRh5+3LuOd99+WksKRQG
	0wpVMq9WyZRSUkSIvs8rXvew96B8Q7dpKRjN1SRUedOhvM8mBGPlEwSj450UeJwvSSgpHsNg
	fJNDwE/zBIaBRjcFVZa90Fv2hYDa81YM7ktNJOTlTGKoGx+iIMtWIYC2J/lCuDZRisGq7aOg
	46mRhJ7qP0L44sgjoFl/j4De/ChoNC2CsdZBBE6zVQBjuUUkXG03kdCf04ug/bmbAENmPgJz
	vUsIk16fw/Cih4pawT0f/IG5R/c+CLgafTfFmSwp3MOKtZzO1Y45S+UFkrOMFFBc17takmu6
	OUlwNTaPgMvLHiK54YGPBPej/i3JmR+9JbhXJie1P/CoKCKWVypSefX67cdF8rpugyCpPSjd
	entUoEUNgToUQLPMJvbrt0mBDtHT3Dq00R+TzGrW5RrHfg5iwlmP+yWhQyIaM/dJ1lndSfn7
	Cxk1a7kb5e8QzErWXJpF+lnMbGGvDOcKZ/QhbNUD+7QnwJcPZz2b7kiYzaz3To5wph/INt/6
	TPiV2Pev+bbEH2PfNPuxAc9obDRbbA+a4SVsQ4WLuIwY/ay1/v9aP2ttQrgSSRSq1ASZQrkp
	TJ6hUqSHnUhMsCDfuZSdmTpmQyNt0Q7E0Eg6T2wbjZZLhLJUTUaCA7E0lgaJS5r2ySXiWFnG
	KV6dGKNOUfIaB1pKE9LF4o1jabESJk6WzMfzfBKv/vcqoAOCtehGw/XDBx1dpbvPFDrH6bsn
	awqZ+Z5uaWLoyDbPr/PHO1t+2qSHj1xcZt/BstaYNb+LaudPWcvrDnlCIjKrF8RFHugoiH+3
	TjW3hQ79RMX3998pDR1MuzRhjNl1YjiSfG1PWa7Dq4rSzu3M3Er1NK72hu15v+Y0bZhD/VqS
	++JsuFZKaOSy8LVYrZH9Bc2mjzMqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYRjHe897ds5xODitUQe7EAYiRVlGxhN9IHTRQVCCgj5uauWxjXTK
	pjKzD3NCZGlZXdicMpvVmspkmpumYmrqiKgm1bLlRGtUyPxa6rSyzYi8+/N/fs/vuXkYLF0k
	YxiVOlfQqBWZckpMitP26Lc2+44ot3sD0WC0NVBQv6CDR6NOERitrQiCoY80zPYNUGCuncNg
	fFVCwg/bIoYv/WM01NtTwffQT0LHVQeGsZuDFJSVLGHoDAVoKHZaCOitdongdWu5CO4uPsDg
	KBqlYajdSMFIw7II/D1lJLgMj0nwlSdDv2k9zL2YQNBncxAwd6OagjtuEwXjJT4E7t4xEqqu
	lCOwdXlEsLQQdlQ9H6GT4/jeiUnMtzz+QPBthk80b7Ln8c2WzXypx415u/UaxdtnbtO8910H
	xQ9WLpF8m3OW4Mv0AYqf/jJM8pNdbyne/HWK4G0tb8lD0hPivelCpipf0Gzbf0qs7PxUReS4
	ZTpHTZAoQs/WliKG4did3IvAjlIUxVBsPOfxhHAky9hEbnZsgCxFYgazjRTX1/CRjvDrWA1n
	r0uOMCQbx9keFFORLGF3cRXTN0SRzLGxXH1T94onKtxPFz9dYaRsErdwv0T0l1/Lue59JiNK
	HL5rq5FGahxe1T+pwreQxLCKMvynDKsoE8JWJFOp87MUqsykBO05ZYFapUs4k51lR+GPeHjx
	Z4UTBYcO9iCWQfJoiTN4WCkVKfK1BVk9iGOwXCYxD6YppZJ0RcF5QZN9UpOXKWh70EaGlG+Q
	pBwVTknZs4pc4Zwg5Aiaf1OCiYopQluGB2Inm87mdY/7cH8tUdhYV9d80NL6ilO97LpwWRfr
	+nyMXvM9ND/yq3tPhtm7+8r937XsLWPM+4YM86VN8pT3w/EZ/sKt9IDXf7z25IRpKmmdbka4
	8O3NSOsJSm9NfbTcP2UYN/4irp8mi7+lWKj278aa+W2y+MoDbV7/Pquc1CoViZuxRqv4A/Ra
	oSoNAwAA
X-CFilter-Loop: Reflected

To simplify struct page, the effort to separate its own descriptor from
struct page is required and the work for page pool is on going.

To achieve that, all the code should avoid directly accessing page pool
members of struct page.

Access ->pp_magic through struct netmem_desc instead of directly
accessing it through struct page in page_pool_page_is_pp().  Plus, move
page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
without header dependency issue.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/mm.h   | 12 ------------
 include/net/netmem.h | 14 ++++++++++++++
 mm/page_alloc.c      |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..0b7f7f998085 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  */
 #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
 
-#ifdef CONFIG_PAGE_POOL
-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
-}
-#else
-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return false;
-}
-#endif
-
 #endif /* _LINUX_MM_H */
diff --git a/include/net/netmem.h b/include/net/netmem.h
index d49ed49d250b..3d1b1dfc9ba5 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
  */
 static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
 
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	struct netmem_desc *desc = (struct netmem_desc *)page;
+
+	return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+#else
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
+#endif
+
 /* net_iov */
 
 DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ef3c07266b3..cc1d169853e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <net/netmem.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
-- 
2.17.1


