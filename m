Return-Path: <bpf+bounces-59252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6433AC7650
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F6F7A46B2
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19225D20B;
	Thu, 29 May 2025 03:11:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC55253F22;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488274; cv=none; b=V6v2CErsFxF9kQvfdRUrXYTmiTp9ECWxji4zRE2SimXxy93O/CkQc+ohvCQ6z1KvD4jcUmJwVtGxKeKp+UkSGUKJozFysKq7qbqYbs3rCRnlH84B2TyoYxQFGHDPxiZ2aTT4xNmGoDaygsAXwXKIWl3vBO8lprLkvW87hE5W0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488274; c=relaxed/simple;
	bh=Q61n92PSF6nkMDXjrMAO+5P+TPRY8etYRrZye4mpY8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aS/NXhkmRyYQB0cGtT/oEb2a+hBrpUKHgyWRiTl7PjBjZWnD0k6zZdIepr/hIKfq9/1fgYtnwJx4revTvTtAqnqgCMY9Rn7lhGOGYAI+KzGkaIZCg6X/Mdq0EculYGy0CDmcMlOrKw8+f86REBDRPGCmpDfklwqgtLEznfGI6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-7b-6837d04350d9
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
Subject: [RFC v3 18/18] page_pool: access ->pp_magic through struct netmem_desc in page_pool_page_is_pp()
Date: Thu, 29 May 2025 12:10:47 +0900
Message-Id: <20250529031047.7587-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+++cnXOczk7L6mSgtQhN0DQs3w+amlDnQ0FpFGmQI09teW1T
	m91QM03JZd7IuWBa3oXFtDlFLU28lKB4iXkpRVFIUktzeMnKiX778Tw8v/fDS2GiNtyekkXF
	cvIoSYSYEOCCWZti14BeL6l7t9EaNLpqAqqWlVA2buSDptKA4PfKCAmLbR0EvC4yY6DpScFh
	SbeKwVT7BAljpdM4NKbVYTDxvJOAzJQ1DJKN5TzoNaj4kLtagkFd4jgJ/Q0aAr5V/+PDdGsm
	Dl3qChzGVH7Qrt0L5s8/ELTp6nhgfvaKgJw+LQGTKWMI+j5O4FCYpEKgazbxYW1ZQ/gdYmsr
	hnhsvforyWr1cWxNuQubYerDWH1lOsHqF7JJdvRLI8F2vlzD2XrjIo/NfDxHsL+mhnF2vnmQ
	YHW1gzjbrW0j2UW9wwU6WOAdxkXI4jn5sVOhAmlaYTMvZlSk1NfPkolocmcGsqIY2pN52l9I
	bvP4p1zCwgTtxJhMK5iF7WgPZnGiA89AAgqj5/jMlGaNZyl20zIm19C5wRSF00eYvlwfSyyk
	TzA5pYYtpyNT9fbDpsdqI8+vyd+cijZuFWS0EBYnQy+RTNL8+tZgP9NSbsKzkFCLdlQikSwq
	PlIii/B0kyZEyZRuN6Ij9Wjjt6UP/4QY0UJvUCuiKSS2EXYiL6mIL4lXJES2IobCxHbCZN+T
	UpEwTJJwj5NHX5fHRXCKVnSAwsX7hMfNd8NE9C1JLBfOcTGcfLvlUVb2icgpP6nEP3rA1vrB
	zfrVy4qWkHOlZVm2wZdmzroHvhhw9lAO+w5ljcSFBw56f1cp17uyQ4OcTwc0XZtR4XvU5qOP
	emyzh5waXA/vGi9WL8nTS8ryzvMuOvpPY+lNDYrUpOn7Dgev9r4jBMKivNSKO098z0S+L7ji
	8Dda5fPT5o3h9pQYV0glHi6YXCH5D8nIS/zXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF/d17d3cdzW5L8mJ/BIMoCjXN5beslCi6+Ucq9PSfvOjVDeeU
	TZdLxPkAzdRSh88JK8k3TTaZU3zUFJ0VJIpiZSoTRSLt4QN1QanRfx/O4Zzzx6FwSRPhSylU
	abxaxSmlpIgQ3QzN87syFiI/U2g+D0ZzOwltWxnQNG8XgLHVhmB9+7MQ1oZGSGh4vomD8UM+
	ARvmHRwWh11CmGtcIqC3oAsH11MnCSX5bhxy7c0YDNaPCmDMVioAw85LHLr080KY6DGSMNv+
	RwBLjhICRmtbCJgrDYdh0xHYfPcNwZC5C4PN4noSKsZNJCzkzyEYH3QRUJdTisDcPy0A95aR
	DJeynS0fMba79ouQNVnSWWvzKbZoehxnLa2PSdbyq1zIzkz1kqyz2k2w3fY1jC3JWyXZn4uf
	CPZ7/yTJNiz/wFhz5yTBvjcNCaMOxYguxvNKhZZXB1yOFckL6vqx1BlJhqV7RahHCweLkCfF
	0MHM/FsDucckfYKZnt7G99ibDmTWXCNEERJROL0qYBaNbmzPOEwrGIPNucsURdDHmXHDpT1Z
	TMuYikab8F/nMaat4/V+j+euXmmt3I9Kdrdqit6Qz5DIhDxakbdCpU3mFEqZvyZJrlMpMvzj
	UpItaPe+xqzfZXa0PnHdgWgKSQ+InShELhFwWo0u2YEYCpd6i3PDzskl4nhO94hXpzxQpyt5
	jQMdpQipjzjiLh8roRO5ND6J51N59X8Xozx99SizD1xV9dnXIjK9guV+WX1TbaHF87MPQ4J1
	0SkVhspyWecrR1yMCpuMDQrA8K/3Q1p8Eysj8/KD7gxwvn2346tk9ls3fAaq9YPRGy8Efsvd
	Vwv8JdaphISzqg5bdJmo/V6hNr3nZOcFL11COPekZiMn6nRotnnFw7odttMXuS4lNHIu8BSu
	1nB/AUwxzXe6AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to separate its own descriptor from
struct page is required and the work for page pool is on going.

To achieve that, all the code should avoid directly accessing page pool
members of struct page.

Access ->pp_magic through struct netmem_desc instead of directly
accessing it through struct page in page_pool_page_is_pp().  Plus, move
page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
without header dependency issue.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h   | 12 ------------
 include/net/netmem.h | 14 ++++++++++++++
 mm/page_alloc.c      |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8dc012e84033..de10ad386592 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
index f05a8b008d00..9e4ed3530788 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -53,6 +53,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
  */
 static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
 
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	struct netmem_desc *desc = (__force struct netmem_desc *)page;
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
index 8c75433ff9a4..40f956cee2d8 100644
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


