Return-Path: <bpf+bounces-59627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB0ACD60E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCCA7AB2CC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7125B669;
	Wed,  4 Jun 2025 02:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A423906A;
	Wed,  4 Jun 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005595; cv=none; b=NjF+W1LoLrr6riYoAVqT53xXQ/0MwwnebujVw0ss+A13qqh1dp90XGW9Dtq8bhBuqCFnd4L2JCbk9O4RbO7YNPRzmIfz2kiVPmfHBpp4cYtnWhyE5VO/e4rg/oIGTmqio9i2jbytCVrcjyHrdVITVu3QnP1bFInd8/JN4DWuF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005595; c=relaxed/simple;
	bh=mcub4JtT0gUWqPG8n/KXl/GyqQiEcFNqH1upQrURVyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X2BgoFn51LZ1p/J6/KoKH+cDm3akbs24JPd/O4Z32YrMvWFrEYLHVOf3LRK+/yjBQvpv9a7k6tWB2YdEQvSXj13oUiLqYZORnv4eshyIq7ATOq/kNMFaFy0NcnWgUPVoh3lXSuznas08ppBWVbRES2gFupe0M1JhoZP0EOI8TOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-70-683fb50a0023
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
Subject: [RFC v4 18/18] page_pool: access ->pp_magic through struct netmem_desc in page_pool_page_is_pp()
Date: Wed,  4 Jun 2025 11:52:46 +0900
Message-Id: <20250604025246.61616-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTYRjHe3fenbMNh4cldlL6cNCHkpVm8ZRi3hjvhVDQhaQXNfLUVtNk
	fkfhKsO0tsqCpFZNRXNTmkzLGSZlNhXNhh85yzQWRokudCbqpJor7378n//vf/OIKNlbHCJS
	ZWTzmgyFWk5LsGQ6oCJS8uygcnfZ1AEwWOppqFvIhydfbEIwmJ8jmFv8xICno5OGqop5Cgzv
	izD8sixRMGF3MTBe8w1Da3EzBa6bXTToirwUXLbVCsDxXC+Eu0vVFDRrvzAw8MJAw1j9HyF8
	a9dh6L5vwjCuTwC7MRjme6YQdFiaBTB/4yENd/qNNHwtGkfQ/8aF4cElPQJLm1MI3gUDnRBG
	mkwjAtJy/zNDjNYc0lgbQUqd/RSxmktoYp0tY8joh1aadJV7MWmxeQREd8VNk5mJj5j8bBui
	iaVpCJNeYwdDPNaNR9gUSVwar1bl8ppd8SckyoFuB84clOVXXi1BWjQaWIrEIo6N4dz2SrzK
	jzpMghWm2W2c07lIrXAQG8V5XJ2+jkREsW4hN2Hw+ktrWRU3U+ryy5jdwj0uHvGzlN3H/bAP
	/R/dxNU1vPIPiX35qPue35WxezmdbZBaGeXYaYbT3bAJ/wnrude1TnwLSY1ojRnJVBm56QqV
	OmansiBDlb/z5Ll0K/I9t+bicqoNzTqOtiNWhOQBUttovFImVORmFaS3I05EyYOkm8J9kTRN
	UXCe15w7rslR81ntKFSE5euk0fN5aTL2tCKbP8vzmbxm9SoQiUO0KKe3eE/TerS42Wz6nexO
	njoW+p0hWwvnHNqz5sT6aklKbPihB1X49rWC6DJt3IV+756+/eWK2e3v6qrO6G0bIq5vLirT
	Dq9LVIuTguraSPEd8eR47HBgvSesMPKp51le0imeofoyl3eMkUbTZHJDYcBL5nCwPCrGGxnY
	lNpTI8dZSkVUBKXJUvwFNZAvYNgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTYRzGe3fenc3l6LiWntQQRh+kaQpaf6jMJPGkEF0EgTc68tCG25RN
	RZNwpSGO1JZRotNWos1NnKjpTBGbYzoSFD9ilqVNFKMwTbOpQemiux/P183DJ0QmHMyXq3JZ
	tUqqkJACLLh6riRS8OqiLFrffxQM1lYSLN4CeDlv44LB3I1gY+sDD9YdwyQ0Pt8kwDBWiuGn
	dZuARaeHB3PNSxj6y3oI8FSNkFBRukPAPZuJA0P1Li6Md1dy4fF2EwE92nkeTL42kPCp9Q8X
	luwVGFy1LRjmKhPAaQyEzbffEDisPRzYfFBPQvWEkYSF0jkEE0MeDHV3KxFYB9xc2PEayAQJ
	09Uyw2F6az/yGGNHHtNpCmd07gmC6TCXk0zHj0c8ZvZdP8mM1Oxgpte2zmEqSlZIZm3xPWa+
	D0yTTOPyKoexdk1jZtTo4F0LSBOcz2QV8nxWfTo+QyCbdI3jnClRwYv75UiLZg/okB+fpmLp
	BkcLZ49J6gTtdm8ReyymYuh1zzDWIQGfoFa49KJhxxc6SMnpNZ0H7zGmjtHPymZ8LKTO0F+c
	0/jfaBhtaR/0Dfnt6rMrT31dERVHV9imiIdIYET7zEgsV+UrpXJFXJQmS1aokhdE3cxWdqDd
	/5rv/Nbb0MZksh1RfCTxF9pm42UirjRfU6i0I5pPSMTCsJO7kjBTWnibVWenq/MUrMaOQvhY
	EiRMucFmiKhb0lw2i2VzWPV/l8P3C9Yic/lZh77a4lKZuvXRy6MWjy61rddTl+to8lKqy8PL
	kYPZzc669H3+xTMXarTF0ohLndOHaz4nFB1RlnvfBDZETUVUPVEZ3d2xcYkLp46z0aHGNLw9
	NF/VZk9VFCX1JQZgxf6vA0nXJX1XRn+1tsuSD40528SrQSEElRLqmJFgjUwaE06oNdK/gSRD
	AbsCAAA=
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
index e51dba8398f7..f23560853447 100644
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
index d84ab624b489..8f354ae7d5c3 100644
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
index 4f29e393f6af..be0752c0ac92 100644
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


