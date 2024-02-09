Return-Path: <bpf+bounces-21588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B282084EF88
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2D828D60E
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA2C522A;
	Fri,  9 Feb 2024 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbMvGi77"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F516139
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451592; cv=none; b=SQ3kFqlE+DfufkSTVhIEI9bfodK3NzW4/Kn2Ox66tRghC+qFG0dIyWlJz2VX5Lj1lHqP9B6WBuassjI0hb8zsHqpf76GOdOlH40lm0UgIOmApttVGltvS5Z1YThqpwq+7W/xD55uDWH9cFeA1LjPcXfYlFUKKf+X+/pcGZ4djUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451592; c=relaxed/simple;
	bh=6TwdfN0NC5VtCZesa7tG8I7CgElc2Ce0A55StbRVB4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsgZaZhVSWKVkyld4ApmZ2enVaWgYQbo4Qa4uF9jnuyDjct+xHm+XoTxZaOSgTB3aXxNzZrUNasJ6GwQRhY7wZcYBEXLlhx0RTv6mNL/KUW1Z6GJ2bZODZ0t8qhnF7YMyaNVFoUaUYnR0Lh4vTwvv5liWI+JClYXq+2g75acgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbMvGi77; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6de3141f041so462441b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451590; x=1708056390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KvQuM8OQ/k4hdbGFhyp69M4b0glecGcjvBA4TzLzwQ=;
        b=RbMvGi77mO7zllHanm/jGJS9Dd8TCZtr76JNlI+e3SRz6DZkaFPHv3M2ihdA/WvupA
         a6vHjsg/0LPSDeYEgwoec0D6aCpvuV85toHZuAn8Q2hsK94lG0iqFAvacMh0dcp2Jr9k
         bHpWxoe8sVFY6CBr+RtTSUxCV+jcpLYg+YRLFvmAb28aFQ+btaC2m7vI8JI2Tu8N9Vfh
         ZTlzSKwqoywk3pEg0mbYJ3FdLMwhiriPL9KLqfY0K2VQIA+rPFtbQpZPWWv5KN8T95Fs
         hoYMDyjn8pZoU3gIwjWrvVhQxFZRDREb+RcfFGC4F8s2PJGtiYl3VlB9flmtgMl6iBLk
         bypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451590; x=1708056390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KvQuM8OQ/k4hdbGFhyp69M4b0glecGcjvBA4TzLzwQ=;
        b=LuEA50eLZAnpcMTK6gaeAX3ON+FDcZdzkm0LMgwj1vSVpD5do3vI5G+IGjhnJVCJmF
         QPMPxDMzEopheyVjQHPJVT5eiFJOTY5sephvLPzPBAVjsYVk7JT1d/mtRtDAgulCKFcC
         9KdzGNtroWIhIyQYrG1ysQEW8viXnJRtwBzahjSjK9STk+A65FKUccsG7zhZnBoRL/GX
         d45dtinipoDJjkdsFJrf4ZNbgWJQQCPLGzL5c2GfRsNUayu/l0OAYAIB1QpfRleKXS0/
         sh+YHNky+5pFMCZnChOWMvskYefkGMuvrROf/9dfbys7sPejY1EJEGlmhBassqyB9tdx
         15VQ==
X-Gm-Message-State: AOJu0YzBjX1AH22ganxPA2VJVdRQ+cj59RZ/xeVhQvvnbs5gVweHZSRK
	+CJp3wLmC8La4rYQTviynLZzK6VA1R3UyDr7G1+rMo44QC1lFLn7baMxpBXl
X-Google-Smtp-Source: AGHT+IGQBdQ96AWfRShK3THRmZ/s+UP/PKdWL9/0jO8LeSeDC7xm1ls7NjuGAIDwxkvXo++YHCAN4Q==
X-Received: by 2002:a05:6a00:bdc:b0:6df:e85e:ecc6 with SMTP id x28-20020a056a000bdc00b006dfe85eecc6mr521111pfu.3.1707451589662;
        Thu, 08 Feb 2024 20:06:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdg8hv5XdH6EKCu1LTwjNtjdDavpVVV78qHLOLm6RZihoGfapXop+ABS9UTa9kAd3MiFUVzdXtkUDGGX96nIPHXik+Vtby1jDoxmr93Sadbon7ZAQZgHUtdc4jR8uEEianIkut2yaoRtShsOlvTSBLyu6qrKADVSDnSWmXWKw7Z+GYkTkVIxTMwWhVUkuQ3tyuAMr64xwMkrKnAnn2HdWivAzaIpaikmZVk5QXlulka1ipuvoCbLwhJ/vJd7n5LB6etkbgJ2LbWrom4JWoyjucVlWdpM7pX6nH6nTuIfGVEzy5qQr/g6YbNCh7o033IAymJ/6+pJsAzwh3lWNBTSOlquwUKBcGvK083zCJn2ES30w86coAEg==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id x29-20020a056a000bdd00b006e0418993cesm591583pfu.8.2024.02.08.20.06.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the rest of the kernel.
Date: Thu,  8 Feb 2024 20:05:52 -0800
Message-Id: <20240209040608.98927-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

BPF would like to use the vmap API to implement a lazily-populated
memory space which can be shared by multiple userspace threads.

The vmap API is generally public and has functions to request and
release areas of kernel address space, as well as functions to map
various types of backing memory into that space.

For example, there is the public ioremap_page_range(), which is used
to map device memory into addressable kernel space.

The new BPF code needs the functionality of vmap_pages_range() in
order to incrementally map privately managed arrays of pages into its
vmap area. Indeed this function used to be public, but became private
when usecases other than vmalloc happened to disappear.

Make it public again for the new external user.

The next commits will introduce bpf_arena which is a sparsely populated shared
memory region between bpf program and user space process. It will map
privately-managed pages into an existing vm area. It's the same pattern and
layer of abstraction as ioremap_pages_range().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/vmalloc.h | 2 ++
 mm/vmalloc.c            | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..bafb87c69e3d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -233,6 +233,8 @@ static inline bool is_vm_area_hugepages(const void *addr)
 
 #ifdef CONFIG_MMU
 void vunmap_range(unsigned long addr, unsigned long end);
+int vmap_pages_range(unsigned long addr, unsigned long end,
+		     pgprot_t prot, struct page **pages, unsigned int page_shift);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 	struct vm_struct *vm = find_vm_area(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..eae93d575d1b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -625,8 +625,8 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-static int vmap_pages_range(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages, unsigned int page_shift)
+int vmap_pages_range(unsigned long addr, unsigned long end,
+		     pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	int err;
 
-- 
2.34.1


