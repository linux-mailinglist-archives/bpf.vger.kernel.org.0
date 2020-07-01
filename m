Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6442115AD
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 00:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGAWOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 18:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgGAWOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC9C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 15:14:18 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a6so5732205ilq.13
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFpXKOKBYU5inQ2HfJmJl6hKO8uVwGG4S8htXWjVjbU=;
        b=K/CO+amzcvP+2Oo19JNMdRspjqV0osk7yEfW/U9fJ6VoPBU0a0U4S5XP31XeeOwLbF
         99k8Ip2Lr2bn9U5uJAFDFY3AppOK+1AQtezwZKphiS4Yo4VOHl89pDHBufCzrH7vOI+H
         qZXCHfB2/qS7Ys3t8IZR3UEJ8PHgB7NXkBKjXdVsVhTPSp+3hJJAPNZm/lp0vQT5HICf
         H6ODg4XJ1nfhUyeRVrFCynnikGfmDaW9dKgfSa6voja3jYPI1ooNSCGFCngRWAhI3dTr
         8nH0Oe48+LEIBeENlV2utITEOZShTmQzAYSVZNQ40xd2TmoP9Jf2AdP+0enmZ1p+NsXE
         7l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFpXKOKBYU5inQ2HfJmJl6hKO8uVwGG4S8htXWjVjbU=;
        b=qJ8rTUnTsS1XR5/+cEWGpnoVLxSpZC+fRvCByv1jPH/ADMFcsUuRL30ouQJg1tC4Bx
         /CWz8+lgNtnKmVxk0WzaEBqPrP5jIBYHdf5TYLEdpzXgTxGtyYrJXqqGzASFasnNybZC
         e8+RsCjMIDBK6ja86A6RHyS7SHGf7snhwfFOmZjfLpqO4hENEUyVjzxO04KKu6nLEmjw
         wQtsR3qXPruVH4pUPK/AL13bm8pKw5+TR7sUqdWkTSzWCjI5OawUc4yo5za1nMFo/8q0
         nvowoDMZQw1F8ll+iOis+Q5U8alP+sGs0OFx5vu/+7OfMWfrPv61jrIFnNVcmHE8v/QI
         XdVA==
X-Gm-Message-State: AOAM530DGZe5KLMmBjlfXyU0PXF0l/spVTHpIvKe/vTxDS6jiBF4ajnr
        PBzcyMBHks1M4WiZswRznnBa+0p8KMwSHA==
X-Google-Smtp-Source: ABdhPJxe/T1xZe3pUvJIpG/UvCa/eAwDM0Oke1WHsfRrpuLY0sEolxkhUE2dJK4k8FWouSuWw4WpnQ==
X-Received: by 2002:a92:cb03:: with SMTP id s3mr9959402ilo.1.1593641657543;
        Wed, 01 Jul 2020 15:14:17 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id t83sm4051543ilb.47.2020.07.01.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:14:17 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 2/5] selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
Date:   Wed,  1 Jul 2020 17:13:55 -0500
Message-Id: <5dd7a327de5dfc3a0f9cf36235d562fd61d10bf4.1593638618.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593638618.git.zhuyifei@google.com>
References: <cover.1593638618.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

The current assumption is that the lifetime of a cgroup storage
is tied to the program's attachment. The storage is created in
cgroup_bpf_attach, and released upon cgroup_bpf_detach and
cgroup_bpf_release.

Because the current semantics is that each attachment gets a
completely independent cgroup storage, and you can have multiple
programs attached to the same (cgroup, attach type) pair, the key
of the CGROUP_STORAGE map, looking up the map with this pair could
yield multiple storages, and that is not permitted. Therefore,
the kernel verifier checks that two programs cannot share the same
CGROUP_STORAGE map, even if they have different expected attach
types, considering that the actual attach type does not always
have to be equal to the expected attach type.

The test creates a CGROUP_STORAGE map and make it shared across
two different programs, one cgroup_skb/egress and one /ingress.
It asserts that the two programs cannot be both loaded, due to
verifier failure from the above reason.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/cg_storage_multi.c         | 37 ++++++++++++---
 .../selftests/bpf/progs/cg_storage_multi.h    | 13 ++++++
 .../progs/cg_storage_multi_egress_ingress.c   | 45 +++++++++++++++++++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  9 ++--
 4 files changed, 94 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 69d29092e7c8..140fb42929b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -8,16 +8,19 @@
 #include <cgroup_helpers.h>
 #include <network_helpers.h>
 
+#include "progs/cg_storage_multi.h"
+
 #include "cg_storage_multi_egress_only.skel.h"
+#include "cg_storage_multi_egress_ingress.skel.h"
 
 #define PARENT_CGROUP "/cgroup_storage"
 #define CHILD_CGROUP "/cgroup_storage/child"
 
 static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
-			   __u32 expected)
+			   struct cgroup_value *expected)
 {
 	struct bpf_cgroup_storage_key key = {0};
-	__u32 value;
+	struct cgroup_value value;
 	int map_fd;
 
 	map_fd = bpf_map__fd(map);
@@ -26,7 +29,7 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 	key.attach_type = BPF_CGROUP_INET_EGRESS;
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value) < 0))
 		return true;
