Return-Path: <bpf+bounces-71379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61887BF047E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8953B8904
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC42F83C3;
	Mon, 20 Oct 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4V9tj2K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E62F83AC
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953199; cv=none; b=jADRhRh0YQu8R0tqbgFbkYTm/xjV+zp3rGnmuxkBDSp5ZxLm8pXY/zxNY/hlOeQMYIvFd2CSOhuRLjXMfU4DiY2td0XiDz4pOlRak5gUYfVO8GKNOsK9QWzUZcC89wlId5oazfExGbSdb5Sc+WcCZEvGEwfKxuiIoPDaW1xXx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953199; c=relaxed/simple;
	bh=48MK3IVfFVIaq7wrnsVF/K0MzzVMTV/KG7hzT0Z3/M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXj9AY2A339CBLXlifMyYV57t1K/SlKG6sJsn6vPKQwXBRoUEu9RjvpWpQ8bUgdR3HFJ8DgCgozw2aj26HgIjSRNEdiqDD0OvzF10W6bjg0po+M0s62+y98wDp8AlYdIXiymj83oQ+PJBguIlgBgnLlR05o+NUSuo04xWbpYs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4V9tj2K; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so3867251a91.2
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953196; x=1761557996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnQBz8V7xJnhNMAVJ8Qx/WiCqXppL5cjjvDtlWap4Rc=;
        b=k4V9tj2Kgt391tuMso8RQF7TVzNCmuZcFgDNDzuW3jiNVLGsCjkHzE2Nkw9UQIx/+g
         GK3OfWFQJc3oHLvN+dwIpHN0U/z9bXykyWNAA4bPQo/TVatCs7NNUIs9k5ymWNhvTL0Q
         VtEThZQqQqxl5WzFTcU+kr22BesP41jm5o0y3kPuJItMiyFVogXdtRtAJmjCytmEX7fY
         MFHHgmtnXWZf6tf7nmxVxnPrYRueLjwwpvHFq+se8eRUZGIt7ciwMeM2D29UF26PqW8o
         W9uW1nGmEwntJeRblsF4aJ4dyrpuH1kV4lzFZeajLeKC9MwLFGgkeyUV7RXfokE0a+Ei
         tr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953196; x=1761557996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnQBz8V7xJnhNMAVJ8Qx/WiCqXppL5cjjvDtlWap4Rc=;
        b=QWPIWiqs9rsjcqSdWqA2RIDWH6jax2WyrwbQ5pa+22gHEwX7bDVE5WLPq601UhrIfI
         RtU2pb/X+aOeuv89gwVVfsKEF3m7Ky07vbpwQwHbUZVP400CD54hzaQNnC8uF7PoBC2b
         RNI82SSv67RrgKOtrDUVuhYh6YKSwBq4JmU9wZi5V2sjJlOMhi0kJRKfxysRTjyPGuJU
         I0cWqnLK8sN+VYMYCfJgfEmW1P4i5Az8b+6jfHnUndLKrHBHe6C2qVvEMLUDgFfbR3vT
         AuAv/G5ik0HmkVKxhL/FuO3uMrYe1mqPxkYvZdRXwxXfSbj5FYofVYSgAGhAC8M13IYU
         9xAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhIat/3rFlnUTyqU7sRT2jvMWyVrelXo4BhkH/dD223i7TnZSkz+5DCDJQuJuY4qcc5t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tliP3KrHABQCWJIDMs2hRIQAIDQZbT3loO/t2dnX8WDcSzAS
	anuvc5zrxoMTlhKWyo8bBf6R1229wh8m8igHZhW32luD6RAh06b/uOMB
X-Gm-Gg: ASbGncuRK6dLBhpszdiGbpqQVLygQKUPwNryiovcuu5adlML/fJbKL7kWSMXB18TDac
	cd4zsN+QOfi81fBc9E9jL2wM7t9iJR6vneI0jxQv+htjXj9fTdnSyM/u1Hk0CAHombCm1vLiIfh
	fAdD5x5EbNQMOqGI4jJuppOJ0qsCfQ7jV41+N/XkBjJfyUNhKLEQj0IhM8kW26ztj0+kQDiTzsP
	wBcXBcqmBYR3PcUsWFK0GrRrwitXhVfmWnafFfWyFNKVYiaw1KfqNxX8xsZLyFYXvkFpPPwDZ4k
	wPfd62JfdbzPc5Odwztmnd+9eN8qU47Z5qrxHXLIunDuXR3gyOWMP5NzGsYq31tJU6uwelhBJQH
	BYNRxWZO8gvaYI8UpBlnH21MCDKCc9iacp8wC1NY16NeJgZ7nwNYWNfil6gQfc2vAwkNOkzdWF4
	6NRsJtje81BeRpsSRrscY46Le1Tdc=
