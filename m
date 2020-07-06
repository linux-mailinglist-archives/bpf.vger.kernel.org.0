Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0162160B0
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGFUyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 16:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFUyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 16:54:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE46C061755
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 13:54:12 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x9so34168644ila.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUx99SWlARm+H51ijmmtvg/ypf38m1B2QFZP9QwtTmU=;
        b=gWJUlJvfGa7PVAWaFXQ/b368VsbmveyhI5LA7A27Fs1uO2i4bcU9mPFMhq/K60rEtc
         WtZ9gdqLP78Ni16OTYoeDwXziP1IDRLzxufMmUaEpmdqJ3YvfOEDrzH8/m+3kfoBJV4B
         nfuVQBJ2Qs6nPeBWc4YwFBXqa+5rCpnxTUUSNEorQvhLJdR/FEM0PuTuHLccoz3DmeXX
         BykehBqj20iDsPIWLVi21EeDT/nDOnGmQwEypb7xuLTIXt8L+DD3psc2Ly51U7maZSrL
         LeIEGGRq0ahAI9bZXSF75z3JLYh8GKbJnAdLXzH0XW0mAH0RVax3czKtKajZ8wOaIVLV
         X0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUx99SWlARm+H51ijmmtvg/ypf38m1B2QFZP9QwtTmU=;
        b=gVmYgmleUQ1ddzABG9mLCJKu6frBAtln8bIZgx1E2Jf1uLRzS5zcJinOQCJo5d1pFI
         nOVkRe3p7dDNMpCVoZ76tehXW/89x3CW8VoFRECkAyYaCi9ZPhw6sYy+fffywqpSZNCC
         Wv79JsPod6vfARCTUB+7/BFnHxoZaQd4uqf8q9/RSJraPiYhDypyYrKOv0IhGNnwBlRw
         xAVTMWPuIZvmav8QlYACHsZ26l61nOuE+P5JvFlxlF2VlhODStkP/DjJqUqEOs118Mht
         RXB3Rb9bx4DV3B7iJsBMqYuiEK74OxUVCh1QfGULmEElwwI0wdjBc1izRLdIcVPLIWzd
         c2Xg==
X-Gm-Message-State: AOAM5305BgbDaesJpuUMY6QKm9oNgojQazxA9VdOeOn6Ay3o+HIailoh
        nCWiP+O9l0ZMYIkuB1PbI7OagtqqHCo=
X-Google-Smtp-Source: ABdhPJwcyRfXSLEsLfKdC/ZPidPqSydUum/gEMhrB22UykWquS834igaNOU2xQalJMvycn6Vl5ymbA==
X-Received: by 2002:a92:794f:: with SMTP id u76mr29760697ilc.215.1594068851864;
        Mon, 06 Jul 2020 13:54:11 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id r124sm10744198iod.40.2020.07.06.13.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:54:11 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 1/5] selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
Date:   Mon,  6 Jul 2020 15:51:18 -0500
Message-Id: <cf91469d82c2b9954779e5e786c2fa852694e14e.1594065127.git.zhuyifei@google.com>
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
 .../bpf/prog_tests/cg_storage_multi.c         | 154 ++++++++++++++++++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  30 ++++
 2 files changed, 184 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
new file mode 100644
index 000000000000..fee34a0ef862
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -0,0 +1,154 @@
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
+	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value) < 0))
+		return true;
+	if (CHECK_FAIL(value != expected))
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
+	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value) == 0))
+		return true;
+	if (CHECK_FAIL(errno != ENOENT))
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
+	int err;
+
+	if (!test__start_subtest("egress_only"))
+		return;
+
+	obj = cg_storage_multi_egress_only__open_and_load();
+	if (CHECK_FAIL(!obj))
+		return;
+
+	/* Attach to parent cgroup, trigger packet from child.
+	 * Assert that there is only one run and in that run the storage is
+	 * parent cgroup's storage.
+	 * Also assert that child cgroup's storage does not exist
+	 */
+	err = bpf_prog_attach(bpf_program__fd(obj->progs.egress),
+			      parent_cgroup_fd,
+			      BPF_CGROUP_INET_EGRESS, BPF_F_ALLOW_MULTI);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	if (CHECK_FAIL(obj->bss->invocations != 1))
+		goto close_bpf_object;
+	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
+				      PARENT_CGROUP, 1)))
+		goto close_bpf_object;
+	if (CHECK_FAIL(assert_storage_noexist(obj->maps.cgroup_storage,
+					      CHILD_CGROUP)))
+		goto close_bpf_object;
+
+	/* Attach to parent and child cgroup, trigger packet from child.
+	 * Assert that there are two additional runs, one that run with parent
+	 * cgroup's storage and one with child cgroup's storage.
+	 */
+	err = bpf_prog_attach(bpf_program__fd(obj->progs.egress),
+			      child_cgroup_fd,
+			      BPF_CGROUP_INET_EGRESS, BPF_F_ALLOW_MULTI);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	if (CHECK_FAIL(obj->bss->invocations != 3))
+		goto close_bpf_object;
+	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
+				      PARENT_CGROUP, 2)))
+		goto close_bpf_object;
+	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
+				      CHILD_CGROUP, 1)))
+		goto close_bpf_object;
+
+close_bpf_object:
+	cg_storage_multi_egress_only__destroy(obj);
+}
+
+void test_cg_storage_multi(void)
+{
+	int parent_cgroup_fd, child_cgroup_fd;
+
+	parent_cgroup_fd = test__join_cgroup(PARENT_CGROUP);
+	child_cgroup_fd = create_and_get_cgroup(CHILD_CGROUP);
+	if (CHECK_FAIL(parent_cgroup_fd < 0 || child_cgroup_fd < 0))
+		goto close_cgroup_fd;
+
+	test_egress_only(parent_cgroup_fd, child_cgroup_fd);
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

