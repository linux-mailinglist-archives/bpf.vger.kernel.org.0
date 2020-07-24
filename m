Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E615F22BD23
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXEsJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 00:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGXEsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 00:48:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D03C0619D3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id a12so8571357ion.13
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQI0CIq4CMHw1mmtrhL8KaiMw/ZmByN1PL74BNGtPCU=;
        b=sVSQXgyq6AqRPyF/ax7o7xd1DGSqdgroV/detSA6Q8D5O0742L0ZMtwKrJbqCvQtB/
         YMP991uvN+96pDiqXOfMCkywOmUGIPgr9Jhh3Sx1JAmXUP1Na6lWnNsLn5qbP2IIUfrv
         E5T7iTP42OYhxloZPZsROAZy3ALZBF2x1piMzSUWPjHAQ8TyOfRqr5gk4/fQX0AlYeQi
         /0fxFzDsYVa2KzvEA6iw7LXGadLs8j32He4wmc7mlsNxOn87cleXZwvvbqz7B75JnTvO
         qnfU28LfJEpyYDATGAaBcK4s9uj1xnoYLwhmDjtHMZMw+9hDkpLqfjPqtmBPoIT2UpTM
         YJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQI0CIq4CMHw1mmtrhL8KaiMw/ZmByN1PL74BNGtPCU=;
        b=pXueefWSvTApfAB7cRfgEFUsV11qpHj/TGRse9M+cMdf1pcQ26FK5rLFP6F5M50EZH
         GgSPtB8aaukUHaEYHetAqI8PzFvdDXAwXbVV+zk122+Cn940LV5do5cjSpwGmnCIGizg
         0++DIe8t0d2XqTQv6JJzLwtUaHLPjSCFTnSKmM8VfA+Ao/nJCTkl8zuSL+PP4KpIFobG
         ByUGxjS+wbuqRSMjL3TUEX2C6ZQP82yeN2mFClzQ2pZxqScyOijVtTnvPRIbUDUJnoX6
         NIVse+Dw09SdoqWCasHXNxxyjRWB3BDItVuwUEh0J944HFSFMpG5YWkoVGEWwaOHOIZk
         /IZA==
X-Gm-Message-State: AOAM533ZrhJLhI2stER3iNeKfvpjnwGKV5RHHzAP1sDrYYGiv3WEkeaq
        esyBdq2/K3PIv6PqKfsMUwigVlGbEjA7qA==
X-Google-Smtp-Source: ABdhPJwFK/6X3IhvXzr+PV6+xTbOt+yV3oJxPK/CgqX/hlFVT8sj+ZYS5yJ2FLgw8oxBEwtyE0nQEQ==
X-Received: by 2002:a02:a19c:: with SMTP id n28mr8673861jah.13.1595566087089;
        Thu, 23 Jul 2020 21:48:07 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id o64sm2686579ilb.12.2020.07.23.21.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 21:48:06 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 1/5] selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
Date:   Thu, 23 Jul 2020 23:47:41 -0500
Message-Id: <5a20206afa4606144691c7caa0d1b997cd60dec0.1595565795.git.zhuyifei@google.com>
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

This test creates a parent cgroup, and a child of that cgroup.
It attaches a cgroup_skb/egress program that simply counts packets,
to a global variable (ARRAY map), and to a CGROUP_STORAGE map.
The program is first attached to the parent cgroup only, then to
parent and child.

The test cases sends a message within the child cgroup, and because
the program is inherited across parent / child cgroups, it will
trigger the egress program for both the parent and child, if they
exist. The program, when looking up a CGROUP_STORAGE map, uses the
cgroup and attach type of the attachment parameters; therefore,
both attaches uses different cgroup storages.

We assert that all packet counts returns what we expects.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/cg_storage_multi.c         | 161 ++++++++++++++++++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  30 ++++
 2 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
