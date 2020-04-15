Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EF01AB3C2
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 00:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgDOWXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 18:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726201AbgDOWXV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Apr 2020 18:23:21 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7BC061A0F
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 15:23:19 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id h6so570455wmi.7
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1mIzf0uNJ1HQHSrhnAJYE+OaaNLEalR5nV8OrmGRp7Q=;
        b=poMVaLmZKcdcG4Bcnx75nTnUfAeTVUBbSMRILdWrxvxVpUbfv9HFq6Pemby1CsT/fT
         k+/QnoQB850GaS3TsSdLhVxdbwa9CfwxhS6O7eBACVCAPW0yD95HpJAYn2dq6LR2Obc6
         ddDNnZa+R8Ko+HWsj7W5NbHrr8oPUcpODFOGeDKojz8RghWgVgLMoL5rkotLQ8zdEX5G
         kT98bNuIZPtygPXOe+idOGBcWhGsWm/hOYLhMMtGummX0ehzhvxXeIQqfO2wzs35lxWX
         GruxOJh+SGsWu0zIRfue5b+IlZHotMFkSNM6OewW/ijGMwt64yxNVJ7y0aGfUfCZcxdn
         pS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1mIzf0uNJ1HQHSrhnAJYE+OaaNLEalR5nV8OrmGRp7Q=;
        b=VdkdbSQHthrXixw1tq50acCsgKfWJVfFrCO8iOJpWRy8aSsV/PW/LcPhaK8LWIZjKF
         ZlM3JW/vgAnj+vBKXv+zJzxO6gbo9RM/ZLvX80SITLYjCiBcmRBLhIHmLT6R6Nvbm2Te
         xzzWj0oVGPFHt1hUqaLVGhwM0w9WTcvxoGj1V+gTkfbVsY3S2wdWJ/qbkEEnkY/qe3bN
         +4rMQt+5pEiSCOAgEmnRM7DARhir1nrwhWj54tkHaCh8xbjIZ+qRoFdMH+trXPlaeNml
         s72hwQ76mjt0V0iBFMBFtXa8UZr/MLFMlKPfNDdmL6nwfVDDbCnwNNKF5g8VXEPyRfbU
         yEaw==
X-Gm-Message-State: AGi0PubcPpv9smrUbD9bjc1oC1bcVEi9aKAq+RCKPf90hAE6he6G/Sdo
        DmKP15KxMGfu0xtqIKRu8vp0vQPWRQ==
X-Google-Smtp-Source: APiQypJPKdrDSHFKJN23DtNTfbMmvVvnzTvIvil6PSbMBOaJJFx9sscPfhIkTKVVc6rydsLOzcHl9F2HyQ==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr29887988wro.286.1586989398145;
 Wed, 15 Apr 2020 15:23:18 -0700 (PDT)
Date:   Thu, 16 Apr 2020 00:23:12 +0200
Message-Id: <20200415222312.236431-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] vmalloc: Fix remap_vmalloc_range() bounds checks
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

