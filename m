Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1C226F55
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgGTTzJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGTTzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 15:55:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA848C061794
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q3so14381496ilt.8
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0P8SGFPnoqyVi26FeXQVELcv5US6/6JL1LqKWbrJiA=;
        b=NPwWMrsnCxov60htjMih9G9jOxyXxuM9hn4j9jHq3tpDbVJwU3DSPwQNxdg4LLtZj2
         yuRPiv++6h8foVSsL2AbHGevecGFBuGHlmHf4TsiXQOsn1mH/RSaZaAV+2bwOh0dMDQo
         gB6YKkNInBKl6AYuegHv++WrecJ5UvKIFxciKQdUOjznzbFSKua1HDeJlXxFuyt5T/WM
         FdYQvC+FqU1NO0sdYwtIeUgtpFUZvm838sb5ghQIvcYVLz6HrhAaIsQw5bxck7LA4fB0
         My5vtFmtDCdXpdEC0HcXHKnb6NpIti1Dpm7R1R33uzFaELNHJYNI/0KSWwG9w13FuLqg
         U9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0P8SGFPnoqyVi26FeXQVELcv5US6/6JL1LqKWbrJiA=;
        b=S99SOXxskaBuRvem1KmkbUUgiRFceYQSCBpM2siTg5ZTjBJYnh1F2FhkrcQAQOwAAL
         S1y7JAoSvau7+bqXdWMhsIcgwOTkkgbYyULEVv8zFhaj5B9FAK7Wxbkd+x560Ne6vpPo
         QjuVW3xhWgpPAALnsALLg6+x8fYh/Nyz57R9DKMZRmQy9jyXesnkLdvYVkb2P2aV9CkF
         hUON8pAjSO8oU3dWylM7w9h229XhfF6YnbsRkyWxixC84AteUm4T+2d6bHMXE9Q5t7Pw
         9ktUjOwvrRGXwLuNZeTwy1ygP5I0c0ZtvI03Hd6U549QXj9W/LvK4iu3NFpBo0FwletQ
         mH9Q==
X-Gm-Message-State: AOAM533SSaHeEpeGKZaIY7pg0aXTZSoxd9nW7jrhkGHD28qXrygMzjqm
        5+bBNL+uKYy3giTG+RtGJkJuQIXuF65UQA==
X-Google-Smtp-Source: ABdhPJwVJoD+dXf7EJY6NUnUZuKMpOMHhGk5tl2Gtiba+6Skn4ubmbfsjJvBNIjmTOPa0dX9xxZQ3Q==
X-Received: by 2002:a05:6e02:588:: with SMTP id c8mr21878348ils.253.1595274906438;
        Mon, 20 Jul 2020 12:55:06 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id v10sm9347174ilj.40.2020.07.20.12.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:55:06 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 1/5] selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
Date:   Mon, 20 Jul 2020 14:54:51 -0500
Message-Id: <3d22f5e42fbc27624f612d827ed872ca95cac500.1595274799.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595274799.git.zhuyifei@google.com>
References: <cover.1595274799.git.zhuyifei@google.com>
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

