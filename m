Return-Path: <bpf+bounces-51350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BCA33621
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC503A293B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A9204F88;
	Thu, 13 Feb 2025 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TenZdNtw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665A2046A0
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417778; cv=none; b=feHZqjKQVlWxyOEnsz2fmWSoZ/bSqQPGlVBCzNqfWIAUTpQ5lFWLtVWyaWYA1mRzsGkQi0VMCZzfv2307ahEI/WuAJoS1ci/mEuXL2cb1w/ElASYMhRRQo16DG0jKZ12XksTbcAqwoeZqf7HCOTAhiTJ/1+FAPClayjhcj0CWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417778; c=relaxed/simple;
	bh=OXvxRRQ0ldJk6tf+xlfHzw5zM51xSwL/MeJ06bSRpIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lo+e28yaJ8Ze3cdpNA5HFHyyA6gykJ6tD4CM/NSj5+5bTRmk2wqBr8siL9fPn19PZX3cuSKSFPkhZtBJyre/J8LOyuxWUBCfblrAImG6dSzEy0BOcHyRGycr7hgI4Taqafgy7Lx85/PWttD82jL/XJAB9R+NW1h88Nn0SV/rzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TenZdNtw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f49bd087cso5581195ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 19:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417776; x=1740022576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/v8WJgHJaSQyAqUJ963JkPt7Jj2HKJav5PT9g4jqQk=;
        b=TenZdNtwAO2kqAzMYvAiV1OquEFziIZ49gD+LTV5o6nZlS4cz3OQiCty26Hgw+vFtb
         /kCwouPaOh3CVNnvPdfb22MjqyBPBiNyRoBVsGJZMfQjrqDz1kSR+LDYRW2KNcT352me
         l4bPia4dL2FixxlD3kbWAjpRShSHl5cSlqrrS90lrdDwkcdyEo9Bi0o0OHrL2Bw+pHNn
         5W3l9ZRu5xoNdImCjkH01ATH/OrQjXczwcbhBTAcAFGt2bytJ0M/9TvVTr1KIs3uQbwy
         SdCn7+/qWpel3FBW2GTbd3oHKb0NWQoBxYfK7KHe1I/d6DnnpKgslv0MJJzjRTb+Xb1e
         NxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417776; x=1740022576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/v8WJgHJaSQyAqUJ963JkPt7Jj2HKJav5PT9g4jqQk=;
        b=WvT6IQJZTGfH4xh0j4V1VmY/72dUTBKgL4TiR1Z+KjayBFx7HK5yCOjpZkvnIpH1yX
         OosfsfJx6RFRwDkuBuPO/MH9zoOeUDDoIpitfanLtSS7W09m9gE/2slhub0HC1WiYtu3
         npc5wD4OSbc1/wKo0c4Q/AHTg/BUhz+cFS8UXRlECC/2ARX5T5DzF8ZSznWVzqhVzlUy
         udWf1BmNA+jf/HdWMkPiy49B4mZRvuF07k6htL/m3yrVUZF5XbMXcPbvGoFFKk+67skl
         TdXZsMtAhUJuwoznfAzqAdUodqvF1kz7pZqxBBISHBIHW8GpKuhMUHFgw0gkKkQM/rxL
         ysFQ==
X-Gm-Message-State: AOJu0YzqDQwlq0kdMmu6mzUl+vvtazLNOzA58UBNGg13PHDretuuqgMi
	pmoqXVDPrMEcd8vsyuZXI+VH8vCkLUuU6x3OwPRTMvpHG5/Gn7fouK9sqg==
X-Gm-Gg: ASbGncvwcrCXohOQzLvpTd0hUsZnG9S0KVDMQGDCsha34q3a4oz3kZ/ZCE6f/PzEaNn
	HXiRZKedduaATHxLPaKtrsgNZLjcY/dl8kd9EtjBTgzpMtjuRsTPQ6qY6v0Lu4X+1eL9kVpJ9tq
	CbWVUWpLM/mO6nUmOSRgOeAJdqIDDjeu1IELQaApX9t/PdkrnqlVCwRpbwD5zh0PhkCindPcw+J
	d7fh7zOYQsutRv1nQVXqIBqNc49tbI4OhEyTHp7bSfOsWGG1JZ7egtYmGuqDLnAm9LysKT8OR0G
	QDd3wP9vD3CjxszZlGeya3dYh22OQCQxYYU9N3Nl85AYH8DWnQ==
X-Google-Smtp-Source: AGHT+IHexcsWqcq7pb6cql8+KDie7vvimoWi/+7jiQiVYLknknAkaUVO0a4xFfFcJbi5waug/L/YFQ==
X-Received: by 2002:a05:6a20:4311:b0:1eb:48e2:2c2f with SMTP id adf61e73a8af0-1ee6b399c55mr3608181637.30.1739417775940;
        Wed, 12 Feb 2025 19:36:15 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324256aa6asm227563b3a.60.2025.02.12.19.36.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 19:36:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Subject: [PATCH bpf-next v8 5/6] mm, bpf: Use memcg in try_alloc_pages().
Date: Wed, 12 Feb 2025 19:35:55 -0800
Message-Id: <20250213033556.9534-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
The caller is responsible to setup memcg correctly.
All BPF memory accounting is memcg based.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3fbcbeb7de8e..c8068fd2da42 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7189,7 +7189,8 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 * specify it here to highlight that try_alloc_pages()
 	 * doesn't want to deplete reserves.
 	 */
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
+			| __GFP_ACCOUNT;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
@@ -7233,6 +7234,11 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
+	if (memcg_kmem_online() && page &&
+	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
+		free_pages_nolock(page, order);
+		page = NULL;
+	}
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 	return page;
-- 
2.43.5


