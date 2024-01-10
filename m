Return-Path: <bpf+bounces-19300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA49A8291AC
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 02:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0831C2413E
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78260645;
	Wed, 10 Jan 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoyL0WeC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609738D
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f874219ff9so31105367b3.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 17:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704848425; x=1705453225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zuYyMrBNcDpnbsdEm25PL7v/orAm1QROAGpPEuxmFkY=;
        b=hoyL0WeC9P4fcG8n4iR/A4ibvf2/o+r4cpFn23Og27BjG9M4ze52j/jAAOsKVp8ztI
         XItp4G/jWieLhrjV09F3RPlyfzPGIY/OVTMhghGhMulFQxGbRBAlSMXTFB+/ZSjpzutN
         Yd6sNEqJV0S7K9yddfDsP7oWuYLuMFcZ+6II+wubImn6Z2uZXOFfQDhi0VbDDoAwqvEa
         Zg+LQc5+CDSd06IymfU6phccddH4m5pQqHEUeeoTUumfVZUuWLKQHsbUB0gh2qWiTXhK
         m/O6DL2Nu3VLeeduP92Sfptl969nsm5IPyCGNen3SVwgSkwwsFJa2H35ju4/uq9KiYB5
         xdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848425; x=1705453225;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuYyMrBNcDpnbsdEm25PL7v/orAm1QROAGpPEuxmFkY=;
        b=GxEoV/rQlf2z69RCpVp2R37N9TdgFRm+sFqRX1AYrvY86ADggQuRSwYJLFkwjOa/5s
         NWt1snywJcmC/eD12zpnzPLQoy+7r6GbZhfPL4PNulCmdFpaWXzlJLE/MOJArA87Bzam
         t0HZn0Y1Z4H1bNd27G1OypoQ+fHP4UD5m5kk3Be3kbtS5uSk+gzSDbCUTYkFwpM+mVKx
         yv2VkT/vADVnef6o24q4mq1z0Y5RgmhP8x1OvvTuwYMolGUqj+YQ769sreLmgu1Q9yQq
         1rCh4QFapwrIAYEwpJhWEz1qH5/tqfqKdYEi0C3w0rZV/XP1/yy6S++XTTQjdVmmzTr3
         k2ng==
X-Gm-Message-State: AOJu0Yzz+C4oeK+ep77dQ3IO6/U1PnotzleeWmuAwlJkJ9YIwj/41g+N
	P7HswjkTyT6lBc8lAiMj6n8trquzfxd81qI=
X-Google-Smtp-Source: AGHT+IFJJIdAIDOGb7tfHmvAG1S3sAk7eaj/DTrBV1NmDfjIbS+BcAqmHl/A/PTrudGzgwrVxZSqJzAO
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:6e02:226:46e2:967b])
 (user=brho job=sendgmr) by 2002:a05:690c:a88:b0:5e8:f747:1c99 with SMTP id
 ci8-20020a05690c0a8800b005e8f7471c99mr176053ywb.4.1704848425222; Tue, 09 Jan
 2024 17:00:25 -0800 (PST)
Date: Tue,  9 Jan 2024 20:00:05 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110010009.1210237-1-brho@google.com>
Subject: [PATCH v3 bpf-next] selftests/bpf: add inline assembly helpers to
 access array elements
From: Barret Rhoden <brho@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>
Cc: mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When accessing an array, even if you insert your own bounds check,
sometimes the compiler will remove the check.  bpf_cmp() will force the
compiler to do the check.

However, the compiler is free to make a copy of a register, check the copy,
and use the original to access the array.  The verifier knows the *copy*
is within bounds, but not the original register!

Although I couldn't recreate the "bounds check a copy of a register",
the test below managed to get the compiler to spill a register to the
stack, then bounds-check the register, and later reread the register -
sans bounds check.

By performing the bounds check and the indexing in assembly, we ensure
the register used to index the array was bounds checked.

Signed-off-by: Barret Rhoden <brho@google.com>
---
v2: https://lore.kernel.org/bpf/20240103185403.610641-1-brho@google.com

Changes since v2:
- added a test prog that should load, but fails to verify for me (Debian
  clang version 16.0.6 (16)).  these tests might be brittle and start
  successfully verifying for other compiler versions.
- removed the mmap-an-arraymap patch
- removed macros and added some "test fixture" code
- used RUN_TESTS for the __failure cases


 .../bpf/prog_tests/test_array_elem.c          | 167 ++++++++++++
 .../selftests/bpf/progs/array_elem_test.c     | 256 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  43 +++
 3 files changed, 466 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_array_elem.c
 create mode 100644 tools/testing/selftests/bpf/progs/array_elem_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_array_elem.c b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
