Return-Path: <bpf+bounces-76739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4134CC4B60
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D37AF302146D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BAD335072;
	Tue, 16 Dec 2025 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="TnoN6hNf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938C339850
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906517; cv=none; b=GTT5jC3lmL1hZuWSYCsxuxKcWTVJ5REsN1oWET4tLtead6Pav4/HrE00KB9n5ctUUYI9uQ6QGWPAGb61ykgkzW+isp+nz9y1Q+CdTjkC7clvumfWI/QzdEGPbPMH/ppmv60O6C296AwA1Mxe6APfsOyt6POewRphSWDY5ndCJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906517; c=relaxed/simple;
	bh=joqLJTtIkVnRI44tsYq01m3VXOwCk77BOSlvBGTbSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj29oWfmH8GvdiN6DrTAJxaTxAf6lyTKddCVZpEy3a/2plARY3TAYxtbB9geu/P6zmNhcvkkRMIZrK2EO5t6Y/RpyxPWayQpFcxn+msFNm4Er4pZBzLsZfC5DHcHAQ3N9wzKZvD4BNdeQRBnkwlTKWoxFW7RrluuXo+epDCxY3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=TnoN6hNf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed861eb98cso53741501cf.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765906507; x=1766511307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=komG/+ijvxBT4KkxTE2dkfKG41nTS8y6IlODO/1wk1w=;
        b=TnoN6hNfRJAAP7tIFdal3fNwXA5yPCX5a1aZ6WdHo/WPOEeODerQGSO7KvAL17fayk
         WmIbXPCK1VnTtD8HhIEc9YE/4q2KP/bpQFf2zq650KCFXWsVIKi4O5QnxPC4kCI9CerN
         N5hSyHF2EsMQjV4AuidMw16aXXJKXkgFwr6CjT34HqfoDJ17csvaEDysWgRbP7mkwf9M
         3BRyDxsXdragOauxXR+OPDTRtPKZx20EPr6JOhImurmW7sKTuT9cFH3GuWgptBf/AGiw
         H2p3tLijgK8zv6NPT0NTzs5aPZ1aMVoCQDcwSNyRGpbIE7GsK8ubgPHqi2QAqaZJ4gUb
         7Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906507; x=1766511307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=komG/+ijvxBT4KkxTE2dkfKG41nTS8y6IlODO/1wk1w=;
        b=q5bOxaLcYkxqp90h4KgiGAt09hJRETiGpB/8SRuPFxDp0pFwlK99B1tMX5d7AJP5v2
         6Omr7adP0dOC3OuK2OdHl1O78wdUrQln6OHkS6rb1rMbiqW55NZ3bffG3jB1NW/xXygJ
         ASFDbjG7j0d5IVSCtOrybAzkAIU3H/dUL+P9xqujXXgDAbKdCLDpFUxdwwGw8+R0BYCn
         QTKS1mxPOU5Uq+/jsqbarpHlqW+ultC8ZN6ly55hwuQoU8ZCsakzwzRGZGd6eb6EVGmn
         Z7P26R+Qh3P09gy7Ij+dkAct3AgB1bVzBi98zUcwkJvdnHIGIMnJtM4xFiIy9hg0gene
         /jQw==
X-Gm-Message-State: AOJu0YzPPEbrrzu/7cIp5baebeoopFOSwgGTWpwzY96UYEEKh0IJgev+
	6eZZgJYtdj0V3f86PpCQ9Pbb31G6UEeihsJ4nIByjuNuaczF2KAR0vVbE80nY6CRzjF8FXeOTR8
	I/sCNABg=
X-Gm-Gg: AY/fxX7aEKcpAkziBySxhuA/FVnQzVS2CK+XkHNoiaEkIKZzwLq49VxFNotMDxI6mO9
	SL24d0ZKfmjbBegMxGcB4WnwkwadL4T++0oI2VzMDe48GOHE+r97CVJU37FSq8NKAaNEjWx/+5A
	5FWDRlSXmarOwlZFyI8WOHagiJ2UCdnDpt70PnN7neI4LHMMjKThu2ngpGuwaZ/5cu0niFiTkvl
	Jhut2V+gpzsqikCtRjZk24WnAFpU/sqw8DPv6g0Rx40QhZp0NHDzf6d6Ak9IutvNhwXs+cCvPOk
	Rt9FnIYm6nVFNhB5uHl+5kgwgD0en8tBY5DelV3jaSEnL6+y1N8W0KE+iC65PD68udZeM+m7z0k
	mUqOhkw0j/0L4GqirmH34f2eH2eAu0DYrAkeY054jdXTuISTONKb1dFYITJdCkQ/7yABcmnnDdF
	sZkJrjpdrhOJxd+zDJ17kr
X-Google-Smtp-Source: AGHT+IEe5rpmUFCM6VMbpHOv5exKxUbEKBJun/3GxxwQmQuALAGVS9fODrN5bITWNykb9Omk/kae/w==
X-Received: by 2002:ac8:6f0e:0:b0:4f1:ad0c:affe with SMTP id d75a77b69052e-4f1d05fa03dmr201981991cf.62.1765906506806;
        Tue, 16 Dec 2025 09:35:06 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860f8basm79310456d6.56.2025.12.16.09.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:35:06 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v4 4/5] libbpf: move arena globals to the end of the arena
Date: Tue, 16 Dec 2025 12:33:24 -0500
Message-ID: <20251216173325.98465-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251216173325.98465-1-emil@etsalapatis.com>
References: <20251216173325.98465-1-emil@etsalapatis.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c                          | 17 +++++++++++++----
 .../selftests/bpf/progs/verifier_arena_large.c  | 12 +++++++++---
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4d4badb64824..6fba879492a8 100644
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


