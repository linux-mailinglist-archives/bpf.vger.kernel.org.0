Return-Path: <bpf+bounces-21368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2284BFB4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02341F21D54
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD11BDDB;
	Tue,  6 Feb 2024 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gybeiERi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458101BC3C
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257099; cv=none; b=VF01dhFbFhcsGfzhNzheViM+UEknr9X7eL0s79BagY2bgVlSVbdacNoYf9QTQVLFxu/dNxoUNC/NAT4VYUKu6iUrNozRjprk57njdLpeC6ngncqMpT1v3aG1KvuEM+5uPVbq2Ubglce6JpeF0G7dJGlCrYmUPpI5Jet40pKgiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257099; c=relaxed/simple;
	bh=1Fl8Vhx1TncSqczMymESz0vJAIjHEVQSOmCMMy7aPo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WeVbdVwS17pCwYAtYE5+FFVwhpPjhXHxpq5PBzMgI8+HAS7w+lGuhur9xevDwgBrVwUmVTqS6Y5pouoOtB37RGbFQBd+b8+wSMN41Jjd+G7Gb6BjIIGseeq5aA7qDQUDH458A2UJdJ9qAeK7l7ytWl24SsqDsQjWuY1eGJupLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gybeiERi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e04eca492fso11817b3a.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257097; x=1707861897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tj/XQbWXLMz6O6W1qhMmj7yBJ5q6YLDIAk/QCdta60=;
        b=gybeiERix74gaWKVotahzjK4YNy6xeEN8BKvkLevYLRYOUtLw3PdUPtXUcTw8W+3v8
         nFQB1/pJw+aHMmzbOQASPhuAoj5CeNymUyAh5bqSMR8maG3ODjOmy4HyIJwlB2jZeVS+
         +mCKICuH8ZBPD86KqHXGoyzXTSbU6sPb+1QqqbIf5Ogc6uPurcN+3hSsOIMUufs91biD
         9wrbLGWngSFuscBFZFRtAAW0g+RvT+PQpD+efFd/35vInhzPWI6MY83U+p44zZJaBjio
         tnFoFpWG+Repgva1J2I8jH2zi5pQpkdG2O+sSdIfdFrVn0uRXUFyni1lZDGc8ls3a4e1
         pmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257097; x=1707861897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Tj/XQbWXLMz6O6W1qhMmj7yBJ5q6YLDIAk/QCdta60=;
        b=etoVG0d5v805A+umY3nXtuEnUb58VfFnn10xoDjwP+7wmaNNE9Cx21CGaiOgyR81k9
         DS0rd8qDv7x1FIcwkmszags7ji5hYgnNTgrjZ+qpMAiNJPyaZQ9tGceOFOlo4EgdG9+0
         6FXZ7wOTnOiGQ+Y+VdL6qOa7Zqh1vh4tLckCn2YgvyIDdqTjYRcVkbNofV64BU/9PqzQ
         94JYLX2kgs1yEdb4b3RYJHU0jq7QRw+f8uLM+OO4hVaz/7Qq6l5UAdM0cANeYNLjl/8+
         u9paa2DYD7To5kti/DwPz+5TGVqVfDP2LQ2r16W9Mb6hvAJaFIjE6t59U8pUXoSID+VU
         NwRg==
X-Gm-Message-State: AOJu0YzpxNOptx/gJ5bhZgZ84ZISMVBCzLwQ+ZYUUB1ipX9HqrTH/Oyi
	IHIA7tDk272yf43fOO0LknpE+YQ1FqQxhGfW3cta1j58mlE+xfqUOMic+z2m
X-Google-Smtp-Source: AGHT+IEjcAf6uXoS2ZepvZd4WPEhsb74cH/NcraOd61wF2bJGbGsztqlhDT3saZuKsz+GWEev5IaMA==
X-Received: by 2002:a05:6a20:3598:b0:19c:2a8d:8b75 with SMTP id j24-20020a056a20359800b0019c2a8d8b75mr2472114pze.28.1707257097406;
        Tue, 06 Feb 2024 14:04:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUog5B9mBd/4ypN4iPfsLncV0Q6zXF9MI3t+m9OSEmXJlkyaYwbJU3Z5CWn6TyAb2DiJtsdoKuHJLryjn1E+YF6B9ICtSLE8PV+NwaK7s/bobASa1TzhWkioQw/pNKVdOB/uuhkbiOyjjZJRLYOlpKWVmq5s3/lmII40TDt44WDD0EUbz7vv76WbdbJJBqhRa1G7/kQyL5mMT0bXWt/GXEdG4CTcUpNAwn3jDPEp8+fy2NVxuh9M65ywbwVm9XrCApUkiY64O7kR5q1Bkwzb8au/2GMwMcXdy3L
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78c01000000b006e02e816f13sm2491180pfd.111.2024.02.06.14.04.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:04:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 03/16] mm: Expose vmap_pages_range() to the rest of the kernel.
Date: Tue,  6 Feb 2024 14:04:28 -0800
Message-Id: <20240206220441.38311-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The next commit will introduce bpf_arena which is a sparsely populated shared
memory region between bpf program and user space process.
It will function similar to vmalloc()/vm_map_ram():
- get_vm_area()
- alloc_pages()
- vmap_pages_range()

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


