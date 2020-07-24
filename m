Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD31822BD26
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 06:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGXEsL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 00:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXEsK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 00:48:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB8C0619D3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so8570542ioh.5
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXOKvlwlEgNe3D+2Pe4FQ/xIp0HVqAb8ItJZi7CfaJo=;
        b=U3ApqwJCna/j/KTJEbz76mFv4H5WQFT/UpwwPk16JgxM8Y+tihi+vcyKWnRJSi7OkB
         gVXzUeVtX0fUyWUgibMb7KX6tLwUIrMPpM61V8VAr0/10RcKUkgMhx3sAy6gpIkNv2Cc
         AYLzi7w4VMlKerH14haU2nO83BPf8ugToQV2OPHYxF+pMXVCBwH8vPxUopue/7QLBy7f
         w+iSO4H/yQqym8wwc3uudAj5an9N8ajXCUIBGwQ1LekBYNLkw1wsp+9oyN+vpWuMGQ5M
         /q+lNsc7aiC5mqI3M34seibzSkeAezir84X8Qts58Lqac0iKaUaSxgBUxBz6qfVlUsFN
         a6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXOKvlwlEgNe3D+2Pe4FQ/xIp0HVqAb8ItJZi7CfaJo=;
        b=oFO0urCKTZ+ZikOvMhADLdMSOz4Cs/iHgYgaEFXgWrusUxaSP4l0Q0Hu5liFZqZAch
         5mIkyrKTtv3KPxhofpu9Y2jDtg+3yuxwW3rvDwGjVx6EYBrB3AWEQBsMDkOG/X0CEFdW
         BFOiDaeXSFvbt63euphKDF8nn2x6ORsbGJc38qAWETxLMTiu22jNz2OY6vjrufR9+Zej
         FHx/TUCWY5uczF1OcGpJGP31XAoMi5Gt/Z5fiVGBrgN1uA31UX+Lb73MqQ8YlHI/rEux
         2QNHMOVWzMevsc+s+T/I/42E9ugF1OqgVzkPsDo2jT2Vp/o+zdNqD1JnNU1cOjV1Jf7P
         iwBg==
X-Gm-Message-State: AOAM533NaoKRcKHsvl64u46SLrSfaukf3VR9qDewFk08cIFmO6eZWM8S
        QwWvv9dtW7VBDAxdFAk7u1fN5QHCZo9Zzw==
X-Google-Smtp-Source: ABdhPJzQ2ZYxYx1S0tZcmhXjud3C3z55KkbFVV8h9hbJb9xAGXB2H/XjA7KFFgmHZG+OP1Sf+aFsig==
X-Received: by 2002:a6b:7416:: with SMTP id s22mr8424056iog.160.1595566089579;
        Thu, 23 Jul 2020 21:48:09 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id o64sm2686579ilb.12.2020.07.23.21.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 21:48:09 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 4/5] selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
Date:   Thu, 23 Jul 2020 23:47:44 -0500
Message-Id: <c756f5f1521227b8e6e90a453299dda722d7324d.1595565795.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595565795.git.zhuyifei@google.com>
References: <cover.1595565795.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This mirrors the original egress-only test. The cgroup_storage is
now extended to have two packet counters, one for egress and one
for ingress. We also extend to have two egress programs to test
that egress will always share with other egress origrams in the
same cgroup. The behavior of the counters are exactly the same as
the original egress-only test.

The test is split into two, one "isolated" test that when the key
type is struct bpf_cgroup_storage_key, which contains the attach
type, programs of different attach types will see different
storages. The other, "shared" test that when the key type is u64,
programs of different attach types will see the same storage if
they are attached to the same cgroup.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/cg_storage_multi.c         | 265 ++++++++++++++++--
 ..._ingress.c => cg_storage_multi_isolated.c} |  16 +-
 .../bpf/progs/cg_storage_multi_shared.c       |  57 ++++
 3 files changed, 311 insertions(+), 27 deletions(-)
 rename tools/testing/selftests/bpf/progs/{cg_storage_multi_egress_ingress.c => cg_storage_multi_isolated.c} (73%)
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 1c7653423698..c67d8c076a34 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -11,25 +11,23 @@
 #include "progs/cg_storage_multi.h"
 
 #include "cg_storage_multi_egress_only.skel.h"
-#include "cg_storage_multi_egress_ingress.skel.h"
+#include "cg_storage_multi_isolated.skel.h"
+#include "cg_storage_multi_shared.skel.h"
 
 #define PARENT_CGROUP "/cgroup_storage"
 #define CHILD_CGROUP "/cgroup_storage/child"
 
 static int duration;
 
