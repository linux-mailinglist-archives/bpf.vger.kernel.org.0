Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3752115AC
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgGAWOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgGAWOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:17 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD38C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 15:14:17 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e64so21843233iof.12
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47sklGup6BRMPEQKoZMOoPCyJVOIWbbdAKErK1F0rkE=;
        b=nvRaUG+/duL7KAV0UVS+O2ILK0skmK+BzPbh2ABUF2Ld8rVS9eiyAumehzHKtWmx6O
         LVVtTJkYy8xHEFqJhXBaGUBiGBJLdGiGxGr+Uqddc34a18QIMP9rIAUjB3diIlNCVPrW
         c15qz8aRvNt4HMZ4WVD7j7MCG9VxCOgH+60ZRnTsoMMr00fnf6+i6uDVO9vN3cU7hCi5
         5Oeiu5jWFtdor+tJE/p5ewB0atJU0MP3U7vRUJ2bNJTwFPjMFQtWhM8irerHbLVd91+1
         zVyVZAw2BtoBfVvUvVE8Gz21RpvfWj8TJkj8IDpqCF7iGczboYZZhnVN7TKQXSMxl3IM
         kM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47sklGup6BRMPEQKoZMOoPCyJVOIWbbdAKErK1F0rkE=;
        b=LegrF6YUN/UdrqHliXngUVczB4f4M6Mlfd4jAUSprls3GgVeM/FE3FZYD5YgmRSwvV
         Pu0piZJ28hVQu7T8Haiohsd3PGcTttp4fsg4PiI1lClpMQqqoKMpc8FYrVPHdHVI0a0u
         RXEzOKKLUat6w3swGWgnBE5Kv79YIj3sqEykiT9TnTJyG/JEnHt/PMRIJCautZuVNXFJ
         wV11ynkOgn+CzZL1gDzH3j+i3zxiW5NFzxAiMs5pBBzlzJ1mqZkGSFbjMPKdubz5wmIs
         PPbsOQk1BNP/HHCSlhFddVTmkLleIwxaOSrqbevx9zagomBy0Z4YSdmlfnU0oBH9gk2i
         Q+3Q==
X-Gm-Message-State: AOAM532fND3YsEE4UbLhkxsZfaWGMfiaAnRU5f1j8sdnb+xjSBh1OPP0
        kI6Hu08ciYv9upfqoKWfpcBhXX8jGzP/OA==
X-Google-Smtp-Source: ABdhPJwfaFoiUML1kFIYY31bXZya/r067xx2w4GJLO/c88H05PUT7G2UrsY/s6F9o5Mm50P7Crxrfw==
X-Received: by 2002:a02:270d:: with SMTP id g13mr29216882jaa.93.1593641656701;
        Wed, 01 Jul 2020 15:14:16 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id t83sm4051543ilb.47.2020.07.01.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:14:16 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 1/5] selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
Date:   Wed,  1 Jul 2020 17:13:54 -0500
Message-Id: <8b67002dbc7f23e44ba1f71dcbfd201a8643f03a.1593638618.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593638618.git.zhuyifei@google.com>
References: <cover.1593638618.git.zhuyifei@google.com>
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
index 000000000000..69d29092e7c8
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
+	server_fd = start_server(AF_INET, SOCK_DGRAM);
+	if (server_fd < 0)
+		goto out_clean;
+
+	client_fd = connect_to_fd(AF_INET, SOCK_DGRAM, server_fd);
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

