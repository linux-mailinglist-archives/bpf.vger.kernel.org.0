Return-Path: <bpf+bounces-74820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A1C669B7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2A2734A430
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2031B13B;
	Mon, 17 Nov 2025 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="KxYVkEIl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B230FC20
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423832; cv=none; b=hmHEcvtjrXAi27t7d17wIhWbZTuXPuX9UcMXw7Vs/Bi8gsZyX/NOGIV8faWo3v0GM4eSINBVbzQ4q0Bu6OUcQBoWdHH1a3454zQEDPePeRO4FbuwEu6QIyUmePnWzsy6c9+Ns6xkOHiwsbLeL/9UGg4+xPx8qfOqdb1bbPmJRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423832; c=relaxed/simple;
	bh=Hwx7aVYImdS+Ac3R+5iIp9X4tYPObnFSADm3yjneK9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNWPoJeE/ZnqRqDWW1CnxNjYPkXwi19yaFHY1Yx0J0Cr/QEh8qCDPb6Fx//dHoVUI84400eLnjfvJrdIWbusafF28ZUmxFwYhxPzbr2V6gHx5NWTUqHv097gZlxzqV8wBrnjFevrxY1ng3ACk4fcaoX268kcQloryHVmX2AFvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=KxYVkEIl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8824ce9812cso53541686d6.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763423828; x=1764028628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vo8eszMObAKbDdr3cj2DycamsfkXDpRcvmTtsqHABD0=;
        b=KxYVkEIlkdO2qyoMclohnTUCztrOIpHcvJxaY34NszXRYVaDH4xfshXYeS9xllNFWg
         to5KUD3mhDxFBbRS5htSCXCzo2b9spwjVPUwmQmVtoyq/1mc9CYqm679UfRCMCc2m1PZ
         dtdb4UBlsaTyxiaOJ1HwywRwTzX688ut4aGwAgutBdNnOkF30YxLv2UcfeEOEJKOQD5J
         IZaGFN1XiYKEcbnzVWLk+cq4QTfwLKp53heHnYQ0aMlvGz8sIKBbiFVsshs+bwpLq5bC
         YV0uEauA517K4SU4AuZKL6mDHesdi4z9Q9YHWO6RazEGa4PKO9zHIs/HxAcq/tMZajS1
         Ke1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763423828; x=1764028628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vo8eszMObAKbDdr3cj2DycamsfkXDpRcvmTtsqHABD0=;
        b=EWHjrd6IdHHLiXzga4WKUUysjyzrMiFj3zK0f60+Ie10FgLs9nHiN50SKmjVTKqApf
         o1ZdcS1qG4+1CYkyR21RA77JcYT4yyZHwDrFgJstjYhnYbZFnLWAmK42d15OpuczSEZU
         qI8bAQ++MRz/2ItNVPD488YKhOVqWhl7kGUeNT1lrrfYC5/n6MPseFqcNZmWeiuPKjjr
         0A8xBQBDm9jZTUlCxKU7hWlFYUNuemEF9vYhi8wfC8Tgn7grXCL8F9bHAttuyYTT3D+S
         XXjarmNLqmcfw07TxLB0qn2F7xLSO4UYI1fmwjl6weGfRz8v9p3uqw+WQ/xAqVNJg0L2
         0BpA==
X-Gm-Message-State: AOJu0YyVoVxQoD7+jd7mf+t5tjY9VN2W12mel/pgI41oTcEDlzWiDrkb
	h+jw+bBMr7k6X+hekYH45mxiez1z6Usd1K0Yr6tc/j0IMJONYyqvQx4VrAWovI7ipg7V+rYsegs
	y+fkuV3g=
X-Gm-Gg: ASbGncv31TUIyeoUSrPll1Eol7g87J2MpgZqKukVe3w90rlwjwJ4WpIg/gg6+2YGKGb
	GuUnAQWWXL+i8xt44+dhe0zcJzQIJgyke/alAniKGkvfuuGfUpc6Mqvbf9lqaUWELoqrJyghxk0
	WBk1nostTTdKPYsF4nH9DSjq4UoNJ5gtlusNvdJILXxjFm3L1Hon1LB0+3hy7CCeklgQ9RUSUqF
	hHS5VabipADo/lfmgsXtNhoc010QD8ePeBYefGCUXhW1co+ASHJM1hT9//ttBztDsKvEB5V1ehH
	0xp37AHK6lgjhqT3crRDZSuoekVnKG8AwKKGZoZQ5qsgWY9l2CAvNer3C0FG9LjCauZTpIjcwyd
	EAk+gUFBfQcbj4RKjeB/lUFYK9/Wdfb2M922SHeh2ZxZkBjSIXC7q1xt8U3eg2n6tU+kxSnqm0l
	0=
