Return-Path: <bpf+bounces-65126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56081B1C67F
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AC77B199F
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3028BA92;
	Wed,  6 Aug 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="fDzJflG0";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="nxrSyIPu"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CC215198
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485119; cv=none; b=oZs+w2HmB1x5nfr/hEpEoqpZgEoyPrI4RucMkFauKVzOd1zpTDcly9ztsQ3V80QXQc3tGcPupoUwOC+zLiLqDOS+OIxNggdaIfTDRXel+SSPA/MNL6hG7z8WAcHY0SxRhXHFDFK8d/j7dQa4MUrwMbWZJiKS5f7TuaKHopraIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485119; c=relaxed/simple;
	bh=9XRG/5GpA945fiS/Q4AstZSlN06ErQkYyWIrf1CmfBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utyEtmmvPQEbQTJBpAiGm80JR8GSjgIoLB/t98jGj7PTDpaotnr2OCZIgTOetnYpDcw3nkXwUzN++GkIE6OU4SWKOW2A7ywr4tiY7mdERrvhJ++84oXpyuq0muMPBmzOUtWMeNDtZ7OpwelmpbnJ4LVGgzPKfXqzN2zJWRTsEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=fDzJflG0; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=nxrSyIPu; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754485116; x=1755089916;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=sFGu5BXaHdw7qt33g/urIepCBkzhd5+wVoobk3GWVFk=;
	b=fDzJflG0Xf+anBPajbpNMaIwDk1XtW0QZ2vsxOEf2MwhI5BbS7yxAkYZwA6ql7GqThbRpV9vQZ/1c
	 ZEefaRToFFd7kEqUB+dH5cnmlO5XF+kt/Jjj+xCzgtLRzDh8YG+WRfZZ3p+/BzvxD8c8ywmTdmM2aq
	 oPlXN0m8d34gvu8mk4E6rhnQ9WQqz+ZealKuz5Zm5PscCMUR9mPEBOZ2lvcWlSfOcEXUgU909eXwjZ
	 Kh9EX1dvyt0Pcw8Bn0DKsUqr+2iQhJM7yH6Wq6rUsGmVYWsTqsVwMp7nccZ7X6/mfFh2yRejseFyCq
	 FpsuIMEyv58485dfeDzxVfcxL3N/u9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754485116; x=1755089916;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=sFGu5BXaHdw7qt33g/urIepCBkzhd5+wVoobk3GWVFk=;
	b=nxrSyIPuFxJvBvGYzbokaEzckF2VsQhhDZ8WbQq3DvuqC84KGmIryiQNXeCVHEq8DDSuNhkm3L5Ny
	 J1gw/pkDg==
X-HalOne-ID: 0ff7d6ea-72c5-11f0-a1f4-f78b1f841584
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 0ff7d6ea-72c5-11f0-a1f4-f78b1f841584;
	Wed, 06 Aug 2025 12:58:36 +0000 (UTC)
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
Subject: [PATCH v15 4/4] rust: support large alignments in allocations
Date: Wed,  6 Aug 2025 14:55:52 +0200
Message-Id: <20250806125552.1727073-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250806124034.1724515-1-vitaly.wool@konsulko.se>
References: <20250806124034.1724515-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for large (> PAGE_SIZE) alignments in Rust allocators.
All the preparations on the C side are already done, we just need
to add bindings for <alloc>_node_align() functions and start
using those.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/slab.c            | 10 ++++++----
 rust/helpers/vmalloc.c         |  5 +++--
 rust/kernel/alloc/allocator.rs | 30 +++++++++---------------------
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
index 8472370a4338..7fac958907b0 100644
--- a/rust/helpers/slab.c
+++ b/rust/helpers/slab.c
@@ -3,13 +3,15 @@
 #include <linux/slab.h>
 
 void * __must_check __realloc_size(2)
-rust_helper_krealloc_node(const void *objp, size_t new_size, gfp_t flags, int node)
+rust_helper_krealloc_node_align(const void *objp, size_t new_size, unsigned long align,
+				gfp_t flags, int node)
 {
-	return krealloc_node(objp, new_size, flags, node);
+	return krealloc_node_align(objp, new_size, align, flags, node);
 }
 
 void * __must_check __realloc_size(2)
