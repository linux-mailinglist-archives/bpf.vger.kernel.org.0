Return-Path: <bpf+bounces-21376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733A84BFC6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F401F22865
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A91BC3C;
	Tue,  6 Feb 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FybHSSRc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203F1BF26
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257131; cv=none; b=H4sjxTkbQRxLuDF9HYYrqEvWcwhIyJwvw7BioVaNmH1QSGFd8bapOyUdEHi/a9PWwKKMOLHGnB0wkFfVe1iVTGIlTe/tLENrE9+vLgdURRcwP+1cozxzWEW4U8snq45rrSJ/yf4zzhud1L6NqwS78ZdQIk4QqRVdjwg5rrH7ktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257131; c=relaxed/simple;
	bh=C8ZKxZ/dzfbNIItzxRQpV0ixzlivUtlS/NIhI15j7WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4Pz88AQ/6uo8ydMmcnDUq/SXXyx62DD4HkGnleJDZ76wxgrznoLhimfrMf+PFXlVETYzC0eGJZXwVHr2uKQ2Me8GAhI69SwdyAGqkWVA0nfW9A/2hdFlFnSCwAFFr+FIg3VkcjRzgGvqdvgiqmvLXvfNDbYUvDZudu5/Kuuui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FybHSSRc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e054f674b3so12061b3a.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257129; x=1707861929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiXImkPg8/G5+2DOGxZ3xDCLE7/uYVswnoMrJHCmlE0=;
        b=FybHSSRcvC0dc9TJpVotdcSSne0AK+AnA5a6Ga8LnEoySX1gY9xazAg13+xj2GAITN
         yAFqDoKcO5rs6D5b31uBD2jg8i0xjaO1ds6cK2G1ZuzeOpUdLlpuwCrDaBOL3mv/qJ52
         XIyj4/AU7W2oVukmSctpZkvfKnQbGh9qKFkSIz5PgYMLk8cJbE5BErQyakg22i7G1t21
         Olefqg1AblTHuc9anQsvzvrPjAqJsuIrHHBEaVCoSRkENyYHuNEnPQa8IQ8GKUbKbdd7
         osNLHEtb9zTVQvBySP+R+Y9WO7GlPDdGRMkmC0K35vTWCxApE0cEJVJ2KErSiYIhIyrV
         0pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257129; x=1707861929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiXImkPg8/G5+2DOGxZ3xDCLE7/uYVswnoMrJHCmlE0=;
        b=Sj8QgZvx/YvVfWi2v/YnYrJY7DPdi6I1rv3gGdY1VLrt45VVI221AyQJgylqKJZNp2
         iANK+KYdcuUyX5l6vXpeDYoZv8V2niRXiNfFCQrcOAtnQabyGHTSEsKZqo3sGFUIMv2T
         4ldn56MVK7GBgkVVnxNjG1KpG3rVpGEbyxHdTE/5yZ+SKk0kUm+j1LeRZCS6KtryCiea
         SX3FEVt1e7Ok3yPS8Crlfifw6SeZ1C5LzSGDKmVfwhM4IUXOKIxSbIqEOLHE0JWEtShe
         Q2Sqwx0pTUGI1MueyxGE1BrckRrgpdH7f5JtrRpbVJTodeQtnpUwFxBKndHVTegZK1RZ
         ylug==
X-Gm-Message-State: AOJu0Yx9Q5UcHOjhVlOl9rkzeFMylcC1NAYbfA8Z2fHa3sfp5ixTXmDd
	vWDo2EeQomVlf7q6sdjVn9IJBmcxyARnq8aDjmbkRu71J4cCtuoMR2PB52/f
X-Google-Smtp-Source: AGHT+IEIl4BNu5aTiVeud6z0/oB6Ycj6jmTdFR/O0kus8+9trSKYb2Mt0v8czJwLnLT6tYLaUsGdUQ==
X-Received: by 2002:a62:c144:0:b0:6e0:4d28:b3a with SMTP id i65-20020a62c144000000b006e04d280b3amr813386pfg.21.1707257129006;
        Tue, 06 Feb 2024 14:05:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVDvb+r0mk8Q2LDEv9B9JMgXfjhY0opj4ilgwOds4APWie51YIRNJnQsC39i+blOZty5ZIcj+KLRBiH6UTqBDlQcNNR2QBOypbk1SEMOeJJvz51o7vEk16399WLfVIf0km+ypgZ7200F6hdBlSZEkCOCdwTvjt+Egj6l8giEFYADjPdyFEjDSXDrkCv67crZA5GJY52dcWfEwzqtvxfTXFf7LbRxgpF28eLdOexz/BcKOiXaX4VDefpgoWZqFjoHApuj3rGrSfywcJymCoRt8xCDNcKkAZJihbB
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id k138-20020a628490000000b006d0d90edd2csm2588957pfd.42.2024.02.06.14.05.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 11/16] libbpf: Add support for bpf_arena.
Date: Tue,  6 Feb 2024 14:04:36 -0800
Message-Id: <20240206220441.38311-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
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

Use traditional map->value_size * map->max_entries to calculate mmap sz,
though it's not the best fit.

Also don't set BTF at bpf_arena creation time, since it doesn't support it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c        | 18 ++++++++++++++++++
 tools/lib/bpf/libbpf_probes.c |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..c5ce5946dc6d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -185,6 +185,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
+	[BPF_MAP_TYPE_ARENA]			= "arena",
 };
 
 static const char * const prog_type_name[] = {
@@ -4852,6 +4853,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_QUEUE:
 	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_ARENA:
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
@@ -4908,6 +4910,22 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	if (map->fd == map_fd)
 		return 0;
 
+	if (def->type == BPF_MAP_TYPE_ARENA) {
+		size_t mmap_sz;
+
+		mmap_sz = bpf_map_mmap_sz(def->value_size, def->max_entries);
+		map->mmaped = mmap((void *)map->map_extra, mmap_sz, PROT_READ | PROT_WRITE,
+				   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
+				   map_fd, 0);
+		if (map->mmaped == MAP_FAILED) {
+			err = -errno;
+			map->mmaped = NULL;
+			pr_warn("map '%s': failed to mmap bpf_arena: %d\n",
+				bpf_map__name(map), err);
+			return err;
+		}
+	}
+
 	/* Keep placeholder FD value but now point it to the BPF map object.
 	 * This way everything that relied on this map's FD (e.g., relocated
 	 * ldimm64 instructions) will stay valid and won't need adjustments.
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index ee9b1dbea9eb..cbc7f4c09060 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -338,6 +338,12 @@ static int probe_map_create(enum bpf_map_type map_type)
 		key_size = 0;
 		max_entries = 1;
 		break;
+	case BPF_MAP_TYPE_ARENA:
+		key_size	= sizeof(__u64);
+		value_size	= sizeof(__u64);
+		opts.map_extra	= 0; /* can mmap() at any address */
+		opts.map_flags	= BPF_F_MMAPABLE;
+		break;
 	case BPF_MAP_TYPE_HASH:
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PROG_ARRAY:
-- 
2.34.1


