Return-Path: <bpf+bounces-18868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D965F8230A1
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99E61C23754
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1D1C290;
	Wed,  3 Jan 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvLJHex6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EED1BDC3
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9eeb4a60so771613276.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704296001; x=1704900801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OicT+l3EZJlJYj2TM+wBf0RsBy8Da2sRlMessm79MX4=;
        b=uvLJHex6cAxG69h2j4On6/Tu/EsYcNpVMI2NmLGQI8RWBwWHngmeHhT0oyQhqe8s32
         stH33io1hEAl4bavoNn1xdcJFxGfPx6X8zx52aAULkBGPblLw8Eae6hGcWA0ZYQqI7wS
         FjMRHkuOP3b/8D2pGisXsGJVZAX+VGzwhZF1x2bHN3XqksXovR9EIo8XpU6hA/Eo/UwG
         usExDcJVq3htvPw8uIkdAgJ0Ni50W0jAnK6gn9lQYp0FMGE7HnXxVii4GVLQ2IdzSw63
         myUNm3DxQG7jpll7B1l2dMjO2T0X9DX46O7j3Ti7wzIsWqAIa4fwNag5t3joNxG+Hrr5
         btWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296001; x=1704900801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OicT+l3EZJlJYj2TM+wBf0RsBy8Da2sRlMessm79MX4=;
        b=R4sVm78eBfsU0jnaupySBbI8Z+Xr8kwrkEsUkshREVfyWcNrM/pxH9F7IbOPCBM8VY
         ypcpPy2SGa9fDSF9PT8uak+qrUj7ktR7uV0FwRILPlEmC6d+7UPnUWs1vspuHh2M1jmb
         nukeyKrNbLBt7HccQtu1fHUrNapngd9XuXKtVRE1dP9HjPLWPZmPZpKaAXHzOXLuL8A6
         FKhOmrTZ4kdjwsotP35QoHoP9Vs25Ui8KryYRSxmncWAf+U0z/ARKzScelOeH0ilR77M
         QuPViHUqDHIXqAPjcIj6fsxPK2bzwjzO/MfafO3svP8ym8XRNhCctlFzrjcX/C7G+Hw9
         19/A==
X-Gm-Message-State: AOJu0Yz3b7/0+D3EG20a6D/CBdbIK3k833iUA7x7MtJ79pwM20q4ebaN
	h+x+9X+hd2o4h0XiklMGjIJsYxnYEXGiCNc=
X-Google-Smtp-Source: AGHT+IFBRD+ZEI1ilypTnzEQs3SBZHYgKw6gKzJ73D+jgtUEvgAc3+DG2QK8wd49cHs1EI2qezTz6GFM
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:7e71:cfbd:2031:cc52])
 (user=brho job=sendgmr) by 2002:a25:7495:0:b0:dbe:9f12:cfc6 with SMTP id
 p143-20020a257495000000b00dbe9f12cfc6mr37792ybc.1.1704296001660; Wed, 03 Jan
 2024 07:33:21 -0800 (PST)
Date: Wed,  3 Jan 2024 10:33:02 -0500
In-Reply-To: <20240103153307.553838-1-brho@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103153307.553838-1-brho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103153307.553838-3-brho@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers to
 access array elements
From: Barret Rhoden <brho@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When accessing an array, even if you insert your own bounds check,
sometimes the compiler will remove the check, or modify it such that the
verifier no longer knows your access is within bounds.

The compiler is even free to make a copy of a register, check the copy,
and use the original to access the array.  The verifier knows the *copy*
is within bounds, but not the original register!

Signed-off-by: Barret Rhoden <brho@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/test_array_elem.c          | 112 ++++++++++
 .../selftests/bpf/progs/array_elem_test.c     | 195 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  43 ++++
 4 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_array_elem.c
 create mode 100644 tools/testing/selftests/bpf/progs/array_elem_test.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 617ae55c3bb5..651d4663cc78 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -34,7 +34,7 @@ LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
 CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
