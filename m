Return-Path: <bpf+bounces-76613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E78CBEDCE
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BBA13065034
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DB31A571;
	Mon, 15 Dec 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="rl9eXW8Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31395312803
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815218; cv=none; b=QT6QT+Hd4Yg98VMTmz2y2x6zvQLMew63WcD8ugSN+7vs0FgB39zxHSwx5V2ccIUvN3aS+Sw+5MzMr5GK1bh0mpzghcy3PMeU+FlDOn83OE4DiaK99yElZcjW/WXUAcXEBMUxabE8G32qUNIgIRWh7RCsqxbT210Jos3Yi3WagJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815218; c=relaxed/simple;
	bh=QKklZNDCBbtgX24QvKioLENZsTgQqwEqlksnSvOA+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2n4a7PFBAK20R5IIufMNyZKW9d8Ic5NoygoLS4aAyHrLECaGlHGvTfFVaFNHW5/wgG8dYU3TlHAiUZaXbpN5cjk+PrIKulNG6TmGAWLnt5C4KICf89txFwH5kgFSVf1+LM/rtyUYGcKOo4XreOjlBTSz1nYqodY3zypLsutwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=rl9eXW8Z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8a3eac7ca30so269658885a.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765815215; x=1766420015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kNeNvij4YvdP3gTA3QkJ0KRZQZN3MAGn1aJzBgUs4o=;
        b=rl9eXW8ZrvcjkZMuwh0Dv7yRJDHsdsi669IwrdNjfap6SsANzm1n/G1HRrusUg23oF
         GEV3qZZCiYZv5McJqVWJnQxL6miI4KpL/T5o+0kRqIEUzsil9QESLQENvbFbPaceBXgr
         6qqxvszRAmy+M5eHsS7jfXcm7ixDPPKlMiAV5heLXgy+QtRWiyCuh0TfZ67/N1uc39OL
         I+MZdHO2IVD6lq94hVA2JFO/Kw1beBPt3bkYI7fodIqcX2odfoANqz7D2QQtiZJKWHss
         OnPeLYp31TY4zPD4HDsNwb8cGKOOS4E55NxYlnpkCz+4IgDxumEhUdsJg+DKUiAzy1r/
         y5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815215; x=1766420015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kNeNvij4YvdP3gTA3QkJ0KRZQZN3MAGn1aJzBgUs4o=;
        b=QjrKJA+RiinuyzOgW9Pjq1l0F+O5X616KFVt1/SZHk1mz5Q+oGtH+sZM1zZETty8Xn
         lRYn7zshWGBYel7SccTe+S1+Fyq/crCiHOjLu2g9VH+JnBS+XytTkewk4ZOKzvpLo1+m
         yPVWxhEo2XAHVWnmu9ogpkCtf/WKJT/R80mpVrYOycb0Bd3V+tYxrdplxMqTsXNLVfgl
         L5fsWyfUtp4fuulA316etaOtplq/4j3Cy8No/Kf/jPw4LNDJmhQxKaorNzVgJwe3NlXC
         nHVdTsnCrhe1quDrgB0IYvg6ErVnjN6aSGeaakPX7Tch41x+jOOlJv4lR72d5LtWwMrl
         ltiA==
X-Gm-Message-State: AOJu0YzCgR35UQ+9HpkU/jm4iqslyd/CyVkd4iILAA1d4ixHD5/eqI6p
	t0Tyml3pkQCI0t33A+M05uiC/C6Lflflwz/c5s1ZzsnbnYVa8WRxheCAX4T7yAQAdV5pPSwvdRa
	3qMEb
X-Gm-Gg: AY/fxX7Farb1Ms+vJ55bG6jz9QY3yl3+zB2CBHE5cXgmejZaCrfhqSjUL3g68fravWm
	F67JQ53aY7+pkiLA/8noLjSIUEFSOCSjbTf3hEADKT+/q/xoamh2anI9MSzjt1eqJ91FFK3Z3yA
	cXEFmoD6hFaTI2TgxGCq0HX94eWbjMsbE6x6JwHOAtQo7IMQafnXUXp39inNEFzCIf8w4d6toX4
	7yeDkcUGfb7UM7j5BeA8I2+ja7/vNcrznMeqTybF88fwILhzdFW2SeONK+QQ9W6Q6eokM8OfLrI
	sIMI3d21YMrJfqbqtm5qpEID2ClBlf33eewrzPyTYJREBb+7m2rwxZLet2ZoWyc2ZU1IUW9io3o
	G4P5kDRw+tQuOVK60PyMKZ2Bl2k1Bu0L4NC2w5ZvbprybdR4tw2JI00sycDNBkDnG7Nu7Zos+KV
	PUI+6mDHYCOw==
X-Google-Smtp-Source: AGHT+IFy4pNBgDxw1xfMUAnYDlCrM7fmnBySBZduwlXKNs59rdAM4IQqTrKX+DNAE7cUhyDQTqBU0w==
X-Received: by 2002:a05:620a:44d1:b0:8b2:e9b7:5606 with SMTP id af79cd13be357-8bb3a390883mr1486501385a.76.1765815213278;
        Mon, 15 Dec 2025 08:13:33 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm1142195585a.26.2025.12.15.08.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:13:33 -0800 (PST)
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
Subject: [PATCH v3 1/5] selftests/bpf: explicitly account for globals in verifier_arena_large
Date: Mon, 15 Dec 2025 11:13:09 -0500
Message-ID: <20251215161313.10120-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251215161313.10120-1-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
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