X-Google-Smtp-Source: AGHT+IFq4jAfdunN994zMtpGY6z7ZtgIpa/ZkkUYRiTLUokYOLHEZQIi0txVjYjHlZ2s2/heMjdjUQ==
X-Received: by 2002:a17:90b:3d8a:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-33bcf87f43dmr18355066a91.12.1760953196306;
        Mon, 20 Oct 2025 02:39:56 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm7617200a91.19.2025.10.20.02.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:39:55 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable binary search
Date: Mon, 20 Oct 2025 17:39:38 +0800
Message-Id: <20251020093941.548058-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020093941.548058-1-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements sorting of BTF types by their kind and name,
enabling the use of binary search for type lookups.

To share logic between kernel and libbpf, a new btf_sort.c file is
introduced containing common sorting functionality.

The sorting is performed during btf__dedup() when the new
sort_by_kind_name option in btf_dedup_opts is enabled.

For vmlinux and kernel module BTF, btf_check_sorted() verifies
whether the types are sorted and binary search can be used.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 include/linux/btf.h             |  20 +++-
 kernel/bpf/Makefile             |   1 +
 kernel/bpf/btf.c                |  39 ++++----
 kernel/bpf/btf_sort.c           |   2 +
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/btf.c             | 163 +++++++++++++++++++++++++++-----
 tools/lib/bpf/btf.h             |   2 +
 tools/lib/bpf/btf_sort.c        | 159 +++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |   6 ++
 9 files changed, 347 insertions(+), 47 deletions(-)
 create mode 100644 kernel/bpf/btf_sort.c
 create mode 100644 tools/lib/bpf/btf_sort.c

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ddc53a7ac7cd..c6fe5e689ab9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -221,7 +221,10 @@ bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
 u32 btf_type_cnt(const struct btf *btf);
-struct btf *btf_base_btf(const struct btf *btf);
+u32 btf_start_id(const struct btf *btf);
+u32 btf_nr_sorted_types(const struct btf *btf);
+void btf_set_nr_sorted_types(struct btf *btf, u32 nr);
+struct btf* btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
 bool btf_type_is_primitive(const struct btf_type *t);
@@ -595,6 +598,10 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
 int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
+int btf_compare_type_kinds_names(const void *a, const void *b, void *priv);
+s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const char *type_name,
+			  u32 kind);
+void btf_check_sorted(struct btf *btf, int start_id);
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
 {
@@ -683,5 +690,16 @@ static inline int btf_check_iter_arg(struct btf *btf, const struct btf_type *fun
 {
 	return -EOPNOTSUPP;
 }
+static inline int btf_compare_type_kinds_names(const void *a, const void *b, void *priv)
+{
+	return -EOPNOTSUPP;
+}
+static inline s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const char *type_name,
+			  u32 kind)
+{
+	return -EOPNOTSUPP;
+}
+static inline void btf_check_sorted(struct btf *btf, int start_id);
+{}
 #endif
 #endif
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7fd0badfacb1..c9d8f986c7e1 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+obj-$(CONFIG_BPF_SYSCALL) += btf_sort.o
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c414cf37e1bd..11b05f4eb07d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -259,6 +259,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 nr_sorted_types;
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -544,33 +545,29 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
-u32 btf_type_cnt(const struct btf *btf)
+u32 btf_start_id(const struct btf *btf)
 {
-	return btf->start_id + btf->nr_types;
+	return btf->start_id;
 }
 
-s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+u32 btf_nr_sorted_types(const struct btf *btf)
 {
-	const struct btf_type *t;
-	const char *tname;
-	u32 i, total;
-
-	do {
-		total = btf_type_cnt(btf);
-		for (i = btf->start_id; i < total; i++) {
-			t = btf_type_by_id(btf, i);
-			if (BTF_INFO_KIND(t->info) != kind)
-				continue;
+	return btf->nr_sorted_types;
+}
 
-			tname = btf_name_by_offset(btf, t->name_off);
-			if (!strcmp(tname, name))
-				return i;
-		}
+void btf_set_nr_sorted_types(struct btf *btf, u32 nr)
+{
+	btf->nr_sorted_types = nr;
+}
 
-		btf = btf->base_btf;
-	} while (btf);
+u32 btf_type_cnt(const struct btf *btf)
+{
+	return btf->start_id + btf->nr_types;
+}
 
-	return -ENOENT;
+s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+{
+	return find_btf_by_name_kind(btf, 1, name, kind);
 }
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
@@ -6239,6 +6236,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf, 1);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6371,6 +6369,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		base_btf = vmlinux_btf;
 	}
 
