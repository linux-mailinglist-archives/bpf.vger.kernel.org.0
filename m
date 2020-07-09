Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9A521AAFF
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGIWzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIWzM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 18:55:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F68AC08C5CE
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 15:55:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y2so4100743ioy.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx06PrtWwrmuUpUzLQRfCLq3oYG7PmzNPdENRnSUpIU=;
        b=idpjp6pHzTWxDTn+GoQOhTkSfuNrnDg+A1t6rC8jIhKv7TCllvsjABBdO1rH1IqSeR
         VEkXCTWRrLka0POKc0iDphR68EaHHQ+uOQa7jpfi2mQzEJ9LAHtUOLGj0T1lUbYaey6b
         o51+n74OP6FembDEYpcDhB93wmISZFYki8Kd6ql4u3lkBleh2b4LP+Amciy40YIcvY6X
         a6WUF5ISoqTF8hGWAGoxSTDGiFrhKwsZGg+uIwWcw8G2Xmf8V2GoSaUHJYzGQ/3cdfk3
         6mRrk3nfuyPtWH1ymxjhNNFFiAB4jnAj0nm0rZxwNx91IsqVRVqmEKgVcZKTYLZk2Hjx
         vjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx06PrtWwrmuUpUzLQRfCLq3oYG7PmzNPdENRnSUpIU=;
        b=t0qBnJs50wq4HcA9feyuIp+Vt1h281j+qpl3Jk2cqa7/cZjJyZJg29jtkT6iYD7ruP
         kzTmnnZWTf2r5z7urNvp45aC9ojSRxr/KguMWDdHO/tOTLpxA3bz7MePrzwOuR/aKUhW
         I3lymL4BG815f+9Lfl6RweuRYc2tkzVPRbXeLKz+ef0Hibu0c73SvErR2OiBTVqEjFpz
         NNeVI3rskbzy37cQPTpG6a7szNQ4leLUgnRK22sP0JpXkT2baaHgD4M0NM1NlfXuapIj
         E8190a3BNPja91yT5kp2lfkKVJSq3rpSAmrRtXS7HcC9YfE5+nsghdpsNhCralnkcV4q
         L/Rg==
X-Gm-Message-State: AOAM5338jdQLsp76UGw/+qt7nVP9W8ItRRiM2Td72T2xP1alEosr4vo1
        WS71d4MYv1vqqD1/xm1R33FEfGTij7aKyw==
X-Google-Smtp-Source: ABdhPJxBQVHoJLzEXSs8ZavYb2JeBRYbKfIOzVag18NCxkCJ2SjeJGOLjs6bP10Yka1dICg1JOtkbg==
X-Received: by 2002:a5d:96d7:: with SMTP id r23mr44622230iol.126.1594335311377;
        Thu, 09 Jul 2020 15:55:11 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id q2sm2552416ilp.82.2020.07.09.15.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:55:10 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v2 bpf-next 2/5] selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
Date:   Thu,  9 Jul 2020 17:54:48 -0500
Message-Id: <ac2a1b112483f8f9e0dea66036111fde56a14ba3.1594333800.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594333800.git.zhuyifei@google.com>
References: <cover.1594333800.git.zhuyifei@google.com>
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
 .../bpf/prog_tests/cg_storage_multi.c         | 42 +++++++++++++----
 .../selftests/bpf/progs/cg_storage_multi.h    | 13 ++++++
 .../progs/cg_storage_multi_egress_ingress.c   | 45 +++++++++++++++++++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  9 ++--
 4 files changed, 98 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 6d5a2194e036..1f4ab437ddb9 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -8,7 +8,10 @@
 #include <cgroup_helpers.h>
 #include <network_helpers.h>
 
+#include "progs/cg_storage_multi.h"
+
 #include "cg_storage_multi_egress_only.skel.h"
+#include "cg_storage_multi_egress_ingress.skel.h"
 
 #define PARENT_CGROUP "/cgroup_storage"
 #define CHILD_CGROUP "/cgroup_storage/child"
@@ -16,10 +19,10 @@
 static int duration;
 
 static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
-			   __u32 expected)
+			   struct cgroup_value *expected)
 {
 	struct bpf_cgroup_storage_key key = {0};
-	__u32 value;
+	struct cgroup_value value;
 	int map_fd;
 
 	map_fd = bpf_map__fd(map);
@@ -29,8 +32,8 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) < 0,
 		  "map-lookup", "errno %d", errno))
 		return true;
-	if (CHECK(value != expected,
-		  "assert-storage", "got %u expected %u", value, expected))
+	if (CHECK(memcmp(&value, expected, sizeof(struct cgroup_value)),
+		  "assert-storage", "storages differ"))
 		return true;
 
 	return false;
@@ -39,7 +42,7 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
 {
 	struct bpf_cgroup_storage_key key = {0};
-	__u32 value;
+	struct cgroup_value value;
 	int map_fd;
 
 	map_fd = bpf_map__fd(map);
@@ -86,6 +89,7 @@ static bool connect_send(const char *cgroup_path)
 static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 {
 	struct cg_storage_multi_egress_only *obj;
+	struct cgroup_value expected_cgroup_value;
 	struct bpf_link *parent_link = NULL, *child_link = NULL;
 	bool err;
 
@@ -109,7 +113,9 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 	if (CHECK(obj->bss->invocations != 1,
 		  "first-invoke", "invocations=%d", obj->bss->invocations))
 		goto close_bpf_object;
-	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 1))
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   PARENT_CGROUP, &expected_cgroup_value))
 		goto close_bpf_object;
 	if (assert_storage_noexist(obj->maps.cgroup_storage, CHILD_CGROUP))
 		goto close_bpf_object;
@@ -129,9 +135,13 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 	if (CHECK(obj->bss->invocations != 3,
 		  "second-invoke", "invocations=%d", obj->bss->invocations))
 		goto close_bpf_object;
-	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 2))
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 2 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   PARENT_CGROUP, &expected_cgroup_value))
 		goto close_bpf_object;
-	if (assert_storage(obj->maps.cgroup_storage, CHILD_CGROUP, 1))
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   CHILD_CGROUP, &expected_cgroup_value))
 		goto close_bpf_object;
 
 close_bpf_object:
@@ -143,6 +153,19 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 	cg_storage_multi_egress_only__destroy(obj);
 }
 
+static void test_egress_ingress(int parent_cgroup_fd, int child_cgroup_fd)
+{
+	struct cg_storage_multi_egress_ingress *obj;
+
+	/* Cannot load both programs due to verifier failure:
+	 * "only one cgroup storage of each type is allowed"
+	 */
+	obj = cg_storage_multi_egress_ingress__open_and_load();
+	if (CHECK(obj || errno != EBUSY,
+		  "skel-load", "errno %d, expected EBUSY", errno))
+		return;
+}
+
 void test_cg_storage_multi(void)
 {
 	int parent_cgroup_fd = -1, child_cgroup_fd = -1;
@@ -157,6 +180,9 @@ void test_cg_storage_multi(void)
 	if (test__start_subtest("egress_only"))
 		test_egress_only(parent_cgroup_fd, child_cgroup_fd);
 
+	if (test__start_subtest("egress_ingress"))
+		test_egress_ingress(parent_cgroup_fd, child_cgroup_fd);
+
 close_cgroup_fd:
 	close(child_cgroup_fd);
 	close(parent_cgroup_fd);
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