-rust_helper_kvrealloc_node(const void *p, size_t size, gfp_t flags, int node)
+rust_helper_kvrealloc_node_align(const void *p, size_t size, unsigned long align,
+				 gfp_t flags, int node)
 {
-	return kvrealloc_node(p, size, flags, node);
+	return kvrealloc_node_align(p, size, align, flags, node);
 }
diff --git a/rust/helpers/vmalloc.c b/rust/helpers/vmalloc.c
index 62d30db9a1a6..7d7f7336b3d2 100644
--- a/rust/helpers/vmalloc.c
+++ b/rust/helpers/vmalloc.c
@@ -3,7 +3,8 @@
 #include <linux/vmalloc.h>
 
 void * __must_check __realloc_size(2)
-rust_helper_vrealloc_node(const void *p, size_t size, gfp_t flags, int node)
+rust_helper_vrealloc_node_align(const void *p, size_t size, unsigned long align,
+				gfp_t flags, int node)
 {
-	return vrealloc_node(p, size, flags, node);
+	return vrealloc_node_align(p, size, align, flags, node);
 }
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 8af7e04e3cc6..63f271624428 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -15,7 +15,6 @@
 
 use crate::alloc::{AllocError, Allocator, NumaNode};
 use crate::bindings;
-use crate::pr_warn;
 
 /// The contiguous kernel allocator.
 ///
@@ -56,25 +55,26 @@ fn aligned_size(new_layout: Layout) -> usize {
 
 /// # Invariants
 ///
-/// One of the following: `krealloc_node`, `vrealloc_node`, `kvrealloc_node`.
+/// One of the following: `krealloc_node_align`, `vrealloc_node_align`, `kvrealloc_node_align`.
 struct ReallocFunc(
     unsafe extern "C" fn(
         *const crate::ffi::c_void,
         usize,
+        crate::ffi::c_ulong,
         u32,
         crate::ffi::c_int,
     ) -> *mut crate::ffi::c_void,
 );
 
 impl ReallocFunc {
-    // INVARIANT: `krealloc_node` satisfies the type invariants.
-    const KREALLOC: Self = Self(bindings::krealloc_node);
+    // INVARIANT: `krealloc_node_align` satisfies the type invariants.
+    const KREALLOC: Self = Self(bindings::krealloc_node_align);
 
-    // INVARIANT: `vrealloc_node` satisfies the type invariants.
-    const VREALLOC: Self = Self(bindings::vrealloc_node);
+    // INVARIANT: `vrealloc_node_align` satisfies the type invariants.
+    const VREALLOC: Self = Self(bindings::vrealloc_node_align);
 
-    // INVARIANT: `kvrealloc_node` satisfies the type invariants.
-    const KVREALLOC: Self = Self(bindings::kvrealloc_node);
+    // INVARIANT: `kvrealloc_node_align` satisfies the type invariants.
+    const KVREALLOC: Self = Self(bindings::kvrealloc_node_align);
 
     /// # Safety
     ///
@@ -116,7 +116,7 @@ unsafe fn call(
         // - Those functions provide the guarantees of this function.
         let raw_ptr = unsafe {
             // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
-            self.0(ptr.cast(), size, flags.0, nid.0).cast()
+            self.0(ptr.cast(), size, layout.align(), flags.0, nid.0).cast()
         };
 
         let ptr = if size == 0 {
@@ -160,12 +160,6 @@ unsafe fn realloc(
         flags: Flags,
         nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        // TODO: Support alignments larger than PAGE_SIZE.
-        if layout.align() > bindings::PAGE_SIZE {
-            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
-            return Err(AllocError);
-        }
-
         // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
         // allocated with this `Allocator`.
         unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags, nid) }
@@ -185,12 +179,6 @@ unsafe fn realloc(
         flags: Flags,
         nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        // TODO: Support alignments larger than PAGE_SIZE.
-        if layout.align() > bindings::PAGE_SIZE {
-            pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
-            return Err(AllocError);
-        }
-
         // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
         // allocated with this `Allocator`.
         unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags, nid) }
-- 
2.39.2


