Return-Path: <bpf+bounces-21596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3684EF90
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7571F28664
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED2522A;
	Fri,  9 Feb 2024 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLxA2Air"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6A5258
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451626; cv=none; b=JeEQtQnoCI8fjV73wu7ZUnRaJAYtx7X2mk5zDNCGEBtluPIEvZonWiOxTzw6fbX3IwKiv0XnjL/eC82/Ddgj+DvrsXpSM4UN3Q5sSNK7AKFQ9XrKRGJS28BEqzIsBKr6xIMDWvUg81LmPH9sxXweFG6YYLHBNHw8tqBqATXmudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451626; c=relaxed/simple;
	bh=SSUom18fY1/fkI/8Dau98DvaWPho4QqURg692OjHxHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9Pab+uo9IbgM/zZu58H86WZND5E/lVpZ88QWFMZ3K7RTSi4Sb9cBCilPX7OkxFCxD7DHUGFTrKK87IZw2GPkRdIRRgVx+kNNvcmNpJxZhcgym555t2fqg6/iiEFPG3+lHbuQt7PvJTpr8NafZ2ISfdiuAFtemvZyV7wYEkHdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLxA2Air; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1da0cd9c0e5so4469735ad.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451623; x=1708056423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd9ldHvznK5bBX0WOOiLjO64Z4v1t4JC5wlS+JmAlpg=;
        b=PLxA2Airwazq64b9koUcxGI9iSN8jOD8fcxRaGkcqt92qXGttcAp3zQjonCroOd4x4
         l2xnbRJWldcRcjbMa/ZdgbFgjXH5IaPY7j81poP3QMWu9bBg07K0FtGCv7XpgGJoqOHE
         H5AXThL7fLccLMLi9FPWUPFEr5YpWWlq0fErqE93SLQNBouy6eDmgyur3IIbW1Lu+08i
         jHYnUQ9RzCIssocZ7t39GmQzua3sB2lCH7vHq4kOtyFY+ymzx+A9YM13yypOHS6WdvX1
         HDwoD+KUlI3hacciEAC5dY8jYOK9QLwuNRzh1RYP/i54Ke22X7h71DJSwPmWK1NQRy/f
         4fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451623; x=1708056423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nd9ldHvznK5bBX0WOOiLjO64Z4v1t4JC5wlS+JmAlpg=;
        b=BYJ0+bVUR4rWFnTbyG1eldcx5kshgY2tQhgaaBNWGqF0imIFy5X+J0VLC7QpTD6Iq0
         Cpb74HwkJhwr4glNQPfuapf3GoUw6ljmxug/uks0NXUotARHkJf0OMn20NODtXVWIq3R
         WU/6Ojw4sV4m1QSo0Ypxp3WUdUTcwkP9snaAaKvC9JOJeGA0AeU/Ba6RoOmpzWcesb+w
         sCkolQoG//n/7yBZc8CnUn+wd37osXgZfJ91fkPW1JP9roWR+sfRQZJbqtx82kb88oXa
         kQ4ZttDgskbLgq4auvnJ2+JHv7w9mJYUN80jttp9aDWUjndIfLI+bnRhn1Sp995v4JIn
         T9JQ==
X-Gm-Message-State: AOJu0YxWsEA15ZQ6dMOop7E0ZH8hn5g0iA5tb8yNEBJ88eUPk9kIJ1uz
	TfJBDfaR/3sFsxofRPJAN464AZVcLsihVZ834EbEXp71+aHF+9h0EaZxP9jQ
X-Google-Smtp-Source: AGHT+IEoPNaoXNST3bY7EQ3Xy37Qb7fTssbofLabaCcz0TDvqlgviwuOkE+S47i6w80xgnTbu99/eA==
X-Received: by 2002:a17:902:ce91:b0:1d9:34ff:f807 with SMTP id f17-20020a170902ce9100b001d934fff807mr727831plg.31.1707451623582;
        Thu, 08 Feb 2024 20:07:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4y6CYVGbOKIVod4G5Bg5GTdHTlGslPYpsljRN9o3Z+8SFl6eHgSF+Plus5zKv7ifiilN8+3Rjaqfp4tPFWlgiGm9U4WYTgptRd2cVgf0dvvrSyQcj/sI1ZPcywe5wsAK74e+moJ3nEcZD20bSvOl4UhYy9gcv8vpm3VgPJnpPhUu4irxBkQwSGw2QH6I3K6McMgvIFFbwqhzJxep1QZGhuyXkrRiSjJTp3dKWrYgJ878B2ObgfAyj29Ns+1kI/6tpzGl9I94oP1IN+y3mDfcH7Qk1OeqG6dNbq3FmYOFCEvdYqPdiXRYRMtkXLZqiyMVp1rjFBtFgEcyRZH6cMEDc1G3cXwnNMCz4r4xrV67tuUAMd7uW7g==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902f74c00b001d9ba3b2b33sm541375plw.163.2024.02.08.20.07.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
