Return-Path: <bpf+bounces-23100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5486D7FB
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 00:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CB31F22B2F
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2845E7B3E9;
	Thu, 29 Feb 2024 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZbaoFU0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580B75810
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250213; cv=none; b=Pyz76H2XFDgEdMHTo4GQlIXI4coZuE05isToUcwIqonbXE9KL4xT6ZiKF3Bv90Hr/fOls5wgDOR/+D14FlQ6fejG2mSc1P5IbDF/FdGuqaCyP49MG3WneVmbZ27YkxHXjFOGRZJ1P5p2/4o5sexuthsKycRl6Y9Y6s1adp98bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250213; c=relaxed/simple;
	bh=E34SH1X7yFBQN1bO+6pOOTmYYI75xA1w4M+eIAQPszw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4k0Cu7jBPikf03p4QtP35x24CfuzDi61v1FLUyKxTek42ibNdl+B9D6zZZRZQvlyzabz8P5CI3bLDDB+o+pvDmcz4nGDbyR2Y130/5KzFVXklRgCMZwHuKIf4rPkQuXgwKVOlY1POMtELFfJsWYvlnN3TjB7BI4mhqp/c3yTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZbaoFU0; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-365afa34572so6716365ab.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709250210; x=1709855010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fSQQtv9Pdd1jRnQzOfB2+LAkUYgIfVtnLn4umtyxEI=;
        b=WZbaoFU0KqQoWqX2QO8JjPlWZ7Kd1Sb1blH+AFVtTgPsNfyXsvHPH1HPBG1FnORSU0
         0Y23M8L7MpXsawd/PZDXx4b8e/2C0NLM+iUjkM8yC2vYzqCkUt/KXzjVJ9OgVea5/rjJ
         RVvllZ/wby3yYXVQkjFfcwRbfU9VU5H/V+HDoKl71IerJoVJpsv+XU1mvvblyD/yRY8Y
         Y9M9wECX/938BVncYK7OkArKgr/DYg2Tt9czf0SAYO5Xg1aFmyCaEtNJYhLJMT9w1yZE
         ngi5PUf8Y6BWBlimXY4VsAst8K0LJHpHF1D/lVeCTI3NNcvF0/pKhS8lOwhlq0yQencn
         i0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250210; x=1709855010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fSQQtv9Pdd1jRnQzOfB2+LAkUYgIfVtnLn4umtyxEI=;
        b=sgWg8Dyr1r0d5khf6YWSZTaAPf1F03JtNfvaw4RTrCJ5/VvawBSmb95uCJPpEEX/uj
         i1l9eC+OZqqtsbcv1J/6ZUrdbghx52aHWGx24oOHEXlNoYpEk0UFxrCWP7HBwIm9GkPK
         DjHlzwjv2CtqJzU2vRMHn44I30JQ9shQ6aJqA9uMNud8la6TSTZfZI+pAK7OWlW40C4z
         Irpzsj34pXvFztnOwz2Gn0R7UFWuqKM5WSQtX31erDqqesvtvah9vWgf1PTRmfNSaVZs
         UgZUYzYyOzwt/TSpPReFYzQtWLosXFpf+fIstgTefuA53muC8GxNX00IQV/v07Dweij2
         kmXA==
X-Gm-Message-State: AOJu0Ywf2/oR46UyAEqDVThN3NyWktddSJOvT2gtBWhz9ntiWJVzPU4F
	gUwewUkAwvubfEF6XxyeFLRfRGeBwV6y0rjTLwJ3LCDaXvnTiA1GXKyACjQz
X-Google-Smtp-Source: AGHT+IEjOcNXmJRmdRJJTTrs5fHGw0wy4T92DO/fjxQ1ryFJYxgxzO1wRU4PulyZo16hmDAMpzbQcA==
X-Received: by 2002:a05:6e02:148e:b0:365:a6a2:24b with SMTP id n14-20020a056e02148e00b00365a6a2024bmr273922ilk.17.1709250210665;
        Thu, 29 Feb 2024 15:43:30 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78453000000b006e4dad633e1sm1850278pfn.177.2024.02.29.15.43.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 15:43:30 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 2/3] mm, xen: Separate xen use cases from ioremap.
Date: Thu, 29 Feb 2024 15:43:15 -0800
Message-Id: <20240229234316.44409-3-alexei.starovoitov@gmail.com>
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

xen grant table and xenbus ring are not ioremap the way arch specific code
is using it, so let's add VM_XEN flag to separate these use cases from
VM_IOREMAP users. xen will not and should not be calling
ioremap_page_range() on that range. /proc/vmallocinfo will print such
regions as "xen" instead of "ioremap".

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/xen/grant-table.c         | 2 +-
 drivers/xen/xenbus/xenbus_client.c | 2 +-
 include/linux/vmalloc.h            | 1 +
 mm/vmalloc.c                       | 7 +++++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/xen/grant-table.c b/arch/x86/xen/grant-table.c
index 1e681bf62561..b816db0349c4 100644
--- a/arch/x86/xen/grant-table.c
+++ b/arch/x86/xen/grant-table.c
@@ -104,7 +104,7 @@ static int arch_gnttab_valloc(struct gnttab_vm_area *area, unsigned nr_frames)
 	area->ptes = kmalloc_array(nr_frames, sizeof(*area->ptes), GFP_KERNEL);
 	if (area->ptes == NULL)
 		return -ENOMEM;
-	area->area = get_vm_area(PAGE_SIZE * nr_frames, VM_IOREMAP);
+	area->area = get_vm_area(PAGE_SIZE * nr_frames, VM_XEN);
 	if (!area->area)
 		goto out_free_ptes;
 	if (apply_to_page_range(&init_mm, (unsigned long)area->area->addr,
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 32835b4b9bc5..b9c81a2d578b 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -758,7 +758,7 @@ static int xenbus_map_ring_pv(struct xenbus_device *dev,
 	bool leaked = false;
 	int err = -ENOMEM;
 
-	area = get_vm_area(XEN_PAGE_SIZE * nr_grefs, VM_IOREMAP);
+	area = get_vm_area(XEN_PAGE_SIZE * nr_grefs, VM_XEN);
 	if (!area)
 		return -ENOMEM;
 	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..71075ece0ed2 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -28,6 +28,7 @@ struct iov_iter;		/* in uio.h */
 #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 #define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
+#define VM_XEN			0x00000800	/* xen grant table and xenbus use cases */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 	!defined(CONFIG_KASAN_VMALLOC)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f42f98a127d5..d53ece3f38ee 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3822,9 +3822,9 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (flags & VMAP_RAM)
 			copied = vmap_ram_vread_iter(iter, addr, n, flags);
-		else if (!(vm && (vm->flags & VM_IOREMAP)))
+		else if (!(vm && (vm->flags & (VM_IOREMAP | VM_XEN))))
 			copied = aligned_vread_iter(iter, addr, n);
-		else /* IOREMAP area is treated as memory hole */
+		else /* IOREMAP | XEN area is treated as memory hole */
 			copied = zero_iter(iter, n);
 
 		addr += copied;
@@ -4415,6 +4415,9 @@ static int s_show(struct seq_file *m, void *p)
 	if (v->flags & VM_IOREMAP)
 		seq_puts(m, " ioremap");
 
+	if (v->flags & VM_XEN)
+		seq_puts(m, " xen");
+
 	if (v->flags & VM_ALLOC)
 		seq_puts(m, " vmalloc");
 
-- 
2.34.1


