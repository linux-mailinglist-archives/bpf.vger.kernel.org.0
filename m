Return-Path: <bpf+bounces-70032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847C0BACE86
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3004A16718D
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A92FF664;
	Tue, 30 Sep 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df6rBIms"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000E3D6F
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236341; cv=none; b=IpAPmEILo9X5b8zre6oDGPNfvzNl9iFjxWwPoiSA/V5ZlZosWKuStHY9Bx5qncM98zE7HnXGnn4c7QfAOGRXecj8xB+9uO+wLsY7w/U83L5PYxmj9JMLThkKCRgWBZZiXB3nP5nons1TXycNkhOeO1KCMFY7Lf/+jOxVhABrJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236341; c=relaxed/simple;
	bh=Ew7TPHTavqSfNBWCfzCxt+bCIiHBO0gnxim7uZNIoZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMtBH9DJj1hvF9kSOIf1wAuBbvompV3kltQ5FLm9otk6EodBym29auSojnYsKhovjmh+pgrcNqCp942294KCvZxTeoVsGBLihjN0TP5IDitUnlczfogz1kfwmek7lR/DqPlak87d9XjCT5BDn1+hxTapyBKGmLxJaQXmJQE2ySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df6rBIms; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so4107000f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236337; x=1759841137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CygSpWjpGfeiA56WDoAVzxyOAibG6n2IyHfwXrcfnzc=;
        b=df6rBIms+zrhjhu9yz2F+IjVJfBEVzeuko2Qik7e1fTLfp3SK+2ehlyo4pzx509mhn
         3FiN8lC8EnIoEQeF4jMU6CWsPPWHIJ7nLzhIkTgWss7UUampNiF+ea1zFkZiYCwe3B9C
         8Uuvm3kZyNVs3EQqJVjHgJ59vO1ImMMT5XkuJDngyjeJ+Aa7kFM6979P3fTvcdX3bpeo
         jO4fB6WgJeK6jt18ktGQ4ICqe8/sEjdZcqeAQn35Jw/uFN3mZMlnagIkxtgaBgKFWJxD
         GUQj3xEtylgXPQG0BQbLqLW0t0cG00YPrNRXQb4x+lZlaUg8IaXIvaUqrjb2NODS/gI8
         +jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236337; x=1759841137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CygSpWjpGfeiA56WDoAVzxyOAibG6n2IyHfwXrcfnzc=;
        b=UopstKlH5xbzikCjmfYh/h9z/TcyvSGxo35j31HINSi7O13CC12vYzvo+xXhzZk447
         MXeL5pyENGl9vpcx51DFYgGcv6JfpE4UaMSKKdH3Dw3QvliEb0QpNc4lD4AnuHKdpHki
         8ZZd5K2ijcFZsjysdWFbH19Xjhq+CtR9sdk/BKTsaEI74h9aEq2P6aCg46XO31WRYSvC
         BEta7EYASkAxDKYASlx513hRMJ0DeB5Vv0WPvPD1AjjraUPLHPMJSm2fvKqdVviyBEUY
         3KXpFXacs9qcgkzoFlHjxacMnRjA3++Gl9RNVN8XHQ0a2nRN8zw6jUWJanVv94xufmS8
         1nrA==
X-Gm-Message-State: AOJu0YxvqtJalXBN6+vNKLkGjjKaM1zE101jVupLmFSilX1PCM9uUNRK
	cBVqteSq0rN8pSXm1rsP4VyNvJrXGJcl+NYakz9O3fy1C84qIFsP/0DHhlkQYg==
X-Gm-Gg: ASbGnctxeBtEWnbJbrfZNv3OoIEeU4rbCgaiwo+lJc86eQ3wtSjNGAYriQdNiJKIwwg
	Fp2c7co0Uq+OnZYtreWJrJZYEPR7NcpLFOThFl9Cw7xCLR416bNjYzgXBYwfl6rg0yauR7xhRAf
	m7soh9robpNyTs8n3BOeswAO+aGuypnZ7ueuDOP/MZztFudL/NUw0+UuveeLr2vrxK5XVatj0P7
	LMsMHRTMPQtEUZ+H6Ef0YUmLO10iSpxyXhr9vFJ1SzsrkRQJWNxR/Xu+OMMVc7a/BgpMc+UVLb6
	DXaijI2ib66a0Mw5uFLG6fK003DK337EISoH7XHyQJ/e9k5V4q7k1ov8zAHygMwPHg1COOgRUQV
	YPqbueD7D8ewbDTaCfeatHLR8yJ4sp4DmKwqdRSyUmDcXss+y1ttsMPwRmbat4b04+bVxdgNHtn
	+w
X-Google-Smtp-Source: AGHT+IH4OlRBb3kz0n9Y8W2LS3m3eFRCUfyCwqWJp1AoiPd2+e/8ry5veVaMbeDA4RXSdxKsZJecmQ==
X-Received: by 2002:a5d:64c6:0:b0:3f0:8d2f:5ed9 with SMTP id ffacd0b85a97d-424107810d7mr3672724f8f.1.1759236337526;
        Tue, 30 Sep 2025 05:45:37 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:36 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v5 bpf-next 03/15] bpf: generalize and export map_get_next_key for arrays
Date: Tue, 30 Sep 2025 12:50:59 +0000
Message-Id: <20250930125111.1269861-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel/bpf/array.c file defines the array_map_get_next_key()
function which finds the next key for array maps. It actually doesn't
use any map fields besides the generic max_entries field. Generalize
it, and export as bpf_array_get_next_key() such that it can be
re-used by other array-like maps.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   |  6 ++++++
 kernel/bpf/arraymap.c | 19 +++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8ad666a02c29..85fb3fb17c0f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2100,6 +2100,12 @@ struct bpf_array {
 	};
 };
 
+/*
+ * The bpf_array_get_next_key() function may be used for all array-like
+ * maps, i.e., maps with u32 keys with range [0 ,..., max_entries)
+ */
+int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key);
+
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 80b1765a3159..493b9841ebd0 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -335,18 +335,17 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 }
 
 /* Called from syscall */
-static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
-	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = key ? *(u32 *)key : U32_MAX;
 	u32 *next = (u32 *)next_key;
 
-	if (index >= array->map.max_entries) {
+	if (index >= map->max_entries) {
 		*next = 0;
 		return 0;
 	}
 
-	if (index == array->map.max_entries - 1)
+	if (index == map->max_entries - 1)
 		return -ENOENT;
 
 	*next = index + 1;
@@ -796,7 +795,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_alloc_check = array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_release_uref = array_map_free_internal_structs,
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
@@ -822,7 +821,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_alloc_check = array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = percpu_array_map_lookup_elem,
 	.map_gen_lookup = percpu_array_map_gen_lookup,
 	.map_update_elem = array_map_update_elem,
@@ -1211,7 +1210,7 @@ const struct bpf_map_ops prog_array_map_ops = {
 	.map_poke_track = prog_array_map_poke_track,
 	.map_poke_untrack = prog_array_map_poke_untrack,
 	.map_poke_run = prog_array_map_poke_run,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = prog_fd_array_get_ptr,
@@ -1315,7 +1314,7 @@ const struct bpf_map_ops perf_event_array_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = perf_event_fd_array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = perf_event_fd_array_get_ptr,
@@ -1351,7 +1350,7 @@ const struct bpf_map_ops cgroup_array_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = cgroup_fd_array_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = cgroup_fd_array_get_ptr,
@@ -1436,7 +1435,7 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_of_map_alloc,
 	.map_free = array_of_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = array_of_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = bpf_map_fd_get_ptr,
-- 
2.34.1


