Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270BF26B581
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgIOXqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 19:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIOXp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 19:45:58 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D6BC061788
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 16:45:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r4so2760286pgl.20
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 16:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=45yFd9r6NBhawqTHKehHRnMtzm7SAMP/iKQPE3OyBgE=;
        b=MzAlXHUX3sWVdA+h1U79rLXno79Zxu5SjNJb2ez9q/Zyy6Nu/H64aFxlUZEjHlYeL0
         Y9HewrStuddADVC62VF0bCDgJX282jozcZENxNRTg3kMu4gP9kaOTjr9r6hwTt95V0sQ
         zmZmkPmRaGL9HabJwzW+fbBYJ88fbKvWgmnGiMgx1hFIgpgjs5tgbsk41CD/YWYABpXe
         GFX+pRk/hc9cJJuXCorX+EF0uBfLgHpJc9p8e5lkkBkQFg/ojBOKmmdzo8Ajk24kZaXH
         Q7nEpdFG3DwxclTktwn7tsWHfSXzVpu9plMuDD4IyOMANprxMOGWNPQRGHfi87CHe4qb
         d9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=45yFd9r6NBhawqTHKehHRnMtzm7SAMP/iKQPE3OyBgE=;
        b=PYECxkcYowoK8d+CRsYYyg2pyX7b0WP7uG/Ymrjr6u81IMeHCu/e7g5gTWeiCWhP9k
         qsjvdqrAhQUgka8hqNG4/u4tM0OJf+RG4onM3RlMV/joxY5pd3lgM/1vs45+KnPhEWCD
         xJrxNKliBkWWoeE1LO65nJ5L0o3Su9UST+IisfdfN0lIV3O+Jg59un22VFjQeiKgU4Un
         lqXzrQjNOir81seL0JXXbvq0n8H3fSaSQneq8og45UzyxFTvuVGu3qgo6TXtGbTlZueQ
         rhvHfDbaC0bAGaxydl1N3XgvX5EPJ39IBotBpWTTuHT5euEY90FcxfJMy94rvE83NZVf
         Ra8w==
X-Gm-Message-State: AOAM530AY+tbgrW3VBfS8bgWBbtpR958Y8V9jBjBorhcImz4IRloA67O
        kOFfeAPSbHaAQVQ/7HpHghP2cnk=
X-Google-Smtp-Source: ABdhPJwlpC4TK0ZBM9SEUOjzkwXQmy5D4b9JJAs2rZ6Phwm4+LJj9iAQBCH4AYMJuPJAnxqy3OcwYI8=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a17:90a:4803:: with SMTP id
 a3mr1518319pjh.192.1600213554814; Tue, 15 Sep 2020 16:45:54 -0700 (PDT)
Date:   Tue, 15 Sep 2020 16:45:43 -0700
In-Reply-To: <20200915234543.3220146-1-sdf@google.com>
Message-Id: <20200915234543.3220146-6-sdf@google.com>
Mime-Version: 1.0
References: <20200915234543.3220146-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Test load and dump metadata
 with btftool and skel
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Andrii Nakryiko <andriin@fb.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This is a simple test to check that loading and dumping metadata
in btftool works, whether or not metadata contents are used by the
program.

A C test is also added to make sure the skeleton code can read the
metadata values.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/metadata.c       | 141 ++++++++++++++++++
 .../selftests/bpf/progs/metadata_unused.c     |  15 ++
 .../selftests/bpf/progs/metadata_used.c       |  15 ++
 .../selftests/bpf/test_bpftool_metadata.sh    |  82 ++++++++++
 5 files changed, 255 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/metadata.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 05798c2b5c67..2a63791177c4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -68,7 +68,8 @@ TEST_PROGS := test_kmod.sh \
 	test_tc_edt.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
