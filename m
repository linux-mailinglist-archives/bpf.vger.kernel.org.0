Return-Path: <bpf+bounces-42868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A1D9ABCF4
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 06:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC96284F0E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0413AD05;
	Wed, 23 Oct 2024 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxWfKpWR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE091E515
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658356; cv=none; b=SUdZ3HBYRBMGUE9E5QzdFpHAAnSjCnHRopytSb2y5tZTsXGlBWqnpBg9kPXRM7FgYcXXCXSpLRs0RQMQZcUa2W285TMGT5c933ej3ptDm1lo/B+FIa2sKAnY8Ml00/E15ZWz0v0k8u1oh4SnjkYGwg/7R6NCumQ3ZHe6qFRRd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658356; c=relaxed/simple;
	bh=VJYtQt85B/rEAN0xMs2iD9uLz/2mbjJcjs5nRSDuMYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J29q/ux8OptUoH11M2Xll/5CindeLJwl6d9VpefUYlXNxnLLXRA+FOspONc0B35ipLJIThsOAzO8tWWvlu+N/Vkk5HT3T7R9NiPcr0sG9FGd/9AN8UKGsVoc9CLoGh9aR9jxEiLPbxG6j30fRm/CgITKLWR8ghVYKlaZtjsrEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxWfKpWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516DFC4CEC6;
	Wed, 23 Oct 2024 04:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729658356;
	bh=VJYtQt85B/rEAN0xMs2iD9uLz/2mbjJcjs5nRSDuMYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxWfKpWRHXjbfJRll8duYQ09CQ0PiVz4AlDVBSdhxV1aD65e6JZMaVI6UmTjhM+b7
	 uTFjszhvAlDvXLdncB7yG1dYyITAChle1J8k7nVyUFKvvL81GOhFuI/ULZ5gCSHjM2
	 4bZCAbghaH/V3+VZ4DUzY8h8JNrAH6Kv7FSfjjGXmWpr/EwvSLdaBrXBI/ZJFuC/gM
	 ZjyhF3d++TVP6uVnNySw2npbnMDEar30ImKj148ggcwap1HyQ2OTRw6NREuBVyNRUb
	 uSHBrOBScBFJ6ojIi0eD372ms32MyZi1UPOCa2GbyBR2oV/nScO+y8vBFZP2vNL2vx
	 t+4wjcwz6L8mw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Alastair Robertson <ajor@meta.com>,
	Jonathan Wiepert <jwiepert@meta.com>
Subject: [PATCH bpf-next 2/3] libbpf: move global data mmap()'ing into bpf_object__load()
Date: Tue, 22 Oct 2024 21:39:07 -0700
Message-ID: <20241023043908.3834423-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241023043908.3834423-1-andrii@kernel.org>
References: <20241023043908.3834423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since BPF skeleton inception libbpf has been doing mmap()'ing of global
data ARRAY maps in bpf_object__load_skeleton() API, which is used by
code generated .skel.h files (i.e., by BPF skeletons only).

This is wrong because if BPF object is loaded through generic
bpf_object__load() API, global data maps won't be re-mmap()'ed after
load step, and memory pointers returned from bpf_map__initial_value()
would be wrong and won't reflect the actual memory shared between BPF
program and user space.

bpf_map__initial_value() return result is rarely used after load, so
this went unnoticed for a really long time, until bpftrace project
attempted to load BPF object through generic bpf_object__load() API and
then used BPF subskeleton instantiated from such bpf_object. It turned
out that .data/.rodata/.bss data updates through such subskeleton was
"blackholed", all because libbpf wouldn't re-mmap() those maps during
bpf_object__load() phase.

Long story short, this step should be done by libbpf regardless of BPF
skeleton usage, right after BPF map is created in the kernel. This patch
moves this functionality into bpf_object__populate_internal_map() to
achieve this. And bpf_object__load_skeleton() is now simple and almost
trivial, only propagating these mmap()'ed pointers into user-supplied
skeleton structs.

We also do trivial adjustments to error reporting inside
bpf_object__populate_internal_map() for consistency with the rest of
libbpf's map-handling code.

