Return-Path: <bpf+bounces-75977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1DCA0601
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 18:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6092A32B28A2
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AC35CBB9;
	Wed,  3 Dec 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="hMZJ57x1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F4835CBA4
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779211; cv=none; b=YXEd/qpZkgIi6+N2IIsnWzHdJP/Wkw219ioe9paIbZ76PFcu0WVc3Dt5Fy52KFGy7koYTmwyd2n1LaFzUqPqgc7+hP4GJYACpFrrO9a0Q1GDupNWDLzZ1GzlMLNC7XkSU5JwF4Wjd2CJZixsVbYz1VKuS6VqI0zxHReSf4P7A8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779211; c=relaxed/simple;
	bh=RBMRWTpMETiWQ9KKjuoS7dtkhhXMrGZhhndkcwA6ylI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPLNdkTBNZ6QeBaBv6KVvpb7cVDm8ySL1erhPE7kFWWvsQVn2g7l6HrAuezLVj5qCW+5gz++8ayoL78/p4VYQqdCyXAIiM/Q/ZU02+XQR4v5iu2ECcYmpSajau6jTyVcQiejK2uksBcJ4QT4aS0fqaQIDtoIbAoGebN96Sjex7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=hMZJ57x1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed7024c8c5so52606661cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764779209; x=1765384009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ALtRIDrVv99k9TvTFnA3ykaoEN7pCIq34RQhLYndho=;
        b=hMZJ57x1l4M9tWrCVc6EIFcEAmFozzTFoA1rlQmMDA/QNT8fjyVybHW0i9TXj34pgS
         08HRV2YELWDkUEqJg+CgHFQhcleeRvkP84qAdmWnvClyf42/jQDcIdKDheacskW2EvqZ
         Icn5GNsvmDWpjRD5G0v9nyoIQkIBH1T3mIMmkBslxomhK1UXXZp+Py4ybUCNCSwmpwYt
         qx3+1nAElN7AhuIsVSpElPHWv+TQ7EFQZLfnb4o0M3ZA8QHTOXsustbwsnONXG+7BjnB
         pAGLx/RuxKaivLkWS7aoEKyS3kJ/6xKu4BfVhUQrWZWXG4lqX3RreZSQpXvzqPkRihC4
         QoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779209; x=1765384009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ALtRIDrVv99k9TvTFnA3ykaoEN7pCIq34RQhLYndho=;
        b=Al3mEkibQe9sHQwPuglUCwXmBsYqX6yNXxfncDM95/pRqmM3+kcNgL4d0AGV5sRFbJ
         Rbr6GWQ3OKrCAqHOk4PuTNfrkognqpgPkbr4UEzkbEqbOUYv/eM2Luuimx9P+UrDww2B
         B39vDCXJkXqT1Q6SoXr2LLLZCv27m6VHIsugKvxB1/usIZrKcASoP6gQYpwMFR/DpS5K
         vDSPEVIeyhUjgrXkfZvBweWTLLl4Zk1gCvejkTonHIoRaIOWziBfqOI3mSRVUP5/uuu3
         2pBjXN3pC/pel56blG7O5OK03wPKSRpseTGSWSkemdsscQn8e7QTAl0BDpdsW3AMIXXG
         vSBA==
X-Gm-Message-State: AOJu0YxrNE4lwK0bQ8TiZx1d0jzU7Y9/zpEaZZgvxHhh9MI5G1ViaRtJ
	R2kxHTsyhE1J++o2ynbxlWg3Vw3hle7VqnDJbHClezfJ8kOqeuEbd9RivfxFO7JUtRqxJl35LxI
	8ik01q3k=
X-Gm-Gg: ASbGnct+E/gHGTY38Gjn8wcl4m3YqWshc6SNFoYYdzsyJMKvCsaSJYzX/F18NRu4r64
	JER7Wm5stA6TOSZcPH+n7EoaQcnF3F/W81a3+QWOOGyfu28QhH08n3ewIlNrB7g3LlS8y0GcxvT
	C6yL+Eggu10A2EV1EKadmDwxvbDuxf1kwK2/LAizCas/2zdFc6UjTh2/uGFvY+igg7nFPWEdhz4
	/VRyypEhPOcGTVxhqmzUeKGqSnMKuvVLIJWogo94k6tkuWnxuZdIYQ8VhZ1KJv2JIn755dPai6N
	BfTnyebDVgRkOGfX0RpMFyvx6XO5Rprrayz1EBVlzn6G8v3gMnnATmJJY9crdhgm7evNuHt7VAA
	d6+8SBQvmVidD607PZoyMjX2mpi5WOOZVP+49Jd3DYQGuW/KpKhAk/Dx0S922HdiSNsfGPgi811
	SEojfXZHfRbA==
