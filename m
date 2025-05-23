Return-Path: <bpf+bounces-58808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D909AC1A92
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E459E16C724
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1286271A7C;
	Fri, 23 May 2025 03:26:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD712248A4;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970790; cv=none; b=JIHQhCHcynMl+Xn26szhKnEh3t3gto/+L+BTYMhgYuTgmTydVKH1T9ryyQ/uQPpo8LYRRfsLQMBENchsoBNemR0kXcgO7IdyIxCdFWdcMsumEA1zW9v7tuAaisDCQ0COg2oPpcN5YfS3kPnm3G87fTLvbSdKQDbf47KJLjHKU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970790; c=relaxed/simple;
	bh=auMzu5bwtgTWBbkAtEOVi0fODaAwrqRd9Gco0GHErxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XLWosBdC5/MhBk8eiCla1ZzBuXJRGHIFKp1DidcIKPENWxBBPWKkYb3GAVC1se/0nj+P6tXh+M6mUFzEK9I77Tc74X5eYzl7xd5dkGcBNCAbQUkpXw46aF4iRXz1N3QoaIFKSSS5iznBN21jkAVxi1gfB0LOOcIoS0sGZ+3/p84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e3-682feadc1e0a
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
Subject: [PATCH 12/18] page_pool: use netmem APIs to access page->pp_magic in page_pool_page_is_pp()
Date: Fri, 23 May 2025 12:26:03 +0900
Message-Id: <20250523032609.16334-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWReUiTcRzG++09fXPwMk3fNIxWZhlpisUXKvHPXyB0QYedo7204ZHMIxcF
	VkObubUOpWPFskxbxmxKrgOptTxSsDxilRcrLcO0NJemaM7wvw/P93kevvCwhMxFhrDqtExR
	k6ZIkdMcyf3wL1nb+T1ate5R/how2ypoeDCeA2W9DgrM1scIfk98YmDUVU/DndteAswtOhLG
	bH8J6KvzMNBzr5+E5/k1BHguNNBg0E0ScMZRLoG3j40UXPlbSkBNbi8DbU/NNHRXzFDQ7zSQ
	0Hj9Pgk9xgSoswSBt2kQgctWIwFv4U0aLrdaaPis60HQ+spDwo3TRgS2WjcFk+NmOmEZrr7/
	QYKfXO9isMWehavKI3GBu5XAdquexvaRSwzufP+cxg1XJ0n8xDEqwYazQzT+1feRxMO1HTS2
	VXeQuNniYvCoPWwbn8RtUoop6mxREx1/mFMNluqp9JGFOVVvhuhclMcVID9W4OMEp76MnOc/
	pluMj2k+QnC7JwgfB/IxwqinftbDsQQ/RAl95klJAWLZAF4p/ByI8HlIPlwobvfMZaX8BsFV
	/Iz437lUeFD5Yo79ZnVT9xjtYxm/XnjW/pHxdQr8BCP87pt/YrHwstxNmpDUghZYkUydlp2q
	UKfERam0aeqcqCPHUu1odtt7p6b2OdDI251OxLNI7i91cNEqGaXIztCmOpHAEvJA6ev+KJVM
	qlRoT4iaY4c0WSlihhOFsqQ8WBrrPa6U8UcVmWKyKKaLmvmrhPULyUWrAqpCB8MbVWHVBRvz
	rCMtu5cnBiZ/CVpZZdq6KGRPLRG5t0n/sKz724vtA2A6H6B7NLMmVsPLF854sXTzwbtdUftJ
	8+q6d22G8ampa4na5hmuKMIafKskidAYVxSd3rtjV2HhuemT8RPaLSXTxsrh+ANLqdVNX7un
	b1zckbd8SamczFApYiIJTYbiH6XJGKPXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGe3fOzjmuFqdpdTByMBFDyimY/aGIUVlvfag+JUWUox3dclPZ
	VNQQLCVT8lKJWK1YlrcpLaZ4SbGay0tJl3lhlaasJlk6zVvewrTo24/n9uVhCEkF6cto4hJ5
	fZxSK6NEpOj43sxdA9/l6pDRUj8wWmooqJ5PgYrhRiEYzfUIZhY+0TBt76Dg4YM5Aoxvs0iY
	tSwS4G530TBUPkJCS3YDAa6CTgryspYIuNJYKYC2e11CeFefL4SixTICGjKGaeh5aqTgc82K
	EEZseSR03akiYShfAe2mLTD3egyB3dIggLnr9yi45TBR8CVrCIGjzUXC3cv5CCytTiEszRsp
	hQzXVX0Q4KY7gzQ2WZNwbWUQznU6CGw151DYOnWTxgP9LRTuLFkicVPjtADnZXoo/NP9kcQT
	rX0UfvhtUoAtdX0k7jbZ6ZObzoj2qXitJpnXy/dHidRjZTnChKn1KbWvPFQGuirKRV4Mx4Zx
	vwrv02tMsYGc07lArLEPG8pNuzrIXCRiCNYj5NzGJUEuYhhvVsVNjgauZUg2gCvudf3titlw
	zl7cTPzblHLVT57/Za9VvfDzLLXGEnY319z7kS5EIhNaZ0Y+mrhknVKj3R1siFWnxmlSgi/E
	66xo9b7y9OUbjWim54gNsQySbRDv0MnVEqEy2ZCqsyGOIWQ+4pcjwWqJWKVMTeP18ef1SVre
	YEPbGFK2VXwsko+SsDHKRD6W5xN4/X9XwHj5ZqAHvlP1y4ro92el/oNF/pdON8yd1/mt2JJ+
	50vn06TDeaZnmYf3hCVGqPzLSjd/klu7O39sp9/EHEy/fGzTKZXn0bkc6SF+MH6jd4DCYd5P
	Ou9/HRiNKA4Jd88kHrjoVXqiwrzt7HiZyTQYPTGueHz7Gm+WH41U7XxR8ri/wFnszpaRBrUy
	NIjQG5R/AAwfKlm6AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to seperate its own descriptor from
struct page is required and the work for page pool is on going.

To achieve that, all the code should avoid accessing page pool members
of struct page directly, but use safe APIs for the purpose.

Use netmem_is_pp() instead of directly accessing page->pp_magic in
page_pool_page_is_pp().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h   | 5 +----
 net/core/page_pool.c | 5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8dc012e84033..3f7c80fb73ce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
 
 #ifdef CONFIG_PAGE_POOL
-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
-}
+bool page_pool_page_is_pp(struct page *page);
 #else
 static inline bool page_pool_page_is_pp(struct page *page)
 {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1071cb3d63e5..37e667e6ca33 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1284,3 +1284,8 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov)
 
 	page_pool_clear_pp_info(netmem);
 }
+
+bool page_pool_page_is_pp(struct page *page)
+{
+	return netmem_is_pp(page_to_netmem(page));
+}
-- 
2.17.1


