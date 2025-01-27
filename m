Return-Path: <bpf+bounces-49870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC701A1DA6F
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6451886F19
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F7155382;
	Mon, 27 Jan 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HF6SHI1b"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9115573F
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994968; cv=none; b=VOTIMNV+Qwnuq3AR63+7fzCsWvvGPxnDPANR0JpnSFMVZ/LyRIvwP+mFkT/O3YzNg2E91C8R2lwf+N/Wv6OufJ9dKXrpQyC5Jjw7oR1auVJqA+UO3cqg6AdQ8k0oCyxBG9jl4Zy3E2i0dTygso1nD4LvCntpdtqJ35P1G92NIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994968; c=relaxed/simple;
	bh=f/cLWhg2L3G/CxGQlXAn2p5Hyiqy8nRAzbJSPsejB3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR4cwRdx+j0ZeOoCOpOK2CHAQAsl5ztkuq1jMjamFl1Oob1o/+IlmfOtBKqTZHUYNYHhJYiLb6fBBR9jWO1JMelaD14QwA7cRW2TpbxCcoF/HyeWDMci0W0e6KjQb/7TfYpRU5ZKjo21uK79aPWOeYCrgfK7ilRyULhWFyRQvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HF6SHI1b; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737994964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdimOJaKKRKEu4ZlEyRbQ+3cZhT739BXfiHVCtmbZsM=;
	b=HF6SHI1bQdbzTmuOygkKBITwF/N1HD62bokJLc9pxZClXfcolue1DcD+1Lt28+BB6ZHMgg
	4hRQF3fJhqEszMeHJUBNNTaSE737OXVYxAIxvVWFWdc4yGHEISaxRBC8MSdgZehWQeQzmI
	uhK/8r6aElbT3QcGL2YEWutVexNAn/g=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 3/4] bpf, bpftool: Generate skeleton for global percpu data
Date: Tue, 28 Jan 2025 00:21:57 +0800
Message-ID: <20250127162158.84906-4-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-1-leon.hwang@linux.dev>
References: <20250127162158.84906-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch enhances bpftool to generate skeletons for global percpu
variables. The generated skeleton includes a dedicated structure for
percpu data, allowing users to initialize and access percpu variables
efficiently.

Changes:

1. skeleton structure:

For global percpu variables, the skeleton now includes a nested
structure, e.g.:

struct test_global_percpu_data {
	struct bpf_object_skeleton *skeleton;
	struct bpf_object *obj;
	struct {
		struct bpf_map *bss;
		struct bpf_map *percpu;
	} maps;
	// ...
	struct test_global_percpu_data__percpu {
		int percpu_data;
	} *percpu;

	// ...
};

  * The "struct test_global_percpu_data__percpu" points to initialized
    data, which is actually "maps.percpu->data".
  * Before loading the skeleton, updating the
    "struct test_global_percpu_data__percpu" modifies the initial value
    of the corresponding global percpu variables.
  * After loading the skeleton, accessing or updating this struct is no
    longer meaningful. Instead, users must interact with the global
    percpu variables via the "maps.percpu" map.

2. code changes:

  * Added support for ".percpu" sections in bpftool's map identification
    logic.
  * Modified skeleton generation to handle percpu data maps
    appropriately.
  * Updated libbpf to make "percpu" pointing to "maps.percpu->data".

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c | 13 +++++++++----
 tools/lib/bpf/libbpf.c  |  3 +++
 tools/lib/bpf/libbpf.h  |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5a4d3240689ed..975775683ca12 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
 
 static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 {
-	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *sfxs[] = { ".data", ".rodata", ".percpu", ".bss", ".kconfig" };
 	const char *name = bpf_map__name(map);
 	int i, n;
 
@@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 
 static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 {
-	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *pfxs[] = { ".data", ".rodata", ".percpu", ".bss", ".kconfig" };
 	int i, n;
 
 	/* recognize hard coded LLVM section name */
@@ -263,7 +263,9 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 		return true;
 	}
 
-	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+	if (!bpf_map__is_internal(map) ||
+	    (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE) &&
+	     bpf_map__type(map) != BPF_MAP_TYPE_PERCPU_ARRAY))
 		return false;
 
 	if (!get_map_ident(map, buf, sz))
@@ -903,7 +905,10 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped, bool
 			i, bpf_map__name(map), ident);
 		/* memory-mapped internal maps */
 		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
-			printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
+			if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
+				printf("\tmap->data = (void **)&obj->%s;\n", ident);
+			else
+				printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
 		}
 
 		if (populate_links && bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS) {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6da6004c5c84d..dafb419bc5b86 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13915,6 +13915,7 @@ static int populate_skeleton_maps(const struct bpf_object *obj,
 		struct bpf_map **map = map_skel->map;
 		const char *name = map_skel->name;
 		void **mmaped = map_skel->mmaped;
+		void **data = map_skel->data;
 
 		*map = bpf_object__find_map_by_name(obj, name);
 		if (!*map) {
@@ -13925,6 +13926,8 @@ static int populate_skeleton_maps(const struct bpf_object *obj,
 		/* externs shouldn't be pre-setup from user code */
 		if (mmaped && (*map)->libbpf_type != LIBBPF_MAP_KCONFIG)
 			*mmaped = (*map)->mmaped;
+		if (data && (*map)->libbpf_type == LIBBPF_MAP_PERCPU_DATA)
+			*data = (*map)->data;
 	}
 	return 0;
 }
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a0..c49d6e44b5630 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1701,6 +1701,7 @@ struct bpf_map_skeleton {
 	const char *name;
 	struct bpf_map **map;
 	void **mmaped;
+	void **data;
 	struct bpf_link **link;
 };
 
-- 
2.47.1


