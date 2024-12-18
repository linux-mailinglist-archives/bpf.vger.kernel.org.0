Return-Path: <bpf+bounces-47180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7609F5D3F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346D87A429F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFE313C83D;
	Wed, 18 Dec 2024 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmpryJoa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DF43146
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491276; cv=none; b=Dd0mD5JfMSSNX1LlaYQ3lRJJOa6Z3pgkToP5UE4X2GMy0CgOJEbdMxOqpayzwEZX2xxWgjdR/AhwOHOuaycBJEOoDBFlNeDb5UfCD9yZl3bcgCZ/Tk9tyxdCRv2hs2V+j/usx5KgvBb9W5YQI1T3kU7sLDGaoghEeLBmuo7cY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491276; c=relaxed/simple;
	bh=Ez0Qn2cewVuxDjKZrQUQnN2X7Qdf1nNERwtTwPZpiag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyHK7zq5YcgZrdO2idKN4QIIeJTEGQh7YYe28E3hEOxGVNl0B12WrKH+O27V4LMloxgm7rd/qZmAxI2C34iWPP9A1vAYQGnrg8+mxH8y1/EDBmB1L/Xg5xvgx25vbUJX/1/r5jN4vo8uFxAgvfJG6QbHeZhwGbzG5bYZH8XxzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmpryJoa; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29e842cb9b4so1910901fac.2
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491273; x=1735096073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e77ZoQKvlnjPoOZm7mn9NDRKoW7hQ+ydIa8Wb5hZHHY=;
        b=jmpryJoaToXH2wMn3kkMAUSvYV4P6LlOm0BQxEt7TmkJv9R/7NvjireF8x+DIpcuva
         cEdDNPhG6yL1Z9Re2Fq5bnkTfkUtu/g0vrTSX3ufO6Ha3k+UBMKYNkm8AR6rUKNKA9cF
         uP0P+/XuCgmIhGLnk++MsBrsCF8xuW1YPWceUqHEtVwwQsiLVsoi5lhz1XA4XytTvuW+
         H7mYvaUYO3IUGIPmfxZCQ8mtZntcBw+Y1H7IOBwfRFqbRzQKC9R7+tlFWRagG1qbG3a3
         hg1onsNMnj2T/VhG1DffS8H2Uk8cCjPguP/zJYy2Xrvy+86bnJsABsI0ImFMbBYLxAfJ
         1wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491273; x=1735096073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e77ZoQKvlnjPoOZm7mn9NDRKoW7hQ+ydIa8Wb5hZHHY=;
        b=AmVzhNjcb4GW8AiqzQ6UggWdu9xpJ3Q6crb2MiFbLGSfc0mMMWTUKZWs5u1xVieQvV
         uFnY0AMLCOhDIy/Kpre3g458t1yaHsHKZ2UinoZtugz3BdFzx346nNTL6td6QH8M8gf1
         GispaQrkWi1c0l3KsY+AzBgIxEqEUnwdfDA8XuEBjWV4e5u5HVrC7BsjJNCXMNsOqyhy
         DtIhnJ/weXxUj/AsvohGgRneeVKsY4OJr+akb2bhlPA0txnJfmmRebpdW8vmPO3L1tpm
         Yth7a5JXdi8v2iNqPabrBDc9YjcldGkn+no2m1w7yhCOE1G26OxwIhKEzw29dUcGKCa0
         9XQQ==
X-Gm-Message-State: AOJu0Yzirv5XW4ba3AHwQicSM/MIl8RdkvRMLf5yA8lZzwKynIN4sdbm
	lc1I5T7+jiGmPBph0SRodHJ3dWSbN5aG3lPqeMhjEaFkHDXz36fal2XgLQ==
X-Gm-Gg: ASbGncuR0yPsMe+Q6tPdDYj2ky9DhywsH4e7UeQ04lCMSLNsRdYHZonJCkcfGMOvCgI
	n1pFjG3rqPTQJm0RP7rwP/O11h73yu0ycEZaXrRQc+iwv43WVrP8yIlEmq2jUEWnJM3uUvzqO46
	n2PU0Qp1WnthW+ItRvmKjfeRN0QPeoyuGRYsVUyymXLA5HhhYXQOATcxRIko2mjbgbwAJQX9xh7
	ddoMzTZ8Qgkthv3pzOWy4q27OfTerVMFKus9Q7vdCwUhJXuLS890V/HkgO4cA==
X-Google-Smtp-Source: AGHT+IHi/o8gjZtYzcre/yxStX7zDbYufL6oPcWXItTfKnkU83y7CXItnrrjbp8U2xtfjDPf2FnqzQ==
X-Received: by 2002:a05:6870:ff06:b0:29e:684d:2739 with SMTP id 586e51a60fabf-2a7b35c8056mr580007fac.32.1734491273379;
        Tue, 17 Dec 2024 19:07:53 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d263b839sm3295077fac.14.2024.12.17.19.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:07:52 -0800 (PST)
From: alexei.starovoitov@gmail.com
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Tue, 17 Dec 2024 19:07:19 -0800
Message-ID: <20241218030720.1602449-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Use try_alloc_pages() and free_pages_nolock()

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e88797fdbeb..45099d24909c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -582,14 +582,14 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 	old_memcg = set_active_memcg(memcg);
 #endif
 	for (i = 0; i < nr_pages; i++) {
-		pg = alloc_pages_node(nid, gfp | __GFP_ACCOUNT, 0);
+		pg = try_alloc_pages(nid, 0);
 
 		if (pg) {
 			pages[i] = pg;
 			continue;
 		}
 		for (j = 0; j < i; j++)
-			__free_page(pages[j]);
+			free_pages_nolock(pages[j], 0);
 		ret = -ENOMEM;
 		break;
 	}
-- 
2.43.5


