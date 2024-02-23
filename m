Return-Path: <bpf+bounces-22625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4B8620D9
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEE9288118
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 23:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D924142649;
	Fri, 23 Feb 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCmAJRf9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBC14EFE2
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732660; cv=none; b=QxbdOOsNnFhPbr+NEgj7RWKWO81KZ/9jHMi3OaXQD/bbzxfM34gT3fTsuiV5VEGZJf7GF0zPN70Q55ZZiL+0RFJGJGA0R2QxwFYecC2PE1fH7HPARhsM81q0dVKIuemh3Swkr+wP6K9rAWaD+nXKEJzY+A83MFnm6VCNzY4USzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732660; c=relaxed/simple;
	bh=ZYEWHKG6ycKzGjYLTI8KPisHYQUrUh/o9jMBZA+E4V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMEF2nYj/nWwcEJQUZ0QSo/tCvnyGjP3VGq9Uvz8qofy6w+jLMUX1eNWECpiCTyk5hZ28owbIEB4Ye/9eVxLVvoky8wJyxuVYIYtt/ghtZZYJGqlCp2fAQomNrF2Z2w8d/U65j7FQXzfIYqnW+vzo+ap8EScXM/gl7PeDHRcH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCmAJRf9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-299c11b250fso1044493a91.2
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 15:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732656; x=1709337456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7v8QcQGKEfLwaJltNJW0mYz5w9KdmkVXr/8REE7aG4=;
        b=WCmAJRf9u3/jsE0wkaAcFJIvtxd6fegFrpJ6kMEyU9CgiuSw0X4qt8TLKjOTuG7Mm+
         euBaoFvNFktmXLbxOJgCrc92Zb7MUhJZdUANlF2CNaF+/2wgOSheA+WQIg6ntAtyVVio
         OHYD0tiiL3RO1pEIMYYogNmHDmcqcbs/xs/VdxrwmyWImg1US94ibC51OvTKlwSLShPq
         PRt/F+tRZyGGgMqh8ItNzu9/E2Wi6P3bsEIKXOVFfgQePz1HCxRLsbk+yHFCzQfpBqyR
         MwYJZfp/G2mriHcIhco+r4FcL8zjCNAbWFaWyoMS5bZEHPsxWo4z3ZDViTM9som82eCm
         777w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732656; x=1709337456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7v8QcQGKEfLwaJltNJW0mYz5w9KdmkVXr/8REE7aG4=;
        b=FRgDLgZsZ+JYMajJUHxbYJzqX9mTxL60OXvjgNTrNeVBE0h89SKvLYMR3vsYUlIQdb
         Z+eSIKcuK6zaLjFmfyDE+qCP/EeVIIx0t4F7KtSADSrk06j2zZOm8qRSqau/x1gffG1p
         YSo7EbpwRyfRz0FCOz0UTkjjBGT1PNcSsTXi6tbADzMiyKJOiomSeZRAFOagcpQ0St9Y
         jo2iivzWZMiKV6SUADnw1PnrvAxujnHacendwipSwk0pn450PQ1L7D90W+WIfOmFf9OX
         hZyyoLW2MCt27vpJ/ztc16id94+ngWBKgZnzdGxHVrqFAGHyhJw6MmMkY3OtVfchr2z4
         3bHg==
X-Gm-Message-State: AOJu0YwFSri2cBNe1s9xyQrSy0jLpkkOFni4F/wxYEMtyy/QUuaa6C1+
	rBFA3RdZrV6SAgkgPiZjJJ7xDAzmIGuV64/KQB8W2LyCa78BBdPmTBCi+h4P
X-Google-Smtp-Source: AGHT+IHG/DO/OVIktjtp11/4CHtLMBPBSMQzb2KGZX31cgPqxxDf+7H9BLoJUXmr0UjElOG7XOtMJQ==
X-Received: by 2002:a17:90b:1050:b0:29a:9ba0:8a5b with SMTP id gq16-20020a17090b105000b0029a9ba08a5bmr411918pjb.5.1708732656476;
        Fri, 23 Feb 2024 15:57:36 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:45de])
        by smtp.gmail.com with ESMTPSA id si4-20020a17090b528400b002963cab9e2asm2161658pjb.2.2024.02.23.15.57.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 15:57:36 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 1/3] mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
Date: Fri, 23 Feb 2024 15:57:26 -0800
Message-Id: <20240223235728.13981-2-alexei.starovoitov@gmail.com>
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

There are various users of get_vm_area() + ioremap_page_range() APIs.
Enforce that get_vm_area() was requested as VM_IOREMAP type and range passed to
ioremap_page_range() matches created vm_area to avoid accidentally ioremap-ing
into wrong address range.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/vmalloc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..f42f98a127d5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -307,8 +307,21 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		phys_addr_t phys_addr, pgprot_t prot)
 {
+	struct vm_struct *area;
 	int err;
 
+	area = find_vm_area((void *)addr);
+	if (!area || !(area->flags & VM_IOREMAP)) {
+		WARN_ONCE(1, "vm_area at addr %lx is not marked as VM_IOREMAP\n", addr);
+		return -EINVAL;
+	}
+	if (addr != (unsigned long)area->addr ||
+	    (void *)end != area->addr + get_vm_area_size(area)) {
+		WARN_ONCE(1, "ioremap request [%lx,%lx) doesn't match vm_area [%lx, %lx)\n",
+			  addr, end, (long)area->addr,
+			  (long)area->addr + get_vm_area_size(area));
+		return -ERANGE;
+	}
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
-- 
2.34.1


