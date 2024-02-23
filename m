Return-Path: <bpf+bounces-22626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813F8620DA
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4944C1C24274
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 23:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8704614DFF8;
	Fri, 23 Feb 2024 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVJ+oW93"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18714DFC4
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732663; cv=none; b=pyL+Zav+tlWnzRgKxeNgjSajBA18x+ewLAkMZatz9iMW/Fw+aa3rtDe0xZStDStS2goYgHqNg2qPh5hU+D+JozoQ7llVErLii+990MTAtyUKQDL4b+3D3QtQauTSwTFqGCthmg43fWQBFCq9XqisPCD7U2T5yAZWU7h6Y2lxGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732663; c=relaxed/simple;
	bh=2ulk4/lnDC0M/c70Y0QYbgSEHbcqLSZIBKA0B/TsiDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRN3VY+sJ+kqca1vFmhJK0xrDvKf71gLTSs6dQwSy9JI2lB7GgOzm4pGf+dzjIp0XwGQ7a0zjYFxnFXvRFo9Qd1xs800FuXdVrtGnA9tzi8hCVrXfzCXd5y2CKVSF8sJRj/U2t9FGx8jCtn412uc2gY9bjPvBmProPQUIQskVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVJ+oW93; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc139ed11fso7307195ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 15:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732660; x=1709337460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgy7UuZvicma9Y2PX48aaJ5ZDCArBODZAL7mSlN3pk0=;
        b=HVJ+oW934KVZTK/RSF4Ec7t998qr6vZiClo4ZmT4LG7czFs14y3RXCcs+W6CiwSvSU
         3v7why+gunWb0RwsZAeRgOaiVXb2Li81VUv3MIHu3dZJVcq5DkxFSdyMkdxb1b75yeRZ
         v/dGKe30OHi3Yrk848aprVCbI/q7WHHYtK1iOlIAWBfMl6uhPWIg7+g/rYH+EKg6DmTy
         BM92MWPaNNmgqBKihP7CIZ/6Cr8rwYRgVc/+z/ozQAkpLIAjVTVTXzSuwxdYn0Blmgfj
         LyIu+zdvN21ibq+cuFIDOXj4g5q4dCqMkFSSRcikWE+CxOLI0vAxHR6q5tV9K2+USmqt
         th4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732660; x=1709337460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgy7UuZvicma9Y2PX48aaJ5ZDCArBODZAL7mSlN3pk0=;
        b=PD2PgHApBJlqHjk0CsDVW0RDkRYkrkZBuGXkNllIIkNZBSFZGTStvn5UACI8DEs/ZU
         Vc5qmmBXqDHFiexqTMXAil7BSAsfZ8xthPLQ5PewInj492AUr7rfv/NRwAY08K5QsMhC
         Xbl7ebIlDOIFMG5GtcA9Qo6fBomCYFSa/mtGRZOsetFZ2GloPqp0aiHDXkW1YoZnujha
         jBSb51qcrn7K01SkaKF+tHRiQFE1LyokkJd5hfEpKozhBgqehBDojKQAH93QvtVlZkBd
         diMYFDglATfN36JlBO2QYlQEXhJWbaUbwn90WLhTdRokf72eXqYEXlcZaNmIogHW1HcC
         idaA==
X-Gm-Message-State: AOJu0YygfZaWrEzsiRBIAeBCB+4oo6XbzEv6A1l2Nv6dXhncoaSImSN2
	T/gGmXhnPEE9DF1I6mNp0NRqUpqkYhx/BNauofqP/omYg0KzomLE1Za1YoOE
X-Google-Smtp-Source: AGHT+IGELhXnvr3n524zH97gDxBoJwFKXzefQUh+8dOBuQvkiJz95RKjpkB2JqjALLNdOQ3Mm4DyFA==
X-Received: by 2002:a17:902:f645:b0:1dc:b64:13cd with SMTP id m5-20020a170902f64500b001dc0b6413cdmr1551144plg.27.1708732660213;
        Fri, 23 Feb 2024 15:57:40 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:45de])
        by smtp.gmail.com with ESMTPSA id bc7-20020a170902930700b001dc486f0cb2sm3796745plb.208.2024.02.23.15.57.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 15:57:39 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 2/3] mm, xen: Separate xen use cases from ioremap.
Date: Fri, 23 Feb 2024 15:57:27 -0800
Message-Id: <20240223235728.13981-3-alexei.starovoitov@gmail.com>
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

xen grant table and xenbus ring are not ioremap the way arch specific code is using it,
so let's add VM_XEN flag to separate them from VM_IOREMAP users.
xen will not and should not be calling ioremap_page_range() on that range.
/proc/vmallocinfo will print such region as "xen" instead of "ioremap" as well.

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
index c720be70c8dd..223e51c243bc 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -28,6 +28,7 @@ struct iov_iter;		/* in uio.h */
 #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 #define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
+#define VM_XEN			0x00000800	/* xen use cases */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 	!defined(CONFIG_KASAN_VMALLOC)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f42f98a127d5..d769a65bddad 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3822,9 +3822,9 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (flags & VMAP_RAM)
 			copied = vmap_ram_vread_iter(iter, addr, n, flags);
-		else if (!(vm && (vm->flags & VM_IOREMAP)))
+		else if (!(vm && (vm->flags & (VM_IOREMAP | VM_XEN))))
 			copied = aligned_vread_iter(iter, addr, n);
-		else /* IOREMAP area is treated as memory hole */
+		else /* IOREMAP|XEN area is treated as memory hole */
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


