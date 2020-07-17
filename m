Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B32222FD9
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 02:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgGQAQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 20:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgGQAQz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7981C061755
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p205so8333124iod.8
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx06PrtWwrmuUpUzLQRfCLq3oYG7PmzNPdENRnSUpIU=;
        b=R/QyUFBaZrm/R0fhoexAHhVxV6dto6HFbymJmuexeChG2KFYIYNqOzPIK8ysMyw4Ap
         VkFoHlAPp9HlrDu9vt5OzUrj6c6VEk5NXeYEuHgoppqF3kGuvGFFttBINeQd57aKCoPI
         dtSFDCzo3oj+vuYMYWyYMdTKZ9yR4pRHLXY6GR8FssKzPZiIbKdbSiJe+1LieSO6yZ6E
         HizLOywggnvCYUjf6yE2XMEDKc/s0sAs/OaBDR4EyppU2S+WSPMvORMDkzuHy7DgbcD/
         B0XBJwJMhfrH5HkIyj3eBwlexmmfFr1iGvK4epE6XbtEB2ZWBqA+0+CfoZ9E8Eevfwc7
         wGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx06PrtWwrmuUpUzLQRfCLq3oYG7PmzNPdENRnSUpIU=;
        b=HRB8G0+/bXCWEOD6VXEYlcEf1yD9NwGk0I0UVlcB7bbF8w2fz7BB51GMV6qG5dkteR
         lSxRO9XV1+LCbzW3ISUIY20hRmdxwTCRdox5e4LU99Oma2ZT6OzJ/WQmIGk1HXFVAjHo
         zmFChwKEXEPI5FY61WWLOayxtKXzL2FIssU97x8be2FNVrtCzgViz4gUeGE4ia3P6EXj
         DT5ykM6TXeyaTSB4mXuwImv1dqQ/asdZ59ofooe7+X8GIihcQ5h7UADtmDzHRqWQDjn3
         k/1kPM4D2UQKla53owhFRrPTHSyodAzUJH74Lf9L3oPOMrhwswuxzKPSYQDVkv4Ia0Tq
         FsUw==
X-Gm-Message-State: AOAM530wtvWy2gGX1iBwJgARb+zXm5vNwUc99+lSxpKKON02AHVtKJcp
        rfp4Rq5u+QtvfdP28zOVfu/vcKpE721u9Q==
X-Google-Smtp-Source: ABdhPJwObsg5np6gZyfu6YYu8o8a2oRcLVUSMWnxloySX9ihf236OEkFmTu3hxZhfsLRmAP99WsLdA==
X-Received: by 2002:a6b:c889:: with SMTP id y131mr7034504iof.194.1594945014812;
        Thu, 16 Jul 2020 17:16:54 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id m5sm3427493ilg.18.2020.07.16.17.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:54 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v3 bpf-next 2/5] selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
Date:   Thu, 16 Jul 2020 19:16:26 -0500
Message-Id: <4d599c413264a61edd2ad224ba9c2be135753efb.1594944827.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594944827.git.zhuyifei@google.com>
References: <cover.1594944827.git.zhuyifei@google.com>
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

