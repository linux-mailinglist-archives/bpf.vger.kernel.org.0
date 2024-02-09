Return-Path: <bpf+bounces-21602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1484EF96
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E331C23A14
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A250538A;
	Fri,  9 Feb 2024 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL9KRfKp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641C525D
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451652; cv=none; b=DVhxaDxGYocAfCyfHtwHUwz0JDX82lGg90YtaQ+NNr8jegiqzIpgVyo6kBH54NLg6dfd814K0CSRipXiXEqhQKGFfgHJ+XMzstm5y/3mEPjXfL0IoMkEji7jt9S46uihbq1q0aP7Y5M8xbkAZmZBGQ5EccEpsVMly4x5xdGAbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451652; c=relaxed/simple;
	bh=Dh/Oq8ZZBWmdokJ7xdFmxBMzQGBQw/0kJBzxQd6oHlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OM9aSJL1e9N5QYbggvm8aL5DlCZxGaWEMQTkbLY5KlDqC19kVQRjfDySnaiMNdCcbaBAnwmCGzq1OX8VQguNDFrIVXLMCOVreSPs4Xmq+ZAsaewmteXbuRxmuDkKlho44p9RmO8in/MNE9t5rgtZ8JPiLY8V1QxXLvIt786cnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL9KRfKp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e05d41828aso397935b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451649; x=1708056449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb+bGqWXAT7EYhVLB+w+aV2CuyvwLgJLPbtGe0eOYJ0=;
        b=QL9KRfKpWXPBKuKJhHSFsVoteYSrCsEntvJ0ntF6DPhzkxjUsYOOkSRXSzNr38ct2H
         8HYuUIHg+CKjgmsGPlG/7s1zRYgVqBf8Wt4rZUo60R++aQjNHVKLftZVdnI/yHrZRz8a
         Rf0FpnBYKefkK6Ohi0IPE9Xm35Puqeoi47DMrjBuMuCZVMqYxhuWrLpWvqMY7L2sSZ3J
         zUEkm+wylV3mzeOXqeo2ON7z1M00LwcrXM/6njEZ5d3I9xOQA3vQmRJDN5m7jn8kKA2U
         JLb08IaEWr+1BwOIV1opdVTaWUzpbTnkhoLwXD2nQe6ATOGeKTMTVXn06W/LJJCvQ1WW
         9ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451649; x=1708056449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb+bGqWXAT7EYhVLB+w+aV2CuyvwLgJLPbtGe0eOYJ0=;
        b=oYqoR5uxtdcAH1pf04MPpTMCcFM5R0u0Sv5p7R45qo3LSOJ3PxD6ziWt00R0bkSZfY
         RFm77Q+z4CmB1n+5NAXxgGSC4/JUT/sqCvAImXezzfqWkq1KadCx1wVFWz0cCmxBXkaE
         ZDbhV+j6/VNsN7DdaK1Yu5XblRmzufxeq2brCeRCzUcJZa3T7lnqTjFKeXY78rMkerRh
         HsWZ9bZ8CZVm5GU1Bxw8Jb3/viuPVaTu/FPV0t9A2NZC4mNQTT+NHL+Pg+W5eWCVIbFi
         hgmQMb0Y0YTMT5+s56EQigfghuiyvi9VEToljPGNwjtkbLSe8fGYvlR+vH/MVn1sXCu2
         Zhgw==
X-Gm-Message-State: AOJu0YxEemzA24R9i0KBx480jfK/SBqmbIR2oYJtH7tK230PmI7F1YQW
	KoXPrAg8q8Qsgqia2F4ZdlweCUmifkB74ElWUpn0mPobQssJI1vC43XCuajO
