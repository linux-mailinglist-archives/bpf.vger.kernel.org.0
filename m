Return-Path: <bpf+bounces-44319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D79C1458
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 03:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFE1C21FAB
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DA42A8B;
	Fri,  8 Nov 2024 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfrP4Oxb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E71BD9D1
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034588; cv=none; b=qhjLUDV+K5W8b614g9VQ2maOeLFlkUCrj3wtuUzx4FS54tVRKSMF5P7K0tDPUH55GoeaH7wKmot1ivS3ClaLMIn8DA1OPse5/jMTy0r1TiKMy79Z4K/4bHGCTIFNlk6pE3zlt8XEZ28NP8oGSBgdq8vMDJN5uZpBBU27RaZUc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034588; c=relaxed/simple;
	bh=Tx6A/SOgItsHbkqtPVxfGDJTcfVPBut2PGfNKSZkMTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmZpoF1rXkSPunXf6UTLrraAw3P8+ht5mVHOR1h5aY5RNkeXFdoZ9iBfMrmSEHlWHTovdo4eCc8ZWJE2YX5s101KzTr0sVpz7ZsM4bAs295W1xYy1ubod7bKziIv/X7qV0zCSNvPza+UYXqeukdzn/8p4Om8fsnJY0cP5OPvRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfrP4Oxb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2113da91b53so12519085ad.3
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 18:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731034585; x=1731639385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBXOuQiOpagEhdU3WNo7zRPx0QA6o/mr45oTcI/JiNE=;
        b=nfrP4Oxb7dpijiRQxpBuWJb98TO+eMAgmXfYKmT4HGL+XIRoNH2UZDsfNkJknidz5I
         uGTvc2X5h+9fIo7bKUpEN2W+2/L/JWo1vOc+knHjFn0c1vUL//EkTf9XLWw/vI16Su9W
         HytYGUy9Z61RoSgSqKGQV+hSf8zf49Kw0L6XH7i8N1xRqYqBh9rsOBLUBBnFjgoamEG3
         ByDt8hlysb6zRtcHHd+Q68T4J1MjDA0GldcnBgihQpxG9i/beoZh7oZuOSzXXTZPFc2h
         cU0T9anqNT5qgGBPUPGozU1qGbISl/pv4TTYaG3ukDedICou3o1X4NWJ7/xjO1My4JPW
         XThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034585; x=1731639385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBXOuQiOpagEhdU3WNo7zRPx0QA6o/mr45oTcI/JiNE=;
        b=c5GfuoWsochsrTVjSm6Qaqf4z9VM0bLi7zBrL3mkx8r2QdpbZokPCFiw1jlBXFa0o2
         ch3LliJ/PpsGhzCRZgDCyDbDqblolLhvqq7aVvCN5GqYHrDRHxk8usyIXzaRyGba0Hsa
         Gt+CyUV3JVAEz/XFJf1LDJP5RGRYKd4m7jes3DajvFzdVAeUUWYCxZzwLAs7UilS2vbn
         FvVCHiQ/d6S9LT6ncGO7HhbnIH45yceHMKpcx4hpQsyib1IWwq4FJwQM7LQYQNKrJutx
         14jSiqO379J8l1L3OwZ7YgWlBZe4GxncwBHJIooL/rLPcx+IRPoIm67E8lUZ9/RJW9Rz
         +ySg==
X-Gm-Message-State: AOJu0Yy9aOnHEuwNuF14aPFIKWEM0kNd+mZ49d2ssN02BGxBzCka1q6k
	grdCj85V0faKSTZoSGEqKn54BCr0MBzYiUZA3/hdKfTVJi/2oIuyZNXH+g==
X-Google-Smtp-Source: AGHT+IEJwlMT3jFnfiG2eGK+FMRwvmupX/A8BFXBaakqOlWl2YFoorBfxSYpDJ6GjHN73XswIQggZQ==
X-Received: by 2002:a17:902:f70e:b0:211:6b25:1262 with SMTP id d9443c01a7336-21183d3435dmr11851305ad.20.1731034585103;
        Thu, 07 Nov 2024 18:56:25 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59f0dsm20382945ad.173.2024.11.07.18.56.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Nov 2024 18:56:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	djwong@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a test for arena range tree algorithm
Date: Thu,  7 Nov 2024 18:56:16 -0800
Message-Id: <20241108025616.17625-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a test that verifies specific behavior of arena range tree
algorithm and just existing bif_alloc1 test due to use
of global data in arena.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_arena_large.c          | 110 +++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 6065f862d964..8a9af79db884 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -29,12 +29,12 @@ int big_alloc1(void *ctx)
 	if (!page1)
 		return 1;
 	*page1 = 1;
-	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
+	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE * 2,
 				      1, NUMA_NO_NODE, 0);
 	if (!page2)
 		return 2;
 	*page2 = 2;
-	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
+	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
 					1, NUMA_NO_NODE, 0);
 	if (no_page)
 		return 3;
@@ -66,4 +66,110 @@ int big_alloc1(void *ctx)
 #endif
 	return 0;
 }
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+#define PAGE_CNT 100
+__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
+__u8 __arena *base;
+
+/*
+ * Check that arena's range_tree algorithm allocates pages sequentially
+ * on the first pass and then fills in all gaps on the second pass.
+ */
+__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
+		int max_idx, int step)
+{
+	__u8 __arena *pg;
+	int i, pg_idx;
+
+	for (i = 0; i < page_cnt; i++) {
+		pg = bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
+					   NUMA_NO_NODE, 0);
+		if (!pg)
+			return step;
+		pg_idx = (pg - base) / PAGE_SIZE;
+		if (first_pass) {
+			/* Pages must be allocated sequentially */
+			if (pg_idx != i)
+				return step + 100;
+		} else {
+			/* Allocator must fill into gaps */
+			if (pg_idx >= max_idx || (pg_idx & 1))
+				return step + 200;
+		}
+		*pg = pg_idx;
+		page[pg_idx] = pg;
+		cond_break;
+	}
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int big_alloc2(void *ctx)
+{
+	__u8 __arena *pg;
+	int i, err;
+
+	base = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!base)
+		return 1;
+	bpf_arena_free_pages(&arena, (void __arena *)base, 1);
+
+	err = alloc_pages(PAGE_CNT, 1, true, PAGE_CNT, 2);
+	if (err)
+		return err;
+
+	/* Clear all even pages */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 3;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 1);
+		page[i] = NULL;
+		cond_break;
+	}
+
+	/* Allocate into freed gaps */
+	err = alloc_pages(PAGE_CNT / 2, 1, false, PAGE_CNT, 4);
+	if (err)
+		return err;
+
+	/* Free pairs of pages */
+	for (i = 0; i < PAGE_CNT; i += 4) {
+		pg = page[i];
+		if (*pg != i)
+			return 5;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 2);
+		page[i] = NULL;
+		page[i + 1] = NULL;
+		cond_break;
+	}
+
+	/* Allocate 2 pages at a time into freed gaps */
+	err = alloc_pages(PAGE_CNT / 4, 2, false, PAGE_CNT, 6);
+	if (err)
+		return err;
+
+	/* Check pages without freeing */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 7;
+		cond_break;
+	}
+
+	pg = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+
+	if (!pg)
+		return 8;
+	/*
+	 * The first PAGE_CNT pages are occupied. The new page
+	 * must be above.
+	 */
+	if ((pg - base) / PAGE_SIZE < PAGE_CNT)
+		return 9;
+	return 0;
+}
+#endif
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


