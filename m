Return-Path: <bpf+bounces-63325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF772B0607E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CF516B571
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8082D8788;
	Tue, 15 Jul 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="KLpJJGNq";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="iLK0oDNm"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E822E8E07
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587902; cv=none; b=NmwubCGb05/VHM6p2ev4XUM68FleTI6AfxMeSzq/MiLl8IoBrUDWHfFDSo7il929ptPwNKOoBKeXCabmnYcoEN8R2GbxH44Yb/HeZGadtFGr2VG9WcUxiPVPWzioMKvPuVhGReGeVDAJN7s3RLtid2SIMNEGi4xwy1WQ+BkGwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587902; c=relaxed/simple;
	bh=uDpABtpi7fABN40wEFRs+KZAVhNwks4LMtg+F/DbG+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OEds0TB9xbsxA4dJ0vEpNW0wUq26jg4aFKOwO5DSSOL+eZ+HMXYEvFcMphWL8/S1ix3zgLnVPiAGoNwP2NyO6MVpNjHtgo3H1PJKeCOz6Ey8EkI1+iyqVomiIT7qWL6Rdqt3HrVed/QuH00FVgw9+1nZi+nq2NRIc/DqtcvP2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=KLpJJGNq; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=iLK0oDNm; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752587899; x=1753192699;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=AZxHEJw5HUfz8R1OwaEl9a0TacuZRcBeb83siGw1DWA=;
	b=KLpJJGNqTOVswfilcT5TmS8mt6rFpCrj055owXe3SKn2C5P1BSUMNO976zldapwV/g95SvIBvfH7M
	 KexRKnCdtkCMKpgwXI82mDPX15LbTs0DDlDZddzhRJc2pz5+3L/3xRVjHYKpPcXbzQe8g2W4WmZrc+
	 4LBylbFpuSFn4KfxPb6MXvwA3j5n2GaTeP4tgv+Li2HNh7k8zNLY7geKo6mU1vc3joaLJYC631FNjE
	 bZptN6x5qm3d5z8yJCxPsHAmPeDUY89Qcj1uqRor8Ao9rpVEsr651jePmA3hBF75tERwNdGYqr4AG5
	 Cr7RvJiXYL88/Hp8s7y9UmMcCpN4W1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752587899; x=1753192699;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=AZxHEJw5HUfz8R1OwaEl9a0TacuZRcBeb83siGw1DWA=;
	b=iLK0oDNmHCpRrpGtOOea2z7gedza8/bJXqguzrkHqtA/DnT5Z6V18dAwsmHltIl7W98KH1PUfYRnu
	 4yZt+3iDw==
