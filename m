Return-Path: <bpf+bounces-63678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D794B098C4
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557D53A46B0
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F83C38;
	Fri, 18 Jul 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l76sQP+D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4120E6
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797411; cv=none; b=c04UwnhbYj8SVvMSdMd5KdzDKkmDh1aaw3Z1fi9uxUj2Yyzpoav1a99F43uPWFGtL92GEzOGB4br7wwf4zitDl57Gu5RLqLy8oTEBvwg6SEqVj4OGCBptqnoBVO7EQf1wxzejgCyVX1SwvEO42xxB2ylkbxVbu1z3ZYL5NqFLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797411; c=relaxed/simple;
	bh=o0FmoIezzDRWUfyaNVXcoO9D0eCWLTcnjznz0CceNWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brNLvlhK8GcWo+unMAQ2f0WgLJ3vngvlzEThQOfrx/MYnVDLD8UiY9s5vNl9FcnRWsBhtd+kUcrghXCLhUidQqyt92/yt1Ee935pduVkCDgWsN7gEKgCnvCIRAc5kteEhmY3fFwL8ptVSLldkBl3vMQGuv4CAi5mliLQR0ncCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l76sQP+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E24C4CEE3;
	Fri, 18 Jul 2025 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752797411;
	bh=o0FmoIezzDRWUfyaNVXcoO9D0eCWLTcnjznz0CceNWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=l76sQP+DjqIz6XYNRP18B0KDbvzsLV+0dOY1X7+jHCtmeOABqZXgsKSYmuVqsHQ/w
	 9/hn30ilJJdvshpF85Mqs1kcbfzujTCsVsEvqIBqx8bPaDQkxnLYkkBqcW7s0V1N9e
	 6A8/vd2orWQIAL33V0oLkawa0DjKeBiWHtubswJkqneFsuLEV574vBI1it/mZd/MD1
	 6uFZW2J/fTnv2pxLv5zw1CP0zw0dEj8lqVwS1HTZmLB+Jw7N7RBt1Ll8uAyggtB3eo
	 Q80eE6JjI0KnfwmnoRHbxY3d8/DXNlUhDqOl6+D1yZ1bhypGdXcfOHnWu6e4SveeYI
	 VOpp9XO7NwUKw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf] libbpf: fix handling of BPF arena relocations
Date: Thu, 17 Jul 2025 17:10:09 -0700
Message-ID: <20250718001009.610955-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial __arean global variable support implementation in libbpf
contains a bug: it remembers struct bpf_map pointer for arena, which is
used later on to process relocations. Recording this pointer is
problematic because map pointers are not stable during ELF relocation
collection phase, as an array of struct bpf_map's can be reallocated,
invalidating all the pointers. Libbpf is dealing with similar issues by
using a stable internal map index, though for BPF arena map specifically
this approach wasn't used due to an oversight.

The resulting behavior is non-deterministic issue which depends on exact
layout of ELF object file, number of actual maps, etc. We didn't hit
this until very recently, when this bug started triggering crash in BPF
CI when validating one of sched-ext BPF programs.

The fix is rather straightforward: we just follow an established pattern
of remembering map index (just like obj->kconfig_map_idx, for example)
instead of `struct bpf_map *`, and resolving index to a pointer at the
point where map information is necessary.

While at it also add debug-level message for arena-related relocation
resolution information, which we already have for all other kinds of
maps.

Fixes: 2e7ba4f8fd1f ("libbpf: Recognize __arena global variables.")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aee36402f0a3..699ac147acb4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -735,7 +735,7 @@ struct bpf_object {
 
 	struct usdt_manager *usdt_man;
 
-	struct bpf_map *arena_map;
+	int arena_map_idx;
 	void *arena_data;
 	size_t arena_data_sz;
 
@@ -1517,6 +1517,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
 	obj->kconfig_map_idx = -1;
+	obj->arena_map_idx = -1;
 
 	obj->kern_version = get_kernel_version();
 	obj->state  = OBJ_OPEN;
@@ -2964,7 +2965,7 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	const long page_sz = sysconf(_SC_PAGE_SIZE);
 	size_t mmap_sz;
 
-	mmap_sz = bpf_map_mmap_sz(obj->arena_map);
+	mmap_sz = bpf_map_mmap_sz(map);
 	if (roundup(data_sz, page_sz) > mmap_sz) {
 		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
 			sec_name, mmap_sz, data_sz);
@@ -3038,12 +3039,12 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		if (map->def.type != BPF_MAP_TYPE_ARENA)
 			continue;
 
-		if (obj->arena_map) {
+		if (obj->arena_map_idx >= 0) {
 			pr_warn("map '%s': only single ARENA map is supported (map '%s' is also ARENA)\n",
-				map->name, obj->arena_map->name);
+				map->name, obj->maps[obj->arena_map_idx].name);
 			return -EINVAL;
 		}
-		obj->arena_map = map;
+		obj->arena_map_idx = i;
 
 		if (obj->efile.arena_data) {
 			err = init_arena_map_data(obj, map, ARENA_SEC, obj->efile.arena_data_shndx,
@@ -3053,7 +3054,7 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 				return err;
 		}
 	}
-	if (obj->efile.arena_data && !obj->arena_map) {
+	if (obj->efile.arena_data && obj->arena_map_idx < 0) {
 		pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
 			ARENA_SEC);
 		return -ENOENT;
@@ -4583,8 +4584,13 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	if (shdr_idx == obj->efile.arena_data_shndx) {
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
-		reloc_desc->map_idx = obj->arena_map - obj->maps;
+		reloc_desc->map_idx = obj->arena_map_idx;
 		reloc_desc->sym_off = sym->st_value;
+
+		map = &obj->maps[obj->arena_map_idx];
+		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
+			 prog->name, obj->arena_map_idx, map->name, map->sec_idx,
+			 map->sec_offset, insn_idx);
 		return 0;
 	}
 
-- 
2.47.1


