Return-Path: <bpf+bounces-23101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D0886D7FC
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 00:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8251C21731
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FDC134419;
	Thu, 29 Feb 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoZSjPKo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37375810
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250217; cv=none; b=l4FvP0QJlvMZCTTKnE8iHdfp2bSnWKEBVFdLsGG6zcrLJbnqDtKSeg6AkVIPBjuJIXIVMI9OSBdgUcc5NOnokhtgd156zyHWBCBdTkyGSEqJoYhXxj1D18I7m2dQFwOdm3+ZjptvWg45PRLVM8/2c/s/ePbp7OTinQL8VUNsRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250217; c=relaxed/simple;
	bh=KV9yKyi7g8b2XBoUUKtG/nY6fqGizf0qXFjKAgiqVEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O21n9/yqu+y/zYYRdhlwSj/F/viQvSJIpxLvsZrmPmkh1zQW5F5fgcHHcnc7fG8fjqqK48KahlCOxDUFIRjADHqSgyNOEAJucIgp4LHskSG/FPuWXfD6fozrQcCSfcfgx4OxAWT0N9gJzUlscKBMwSwdT3lAi3McfQqBrARQ57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoZSjPKo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so341636b3a.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709250214; x=1709855014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGmuzG0BuzfpsyKgKDkTT6Enikl3D6AjMcJQdJLpWcI=;
        b=HoZSjPKoguMWLDsZ+7iXqDtiXlMXHDcDaXGJJFpaEhYtADbaqVzdVFuKSUBmhdeJ8j
         4K0351XPgAu5IrmiztY9b4x14BWveePnX7TLQfoWqIGjfdMtjz90WBCAWafaW1aYeHrv
         vJ775clVev8htasWtUu9T0MGyXijBNeFMGcrBILyLtrq+dhJQEfitlnKRM+O63BhfFu8
         clpJkpCbID4lyziMybTR/47DSQiGkKUj3wi9m+bF0iTmHb0AarCU5YPwtDehsc4WCf6z
         346OTNYNIV4Cqok5tc7RI3j1L8449b5USX4wDFohWOknqBj5+CsNdaDIViQPcndEgfCF
         mj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250214; x=1709855014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGmuzG0BuzfpsyKgKDkTT6Enikl3D6AjMcJQdJLpWcI=;
        b=pIlvudJRPnHWAbsbv2b7M3BVVaFq/Vsw6NU7ADFb2OHZKvZk3aqg1l4B9uYxpCqc+f
         W7fbZA0jwddPuG0nPmUOgGJKiIWXtSbdhyvvmOv572vZWgfwBKiOw/ZXl1O4Vx2KtAIn
         CfZnHGXD6QpB5sXIyGx2CwqyNcNzKy8gnCJuQwk5z7vrhDO6ZeFC3n5rCjdSDO8g+Sxx
         qpYmGGVxey8N2OXego7mtpc0O2Bfz437s/Mn/l2GYn4ABBGK4LO9GdD99Jb4K0jkoTT4
         YnnDO990DFdHrsPLDRx2pW9n8UV8jRyyGNHeF8Xa0YSXydhWduM3s5na0YPiYBPOtP2Y
         Io/Q==
X-Gm-Message-State: AOJu0Yz1LL1tvKxnDIJvfQHLHvaPOgAij7PmrVyXhShszvR28cQ9+I8N
	83oAJsdHdNz6bRan0jWspwTvwt7PvzGioHuHnCsj9f2UuKWzLkLuA6TIt+SS
X-Google-Smtp-Source: AGHT+IHI1rET3Z0/K8864m6GkWZwYbKsdcM+bbhi3ZQPOLm9p/XFzMkvrTJzDnJ+bGJeFJuwnOye6Q==
X-Received: by 2002:a05:6a00:92a2:b0:6e4:84db:e30e with SMTP id jw34-20020a056a0092a200b006e484dbe30emr186581pfb.32.1709250214399;
        Thu, 29 Feb 2024 15:43:34 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79ec8000000b006e50cedb59bsm1850608pfq.16.2024.02.29.15.43.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 15:43:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	boris.ostrovsky@oracle.com,
	sstabellini@kernel.org,
	jgross@suse.com,
	linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 3/3] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
Date: Thu, 29 Feb 2024 15:43:16 -0800
Message-Id: <20240229234316.44409-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240229234316.44409-1-alexei.starovoitov@gmail.com>
References: <20240229234316.44409-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

vmap/vmalloc APIs are used to map a set of pages into contiguous kernel
virtual space.

get_vm_area() with appropriate flag is used to request an area of kernel
address range. It'se used for vmalloc, vmap, ioremap, xen use cases.
- vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag.
- the areas created by vmap() function should be tagged with VM_MAP.
- ioremap areas are tagged with VM_IOREMAP.
- xen use cases are VM_XEN.

