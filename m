Return-Path: <bpf+bounces-46475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDE9EA543
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BB4160644
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226D19E97E;
	Tue, 10 Dec 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSltBbeG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE127456
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798412; cv=none; b=Q/VQQOQVV8ULyF4e7Ms0is3g1pTIG9yYXVHyhFhi5tZCKhh16+aEybFnN1UqzgR0gf2sXoc8mWUOuTtvVtEvXnOYXoDJTSE7SnNAFvctvw8AF6wB4rDkoXNo18PXD2KGsSRMXNYUvbEDr/1D+86xdrrYdcr7ebmrkV+UDpqhiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798412; c=relaxed/simple;
	bh=JR613i1llUMzESxxaqycZ9MjvkFCwoZDaJ+9bxjM9vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrwrVeHM1SV78BnGrpHmOROnWIh6sEe1aitqoXZcj2cNLTdCbii6MXdhdS2d1SWYuZXnxQT6tTioS0jCGOJ1PczBZFi9dEy9K8xBvO13TQoe3JMZtUSp2vExaJ45mtcXtlKBEFxRPuU8JBcXmJY5FFLsvtpV7rIIngSMOGu3iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSltBbeG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7feb6871730so308291a12.2
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 18:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733798409; x=1734403209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiTKIgIWEw4pjiXWRJupFp29ffG8tRf5Pk0epbA95Ok=;
        b=fSltBbeGvVjaiUwSeXJgCVW+e/QifyesUDhVGYu+wGA0E/gKR7vb00BKIzZg3CL/hY
         2Zg2llFP24OgFB1gXYNNssAXfS/7N34qKla09XCmfsC8vPFuzCsghluJ3gxNfH4mFjmE
         UlxFRLL4dR/Lp/R0AzUFGcO8MhmYxn40lszgx2tcKPAL07bIsN2aCJBz/5fS7UrOVs/f
         K9EMhcD6aL/FdlIghQR+boAtNFjfZF+Z6rcxWtOgICUf0ewgi1GDCx+iQecxFs7noGYv
         ml0p3VgVjx+Ms2pV9JXtV7cEVRy9cm2pBIgHu4Z0uzzs/X9TYTB6GQMWtLMIv8lf2k0r
         uvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798409; x=1734403209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiTKIgIWEw4pjiXWRJupFp29ffG8tRf5Pk0epbA95Ok=;
        b=xE1LWmw6go1XmV1/ZEu7ohIcOs3IgnW4evAS5/sXgFVisFOVw49IQNnDVvFq+ZQ+d8
         5524naTPmihPCjJiA6oUzC1YmnTqWj1IQqwoOj+KZd6RuwaIv8Eigps0+va1sy8Ax/pN
         cVvhqUqMQ9XMVQFocTJ23KMSqKyo3vwrZJP3r+B7fSop7U3678DJ61C2I90qhXrQgYnb
         gukYpqSOuQe6Y7xdyMV/vLkkefJ+3Epi09M+LjH93o4UNLeecZ0RluQ0FOapzDeRpppH
         Y48TM9dN8YyZCnDrTbb97CxhqtLLwCmIzuH3o5RaGrs3x07jMiN6hXLbixkXTB9PcRRq
         AMHw==
X-Gm-Message-State: AOJu0Yz0PZiABbm8LdlHSyaKVdUF9tehO89gR6biPrbLx81pKG0M8+3z
	aFi/4oR5wHCMwiPpiD04WTEo1r8UTWWkl6tughUwpPzSQ7a0VcX9LDkYbA==
X-Gm-Gg: ASbGncu0ogAtTUpA4EYuneCoWdAwKo4juvl+Nj+rQ4UfKO/9iCxqVCjunmr+kXh3t4A
	bn4WF+5IIa2umcPaY00ql5om377czXUznmwIWrbFCdgs988Hu22dGQWSQI2l2dg3T0rjYaAwabb
	QF43HtsLRP7hwK6nfh6amH0wsjzheLNIHjgpr711JUdl2F43hJGWuutybzTnBUyCMh0ahY0wE0T
	FrixCTdDMhAJ/vQBxQbHSDy1kGzojZiQEGvBdzr7tmhHkvxmUfBtJEDJEydWcDVVt7Aj0KKmzdu
	D3f55w==
X-Google-Smtp-Source: AGHT+IEyaw7MLXSrpLiOPJxXq3UM5b+L21nSTK6Jj0nYt9CgSbssrgPTsovcJ8e9A4v907+avThj1Q==
X-Received: by 2002:a17:90b:3847:b0:2ee:c4f2:a77d with SMTP id 98e67ed59e1d1-2efcf16f547mr3957084a91.21.1733798409404;
        Mon, 09 Dec 2024 18:40:09 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef1e920587sm8088928a91.1.2024.12.09.18.40.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:40:09 -0800 (PST)
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
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Mon,  9 Dec 2024 18:39:36 -0800
Message-Id: <20241210023936.46871-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
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
index 5684e8ce132d..70589208b545 100644
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


