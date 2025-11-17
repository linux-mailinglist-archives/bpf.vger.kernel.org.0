Return-Path: <bpf+bounces-74771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26080C65981
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4286A35D7BC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9F314D03;
	Mon, 17 Nov 2025 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqlOADLL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01D3128BE
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401058; cv=none; b=iLJ1X8BP3JgxwEoroEeS6HBeVw85/FhG8oUGg4bBc8Du+q88sBSNJXvXQf3v6K0hF4WP6wjr8b5GTu/U4DHFuF0OzGFjAxnEsGUsxN92lJImQ8WvDT70FlB7XQswFYHVKMnGN0OMeN7Yk5xIbTzM1kEFDHiPs5hg3aBiB/lCcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401058; c=relaxed/simple;
	bh=BXXvH+/1CsOcZQO748vKJMoBtVkgAm/S/z6ByaHgp5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNSBGyH5QzbjdvYxhfoMh2CdchneuNd68eIy43v+l+kr0TSL6EAqeWXXWz5Jfgb+Vi8OaNnYWf0vhPyBtmRnuWuk+ItnIVLvEY8RjgPWy6WAtJoqBezm9IslLzP+IpJ2epgeLu8o3Ry/qYPMv/ONL4kehNlieZOxHabg805wniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqlOADLL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5110965b3a.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763401057; x=1764005857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF/oCzsCJVfQ1QNnE888AU746+zdxfjxC/Ij11uSPgk=;
        b=MqlOADLLygoyZNjIWpAvmv0LIk/TQniaS95QeEiQzukbYdA9Yoh9NX8ZbnGq4r9Oyu
         HQieknkN8oDv7dFJ5fU/eV7jbitYDyyd+4Ov7IhtrWvIn2Hi3qRKvG/ARBTfPkPJIkAr
         yBrc5z38xyEalJ7LjpEVjbQvxBUoVqozlQ+ZwuU72fHIy43W5MrKHsrTBkrfIC3Fk9jl
         d3odmZxRCruq2DKkO6e8MdlxPv//P6yuXcZcSUBWquktMtGA2LXJkfJIyrG9bkq4xEdw
         yvWNBCbFbIY6V0jumUjyCUhfkPE31Hc1HlEgzNSvhDXH7GpOFYudU5Z4Dj2wEOBjDGb1
         vicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401057; x=1764005857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vF/oCzsCJVfQ1QNnE888AU746+zdxfjxC/Ij11uSPgk=;
        b=mIuocwTlrWrxlI1YMkiIKJpKqKZQpTixHkr8YB78sB3nX5WexawzgeVXEHlaZrFbfa
         anC3GPLOxmimQL9+pmF5NonP2tOs8oLH3Sn2BZLXuVX6hf7+ftJwBgVJP1+pdRj4cO5Z
         UutRoEoL4TkXdXsjNGfDSxs0XQRLcIqkw+ArIJqUPfW/LttWDG4MLOvUrXmpxwvmmtPN
         JOBz0Sfyr9D1rgFwKs2keN6HNra+jvsdvyIU3tD7W0oht+y51sD2ufHZuxuDNPT/0nJC
         kB5atOebxvKZgUJTTxhEpHc0fYj1wC5vnkSGMrScN31RAithBGFvR/JI7rWsYnruxZfd
         cinQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqdkMK/eNrLwdkOC2cFTH0QM/VUI06gEU2vwdqR+ofktpleSqOKxw6jW4YYbXNr+LpSB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sBlpw4AMOWUwiCZz08QsAftWiE5pbmqTQj4rnRSRI3SJLRLa
	XWPWUNuKRIBDhD0qypR9wDO+g8GzRr3tbhy+SnP3CahSz9d3mPic9YBD
X-Gm-Gg: ASbGncvj0J06apyIXjJZnaBg7v/OP9vOCKmIFbppJhWYOzLnVuv+s/3gnXRGEGCK96a
	lV4ziZqwxt8dSGHg0tDemNcbhDZLxBz+x5Vu9Ecc1S30Hq8KMdX2csm9Hgs8WoYCM4QgLY1P7cN
	97riFy/tR+aj/RtJ4xAUDC3OKmfd5ewiBLXKp+/QPAC7qq+iIjxyS9z5ogkOZP5+Q1cU4HqX5UA
	dmqPyotSpV8veGgHQRXQuY9GkrrsUu5LNbjlyozoSni3W7GzuNkWiVqo1ZBrtWzt7h77G8E+Sw/
	oeTPfx4XhBCUxrfZdgXqKgWmODubtWd3TGSxQkYaRHqaAzEA8h3j19kgXviQnzY92fAtCD4heq5
	Haumm4gRI++wSvXjHksirCiTj6hveDjZc6+FE9QgZn24rXAWjOPNQTz8TJqgbqX9COYOjlre8Gr
	RHwfWGKesxQn6OJmftEw2kNb6ihincjfopuuwGo+MRRj9s4TynXvOCl/c/RJ3xQ1kG
X-Google-Smtp-Source: AGHT+IFYh76XnkGH8ZPN+SodrLUUb6MouxEfWZLQ+VK6P5yiR1d/domnXV9JBxjTuI4H6aRFsqsiNQ==
X-Received: by 2002:a05:7022:662b:b0:119:e569:fbb7 with SMTP id a92af1059eb24-11b4120f544mr5937733c88.38.1763401056525;
        Mon, 17 Nov 2025 09:37:36 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11bf23d6967sm17190077c88.3.2025.11.17.09.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:37:35 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
Date: Mon, 17 Nov 2025 09:35:30 -0800
Message-ID: <20251117173530.43293-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117173530.43293-1-vishal.moola@gmail.com>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
this mask here, remove it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d343db806170..d55a77977762 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	node = numa_node_id();
 
-	vb = kmalloc_node(sizeof(struct vmap_block),
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
 	if (unlikely(!vb))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.1


