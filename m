Return-Path: <bpf+bounces-62829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1CEAFF18A
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 21:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2627189A38D
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B770623ED6F;
	Wed,  9 Jul 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jyi3uyEM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11723B63C
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088400; cv=none; b=XiviwzLbRTtSoFXE3h8pv6JwAVpYzjTRnWt6tUoSBKosAmgL675kLZ1UxMdD7My2JBhCxhit7V4m8C+x2VdchbDbNJHH2VZ+A2AUV6UVL5NdNe1XxjL1Cm2QsYgKZZ4lAHf05e875UYKviNIaPgCFEbeprZetq1sPtx6C1/vIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088400; c=relaxed/simple;
	bh=HqvOwhG2gUNrV14wyzpC0PoPx3XpzEPhhGfyiXjtim8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5xdA8koPvz/vPQMhVhTxoCtbHBcYQSjQogl1zFjfWM6sWJ7PDfH/XWEuPh/y4PmS/aah/KzO4pvRpoh+8so046A8DegY4BOrBa8KP2bKLrw/pQ4K60amzvN0UWINebQ7N9i6j8F0p3TWAh13sr0Zg8+sfMk+cWDZKq++MHtHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jyi3uyEM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d9e2f85b51so23672685a.1
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752088396; x=1752693196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQUR3MKa4qjlkUx/cM5YCByHAe9k0nfoMOJurJpKgRs=;
        b=jyi3uyEMBhTVWLv5/qpjj9xrnxXrs56aJJ4LyM5J6IOlxvVy09cC0t5FHhxZStd4BX
         zNutq/MrlZyTgAH43n/Bd/QT+NkTCG1l99yTpj90vmY7yxNJiZH8z9pWjL61CVsHjrDR
         +94m2u82FzYQVgAsKmHzyyGc9KGC9NZD2asjon8srrIrbckTbyjhs12Ppl4VRCGhd9o4
         Q/8ckg9Br2RwK10ldLOiwRCq0dRgtdMOcfGyxI0BU3ldFIN8chh5VVMz3DjfvXPJ895a
         RDr9B7A0NVUhRMjmZvO+NH+5tq5SY0G3Y6MtJuN7EmZ9iGKL3sl4KgtVeY8y76r3dlfK
         sgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088396; x=1752693196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQUR3MKa4qjlkUx/cM5YCByHAe9k0nfoMOJurJpKgRs=;
        b=wv4dwnf2lI6Mgvc19FunHiqhFtyOUnp9bCwcT9Zsy5tzvY3Z5NH6S0A8kaq4/n8ppZ
         IxOv7VMGbhQSUbtMqQwpfGcn14nB6jEZkp/uQMxEcO1TjeKxH+e7BYYd1gqZJeQhc02h
         gPQuVbczfBMerRL0j1h4oq09vEJhImPySuEGz8rhwquYmV8FgoS5G3bVAkHVenbzlhkl
         0A1yKTjE25Ktfh3HR+NDfROJngiOAl1lbSVW7vEBpqARqg8uaVN6SqWzQq7/H2er/MvA
         xo9jjNsrPT/8ijKV13t9Z7jG9HxS5mTj2kjXtcxjVIp8jbhwA4jR5Vs6ZhEHkxoCKa4B
         16ew==
X-Gm-Message-State: AOJu0YzdDrSZhtmqPzlO5p3m/AyHaBxmd2C2kjLRDND1jv+XZu2HJg87
	ijTi0RtfAcUwiqjS1ioH9VrSmD4wtgaY1MiqvhrulfGxQlOew2HDknAOhZSafhn7iIhhYC9TKc1
	sb33UNd8=
X-Gm-Gg: ASbGncsXwvk/lgmBh0DQQHjCue8VmoJTUNePdh63+SnX9/1C9i4mMRX0EdJyMh2OhMB
	w0M3afZlx7/srugaJT5KFVUOMLlYqATAuJNvHyNZ8P6yQ7BfAOLJLJZr94yVx5jttXpENNs4/kV
	9/d1rLl27XW4J3BX+HcnCjj3Wu6qrBJXNCZQiT5FkM+PN+0FI7L81XjDMjk4DW+/LEhYtSqCPXp
	eaUMwxy3FYmTSok8Lo13toBU3a2CsB3BVS1VAv3z/5+kosaz2HwyjGB9CIujzmFgKEfmvzqOWD8
	WMLgqXMvylewrmNnQuIUzUpAWqQXujGOQYCnsDOLJvUuq+LBm69b+ceF4gM=
X-Google-Smtp-Source: AGHT+IEojJMYyoYZ5yOIHVcuumg8mhpF7oevQplfexTAWdPnLDHYJ8nbxLAKOJAhdZNVfv6rxqjr4Q==
X-Received: by 2002:a05:620a:4885:b0:7d3:b28d:9aeb with SMTP id af79cd13be357-7db7db7847amr618417285a.48.1752088396040;
        Wed, 09 Jul 2025 12:13:16 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe92c9bsm977186985a.91.2025.07.09.12.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:13:15 -0700 (PDT)
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
Subject: [PATCH v4 1/2] bpf/arena: add bpf_arena_reserve_pages kfunc
Date: Wed,  9 Jul 2025 15:13:11 -0400
Message-ID: <20250709191312.29840-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709191312.29840-1-emil@etsalapatis.com>
References: <20250709191312.29840-1-emil@etsalapatis.com>
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0d56cea71602..5b37753799d2 100644
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
+		return -EBUSY;
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


