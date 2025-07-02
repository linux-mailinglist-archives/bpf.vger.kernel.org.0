Return-Path: <bpf+bounces-62024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE2AF074D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 02:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758C3189EE00
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24B5171A1;
	Wed,  2 Jul 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ksBvvfN2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFE46BF
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751416447; cv=none; b=E7SFHe8lzzujVY6GfnaFhMlJEHkasF0stlQiEKqG5incyYJUT/H7g1E6LClEFlvkaKPpBTZIGQUmu9Vgwtek7OP34XDj5DMrke/PuP8Tzfdqc2Lh5gTMLUTLqefg3D6PSuU2SmvVu9HbEo/uMxBRL2QzxO6NIZ8rUMzMWGe2cqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751416447; c=relaxed/simple;
	bh=0Qw+LNU8vzZdds8M3Gsu9gHXbwJACv+1G023/8sFisQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkNCP+O9rZCqLi3vYFDBEw8kPtBF1gGW9NVbi3fPjzFSVOJP9hsw+W+71BHBuLSrM7t3FoaWNgWhbWJAzD2gyeiQ6eNZbBG3Xl7zXM8/Hsa7rCCOhDVq1kqai+FpFTe0EiBw9uuvbHzfRGVuUuriOsgmmrQJ4QTKQOG083q7OQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ksBvvfN2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3da67de87so597207485a.3
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751416444; x=1752021244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwjhgvZARKPTWM83aCG5PuptUTm3dySotYSmkA36j7U=;
        b=ksBvvfN2d6dnEp7+6k2K/h5JmTIGbqQLQHngzEg1i+fI8sqNSy1CwTedXFA21T72wo
         spsUm+Hfism1D7ug3BlCDIKhNzRoGiDNhUOvmHvgRGUE/0RjuCOVWR4V9UviP0yELJ/M
         a/EkJP5zFK4OOpn0IQdEpKQxoADikqdPWch2VYhZMFH1OHXkPh2oF/RGEqzLU9IAbsye
         Qgy64o1RdakP1sO2thMoKfq8L7sStavOgMYpF9OpPHmCgymx/GE53if/EoYNpBzuLKIi
         JWF9xvPbMn50txqzBA7+a9jF/xfggCXpjlNgllwzJdf83K708IbqmagbFtcPjiEu6NCL
         uKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751416444; x=1752021244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwjhgvZARKPTWM83aCG5PuptUTm3dySotYSmkA36j7U=;
        b=elvg/KMV8NirUhRwir2XBrXHC+Bpemb4YkmcEqKb6oPsGuoFu2aBKN0/9fXVk9T1ds
         SELrVwo+J80ACaC5txgG8Ej6/l6gjcvD7Ym/q8xj6TyhKaGJSdbmmlkvJBdZWIjrHRWQ
         tPK2jHNiXpIHMzkFrC8bm8PBffGCRGMRoFeIXp46Er8YCiSF0YrplsdFHFgw1Zr7ZGQ0
         oS1ff3nMor6CFiQraGJWZyySdaX7GMnw7QSs30uzawf6QswZucgYFTyWxUNj6phe4nEg
         UxQp95w/n/TFKUVQwoafPcv4mAtZ4S4ofs43nFn6YnDAavVAVmA276JfGVidq8Zx7XXe
         NEBA==
X-Gm-Message-State: AOJu0YwAXhvLD9XqI4SrtYQJlSFIb066Wu3uzLPhTL12Bv+KWYb6gsmS
	S6mPfVgQBkM7pWmyBr2KOOuapEEOc8v6L68TkOOr8jDUv+lPL7rDHZWM3iCSOu5hft8FVnbEzR3
	HGDAcSYbcHg==
X-Gm-Gg: ASbGncvu5exz47p4jbtX4bl+TAYNlGR92SP5HFLW5lF86D3447uqMy3SfyUoDyiGS0I
	G0CKoedc6GMZV1LkBwLmJLoELb4C7a4NwHPAyv1L3L5b/mb+U+m3jopYPndaoxZF0BL5u4f2nSW
	mcIsYtsKQYhZ7IjYLdUfpezAfBPeVThhno4VtK0BpsqWYeXPRVV0F5HQWf9U9xwpR1s5IPyBhni
	COJXrZHQd2vFsT2Am0YiPlbrwWcIdRff5nlWagSFKM1M+Ru8YQVWTTp0X0FfOh7HmNIm0f3kgs2
	ewS1CQlBbubfUSYhsR0UpvDGLGljlx2fGcW1agNN07uRkwHtzfNs2JGw8PE=
X-Google-Smtp-Source: AGHT+IFU+yNOOwkUFI/NkPf9Bo665P5qKa3JSRctkwSxMhAj5I5+/YAmgeVw0KNmnN942+M+jGHYlQ==
X-Received: by 2002:a05:620a:2618:b0:7d4:635f:3e42 with SMTP id af79cd13be357-7d5c47358d6mr143403485a.20.1751416444391;
        Tue, 01 Jul 2025 17:34:04 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317cc43sm853106285a.46.2025.07.01.17.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 17:34:04 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 1/2] bpf/arena: add bpf_arena_reserve_pages kfunc
Date: Tue,  1 Jul 2025 20:33:50 -0400
Message-ID: <20250702003351.197234-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702003351.197234-1-emil@etsalapatis.com>
References: <20250702003351.197234-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF arena kfunc for reserving a range of arena virtual
addresses without backing them with pages. This prevents the range from
being populated using bpf_arena_alloc_pages().

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0d56cea71602..18db8b826836 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -550,6 +550,34 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	}
 }
 
+/*
+ * Reserve an arena virtual address range without populating it. This call stops
+ * bpf_arena_alloc_pages from adding pages to this range.
+ */
+static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt)
+{
+	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	long pgoff;
+	int ret;
+
+	if (uaddr & ~PAGE_MASK)
+		return 0;
+
+	pgoff = compute_pgoff(arena, uaddr);
+	if (pgoff + page_cnt > page_cnt_max)
+		return -EINVAL;
+
+	guard(mutex)(&arena->lock);
+
+	/* Cannot guard already allocated pages. */
+	ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
+	if (ret)
+		return -EALREADY;
+
+	/* "Allocate" the region to prevent it from being allocated. */
+	return range_tree_clear(&arena->rt, pgoff, page_cnt);
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
@@ -573,11 +601,26 @@ __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt
 		return;
 	arena_free_pages(arena, (long)ptr__ign, page_cnt);
 }
+
+__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA)
+		return -EINVAL;
+
+	if (!page_cnt)
+		return 0;
+
+	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
 BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_RET | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0


