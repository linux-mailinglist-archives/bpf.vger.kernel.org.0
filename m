Return-Path: <bpf+bounces-76736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BEFCC4BA2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C72D73078A51
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF98337B8A;
	Tue, 16 Dec 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Md6iG+nM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425630DD0B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906515; cv=none; b=CBpR61bhsbyO9SOt1I7wkYIi+ObOpiblgpjhaNw+5H1SPuaZU3pGAg/nuoWjeTUOh9hPyPxpU8Zina8WMROtQ0EBb1+EO7VOeTp1yvg7Va8vesS670eFFlIrq+xi7aGM1Rh5ba3xp1QM8JyHmxp/IS1UKZnINcn/np3T3CtYgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906515; c=relaxed/simple;
	bh=QKklZNDCBbtgX24QvKioLENZsTgQqwEqlksnSvOA+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTDCqKAuGI6uH99V9xvH1PPagTUTgdTmvi//FvsbqfLuiiSOI1VDHjcAPiIYOfTAveOwhAJ7RJtPm9voqYzbBsTFoLXNM3KZmv8nLTBkKGojNXTHfa/WgwT3hrTxYF6BGRQD118OQV0rMZxbnp8BCSlBdC6vDGOoV0m3p7WcHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Md6iG+nM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee158187aaso45918771cf.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765906503; x=1766511303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kNeNvij4YvdP3gTA3QkJ0KRZQZN3MAGn1aJzBgUs4o=;
        b=Md6iG+nMsxtAJPi1QOnP3nBHCI29pXpqzPUNmT90T80lBYPLhmDB0kKh7AnrN+HjFi
         cZdrb5nnw6UFzSjA5piYuRN3sHHzvm/j9jHcqu1RxIgSRSoLHzpRqtvrNUtG8RV7rAqD
         cQs4KBCj/OoU43bD2fknZOa+DqH38NdFXJyoNfm76MYX8TDR1I5sgavPYr0v+3JgHfxn
         eIKDtiiBy2kILJnvDzE4aXdoBKzWWhFs+otmvchja2cIhIL7QK3WyBT+uRizzpuDX66q
         njC5aZLM1VDK7Ry2YGSTINwimrfikI/Sl0AoGc3X2JHiaU/vNf3MlhvbZoP2buMAHw+E
         9MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906503; x=1766511303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kNeNvij4YvdP3gTA3QkJ0KRZQZN3MAGn1aJzBgUs4o=;
        b=cJdP9XtIsQK/9CcMFrzeR8GcSWn8Arz/4sSL78R/2uiFDKXVKQQAWt75L84vXO6AmQ
         +c/edKr8T0u0LVmxtjv8QIneigYvUn6xdDLWYeZoR1pKr3zcNuGPTIrEyOI/wa/DZKEq
         m0qJqhMLqwPj4rb1rgHOcIkNL/Nis2M5GWYUikmXcFjhmCFXAEpuGc5qSe0jO3KbUExB
         cMt3bVemF3AHWHvWSMo9yFXipCrBquPYTkxDdxEWaiAgoreNYAN3DVMjcL7H8qdkYXZt
         qhImyBt3/XydtIMMpO7Z39VnkmQX1UjJbvJmOWB0DNm0g0YKuyXO6dxh+sZmWRXRwEzp
         ha7Q==
X-Gm-Message-State: AOJu0Yy6Hx45LnKBuNQ/B1R9Z+YtVVuMD5acC2GNniq51qj6WdIOXMFM
	hasJrQu4pGTXUuIbY7J5tb44Eb84H4zCvcyMAT+yGRMNOtZJC88vtuYv5mUQIK0IXuvtzDQXCX7
	sHc3ORrE=
X-Gm-Gg: AY/fxX4J3FES5VeN9wBTvgvrhsWHIaTUrqPnkhqCMgCJ+BTzLwidQJsPd0TPyb5sVq+
	icdHTviihpE6eAGLc00CmQtmfhnkQm/LfCtxTgtlWF0BKchF+RHOGvdxmi8HqD74eprmsKVD/Is
	hjsBt8JaWj9rn97Xa3zq9gjBLddtctAxjiD0BnAXr4fYW+e55j0U9G4IyVGlsGAYi+EdAvfGdOl
	VvrDNLsyPicEgqiV9slfelJ8eJS/ZB4DsxI+x9P3TNywyZHFbWEKbKlDQFMqwlJS+jcs95sOmEx
	iIBals+usuFIE40y0JIOYW1sEHS7gL5UINM1h2aRCYG+kZv0MmzF47qQDTYizbYuhS7BIzI6Fgf
	tJF3x2DD9Mho1ZM6ZGGPVyr2QVgVSRbDtFuH/H28lIoncFJPBXvyZ+6KyAN9qspWMAZw1HyExtc
	g2SbvEZ6bF2QHmErbt88Qx
X-Google-Smtp-Source: AGHT+IEceUGZxQQjeBAM7xOPOZDeQTQofKX9mVm7vh2b9Sq9GgABdz6WLts+FFvrCRqGTt9J3cEOAQ==
X-Received: by 2002:a05:622a:4c06:b0:4e7:1eb9:605d with SMTP id d75a77b69052e-4f1d0462e09mr227379701cf.11.1765906502954;
        Tue, 16 Dec 2025 09:35:02 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860f8basm79310456d6.56.2025.12.16.09.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:35:02 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v4 1/5] selftests/bpf: explicitly account for globals in verifier_arena_large
Date: Tue, 16 Dec 2025 12:33:21 -0500
Message-ID: <20251216173325.98465-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251216173325.98465-1-emil@etsalapatis.com>
References: <20251216173325.98465-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The big_alloc1 test in verifier_arena_large assumes that the arena base
and the first page allocated by bpf_arena_alloc_pages are identical.
This is not the case, because the first page in the arena is populated
by global arena data. The test still passes because the code makes the
tacit assumption that the first page is on offset PAGE_SIZE instead of
0.

Make this distinction explicit in the code, and adjust the page offsets
requested during the test to count from the beginning of the arena
instead of using the address of the first allocated page.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/progs/verifier_arena_large.c    | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index f19e15400b3e..bd430a34c3ab 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -23,18 +23,25 @@ int big_alloc1(void *ctx)
 {
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile char __arena *page1, *page2, *no_page, *page3;
-	void __arena *base;
+	u64 base;
 
-	page1 = base = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	base = (u64)arena_base(&arena);
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
 	if (!page1)
 		return 1;
+
+	/* Account for global arena data. */
+	if ((u64)page1 != base + PAGE_SIZE)
+		return 15;
+
 	*page1 = 1;
-	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE * 2,
+	page2 = bpf_arena_alloc_pages(&arena, (void __arena *)(ARENA_SIZE - PAGE_SIZE),
 				      1, NUMA_NO_NODE, 0);
 	if (!page2)
 		return 2;
 	*page2 = 2;
-	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
+	no_page = bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_SIZE,
 					1, NUMA_NO_NODE, 0);
 	if (no_page)
 		return 3;
-- 
2.49.0