-	test_bpftool.sh
+	test_bpftool.sh \
+	test_bpftool_metadata.sh \
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/metadata.c b/tools/testing/selftests/bpf/prog_tests/metadata.c
new file mode 100644
index 000000000000..2c53eade88e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/metadata.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include <network_helpers.h>
+
+#include "metadata_unused.skel.h"
+#include "metadata_used.skel.h"
+
+static int duration;
+
+static int prog_holds_map(int prog_fd, int map_fd)
+{
+	struct bpf_prog_info prog_info = {};
+	struct bpf_prog_info map_info = {};
+	__u32 prog_info_len;
+	__u32 map_info_len;
+	__u32 *map_ids;
+	int nr_maps;
+	int ret;
+	int i;
+
+	map_info_len = sizeof(map_info);
+	ret = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
+	if (ret)
+		return -errno;
+
+	prog_info_len = sizeof(prog_info);
+	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	if (ret)
+		return -errno;
+
+	map_ids = calloc(prog_info.nr_map_ids, sizeof(__u32));
+	if (!map_ids)
+		return -ENOMEM;
+
+	nr_maps = prog_info.nr_map_ids;
+	memset(&prog_info, 0, sizeof(prog_info));
+	prog_info.nr_map_ids = nr_maps;
+	prog_info.map_ids = ptr_to_u64(map_ids);
+	prog_info_len = sizeof(prog_info);
+
+	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	if (ret) {
+		ret = -errno;
+		goto free_map_ids;
+	}
+
+	ret = -ENOENT;
+	for (i = 0; i < prog_info.nr_map_ids; i++) {
+		if (map_ids[i] == map_info.id) {
+			ret = 0;
+			break;
+		}
+	}
+
+free_map_ids:
+	free(map_ids);
+	return ret;
+}
+
+static void test_metadata_unused(void)
+{
+	struct metadata_unused *obj;
+	int err;
+
+	obj = metadata_unused__open_and_load();
+	if (CHECK(!obj, "skel-load", "errno %d", errno))
+		return;
+
+	err = prog_holds_map(bpf_program__fd(obj->progs.prog),
+			     bpf_map__fd(obj->maps.rodata));
+	if (CHECK(err, "prog-holds-rodata", "errno: %d", err))
+		return;
+
+	/* Assert that we can access the metadata in skel and the values are
+	 * what we expect.
+	 */
+	if (CHECK(strncmp(obj->rodata->bpf_metadata_a, "foo",
+			  sizeof(obj->rodata->bpf_metadata_a)),
+		  "bpf_metadata_a", "expected \"foo\", value differ"))
+		goto close_bpf_object;
+	if (CHECK(obj->rodata->bpf_metadata_b != 1, "bpf_metadata_b",
+		  "expected 1, got %d", obj->rodata->bpf_metadata_b))
+		goto close_bpf_object;
+
+	/* Assert that binding metadata map to prog again succeeds. */
+	err = bpf_prog_bind_map(bpf_program__fd(obj->progs.prog),
+				bpf_map__fd(obj->maps.rodata), NULL);
+	CHECK(err, "rebind_map", "errno %d, expected 0", errno);
+
+close_bpf_object:
+	metadata_unused__destroy(obj);
+}
+
+static void test_metadata_used(void)
+{
+	struct metadata_used *obj;
+	int err;
+
+	obj = metadata_used__open_and_load();
+	if (CHECK(!obj, "skel-load", "errno %d", errno))
+		return;
+
+	err = prog_holds_map(bpf_program__fd(obj->progs.prog),
+			     bpf_map__fd(obj->maps.rodata));
+	if (CHECK(err, "prog-holds-rodata", "errno: %d", err))
+		return;
+
+	/* Assert that we can access the metadata in skel and the values are
+	 * what we expect.
+	 */
+	if (CHECK(strncmp(obj->rodata->bpf_metadata_a, "bar",
+			  sizeof(obj->rodata->bpf_metadata_a)),
+		  "metadata_a", "expected \"bar\", value differ"))
+		goto close_bpf_object;
+	if (CHECK(obj->rodata->bpf_metadata_b != 2, "metadata_b",
+		  "expected 2, got %d", obj->rodata->bpf_metadata_b))
+		goto close_bpf_object;
+
+	/* Assert that binding metadata map to prog again succeeds. */
+	err = bpf_prog_bind_map(bpf_program__fd(obj->progs.prog),
+				bpf_map__fd(obj->maps.rodata), NULL);
+	CHECK(err, "rebind_map", "errno %d, expected 0", errno);
+
+close_bpf_object:
+	metadata_used__destroy(obj);
+}
+
+void test_metadata(void)
+{
+	if (test__start_subtest("unused"))
+		test_metadata_unused();
+
+	if (test__start_subtest("used"))
+		test_metadata_used();
+}
diff --git a/tools/testing/selftests/bpf/progs/metadata_unused.c b/tools/testing/selftests/bpf/progs/metadata_unused.c
new file mode 100644
index 000000000000..672a0d19f8d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/metadata_unused.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+volatile const char bpf_metadata_a[] SEC(".rodata") = "foo";
+volatile const int bpf_metadata_b SEC(".rodata") = 1;
+
+SEC("cgroup_skb/egress")
+int prog(struct xdp_md *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/metadata_used.c b/tools/testing/selftests/bpf/progs/metadata_used.c
new file mode 100644
index 000000000000..b7198e65383d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/metadata_used.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+volatile const char bpf_metadata_a[] SEC(".rodata") = "bar";
+volatile const int bpf_metadata_b SEC(".rodata") = 2;
+
+SEC("cgroup_skb/egress")
+int prog(struct xdp_md *ctx)
+{
+	return bpf_metadata_b ? 1 : 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_bpftool_metadata.sh b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
new file mode 100755
index 000000000000..1bf81b49457a
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+TESTNAME=bpftool_metadata
+BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
+BPF_DIR=$BPF_FS/test_$TESTNAME
+
+_cleanup()
+{
+	set +e
+	rm -rf $BPF_DIR 2> /dev/null
+}
+
+cleanup_skip()
+{
+	echo "selftests: $TESTNAME [SKIP]"
+	_cleanup
+
+	exit $ksft_skip
+}
+
+cleanup()
+{
+	if [ "$?" = 0 ]; then
+		echo "selftests: $TESTNAME [PASS]"
+	else
+		echo "selftests: $TESTNAME [FAILED]"
+	fi
+	_cleanup
+}
+
+if [ $(id -u) -ne 0 ]; then
+	echo "selftests: $TESTNAME [SKIP] Need root privileges"
+	exit $ksft_skip
+fi
+
+if [ -z "$BPF_FS" ]; then
+	echo "selftests: $TESTNAME [SKIP] Could not run test without bpffs mounted"
+	exit $ksft_skip
+fi
+
+if ! bpftool version > /dev/null 2>&1; then
+	echo "selftests: $TESTNAME [SKIP] Could not run test without bpftool"
+	exit $ksft_skip
+fi
+
+set -e
+
+trap cleanup_skip EXIT
+
+mkdir $BPF_DIR
+
+trap cleanup EXIT
+
+bpftool prog load metadata_unused.o $BPF_DIR/unused
+
+METADATA_PLAIN="$(bpftool prog)"
+echo "$METADATA_PLAIN" | grep 'a = "foo"' > /dev/null
+echo "$METADATA_PLAIN" | grep 'b = 1' > /dev/null
+
+bpftool prog --json | grep '"metadata":{"a":"foo","b":1}' > /dev/null
+
+bpftool map | grep 'metadata.rodata' > /dev/null
+
+rm $BPF_DIR/unused
+
+bpftool prog load metadata_used.o $BPF_DIR/used
+
+METADATA_PLAIN="$(bpftool prog)"
+echo "$METADATA_PLAIN" | grep 'a = "bar"' > /dev/null
+echo "$METADATA_PLAIN" | grep 'b = 2' > /dev/null
+
+bpftool prog --json | grep '"metadata":{"a":"bar","b":2}' > /dev/null
+
+bpftool map | grep 'metadata.rodata' > /dev/null
+
+rm $BPF_DIR/used
+
+exit 0
-- 
2.28.0.618.gf4bc123cb7-goog