BPF would like to extend the vmap API to implement a lazily-populated
sparse, yet contiguous kernel virtual space. Introduce VM_SPARSE flag
and vm_area_map_pages(area, start_addr, count, pages) API to map a set
of pages within a given area.
It has the same sanity checks as vmap() does.
It also checks that get_vm_area() was created with VM_SPARSE flag
which identifies such areas in /proc/vmallocinfo
and returns zero pages on read through /proc/kcore.

The next commits will introduce bpf_arena which is a sparsely populated
shared memory region between bpf program and user space process. It will
map privately-managed pages into a sparse vm area with the following steps:

  // request virtual memory region during bpf prog verification
  area = get_vm_area(area_size, VM_SPARSE);

  // on demand
  vm_area_map_pages(area, kaddr, kend, pages);
  vm_area_unmap_pages(area, kaddr, kend);

  // after bpf program is detached and unloaded
  free_vm_area(area);

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/vmalloc.h |  5 ++++
 mm/vmalloc.c            | 59 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 71075ece0ed2..dfbcfb9f9a08 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -29,6 +29,7 @@ struct iov_iter;		/* in uio.h */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 #define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
 #define VM_XEN			0x00000800	/* xen grant table and xenbus use cases */
+#define VM_SPARSE		0x00001000	/* sparse vm_area. not all pages are present. */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 	!defined(CONFIG_KASAN_VMALLOC)
@@ -233,6 +234,10 @@ static inline bool is_vm_area_hugepages(const void *addr)
 }
 
 #ifdef CONFIG_MMU
+int vm_area_map_pages(struct vm_struct *area, unsigned long start,
+		      unsigned long end, struct page **pages);
+void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
+			 unsigned long end);
 void vunmap_range(unsigned long addr, unsigned long end);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d53ece3f38ee..dae98b1f78a8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -648,6 +648,58 @@ static int vmap_pages_range(unsigned long addr, unsigned long end,
 	return err;
 }
 
+static int check_sparse_vm_area(struct vm_struct *area, unsigned long start,
+				unsigned long end)
+{
+	might_sleep();
+	if (WARN_ON_ONCE(area->flags & VM_FLUSH_RESET_PERMS))
+		return -EINVAL;
+	if (WARN_ON_ONCE(area->flags & VM_NO_GUARD))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!(area->flags & VM_SPARSE)))
+		return -EINVAL;
+	if ((end - start) >> PAGE_SHIFT > totalram_pages())
+		return -E2BIG;
+	if (start < (unsigned long)area->addr ||
+	    (void *)end > area->addr + get_vm_area_size(area))
+		return -ERANGE;
+	return 0;
+}
+
+/**
+ * vm_area_map_pages - map pages inside given sparse vm_area
+ * @area: vm_area
+ * @start: start address inside vm_area
+ * @end: end address inside vm_area
+ * @pages: pages to map (always PAGE_SIZE pages)
+ */
+int vm_area_map_pages(struct vm_struct *area, unsigned long start,
+		      unsigned long end, struct page **pages)
+{
+	int err;
+
+	err = check_sparse_vm_area(area, start, end);
+	if (err)
+		return err;
+
+	return vmap_pages_range(start, end, PAGE_KERNEL, pages, PAGE_SHIFT);
+}
+
+/**
+ * vm_area_unmap_pages - unmap pages inside given sparse vm_area
+ * @area: vm_area
+ * @start: start address inside vm_area
+ * @end: end address inside vm_area
+ */
+void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
+			 unsigned long end)
+{
+	if (check_sparse_vm_area(area, start, end))
+		return;
+
+	vunmap_range(start, end);
+}
+
 int is_vmalloc_or_module_addr(const void *x)
 {
 	/*
@@ -3822,9 +3874,9 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (flags & VMAP_RAM)
 			copied = vmap_ram_vread_iter(iter, addr, n, flags);
-		else if (!(vm && (vm->flags & (VM_IOREMAP | VM_XEN))))
+		else if (!(vm && (vm->flags & (VM_IOREMAP | VM_XEN | VM_SPARSE))))
 			copied = aligned_vread_iter(iter, addr, n);
-		else /* IOREMAP | XEN area is treated as memory hole */
+		else /* IOREMAP | XEN | SPARSE area is treated as memory hole */
 			copied = zero_iter(iter, n);
 
 		addr += copied;
@@ -4418,6 +4470,9 @@ static int s_show(struct seq_file *m, void *p)
 	if (v->flags & VM_XEN)
 		seq_puts(m, " xen");
 
+	if (v->flags & VM_SPARSE)
+		seq_puts(m, " sparse");
+
 	if (v->flags & VM_ALLOC)
 		seq_puts(m, " vmalloc");
 
-- 
2.34.1