new file mode 100644
index 000000000000..e90e0547d759
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -0,0 +1,161 @@
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
+#include "cg_storage_multi_egress_only.skel.h"
+
+#define PARENT_CGROUP "/cgroup_storage"
+#define CHILD_CGROUP "/cgroup_storage/child"
+
+static int duration;
+
+static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
+			   __u32 expected)
+{
+	struct bpf_cgroup_storage_key key = {0};
+	__u32 value;
+	int map_fd;
+
+	map_fd = bpf_map__fd(map);
+
+	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
+	key.attach_type = BPF_CGROUP_INET_EGRESS;
+	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) < 0,
+		  "map-lookup", "errno %d", errno))
+		return true;
+	if (CHECK(value != expected,
+		  "assert-storage", "got %u expected %u", value, expected))
+		return true;
+
+	return false;
+}
+
+static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
+{
+	struct bpf_cgroup_storage_key key = {0};
+	__u32 value;
+	int map_fd;
+
+	map_fd = bpf_map__fd(map);
+
+	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
+	key.attach_type = BPF_CGROUP_INET_EGRESS;
+	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) == 0,
+		  "map-lookup", "succeeded, expected ENOENT"))
+		return true;
+	if (CHECK(errno != ENOENT,
+		  "map-lookup", "errno %d, expected ENOENT", errno))
+		return true;
+
+	return false;
+}
+
+static bool connect_send(const char *cgroup_path)
+{
+	bool res = true;
+	int server_fd = -1, client_fd = -1;
+
+	if (join_cgroup(cgroup_path))
+		goto out_clean;
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, NULL, 0, 0);
+	if (server_fd < 0)
+		goto out_clean;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (client_fd < 0)
+		goto out_clean;
+
+	if (send(client_fd, "message", strlen("message"), 0) < 0)
+		goto out_clean;
+
+	res = false;
+
+out_clean:
+	close(client_fd);
+	close(server_fd);
+	return res;
+}
+
+static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
+{
+	struct cg_storage_multi_egress_only *obj;
+	struct bpf_link *parent_link = NULL, *child_link = NULL;
+	bool err;
+
+	obj = cg_storage_multi_egress_only__open_and_load();
+	if (CHECK(!obj, "skel-load", "errno %d", errno))
+		return;
+
+	/* Attach to parent cgroup, trigger packet from child.
+	 * Assert that there is only one run and in that run the storage is
+	 * parent cgroup's storage.
+	 * Also assert that child cgroup's storage does not exist
+	 */
+	parent_link = bpf_program__attach_cgroup(obj->progs.egress,
+						 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_link), "parent-cg-attach",
+		  "err %ld", PTR_ERR(parent_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "first-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 1,
+		  "first-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 1))
+		goto close_bpf_object;
+	if (assert_storage_noexist(obj->maps.cgroup_storage, CHILD_CGROUP))
+		goto close_bpf_object;
+
+	/* Attach to parent and child cgroup, trigger packet from child.
+	 * Assert that there are two additional runs, one that run with parent
+	 * cgroup's storage and one with child cgroup's storage.
+	 */
+	child_link = bpf_program__attach_cgroup(obj->progs.egress,
+						child_cgroup_fd);
+	if (CHECK(IS_ERR(child_link), "child-cg-attach",
+		  "err %ld", PTR_ERR(child_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "second-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 3,
+		  "second-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 2))
+		goto close_bpf_object;
+	if (assert_storage(obj->maps.cgroup_storage, CHILD_CGROUP, 1))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(parent_link);
+	bpf_link__destroy(child_link);
+
+	cg_storage_multi_egress_only__destroy(obj);
+}
+
+void test_cg_storage_multi(void)
+{
+	int parent_cgroup_fd = -1, child_cgroup_fd = -1;
+
+	parent_cgroup_fd = test__join_cgroup(PARENT_CGROUP);
+	if (CHECK(parent_cgroup_fd < 0, "cg-create-parent", "errno %d", errno))
+		goto close_cgroup_fd;
+	child_cgroup_fd = create_and_get_cgroup(CHILD_CGROUP);
+	if (CHECK(child_cgroup_fd < 0, "cg-create-child", "errno %d", errno))
+		goto close_cgroup_fd;
+
+	if (test__start_subtest("egress_only"))
+		test_egress_only(parent_cgroup_fd, child_cgroup_fd);
+
+close_cgroup_fd:
+	close(child_cgroup_fd);
+	close(parent_cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c b/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
new file mode 100644
index 000000000000..ec0165d07105
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
@@ -0,0 +1,30 @@
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
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u32);
+} cgroup_storage SEC(".maps");
+
+__u32 invocations = 0;
+
+SEC("cgroup_skb/egress")
+int egress(struct __sk_buff *skb)
+{
+	__u32 *ptr_cg_storage = bpf_get_local_storage(&cgroup_storage, 0);
+
+	__sync_fetch_and_add(ptr_cg_storage, 1);
+	__sync_fetch_and_add(&invocations, 1);
+
+	return 1;
+}
-- 
2.27.0