-static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
+static bool assert_storage(struct bpf_map *map, const void *key,
 			   struct cgroup_value *expected)
 {
-	struct bpf_cgroup_storage_key key = {0};
 	struct cgroup_value value;
 	int map_fd;
 
 	map_fd = bpf_map__fd(map);
 
-	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
-	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) < 0,
+	if (CHECK(bpf_map_lookup_elem(map_fd, key, &value) < 0,
 		  "map-lookup", "errno %d", errno))
 		return true;
 	if (CHECK(memcmp(&value, expected, sizeof(struct cgroup_value)),
@@ -39,17 +37,14 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 	return false;
 }
 
-static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
+static bool assert_storage_noexist(struct bpf_map *map, const void *key)
 {
-	struct bpf_cgroup_storage_key key = {0};
 	struct cgroup_value value;
 	int map_fd;
 
 	map_fd = bpf_map__fd(map);
 
-	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
-	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) == 0,
+	if (CHECK(bpf_map_lookup_elem(map_fd, key, &value) == 0,
 		  "map-lookup", "succeeded, expected ENOENT"))
 		return true;
 	if (CHECK(errno != ENOENT,
@@ -90,9 +85,12 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 {
 	struct cg_storage_multi_egress_only *obj;
 	struct cgroup_value expected_cgroup_value;
+	struct bpf_cgroup_storage_key key;
 	struct bpf_link *parent_link = NULL, *child_link = NULL;
 	bool err;
 
+	key.attach_type = BPF_CGROUP_INET_EGRESS;
+
 	obj = cg_storage_multi_egress_only__open_and_load();
 	if (CHECK(!obj, "skel-load", "errno %d", errno))
 		return;
@@ -113,11 +111,13 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 	if (CHECK(obj->bss->invocations != 1,
 		  "first-invoke", "invocations=%d", obj->bss->invocations))
 		goto close_bpf_object;
+	key.cgroup_inode_id = get_cgroup_id(PARENT_CGROUP);
 	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
 	if (assert_storage(obj->maps.cgroup_storage,
-			   PARENT_CGROUP, &expected_cgroup_value))
+			   &key, &expected_cgroup_value))
 		goto close_bpf_object;
-	if (assert_storage_noexist(obj->maps.cgroup_storage, CHILD_CGROUP))
+	key.cgroup_inode_id = get_cgroup_id(CHILD_CGROUP);
+	if (assert_storage_noexist(obj->maps.cgroup_storage, &key))
 		goto close_bpf_object;
 
 	/* Attach to parent and child cgroup, trigger packet from child.
@@ -135,13 +135,15 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 	if (CHECK(obj->bss->invocations != 3,
 		  "second-invoke", "invocations=%d", obj->bss->invocations))
 		goto close_bpf_object;
+	key.cgroup_inode_id = get_cgroup_id(PARENT_CGROUP);
 	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 2 };
 	if (assert_storage(obj->maps.cgroup_storage,
-			   PARENT_CGROUP, &expected_cgroup_value))
+			   &key, &expected_cgroup_value))
 		goto close_bpf_object;
+	key.cgroup_inode_id = get_cgroup_id(CHILD_CGROUP);
 	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
 	if (assert_storage(obj->maps.cgroup_storage,
-			   CHILD_CGROUP, &expected_cgroup_value))
+			   &key, &expected_cgroup_value))
 		goto close_bpf_object;
 
 close_bpf_object:
@@ -151,18 +153,228 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 	cg_storage_multi_egress_only__destroy(obj);
 }
 
-static void test_egress_ingress(int parent_cgroup_fd, int child_cgroup_fd)
+static void test_isolated(int parent_cgroup_fd, int child_cgroup_fd)
 {
-	struct cg_storage_multi_egress_ingress *obj;
+	struct cg_storage_multi_isolated *obj;
+	struct cgroup_value expected_cgroup_value;
+	struct bpf_cgroup_storage_key key;
+	struct bpf_link *parent_egress1_link = NULL, *parent_egress2_link = NULL;
+	struct bpf_link *child_egress1_link = NULL, *child_egress2_link = NULL;
+	struct bpf_link *parent_ingress_link = NULL, *child_ingress_link = NULL;
+	bool err;
 
-	/* Cannot load both programs due to verifier failure:
-	 * "only one cgroup storage of each type is allowed"
+	obj = cg_storage_multi_isolated__open_and_load();
+	if (CHECK(!obj, "skel-load", "errno %d", errno))
+		return;
+
+	/* Attach to parent cgroup, trigger packet from child.
+	 * Assert that there is three runs, two with parent cgroup egress and
+	 * one with parent cgroup ingress, stored in separate parent storages.
+	 * Also assert that child cgroup's storages does not exist
 	 */
-	obj = cg_storage_multi_egress_ingress__open_and_load();
-	CHECK(obj || errno != EBUSY,
-	      "skel-load", "errno %d, expected EBUSY", errno);
+	parent_egress1_link = bpf_program__attach_cgroup(obj->progs.egress1,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_egress1_link), "parent-egress1-cg-attach",
+		  "err %ld", PTR_ERR(parent_egress1_link)))
+		goto close_bpf_object;
+	parent_egress2_link = bpf_program__attach_cgroup(obj->progs.egress2,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_egress2_link), "parent-egress2-cg-attach",
+		  "err %ld", PTR_ERR(parent_egress2_link)))
+		goto close_bpf_object;
+	parent_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_ingress_link), "parent-ingress-cg-attach",
+		  "err %ld", PTR_ERR(parent_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "first-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 3,
+		  "first-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	key.cgroup_inode_id = get_cgroup_id(PARENT_CGROUP);
+	key.attach_type = BPF_CGROUP_INET_EGRESS;
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 2 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+	key.attach_type = BPF_CGROUP_INET_INGRESS;
+	expected_cgroup_value = (struct cgroup_value) { .ingress_pkts = 1 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+	key.cgroup_inode_id = get_cgroup_id(CHILD_CGROUP);
+	key.attach_type = BPF_CGROUP_INET_EGRESS;
+	if (assert_storage_noexist(obj->maps.cgroup_storage, &key))
+		goto close_bpf_object;
+	key.attach_type = BPF_CGROUP_INET_INGRESS;
+	if (assert_storage_noexist(obj->maps.cgroup_storage, &key))
+		goto close_bpf_object;
 
-	cg_storage_multi_egress_ingress__destroy(obj);
+	/* Attach to parent and child cgroup, trigger packet from child.
+	 * Assert that there is six additional runs, parent cgroup egresses and
+	 * ingress, child cgroup egresses and ingress.
+	 * Assert that egree and ingress storages are separate.
+	 */
+	child_egress1_link = bpf_program__attach_cgroup(obj->progs.egress1,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_egress1_link), "child-egress1-cg-attach",
+		  "err %ld", PTR_ERR(child_egress1_link)))
+		goto close_bpf_object;
+	child_egress2_link = bpf_program__attach_cgroup(obj->progs.egress2,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_egress2_link), "child-egress2-cg-attach",
+		  "err %ld", PTR_ERR(child_egress2_link)))
+		goto close_bpf_object;
+	child_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_ingress_link), "child-ingress-cg-attach",
+		  "err %ld", PTR_ERR(child_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "second-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 9,
+		  "second-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	key.cgroup_inode_id = get_cgroup_id(PARENT_CGROUP);
+	key.attach_type = BPF_CGROUP_INET_EGRESS;
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 4 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+	key.attach_type = BPF_CGROUP_INET_INGRESS;
+	expected_cgroup_value = (struct cgroup_value) { .ingress_pkts = 2 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+	key.cgroup_inode_id = get_cgroup_id(CHILD_CGROUP);
+	key.attach_type = BPF_CGROUP_INET_EGRESS;
+	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 2 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+	key.attach_type = BPF_CGROUP_INET_INGRESS;
+	expected_cgroup_value = (struct cgroup_value) { .ingress_pkts = 1 };
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(parent_egress1_link);
+	bpf_link__destroy(parent_egress2_link);
+	bpf_link__destroy(parent_ingress_link);
+	bpf_link__destroy(child_egress1_link);
+	bpf_link__destroy(child_egress2_link);
+	bpf_link__destroy(child_ingress_link);
+
+	cg_storage_multi_isolated__destroy(obj);
+}
+
+static void test_shared(int parent_cgroup_fd, int child_cgroup_fd)
+{
+	struct cg_storage_multi_shared *obj;
+	struct cgroup_value expected_cgroup_value;
+	__u64 key;
+	struct bpf_link *parent_egress1_link = NULL, *parent_egress2_link = NULL;
+	struct bpf_link *child_egress1_link = NULL, *child_egress2_link = NULL;
+	struct bpf_link *parent_ingress_link = NULL, *child_ingress_link = NULL;
+	bool err;
+
+	obj = cg_storage_multi_shared__open_and_load();
+	if (CHECK(!obj, "skel-load", "errno %d", errno))
+		return;
+
+	/* Attach to parent cgroup, trigger packet from child.
+	 * Assert that there is three runs, two with parent cgroup egress and
+	 * one with parent cgroup ingress.
+	 * Also assert that child cgroup's storage does not exist
+	 */
+	parent_egress1_link = bpf_program__attach_cgroup(obj->progs.egress1,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_egress1_link), "parent-egress1-cg-attach",
+		  "err %ld", PTR_ERR(parent_egress1_link)))
+		goto close_bpf_object;
+	parent_egress2_link = bpf_program__attach_cgroup(obj->progs.egress2,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_egress2_link), "parent-egress2-cg-attach",
+		  "err %ld", PTR_ERR(parent_egress2_link)))
+		goto close_bpf_object;
+	parent_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_ingress_link), "parent-ingress-cg-attach",
+		  "err %ld", PTR_ERR(parent_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "first-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 3,
+		  "first-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	key = get_cgroup_id(PARENT_CGROUP);
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 2,
+		.ingress_pkts = 1,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+	key = get_cgroup_id(CHILD_CGROUP);
+	if (assert_storage_noexist(obj->maps.cgroup_storage, &key))
+		goto close_bpf_object;
+
+	/* Attach to parent and child cgroup, trigger packet from child.
+	 * Assert that there is six additional runs, parent cgroup egresses and
+	 * ingress, child cgroup egresses and ingress.
+	 */
+	child_egress1_link = bpf_program__attach_cgroup(obj->progs.egress1,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_egress1_link), "child-egress1-cg-attach",
+		  "err %ld", PTR_ERR(child_egress1_link)))
+		goto close_bpf_object;
+	child_egress2_link = bpf_program__attach_cgroup(obj->progs.egress2,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_egress2_link), "child-egress2-cg-attach",
+		  "err %ld", PTR_ERR(child_egress2_link)))
+		goto close_bpf_object;
+	child_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_ingress_link), "child-ingress-cg-attach",
+		  "err %ld", PTR_ERR(child_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "second-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 9,
+		  "second-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	key = get_cgroup_id(PARENT_CGROUP);
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 4,
+		.ingress_pkts = 2,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+	key = get_cgroup_id(CHILD_CGROUP);
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 2,
+		.ingress_pkts = 1,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   &key, &expected_cgroup_value))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(parent_egress1_link);
+	bpf_link__destroy(parent_egress2_link);
+	bpf_link__destroy(parent_ingress_link);
+	bpf_link__destroy(child_egress1_link);
+	bpf_link__destroy(child_egress2_link);
+	bpf_link__destroy(child_ingress_link);
+
+	cg_storage_multi_shared__destroy(obj);
 }
 
 void test_cg_storage_multi(void)