-	  -Wall -Werror 						\
+	  -dicks -Wall -Werror 						\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
diff --git a/tools/testing/selftests/bpf/prog_tests/test_array_elem.c b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
new file mode 100644
index 000000000000..c953636f07c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+#include <test_progs.h>
+#include "array_elem_test.skel.h"
+
+#define NR_MAP_ELEMS 100
+
+/*
+ * Helper to load and run a program.
+ * Call must define skel, map_elems, and bss_elems.
+ * Destroy the skel when you're done.
+ */
+#define load_and_run(PROG) ({						\
+	int err;							\
+	skel = array_elem_test__open();					\
+	if (!ASSERT_OK_PTR(skel, "array_elem_test open"))		\
+		return;							\
+	bpf_program__set_autoload(skel->progs.x_ ## PROG, true);	\
+	err = array_elem_test__load(skel);				\
+	if (!ASSERT_EQ(err, 0, "array_elem_test load")) {		\
+		array_elem_test__destroy(skel);				\
+		return;							\
+	}								\
+	err = array_elem_test__attach(skel);				\
+	if (!ASSERT_EQ(err, 0, "array_elem_test attach")) {		\
+		array_elem_test__destroy(skel);				\
+		return;							\
+	}								\
+	for (int i = 0; i < NR_MAP_ELEMS; i++)				\
+		skel->bss->lookup_indexes[i] = i;			\
+	map_elems = bpf_map__mmap(skel->maps.arraymap);			\
+	ASSERT_OK_PTR(map_elems, "mmap");				\
+	bss_elems = skel->bss->bss_elems;				\
+	skel->bss->target_pid = getpid();				\
+	usleep(1);							\
+})
+
+static void test_access_all(void)
+{
+	struct array_elem_test *skel;
+	int *map_elems;
+	int *bss_elems;
+
+	load_and_run(access_all);
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(map_elems[i], i, "array_elem map value not written");
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(bss_elems[i], i, "array_elem bss value not written");
+
+	array_elem_test__destroy(skel);
+}
+
+static void test_oob_access(void)
+{
+	struct array_elem_test *skel;
+	int *map_elems;
+	int *bss_elems;
+
+	load_and_run(oob_access);
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(map_elems[i], 0, "array_elem map value was written");
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(bss_elems[i], 0, "array_elem bss value was written");
+
+	array_elem_test__destroy(skel);
+}
+
+static void test_access_array_map_infer_sz(void)
+{
+	struct array_elem_test *skel;
+	int *map_elems;
+	int *bss_elems __maybe_unused;
+
+	load_and_run(access_array_map_infer_sz);
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		ASSERT_EQ(map_elems[i], i, "array_elem map value not written");
+
+	array_elem_test__destroy(skel);
+}
+
+
+/* Test that attempting to load a bad program fails. */
+#define test_bad(PROG) ({						\
+	struct array_elem_test *skel;					\
+	int err;							\
+	skel = array_elem_test__open();					\
+	if (!ASSERT_OK_PTR(skel, "array_elem_test open"))		\
+		return;							\
+	bpf_program__set_autoload(skel->progs.x_bad_ ## PROG, true); 	\
+	err = array_elem_test__load(skel);				\
+	ASSERT_ERR(err, "array_elem_test load " # PROG);		\
+	array_elem_test__destroy(skel);					\
+})
+
+void test_test_array_elem(void)
+{
+	if (test__start_subtest("array_elem_access_all"))
+		test_access_all();
+	if (test__start_subtest("array_elem_oob_access"))
+		test_oob_access();
+	if (test__start_subtest("array_elem_access_array_map_infer_sz"))
+		test_access_array_map_infer_sz();
+	if (test__start_subtest("array_elem_bad_map_array_access"))
+		test_bad(map_array_access);
+	if (test__start_subtest("array_elem_bad_bss_array_access"))
+		test_bad(bss_array_access);
+}
diff --git a/tools/testing/selftests/bpf/progs/array_elem_test.c b/tools/testing/selftests/bpf/progs/array_elem_test.c
new file mode 100644
index 000000000000..9d48afc933f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/array_elem_test.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+#include <stdbool.h>
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
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
+/* Arrays can be in the BSS or inside a map element.  Make sure both work. */
+int bss_elems[NR_MAP_ELEMS];
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
+	__type(key, int);
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
+ * Test that we can access all elements, and that we are accessing the element
+ * we think we are accessing.
+ */
+static void access_all(void)
+{
+	int *map_elems = get_map_elems();
+	int *x;
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++) {
+		x = bpf_array_elem(map_elems, NR_MAP_ELEMS, lookup_indexes[i]);
+		if (x)
+			*x = i;
+	}
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++) {
+		x = bpf_array_sz_elem(bss_elems, lookup_indexes[i]);
+		if (x)
+			*x = i;
+	}
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int x_access_all(void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+	access_all();
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
+	x = bpf_array_sz_elem(bss_elems, idx);
+	if (x)
+		*x = 1;
+}
+
+/*
+ * Test various out-of-bounds accesses.
+ */
+static void oob_access(void)
+{
+	set_elem_to_1(NR_MAP_ELEMS + 5);
+	set_elem_to_1(NR_MAP_ELEMS);
+	set_elem_to_1(-1);
+	set_elem_to_1(~0UL);
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int x_oob_access(void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+	oob_access();
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
+static void access_array_map_infer_sz(void)
+{
+	struct map_array *arr = get_map_array();
+	int *x;
+
+	for (int i = 0; i < NR_MAP_ELEMS; i++) {
+		x = bpf_array_sz_elem(arr->elems, lookup_indexes[i]);
+		if (x)
+			*x = i;
+	}
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int x_access_array_map_infer_sz(void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+	access_array_map_infer_sz();
+	return 0;
+}
+
+
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int x_bad_map_array_access(void *ctx)
+{
+	int *map_elems = get_map_elems();
+
+	/*
+	 * Need to check to promote map_elems from MAP_OR_NULL to MAP so that we
+	 * fail to load below for the right reason.
+	 */
+	if (!map_elems)
+		return 0;
+	/* Fail to load: we don't prove our access is inside map_elems[] */
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		map_elems[lookup_indexes[i]] = i;
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int x_bad_bss_array_access(void *ctx)
+{
+	/* Fail to load: we don't prove our access is inside bss_elems[] */
+	for (int i = 0; i < NR_MAP_ELEMS; i++)
+		bss_elems[lookup_indexes[i]] = i;
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


