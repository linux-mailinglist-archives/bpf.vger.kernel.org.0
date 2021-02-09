Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B364531490F
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBIGph (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBIGpf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 01:45:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D18C06178C
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 22:44:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 190so1990263wmz.0
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 22:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2Ons2bD2TTfk3iPm196vrHtJWcA9l/STffjEfACtKI=;
        b=pR+qIVDr3u9ePV5ktyYJKWGacGFZv84Z2oe0MpMdX71q3kWOa7cv7BRC5lKi9Jx1T4
         PpxDYdsRfiltLNk+p03S3yH5RqIEw+xqowRG9MibR3BUeaOWzCCQjOq8uNSgI7+TQ29Y
         Xzm1Yg6qb4q3+onXh2RXOuhDFIxCJLd5iW56IkFwEArqBDI6Fh2KFalxmXv2pGNgpu9L
         YzR/mQU3Uq4f4/PtQ2fc5SX29vWd5aViiaiAwhWOrvqEEreX+jJyrmj5uhuufD0AtigE
         R43CJeRMjx2vFvFKpDxfO/JYMzitG9wVi6yRkh49j6rB0c60W/mY2KnDgCZpl2Gbss+s
         yD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2Ons2bD2TTfk3iPm196vrHtJWcA9l/STffjEfACtKI=;
        b=H/bxKziX3WocfcpXc0LQ/dv2cds2dlDJRQe0LCeXIV6nh+O04cZG5BUkm8z58duD3E
         ec6Pv16V7FMbXSXMIX5gPooKQm6dBkf+JXu+H4CfL0OzKjoKndGZ19WUcdsRsmxFNKAL
         odzGzBU9GQrlujdL6iRispACTEea9N2w/sI8ulKv9koe+UbOHAsSGzlThR+PybHq8VxH
         amGdGxbDx+AaYMbYJhfGMGg50/AIPK6HWu4u8aq4KPRJgu790swVirjHLCGOHSGQa1mc
         jz7bCXSWQm+gTa1NVAtICHQIncPYpRYeCrRW16zftNcgoHZ17yEE0CxeSu/D/SYJ7zzS
         qChQ==
X-Gm-Message-State: AOAM5320abxqEbcgcpiS4al71cbffIO1gQiESL+iiwtKpb9T1YSK9zq3
        x7JNQJQZu8Ohvh2PiD1S0T496br/mxLZgrqSZlE=
X-Google-Smtp-Source: ABdhPJx5hmlfMaLJDXlKfnFTrwPtBj6lYUBExiYDbw9OIs1ZaWiqZd40MRf6Hg4oggoUcgUG6mNdCA==
X-Received: by 2002:a1c:5f82:: with SMTP id t124mr1859797wmb.55.1612853093768;
        Mon, 08 Feb 2021 22:44:53 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id t197sm5320717wmt.3.2021.02.08.22.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:44:53 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: Add unit tests for pointers in global functions
Date:   Tue,  9 Feb 2021 10:44:21 +0400
Message-Id: <20210209064421.15222-5-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209064421.15222-1-me@ubique.spb.ru>
References: <20210209064421.15222-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_global_func9  - check valid pointer's scenarios
test_global_func10 - check that a smaller type cannot be passed as a
                     larger one
test_global_func11 - check that CTX pointer cannot be passed
test_global_func12 - check access to a null pointer
test_global_func13 - check access to an arbitrary pointer value
test_global_func14 - check that an opaque pointer cannot be passed
test_global_func15 - check that a variable has an unknown value after
		     it was passed to a global function by pointer
test_global_func16 - check access to uninitialized stack memory

test_global_func_args - check read and write operations through a pointer

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
v1 -> v2:
 - Test pointer to a global variable, array, enum, int
 - Test reading / writing values by pointers in global functions

 .../bpf/prog_tests/global_func_args.c         |  56 ++++++++
 .../bpf/prog_tests/test_global_funcs.c        |   8 ++
 .../selftests/bpf/progs/test_global_func10.c  |  29 ++++
 .../selftests/bpf/progs/test_global_func11.c  |  19 +++
 .../selftests/bpf/progs/test_global_func12.c  |  21 +++
 .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
 .../selftests/bpf/progs/test_global_func14.c  |  21 +++
 .../selftests/bpf/progs/test_global_func15.c  |  22 +++
 .../selftests/bpf/progs/test_global_func16.c  |  22 +++
 .../selftests/bpf/progs/test_global_func9.c   | 132 ++++++++++++++++++
 .../bpf/progs/test_global_func_args.c         |  79 +++++++++++
 11 files changed, 433 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func14.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func15.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func16.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_args.c b/tools/testing/selftests/bpf/prog_tests/global_func_args.c
new file mode 100644
index 000000000000..643355e3358f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/global_func_args.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "test_progs.h"
+#include "network_helpers.h"
+
+static void test_global_func_args0(struct bpf_object *obj, __u32 duration)
+{
+	int err, i, map_fd, actual_value;
+
+	map_fd = bpf_find_map(__func__, obj, "values");
+	if (CHECK_FAIL(map_fd < 0))
+		return;
+
+	struct {
+		const char *descr;
+		int expected_value;
+	} tests[] = {
+		{"passing NULL pointer", 0},
+		{"returning value", 1},
+		{"reading local variable", 100 },
+		{"writing local variable", 101 },
+		{"reading global variable", 42 },
+		{"writing global variable", 43 },
+		{"writing to pointer-to-pointer", 1 },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		const int expected_value = tests[i].expected_value;
+
+		err = bpf_map_lookup_elem(map_fd, &i, &actual_value);
+
+		CHECK(err || actual_value != expected_value, tests[i].descr,
+			 "err %d result %d expected %d\n", err, actual_value, expected_value);
+	}
+}
+
+void test_global_func_args(void)
+{
+	const char *file = "./test_global_func_args.o";
+	__u32 duration = 0, retval;
+	struct bpf_object *obj;
+	int err, prog_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
+	if (CHECK(err, "load program", "error %d loading %s\n", err, file))
+		return;
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "pass global func args run",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+
+	test_global_func_args0(obj, duration);
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 32e4348b714b..59a3069a66f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -61,6 +61,14 @@ void test_test_global_funcs(void)
 		{ "test_global_func6.o" , "modified ctx ptr R2" },
 		{ "test_global_func7.o" , "foo() doesn't return scalar" },
 		{ "test_global_func8.o" },
+		{ "test_global_func9.o" },
+		{ "test_global_func10.o", "invalid indirect read from stack off -8+4 size 8" },
+		{ "test_global_func11.o", "Caller passes invalid args into func#1" },
+		{ "test_global_func12.o", "invalid mem access 'mem_or_null'" },
+		{ "test_global_func13.o", "Caller passes invalid args into func#1" },
+		{ "test_global_func14.o", "reference type('FWD S') size cannot be determined" },
+		{ "test_global_func15.o", "At program exit the register R0 has value" },
+		{ "test_global_func16.o", "invalid indirect read from stack" },
 	};
 	libbpf_print_fn_t old_print_fn = NULL;
 	int err, i, duration = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
new file mode 100644
index 000000000000..61c2ae92ce41
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct Small {
+	int x;
+};
+
+struct Big {
+	int x;
+	int y;
+};
+
+__noinline int foo(const struct Big *big)
+{
+	if (big == 0)
+		return 0;
+
+	return bpf_get_prandom_u32() < big->y;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	const struct Small small = {.x = skb->len };
+
+	return foo((struct Big *)&small) ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
new file mode 100644
index 000000000000..28488047c849
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+__noinline int foo(const struct S *s)
+{
+	return s ? bpf_get_prandom_u32() < s->x : 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	return foo(skb);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
new file mode 100644
index 000000000000..62343527cc59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+__noinline int foo(const struct S *s)
+{
+	return bpf_get_prandom_u32() < s->x;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	const struct S s = {.x = skb->len };
+
+	return foo(&s);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
new file mode 100644
index 000000000000..ff8897c1ac22
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+__noinline int foo(const struct S *s)
+{
+	if (s)
+		return bpf_get_prandom_u32() < s->x;
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	const struct S *s = (const struct S *)(0xbedabeda);
+
+	return foo(s);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func14.c b/tools/testing/selftests/bpf/progs/test_global_func14.c
new file mode 100644
index 000000000000..698c77199ebf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func14.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S;
+
+__noinline int foo(const struct S *s)
+{
+	if (s)
+		return bpf_get_prandom_u32() < *(const int *) s;
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+
+	return foo(NULL);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
new file mode 100644
index 000000000000..c19c435988d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__noinline int foo(unsigned int *v)
+{
+	if (v)
+		*v = bpf_get_prandom_u32();
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	unsigned int v = 1;
+
+	foo(&v);
+
+	return v;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func16.c b/tools/testing/selftests/bpf/progs/test_global_func16.c
new file mode 100644
index 000000000000..0312d1e8d8c0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func16.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__noinline int foo(int (*arr)[10])
+{
+	if (arr)
+		return (*arr)[9];
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	int array[10];
+
+	const int rv = foo(&array);
+
+	return rv ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
new file mode 100644
index 000000000000..bd233ddede98
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+struct C {
+	int x;
+	int y;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct S);
+} map SEC(".maps");
+
+enum E {
+	E_ITEM
+};
+
+static int global_data_x = 100;
+static int volatile global_data_y = 500;
+
+__noinline int foo(const struct S *s)
+{
+	if (s)
+		return bpf_get_prandom_u32() < s->x;
+
+	return 0;
+}
+
+__noinline int bar(int *x)
+{
+	if (x)
+		*x &= bpf_get_prandom_u32();
+
+	return 0;
+}
+__noinline int baz(volatile int *x)
+{
+	if (x)
+		*x &= bpf_get_prandom_u32();
+
+	return 0;
+}
+
+__noinline int qux(enum E *e)
+{
+	if (e)
+		return *e;
+
+	return 0;
+}
+
+__noinline int quux(int (*arr)[10])
+{
+	if (arr)
+		return (*arr)[9];
+
+	return 0;
+}
+
+__noinline int quuz(int **p)
+{
+	if (p)
+		*p = NULL;
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	int result = 0;
+
+	{
+		const struct S s = {.x = skb->len };
+
+		result |= foo(&s);
+	}
+
+	{
+		const __u32 key = 1;
+		const struct S *s = bpf_map_lookup_elem(&map, &key);
+
+		result |= foo(s);
+	}
+
+	{
+		const struct C c = {.x = skb->len, .y = skb->family };
+
+		result |= foo((const struct S *)&c);
+	}
+
+	{
+		result |= foo(NULL);
+	}
+
+	{
+		bar(&result);
+		bar(&global_data_x);
+	}
+
+	{
+		result |= baz(&global_data_y);
+	}
+
+	{
+		enum E e = E_ITEM;
+
+		result |= qux(&e);
+	}
+
+	{
+		int array[10] = {0};
+
+		result |= quux(&array);
+	}
+
+	{
+		int *p;
+
+		result |= quuz(&p);
+	}
+
+	return result ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_args.c b/tools/testing/selftests/bpf/progs/test_global_func_args.c
new file mode 100644
index 000000000000..c8e47e120bf6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func_args.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int v;
+};
+
+static struct S global_variable;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 7);
+	__type(key, __u32);
+	__type(value, int);
+} values SEC(".maps");
+
+static void save_value(__u32 index, int value)
+{
+	bpf_map_update_elem(&values, &index, &value, 0);
+}
+
+__noinline int foo(__u32 index, struct S *s)
+{
+	if (s) {
+		save_value(index, s->v);
+		return ++s->v;
+	}
+
+	save_value(index, 0);
+
+	return 1;
+}
+
+__noinline int bar(struct S **s)
+{
+	if (s)
+		*s = 0;
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	__u32 index = 0;
+
+	{
+		const int v = foo(index++, 0);
+
+		save_value(index++, v);
+	}
+
+	{
+		struct S s = { .v = 100 };
+
+		foo(index++, &s);
+		save_value(index++, s.v);
+	}
+
+	{
+		global_variable.v = 42;
+		foo(index++, &global_variable);
+		save_value(index++, global_variable.v);
+	}
+
+	{
+		struct S v, *p = &v;
+
+		bar(&p);
+		save_value(index++, !p);
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1