X-Google-Smtp-Source: AGHT+IHkS1cHYi+8LKJiQoUiBTsdCzieiX9x/qhaiemlsCePaMiG314WD13+gvkOXST6lgbqoJOfqg==
X-Received: by 2002:a05:6214:2586:b0:876:735d:4190 with SMTP id 6a1803df08f44-882925c530dmr204649376d6.13.1763423828282;
        Mon, 17 Nov 2025 15:57:08 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862cf6d5sm103077516d6.11.2025.11.17.15.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 15:57:07 -0800 (PST)
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
Subject: [PATCH 3/4] libbpf: offset global arena data into the arena if possible
Date: Mon, 17 Nov 2025 18:56:35 -0500
Message-ID: <20251117235636.140259-4-emil@etsalapatis.com>
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

Currently, libbpf places global arena data at the very beginning of
the arena mapping. Stray NULL dereferences into the arena then find
valid data and lead to silent corruption instead of causing an arena
page fault. The data is placed in the mapping at load time, preventing
us from reserving the region using bpf_arena_reserve_pages().

Adjust the arena logic to attempt placing the data from an offset within
the arena (currently 16 pages in) instead of the very beginning. If
placing the data at an offset would lead to an allocation failure due
to global data being as large as the entire arena, progressively reduce
the offset down to 0 until placement succeeds.

Adjust existing arena tests in the same commit to account for the new
global data offset. New tests that explicitly consider the new feature
are introduced in the next patch.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c                        | 30 +++++++++++++++----
 .../bpf/progs/verifier_arena_large.c          | 14 +++++++--
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 32dac36ba8db..6f40c6321935 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -757,6 +757,7 @@ struct bpf_object {
 	int arena_map_idx;
 	void *arena_data;
 	size_t arena_data_sz;
+	__u32 arena_data_off;
 
 	void *jumptables_data;
 	size_t jumptables_data_sz;
@@ -2991,10 +2992,14 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 			       void *data, size_t data_sz)
 {
 	const long page_sz = sysconf(_SC_PAGE_SIZE);
+	const size_t data_alloc_sz = roundup(data_sz, page_sz);
+	/* default offset into the arena, may be resized */
+	const long max_off_pages = 16;
 	size_t mmap_sz;
+	long off_pages;
 
 	mmap_sz = bpf_map_mmap_sz(map);
-	if (roundup(data_sz, page_sz) > mmap_sz) {
+	if (data_alloc_sz > mmap_sz) {
 		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
 			sec_name, mmap_sz, data_sz);
 		return -E2BIG;
@@ -3006,6 +3011,17 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
+	/*
+	 * find the largest offset for global arena variables
+	 * where they still fit in the arena
+	 */
+	for (off_pages = max_off_pages; off_pages > 0; off_pages >>= 1) {
+		if (off_pages * page_sz + data_alloc_sz <= mmap_sz)
+			break;
+	}
+
+	obj->arena_data_off = off_pages * page_sz;
+
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
 
@@ -4663,7 +4679,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
-		reloc_desc->sym_off = sym->st_value;
+		reloc_desc->sym_off = sym->st_value + obj->arena_data_off;
 
 		map = &obj->maps[obj->arena_map_idx];
 		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
@@ -5624,7 +5640,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 					return err;
 				}
 				if (obj->arena_data) {
-					memcpy(map->mmaped, obj->arena_data, obj->arena_data_sz);
+					memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
+						obj->arena_data_sz);
 					zfree(&obj->arena_data);
 				}
 			}
@@ -10557,8 +10574,11 @@ int bpf_map__data_offset(const struct bpf_map *map)
 	if (!map->mmaped)
 		return -EINVAL;
 
-	/* No offsetting for now. */
-	return 0;
+	/* Only arenas have offsetting. */
+	if (map->def.type != BPF_MAP_TYPE_ARENA)
+		return 0;
+
+	return map->obj->arena_data_off;
 }
 
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index bd430a34c3ab..f72198596889 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -10,6 +10,7 @@
 #include "bpf_arena_common.h"
 
 #define ARENA_SIZE (1ull << 32)
+#define GLOBAL_PGOFF (16)
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
@@ -31,8 +32,7 @@ int big_alloc1(void *ctx)
 	if (!page1)
 		return 1;
 
-	/* Account for global arena data. */
-	if ((u64)page1 != base + PAGE_SIZE)
+	if ((u64)page1 != base)
 		return 15;
 
 	*page1 = 1;
@@ -216,6 +216,16 @@ int big_alloc2(void *ctx)
 	__u8 __arena *pg;
 	int i, err;
 
+	/*
+	 * The global data is placed in a page with global offset 16.
+	 * This test is about page allocation contiguity, so avoid
+	 * accounting for the stray allocation by also allocating
+	 * all pages before it. We never use the page range, so leak it.
+	 */
+	pg = bpf_arena_alloc_pages(&arena, NULL, GLOBAL_PGOFF, NUMA_NO_NODE, 0);
+	if (!pg)
+		return 10;
+
 	base = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
 	if (!base)
 		return 1;
-- 
2.49.0