remap_vmalloc_range() has had various issues with the bounds checks it
promises to perform ("This function checks that addr is a valid vmalloc'ed
area, and that it is big enough to cover the vma") over time, e.g.:

 - not detecting pgoff<<PAGE_SHIFT overflow
 - not detecting (pgoff<<PAGE_SHIFT)+usize overflow
 - not checking whether addr and addr+(pgoff<<PAGE_SHIFT) are the same
   vmalloc allocation
 - comparing a potentially wildly out-of-bounds pointer with the end of the
   vmalloc region

In particular, since commit fc9702273e2e ("bpf: Add mmap() support for
BPF_MAP_TYPE_ARRAY"), unprivileged users can cause kernel null pointer
dereferences by calling mmap() on a BPF map with a size that is bigger than
the distance from the start of the BPF map to the end of the address space.
This could theoretically be used as a kernel ASLR bypass, by using whether
mmap() with a given offset oopses or returns an error code to perform a
binary search over the possible address range.

To allow remap_vmalloc_range_partial() to verify that addr and
addr+(pgoff<<PAGE_SHIFT) are in the same vmalloc region, pass the offset
to remap_vmalloc_range_partial() instead of adding it to the pointer in
remap_vmalloc_range().

In remap_vmalloc_range_partial(), fix the check against get_vm_area_size()
by using size comparisons instead of pointer comparisons, and add checks
for pgoff.

Cc: stable@vger.kernel.org
Fixes: 833423143c3a ("[PATCH] mm: introduce remap_vmalloc_range()")
Signed-off-by: Jann Horn <jannh@google.com>
---
I'm just sending this on the public list, since the worst-case impact for
non-root users is leaking kernel pointers to userspace. In a context where
you can reach BPF (no sandboxing), I don't think that kernel ASLR is very
effective at the moment anyway.

 fs/proc/vmcore.c         |  5 +++--
 include/linux/vmalloc.h  |  2 +-
 mm/vmalloc.c             | 16 +++++++++++++---
 samples/vfio-mdev/mdpy.c |  2 +-
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7dc800cce3543..c663202da8de7 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -266,7 +266,8 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
-			if (remap_vmalloc_range_partial(vma, dst, buf, tsz)) {
+			if (remap_vmalloc_range_partial(vma, dst, buf, 0,
+							tsz)) {
 				ret = -EFAULT;
 				goto out_unlock;
 			}
@@ -624,7 +625,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)start, size);
 		kaddr = elfnotes_buf + start - elfcorebuf_sz - vmcoredd_orig_sz;
 		if (remap_vmalloc_range_partial(vma, vma->vm_start + len,
-						kaddr, tsz))
+						kaddr, 0, tsz))
 			goto fail;
 
 		size -= tsz;
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 0507a162ccd0e..a95d3cc74d79b 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -137,7 +137,7 @@ extern void vunmap(const void *addr);
 
 extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 				       unsigned long uaddr, void *kaddr,
-				       unsigned long size);
+				       unsigned long pgoff, unsigned long size);
 
 extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 							unsigned long pgoff);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 399f219544f74..9a8227afa0738 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -34,6 +34,7 @@
 #include <linux/llist.h>
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
+#include <linux/overflow.h>
 
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
@@ -3054,6 +3055,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
  * @vma:		vma to cover
  * @uaddr:		target user address to start at
  * @kaddr:		virtual address of vmalloc kernel memory
+ * @pgoff:		offset from @kaddr to start at
  * @size:		size of map area
  *
  * Returns:	0 for success, -Exxx on failure
@@ -3066,9 +3068,15 @@ long vwrite(char *buf, char *addr, unsigned long count)
  * Similar to remap_pfn_range() (see mm/memory.c)
  */
 int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
-				void *kaddr, unsigned long size)
+				void *kaddr, unsigned long pgoff,
+				unsigned long size)
 {
 	struct vm_struct *area;
+	unsigned long off;
+	unsigned long end_index;
+
+	if (check_shl_overflow(pgoff, PAGE_SHIFT, &off))
+		return -EINVAL;
 
 	size = PAGE_ALIGN(size);
 
@@ -3082,8 +3090,10 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 	if (!(area->flags & (VM_USERMAP | VM_DMA_COHERENT)))
 		return -EINVAL;
 
-	if (kaddr + size > area->addr + get_vm_area_size(area))
+	if (check_add_overflow(size, off, &end_index) ||
+	    end_index > get_vm_area_size(area))
 		return -EINVAL;
+	kaddr += off;
 
 	do {
 		struct page *page = vmalloc_to_page(kaddr);
@@ -3122,7 +3132,7 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 						unsigned long pgoff)
 {
 	return remap_vmalloc_range_partial(vma, vma->vm_start,
-					   addr + (pgoff << PAGE_SHIFT),
+					   addr, pgoff,
 					   vma->vm_end - vma->vm_start);
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
index cc86bf6566e42..9894693f3be17 100644
--- a/samples/vfio-mdev/mdpy.c
+++ b/samples/vfio-mdev/mdpy.c
@@ -418,7 +418,7 @@ static int mdpy_mmap(struct mdev_device *mdev, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	return remap_vmalloc_range_partial(vma, vma->vm_start,
-					   mdev_state->memblk,
+					   mdev_state->memblk, 0,
 					   vma->vm_end - vma->vm_start);
 }
 

base-commit: 8632e9b5645bbc2331d21d892b0d6961c1a08429
-- 
2.26.0.110.g2183baf09c-goog