X-HalOne-ID: c0fddb25-6183-11f0-b805-d510462faafc
Received: from slottsdator.home (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id c0fddb25-6183-11f0-b805-d510462faafc;
	Tue, 15 Jul 2025 13:58:18 +0000 (UTC)
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
Subject: [PATCH v13 2/4] mm/slub: allow to set node and align in k[v]realloc
Date: Tue, 15 Jul 2025 15:58:15 +0200
Message-Id: <20250715135815.2230224-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reimplement k[v]realloc_node() to be able to set node and
alignment should a user need to do so. In order to do that while
retaining the maximal backward compatibility, add
k[v]realloc_node_align() functions and redefine the rest of API
using these new ones.

While doing that, we also keep the number of  _noprof variants to a
minimum, which implies some changes to the existing users of older
_noprof functions, that basically being bcachefs.

With that change we also provide the ability for the Rust part of
the kernel to set node and alignment in its K[v]xxx
[re]allocations.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 fs/bcachefs/darray.c   |  2 +-
 fs/bcachefs/util.h     |  2 +-
 include/linux/bpfptr.h |  2 +-
 include/linux/slab.h   | 39 +++++++++++++++----------
 lib/rhashtable.c       |  4 +--
 mm/slub.c              | 64 +++++++++++++++++++++++++++++-------------
 6 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/fs/bcachefs/darray.c b/fs/bcachefs/darray.c
index e86d36d23e9e..928e83a1ce42 100644
--- a/fs/bcachefs/darray.c
+++ b/fs/bcachefs/darray.c
@@ -21,7 +21,7 @@ int __bch2_darray_resize_noprof(darray_char *d, size_t element_size, size_t new_
 			return -ENOMEM;
 
 		void *data = likely(bytes < INT_MAX)
-			? kvmalloc_noprof(bytes, gfp)
+			? kvmalloc_node_align_noprof(bytes, 1, gfp, NUMA_NO_NODE)
 			: vmalloc_noprof(bytes);
 		if (!data)
 			return -ENOMEM;
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 0a4b1d433621..2d6d4b547db8 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -61,7 +61,7 @@ static inline void *bch2_kvmalloc_noprof(size_t n, gfp_t flags)
 {
 	void *p = unlikely(n >= INT_MAX)
 		? vmalloc_noprof(n)
-		: kvmalloc_noprof(n, flags & ~__GFP_ZERO);
+		: kvmalloc_node_align_noprof(n, 1, flags & ~__GFP_ZERO, NUMA_NO_NODE);
 	if (p && (flags & __GFP_ZERO))
 		memset(p, 0, n);
 	return p;
diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
index 1af241525a17..f6e0795db484 100644
--- a/include/linux/bpfptr.h
+++ b/include/linux/bpfptr.h
@@ -67,7 +67,7 @@ static inline int copy_to_bpfptr_offset(bpfptr_t dst, size_t offset,
 
 static inline void *kvmemdup_bpfptr_noprof(bpfptr_t src, size_t len)
 {
-	void *p = kvmalloc_noprof(len, GFP_USER | __GFP_NOWARN);
+	void *p = kvmalloc_node_align_noprof(len, 1, GFP_USER | __GFP_NOWARN, NUMA_NO_NODE);
 
 	if (!p)
 		return ERR_PTR(-ENOMEM);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index d5a8ab98035c..6dc300bac2a1 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -465,9 +465,13 @@ int kmem_cache_shrink(struct kmem_cache *s);
 /*
  * Common kmalloc functions provided by all allocators
  */
-void * __must_check krealloc_noprof(const void *objp, size_t new_size,
-				    gfp_t flags) __realloc_size(2);
-#define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
+void * __must_check krealloc_node_align_noprof(const void *objp, size_t new_size,
+					       unsigned long align,
+					       gfp_t flags, int nid) __realloc_size(2);
+#define krealloc_noprof(_o, _s, _f)	krealloc_node_align_noprof(_o, _s, 1, _f, NUMA_NO_NODE)
+#define krealloc_node_align(...)	alloc_hooks(krealloc_node_align_noprof(__VA_ARGS__))
+#define krealloc_node(_o, _s, _f, _n)	krealloc_node_align(_o, _s, 1, _f, _n)
+#define krealloc(...)			krealloc_node(__VA_ARGS__, NUMA_NO_NODE)
 
 void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
@@ -1041,18 +1045,20 @@ static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
 #define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
 #define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
-void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node) __alloc_size(1);
-#define kvmalloc_node_noprof(size, flags, node)	\
-	__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node)
-#define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
-
-#define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
-#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(_size, _flags, NUMA_NO_NODE)
+void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
+			     gfp_t flags, int node) __alloc_size(1);
+#define kvmalloc_node_align_noprof(_size, _align, _flags, _node)	\
+	__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, NULL), _align, _flags, _node)
+#define kvmalloc_node_align(...)		\
+	alloc_hooks(kvmalloc_node_align_noprof(__VA_ARGS__))
+#define kvmalloc_node(_s, _f, _n)		kvmalloc_node_align(_s, 1, _f, _n)
+#define kvmalloc(...)				kvmalloc_node(__VA_ARGS__, NUMA_NO_NODE)
 #define kvzalloc(_size, _flags)			kvmalloc(_size, (_flags)|__GFP_ZERO)
 
 #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