-	if (CHECK_FAIL(value != expected))
+	if (CHECK_FAIL(memcmp(&value, expected, sizeof(struct cgroup_value))))
 		return true;
 
 	return false;
@@ -35,7 +38,7 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
 {
 	struct bpf_cgroup_storage_key key = {0};
-	__u32 value;
+	struct cgroup_value value;
 	int map_fd;
 
 	map_fd = bpf_map__fd(map);
@@ -80,6 +83,7 @@ static bool connect_send(const char *cgroup_path)
 static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 {
 	struct cg_storage_multi_egress_only *obj;
+	struct cgroup_value expected_cgroup_value;
 	int err;
 
 	if (!test__start_subtest("egress_only"))
@@ -104,8 +108,9 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 		goto close_bpf_object;
 	if (CHECK_FAIL(obj->bss->invocations != 1))
 		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
 	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
-				      PARENT_CGROUP, 1)))
+				      PARENT_CGROUP, &expected_cgroup_value)))
 		goto close_bpf_object;
 	if (CHECK_FAIL(assert_storage_noexist(obj->maps.cgroup_storage,
 					      CHILD_CGROUP)))
@@ -126,17 +131,34 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 		goto close_bpf_object;
 	if (CHECK_FAIL(obj->bss->invocations != 3))
 		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 2 };
 	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
-				      PARENT_CGROUP, 2)))
+				      PARENT_CGROUP, &expected_cgroup_value)))
 		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
 	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
-				      CHILD_CGROUP, 1)))
+				      CHILD_CGROUP, &expected_cgroup_value)))
 		goto close_bpf_object;
 
 close_bpf_object:
 	cg_storage_multi_egress_only__destroy(obj);
 }
 
+static void test_egress_ingress(int parent_cgroup_fd, int child_cgroup_fd)
+{
+	struct cg_storage_multi_egress_ingress *obj;
+
+	if (!test__start_subtest("egress_ingress"))
+		return;
+
+	/* Cannot load both programs due to verifier failure:
+	 * "only one cgroup storage of each type is allowed"
+	 */
+	obj = cg_storage_multi_egress_ingress__open_and_load();
+	if (CHECK_FAIL(obj || errno != EBUSY))
+		return;
+}
+
 void test_cg_storage_multi(void)
 {
 	int parent_cgroup_fd, child_cgroup_fd;
@@ -147,6 +169,7 @@ void test_cg_storage_multi(void)
 		goto close_cgroup_fd;
 
 	test_egress_only(parent_cgroup_fd, child_cgroup_fd);
+	test_egress_ingress(parent_cgroup_fd, child_cgroup_fd);
 
 close_cgroup_fd:
 	close(child_cgroup_fd);
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi.h b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
new file mode 100644
index 000000000000..a0778fe7857a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __PROGS_CG_STORAGE_MULTI_H
+#define __PROGS_CG_STORAGE_MULTI_H
+
+#include <asm/types.h>
+
+struct cgroup_value {
+	__u32 egress_pkts;
+	__u32 ingress_pkts;
+};
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c b/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
new file mode 100644
index 000000000000..9ce386899365
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <errno.h>
+#include <linux/bpf.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <bpf/bpf_helpers.h>
+
+#include "progs/cg_storage_multi.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, struct cgroup_value);
+} cgroup_storage SEC(".maps");
+
+__u32 invocations = 0;
+
+SEC("cgroup_skb/egress")
+int egress(struct __sk_buff *skb)
+{
+	struct cgroup_value *ptr_cg_storage =
+		bpf_get_local_storage(&cgroup_storage, 0);
+
+	__sync_fetch_and_add(&ptr_cg_storage->egress_pkts, 1);
+	__sync_fetch_and_add(&invocations, 1);
+
+	return 1;
+}
+
+SEC("cgroup_skb/ingress")
+int ingress(struct __sk_buff *skb)
+{
+	struct cgroup_value *ptr_cg_storage =
+		bpf_get_local_storage(&cgroup_storage, 0);
+
+	__sync_fetch_and_add(&ptr_cg_storage->ingress_pkts, 1);
+	__sync_fetch_and_add(&invocations, 1);
+
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c b/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
index ec0165d07105..44ad46b33539 100644
--- a/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
@@ -10,10 +10,12 @@
 #include <linux/udp.h>
 #include <bpf/bpf_helpers.h>
 
+#include "progs/cg_storage_multi.h"
+
 struct {
 	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__type(key, struct bpf_cgroup_storage_key);
-	__type(value, __u32);
+	__type(value, struct cgroup_value);
 } cgroup_storage SEC(".maps");
 
 __u32 invocations = 0;
@@ -21,9 +23,10 @@ __u32 invocations = 0;
 SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
 {
-	__u32 *ptr_cg_storage = bpf_get_local_storage(&cgroup_storage, 0);
+	struct cgroup_value *ptr_cg_storage =
+		bpf_get_local_storage(&cgroup_storage, 0);
 
-	__sync_fetch_and_add(ptr_cg_storage, 1);
+	__sync_fetch_and_add(&ptr_cg_storage->egress_pkts, 1);
 	__sync_fetch_and_add(&invocations, 1);
 
 	return 1;
-- 
2.27.0

