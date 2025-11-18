Return-Path: <bpf+bounces-74848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD51C6714A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 04:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D84B029BCE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405A2F6930;
	Tue, 18 Nov 2025 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="oAhw5hi8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267911DF963
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434874; cv=none; b=j0cNNkX1dSLTgzw1IccWxlYi1kvggVa96X4jNF+F4tMg5/A52vSGTFfFYEbT5NDhfqu+hbk1Y4Yx9zEueOOgM06quAAYw0ws/U8LqtbmOWQ9edKPHfyCMRPBM6Q6XdtDicQ85DVzdrSzkS6lDPAIaPzxA88NFFGDgYJorNL2Coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434874; c=relaxed/simple;
	bh=4PhiQstjKhHvYJ5nklJ4jLICN2ugPypI/Xc3TqqhjyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5O+MIVJOrVZlfVNu/xBSZnAB6g+zQwH/IJMlJ0jFxWn63snQmCnFvR2g9itcuUDa55P3Q5ExmMpoi1DrCusXLFhy8PG/NTEFJpGCYPXTEiBr3OLYetF2FfxLQYNt9L5uvdFqgvXJGn1DKrqHtApl7aefdlbZz/PZgNdph4JT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=oAhw5hi8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2dcdde65bso374403385a.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763434872; x=1764039672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/DMMSngiLvpTHRK1ArBs/JSnlOpOYeNKXtqhFEPKME=;
        b=oAhw5hi8CWyUwAqpynicHg6oXJ8aYJOmA+RCOgz4a+umThKlGx1xJXf7M4YZPGybPo
         7TChE2CP9W9yCYuy3YZp58AwP7dwWe6tyhDDGmvxPNAxCHtaQhj/avvjM0jFyk+Iz/Wl
         gPG+GLCgwu2fc3wRuDWngG3fXQR3ooIGMbc0XRwbZgkKATqrBF0Ak5XN+Qt6R01rWwQl
         iNrjf1fUpk5mRz/ivl1csTrBx55X3BGexmWFraozZAcqr99DdRy8O44LL3PYepEtSXzQ
         jI2hdxTHCZ4CD/V7m+t1ctgAvvUCXTCUH7NlFD29MSgJhyc0l3LVqS+5EfT7iqQi6pLD
         QMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434872; x=1764039672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/DMMSngiLvpTHRK1ArBs/JSnlOpOYeNKXtqhFEPKME=;
        b=S4VjDVbDebbMG/lkM1Cv9pZ5p7IO8lSh5wsqygK7S1AuDs6q20tVTmhJj9n+SkOcPN
         WMIhgY0ghYixWO6D5b39IdcOU5c5qvYg31tdIrlX7o2WiMVduZozD5IrsQrtjoVG9VMj
         xebKhQV5LDtzOBa+BJ36396KBA7QpnqV5yXy2t6Hf77HP6z+wIsT0bf/1ZlHRU/VjpDs
         5012UfxgOf6AL0EupTP9dxqLPaSfhThBWHfZ6/Iz9RtIZVE3ewY22ibBi7cwWbi3uB3Y
         JxhjBjniME0IajInEt2a2V7Jfv99tSgmmSkpQAlHHYWVsi8OvtUT3Sb3wr9QsT9sippP
         k61g==
X-Gm-Message-State: AOJu0Yw7eYh7nvBjR5btzY2dyewnvdAV6UyCqNhyRc5WKQqAuq5ymqko
	m6pPgJvGKgNsvKbc4TUGV0Y/wBsZloTzh/KWUm63TMN1Iwl3afATcwSz5rCQ2SvISGcq8KSo+QR
	UcYJpocs=
X-Gm-Gg: ASbGncteavgzPjN2ypVNLdZMdsOM7KJHK1+w7GkALckhjlNV2Cs5vaZEhb4EEAvmj/T
	BBm2FOQRj4MTfaeqc74wraS45QFVdIlTyLfaOer6Ga6ri9/gQAtKJtf4wOCOfLP08f6MNiKXbPn
	pt5/NjPLo2zPGTRxVLlvVT9f/o2qrrROrwx3stzZrRBN5bZbAR+n5H7lbED4hrBRSYRtR0NgvWE
	xayckfxOvQ0w64eTTZPLytNr35EPYNIuEsl0lnucWO5CLmfXNkD5QhAbq6P31EeRWN5wrn4CcC6
	xPQ3fftlLCf/G6zKuK0iUQ+AYTLDCgPt/zjLPUBoWXSbfG5DAipih/n0N/qSzJ2x1Uq0LSz4sbL
	XEmN2tdHVC8Hfh/UP8fQXEXZ7kduYh+2siGKXZzLtg2s1G2R+Ubo7H65UaGzrZB+WdmDsfguG0m
	g=
X-Google-Smtp-Source: AGHT+IHsd5oE5WfqgW7IcfHt7xBFZ21uGBMUCXlvDM6xAFG4uz+MuVpX/xLD3zcEpNTrt7LmC6UCYg==
X-Received: by 2002:a05:620a:2545:b0:8b1:2fab:30c9 with SMTP id af79cd13be357-8b2c3140318mr1725459085a.2.1763434871851;
        Mon, 17 Nov 2025 19:01:11 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af043037sm1117130185a.48.2025.11.17.19.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:01:11 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 1/4] selftests/bpf: explicitly account for globals in verifier_arena_large
Date: Mon, 17 Nov 2025 22:00:55 -0500
Message-ID: <20251118030058.162967-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118030058.162967-1-emil@etsalapatis.com>
References: <20251118030058.162967-1-emil@etsalapatis.com>
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