+
 #define kmem_buckets_valloc(_b, _size, _flags)	\
-	alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
+	alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), 1, _flags, NUMA_NO_NODE))
 
 static inline __alloc_size(1, 2) void *
 kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
@@ -1062,7 +1068,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	return kvmalloc_node_noprof(bytes, flags, node);
+	return kvmalloc_node_align_noprof(bytes, 1, flags, node);
 }
 
 #define kvmalloc_array_noprof(...)		kvmalloc_array_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
@@ -1073,9 +1079,12 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 #define kvcalloc_node(...)			alloc_hooks(kvcalloc_node_noprof(__VA_ARGS__))
 #define kvcalloc(...)				alloc_hooks(kvcalloc_noprof(__VA_ARGS__))
 
-void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
-		__realloc_size(2);
-#define kvrealloc(...)				alloc_hooks(kvrealloc_noprof(__VA_ARGS__))
+void *kvrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
+				  gfp_t flags, int nid) __realloc_size(2);
+#define kvrealloc_node_align(...)		\
+	alloc_hooks(kvrealloc_node_align_noprof(__VA_ARGS__))
+#define kvrealloc_node(_p, _s, _f, _n)		kvrealloc_node_align(_p, _s, 1, _f, _n)
+#define kvrealloc(...)				kvrealloc_node(__VA_ARGS__, NUMA_NO_NODE)
 
 extern void kvfree(const void *addr);
 DEFINE_FREE(kvfree, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T))
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 3e555d012ed6..fde0f0e556f8 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -184,8 +184,8 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	static struct lock_class_key __key;
 
 	tbl = alloc_hooks_tag(ht->alloc_tag,
-			kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
-					     gfp|__GFP_ZERO, NUMA_NO_NODE));
+			kvmalloc_node_align_noprof(struct_size(tbl, buckets, nbuckets),
+					     1, gfp|__GFP_ZERO, NUMA_NO_NODE));
 
 	size = nbuckets;
 
diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..80f7b609a18d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4844,7 +4844,7 @@ void kfree(const void *object)
 EXPORT_SYMBOL(kfree);
 
 static __always_inline __realloc_size(2) void *
-__do_krealloc(const void *p, size_t new_size, gfp_t flags)
+__do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
 {
 	void *ret;
 	size_t ks = 0;
@@ -4858,6 +4858,16 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 	if (!kasan_check_byte(p))
 		return NULL;
 
+	/*
+	 * If reallocation is not necessary (e. g. the new size is less
+	 * than the current allocated size), the current allocation will be
+	 * preserved unless __GFP_THISNODE is set. In the latter case a new
+	 * allocation on the requested node will be attempted.
+	 */
+	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
+		     nid != page_to_nid(virt_to_page(p)))
+		goto alloc_new;
+
 	if (is_kfence_address(p)) {
 		ks = orig_size = kfence_ksize(p);
 	} else {
@@ -4880,6 +4890,10 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 	if (new_size > ks)
 		goto alloc_new;
 
+	/* If the old object doesn't satisfy the new alignment, allocate a new one */
+	if (!IS_ALIGNED((unsigned long)p, align))
+		goto alloc_new;
+
 	/* Zero out spare memory. */
 	if (want_init_on_alloc(flags)) {
 		kasan_disable_current();
@@ -4902,7 +4916,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 	return (void *)p;
 
 alloc_new:
-	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
+	ret = kmalloc_node_track_caller_noprof(new_size, flags, nid, _RET_IP_);
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
@@ -4914,10 +4928,12 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 }
 
 /**
- * krealloc - reallocate memory. The contents will remain unchanged.
+ * krealloc_node_align - reallocate memory. The contents will remain unchanged.
  * @p: object to reallocate memory for.
  * @new_size: how many bytes of memory are required.
+ * @align: desired alignment.
  * @flags: the type of memory to allocate.
+ * @nid: NUMA node or NUMA_NO_NODE
  *
  * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
  * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
@@ -4946,7 +4962,8 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
  *
  * Return: pointer to the allocated memory or %NULL in case of error
  */
-void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
+void *krealloc_node_align_noprof(const void *p, size_t new_size, unsigned long align,
+				 gfp_t flags, int nid)
 {
 	void *ret;
 
@@ -4955,13 +4972,13 @@ void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
 		return ZERO_SIZE_PTR;
 	}
 
-	ret = __do_krealloc(p, new_size, flags);
+	ret = __do_krealloc(p, new_size, align, flags, nid);
 	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
 }