X-Google-Smtp-Source: AGHT+IGG5TNU//6saVXjiaDd3768cg95qj6j0b0wUL2WN3QIR5+8d+0UOYlVtQ8UWRPRvc2Z7Z+eHQ==
X-Received: by 2002:aa7:8058:0:b0:6d9:bb2f:3a69 with SMTP id y24-20020aa78058000000b006d9bb2f3a69mr491139pfm.28.1707451649186;
        Thu, 08 Feb 2024 20:07:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjtlzegU4md9eHPzOxI0W1dNxIUvJ3ODioqbSz+ZgQBvX4dmxdiUbBS7O0w8vBr9vAaA6uqWY3U+OSwiXqgbz757P/uWzG9Bl/sXQ7GtnQIvtx20f9N7sMwORHdhPk1jSJQUGn+dV9YbQOAp9CA6N76SE+oDBaw4b2sQToICMcKVjX46jljS+JQMlD//n/vyjn+4CQctUA2dDpLFz731lYn5YNR6kHFjmOpnCVsqCimcT4OO69W6fLm3kO0bz103wJeDiTKCf2y2EhDA8TpqLgZ0/vRkNtoRuBNvX+x8dmjKsHDq6+BYewLzKAphfVEbgNcG8GaOwoAFr2ClxgPEgiiSFHz8ev2mjVD2N/VkgGqLN8yyjFNg==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b006ddcf5d5b0bsm582570pfn.153.2024.02.08.20.07.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:28 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 18/20] selftests/bpf: Add bpf_arena_list test.
Date: Thu,  8 Feb 2024 20:06:06 -0800
Message-Id: <20240209040608.98927-19-alexei.starovoitov@gmail.com>
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

bpf_arena_alloc.h - implements page_frag allocator as a bpf program.
bpf_arena_list.h - doubly linked link list as a bpf program.

Compiled as a bpf program and as native C code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h | 58 +++++++++++
 tools/testing/selftests/bpf/bpf_arena_list.h  | 95 +++++++++++++++++++
 .../selftests/bpf/prog_tests/arena_list.c     | 68 +++++++++++++
 .../testing/selftests/bpf/progs/arena_list.c  | 76 +++++++++++++++
 6 files changed, 299 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 8e70af386e52..83a3d9bee59c 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -12,3 +12,4 @@ fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_mu
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
 verifier_arena                                   # JIT does not support arena
+arena						 # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index ded440277f6e..9293b88a327e 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -4,3 +4,4 @@ exceptions				 # JIT does not support calling kfunc bpf_throw				       (excepti
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 verifier_arena                           # JIT does not support arena
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
diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing/selftests/bpf/bpf_arena_list.h
new file mode 100644
index 000000000000..31fd744dfb72
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
+static inline void *bpf_iter_num_new(struct bpf_iter_num *it, int i, int j) { return NULL; }
+static inline void bpf_iter_num_destroy(struct bpf_iter_num *it) {}
+static inline bool bpf_iter_num_next(struct bpf_iter_num *it) { return true; }
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
index 000000000000..e61886debab1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_list.c
@@ -0,0 +1,68 @@
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
+	ASSERT_EQ(sum, expected_sum, "sum of elems");
+	ASSERT_EQ(skel->arena->arena_sum, expected_sum, "__arena sum of elems");
+	ASSERT_EQ(skel->arena->test_val, cnt + 1, "num of elems");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_del), &opts);
+	ASSERT_OK(ret, "ret_del");
+	sum = list_sum(skel->bss->list_head);
+	ASSERT_EQ(sum, 0, "sum of list elems after del");
+	ASSERT_EQ(skel->bss->list_sum, expected_sum, "sum of list elems computed by prog");
+	ASSERT_EQ(skel->arena->arena_sum, expected_sum, "__arena sum of elems");
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
index 000000000000..04ebcdd98f10
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -0,0 +1,76 @@
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
+	__uint(max_entries, 1000); /* number of pages */
+	__ulong(map_extra, 2ull << 44); /* start of mmap() region */
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
+long __arena arena_sum;
+int __arena test_val = 1;
+struct arena_list_head __arena global_head;
+
+SEC("syscall")
+int arena_list_add(void *ctx)
+{
+#ifdef __BPF_FEATURE_ARENA_CAST
+	__u64 i;
+
+	list_head = &global_head;
+
+	bpf_for(i, 0, cnt) {
+		struct elem __arena *n = bpf_alloc(sizeof(*n));
+
+		test_val++;
+		n->value = i;
+		arena_sum += i;
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
+	arena_sum = 0;
+	list_for_each_entry(n, list_head, node) {
+		sum += n->value;
+		arena_sum += n->value;
+		list_del(&n->node);
+		bpf_free(n);
+	}
+	list_sum = sum;
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