new file mode 100644
index 000000000000..93e8f03fdeac
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+#include <test_progs.h>
+#include "array_elem_test.skel.h"
+
+#include <sys/mman.h>
+
+#define NR_MAP_ELEMS 100
+
+static size_t map_mmap_sz(struct bpf_map *map)
+{
+	size_t mmap_sz;
+
+	mmap_sz = (size_t)roundup(bpf_map__value_size(map), 8) *
+		bpf_map__max_entries(map);
+	mmap_sz = roundup(mmap_sz, sysconf(_SC_PAGE_SIZE));
+
+	return mmap_sz;
+}
+
+static void *map_mmap(struct bpf_map *map)
+{
+	return mmap(NULL, map_mmap_sz(map), PROT_READ | PROT_WRITE, MAP_SHARED,
+		    bpf_map__fd(map), 0);
+}
+
+static void map_munmap(struct bpf_map *map, void *addr)
+{
+	munmap(addr, map_mmap_sz(map));
+}
+
+struct arr_elem_fixture {
+	struct array_elem_test *skel;
+	int *map_elems;
+};
+
+static void setup_fixture(struct arr_elem_fixture *tf, size_t prog_off)
+{
+	struct array_elem_test *skel;
+	struct bpf_program *prog;
+	int err;
+
+	skel = array_elem_test__open();
+	if (!ASSERT_OK_PTR(skel, "array_elem_test open"))
+		return;
+
+	/*
+	 * Our caller doesn't know the addr of the program until the skeleton is
+	 * opened.  But the offset to the pointer is statically known.
+	 */
+	prog = *(struct bpf_program**)((__u8*)skel + prog_off);
+	bpf_program__set_autoload(prog, true);
+
+	err = array_elem_test__load(skel);
+	if (!ASSERT_EQ(err, 0, "array_elem_test load")) {
+		array_elem_test__destroy(skel);
+		return;
+	}
+
+	err = array_elem_test__attach(skel);
+	if (!ASSERT_EQ(err, 0, "array_elem_test attach")) {
+		array_elem_test__destroy(skel);
+		return;
+	}
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++) {
+		skel->bss->lookup_indexes[i] = i;
+		err = bpf_map_update_elem(bpf_map__fd(skel->maps.lookup_again),
+					  &i, &i, BPF_ANY);
+		ASSERT_EQ(err, 0, "array_elem_test set lookup_again");
+	}
+
+	tf->map_elems = map_mmap(skel->maps.arraymap);
+	ASSERT_OK_PTR(tf->map_elems, "mmap");
+
+	tf->skel = skel;
+}
+
+static void run_test(struct arr_elem_fixture *tf)
+{
+	tf->skel->bss->target_pid = getpid();
+	usleep(1);
+}
+
+static void destroy_fixture(struct arr_elem_fixture *tf)
+{
+	map_munmap(tf->skel->maps.arraymap, tf->map_elems);
+	array_elem_test__destroy(tf->skel);
+}
+
+static void test_access_single(void)
+{
+	struct arr_elem_fixture tf[1];
+
+	setup_fixture(tf, offsetof(struct array_elem_test,
+				   progs.access_single));
+	run_test(tf);
+
+	ASSERT_EQ(tf->map_elems[0], 1337, "array_elem map value not written");
+
+	destroy_fixture(tf);
+}
+
+static void test_access_all(void)
+{
+	struct arr_elem_fixture tf[1];
+
+	setup_fixture(tf, offsetof(struct array_elem_test,
+				   progs.access_all));
+	run_test(tf);
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(tf->map_elems[i], i,
+			  "array_elem map value not written");
+
+	destroy_fixture(tf);
+}
+
+static void test_oob_access(void)
+{
+	struct arr_elem_fixture tf[1];
+
+	setup_fixture(tf, offsetof(struct array_elem_test,
+				   progs.oob_access));
+	run_test(tf);
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(tf->map_elems[i], 0,
+			  "array_elem map value was written");
+
+	destroy_fixture(tf);
+}
+
+static void test_infer_size(void)
+{
+	struct arr_elem_fixture tf[1];
+
+	setup_fixture(tf, offsetof(struct array_elem_test,
+				   progs.infer_size));
+	run_test(tf);
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(tf->map_elems[i], i,
+			  "array_elem map value not written");
+
+	destroy_fixture(tf);
+}
+
+void test_test_array_elem(void)
+{
+	if (test__start_subtest("real_access_single"))
+		test_access_single();
+	if (test__start_subtest("real_access_all"))
+		test_access_all();
+	if (test__start_subtest("real_oob_access"))
+		test_oob_access();
+	if (test__start_subtest("real_infer_size"))
+		test_infer_size();
+
+	/*
+	 * RUN_TESTS() will load the *bad* tests, marked with
+	 * __failure, and ensure they fail to load.  It will also load the
+	 * *good* tests, which we already tested, so you'll see some tests twice
+	 * in the output.
+	 */
+	RUN_TESTS(array_elem_test);
+}
diff --git a/tools/testing/selftests/bpf/progs/array_elem_test.c b/tools/testing/selftests/bpf/progs/array_elem_test.c
new file mode 100644
index 000000000000..9cd90a3623e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/array_elem_test.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include <vmlinux.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+int target_pid = 0;
+
+#define NR_MAP_ELEMS 100
+
+/*
+ * We want to test valid accesses into an array, but we also need to fool the
+ * verifier.  If we just do for (i = 0; i < 100; i++), the verifier knows the
+ * value of i and can tell we're inside the array.
+ *
+ * This "lookup" array is just the values 0, 1, 2..., such that
+ * lookup_indexes[i] == i.  (set by userspace).  But the verifier doesn't know
+ * that.
+ */
+unsigned int lookup_indexes[NR_MAP_ELEMS];
+
+/*
+ * This second lookup array also has the values 0, 1, 2.  The extra layer of
+ * lookups seems to make the compiler work a little harder, and more likely to
+ * spill to the stack.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, NR_MAP_ELEMS);
+	__type(key, u32);
+	__type(value, u32);
+	__uint(map_flags, BPF_F_MMAPABLE);
+} lookup_again SEC(".maps");
+
+struct map_array {
+	int elems[NR_MAP_ELEMS];
+};
+
+/*
+ * This is an ARRAY_MAP of a single struct, and that struct is an array of
+ * elements.  Userspace can mmap the map as if it was just a basic array of
+ * elements.  Though if you make an ARRAY_MAP where the *values* are ints, don't
+ * forget that bpf map elements are rounded up to 8 bytes.
+ *
+ * Once you get the pointer to the base of the inner array, you can access all
+ * of the elements without another bpf_map_lookup_elem(), which is useful if you
+ * are operating on multiple elements while holding a spinlock.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct map_array);
+	__uint(map_flags, BPF_F_MMAPABLE);
+} arraymap SEC(".maps");
+
+static struct map_array *get_map_array(void)
+{
+	int zero = 0;
+
+	return bpf_map_lookup_elem(&arraymap, &zero);
+}
+
+static int *get_map_elems(void)
+{
+	struct map_array *arr = get_map_array();
+
+	if (!arr)
+		return NULL;
+	return arr->elems;
+}
+
+/*
+ * This is convoluted enough that the compiler may spill a register (r1) before
+ * bounds checking it.
+ */
+static void bad_set_elem(unsigned int which, int val)
+{
+	u32 idx_1;
+	u32 *idx_2p;
+	int *map_elems;
+
+	if (which >= NR_MAP_ELEMS)
+		return;
+
+	idx_1 = lookup_indexes[which];
+	idx_2p = bpf_map_lookup_elem(&lookup_again, &idx_1);
+	if (!idx_2p)
+		return;
+
+	/*
+	 * reuse idx_1, which is often r1.  if you use a new variable, e.g.
+	 * idx_3 = *idx_2p, the compiler will pick a non-caller save register
+	 * (e.g. r6), and won't spill it to the stack.
+	 */
+	idx_1 = *idx_2p;
+
+	/*
+	 * Whether we use bpf_cmp or a normal comparison, r1 might get spilled
+	 * to the stack, *then* checked against NR_MAP_ELEMS.  The verifier will
+	 * know r1's bounds, but since the check happened after the spill, it
+	 * doesn't know about the stack variable's bounds.
+	 */
+	if (bpf_cmp_unlikely(idx_1, >=, NR_MAP_ELEMS))
+		return;
+
+	/*
+	 * This does a bpf_map_lookup_elem(), which is a function call, which
+	 * necessitates spilling r1.
+	 */
+	map_elems = get_map_elems();
+	if (map_elems)
+		map_elems[idx_1] = val;
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+__failure
+__msg("R0 unbounded memory access, make sure to bounds check any such access")
+int bad_access_single(void *ctx)
+{
+	bad_set_elem(0, 1337);
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+__failure
+__msg("R0 unbounded memory access, make sure to bounds check any such access")
+int bad_access_all(void *ctx)
+{
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		bad_set_elem(i, i);
+	return 0;
+}
+
+/*
+ * Both lookup_indexes and lookup_again are identity maps, i.e. f(x) = x (within
+ * bounds), so ultimately we're setting map_elems[which] = val.
+ */
+static void good_set_elem(unsigned int which, int val)
+{
+	u32 idx_1;
+	u32 *idx_2p;
+	int *map_elems, *x;
+
+	if (which >= NR_MAP_ELEMS)
+		return;
+	idx_1 = lookup_indexes[which];
+	idx_2p = bpf_map_lookup_elem(&lookup_again, &idx_1);
+
+	if (!idx_2p)
+		return;
+
+	idx_1 = *idx_2p;
+
+	map_elems = get_map_elems();
+	x = bpf_array_elem(map_elems, NR_MAP_ELEMS, idx_1);
+	if (x)
+		*x = val;
+}
+
+/*
+ * Test accessing a single element in the array with a convoluted lookup.
+ */
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int access_single(void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	good_set_elem(0, 1337);
+
+	return 0;
+}
+
+/*
+ * Test that we can access all elements, and that we are accessing the element
+ * we think we are accessing.
+ */
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int access_all(void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		good_set_elem(i, i);
+
+	return 0;
+}
+
+/*
+ * Helper for various OOB tests.  An out-of-bound access should be handled like
+ * a lookup failure.  Specifically, the verifier should ensure we do not access
+ * outside the array.  Userspace will check that we didn't access somewhere
+ * inside the array.
+ */
+static void set_elem_to_1(long idx)
+{
+	int *map_elems = get_map_elems();
+	int *x;
+
+	x = bpf_array_elem(map_elems, NR_MAP_ELEMS, idx);
+	if (x)
+		*x = 1;
+}
+
+/*
+ * Test various out-of-bounds accesses.
+ */
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int oob_access(void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	set_elem_to_1(NR_MAP_ELEMS + 5);
+	set_elem_to_1(NR_MAP_ELEMS);
+	set_elem_to_1(-1);
+	set_elem_to_1(~0UL);
+
+	return 0;
+}
+
+/*
+ * Test that we can use the ARRAY_SIZE-style helper with an array in a map.
+ *
+ * Note that you cannot infer the size of the array from just a pointer; you
+ * have to use the actual elems[100].  i.e. this will fail and should fail to
+ * compile (-Wsizeof-pointer-div):
+ *
+ *	int *map_elems = get_map_elems();
+ *	x = bpf_array_sz_elem(map_elems, lookup_indexes[i]);
+ */
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int infer_size(void *ctx)
+{
+	struct map_array *arr = get_map_array();
+	int *x;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++) {
+		x = bpf_array_sz_elem(arr->elems, lookup_indexes[i]);
+		if (x)
+			*x = i;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 2fd59970c43a..002bab44cde2 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -135,4 +135,47 @@
 /* make it look to compiler like value is read and written */
 #define __sink(expr) asm volatile("" : "+g"(expr))
 
+/*
+ * Access an array element within a bound, such that the verifier knows the
+ * access is safe.
+ *
+ * This macro asm is the equivalent of:
+ *
+ *	if (!arr)
+ *		return NULL;
+ *	if (idx >= arr_sz)
+ *		return NULL;
+ *	return &arr[idx];
+ *
+ * The index (___idx below) needs to be a u64, at least for certain versions of
+ * the BPF ISA, since there aren't u32 conditional jumps.
+ */
+#define bpf_array_elem(arr, arr_sz, idx) ({				\
+	typeof(&(arr)[0]) ___arr = arr;					\
+	__u64 ___idx = idx;						\
+	if (___arr) {							\
+		asm volatile("if %[__idx] >= %[__bound] goto 1f;	\
+			      %[__idx] *= %[__size];		\
+			      %[__arr] += %[__idx];		\
+			      goto 2f;				\
+			      1:;				\
+			      %[__arr] = 0;			\
+			      2:				\
+			      "						\
+			     : [__arr]"+r"(___arr), [__idx]"+r"(___idx)	\
+			     : [__bound]"r"((arr_sz)),		        \
+			       [__size]"i"(sizeof(typeof((arr)[0])))	\
+			     : "cc");					\
+	}								\
+	___arr;								\
+})
+
+/*
+ * Convenience wrapper for bpf_array_elem(), where we compute the size of the
+ * array.  Be sure to use an actual array, and not a pointer, just like with the
+ * ARRAY_SIZE macro.
+ */
+#define bpf_array_sz_elem(arr, idx) \
+	bpf_array_elem(arr, sizeof(arr) / sizeof((arr)[0]), idx)
+
 #endif
-- 
2.43.0.472.g3155946c3a-goog


