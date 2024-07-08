Return-Path: <bpf+bounces-34139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A092AABA
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7691C21CF4
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72AD3FB1B;
	Mon,  8 Jul 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6a6yY+j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EC1E522
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471551; cv=none; b=MFPCVwpF+TJNg6fYTsgpYFSkPn0fk4d/+n84ZAsjn9EX2pv5HJICJmWE/3OiRJTDxZfxuUN+nWnAjFph/rMhwe21bQohevlt5rqpx31pxIYVv6W4pwE49XOs09vPvQIdjbbOuug03KlpPTokgEM324+DbQExWAEpQZAdIo9hYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471551; c=relaxed/simple;
	bh=xAZaJk8DmKSyHgjCAvTvzoRWneC7MlALSfWDfBmNqIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrbdOIFq+It8bS0bSs7Zvk/wz3vQ4SteoS4UxoFRgM23YqNE38jkLjGHRm/qyel7yn7Edu10gTKBu9xtbACGJR7IybgK9RmpcQuwUNDS0QB68xLmkl0MEsc0ORK/NbYqPvbBX+xs2POWZRTJ8kFq8OELUN+HXm3XHSAHxM9hpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6a6yY+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF34EC116B1;
	Mon,  8 Jul 2024 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720471550;
	bh=xAZaJk8DmKSyHgjCAvTvzoRWneC7MlALSfWDfBmNqIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6a6yY+jlh2sp7NWLZOe0KQw4huDK1A+zgLB3LHAQOAnMPsqNIK7xLZW6wpVdbCVi
	 if+9nsWDhoCrdRqN3FkiQrXQMvlm6o5U4XkqkmODiQUezkd08mpxsl4/+y7TAihFuR
	 qgWwRLeNxcHtzF17iTO417AduqZteR9DOmem6gyqH+vGAwVWPOYLQHJG0htJ0DBIrj
	 emcDmmDLV3FY74kC7eEuHv3OHLaP8phQYXRqIiNTGBWdI5T68I5UF0UqKvb18RxJDn
	 sfGPYpJQeotSDPHI1olSBKygChvpYLBYlxUrKAQHw7hpAZ1oFt+dwLCvu6RCs7LpFO
	 Q2Zuu1yNWjW9Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH v2 bpf-next 2/3] libbpf: fix BPF skeleton forward/backward compat handling
Date: Mon,  8 Jul 2024 13:45:39 -0700
Message-ID: <20240708204540.4188946-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708204540.4188946-1-andrii@kernel.org>
References: <20240708204540.4188946-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF skeleton was designed from day one to be extensible. Generated BPF
skeleton code specifies actual sizes of map/prog/variable skeletons for
that reason and libbpf is supposed to work with newer/older versions
correctly.

Unfortunately, it was missed that we implicitly embed hard-coded most
up-to-date (according to libbpf's version of libbpf.h header used to
compile BPF skeleton header) sizes of those structs, which can differ
from the actual sizes at runtime when libbpf is used as a shared
library.

We have a few places were we just index array of maps/progs/vars, which
implicitly uses these potentially invalid sizes of structs.

