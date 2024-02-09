Return-Path: <bpf+bounces-21603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308A84EF97
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286F61C24622
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED0A5227;
	Fri,  9 Feb 2024 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfgR3Fkj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150A5663
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451656; cv=none; b=lKkm3Xw2CcCL/R6w9t8RCGsgkNnQYYKIJoFL3O9qJ6WfcsW0Zso77HfFNhmr9n/8LF4nGSI6/BxYgopEtfvxZrMMiCKW/zrSANcWRnK5MBBgR1nwwZj5nl1pmB9jXOOCFYyncvUr3DqsCJQQpbPXUczNHcxN/GEF/A0Wvg0YtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451656; c=relaxed/simple;
	bh=7F+cBTB+Lz+iwrFci5SzkqudP1jNJrXGzpkIb1Egtt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYh+sTw3ci/N4kKyp3CCOL7SmmP9fJuZTwo/kB0DGpboQUlv937TNmDph2C+V/slwxqek8YazjsXZrU6W8/WBIiW5tSwGsEVqWuoeh5EHBLr3nqxCkXDV5GmiKlbxxAIXUgJ7HulWt3exHbhEw9UbTFM6jSsVZbjnRuTWg495EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfgR3Fkj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d95d67ff45so3996405ad.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451653; x=1708056453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax1i6Xx3KClBMGyRsPQIF9NlJODAQM+auENr+G97oYA=;
        b=LfgR3FkjClh2tydUCXToWYQmM/SlJJ+SnwkQRgzZMMkqlXJespOQ11MAL8leVwmL/s
         CZQzhhgb+u2LZ4fJU/4LOAsknzdtDeetx2PsUCRZudLUc597Xn//xw4HZigLrrYeYlR4
         emc6E9Sf31yn4zu/BAJVv5Ll6aViT4ph03s73NbkiIyy4V5L4CXlCu+0e449zKK++Xv7
         w51AMkQT79k+p0eyXXo6McxOHkiCEk44gxTVXMth6UZ/eqLbY1E4QUWNgqm7QLz2qPyw
         BB0Wuf1UK3GSISyHlXITRUpl5FHxgYNjOggxjQtuJOy8YMRbJuGs36UiLgf9QXCskA9D
         hYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451653; x=1708056453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax1i6Xx3KClBMGyRsPQIF9NlJODAQM+auENr+G97oYA=;
        b=P+Rs4nItdoJf6FZUI5aZc6UgAjbG4d+lhL8py64fS1t0vV72DRiEXBHU0Kn0UCUxzK
         9K1yNgTG/xnpD0XLTTQ2Papen2//i85pL7aMlD7We/aWgn6tvEE5q06zYyNJrds4YuyN
         +rShF3YwG+LIN9MWShkKUIkF9aurxpL14l37nlmUp0WPnFYsWcV41LRQN9oQZS1rBn3t
         GE3M8nxRDGh13bs6OLS2un1zo5fri0Qtr40E8aaCmCJs0u0O7gfjoU8SNq8U4U+h+yF4
         xIxOHIAdMBbNPacrjaGhJQ8QYJkj70dM4l8YfRE4/9nuWqop5KvgO32zpU6KzeiyXtX5
         nwiA==
X-Gm-Message-State: AOJu0YzCnViAOFiboMdow46IUTJ7SVw4eMpPxVWO+R0SQZRKFhMJjQqw
	28zYzJKOyT277lgVVLNHpxM+Um6X8DtAumYgqoba/8kortup5rVxD2w9yhlG
