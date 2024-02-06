Return-Path: <bpf+bounces-21380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46E84BFCA
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5330B1C241C9
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E971C686;
	Tue,  6 Feb 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Mv1eaR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BE1C28F
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257147; cv=none; b=DeCA+LzU6Kh+XrZkdvc6AgTY00ZlhefKHFU51lnWYTLjILvMrbVi2NkaEpp+bcrZgsAXJxs7971q240+KoX7xMsHwJ71+hTi/D65/aKMX+pNlEUDKaXu5E2+bY2in19GA6JcsXRnRbLCcVHgVxBeP58pVJuXM405nOPJ67l/14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257147; c=relaxed/simple;
	bh=pgjvqVMRCfFJvV6B1C97AEpFj5UfbOZUhIL4K0taz+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=si5XG9wKs5tTUCDDCMShVyJBUF2Du6OoVAIsWe/gScWMe92K6/BViiH5zYrPv2PrmwmihtDlGcQgyQbwNLPbJlxqtBw0bmsOWfDMMBWCg7n2/yoNRnhOqRJae6ZPynstbvLP17Wf5ut9abNeXDss1F4m4u26R5tWT4KzWLfTP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Mv1eaR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d76671e5a4so233155ad.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257145; x=1707861945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE9MS9eGwDxxFPhO8TsHXptAYT9bfyhTWbVoEpeoqYo=;
        b=g6Mv1eaRrQzGyvbARftPGc6nDkJ41JpfgLwSqDFeW+DKw5gm3/BDkGjacDuHOMu8uy
         pish/OH6mPFa/UNJ16Yh4N0i1F5LVpMU0QzVTjmsRrLqXtllbz3r4YGuv6MNUWAcRJWA
         d+XSLy13SENVt/bXN7pNrePCvC7sfIdUcXgbVFcMaRcXGgQ8CvOy1aKFuocmhGwNw4Wv
         sV/vGo/u43s8zgxNCvTiq/dWOX+VESWH45rN5Vja7BO9rIAnDpImC7Cb5AGUK2DSfrOh
         e0sf1KS6t+1+GO97HMjRJEndzeUOsnIawd6id9qtAvk/GvI3s3rmzy9D9oyA40+GKluQ
         aEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257145; x=1707861945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE9MS9eGwDxxFPhO8TsHXptAYT9bfyhTWbVoEpeoqYo=;
        b=hmA6MPWhtR/ZX5FgnWkQyUcR07SZJfzRZhQV4EX2JIyGt6Pr4rQjXCzMguk3pC0poV
         D8Dm9vO2M2v5GN+I+73b8Faf5u1Af0/2KHQ9LMYjiktIsdGTLN66w/FTsFmOOumRyC/x
         0KNU3fHCj86HvLn3aQB8bibIh8i9BtKLWlNEWkYeN9PM8tnyib7+aerAVT81QmI4HD5F
         GLprfENHQOvJ6URZxgcdO7USTYFTvKfqigu5DOARXMaK6CuElgFEU+F2977RhGsUiZg5
         3y5UxNgAnmpVwUoK3djV5BZX9VI02r//qNBqI9+Ei48p6SkSNxAN7nM14O/O2a2xOjHv
         Xw/g==
X-Gm-Message-State: AOJu0Yx11jKTygZ2X/9F4mrlPwK2sfh1WraGid0YCYYkvsX6P9LlFuMF
	6HTbiQZQTKx/TwbndBxpieCotcv1sOoZ11QWP8FEYGn75gRdYB8KFcs9j7L4