@@ -179,8 +391,11 @@ void test_cg_storage_multi(void)
 	if (test__start_subtest("egress_only"))
 		test_egress_only(parent_cgroup_fd, child_cgroup_fd);
 
-	if (test__start_subtest("egress_ingress"))
-		test_egress_ingress(parent_cgroup_fd, child_cgroup_fd);
+	if (test__start_subtest("isolated"))
+		test_isolated(parent_cgroup_fd, child_cgroup_fd);
+
+	if (test__start_subtest("shared"))
+		test_shared(parent_cgroup_fd, child_cgroup_fd);
 
 close_cgroup_fd:
 	close(child_cgroup_fd);
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c b/tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
similarity index 73%
rename from tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
rename to tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
index 9ce386899365..a25373002055 100644
--- a/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
@@ -20,8 +20,20 @@ struct {
 
 __u32 invocations = 0;
 
-SEC("cgroup_skb/egress")
-int egress(struct __sk_buff *skb)
+SEC("cgroup_skb/egress/1")
+int egress1(struct __sk_buff *skb)
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
+SEC("cgroup_skb/egress/2")
+int egress2(struct __sk_buff *skb)
 {
 	struct cgroup_value *ptr_cg_storage =
 		bpf_get_local_storage(&cgroup_storage, 0);
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c b/tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c
new file mode 100644
index 000000000000..a149f33bc533
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c
@@ -0,0 +1,57 @@
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
+	__type(key, __u64);
+	__type(value, struct cgroup_value);
+} cgroup_storage SEC(".maps");
+
+__u32 invocations = 0;
+
+SEC("cgroup_skb/egress/1")
+int egress1(struct __sk_buff *skb)
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
+SEC("cgroup_skb/egress/2")
+int egress2(struct __sk_buff *skb)
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
-- 
2.27.0