-EXPORT_SYMBOL(krealloc_noprof);
+EXPORT_SYMBOL(krealloc_node_align_noprof);
 
 static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
 {
@@ -4992,6 +5009,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
  * failure, fall back to non-contiguous (vmalloc) allocation.
  * @size: size of the request.
  * @b: which set of kmalloc buckets to allocate from.
+ * @align: desired alignment.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
  * @node: numa node to allocate from
  *
@@ -5004,19 +5022,22 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
  *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
-void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
+void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
+			     gfp_t flags, int node)
 {
 	void *ret;
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
-	 * requests
+	 * requests and small alignments
 	 */
-	ret = __do_kmalloc_node(size, PASS_BUCKET_PARAM(b),
-				kmalloc_gfp_adjust(flags, size),
-				node, _RET_IP_);
-	if (ret || size <= PAGE_SIZE)
-		return ret;
+	if (size >= align) {
+		ret = __do_kmalloc_node(size, PASS_BUCKET_PARAM(b),
+					kmalloc_gfp_adjust(flags, size),
+					node, _RET_IP_);
+		if (ret || size <= PAGE_SIZE)
+			return ret;
+	}
 
 	/* non-sleeping allocations are not supported by vmalloc */
 	if (!gfpflags_allow_blocking(flags))
@@ -5034,7 +5055,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 	 * about the resulting pointer, and cannot play
 	 * protection games.
 	 */
-	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VMALLOC_END,
 			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
@@ -5078,10 +5099,12 @@ void kvfree_sensitive(const void *addr, size_t len)
 EXPORT_SYMBOL(kvfree_sensitive);
 
 /**
- * kvrealloc - reallocate memory; contents remain unchanged
+ * kvrealloc_node_align - reallocate memory; contents remain unchanged
  * @p: object to reallocate memory for
  * @size: the size to reallocate
+ * @align: desired alignment
  * @flags: the flags for the page level allocator
+ * @nid: NUMA node id
  *
  * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
  * and @p is not a %NULL pointer, the object pointed to is freed.
@@ -5099,17 +5122,18 @@ EXPORT_SYMBOL(kvfree_sensitive);
  *
  * Return: pointer to the allocated memory or %NULL in case of error
  */
-void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
+void *kvrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
+				  gfp_t flags, int nid)
 {
 	void *n;
 
 	if (is_vmalloc_addr(p))
-		return vrealloc_noprof(p, size, flags);
+		return vrealloc_node_align_noprof(p, size, align, flags, nid);
 
-	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
+	n = krealloc_node_align_noprof(p, size, align, kmalloc_gfp_adjust(flags, size), nid);
 	if (!n) {
 		/* We failed to krealloc(), fall back to kvmalloc(). */
-		n = kvmalloc_noprof(size, flags);
+		n = kvmalloc_node_align_noprof(size, align, flags, nid);
 		if (!n)
 			return NULL;
 
@@ -5125,7 +5149,7 @@ void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
 
 	return n;
 }
-EXPORT_SYMBOL(kvrealloc_noprof);
+EXPORT_SYMBOL(kvrealloc_node_align_noprof);
 
 struct detached_freelist {
 	struct slab *slab;
-- 
2.39.2