X-Google-Smtp-Source: AGHT+IGG4t9RdwkiKkRY2M19m/mS/AAjGHnAhoQCng8LQI6dq4CJB9Jc9qt3c31BNL7jwZ3IWRcjFQ==
X-Received: by 2002:a17:902:7448:b0:1d9:bbc2:87e7 with SMTP id e8-20020a170902744800b001d9bbc287e7mr2885407plt.36.1707257144956;
        Tue, 06 Feb 2024 14:05:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEDKC/l6eMEMtNlzEQS5nYwT0OU5E3cdDptT/bk60YVGSKo/zQyR2ggEBvMoXC+IGYAYwNexnNHzYKcK6Sy1nflFapKyb6QjD9fh6dKatzP9UaH207UZqQkqxAPhLpJ9gE4n8DSenkdqE6Hx7xzVlkC0yZzzMBg+zbd00GLiEiyZE3ZCbRK1jHdn2TTU4BYf91E/uepkReQz42tma3AhYwsh1vxCHafwJkY55srTZRYvlXGxlMA83+0cIWjdTdB8SDJPrz9RM8r0kHkKlT/LYjXrqgBXOFJ2Dl
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001d8e5a3be8asm1277pll.259.2024.02.06.14.05.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:44 -0800 (PST)
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
Subject: [PATCH bpf-next 15/16] selftests/bpf: Add bpf_arena_list test.
Date: Tue,  6 Feb 2024 14:04:40 -0800
Message-Id: <20240206220441.38311-16-alexei.starovoitov@gmail.com>
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

bpf_arena_common.h - common helpers and macros
bpf_arena_alloc.h - implements page_frag allocator as a bpf program.
bpf_arena_list.h - doubly linked link list as a bpf program.

Compiled as a bpf program and as native C code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h | 58 +++++++++++
 .../testing/selftests/bpf/bpf_arena_common.h  | 70 ++++++++++++++
 tools/testing/selftests/bpf/bpf_arena_list.h  | 95 +++++++++++++++++++
 .../selftests/bpf/prog_tests/arena_list.c     | 65 +++++++++++++
 .../testing/selftests/bpf/progs/arena_list.c  | 75 +++++++++++++++
 7 files changed, 365 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 5c2cc7e8c5d0..7759cff95b6f 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -11,3 +11,4 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
