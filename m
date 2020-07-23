Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6691122A9BF
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 09:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGWHlI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGWHlH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 03:41:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD83C0619DC
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:07 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id o3so3506680ilo.12
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx06PrtWwrmuUpUzLQRfCLq3oYG7PmzNPdENRnSUpIU=;
        b=luRvkaC5OhMJ52ApdqG8gqJ0uaq79S+MQQIeSlillDe3aqpbVg+ycUWO8XSeR2+9Oc
         nzNiXJf+hrA3l+IE6+x8w7XoljCxCp+zqraHRwioZuSeAPY9v5nSJowGrZ5gnpfubPOP
         e8FbCm7yQO5vzPg4QZUsbeMOxLV8IIzkeb5nODixpXzHGAnXxmvVKyuWagXIOsampOsR
         F8xBcPfJgz8IM+4847QhNOVIOW9l6cDOAuPn3WjUsBS4IjaYppG8bTIq1pzlfZS82k5m
         XbVaIGJ6CwTUDxwTreeasCf7rtMHVLkRCWk/w6lR1u/Yjxj7H3Hl/IOEsxUarEKpKA4y
         j7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx06PrtWwrmuUpUzLQRfCLq3oYG7PmzNPdENRnSUpIU=;
        b=udm9Esdc4uq+YueNcdnu6/nnDlItdi9FI671R3YcyyyyJHJmUS5sFTa0Jf2N6lnB30
         VhZdjYNr7AYvQku2gVatOv2fvV96h3OpnVA29QciZLoM69YL/8np1zltylkYG3hL2+Yv
         3c+kuaQ1dB6hsSkMBwypXPbYTiYmX5+z22rASStUqmI08qY5ZuYfxWenPiEcxCI+fd5r
         uIWiQ9M28xKNrnLoWilWeXIc2TUPfo3oDnrynmIdp4K01uYLgE9a2fwMgUQDqnLpdgTQ
         uDO8hPGqd04KfCdJ0cnTs0Fm/rqOJ6l/BudsAdDdwsWWntjVN0OTntq8B87EXNaG+9WI
         tgQg==
X-Gm-Message-State: AOAM533KuarWTUw+aY90ADDv5QAeRHPhQCbqQNDi0THggjQOK5M76/a1
        NpXbGacQkyeudKH0+8caK331iMxXQXwmkw==
X-Google-Smtp-Source: ABdhPJwgPlm1HuhxNOOHKEHGTLJSYSIXuscDYjmJhvgT+F+Y1/wrb/l8NVTmNs9wrgcVGZwJj5wCQg==
X-Received: by 2002:a92:d206:: with SMTP id y6mr3808411ily.162.1595490066451;
        Thu, 23 Jul 2020 00:41:06 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id c9sm1035552ilm.57.2020.07.23.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:41:05 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 2/5] selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
Date:   Thu, 23 Jul 2020 02:40:55 -0500
Message-Id: <16989c2daceb609f6538f132987a66a84aa2032a.1595489786.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595489786.git.zhuyifei@google.com>
References: <cover.1595489786.git.zhuyifei@google.com>
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

