Return-Path: <bpf+bounces-33662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3CD9248BA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0730B227F7
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634851CB320;
	Tue,  2 Jul 2024 20:04:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773941A28C
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950660; cv=none; b=T+Rf9UJdJQ62u/tBG1nr3RWCfKy2m/GdmIa0CeJQwdyr3kVRRWMQzqgb3rb8W6edCo5N2cmDNKrs4LXh49cz500+RSgsX1GNwScHbQNMgTu7s1UdF0tlKYzQlRegFGAI6drziz+Zojds3EtktMJUgE71zF87iokR70A28OpdFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950660; c=relaxed/simple;
	bh=6ykr1pGZt1aFGqbLFoYwBtmjRUeGZXpUOwvvyh296tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ac3QVa8N9PT2jj2MLf/YYiu7Zc/nyuKNzue7CXuujj3V3Bi3WTBZ2jXpy1ZY8OsmSTr8iEN6xzhWyW7cJg67JC6YVX0FG9xswt2FA2jw1dyK7WG5W3pr10+kQTI8H1SvScDaBQF0ZoyL7Rx0DKY/onFpm+LW499O7VgjLHnMSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso2750930a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 13:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719950657; x=1720555457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npnF/NS1FUyIN+RQxi2ZESSmnk0JdQ7JK4XnBZmC3CA=;
        b=syrkd2y/8cakQqIZbOkt4EMDVDc6qgst8Vmb+f/8ZMQHxt0H7TJmy+/Mf2cPWIFu7T
         nf5fwHbJ5g2dbTVVn2LmzPwkrwmPueUZOrfDQIzrwxMdxkvF+DwCtcprnc+YQwqjE2zh
         MpsDX1PCSzSSTPHjtOA+/+Nnv4IjT+lTJF7NJzcg76Ww2boxV2HNm1Ww+4tFLNwEVWqR
         OQKqhhiKsbfgwMPY5RBA9mp0JsQdXkzwliiEQ4SCbOVCO2m31ZQK04y1BJDLI34xFskx
         J+w53TpVijlOgJ3LXunWaFApPaBgpNfHTBuXFGF6ommaVjRzlfJKQAjI/gYEouXNSpMO
         YD2w==
X-Gm-Message-State: AOJu0Yx975UllALBprqsDsNyxm8nYXmRXOJLD9kcIVjfnHO/UeT3ncN3
	XjBYoZjwQ1L8vf7AKN8WKD6xlklP+d/eg0QBT04Ok7QOnJtQGi13aTxXAg==
X-Google-Smtp-Source: AGHT+IHRLOweNwG/yVZTWe9Bg++mRpuUltwDj8/llQhZVPyzow8FoZNr0mYr27Al71nnS1TWQLP+gg==
X-Received: by 2002:a05:6402:1941:b0:58b:b864:ec77 with SMTP id 4fb4d7f45d1cf-58bb864ed65mr1404542a12.39.1719950656687;
        Tue, 02 Jul 2024 13:04:16 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::7:1902])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58613815dd7sm6105318a12.43.2024.07.02.13.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 13:04:16 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] libbpf: use original struct sizes for skeleton iterations
Date: Tue,  2 Jul 2024 20:59:41 +0100
Message-ID: <20240702195941.448432-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

