Return-Path: <bpf+bounces-22627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADA8620DB
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEA11C24337
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 23:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D9114DFFC;
	Fri, 23 Feb 2024 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEk4+AcR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE014DFC4
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732667; cv=none; b=T3HmtPXBbYoPLzkX+MfSYscc+OtAzf3jcYT36RZv0vNNcFluQJh+MZJvpwy0fD3t08X2+OQjZ5nf9W31wDh5II8iQjq1GmLyayywt0UFE9CLjqQg/yKtwySjg/c6reClZJ01wkIUBTtVZrSy+dDuJPaTqmnsBWMsvZfwTLyAE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732667; c=relaxed/simple;
	bh=RlWlRZVtotOtw3aZKr9EShTGvPYJ6+b8kE3pX4rZWWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKFoQScKeS5rgrXEn/ycIOUJJnxNUa5tHmVzY+0FDHNoW+egg+LVG/wjOMh3RN/JhuKL1aGECd69kV8YyAEbyv0qMuwkiTG3pvWSADwL03XzUugkCURZnpeiK4xzCXVdahx2wo/RZ6GCJj/Vd0xUiV9jD4qUAEgZB6SuZL80Y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEk4+AcR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbd32cff0bso7456215ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 15:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732664; x=1709337464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T/JxyeGclar7cIIHLQMvHUD6oGOKffCuXl9nke3dJg=;
        b=fEk4+AcRKDyu1/dRrICJDYeIth3ILnmxivk/SjnvArwEacr67wS7bqog48xS+JFFIh
         qztZKEAls7KvVvFR+ec/cZPQ4xyWXDtY92xOcs0H9ywTstukQRrw6jCvevGfuBB1KRCO
         roDSrFGXF4Iv4CuddeD8DyCrxstZqYmqWlsv9pQSaTfBtMFChX0TMoFFjin9waNrkH2z
         7AmUxyD1idDERI8CI3abCZk27FJ6g4w3wt9gSzaQFmNnx9UUP2EKyTZ2RUBIz4UMLVnl
         gdmNT42NFacnOszyho6SngGmvzAGw7htE8E+eEevrwayMIwfU3eJbbhkqYmVrInos2NP
         BWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732664; x=1709337464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T/JxyeGclar7cIIHLQMvHUD6oGOKffCuXl9nke3dJg=;
        b=oys3lPvpUONGYlawG8d2z5bCETgW+659N9+REKje0X8mTDGKbiXT/rGeNn0Xru5v0w
         ViAzxhsruq2QkDZaWFFXZ92h1ma4MIwJIAmiEXtplpegCDv33bwciZLnp4bZeiVL3VR7
         zoaff76PjrmvXpmcCDSJgRmwcgnpMLvmB9OvfkvgzfxLB7etLgmtK4ce9jga+IR4ePRT
         xMNZY75LRiFm+uLg7c5Rv4/Rn4+Vdaw+kKRUNsQT+Hc2gipMrzYnLP92QIFSwKUHZ1Bf
         dKp17dyxr6rHsNqPJ/rJ7M7S/mse3zEiy0mvik1vX/wEcg/OPi5k75n+Gq008GHCGA6d
         1W4Q==
X-Gm-Message-State: AOJu0YxZQkAo6NbE3pBn5Mm53RMcYJlXGud4RIVv0x8VaHj+r0Ig0v73
	TsK2kTtjhwLeLNWZ8XeeGtMG9kyWS1IydJBQVS4V2gdPX9m+cGbyS9cq/8WJ
X-Google-Smtp-Source: AGHT+IGrC0E10ADJh+Q28iXnJRIwpr5YwuUUqZaBfkmopbBhR99u1mcgLWatOYemqm7CQuFVwzUw8A==
X-Received: by 2002:a17:902:c40d:b0:1d9:d341:b150 with SMTP id k13-20020a170902c40d00b001d9d341b150mr1582992plk.40.1708732664121;
        Fri, 23 Feb 2024 15:57:44 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:45de])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902728b00b001dc23e877c1sm6175189pll.265.2024.02.23.15.57.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 15:57:43 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 3/3] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
Date: Fri, 23 Feb 2024 15:57:28 -0800
Message-Id: <20240223235728.13981-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

vmap/vmalloc APIs are used to map a set of pages into contiguous kernel virtual space.

get_vm_area() with appropriate flag is used to request an area of kernel address range.
It'se used for vmalloc, vmap, ioremap, xen use cases.
- vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag.
- the areas created by vmap() function should be tagged with VM_MAP.
- ioremap areas are tagged with VM_IOREMAP.
- xen use cases are VM_XEN.