X-Google-Smtp-Source: AGHT+IF7GzBlu1iyz/a6OfL/znABMXQ+4Vlo5SNgY2b3lsZUXDL6rBrjuG4nCfL1xahU6TWaf4sSZg==
X-Received: by 2002:a05:622a:60b:b0:4ed:aeca:dcc8 with SMTP id d75a77b69052e-4f01754a515mr42542471cf.22.1764779208581;
        Wed, 03 Dec 2025 08:26:48 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f0046825d6sm45279411cf.5.2025.12.03.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:26:48 -0800 (PST)
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
Subject: [PATCH v2 3/4] libbpf: move arena globals to the end of the arena
Date: Wed,  3 Dec 2025 11:26:24 -0500
Message-ID: <20251203162625.13152-4-emil@etsalapatis.com>
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

Arena globals are currently placed at the beginning of the arena
by libbpf. This is convenient, but prevents users from reserving
guard pages in the beginning of the arena to identify NULL pointer
dereferences. Adjust the load logic to place the globals at the
end of the arena instead.

Also modify bpftool to set the arena pointer in the program's BPF
skeleton to point to the globals. Users now call bpf_map__initial_value()
to find the beginning of the arena mapping and use the arena pointer
in the skeleton to determine which part of the mapping holds the
arena globals and which part is free.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c                        | 19 +++++++++++++++----
 .../bpf/progs/verifier_arena_large.c          | 12 +++++++++---
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 706e7481bdf6..9642d697b690 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -757,6 +757,7 @@ struct bpf_object {
 	int arena_map_idx;
 	void *arena_data;
 	size_t arena_data_sz;
+	__u32 arena_data_off;
 
 	void *jumptables_data;
 	size_t jumptables_data_sz;
@@ -2991,10 +2992,11 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 			       void *data, size_t data_sz)
 {
 	const long page_sz = sysconf(_SC_PAGE_SIZE);
+	const size_t data_alloc_sz = roundup(data_sz, page_sz);
 	size_t mmap_sz;
 
 	mmap_sz = bpf_map_mmap_sz(map);
-	if (roundup(data_sz, page_sz) > mmap_sz) {
+	if (data_alloc_sz > mmap_sz) {
 		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
 			sec_name, mmap_sz, data_sz);
 		return -E2BIG;
@@ -3006,6 +3008,9 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
+	/* place globals at the end of the arena */
+	obj->arena_data_off = mmap_sz - data_alloc_sz;
+
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
 
@@ -4663,7 +4668,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
-		reloc_desc->sym_off = sym->st_value;
+		reloc_desc->sym_off = sym->st_value + obj->arena_data_off;
 
 		map = &obj->maps[obj->arena_map_idx];
 		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
@@ -5624,7 +5629,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 					return err;
 				}
 				if (obj->arena_data) {
-					memcpy(map->mmaped, obj->arena_data, obj->arena_data_sz);
+					memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
+						obj->arena_data_sz);
 					zfree(&obj->arena_data);
 				}
 			}
@@ -14387,6 +14393,7 @@ void bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s)
 
 int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 {
+	void *mmaped;
 	int i, err;
 
 	err = bpf_object__load(*s->obj);
@@ -14402,7 +14409,11 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 		if (!map_skel->mmaped)
 			continue;
 
-		*map_skel->mmaped = map->mmaped;
+		mmaped = map->mmaped;
+		if (map->def.type == BPF_MAP_TYPE_ARENA)
+			mmaped += map->obj->arena_data_off;
+
+		*map_skel->mmaped = mmaped;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index bd430a34c3ab..2b8cf2a4d880 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -31,16 +31,22 @@ int big_alloc1(void *ctx)
 	if (!page1)
 		return 1;
 
-	/* Account for global arena data. */
-	if ((u64)page1 != base + PAGE_SIZE)
+	if ((u64)page1 != base)
 		return 15;
 
 	*page1 = 1;
-	page2 = bpf_arena_alloc_pages(&arena, (void __arena *)(ARENA_SIZE - PAGE_SIZE),
+	page2 = bpf_arena_alloc_pages(&arena, (void __arena *)(ARENA_SIZE - 2 * PAGE_SIZE),
 				      1, NUMA_NO_NODE, 0);
 	if (!page2)
 		return 2;
 	*page2 = 2;
+
+	/* Test for the guard region at the end of the arena. */
+	no_page = bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_SIZE - PAGE_SIZE,
+					1, NUMA_NO_NODE, 0);
+	if (no_page)
+		return 16;
+
 	no_page = bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_SIZE,
 					1, NUMA_NO_NODE, 0);
 	if (no_page)
-- 
2.49.0