This patch aims to fix this problem going forward. Once this lands,
we'll backport these changes in Github repo to create patched releases
for older libbpfs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")
Fixes: 08ac454e258 ("libbpf: Auto-attach struct_ops BPF maps in BPF skeleton")
Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 47 ++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 30f121754d83..8625c948f60a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13712,14 +13712,15 @@ int libbpf_num_possible_cpus(void)
 
 static int populate_skeleton_maps(const struct bpf_object *obj,
 				  struct bpf_map_skeleton *maps,
-				  size_t map_cnt)
+				  size_t map_cnt, size_t map_skel_sz)
 {
 	int i;
 
 	for (i = 0; i < map_cnt; i++) {
-		struct bpf_map **map = maps[i].map;
-		const char *name = maps[i].name;
-		void **mmaped = maps[i].mmaped;
+		struct bpf_map_skeleton *map_skel = (void *)maps + i * map_skel_sz;
+		struct bpf_map **map = map_skel->map;
+		const char *name = map_skel->name;
+		void **mmaped = map_skel->mmaped;
 
 		*map = bpf_object__find_map_by_name(obj, name);
 		if (!*map) {
@@ -13736,13 +13737,14 @@ static int populate_skeleton_maps(const struct bpf_object *obj,
 
 static int populate_skeleton_progs(const struct bpf_object *obj,
 				   struct bpf_prog_skeleton *progs,
-				   size_t prog_cnt)
+				   size_t prog_cnt, size_t prog_skel_sz)
 {
 	int i;
 
 	for (i = 0; i < prog_cnt; i++) {
-		struct bpf_program **prog = progs[i].prog;
-		const char *name = progs[i].name;
+		struct bpf_prog_skeleton *prog_skel = (void *)progs + i * prog_skel_sz;
+		struct bpf_program **prog = prog_skel->prog;
+		const char *name = prog_skel->name;
 
 		*prog = bpf_object__find_program_by_name(obj, name);
 		if (!*prog) {
@@ -13783,13 +13785,13 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 	}
 
 	*s->obj = obj;
-	err = populate_skeleton_maps(obj, s->maps, s->map_cnt);
+	err = populate_skeleton_maps(obj, s->maps, s->map_cnt, s->map_skel_sz);
 	if (err) {
 		pr_warn("failed to populate skeleton maps for '%s': %d\n", s->name, err);
 		return libbpf_err(err);
 	}
 
-	err = populate_skeleton_progs(obj, s->progs, s->prog_cnt);
+	err = populate_skeleton_progs(obj, s->progs, s->prog_cnt, s->prog_skel_sz);
 	if (err) {
 		pr_warn("failed to populate skeleton progs for '%s': %d\n", s->name, err);
 		return libbpf_err(err);
@@ -13819,20 +13821,20 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
 		return libbpf_err(-errno);
 	}
 
-	err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
+	err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt, s->map_skel_sz);
 	if (err) {
 		pr_warn("failed to populate subskeleton maps: %d\n", err);
 		return libbpf_err(err);
 	}
 
-	err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
+	err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt, s->prog_skel_sz);
 	if (err) {
 		pr_warn("failed to populate subskeleton maps: %d\n", err);
 		return libbpf_err(err);
 	}
 
 	for (var_idx = 0; var_idx < s->var_cnt; var_idx++) {
-		var_skel = &s->vars[var_idx];
+		var_skel = (void *)s->vars + var_idx * s->var_skel_sz;
 		map = *var_skel->map;
 		map_type_id = bpf_map__btf_value_type_id(map);
 		map_type = btf__type_by_id(btf, map_type_id);
@@ -13879,10 +13881,11 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 	}
 
 	for (i = 0; i < s->map_cnt; i++) {
-		struct bpf_map *map = *s->maps[i].map;
+		struct bpf_map_skeleton *map_skel = (void *)s->maps + i * s->map_skel_sz;
+		struct bpf_map *map = *map_skel->map;
 		size_t mmap_sz = bpf_map_mmap_sz(map);
 		int prot, map_fd = map->fd;
-		void **mmaped = s->maps[i].mmaped;
+		void **mmaped = map_skel->mmaped;
 
 		if (!mmaped)
 			continue;
@@ -13930,8 +13933,9 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 	int i, err;
 
 	for (i = 0; i < s->prog_cnt; i++) {
-		struct bpf_program *prog = *s->progs[i].prog;
-		struct bpf_link **link = s->progs[i].link;
+		struct bpf_prog_skeleton *prog_skel = (void *)s->progs + i * s->prog_skel_sz;
+		struct bpf_program *prog = *prog_skel->prog;
+		struct bpf_link **link = prog_skel->link;
 
 		if (!prog->autoload || !prog->autoattach)
 			continue;
@@ -13970,8 +13974,9 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		return 0;
 
 	for (i = 0; i < s->map_cnt; i++) {
-		struct bpf_map *map = *s->maps[i].map;
-		struct bpf_link **link = s->maps[i].link;
+		struct bpf_map_skeleton *map_skel = (void *)s->maps + i * s->map_skel_sz;
+		struct bpf_map *map = *map_skel->map;
+		struct bpf_link **link = map_skel->link;
 
 		if (!map->autocreate || !map->autoattach)
 			continue;
@@ -14000,7 +14005,8 @@ void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)
 	int i;
 
 	for (i = 0; i < s->prog_cnt; i++) {
-		struct bpf_link **link = s->progs[i].link;
+		struct bpf_prog_skeleton *prog_skel = (void *)s->progs + i * s->prog_skel_sz;
+		struct bpf_link **link = prog_skel->link;
 
 		bpf_link__destroy(*link);
 		*link = NULL;
@@ -14010,7 +14016,8 @@ void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)
 		return;
 
 	for (i = 0; i < s->map_cnt; i++) {
-		struct bpf_link **link = s->maps[i].link;
+		struct bpf_map_skeleton *map_skel = (void *)s->maps + i * s->map_skel_sz;
+		struct bpf_link **link = map_skel->link;
 
 		if (link) {
 			bpf_link__destroy(*link);
-- 
2.43.0