BPF would like to extend the vmap API to implement a lazily-populated
sparse, yet contiguous kernel virtual space.
Introduce VM_SPARSE vm_area flag and
vm_area_map_pages(area, start_addr, count, pages) API to map a set
of pages within a given area.
It has the same sanity checks as vmap() does.
It also checks that get_vm_area() was created with VM_SPARSE flag
which identifies such areas in /proc/vmallocinfo
and returns zero pages on read through /proc/kcore.

The next commits will introduce bpf_arena which is a sparsely populated shared
memory region between bpf program and user space process. It will map
privately-managed pages into a sparse vm area with the following steps:

  area = get_vm_area(area_size, VM_SPARSE);  // at bpf prog verification time
  vm_area_map_pages(area, kaddr, 1, page);   // on demand
                    // it will return an error if kaddr is out of range
  vm_area_unmap_pages(area, kaddr, 1);
  free_vm_area(area);                        // after bpf prog is unloaded

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/vmalloc.h |  4 +++
 mm/vmalloc.c            | 55 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 223e51c243bc..416bc7b0b4db 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -29,6 +29,7 @@ struct iov_iter;		/* in uio.h */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 #define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
 #define VM_XEN			0x00000800	/* xen use cases */
+#define VM_SPARSE		0x00001000	/* sparse vm_area. not all pages are present. */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 	!defined(CONFIG_KASAN_VMALLOC)
@@ -233,6 +234,9 @@ static inline bool is_vm_area_hugepages(const void *addr)
 }
 
 #ifdef CONFIG_MMU
+int vm_area_map_pages(struct vm_struct *area, unsigned long addr, unsigned int count,
+		      struct page **pages);
+int vm_area_unmap_pages(struct vm_struct *area, unsigned long addr, unsigned int count);
 void vunmap_range(unsigned long addr, unsigned long end);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d769a65bddad..a05dfbbacb78 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -648,6 +648,54 @@ static int vmap_pages_range(unsigned long addr, unsigned long end,
 	return err;
 }
 
+/**
+ * vm_area_map_pages - map pages inside given vm_area
+ * @area: vm_area
+ * @addr: start address inside vm_area
+ * @count: number of pages
+ * @pages: pages to map (always PAGE_SIZE pages)
+ */
+int vm_area_map_pages(struct vm_struct *area, unsigned long addr, unsigned int count,
+		      struct page **pages)
+{
+	unsigned long size = ((unsigned long)count) * PAGE_SIZE;
+	unsigned long end = addr + size;
+
+	might_sleep();
+	if (WARN_ON_ONCE(area->flags & VM_FLUSH_RESET_PERMS))
+		return -EINVAL;
+	if (WARN_ON_ONCE(area->flags & VM_NO_GUARD))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!(area->flags & VM_SPARSE)))
+		return -EINVAL;
+	if (count > totalram_pages())
+		return -E2BIG;
+	if (addr < (unsigned long)area->addr || (void *)end > area->addr + area->size)
+		return -ERANGE;
+
+	return vmap_pages_range(addr, end, PAGE_KERNEL, pages, PAGE_SHIFT);
+}
+
+/**
+ * vm_area_unmap_pages - unmap pages inside given vm_area
+ * @area: vm_area
+ * @addr: start address inside vm_area
+ * @count: number of pages to unmap
+ */
+int vm_area_unmap_pages(struct vm_struct *area, unsigned long addr, unsigned int count)
+{
+	unsigned long size = ((unsigned long)count) * PAGE_SIZE;
+	unsigned long end = addr + size;
+
+	if (WARN_ON_ONCE(!(area->flags & VM_SPARSE)))
+		return -EINVAL;
+	if (addr < (unsigned long)area->addr || (void *)end > area->addr + area->size)
+		return -ERANGE;
+
+	vunmap_range(addr, end);
+	return 0;
+}
+
 int is_vmalloc_or_module_addr(const void *x)
 {
 	/*
@@ -3822,9 +3870,9 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (flags & VMAP_RAM)
 			copied = vmap_ram_vread_iter(iter, addr, n, flags);
-		else if (!(vm && (vm->flags & (VM_IOREMAP | VM_XEN))))
+		else if (!(vm && (vm->flags & (VM_IOREMAP | VM_XEN | VM_SPARSE))))
 			copied = aligned_vread_iter(iter, addr, n);
-		else /* IOREMAP|XEN area is treated as memory hole */
+		else /* IOREMAP|XEN|SPARSE area is treated as memory hole */
 			copied = zero_iter(iter, n);
 
 		addr += copied;
@@ -4418,6 +4466,9 @@ static int s_show(struct seq_file *m, void *p)
 	if (v->flags & VM_XEN)
 		seq_puts(m, " xen");
 
+	if (v->flags & VM_SPARSE)
+		seq_puts(m, " sparse");
+
 	if (v->flags & VM_ALLOC)
 		seq_puts(m, " vmalloc");
 
-- 
2.34.1


