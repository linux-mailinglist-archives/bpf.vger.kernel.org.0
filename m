Return-Path: <bpf+bounces-21381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547C84BFCB
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292F81C240D3
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A451C2BE;
	Tue,  6 Feb 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckRZtImY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF331C2A0
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257151; cv=none; b=MOZV2lwlyCfroqMW9rqC+QUotfi735Ub3Qg9roQr9mW547HhJMOKYQuuFsk0Hg3EIBJKDQwjR432gTrcpKnlTQwuxAh00k/fUXtmAB1oOMcm0lQ81/vwE6cv4oozQsDJLCkYF3WroxmTq/w67FXT8OXokKpGSYxdjHN5HoAw1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257151; c=relaxed/simple;
	bh=wsv90GiucnGYO3Rdtvz9NJ7jONRtbYkGT2AiHeEnT3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUGlH15cjNvYv2bMPXcJWT7lNm8KS6v7zFYmJO3afPvEOt3gRdNLJSUcuPSfJfk5VTvP3qu4+mnYRKSDKLCxOGeiL/0HhSDKDQ4WvuKejv4S/8oknG/8iqnSNX7RTWRwjuje/3vj633QYvG4FJL7Fvo6RE9GJueMdckBzuMiqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckRZtImY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93edfa76dso135555ad.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257149; x=1707861949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5sXl6wfPkVpJxXcJSxvXuOvb+1sMHHR6BvnXTDIECA=;
        b=ckRZtImY7oV/m6cNK/3X/OcVburjkmPVHyp74277OyI0C99yBx80ezYuXmELMmKqvh
         lYpGORRktD129L9I8gjW09XTP42vj53mmpdX2Q0ZJbOgKBCS1jFghM8WwjcEZvCiTqG7
         OPFK5MVxpZDJvM1PtW6tp1/OI45pBm87PrBZcu+6ruh7bLgfkkIKXBEjk7fcDuHNcl7b
         pwro9QSBvvZNB+HJMb7U8IAcwa1fRpBOsL2w69/ruBkUue+ou8YtMP/4rYQ8TSHfCsSS
         KvhpUZTFPwlyEUAzpSHeoIVIxhf98C1/q9A2KwxqfaU66Pt3SyKAxM7HaNLVkHgMmI+p
         FmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257149; x=1707861949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5sXl6wfPkVpJxXcJSxvXuOvb+1sMHHR6BvnXTDIECA=;
        b=w8NH7U3NBa3nIJy6SuE8axcUoX6c8sRtK5TU5SFwc27cu+EO6kbgq1ieWT6noRiuEd
         BBMXI0e4GUu5EEr9DgwII6tcFdXgmJmep3dCC1ObYUnwkO/Zv2Bryvqiq7A3D3r+Uhpj
         Q0pRNuSo1NKrzP3UZE7lwyKc3/1HpJ0JaNUeyk+s/4KW3Qvwnkqt/L1al3yP6y2b48py
         nNOR7OCRUuFCPeO8mRcsG6qhKA8MaYHdgrcDVg017JwN33K//F4jjwa4CSbCmGVzF9R6
         vVRaBgPuZfkOMRK+fHh2GGHf0Tpb6LP9kthX9xzFm1n70yzVp/gfsqxmeHcVHTkhlv83
         43pw==
X-Gm-Message-State: AOJu0YyeQL2AH3WtSBxug0NlwJhd5YygPx2DN57wYBOwXUlmbHskTUqe
	oJ80GXX2xQwkGtf2jt0j+9m2fS9zG8h9qHQIcx14rsM2Ybi2dv0J3KLVJ/Xl
X-Google-Smtp-Source: AGHT+IF9U+BtdYCt6M8dYZtgQt/dJeYpcJAyzhX1n//KSQC1NX0NDBwdE7WV9Rte853ceTYT7aKzoQ==
X-Received: by 2002:a17:902:650f:b0:1d9:edf5:c86b with SMTP id b15-20020a170902650f00b001d9edf5c86bmr59997plk.67.1707257148740;
        Tue, 06 Feb 2024 14:05:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwrnDaQTz88yxH7R10WszU4AcGQqpT0AnT3dwaaN4OHwpmdUYYkayQ0PtrkBsBSO9Wjx5ZBjmxmqDBYbHr2gYsJUzr8QjyyEEQvgAvG79SyCGECLR+KK1BoD8xCyc5PEBoX01aS0vrV5oCmEn0oAq8Cv79v4fg0YQg3/5TU0uAa9YA/zGgqQufx4ZMBU3oiWF3pbssnjT3Rt3yOG3GlgiyLxeTvaM8xicjLTdO62TKE10RjLGBtI7VQRG0Ytm9FHSObaQjTVnSsh5LfPEi9eM4mstvz9dj7/i0
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id r1-20020a170903410100b001d8f81ecebesm3718pld.192.2024.02.06.14.05.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:48 -0800 (PST)
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
Subject: [PATCH bpf-next 16/16] selftests/bpf: Add bpf_arena_htab test.
Date: Tue,  6 Feb 2024 14:04:41 -0800
Message-Id: <20240206220441.38311-17-alexei.starovoitov@gmail.com>
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

bpf_arena_htab.h - hash table implemented as bpf program

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++++++++++++++++
 .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++++++++++++++
 .../testing/selftests/bpf/progs/arena_htab.c  |  48 +++++++++
 .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
 4 files changed, 241 insertions(+)
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
index 000000000000..51a9eeb3df5a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -0,0 +1,48 @@
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
+	__uint(max_entries, 1u << 20); /* max_entries * value_size == size of mmap() region */
+	__type(key, __u64);
+	__type(value, __u64);
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


