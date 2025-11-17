Return-Path: <bpf+bounces-74818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC1C669A2
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C11F4E067A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128C314B72;
	Mon, 17 Nov 2025 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="D+5mdGZp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19D2C0296
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423822; cv=none; b=AzQy+nIQ+r5HUnYx7X8ZO4QyCMpifG+vvMxdjp0FqChvA2ziDknw76NvQiB+b+Bm5l69SRKDwnq+mZ7deGudfa95RdJPl8RO5oFTIKYYlKTHncqHewbVxcOeBxZaiRObUuWc9U45gSRWCOFpYcSzI8hewj/miUZW9cy6LxDdStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423822; c=relaxed/simple;
	bh=4PhiQstjKhHvYJ5nklJ4jLICN2ugPypI/Xc3TqqhjyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHkdmIN9g2V40CscUTjbCbQIxz58oJv7h24r0yppogXLsB7wQX+7CJTk3UfHoUPnSn4x8qVodgN+FlAp0exgJ1LSvvpBbrRg/afhLEbeESKHUvvjHsuY/FwdtpIi3omaJuRed//QvTiuhOhuclwpCFhRwvElO7DU+KUeSjPfJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=D+5mdGZp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88054872394so64524286d6.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763423820; x=1764028620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/DMMSngiLvpTHRK1ArBs/JSnlOpOYeNKXtqhFEPKME=;
        b=D+5mdGZpBMOlMLz62hzjJrf6JvX24PsBeiyGGmpuRgCjYZ4GkqEkiGfOoFu8CmpJam
         PeMWzVil4rW7x7rA5vq8FY/em0CEHc3i86HGWopyJwxdqRwrxi2d+pCKFPAwwm3xSdFb
         yh7uH+rduQc8W7+jaUILIstlAtOAEIWVLdbNNEKYnrRWGTon9JQ+KfhtGtbP+5N9Mh58
         AYy0nlLvG59fYpmRxyo+nulQ2zoVxIvur2R/nqptV+aT0IPp9GO4ZUkdLhzffDHHACVW
         eq7hQx/IM9rnaB4uj8Sg8pUW8EijsyEqcPBlDiqSm0yj1NotD6IvQt1x6AkbHMQQe3aE
         9akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763423820; x=1764028620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/DMMSngiLvpTHRK1ArBs/JSnlOpOYeNKXtqhFEPKME=;
        b=Tlbr6wzXMT6OVmQDOsLZECLRTrsEOHSjD8SfEYIdmJTyxHUSI9eUAPqEhRycVMUHK4
         rHq9DuW92nFVhyVQcX2pytRwyECinc9E4vbKrf2Pn5Fn1E+/nGP7a1zHsQ0+oFINOzRO
         MVgZDoQ/aj6aWv9WVrsT0k8SJMen6yJwxia+g2GYG6cKql7IN1VAazEAV78eYKZyqnbT
         FhUFPyum2VkpqLaeq1FfW14YpjXdDyF6HtRBj7cEMfkFCsO3dsQaL4Ibos/lHdmTNOkU
         TdMv8+JToBRzrtJ8O++A6y0ObQDDFxDZV3LDK2Bka/xVVevZEO3G63BibnOWEzVPfpuT
         ZOfw==
X-Gm-Message-State: AOJu0YxrNkJcrDVejDYa2KyYBNHYFxaka2N2JtvLby2ZTyINTaNilHz9
	WHKkicctKluuLNNUWzzScD6Y4Fi9aIXhefBR8EOH055WSc3VKYu9hTiDwk1Pg6fuoRWsHAN/geG
	Wb+sWotI=
X-Gm-Gg: ASbGncveaP8FFBbJRY+NRx3DJnhV219nrL5hRt0YdCdFb4p0FuW0aurfHYrUMeRcT+/
	vR4rXrNTJCJHFJv8bJVt9zQMH1dxKEtu/NuAUoo9IQRw59afStj59pgxxHuSeU2PrpqRAK2S34W
	gVto279ISgFgatM8IIFMsbRYclmxIpJCQc16EvVz+RbclJSOpeQpGEoE4DA7MmQZjpu1i612YS+
	SE2BWw6vSLwBe/SjjNuq4dilbOGJN1Wpb9OOyAPZskr98n+VfIgPfSissU7jC6EQOdCY3Jcatav
	Pdzp13XQza7v7NutkB3HTOOZ1znU8rTsLDGhzkQESIs7uyrL5zmekmuNIusPLiR3XtcQbGFecS4
	XdshwQIPXJ0vJ6jaD76ApV/o2I56DPHaj1oecyZlYeYvo/DtMvK5Ko3gNztYjeWWR3GdxpdIJZN
	j9+va2ktsmHA==
X-Google-Smtp-Source: AGHT+IGcn9o1EVepWgsMjFfklIlXEPVdJEIGRcQ2T9FAph+WefgWwvnmjaLUo3f4KT9Pl56Hdmu82w==
X-Received: by 2002:a05:6214:d86:b0:882:4130:d109 with SMTP id 6a1803df08f44-882926b1e26mr238758296d6.36.1763423819579;
        Mon, 17 Nov 2025 15:56:59 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862cf6d5sm103077516d6.11.2025.11.17.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 15:56:59 -0800 (PST)
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
Subject: [PATCH 1/4] selftests/bpf: explicitly account for globals in verifier_arena_large
Date: Mon, 17 Nov 2025 18:56:33 -0500
Message-ID: <20251117235636.140259-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251117235636.140259-1-emil@etsalapatis.com>
References: <20251117235636.140259-1-emil@etsalapatis.com>
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


