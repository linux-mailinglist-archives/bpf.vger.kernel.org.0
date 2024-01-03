Return-Path: <bpf+bounces-18887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F54823512
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625651C2427E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D91CF89;
	Wed,  3 Jan 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT7fRR6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EB1CA90
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbddee32a66so8781431276.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704308046; x=1704912846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUt8YVNSoa+7YDD+I3FZ435kHRVdX3CBnM/UnKKoCug=;
        b=tT7fRR6mXoL4uKMhMIRebk7jHR/8ufeUpvq/dNbu4EEarqzPixDtxJIDIyn6uL0561
         VRrS5VxG3AiG9ntj4mr+wwDLdKiyk/eerGGgF0HpWfmWqX82rToVNxvqNUZvC8U5BwKN
         YDcbQEiAC+q/QXoNRFbg+slA47QAlRgaAJI+rsqwjxkx0dRQsjAtc/9hsa44w0/VAoBx
         2ske0ZOLY2S/Q6yTNL56Ve7TKZh6NZPOKZKTyNdWh+DnNCPb7jmf6Fi/xL9KqE4CWt9L
         FsFe+dd+RJVK/HGwzeAn1vtBM7oEGinaOeoalC33PtY8W0jhpQoDmzbQEs5i8G9WvLXg
         KVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308046; x=1704912846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUt8YVNSoa+7YDD+I3FZ435kHRVdX3CBnM/UnKKoCug=;
        b=Jf4v8IABb6J2hIdM79LnA7TVFN9/obJZxRs/WopFA/2ejASTaX/qPclMK4AUhoTVdL
         17oYYsLlrJ4rE/3/UGm8uDfhPsebOk/V113lsseiACddv2AMI0R7FJ7+ZJMaH7BvM4Iv
         WbEtPb+QjEZp8CElC5kX5nn4+EDr8pdVDrjKuEqdBO0hCD/fHXVxVAU6ukg0FeiW09Tj
         Uj6twaw6Y58JFmUxZ7cx7xnCO8mo7a20BaVe6dP7Q2BN+WpSmUzzbk676NxJypyLeU2t
         JsGPfOTn0xNuFQEASKx9CNQ7Hy/D0Y/rYhTx8Y6dTzx3GUqF1VbKpleiuptONA5eZd5T
         SASQ==
X-Gm-Message-State: AOJu0YxWMMDYAsAOjGItfbYUSGPmQBLLU/7AzjocCg9y7OuGYPtPmPyA
	uNVxVOmoUrcSd3qht+yx4JHvT0REzCb/KE4=
X-Google-Smtp-Source: AGHT+IH7zw5ccoHaAuRraWQZVEPyoR1+1HYH38kijZYviOoia1xzB1IQcNR+fIkZhTYccCv7VvR4V71p
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:7e71:cfbd:2031:cc52])
 (user=brho job=sendgmr) by 2002:a25:b30d:0:b0:dbe:a677:5de5 with SMTP id
 l13-20020a25b30d000000b00dbea6775de5mr28285ybj.4.1704308046693; Wed, 03 Jan
 2024 10:54:06 -0800 (PST)
Date: Wed,  3 Jan 2024 13:53:58 -0500
In-Reply-To: <20240103185403.610641-1-brho@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103185403.610641-1-brho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103185403.610641-2-brho@google.com>
Subject: [PATCH v2 bpf-next 1/2] libbpf: add helpers for mmapping maps
From: Barret Rhoden <brho@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_map__mmap_size() was internal to bpftool.  Use that to make wrappers
for mmap and munmap.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 tools/bpf/bpftool/gen.c  | 16 +++-------------
 tools/lib/bpf/libbpf.c   | 18 ++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  6 ++++++
 tools/lib/bpf/libbpf.map |  4 ++++
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee3ce2b8000d..a328e960c141 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -453,16 +453,6 @@ static void print_hex(const char *data, int data_sz)
 	}
 }
 
-static size_t bpf_map_mmap_sz(const struct bpf_map *map)
-{
-	long page_sz = sysconf(_SC_PAGE_SIZE);
-	size_t map_sz;
-
-	map_sz = (size_t)roundup(bpf_map__value_size(map), 8) * bpf_map__max_entries(map);
-	map_sz = roundup(map_sz, page_sz);
-	return map_sz;
-}
-
 /* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
 static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 {
@@ -641,7 +631,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		if (bpf_map__is_internal(map) &&
 		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
-			       ident, bpf_map_mmap_sz(map));
+			       ident, bpf_map__mmap_size(map));
 		codegen("\
 			\n\
 				skel_closenz(skel->maps.%1$s.map_fd);	    \n\
@@ -723,7 +713,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 					goto cleanup;			    \n\
 				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
 			}						    \n\
-			", ident, bpf_map_mmap_sz(map));
+			", ident, bpf_map__mmap_size(map));
 	}
 	codegen("\
 		\n\
@@ -780,7 +770,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			if (!skel->%1$s)				    \n\
 				return -ENOMEM;				    \n\
 			",
-		       ident, bpf_map_mmap_sz(map), mmap_flags);
+		       ident, bpf_map__mmap_size(map), mmap_flags);
 	}
 	codegen("\
 		\n\
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ebcfb2147fbd..2dae6fabc0d1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9830,6 +9830,24 @@ void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
 	return map->mmaped;
 }
 
+size_t bpf_map__mmap_size(const struct bpf_map *map)
+{
+	return bpf_map_mmap_sz(bpf_map__value_size(map),
+			       bpf_map__max_entries(map));
+}
+
+void *bpf_map__mmap(const struct bpf_map *map)
+{
+	return mmap(NULL, bpf_map__mmap_size(map),
+		    PROT_READ | PROT_WRITE, MAP_SHARED,
+		    bpf_map__fd(map), 0);
+}
+
+int bpf_map__munmap(const struct bpf_map *map, void *addr)
+{
+	return munmap(addr, bpf_map__mmap_size(map));
+}
+
 bool bpf_map__is_internal(const struct bpf_map *map)
 {
 	return map->libbpf_type != LIBBPF_MAP_UNSPEC;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6cd9c501624f..148f4c783ca7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -996,6 +996,12 @@ LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
 LIBBPF_API void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
+/* get the mmappable size of the map */
+LIBBPF_API size_t bpf_map__mmap_size(const struct bpf_map *map);
+/* mmap the map */
+LIBBPF_API void *bpf_map__mmap(const struct bpf_map *map);
+/* munmap the map at addr */
+LIBBPF_API int bpf_map__munmap(const struct bpf_map *map, void *addr);
 
 /**
  * @brief **bpf_map__is_internal()** tells the caller whether or not the
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 91c5aef7dae7..9e44de4fbf39 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -411,4 +411,8 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+	global:
+		bpf_map__mmap_size;
+		bpf_map__mmap;
+		bpf_map__munmap;
 } LIBBPF_1.3.0;
-- 
2.43.0.472.g3155946c3a-goog