Reported-by: Alastair Robertson <ajor@meta.com>
Reported-by: Jonathan Wiepert <jwiepert@meta.com>
Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 83 ++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7c40286c3948..711173acbcef 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5122,6 +5122,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	enum libbpf_map_type map_type = map->libbpf_type;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, zero = 0;
+	size_t mmap_sz;
 
 	if (obj->gen_loader) {
 		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
@@ -5135,8 +5136,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	if (err) {
 		err = -errno;
 		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("Error setting initial map(%s) contents: %s\n",
-			map->name, cp);
+		pr_warn("map '%s': failed to set initial contents: %s\n",
+			bpf_map__name(map), cp);
 		return err;
 	}
 
@@ -5146,11 +5147,43 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 		if (err) {
 			err = -errno;
 			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-			pr_warn("Error freezing map(%s) as read-only: %s\n",
-				map->name, cp);
+			pr_warn("map '%s': failed to freeze as read-only: %s\n",
+				bpf_map__name(map), cp);
 			return err;
 		}
 	}
+
+	/* Remap anonymous mmap()-ed "map initialization image" as
+	 * a BPF map-backed mmap()-ed memory, but preserving the same
+	 * memory address. This will cause kernel to change process'
+	 * page table to point to a different piece of kernel memory,
+	 * but from userspace point of view memory address (and its
+	 * contents, being identical at this point) will stay the
+	 * same. This mapping will be released by bpf_object__close()
+	 * as per normal clean up procedure.
+	 */
+	mmap_sz = bpf_map_mmap_sz(map);
+	if (map->def.map_flags & BPF_F_MMAPABLE) {
+		void *mmaped;
+		int prot;
+
+		if (map->def.map_flags & BPF_F_RDONLY_PROG)
+			prot = PROT_READ;
+		else
+			prot = PROT_READ | PROT_WRITE;
+		mmaped = mmap(map->mmaped, mmap_sz, prot, MAP_SHARED | MAP_FIXED, map->fd, 0);
+		if (mmaped == MAP_FAILED) {
+			err = -errno;
+			pr_warn("map '%s': failed to re-mmap() contents: %d\n",
+				bpf_map__name(map), err);
+			return err;
+		}
+		map->mmaped = mmaped;
+	} else if (map->mmaped) {
+		munmap(map->mmaped, mmap_sz);
+		map->mmaped = NULL;
+	}
+
 	return 0;
 }
 
@@ -5467,8 +5500,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 				err = bpf_object__populate_internal_map(obj, map);
 				if (err < 0)
 					goto err_out;
-			}
-			if (map->def.type == BPF_MAP_TYPE_ARENA) {
+			} else if (map->def.type == BPF_MAP_TYPE_ARENA) {
 				map->mmaped = mmap((void *)(long)map->map_extra,
 						   bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
 						   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
@@ -13916,46 +13948,11 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 	for (i = 0; i < s->map_cnt; i++) {
 		struct bpf_map_skeleton *map_skel = (void *)s->maps + i * s->map_skel_sz;
 		struct bpf_map *map = *map_skel->map;
-		size_t mmap_sz = bpf_map_mmap_sz(map);
-		int prot, map_fd = map->fd;
-		void **mmaped = map_skel->mmaped;
-
-		if (!mmaped)
-			continue;
-
-		if (!(map->def.map_flags & BPF_F_MMAPABLE)) {
-			*mmaped = NULL;
-			continue;
-		}
 
-		if (map->def.type == BPF_MAP_TYPE_ARENA) {
-			*mmaped = map->mmaped;
+		if (!map_skel->mmaped)
 			continue;
-		}
-
-		if (map->def.map_flags & BPF_F_RDONLY_PROG)
-			prot = PROT_READ;
-		else
-			prot = PROT_READ | PROT_WRITE;
 
-		/* Remap anonymous mmap()-ed "map initialization image" as
-		 * a BPF map-backed mmap()-ed memory, but preserving the same
-		 * memory address. This will cause kernel to change process'
-		 * page table to point to a different piece of kernel memory,
-		 * but from userspace point of view memory address (and its
-		 * contents, being identical at this point) will stay the
-		 * same. This mapping will be released by bpf_object__close()
-		 * as per normal clean up procedure, so we don't need to worry
-		 * about it from skeleton's clean up perspective.
-		 */
-		*mmaped = mmap(map->mmaped, mmap_sz, prot, MAP_SHARED | MAP_FIXED, map_fd, 0);
-		if (*mmaped == MAP_FAILED) {
-			err = -errno;
-			*mmaped = NULL;
-			pr_warn("failed to re-mmap() map '%s': %d\n",
-				 bpf_map__name(map), err);
-			return libbpf_err(err);
-		}
+		*map_skel->mmaped = map->mmaped;
 	}
 
 	return 0;
-- 
2.43.5


