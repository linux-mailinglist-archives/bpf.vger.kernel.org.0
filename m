Return-Path: <bpf+bounces-22335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F2485C4BD
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8FD1C21FC0
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86D1369A8;
	Tue, 20 Feb 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBJ39GlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F612EBEC
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457180; cv=none; b=XIQj3y63gnWs04RPvnzPkNsTthSbAlQoV9+oQymSRES5PX8sEuOMrJTFPB+S8UjyvqCkIHmnMO4tR+YwMGn/WL+L8KXZe1LFxSb2CMh8OpQBXRJDzBEOihk640x3sG/vV9w1HsZ+ase40IpReaBWpNFP1a4RbgdZKgZCSpBWejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457180; c=relaxed/simple;
	bh=/9xvc1O7tWO8OH5z4rh+7D+5cn0qhyZ2sPdbpvOvLks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZj/4z3yHVvSb2ZOqbDw1KEFA4lSzwlF7EkOnTPCtfr+bTF3YrsA/lVv0IJO2+886DxWiv3LADrNtQrMYLKcCUkFpYGXRmdH816V+xfeg3X3nTxUXEWECpzaT2ETOq8Wz2InZga8TixS69AmBRy+claOjwhRY4QWfs3A9+ZQFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBJ39GlW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dbd32cff0bso23564045ad.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708457178; x=1709061978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbsUkow/oAiTwTXzAYe7YvLlZhgnFaTumNCFpEDptvY=;
        b=KBJ39GlWssr60XJvyfbcJPzpiRti5eEXv9v8XyJ8/3SC1rNeWaw4Q7iaQd4Gs2eRyQ
         NICEgzb7C3i4CzrbM1Pfm3W5q0aW825lq6SZGqTi89Ouw6gWnKZMtkLyCJdHFQyaVAIt
         u4KAQs/Icerinv+3oB7vkMbbArUWLuJtxDnMmElmsfmzXO8L8r/kG1fQTsijUk6UnSmf
         8nc5I2d5bvjHvyMq5sbqfZZscr3rE9jc1cC1z+Q7kLwg1t0rxl8Zus0JxrN7xzCcDqVM
         uUsDyOCw1J0EtGkziK0CelQY9rENw8iBBUN8C5sOj0E3qCoUW2mFgqSnWGGJHP50FcnL
         9a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708457178; x=1709061978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbsUkow/oAiTwTXzAYe7YvLlZhgnFaTumNCFpEDptvY=;
        b=xE2c3wYTdSi+IXkSVeIpn/MM8vxz218+qao+pYbAH1b5Zaf+yJzuuvAf6bqjfBxAWz
         XJf4x00hU/fBtQuwrVcNfaFXTe37sOhUj1IPZF5BfvxvAvNX41pfA5dp0Ru/DPQfqMkb
         GENx6xR/xm+BcSAEuoYbRbZrNrkZWK87G0Fy7prqueI/l8e0A2EzYXZOoxRrHMftSt23
         ZD5+VgUwHP6juLwduOVNmS5XpXM5uaVJioiRxhA42IK72xEArJcOqnWAFXEf8jBLyiR6
         Xu+KHO3d2aH93gFNMPhHVbCCHtcWeWPBFFGUavbnTHqLgOkrmLB3KiHzYX+W2KvaAhFG
         1TSA==
X-Gm-Message-State: AOJu0Yy4qzKhwAuAMVdeDx2FF04CYgAD7cfyh5DWPGPjpKK+JwHc1Br6
	RMPaLlqtF5wZUnEHcpCOojaaMrbOgOeJiCYjoLYu7uIQnZiPdgYNPyQB17MK
X-Google-Smtp-Source: AGHT+IHxhJ+utJfB5SoIVUC1hkyrBK1kgV2gS7bGydSFtzZP5wRbTlnyeVyIkE8ZXltjEjSELgtIZw==
X-Received: by 2002:a17:902:d2ca:b0:1db:e1f4:d454 with SMTP id n10-20020a170902d2ca00b001dbe1f4d454mr7989029plc.12.1708457177734;
        Tue, 20 Feb 2024 11:26:17 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:504e])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001dbc3f2e7e8sm6382109plc.98.2024.02.20.11.26.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Feb 2024 11:26:16 -0800 (PST)
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
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] mm: Introduce vm_area_[un]map_pages().
Date: Tue, 20 Feb 2024 11:26:13 -0800
Message-Id: <20240220192613.8840-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

vmap() API is used to map a set of pages into contiguous kernel virtual space.

BPF would like to extend the vmap API to implement a lazily-populated
contiguous kernel virtual space which size and start address is fixed early.

The vmap API has functions to request and release areas of kernel address space:
get_vm_area() and free_vm_area().

Introduce vm_area_map_pages(area, start_addr, count, pages)
to map a set of pages within a given area.
It has the same sanity checks as vmap() does.
In addition it also checks that get_vm_area() was created with VM_MAP flag
(as all users of vmap() should be doing).

Also add vm_area_unmap_pages() that is a safer alternative to
existing vunmap_range() api.

The next commits will introduce bpf_arena which is a sparsely populated shared
memory region between bpf program and user space process. It will map
privately-managed pages into an existing vm area with the following steps:

  area = get_vm_area(area_size, VM_MAP | VM_USERMAP); // at bpf prog verification time
  vm_area_map_pages(area, kaddr, 1, page);            // on demand
  vm_area_unmap_pages(area, kaddr, 1);
  free_vm_area(area);                                 // after bpf prog is unloaded

For BPF use case the area_size will be 4Gbyte plus 64Kbyte of guard pages and
area->addr known and fixed at the program verification time.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/vmalloc.h |  3 +++
 mm/vmalloc.c            | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..7d112cc5f2a3 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -232,6 +232,9 @@ static inline bool is_vm_area_hugepages(const void *addr)
 }
 
 #ifdef CONFIG_MMU
+int vm_area_map_pages(struct vm_struct *area, unsigned long addr, unsigned int count,
+		      struct page **pages);
+int vm_area_unmap_pages(struct vm_struct *area, unsigned long addr, unsigned int count);
 void vunmap_range(unsigned long addr, unsigned long end);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..d6337d46f1d8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -635,6 +635,52 @@ static int vmap_pages_range(unsigned long addr, unsigned long end,
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
+	if (WARN_ON_ONCE(!(area->flags & VM_MAP)))
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
-- 
2.34.1