+arena						 # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1a63996c0304..11f7b612f967 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -3,3 +3,4 @@
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
+arena					 # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/bpf_arena_alloc.h b/tools/testing/selftests/bpf/bpf_arena_alloc.h
new file mode 100644
index 000000000000..0f4cb399b4c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_alloc.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+#include "bpf_arena_common.h"
+
+#ifndef __round_mask
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#endif
+#ifndef round_up
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#endif
+
+void __arena *cur_page;
+int cur_offset;
+
+/* Simple page_frag allocator */
+static inline void __arena* bpf_alloc(unsigned int size)
+{
+	__u64 __arena *obj_cnt;
+	void __arena *page = cur_page;
+	int offset;
+
+	size = round_up(size, 8);
+	if (size >= PAGE_SIZE - 8)
+		return NULL;
+	if (!page) {
+refill:
+		page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+		if (!page)
+			return NULL;
+		cast_kern(page);
+		cur_page = page;
+		cur_offset = PAGE_SIZE - 8;
+		obj_cnt = page + PAGE_SIZE - 8;
+		*obj_cnt = 0;
+	} else {
+		cast_kern(page);
+		obj_cnt = page + PAGE_SIZE - 8;
+	}
+
+	offset = cur_offset - size;
+	if (offset < 0)
+		goto refill;
+
+	(*obj_cnt)++;
+	cur_offset = offset;
+	return page + offset;
+}
+
+static inline void bpf_free(void __arena *addr)
+{
+	__u64 __arena *obj_cnt;
+
+	addr = (void __arena *)(((long)addr) & ~(PAGE_SIZE - 1));
+	obj_cnt = addr + PAGE_SIZE - 8;
+	if (--(*obj_cnt) == 0)
+		bpf_arena_free_pages(&arena, addr, 1);
+}
diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
new file mode 100644
index 000000000000..07849d502f40
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifndef WRITE_ONCE
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
+#endif
+
+#ifndef NUMA_NO_NODE
+#define	NUMA_NO_NODE	(-1)
+#endif
+
+#ifndef arena_container_of
+#define arena_container_of(ptr, type, member)			\
+	({							\
+		void __arena *__mptr = (void __arena *)(ptr);	\
+		((type *)(__mptr - offsetof(type, member)));	\
+	})
+#endif
+
+#ifdef __BPF__ /* when compiled as bpf program */
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE __PAGE_SIZE
+/*
+ * for older kernels try sizeof(struct genradix_node)
+ * or flexible:
+ * static inline long __bpf_page_size(void) {
+ *   return bpf_core_enum_value(enum page_size_enum___l, __PAGE_SIZE___l) ?: sizeof(struct genradix_node);
+ * }
+ * but generated code is not great.
+ */
+#endif
+
+#if defined(__BPF_FEATURE_ARENA_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#define __arena __attribute__((address_space(1)))
+#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
+#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
+#else
+#define __arena
+#define cast_kern(ptr) bpf_arena_cast(ptr, BPF_ARENA_CAST_KERN, 1)
+#define cast_user(ptr) bpf_arena_cast(ptr, BPF_ARENA_CAST_USER, 1)
+#endif
+
+void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
+				    int node_id, __u64 flags) __ksym __weak;
+void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
+
+#else /* when compiled as user space code */
+
+#define __arena
+#define __arg_arena
+#define cast_kern(ptr) /* nop for user space */
+#define cast_user(ptr) /* nop for user space */
+__weak char arena[1];
+
+#ifndef offsetof
+#define offsetof(type, member)  ((unsigned long)&((type *)0)->member)
+#endif
+
+static inline void __arena* bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt,
+						  int node_id, __u64 flags)
+{
+	return NULL;
+}
+static inline void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt)
+{
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing/selftests/bpf/bpf_arena_list.h
new file mode 100644
index 000000000000..9f34142b0f65
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_list.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+#include "bpf_arena_common.h"
+
+struct arena_list_node;
+
+typedef struct arena_list_node __arena arena_list_node_t;
+
+struct arena_list_node {
+	arena_list_node_t *next;
+	arena_list_node_t * __arena *pprev;
+};
+
+struct arena_list_head {
+	struct arena_list_node __arena *first;
+};
+typedef struct arena_list_head __arena arena_list_head_t;
+
+#define list_entry(ptr, type, member) arena_container_of(ptr, type, member)
+
+#define list_entry_safe(ptr, type, member) \
+	({ typeof(*ptr) * ___ptr = (ptr); \
+	 ___ptr ? ({ cast_kern(___ptr); list_entry(___ptr, type, member); }) : NULL; \
+	 })
+
+#ifndef __BPF__
+static inline void *bpf_iter_num_new(struct bpf_iter_num *, int, int) {	return NULL; }
+static inline void bpf_iter_num_destroy(struct bpf_iter_num *) {}
+static inline bool bpf_iter_num_next(struct bpf_iter_num *) { return true; }
+#endif
+
+/* Safely walk link list of up to 1M elements. Deletion of elements is allowed. */
+#define list_for_each_entry(pos, head, member)						\
+	for (struct bpf_iter_num ___it __attribute__((aligned(8),			\
+						      cleanup(bpf_iter_num_destroy))),	\
+			* ___tmp = (			\
+				bpf_iter_num_new(&___it, 0, (1000000)),			\
+				pos = list_entry_safe((head)->first,			\
+						      typeof(*(pos)), member),		\
+				(void)bpf_iter_num_destroy, (void *)0);			\
+	     bpf_iter_num_next(&___it) && pos &&				\
+		({ ___tmp = (void *)pos->member.next; 1; });			\
+	     pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))
+
+static inline void list_add_head(arena_list_node_t *n, arena_list_head_t *h)
+{
+	arena_list_node_t *first = h->first, * __arena *tmp;
+
+	cast_user(first);
+	cast_kern(n);
+	WRITE_ONCE(n->next, first);
+	cast_kern(first);
+	if (first) {
+		tmp = &n->next;
+		cast_user(tmp);
+		WRITE_ONCE(first->pprev, tmp);
+	}
+	cast_user(n);
+	WRITE_ONCE(h->first, n);
+
+	tmp = &h->first;
+	cast_user(tmp);
+	cast_kern(n);
+	WRITE_ONCE(n->pprev, tmp);
+}
+
+static inline void __list_del(arena_list_node_t *n)
+{
+	arena_list_node_t *next = n->next, *tmp;
+	arena_list_node_t * __arena *pprev = n->pprev;
+
+	cast_user(next);
+	cast_kern(pprev);
+	tmp = *pprev;
+	cast_kern(tmp);
+	WRITE_ONCE(tmp, next);
+	if (next) {
+		cast_user(pprev);
+		cast_kern(next);
+		WRITE_ONCE(next->pprev, pprev);
+	}
+}
+
+#define POISON_POINTER_DELTA 0
+
+#define LIST_POISON1  ((void __arena *) 0x100 + POISON_POINTER_DELTA)
+#define LIST_POISON2  ((void __arena *) 0x122 + POISON_POINTER_DELTA)
+
+static inline void list_del(arena_list_node_t *n)
+{
+	__list_del(n);
+	n->next = LIST_POISON1;
+	n->pprev = LIST_POISON2;
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_list.c b/tools/testing/selftests/bpf/prog_tests/arena_list.c
new file mode 100644
index 000000000000..ca3ce8abefc4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_list.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <network_helpers.h>
+
+#define PAGE_SIZE 4096
+
+#include "bpf_arena_list.h"
+#include "arena_list.skel.h"
+
+struct elem {
+	struct arena_list_node node;
+	__u64 value;
+};
+
+static int list_sum(struct arena_list_head *head)
+{
+	struct elem __arena *n;
+	int sum = 0;
+
+	list_for_each_entry(n, head, node)
+		sum += n->value;
+	return sum;
+}
+
+static void test_arena_list_add_del(int cnt)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_list *skel;
+	int expected_sum = (u64)cnt * (cnt - 1) / 2;
+	int ret, sum;
+
+	skel = arena_list__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_list__open_and_load"))
+		return;
+
+	skel->bss->cnt = cnt;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_add), &opts);
+	ASSERT_OK(ret, "ret_add");
+	ASSERT_OK(opts.retval, "retval");
+	if (skel->bss->skip) {
+		printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
+		test__skip();
+		goto out;
+	}
+	sum = list_sum(skel->bss->list_head);
+	ASSERT_EQ(sum, expected_sum, "sum of list elems");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_del), &opts);
+	ASSERT_OK(ret, "ret_del");
+	sum = list_sum(skel->bss->list_head);
+	ASSERT_EQ(sum, 0, "sum of list elems after del");
+	ASSERT_EQ(skel->bss->list_sum, expected_sum, "sum of list elems computed by prog");
+out:
+	arena_list__destroy(skel);
+}
+
+void test_arena_list(void)
+{
+	if (test__start_subtest("arena_list_1"))
+		test_arena_list_add_del(1);
+	if (test__start_subtest("arena_list_1000"))
+		test_arena_list_add_del(1000);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
new file mode 100644
index 000000000000..1acdec9dadde
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -0,0 +1,75 @@
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
+	__uint(max_entries, 1u << 24); /* max_entries * value_size == size of mmap() region */
+	__ulong(map_extra, 2ull << 44); /* start of mmap() region */
+	__type(key, __u64);
+	__type(value, __u64);
+} arena SEC(".maps");
+
+#include "bpf_arena_alloc.h"
+#include "bpf_arena_list.h"
+
+struct elem {
+	struct arena_list_node node;
+	__u64 value;
+};
+
+struct arena_list_head __arena *list_head;
+int list_sum;
+int cnt;
+bool skip = false;
+
+SEC("syscall")
+int arena_list_add(void *ctx)
+{
+#ifdef __BPF_FEATURE_ARENA_CAST
+	__u64 i;
+
+	list_head = bpf_alloc(sizeof(*list_head));
+
+	bpf_for(i, 0, cnt) {
+		struct elem __arena *n = bpf_alloc(sizeof(*n));
+
+		n->value = i;
+		list_add_head(&n->node, list_head);
+	}
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+int arena_list_del(void *ctx)
+{
+#ifdef __BPF_FEATURE_ARENA_CAST
+	struct elem __arena *n;
+	int sum = 0;
+
+	list_for_each_entry(n, list_head, node) {
+		sum += n->value;
+		list_del(&n->node);
+		bpf_free(n);
+	}
+	list_sum = sum;
+
+	/* triple free will not crash the kernel */
+	bpf_free(list_head);
+	bpf_free(list_head);
+	bpf_free(list_head);
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


