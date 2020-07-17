Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0D222FD8
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgGQAQz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgGQAQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:54 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE179C061755
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:54 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a12so8324692ion.13
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0P8SGFPnoqyVi26FeXQVELcv5US6/6JL1LqKWbrJiA=;
        b=ABwBPq4XnUqXZF0yNAi4Hu4iUrLs0w2b7BOlnly0a3uSfkP3PgAhGm2mODS2CW2kNX
         B6CsgDy5hzy1Mg6iSvqDsawR7YmStVE76jmm+iAk3ChjOgTGTEir9zPQlyVvOzEMzh7h
         RgoPt/dLaUjTAO030gG7vk2H+pzJUCUx1af6qPnlIS10MT3H5kLQrEk8Tkd513k1qgjq
         trEiYeetWonH2zXq9LadVpDC3U4bz4z/8ho9OpQjtOY2/YIED9+TCw3hefBwk9vlk8Y0
         TRiOn3k26qeN/c7BiUVbBWm+d1cYjSi+KO2iB3tsPg7lHV4BC3u5j1ydoEu/9TEF0n5u
         +KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0P8SGFPnoqyVi26FeXQVELcv5US6/6JL1LqKWbrJiA=;
        b=Uh3Rznp3tg07Ke/eOkECztVzQM5detanwJ0EbpZ3VaQveYwKqCxUA7WgOBbUnck8+i
         Ky/fLXlCwiKO/tHrcnJYqqdapBToi/MNOeRbMiJlmOD7U3Z82ak3RRIN6rhMAoawowoq
         fNheU4mw/kZb5oXrQGSpySxiwJunbL+ZQmNz0IJ5JOJ/twb6LJrKVMjo2mhGQj2LmrX3
         cvTn5zj0L1nixoN8Hgy4pYkYmO1X2AAPpuez2BxGHCsIzjeOWs2wKH3fvW0e9nZ2/sZE
         6gI1b5WipOasGaBXXGP7zlrkjj+szYDOmmcA55sBXL+nlKsIUdRaknzlxDDbz7l0sLm+
         1BRA==
X-Gm-Message-State: AOAM531xiDiSj26x5y8FySzDGtgRueXTzJhJvi9eW2Fhz7HSNXOt2ho1
        lxPVoahEZ2LKdxT4MI7vekJXI9AtcIdw4A==
X-Google-Smtp-Source: ABdhPJwmyO4KkCUviiyic645WnuqFRl4xF0NnOxjb2kTdBFEdzAk8P0GOs3MQvxPRiHbq8+EFO3xqA==
X-Received: by 2002:a6b:8b11:: with SMTP id n17mr6917646iod.155.1594945013865;
        Thu, 16 Jul 2020 17:16:53 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id m5sm3427493ilg.18.2020.07.16.17.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:53 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 1/5] selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
Date:   Thu, 16 Jul 2020 19:16:25 -0500
Message-Id: <60723a180cac6aad3d0bd6d77719f8e30619dc9d.1594944827.git.zhuyifei@google.com>
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
 .../bpf/prog_tests/cg_storage_multi.c         | 163 ++++++++++++++++++
 .../bpf/progs/cg_storage_multi_egress_only.c  |  30 ++++
 2 files changed, 193 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
new file mode 100644
index 000000000000..6d5a2194e036
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -0,0 +1,163 @@
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
+	if (parent_link)
+		bpf_link__destroy(parent_link);
+	if (child_link)
+		bpf_link__destroy(child_link);
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

