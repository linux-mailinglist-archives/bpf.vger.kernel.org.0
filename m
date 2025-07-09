Return-Path: <bpf+bounces-62815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94446AFEFC6
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C6C4E80CB
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627D22687C;
	Wed,  9 Jul 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="T9LYSHLw";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="LT8DH/c+"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFB22686F
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081877; cv=none; b=BeZD+ugOacxTA+cfqe4Em7KacD0ejgkPEYl6hvhwnof5cUU7LiEtMkJE96maP4U93v2fPyL/HWQKhuTaQvVvvHjzFPHmkL4Qk3BPaYXNY+NYV0NOKe3Pl8Li779E4Yzpe48VtonrTvJtj3fEOZksIO+oAnr/0heejGkMc9rsCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081877; c=relaxed/simple;
	bh=6nt1E6Zy0PpjxdywH+jj8I3NIZ4GY8CkaV8XIMca098=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rq68s1blIAXxzAq0hMpyqmMgTdN5VyYf48e9i7GmlLnL8q6hC5esNaI0wcjmWH+5fImmhb6LY4zY1Z4TvMETdPKIeDYvYWJkFZ9PlHqQXD1Bejah4uzS/eZKAaNBVLBEQdhK38PfB/jxoEEn3MhuVdQ4t4wLLLFAPP6ap7UeaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=T9LYSHLw; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=LT8DH/c+; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752081873; x=1752686673;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=LrAktGzEr99plww7RQsKYhjMWGxj5SAMk+RHJzmK6Ug=;
	b=T9LYSHLwSRbrEMwdcrSDsva5TQrosqkDOAIqW7sbTvOJjCj7RxwznqswRAjTOmLQI/EtCaqf7n/GX
	 ceBbmJlBtLMnY2WVwWrqAFc+voF0Z5Yo8ZLSdGfn+CXfoGXDXGkMCWkCHy84GavWbhiDGNp/JflR5N
	 2Vd44aHo4Pc5XNugP1c9iYVXntZIGgejWObk1RZ0KyGi+HCGVHaaOaGta0vaNQZ7l3+IrHh5vjSZ89
	 2TaHQ5cYEXQwonYUePBTKan+i9ARXBUftpzAN21IQDPb8OL8nygcZ7PqqjRekz1tCwFm69bXKJ08Se
	 Ea638j0U+eOCgf5/GQiWuaK7AKS4LJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752081873; x=1752686673;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=LrAktGzEr99plww7RQsKYhjMWGxj5SAMk+RHJzmK6Ug=;
	b=LT8DH/c+ol1Lg+cQsN1EzKer+bHvDwp5dgp8b9IyDOistvlz0aXBgD9tsSStPUgmAAnuU+vawb8xb
	 sKMBOdGAA==
X-HalOne-ID: 938077d2-5ce9-11f0-86af-f78b1f841584
Received: from slottsdator.home (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 938077d2-5ce9-11f0-86af-f78b1f841584;
	Wed, 09 Jul 2025 17:24:33 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	rust-for-linux@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	bpf@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in vrealloc
Date: Wed,  9 Jul 2025 19:24:16 +0200
Message-Id: <20250709172416.1031970-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reimplement vrealloc() to be able to set node and alignment should
a user need to do so. Rename the function to vrealloc_node_align()
to better match what it actually does now and introduce macros for
vrealloc() and friends for backward compatibility.

With that change we also provide the ability for the Rust part of
the kernel to set node and alignment in its allocations.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/vmalloc.h | 12 +++++++++---
 mm/nommu.c              |  3 ++-
 mm/vmalloc.c            | 31 ++++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index fdc9aeb74a44..68791f7cb3ba 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -197,9 +197,15 @@ extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1
 extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
 #define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
 
-void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
-		__realloc_size(2);
-#define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
+void *__must_check vrealloc_node_align_noprof(const void *p, size_t size,
+		unsigned long align, gfp_t flags, int nid) __realloc_size(2);
+#define vrealloc_node_noprof(_p, _s, _f, _nid)	\
+	vrealloc_node_align_noprof(_p, _s, 1, _f, _nid)
+#define vrealloc_noprof(_p, _s, _f)		\
+	vrealloc_node_align_noprof(_p, _s, 1, _f, NUMA_NO_NODE)
+#define vrealloc_node_align(...)		alloc_hooks(vrealloc_node_align_noprof(__VA_ARGS__))
+#define vrealloc_node(...)			alloc_hooks(vrealloc_node_noprof(__VA_ARGS__))
+#define vrealloc(...)				alloc_hooks(vrealloc_noprof(__VA_ARGS__))
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
diff --git a/mm/nommu.c b/mm/nommu.c
index 87e1acab0d64..8359b2025b9f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -119,7 +119,8 @@ void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc_noprof);
 
-void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
+void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
+				 gfp_t flags, int node)
 {
 	return krealloc_noprof(p, size, (flags | __GFP_COMP) & ~__GFP_HIGHMEM);
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6dbcdceecae1..03dd06097b25 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4089,19 +4089,31 @@ void *vzalloc_node_noprof(unsigned long size, int node)
 EXPORT_SYMBOL(vzalloc_node_noprof);
 
 /**
- * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
+ * vrealloc_node_align_noprof - reallocate virtually contiguous memory; contents
+ * remain unchanged
  * @p: object to reallocate memory for
  * @size: the size to reallocate
+ * @align: requested alignment
  * @flags: the flags for the page level allocator
+ * @nid: node number of the target node
+ *
+ * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc(). If @size is
+ * 0 and @p is not a %NULL pointer, the object pointed to is freed.
  *
- * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
- * @p is not a %NULL pointer, the object pointed to is freed.
+ * if @nid is not NUMA_NO_NODE, this function will try to allocate memory on
+ * the given node. If reallocation is not necessary (e. g. the new size is less
+ * than the current allocated size), the current allocation will be preserved
+ * unless __GFP_THISNODE is set. In the latter case a new allocation on the
+ * requested node will be attempted.
  *
  * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
  * initial memory allocation, every subsequent call to this API for the same
  * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
  * __GFP_ZERO is not fully honored by this API.
  *
+ * If the requested alignment is bigger than the one the *existing* allocation
+ * has, this function will fail.
+ *
  * In any case, the contents of the object pointed to are preserved up to the
  * lesser of the new and old sizes.
  *
@@ -4111,7 +4123,8 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
  * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
  *         failure
  */
-void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
+void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
+				 gfp_t flags, int nid)
 {
 	struct vm_struct *vm = NULL;
 	size_t alloced_size = 0;
@@ -4135,6 +4148,12 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		if (WARN(alloced_size < old_size,
 			 "vrealloc() has mismatched area vs requested sizes (%p)\n", p))
 			return NULL;
+		if (WARN(!IS_ALIGNED((unsigned long)p, align),
+			 "will not reallocate with a bigger alignment (0x%lx)\n", align))
+			return NULL;
+		if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
+			     nid != page_to_nid(vmalloc_to_page(p)))
+			goto need_realloc;
 	}
 
 	/*
@@ -4165,8 +4184,10 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		return (void *)p;
 	}
 
+need_realloc:
 	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
-	n = __vmalloc_noprof(size, flags);
+	n = __vmalloc_node_noprof(size, align, flags, nid, __builtin_return_address(0));
+
 	if (!n)
 		return NULL;
 
-- 
2.39.2


