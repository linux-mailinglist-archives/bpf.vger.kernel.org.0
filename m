Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5026122A9BE
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGWHlG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGWHlG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 03:41:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4C0C0619DC
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p205so5263352iod.8
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0P8SGFPnoqyVi26FeXQVELcv5US6/6JL1LqKWbrJiA=;
        b=EwVrshzBo9UzZN+dBIvEekjM/kGeAzmWYX/j3e/qWjTZ3CalO8MuCJt6j3esK3Fru2
         RvBfLxc9S4JdPmsmUOyMpy+HW3aGW/fFvkE985UMQw2xYoVp8c9grY5CIbxYa/YmptQq
         Q7aOkrkeZChB1p45/fhLX2EhhkOUZkcOPAHZPL+Giuglno7OiYUaAuc4TXsPfMWUhmZf
         6siSvKTfUT5BsGjyKcmSLAlJZoGUF+ZhiS3x9YDEw6FghGStUrUXl2AF82x03+o2AZbr
         SfUSM74/s9CnIbX3D2y9s0eT74vyCEvnHd2Sr2FVgkFNNMNvnHYO1al2CeIQvmuz52Rq
         5Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0P8SGFPnoqyVi26FeXQVELcv5US6/6JL1LqKWbrJiA=;
        b=EH3aMtfsYvsTY6GB0ahmwWUniHlRTTH62sE6Ol4GinoX7Zcd4Pfm7yuZvvGeuwNor9
         OB5CqUy+jhAaLgfqLM5dXxKgmSWHc3yAZpN24HlD0wQ3CYK1PV9jSfuG9sk3AJKCh8dO
         fKpoxDxPc+XR0X2ymzlTrcO2Gw2Zlq3dN0hErY33L5WGGbioBY/zmy6pq4rGn5snMYru
         2JXcmNwuqhoAXm5r5ULMxYES+ATBe9oCPSbw/ckf0lhHroWtWe3Xi0wbYC8/YAs6K8gF
         Dt7MbRHhJycsVh7y7s5+2Xos4Rxu2YAZzXHc7dcTwtq9w/mstiAwn2ikowr0LqkvIlDe
         h68Q==
X-Gm-Message-State: AOAM532zZCRpr+oNityf6epTq/R1vf7F+Q/BKpApmcGTTcgce0JXdwQi
        bMwX1DnM9+JcnxHo1H2gbKmxGPHjE5Uxlw==
X-Google-Smtp-Source: ABdhPJwJYP6v7LlhNa8aOwySmF1mVAZZZxARlG9UeHlqlVyxQJkbSa+f/MqGwIm5OO6NuXfsw9O2Tg==
X-Received: by 2002:a02:7419:: with SMTP id o25mr3408419jac.46.1595490065284;
        Thu, 23 Jul 2020 00:41:05 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id c9sm1035552ilm.57.2020.07.23.00.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:41:04 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 1/5] selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
Date:   Thu, 23 Jul 2020 02:40:54 -0500
Message-Id: <46200200d3a12dac05a4f8b8cefebebce06bd6db.1595489786.git.zhuyifei@google.com>
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

