Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B82160B1
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGFUyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFUyN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 16:54:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF7EC061755
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 13:54:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a6so17399632ilq.13
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSrlpH4HSsfJcVSLE4a6+tSmqYODYPfH33FwVBIhULk=;
        b=GDwtiiyjFwo1JHvylgf++TQcmtO3IuYultuZSYBQIY9fan4NPlkA8GHDhFvSDMUm2B
         EgJBaIGbYSkadlD99qr9T94qArC5OKkCiLepLB7kIcuNT5XG7BklEvJwK0aW4DwDaX/P
         Tq9UL1hQEa+oCiOQx9APap012lUoRVBoti/AxlY0kx+X2BjCxGdl6OyheMAxo+8GiN4e
         6hEAKy7ZnEKRFecdXTK42MzJLGdvgiroj3GA0aTuP1oUn6VzH55Dtm+eMDacq1D5noci
         mBpI5mAg5jUKqHR3eFloqDsNmdpXDDJoy868GL4HLzbY+wiGgraxNdjksNdvO0hU3s4J
         3NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSrlpH4HSsfJcVSLE4a6+tSmqYODYPfH33FwVBIhULk=;
        b=Jlbn/qD8HH81psfKO3gfEm9bQTyMIsVM2tPFZiJXm3Q8onbgbqDGBaCbxNtz+QTwgp
         vbBwXtkeh7pdRb3RakPoXpqIE+3NxeF0svoWkS7YcYaKT7IOmZg2PHuGGUwUEFs1yrH6
         Teqp7bHex7KgpcmQ6kAza8DjzfXIzUN4bC5Y3JceEeyQitV0G9Ig88r7w9jw6Z1jc3bk
         vu2yPihEuVVCkLqkqWRmkjYKax0gg84Iw5t36RVVh/Mac+B4Q22FrK4oHMV/YLCjetMf
         m2qRzdnKWB42rZq9EHJru8a9C2zMWNBRw6tXpe6Htnr6CzZWa204sRl2RkGuaUEcpot2
         Fc4w==
X-Gm-Message-State: AOAM533fC8OYT6FcyX9g9leSuv2fBpjJ2GrnvQWIoAqsjnM7NOJaSlAd
        tJGx428qNl6fRMvqwRbPW4d2nsL6rkQ=
X-Google-Smtp-Source: ABdhPJytrolUtIZSW+CX+rlk3BWaLElcfrYyAj5pTp7OYqCEsbiH0nYz5v96hS8Hr42dLGGF7L1bJA==
X-Received: by 2002:a05:6e02:4ce:: with SMTP id f14mr31695987ils.2.1594068852909;
        Mon, 06 Jul 2020 13:54:12 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id r124sm10744198iod.40.2020.07.06.13.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:54:12 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 2/5] selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
Date:   Mon,  6 Jul 2020 15:51:19 -0500
Message-Id: <1ee7ac24911b161b048f1221ed35932126fe0e95.1594065127.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594065127.git.zhuyifei@google.com>
References: <cover.1594065127.git.zhuyifei@google.com>
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
index fee34a0ef862..6738b18835d5 100644
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

