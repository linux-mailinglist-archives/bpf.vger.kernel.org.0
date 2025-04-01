Return-Path: <bpf+bounces-55025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0EBA772F3
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 05:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300167A38B9
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D251C6FFB;
	Tue,  1 Apr 2025 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDOJOhv+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9DB673;
	Tue,  1 Apr 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743477825; cv=none; b=fdGuEBarIjgWHuGs13c2PnKDRl6AAp1R6ocLwDH/xhUmYjIcqjuvKUsQhTdTJ1brHH6AUXfuos+IvD+n1SX7sQA5KX1LmuV9gsUwUc5+1pmRVn4ZlmaL6L5ur4mQMP+XCGv4D3BU5FV+l44/xw7sB+GHrQor8jH95/OZ0vyCn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743477825; c=relaxed/simple;
	bh=nG0WsX3of3zqmPKgElR7SZ/ligqqKz0zzpIj2mhfED4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dTL0ICNrJnmP9wys0Tkeb6vR7RfNRZVoitUXfLCjc+LeGIejRsS5ERLoPq9xDBH5aOoGoD6onri1m2jOF3ktH1iUGooqNiSp2DZKThTv7YqNBTRJ8tIAPtMmepPy0w/QR2IGV4efl4hVqrlb+1uAf/5iDtDjDW2e+pJBGFy102w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDOJOhv+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2295d78b45cso6352395ad.0;
        Mon, 31 Mar 2025 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743477821; x=1744082621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GyTHIHtfK/M/EaItKiDbKrlUkEHiNDtcEd/dqqaWX4k=;
        b=cDOJOhv+6PRbq8PRDERwpp7LFkuLzgXWpVWEnS+fY/KkzR3T4IltmMx8TFPquotKv6
         vgLJNJhuC9jRvDecu24iZugmtr49huZrmqPfxdMLcWPM6gMlDneZcyyPHbEvUNQh0Zyn
         gOyqCfNmutDpBR5/5+ZiSBEtIH5fUxXHQoDS6tgL6CIAcUHzCUMnMVrz57Gu1UpN2PpV
         R0Nb28b98tRUncZeqIuuGDsb0OgTq6ZnBmIvr/+N9sLzjXXjOkBbI9FtU9s2LSDMmTMP
         nEG+x4E0jBO1JlDM4rtoq/dn9ZFNAxum+ICmCF3AWQaJss9s/I4WZBqilA2LPg/EpuFX
         pCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743477821; x=1744082621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyTHIHtfK/M/EaItKiDbKrlUkEHiNDtcEd/dqqaWX4k=;
        b=JzyqitbXGL08jao8D8celAkqnuF0jaF0t95BdG/GE3boh6BrosL6A9fC6HXrkHEncz
         380VR2IDtkN5xuQIfU7qjhKx3t1QYCc0EdR8AYkmlgHgthbBQleuIUNfsRE+Qz9GISgV
         FGEJKnFaAD8o/pAuGY9qIIEyK9nhgu//1uFRPwTQtMjnf/IBzEovtAcgZxUKJZeF1Hbm
         28OmLDEbVHg5I1ERXYKQy0n0XCofbHWfqafu/rMrOxpEBPrVgIBZMm2Suv6BS2QqM7DF
         l8P5OdTEXKZ6wIbtRvgofsWF/5QMXLT9gB0D9AN06Ssacg5Szk+Qhmr0F5ah/CUiva5e
         z9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEaD93AUeaBEUobhe93JF0zfLqoJTxmHzZ8j4YpJw/z9B7ha2tPT5IBCIdvPWS8ByIKTl6lBon1Euh0Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYe9Di1lfx21FOqK1Kh2UkNA9awVKJ4BVH0NF2fTL++H9aAvy
	u7+vnHgw6eYjIGOApxYzY5FErJufLZss9+U4/zV8eD/ve0faPjyy
X-Gm-Gg: ASbGncsJzLBLi6VoqOckSc3vQ9pEUUbLQ/ulhUYQBPp6iuHEhdp6h9+by7sJnTvHxYq
	aJUE21KUii2wLljumYFytEuBC4hzYmxFYvEpcUjHVv8AkAp2LwdAvjgd2clEmv0joSXhTxKcb2B
	TjlGq4M4lQRmrfHi/goEvEfGozIlQTj0FrP8KKJzkx1kowWxRIIZFPFiWF/SlRFM7MIM6E67Top
	3gYIo3nFAN3mKaUCC5Q+2DA9L/6LWFBPmz4vVQyvBDnD99hU6fu1LOkYeJIM0W+vc9fUOOa/I3A
	UMRqpZLQH2lqWCEmEiBvJTogee0DzsqAFSfXhpBUHbLMarLA8E+AVKxVBwEUN5sMY8dmXA3w
X-Google-Smtp-Source: AGHT+IGbATZ37yRIwmSJcgIyIsI9pZaO2Extab2UnYDBjvUc6rmoB6R1Uotr7JtV9bUkdDI9s3wWEA==
X-Received: by 2002:a17:902:d48a:b0:220:c178:b2e with SMTP id d9443c01a7336-2292f954d7cmr193286665ad.17.1743477820888;
        Mon, 31 Mar 2025 20:23:40 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:22d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee0290sm77399575ad.79.2025.03.31.20.23.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Mar 2025 20:23:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Fix try_alloc_pages
Date: Mon, 31 Mar 2025 20:23:36 -0700
Message-Id: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Fix an obvious bug. try_alloc_pages() should set_page_refcounted.

Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---

As soon as I fast forwarded and rerun the tests the bug was
seen immediately.
I'm completely baffled how I managed to lose this hunk.
I'm pretty sure I manually tested various code paths of
trylock logic with CONFIG_DEBUG_VM=y.
Pure incompetence :(
Shame.
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ffbb5678bc2f..c0bcfe9d0dd9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7248,6 +7248,9 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
+	if (page)
+		set_page_refcounted(page);
+
 	if (memcg_kmem_online() && page &&
 	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
 		free_pages_nolock(page, order);
-- 
2.47.1