X-Google-Smtp-Source: AGHT+IEGpYswlstUcGLeCwP8YO/u0UAf0+3x8WGh941h8RI1JhGiemicOLthwo5sUBqPjsP/3SF5Yw==
X-Received: by 2002:a17:902:ec86:b0:1d8:b798:dfe3 with SMTP id x6-20020a170902ec8600b001d8b798dfe3mr539249plg.43.1707451653406;
        Thu, 08 Feb 2024 20:07:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs1Kr+GkxG5gGSe9IAqpYlusa71Kdv6s5vkhdFG/fLIWePlY2qWKxLMvnRUrNz4H/DAJGLF26mTDtKKjD8WWDBIctDQZzbsST9F4Ln+bPNO0wK+o8/lgyIJDSDX9j0UVSTG00H0rEVqkxYJfTYelhcv9T3cgo6Q3OyKabdF+pCiDx0TAFrFONzZioUBqDHvXhS2oIgVjsslE6CRoZx9oQ36cxG82cPnMKVzWA3lxyVdGIsESj7DqQMgkA+fPZOW4nam9SwLlwJAN1KWtzKdp0P8+g79UkteFT1wAcUGkp8s/fBeG9eZbxbKgPEzBihaEPIHFM4epKG+jmwpn4Na/ARvgwu54fm4mUdB5o9tfeL1v7IVfQwXQ==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b001d963d963aasm561477plb.308.2024.02.08.20.07.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:33 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 19/20] selftests/bpf: Add bpf_arena_htab test.
Date: Thu,  8 Feb 2024 20:06:07 -0800
Message-Id: <20240209040608.98927-20-alexei.starovoitov@gmail.com>
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

bpf_arena_htab.h - hash table implemented as bpf program

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++++++++++++++++
 .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++++++++++++++
 .../testing/selftests/bpf/progs/arena_htab.c  |  46 ++++++++
 .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
 4 files changed, 239 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c

diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testing/selftests/bpf/bpf_arena_htab.h
new file mode 100644
index 000000000000..acc01a876668
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_htab.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+#include <errno.h>
+#include "bpf_arena_alloc.h"
+#include "bpf_arena_list.h"
+
+struct htab_bucket {
+	struct arena_list_head head;
+};
+typedef struct htab_bucket __arena htab_bucket_t;
+
+struct htab {
+	htab_bucket_t *buckets;
+	int n_buckets;
+};
+typedef struct htab __arena htab_t;
+
+static inline htab_bucket_t *__select_bucket(htab_t *htab, __u32 hash)
+{
+	htab_bucket_t *b = htab->buckets;
+
+	cast_kern(b);
+	return &b[hash & (htab->n_buckets - 1)];
+}
+
+static inline arena_list_head_t *select_bucket(htab_t *htab, __u32 hash)
+{
+	return &__select_bucket(htab, hash)->head;
+}
+
+struct hashtab_elem {
+	int hash;
+	int key;
+	int value;
+	struct arena_list_node hash_node;
+};
+typedef struct hashtab_elem __arena hashtab_elem_t;
+
+static hashtab_elem_t *lookup_elem_raw(arena_list_head_t *head, __u32 hash, int key)
+{
+	hashtab_elem_t *l;
+
+	list_for_each_entry(l, head, hash_node)
+		if (l->hash == hash && l->key == key)
+			return l;
+
+	return NULL;
+}
+
+static int htab_hash(int key)
+{
+	return key;
+}
+
+__weak int htab_lookup_elem(htab_t *htab __arg_arena, int key)
+{
+	hashtab_elem_t *l_old;
+	arena_list_head_t *head;
+
+	cast_kern(htab);
+	head = select_bucket(htab, key);
+	l_old = lookup_elem_raw(head, htab_hash(key), key);
+	if (l_old)
+		return l_old->value;
+	return 0;
+}
+
+__weak int htab_update_elem(htab_t *htab __arg_arena, int key, int value)
+{
+	hashtab_elem_t *l_new = NULL, *l_old;
+	arena_list_head_t *head;
+
+	cast_kern(htab);
+	head = select_bucket(htab, key);
+	l_old = lookup_elem_raw(head, htab_hash(key), key);
+
+	l_new = bpf_alloc(sizeof(*l_new));
+	if (!l_new)
+		return -ENOMEM;
+	l_new->key = key;
+	l_new->hash = htab_hash(key);
+	l_new->value = value;
+
+	list_add_head(&l_new->hash_node, head);
+	if (l_old) {
+		list_del(&l_old->hash_node);
+		bpf_free(l_old);
+	}
+	return 0;
+}
+
+void htab_init(htab_t *htab)
+{
+	void __arena *buckets = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+
+	cast_user(buckets);
+	htab->buckets = buckets;
+	htab->n_buckets = 2 * PAGE_SIZE / sizeof(struct htab_bucket);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_htab.c b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
new file mode 100644
index 000000000000..0766702de846
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <network_helpers.h>
+
+#include "arena_htab_asm.skel.h"
+#include "arena_htab.skel.h"
+
+#define PAGE_SIZE 4096
+
+#include "bpf_arena_htab.h"
+
+static void test_arena_htab_common(struct htab *htab)
+{
+	int i;
+
+	printf("htab %p buckets %p n_buckets %d\n", htab, htab->buckets, htab->n_buckets);
+	ASSERT_OK_PTR(htab->buckets, "htab->buckets shouldn't be NULL");
+	for (i = 0; htab->buckets && i < 16; i += 4) {
+		/*
+		 * Walk htab buckets and link lists since all pointers are correct,
+		 * though they were written by bpf program.
+		 */
+		int val = htab_lookup_elem(htab, i);
+
+		ASSERT_EQ(i, val, "key == value");
+	}
+}
+
+static void test_arena_htab_llvm(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_htab *skel;
+	struct htab *htab;
+	size_t arena_sz;
+	void *area;
+	int ret;
+
+	skel = arena_htab__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_htab__open_and_load"))
+		return;
+
+	area = bpf_map__initial_value(skel->maps.arena, &arena_sz);
+	/* fault-in a page with pgoff == 0 as sanity check */
+	*(volatile int *)area = 0x55aa;
+
+	/* bpf prog will allocate more pages */
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_htab_llvm), &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+	if (skel->bss->skip) {
+		printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
+		test__skip();
+		goto out;
+	}
+	htab = skel->bss->htab_for_user;
+	test_arena_htab_common(htab);
+out:
+	arena_htab__destroy(skel);
+}
+
+static void test_arena_htab_asm(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_htab_asm *skel;
+	struct htab *htab;
+	int ret;
+
+	skel = arena_htab_asm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_htab_asm__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_htab_asm), &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+	htab = skel->bss->htab_for_user;
+	test_arena_htab_common(htab);
+	arena_htab_asm__destroy(skel);
+}
+
+void test_arena_htab(void)
+{
+	if (test__start_subtest("arena_htab_llvm"))
+		test_arena_htab_llvm();
+	if (test__start_subtest("arena_htab_asm"))
+		test_arena_htab_asm();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
new file mode 100644
index 000000000000..441fc502312f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+} arena SEC(".maps");
+
+#include "bpf_arena_htab.h"
+
+void __arena *htab_for_user;
+bool skip = false;
+
+SEC("syscall")
+int arena_htab_llvm(void *ctx)
+{
+#if defined(__BPF_FEATURE_ARENA_CAST) || defined(BPF_ARENA_FORCE_ASM)
+	struct htab __arena *htab;
+	__u64 i;
+
+	htab = bpf_alloc(sizeof(*htab));
+	cast_kern(htab);
+	htab_init(htab);
+
+	/* first run. No old elems in the table */
+	bpf_for(i, 0, 1000)
+		htab_update_elem(htab, i, i);
+
+	/* should replace all elems with new ones */
+	bpf_for(i, 0, 1000)
+		htab_update_elem(htab, i, i);
+	cast_user(htab);
+	htab_for_user = htab;
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_htab_asm.c b/tools/testing/selftests/bpf/progs/arena_htab_asm.c
new file mode 100644
index 000000000000..6cd70ea12f0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_htab_asm.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#define BPF_ARENA_FORCE_ASM
+#define arena_htab_llvm arena_htab_asm
+#include "arena_htab.c"
-- 
2.34.1