BPF skeletons can be created by previous or newer versions of libbpf,
for which sizeof(bpf_map_skeleton) or bpf_prog_skeleton may differ.
Libbpf should not rely on array indexing, but instead use original
sizes via map_skel_sz/prog_skel_sz for iterating over the
arrays of maps/progs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4a28fac4908a..b46cf29d74b6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13712,14 +13712,16 @@ int libbpf_num_possible_cpus(void)
 
 static int populate_skeleton_maps(const struct bpf_object *obj,
 				  struct bpf_map_skeleton *maps,
-				  size_t map_cnt)
+				  size_t map_cnt, size_t map_sz)
 {
 	int i;
 
 	for (i = 0; i < map_cnt; i++) {
-		struct bpf_map **map = maps[i].map;
-		const char *name = maps[i].name;
-		void **mmaped = maps[i].mmaped;
+		struct bpf_map_skeleton *map_skel = (struct bpf_map_skeleton *)
+			((char *)maps + map_sz * i);
+		struct bpf_map **map = map_skel->map;
+		const char *name = map_skel->name;
+		void **mmaped = map_skel->mmaped;
 
 		*map = bpf_object__find_map_by_name(obj, name);
 		if (!*map) {
@@ -13736,13 +13738,15 @@ static int populate_skeleton_maps(const struct bpf_object *obj,
 
 static int populate_skeleton_progs(const struct bpf_object *obj,
 				   struct bpf_prog_skeleton *progs,
-				   size_t prog_cnt)
+				   size_t prog_cnt, size_t prog_sz)
 {
 	int i;
 
 	for (i = 0; i < prog_cnt; i++) {
-		struct bpf_program **prog = progs[i].prog;
-		const char *name = progs[i].name;
+		struct bpf_prog_skeleton *cur_prog = (struct bpf_prog_skeleton *)
+			((char *)progs + prog_sz * i);
+		struct bpf_program **prog = cur_prog->prog;
+		const char *name = cur_prog->name;
 
 		*prog = bpf_object__find_program_by_name(obj, name);
 		if (!*prog) {
@@ -13783,13 +13787,13 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
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
@@ -13819,13 +13823,13 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
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
@@ -13879,10 +13883,12 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 	}
 
 	for (i = 0; i < s->map_cnt; i++) {
-		struct bpf_map *map = *s->maps[i].map;
+		struct bpf_map_skeleton *map_skel = (struct bpf_map_skeleton *)
+			((char *)s->maps + s->map_skel_sz * i);
+		struct bpf_map *map = *map_skel->map;
 		size_t mmap_sz = bpf_map_mmap_sz(map);
 		int prot, map_fd = map->fd;
-		void **mmaped = s->maps[i].mmaped;
+		void **mmaped = map_skel->mmaped;
 
 		if (!mmaped)
 			continue;
@@ -13930,8 +13936,10 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 	int i, err;
 
 	for (i = 0; i < s->prog_cnt; i++) {
-		struct bpf_program *prog = *s->progs[i].prog;
-		struct bpf_link **link = s->progs[i].link;
+		struct bpf_prog_skeleton *prog_skel = (struct bpf_prog_skeleton *)
+			((char *)s->progs + s->prog_skel_sz * i);
+		struct bpf_program *prog = *prog_skel->prog;
+		struct bpf_link **link = prog_skel->link;
 
 		if (!prog->autoload || !prog->autoattach)
 			continue;
@@ -13970,8 +13978,10 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		return 0;
 
 	for (i = 0; i < s->map_cnt; i++) {
-		struct bpf_map *map = *s->maps[i].map;
-		struct bpf_link **link = s->maps[i].link;
+		struct bpf_map_skeleton *map_skel = (struct bpf_map_skeleton *)
+			((char *)s->maps + s->map_skel_sz * i);
+		struct bpf_map *map = *map_skel->map;
+		struct bpf_link **link = map_skel->link;
 
 		if (!map->autocreate || !map->autoattach)
 			continue;
@@ -14000,7 +14010,9 @@ void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)
 	int i;
 
 	for (i = 0; i < s->prog_cnt; i++) {
-		struct bpf_link **link = s->progs[i].link;
+		struct bpf_prog_skeleton *prog_skel = (struct bpf_prog_skeleton *)
+			((char *)s->progs + s->prog_skel_sz * i);
+		struct bpf_link **link = prog_skel->link;
 
 		bpf_link__destroy(*link);
 		*link = NULL;
@@ -14010,7 +14022,9 @@ void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)
 		return;
 
 	for (i = 0; i < s->map_cnt; i++) {
-		struct bpf_link **link = s->maps[i].link;
+		struct bpf_map_skeleton *map_skel = (struct bpf_map_skeleton *)
+			((char *)s->maps + s->map_skel_sz * i);
+		struct bpf_link **link = map_skel->link;
 
 		if (link) {
 			bpf_link__destroy(*link);
-- 
2.45.2