Date: Thu,  8 Feb 2024 20:06:00 -0800
Message-Id: <20240209040608.98927-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

mmap() bpf_arena right after creation, since the kernel needs to
remember the address returned from mmap. This is user_vm_start.
LLVM will generate bpf_arena_cast_user() instructions where
necessary and JIT will add upper 32-bit of user_vm_start
to such pointers.

Fix up bpf_map_mmap_sz() to compute mmap size as
map->value_size * map->max_entries for arrays and
PAGE_SIZE * map->max_entries for arena.

Don't set BTF at arena creation time, since it doesn't support it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c        | 43 ++++++++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf_probes.c |  7 ++++++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..4880d623098d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -185,6 +185,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
+	[BPF_MAP_TYPE_ARENA]			= "arena",
 };
 
 static const char * const prog_type_name[] = {
@@ -1577,7 +1578,7 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 	return map;
 }
 
-static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
+static size_t __bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
 {
 	const long page_sz = sysconf(_SC_PAGE_SIZE);
 	size_t map_sz;
@@ -1587,6 +1588,20 @@ static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
 	return map_sz;
 }
 
+static size_t bpf_map_mmap_sz(const struct bpf_map *map)
+{
+	const long page_sz = sysconf(_SC_PAGE_SIZE);
+
+	switch (map->def.type) {
+	case BPF_MAP_TYPE_ARRAY:
+		return __bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
+	case BPF_MAP_TYPE_ARENA:
+		return page_sz * map->def.max_entries;
+	default:
+		return 0; /* not supported */
+	}
+}
+
 static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t new_sz)
 {
 	void *mmaped;
@@ -1740,7 +1755,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
 		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
 
-	mmap_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
+	mmap_sz = bpf_map_mmap_sz(map);
 	map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
 			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 	if (map->mmaped == MAP_FAILED) {
@@ -4852,6 +4867,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_QUEUE:
 	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_ARENA:
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
@@ -4908,6 +4924,21 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	if (map->fd == map_fd)
 		return 0;
 
+	if (def->type == BPF_MAP_TYPE_ARENA) {
+		map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
+				   PROT_READ | PROT_WRITE,
+				   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
+				   map_fd, 0);
+		if (map->mmaped == MAP_FAILED) {
+			err = -errno;
+			map->mmaped = NULL;
+			close(map_fd);
+			pr_warn("map '%s': failed to mmap bpf_arena: %d\n",
+				bpf_map__name(map), err);
+			return err;
+		}
+	}
+
 	/* Keep placeholder FD value but now point it to the BPF map object.
 	 * This way everything that relied on this map's FD (e.g., relocated
 	 * ldimm64 instructions) will stay valid and won't need adjustments.
@@ -8582,7 +8613,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 	if (map->mmaped) {
 		size_t mmap_sz;
 
-		mmap_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
+		mmap_sz = bpf_map_mmap_sz(map);
 		munmap(map->mmaped, mmap_sz);
 		map->mmaped = NULL;
 	}
@@ -9830,8 +9861,8 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 		int err;
 		size_t mmap_old_sz, mmap_new_sz;
 
-		mmap_old_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
-		mmap_new_sz = bpf_map_mmap_sz(size, map->def.max_entries);
+		mmap_old_sz = bpf_map_mmap_sz(map);
+		mmap_new_sz = __bpf_map_mmap_sz(size, map->def.max_entries);
 		err = bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
 		if (err) {
 			pr_warn("map '%s': failed to resize memory-mapped region: %d\n",
@@ -13356,7 +13387,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 
 	for (i = 0; i < s->map_cnt; i++) {
 		struct bpf_map *map = *s->maps[i].map;
-		size_t mmap_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
+		size_t mmap_sz = bpf_map_mmap_sz(map);
 		int prot, map_fd = map->fd;
 		void **mmaped = s->maps[i].mmaped;
 
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index ee9b1dbea9eb..302188122439 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -338,6 +338,13 @@ static int probe_map_create(enum bpf_map_type map_type)
 		key_size = 0;
 		max_entries = 1;
 		break;
+	case BPF_MAP_TYPE_ARENA:
+		key_size	= 0;
+		value_size	= 0;
+		max_entries	= 1; /* one page */
+		opts.map_extra	= 0; /* can mmap() at any address */
+		opts.map_flags	= BPF_F_MMAPABLE;
+		break;
 	case BPF_MAP_TYPE_HASH:
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PROG_ARRAY:
-- 
2.34.1


