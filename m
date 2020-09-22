Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F112748BA
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 21:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIVTEH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Sep 2020 15:04:07 -0400
Received: from mx.der-flo.net ([193.160.39.236]:46168 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVTEH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 15:04:07 -0400
Received: by mx.der-flo.net (Postfix, from userid 110)
        id 6A3F744019; Tue, 22 Sep 2020 21:04:04 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.der-flo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from linux.home (unknown [IPv6:2a02:1203:ecb0:3930:146b:10e2:afb5:be30])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 9C79844011;
        Tue, 22 Sep 2020 21:03:08 +0200 (CEST)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next v2] bpf: Lift hashtab key_size limit
Date:   Tue, 22 Sep 2020 21:02:34 +0200
Message-Id: <20200922190234.224161-1-dev@der-flo.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently key_size of hashtab is limited to MAX_BPF_STACK.
As the key of hashtab can also be a value from a per cpu map it can be
larger than MAX_BPF_STACK.

Changelog:

v2:
 -  Add a test for bpf side

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/hashtab.c                          | 16 +++----
 .../selftests/bpf/prog_tests/hash_large_key.c | 28 ++++++++++++
 .../selftests/bpf/progs/test_hash_large_key.c | 45 +++++++++++++++++++
 tools/testing/selftests/bpf/test_maps.c       |  2 +-
 4 files changed, 79 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/hash_large_key.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_hash_large_key.c

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index fe0e06284..fcac16cd4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -390,17 +390,11 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	    attr->value_size == 0)
 		return -EINVAL;
 
-	if (attr->key_size > MAX_BPF_STACK)
-		/* eBPF programs initialize keys on stack, so they cannot be
-		 * larger than max stack size
-		 */
-		return -E2BIG;
-
-	if (attr->value_size >= KMALLOC_MAX_SIZE -
-	    MAX_BPF_STACK - sizeof(struct htab_elem))
-		/* if value_size is bigger, the user space won't be able to
-		 * access the elements via bpf syscall. This check also makes
-		 * sure that the elem_size doesn't overflow and it's
+	if ((attr->key_size + attr->value_size) >= KMALLOC_MAX_SIZE -
+	    sizeof(struct htab_elem))
+		/* if key_size + value_size is bigger, the user space won't be
+		 * able to access the elements via bpf syscall. This check
+		 * also makes sure that the elem_size doesn't overflow and it's
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
diff --git a/tools/testing/selftests/bpf/prog_tests/hash_large_key.c b/tools/testing/selftests/bpf/prog_tests/hash_large_key.c
new file mode 100644
index 000000000..962f56060
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/hash_large_key.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Florian Lehner
+
+#include <test_progs.h>
+
+void test_hash_large_key(void)
+{
+	const char *file = "./test_hash_large_key.o";
+	int prog_fd, map_fd[2];
+	struct bpf_object *obj = NULL;
+	int err = 0;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
+	if (CHECK_FAIL(err)) {
+		printf("test_hash_large_key: bpf_prog_load errno %d", errno);
+		goto close_prog;
+	}
+
+	map_fd[0] = bpf_find_map(__func__, obj, "hash_map");
+	if (CHECK_FAIL(map_fd[0] < 0))
+		goto close_prog;
+	map_fd[1] = bpf_find_map(__func__, obj, "key_map");
+	if (CHECK_FAIL(map_fd[1] < 0))
+		goto close_prog;
+
+close_prog:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_hash_large_key.c b/tools/testing/selftests/bpf/progs/test_hash_large_key.c
new file mode 100644
index 000000000..622ee73a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_hash_large_key.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Florian Lehner
+
+#include <linux/bpf.h>
+#include <linux/version.h>
+#include <bpf/bpf_helpers.h>
+
+struct bigelement {
+	int a;
+	char b[4096];
+	long long c;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, struct bigelement);
+	__type(value, __u32);
+} hash_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct bigelement);
+} key_map SEC(".maps");
+
+SEC("hash_large_key_demo")
+int bpf_hash_large_key_test(struct __sk_buf *skb)
+{
+	int zero = 0, err = 1, value = 42;
+	struct bigelement *key;
+
+	key = bpf_map_lookup_elem(&key_map, &zero);
+	if (!key)
+		goto err;
+
+	if (bpf_map_update_elem(&hash_map, key, &value, BPF_ANY))
+		goto err;
+	err = 0;
+err:
+	return err;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 754cf6117..9b2a096f0 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1225,7 +1225,7 @@ static void test_map_large(void)
 {
 	struct bigkey {
 		int a;
-		char b[116];
+		char b[4096];
 		long long c;
 	} key;
 	int fd, i, value;
-- 
2.26.2