+	btf_check_sorted(btf, btf_nr_types(base_btf));
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
diff --git a/kernel/bpf/btf_sort.c b/kernel/bpf/btf_sort.c
new file mode 100644
index 000000000000..898f9189952c
--- /dev/null
+++ b/kernel/bpf/btf_sort.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "../../tools/lib/bpf/btf_sort.c"
diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index c80204bb72a2..ed7c2506e22d 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
+	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o btf_sort.o
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..87e47f0b78ba 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2018 Facebook */
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <byteswap.h>
 #include <endian.h>
 #include <stdio.h>
@@ -92,6 +95,9 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* number of named types in this BTF instance for binary search
+	 */
+	__u32 nr_sorted_types;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -619,6 +625,21 @@ __u32 btf__type_cnt(const struct btf *btf)
 	return btf->start_id + btf->nr_types;
 }
 
+__u32 btf__start_id(const struct btf *btf)
+{
+	return btf->start_id;
+}
+
+__u32 btf__nr_sorted_types(const struct btf *btf)
+{
+	return btf->nr_sorted_types;
+}
+
+void btf__set_nr_sorted_types(struct btf *btf, __u32 nr)
+{
+	btf->nr_sorted_types = nr;
+}
+
 const struct btf *btf__base_btf(const struct btf *btf)
 {
 	return btf->base_btf;
@@ -915,38 +936,16 @@ __s32 btf__find_by_name(const struct btf *btf, const char *type_name)
 	return libbpf_err(-ENOENT);
 }
 
-static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
-				   const char *type_name, __u32 kind)
-{
-	__u32 i, nr_types = btf__type_cnt(btf);
-
-	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
-		return 0;
-
-	for (i = start_id; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
-
-		if (btf_kind(t) != kind)
-			continue;
-		name = btf__name_by_offset(btf, t->name_off);
-		if (name && !strcmp(type_name, name))
-			return i;
-	}
-
-	return libbpf_err(-ENOENT);
-}
-
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind)
 {
-	return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
+	return find_btf_by_name_kind(btf, btf->start_id, type_name, kind);
 }
 
 __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 			     __u32 kind)
 {
-	return btf_find_by_name_kind(btf, 1, type_name, kind);
+	return find_btf_by_name_kind(btf, 1, type_name, kind);
 }
 
 static bool btf_is_modifiable(const struct btf *btf)
@@ -3411,6 +3410,7 @@ static int btf_dedup_struct_types(struct btf_dedup *d);
 static int btf_dedup_ref_types(struct btf_dedup *d);
 static int btf_dedup_resolve_fwds(struct btf_dedup *d);
 static int btf_dedup_compact_types(struct btf_dedup *d);
+static int btf_dedup_compact_and_sort_types(struct btf_dedup *d);
 static int btf_dedup_remap_types(struct btf_dedup *d);
 
 /*
@@ -3600,7 +3600,7 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 		pr_debug("btf_dedup_ref_types failed: %s\n", errstr(err));
 		goto done;
 	}
-	err = btf_dedup_compact_types(d);
+	err = btf_dedup_compact_and_sort_types(d);
 	if (err < 0) {
 		pr_debug("btf_dedup_compact_types failed: %s\n", errstr(err));
 		goto done;
@@ -3649,6 +3649,8 @@ struct btf_dedup {
 	 * BTF is considered to be immutable.
 	 */
 	bool hypot_adjust_canon;
+	/* Sort btf_types by kind and time */
+	bool sort_by_kind_name;
 	/* Various option modifying behavior of algorithm */
 	struct btf_dedup_opts opts;
 	/* temporary strings deduplication state */
@@ -3741,6 +3743,7 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_o
 
 	d->btf = btf;
 	d->btf_ext = OPTS_GET(opts, btf_ext, NULL);
+	d->sort_by_kind_name = OPTS_GET(opts, sort_by_kind_name, false);
 
 	d->dedup_table = hashmap__new(hash_fn, btf_dedup_equal_fn, NULL);
 	if (IS_ERR(d->dedup_table)) {
@@ -5288,6 +5291,116 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 	return 0;
 }
 
