Return-Path: <bpf+bounces-75975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE398CA0C9D
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078CC317B416
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2AF35CBAA;
	Wed,  3 Dec 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="V7BlPfDz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9035CB9D
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779210; cv=none; b=cf/q/QZaP9YVfYwZPUc6IdQ5SGFqkMN8yIEfdvvGLe1+XD27QKQyo2vHMW3v085URU5hMLzRvyA+nTvKeo8e09qZNJcDrEnAm74TFxePU3j0bibIsEzxlHo6JBdMC9S7x7NnTtJslC89gS3ubbwAObltH1i2ryNE9Idncp3xf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779210; c=relaxed/simple;
	bh=QKklZNDCBbtgX24QvKioLENZsTgQqwEqlksnSvOA+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXbSy9qtm5TlG+kLPa1cXeuWbowXG4gK7ZREVwu6Hw0ER5ONoAGJgpEUmIsVK2lYtkzUnKxtJpBOmKBkS1oJ1dDbiwIz4fbhnSwxUsUOru+g18aEceHlXYUeE3KpWFlsyrEPLxEqz8zOqXGX4cbfuHXPBJpmL06GV3JMgYyRiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=V7BlPfDz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed861eb98cso74385761cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764779207; x=1765384007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kNeNvij4YvdP3gTA3QkJ0KRZQZN3MAGn1aJzBgUs4o=;
        b=V7BlPfDz+vLW3mvH+oDccJy9++rn0B6Bz976NtqhXos5tv8TVhC4kR1HOzw5V/my11
         7clXPqajk+XTKBD/h0icgYZPU+y1E4I9hQmcmCmqRozQvcqBiOTKglwxz3iRjAtm2Mlz
         lnSkl2cwf/ky3dPim+u03s0n0JqjsHxJX+FfYwRXuqREIFsRoAgrXlgdftQ1e1zrzS7L
         6x2GbzhJMBDFrpGWO9YdakeqO6Fof6QCXDlH/s2GHbd906bXvITiLW0+TVV9SrUKkzNK
         8svKF5T719UlWhR4kuFanx5Y269jXQROoI093XuvXHZh0Jpri3qoNAvaWljdP/SWDtsL
         Savg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779207; x=1765384007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kNeNvij4YvdP3gTA3QkJ0KRZQZN3MAGn1aJzBgUs4o=;
        b=JjiR2O/fUnQvysoZaGAb2XMOTN9ciqTQSIBNoRAsS3PdPIkiJfL+vpBqEVnmcrbFPM
         PqvS3K53KKIpBqYWbVzlLwvEmG6/3BvJWPUlKbocb/nHnANqMp0nJcyXzXyc2qb+gWij
         W+ne2ewKZlZxd1fwqGP421QtZluDk89lrVDlWHHio58Q7kC0qxfdeJqve4PBIeZhLgOv
         e6+GNLm3dkXuw7S/r0U47ZNpVTtUHh9bm7iFMEI+4dkfctjPpqt2FyP2iwudjCCqN2fp
         PsDV/a0c9lp/gfTbV6OeLppFRJmYAVB7YhucKzu/i/iOIy3GD6vt6CLud3FRJRe7ACPQ
         q1xg==
X-Gm-Message-State: AOJu0YxZ4gZrBi7mQpqnkLT06ohDQA6CoKWqPmuuo69O4vgufRq2hKvu
	emk8N5PaHKK8xnksl8xpP52K03jvZ6U9cL9rJ7D3YwAb9gL1C1ljzhYS/bxFR4qUHjV/2ZVOtTw
	tm5oj05w=
X-Gm-Gg: ASbGncuiablyssKv1yXGMRrn3GD3NvtOtP8nBS43wS44DuMc/nm1Js5HQhbjsZLFGBN
	Aocq5WYMORMq6RGwmTAMN0Rbq6eoEshowFhyqsnsweg1J5Y5QjHeNsmFZmj0tTnwIj9VudRVi8S
	cujKPBbpzukfaR6usX+Cxzh4jhVZIWhBbgPc6mbLRWPoSqP+f8RLQscShoYzGtpOFjYWsgxAs+A
	YteFqsfq7xxOuLIUj8ok3ehSPAX7XBPuqMlIxAj/bqOXAxExhV4VJL5g+48O587fIl96DsxbwPU
	L8Q8bouSM3Pe6lBztefUCXN07cqtKzy0+oftKHyN19zizCn9BrKjKDB1f73vFnZ2P2vKxJhM449
	J+YKcpMWqSZRz0cEGFjuLMBsl/AUYHCkw5IA9iODkWbUTCPGEstdyqm49E3ZO82dg2V9bTuZyaz
	p5yw7/XlcvCg==
X-Google-Smtp-Source: AGHT+IHLycjQra7/KKGRknvnxAl7KcR8eVvqXHJtbWBvGPBuVVOlXtO+xNzXe0fZi60zt2mmm+O8uQ==
X-Received: by 2002:a05:622a:1301:b0:4ed:bad6:9fa9 with SMTP id d75a77b69052e-4f017592172mr41901861cf.6.1764779207240;
        Wed, 03 Dec 2025 08:26:47 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f0046825d6sm45279411cf.5.2025.12.03.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:26:46 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 1/4] selftests/bpf: explicitly account for globals in verifier_arena_large
Date: Wed,  3 Dec 2025 11:26:22 -0500
Message-ID: <20251203162625.13152-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203162625.13152-1-emil@etsalapatis.com>
References: <20251203162625.13152-1-emil@etsalapatis.com>
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


