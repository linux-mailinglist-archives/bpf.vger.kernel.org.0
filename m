Return-Path: <bpf+bounces-74850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4FCC67153
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 04:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF26A4EAFC6
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577926ED3A;
	Tue, 18 Nov 2025 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ww+9BbOO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627161DF963
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434878; cv=none; b=lX3K8gOgmn/IrkfIEPIJNLz2AORLZNikzYxL5ik0vgeGKopWgXfXry72V4crtF9NgmIofcNPXjuPz0XLQHBcSw5vzTDmP2zRIZnWQTesj9QdSo1tp4vbqm1+ZpcdCQrv/GhqEcu8vopOSPPZgwaMzLfUDvVFMySk+QEUmoRDjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434878; c=relaxed/simple;
	bh=Hwx7aVYImdS+Ac3R+5iIp9X4tYPObnFSADm3yjneK9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jykGz3jq4bPRBt3RIYu4tJGpCwNluO75CvIEXukU9WvBWZ4imy3mzp+we3O1xpCyCr2JlYOszTN60tcZnB+c08u1VYpfGavL2oBnMYSJqieCfnMuV8YIef2GNfOSEsAt1RBmqN/FWCujA40adpq95l0VWazoKNvW+rjZIOG6mcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ww+9BbOO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1f2fbaed7so396822085a.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763434875; x=1764039675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vo8eszMObAKbDdr3cj2DycamsfkXDpRcvmTtsqHABD0=;
        b=ww+9BbOOu2ReEvBId4owN76ovt6t7Pmit4EWMxnoWaAGMGEtS1cn2R+TysSb40dkwj
         OtiyjmMSbZWmecoF+RwggM1lpF5X53arXdoLauXblY0pIQgC6XTnAiwuq2Y5NI2bomNM
         WzmVMZJ44TdObSPS36wvOjKat6XNP2F5oHTEe5EshJ463ODr1x6G5dmJd1UxPIMyBJy/
         EHvVwnBt2qKNAD8cEVR4Uwo96bsbwKgpcTGJQ6yF24+igtD3bYM6EAs7EOEsMyHdAIQr
         eHRaZB4qCuzA7G4Td0d3tSxBTv2TrvYbdwn8MkbyWT8GBqGnHPLXYZfQXp9yA7Cf+aYo
         C2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434875; x=1764039675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vo8eszMObAKbDdr3cj2DycamsfkXDpRcvmTtsqHABD0=;
        b=L0TQg3+6JQuX2LPb9/V10ctD6MCLP86Mwq9SrSJqGmao4fHVylXWWOYgy3gbx7c3iJ
         pKjdMGC6AnyZfWY5rEoyofFXZcv9ZRRaMHgwSBanqcQzM7tDOAYS4hPFoIOuf6oX3/JR
         GQX1HAYVJtLLd1hvReI9msTXOjbEHrdMz3oSA3DnWEuB/dmoseCS8rB0aIpDxNbT9d9L
         aRh6Nhbc2KG0qCGvBukcOd/Ng2/bS2z6ESLic3sRWyWKgKvHtBrWxHl3s2n0Ia2jboXs
         2QvNRlAlEAI7DDn02MqIa2i5AhKvOI6Xsr9gNZaFW0rpD40syBbabCq3koFoQxOzSxB2
         YhwQ==
X-Gm-Message-State: AOJu0YwPUpsOwGQ6m0Y7ijd3oBblcB3dMLDgZiCFgeJYXWpXU3MFGvWV
	cLhvPHT3NyANa6VU+OfnixgOSIO+rRFvK8taTidE9kBQGqBVKdZMevTCjIo/nWIQWytn98j9xWX
	wadX/rjs=
X-Gm-Gg: ASbGnct8qFn0Qgw2QOv0Zxx1MPrVPKZvyUr9qIe4vy96DV1EBIgmWgb9JD5scFVs+lH
	GdUH3ArhFeaE23qnhZGfpGsvxoz3EWDErUAmj6VgRWbgfzGQCXqFh9lhFGmVECakVqEMv/0OQrs
	Wlwg5Czr9uA24VEvjVGDBoDMdXuFPv33+6/xhdEK/uPtkR6LULCQuUGh5bYYFhjE+EabI6N9SDX
	OKf1TibfVUdSybeDAXfzZ0GC7Bb9/yXHOFFbSrMTkmsPkR74QtSAplccuFMb7oGOuvPp4A/S0Wn
	lBXDxltUfW7PMPDCN7P0W312ndihvDjSxpAOjcZXCAloBbpvpidPtyOIDd9EY+VFLUPFK3EtPrb
	Zd0EBdQIbMz1/uedRo9G7e5Wj0plMYUmAzYT5JTVkgA6C80wHAAMFWjP1nf9wnUa0qMcfqNNkfb
	E=
X-Google-Smtp-Source: AGHT+IFGCc/HCHpVmMrIs/YHvpHnD47JZh/mMFzoyVB3SCypUg4WWF1ee5IqXSkQ6xsSaKhkHfpUJA==
X-Received: by 2002:a05:620a:1726:b0:8a4:4156:16e with SMTP id af79cd13be357-8b2c3164ddfmr1796131385a.20.1763434875089;
        Mon, 17 Nov 2025 19:01:15 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af043037sm1117130185a.48.2025.11.17.19.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:01:14 -0800 (PST)
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
Subject: [PATCH v2 3/4] libbpf: offset global arena data into the arena if possible
Date: Mon, 17 Nov 2025 22:00:57 -0500
Message-ID: <20251118030058.162967-4-emil@etsalapatis.com>
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


