Return-Path: <bpf+bounces-76616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2821CBEDD1
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D45306C2E2
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F093332EBD;
	Mon, 15 Dec 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gdbQarYy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CF298CC7
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815224; cv=none; b=SWMswJbasMC5jJaOOjodR4FXdRYYcXcpKa6AoQ7vAVrA/AGFvaZQXYKeYogqTsu0h8/NK/QTmH4Fw5b06OUAxYX1TO/27EdpjKxBwO+XV0jdHiTyPfvgfioSLnyNi84wJDSo5JTpNu0Tkbf8qa+tf7W0nL/v/YlhjSqOd4if3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815224; c=relaxed/simple;
	bh=X/ZBzEmw9ozdEe2h94riipSABuCHoyLZKtJOhXckKZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVgk+WSFVTn48PqPAOoYETyilnXqlrETp1TPGbteN7kBSYyxhCf8w8czcIxNeJAuAP2xxnYg2pC7fty11DUdSxZC56pHVrAk4p2QNGC5E2EZdqbf1g+e2lvs27H71k73fcREbszgYbMaXXWL/R3pWV4f8IfSjyevjtqaMVoU45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gdbQarYy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b5c81bd953so404467285a.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765815220; x=1766420020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2qbRsCxl0t1Vae/yRYRau7WLDVBk122vh7ZUBizV7c=;
        b=gdbQarYy1/KNe23o54X0NzcQL5xttMmmJ2u6Dhasjnx5yRZx21w9D8/1n35pz0zYxM
         4iWX01x8JOTYqRI9+h1X9v/I/wDhAnROJIwBaH3patmFWy54TFLjV8hGcVSJ5KKamFK7
         U6ONsIVh6T/BJXJk1IbgvL5uOk+QU3sgaGeMu0Pb9QFKF0wfCQfyBn2SBKJU1MSZ9Am4
         8zNPLw9gBeOLAbxku1zPuoG6OdXCRhvwaIsdTvj5jRk6yGmRcn/L/LC5gCyA9fqCqWEp
         9QHMcJsVqmy+0Y1URVYrR9wdxP7bopvtiqiq4rAx2KaH2pbxmoIZXk8CiJYBsZAJcXlf
         35CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815220; x=1766420020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2qbRsCxl0t1Vae/yRYRau7WLDVBk122vh7ZUBizV7c=;
        b=PG4qW1goy83WkGLglWlYJWOHc8ldH3DCSNPTFVyIYooiwTUGcPa8xqy5hX9PZqzlmk
         0CZeXS494EzbYj04RA5qZ7KDlvK/+4+7brTKHu+jjq1R7LhTJ8klicY39Cw6kJUCRwgV
         zIB/kcDHFVZeXYlWyWIOASM4cUWgygMExB3Q0hmtLsHIMsA5ZoYQRL3bd7VJmYOdQIEU
         AKSyA7RrshmmVVJucoMlWbq6ga2R0LwGo9ohR4qL7KsY2WohMaVqov2vtiP+JWA/F4Lo
         ZZ5vct5NPk3PuHCe3DDMYl55TZvoF3i9tMOSOgohRfKJEc9ovnJl5GfnaSGTcKhkpIFg
         4udw==
X-Gm-Message-State: AOJu0Yyj444/NMgR5aJrsH1oZ75JtocajUFJ55Su6j0siy0QrjMSKG5f
	H7FetgSpuFqq/RfrwKQHIKFdURH/7h7liiCHaQgITwTec7CNfYPjQz08pGvZoOQ2A5uopLTSgaF
	VGlne
X-Gm-Gg: AY/fxX4CF/CWPgLrTdl3adDPbN6gCKosdy9Dpg1rf9NSTMpsMqtkb9zmgdZdU63JF/p
	VQGimFM51Ngkk4qQQd3HSzt/efVIG7oy4K171NuWrnLEA7daqZbVRh9umV06qf5gAWETEGThoY3
	52Pw0AcPsSGaq9mtbj2BEMfbaaW4xQhWMblegCmbRupi2FVdPl9DwVwEt9ICFm/kheX9egseLKo
	QzWNTc5NG2FYiIM0y/ZzIncOwRSPUzXXo1H6VyleOX9UPME/8VJ8q5SFRqMv1KwphN5hW7gi2y2
	eA0ogxXPIngYvvq6/iXaPCI+c3JkMvaC0To1FPIOAcCnn04u/j4h1ThrxowylLmm+zbf/VpqR2X
	3MzIYtokJJf3aNVi+TRkZH71R2sifi08MHSd3yU1Ya5JCNKDtN+ABlwgAwXAwtTGqPy1yJ/BtO0
	s5tAC/1dyAdQ==
X-Google-Smtp-Source: AGHT+IEvLc7D1ieKM8ehW4Vx4HwvOhAA1Gh1gli/01fuKKrjZAHtYHpu/sfiF0kp8Y5TofsondMV5w==
X-Received: by 2002:a05:620a:31a6:b0:8b2:efd6:1c79 with SMTP id af79cd13be357-8bb3a248935mr1684296085a.68.1765815219445;
        Mon, 15 Dec 2025 08:13:39 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm1142195585a.26.2025.12.15.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:13:39 -0800 (PST)
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
Subject: [PATCH v3 4/5] libbpf: move arena globals to the end of the arena
Date: Mon, 15 Dec 2025 11:13:12 -0500
Message-ID: <20251215161313.10120-5-emil@etsalapatis.com>
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
 tools/lib/bpf/libbpf.c                          | 17 +++++++++++++----
 .../selftests/bpf/progs/verifier_arena_large.c  | 12 +++++++++---
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5e66bbc2ab85..135f5b36256e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -757,6 +757,7 @@ struct bpf_object {
 	int arena_map_idx;
 	void *arena_data;
 	size_t arena_data_sz;
+	size_t arena_data_off;
 
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
@@ -14429,7 +14435,10 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 		if (!map_skel->mmaped)
 			continue;
 
-		*map_skel->mmaped = map->mmaped;
+		if (map->def.type == BPF_MAP_TYPE_ARENA)
+			*map_skel->mmaped = map->mmaped + map->obj->arena_data_off;
+		else
+			*map_skel->mmaped = map->mmaped;
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