+static __u32 *get_sorted_canon_types(struct btf_dedup *d, __u32 *cnt)
+{
+	int i, j, id, types_cnt = 0;
+	__u32 *sorted_ids;
+
+	for (i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
+		if (d->map[id] == id)
+			++types_cnt;
+
+	sorted_ids = calloc(types_cnt, sizeof(*sorted_ids));
+	if (!sorted_ids)
+		return NULL;
+
+	for (j = 0, i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
+		if (d->map[id] == id)
+			sorted_ids[j++] = id;
+
+	qsort_r(sorted_ids, types_cnt, sizeof(*sorted_ids),
+		btf_compare_type_kinds_names, d->btf);
+
+	*cnt = types_cnt;
+
+	return sorted_ids;
+}
+
+/*
+ * Compact and sort BTF types.
+ *
+ * Similar to btf_dedup_compact_types, but additionally sorts the btf_types.
+ */
+static int btf__dedup_compact_and_sort_types(struct btf_dedup *d)
+{
+	__u32 canon_types_cnt = 0, canon_types_len = 0;
+	__u32 *new_offs = NULL, *canon_types = NULL;
+	const struct btf_type *t;
+	void *p, *new_types = NULL;
+	int i, id, len, err;
+
+	/* we are going to reuse hypot_map to store compaction remapping */
+	d->hypot_map[0] = 0;
+	/* base BTF types are not renumbered */
+	for (id = 1; id < d->btf->start_id; id++)
+		d->hypot_map[id] = id;
+	for (i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
+		d->hypot_map[id] = BTF_UNPROCESSED_ID;
+
+	canon_types = get_sorted_canon_types(d, &canon_types_cnt);
+	if (!canon_types) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	for (i = 0; i < canon_types_cnt; i++) {
+		id = canon_types[i];
+		t = btf__type_by_id(d->btf, id);
+		len = btf_type_size(t);
+		if (len < 0) {
+			err = len;
+			goto out_err;
+		}
+		canon_types_len += len;
+	}
+
+	new_offs = calloc(canon_types_cnt, sizeof(*new_offs));
+	new_types = calloc(canon_types_len, 1);
+	if (!new_types || !new_offs) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	p = new_types;
+
+	for (i = 0; i < canon_types_cnt; i++) {
+		id = canon_types[i];
+		t = btf__type_by_id(d->btf, id);
+		len = btf_type_size(t);
+		memcpy(p, t, len);
+		d->hypot_map[id] = d->btf->start_id + i;
+		new_offs[i] = p - new_types;
+		p += len;
+	}
+
+	/* shrink struct btf's internal types index and update btf_header */
+	free(d->btf->types_data);
+	free(d->btf->type_offs);
+	d->btf->types_data = new_types;
+	d->btf->type_offs = new_offs;
+	d->btf->types_data_cap = canon_types_len;
+	d->btf->type_offs_cap = canon_types_cnt;
+	d->btf->nr_types = canon_types_cnt;
+	d->btf->hdr->type_len = canon_types_len;
+	d->btf->hdr->str_off = d->btf->hdr->type_len;
+	d->btf->raw_size = d->btf->hdr->hdr_len + d->btf->hdr->type_len + d->btf->hdr->str_len;
+	free(canon_types);
+	return 0;
+
+out_err:
+	free(canon_types);
+	free(new_types);
+	free(new_offs);
+	return err;
+}
+
+static int btf_dedup_compact_and_sort_types(struct btf_dedup *d)
+{
+	if (d->sort_by_kind_name)
+		return btf__dedup_compact_and_sort_types(d);
+	return btf_dedup_compact_types(d);
+}
+
 /*
  * Figure out final (deduplicated and compacted) type ID for provided original
  * `type_id` by first resolving it into corresponding canonical type ID and
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..9a7cfe6b4bb3 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -251,6 +251,8 @@ struct btf_dedup_opts {
 	size_t sz;
 	/* optional .BTF.ext info to dedup along the main BTF info */
 	struct btf_ext *btf_ext;
+	/* Sort btf_types by kind and name */
+	bool sort_by_kind_name;
 	/* force hash collisions (used for testing) */
 	bool force_collisions;
 	size_t :0;
diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
new file mode 100644
index 000000000000..2ad4a56f1c08
--- /dev/null
+++ b/tools/lib/bpf/btf_sort.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#ifdef __KERNEL__
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/string.h>
+
+#define btf_type_by_id				(struct btf_type *)btf_type_by_id
+#define btf__str_by_offset			btf_str_by_offset
+#define btf__name_by_offset			btf_name_by_offset
+#define btf__type_cnt				btf_nr_types
+#define btf__start_id				btf_start_id
+#define btf__nr_sorted_types			btf_nr_sorted_types
+#define btf__set_nr_sorted_types		btf_set_nr_sorted_types
+#define btf__base_btf				btf_base_btf
+#define libbpf_err(x)				x
+
+#else
+
+#include "btf.h"
+#include "bpf.h"
+#include "libbpf.h"
+#include "libbpf_internal.h"
+
+#endif /* __KERNEL__ */
+
+/* Skip the sorted check if number of btf_types is below threshold
+ */
+#define BTF_CHECK_SORT_THRESHOLD  8
+
+struct btf;
+
+static int cmp_btf_kind_name(int ka, const char *na, int kb, const char *nb)
+{
+	return (ka - kb) ?: strcmp(na, nb);
+}
+
+/*
+ * Sort BTF types by kind and name in ascending order, placing named types
+ * before anonymous ones.
+ */
+int btf_compare_type_kinds_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+	int ka, kb;
+
+	/* ta w/o name is greater than tb */
+	if (!ta->name_off && tb->name_off)
+		return 1;
+	/* tb w/o name is smaller than ta */
+	if (ta->name_off && !tb->name_off)
+		return -1;
+
+	ka = btf_kind(ta);
+	kb = btf_kind(tb);
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+
+	return cmp_btf_kind_name(ka, na, kb, nb);
+}
+
+__s32 find_btf_by_name_kind(const struct btf *btf, int start_id,
+				   const char *type_name, __u32 kind)
+{
+	const struct btf_type *t;
+	const char *tname;
+	__u32 i, total;
+
+	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
+		return 0;
+
+	do {
+		if (btf__nr_sorted_types(btf)) {
+			/* binary search */
+			__s32 start, end, mid, found = -1;
+			int ret;
+
+			start = btf__start_id(btf);
+			end = start + btf__nr_sorted_types(btf) - 1;
+			/* found the leftmost btf_type that matches */
+			while(start <= end) {
+				mid = start + (end - start) / 2;
+				t = btf_type_by_id(btf, mid);
+				tname = btf__name_by_offset(btf, t->name_off);
+				ret = cmp_btf_kind_name(BTF_INFO_KIND(t->info), tname,
+							kind, type_name);
+				if (ret == 0)
+					found = mid;
+				if (ret < 0)
+					start = mid + 1;
+				else if (ret >= 0)
+					end = mid - 1;
+			}
+
+			if (found != -1)
+				return found;
+		} else {
+			/* linear search */
+			total = btf__type_cnt(btf);
+			for (i = btf__start_id(btf); i < total; i++) {
+				t = btf_type_by_id(btf, i);
+				if (btf_kind(t) != kind)
+					continue;
+
+				tname = btf__name_by_offset(btf, t->name_off);
+				if (tname && !strcmp(tname, type_name))
+					return i;
+			}
+		}
+
+		btf = btf__base_btf(btf);
+	} while (btf && btf__start_id(btf) >= start_id);
+
+	return libbpf_err(-ENOENT);
+}
+
+void btf_check_sorted(struct btf *btf, int start_id)
+{
+	const struct btf_type *t;
+	int i, n, nr_sorted_types;
+
+	n = btf__type_cnt(btf);
+	if ((n - start_id) < BTF_CHECK_SORT_THRESHOLD)
+		return;
+
+	n--;
+	nr_sorted_types = 0;
+	for (i = start_id; i < n; i++) {
+		int k = i + 1;
+
+		t = btf_type_by_id(btf, i);
+		if (!btf__str_by_offset(btf, t->name_off))
+			return;
+
+		t = btf_type_by_id(btf, k);
+		if (!btf__str_by_offset(btf, t->name_off))
+			return;
+
+		if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
+			return;
+
+		if (t->name_off)
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, start_id);
+	if (t->name_off)
+		nr_sorted_types++;
+	if (nr_sorted_types >= BTF_CHECK_SORT_THRESHOLD)
+		btf__set_nr_sorted_types(btf, nr_sorted_types);
+}
+
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 35b2527bedec..f71f3e70c51c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -248,6 +248,12 @@ const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, _
 const struct btf_header *btf_header(const struct btf *btf);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
+int btf_compare_type_kinds_names(const void *a, const void *b, void *priv);
+__s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const char *type_name, __u32 kind);
+void btf_check_sorted(struct btf *btf, int start_id);
+__u32 btf__start_id(const struct btf *btf);
+__u32 btf__nr_sorted_types(const struct btf *btf);
+void btf__set_nr_sorted_types(struct btf *btf, __u32 nr);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.34.1


