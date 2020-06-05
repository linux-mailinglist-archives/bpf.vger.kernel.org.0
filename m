Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A624F1EEEA7
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 02:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFEAIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 20:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 20:08:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDAC08C5C0
        for <bpf@vger.kernel.org>; Thu,  4 Jun 2020 17:08:41 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p5so7871524ile.6
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRE7MFF58IX4nisvjG9/VrD2MFrt85I31yTiIm59rZo=;
        b=LfL2RveSVTA7v3gyeA65Icy7O66ey0LGZWLesrR7P3ewk7DtE9Y22zMrfODckZ7eYq
         ut94qLavTqJpsrNNt8B2UFelkfso6Fo1WkNp/9JrqhdbxJCMymmL3eXTi5J5q1alSQpR
         LCO6CXPGI47RPADkUedX435p+B1Mq4BMo2CgL+7q6uTf7XbQEt4e/4LWXmRGPU5Lzo5P
         yU+LDkFRMr4zgTSsJ0aeoKsHOPDEx/CAZJQCj8hPt+8OBWZuApN12m7mMoFGHWSK9mjr
         rTgQdvRIchL9hvFSnL1ST8DZIeNDoAONJkCU3C12kne+pCsYuOavjK/w5nO03UxlIm6L
         qW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRE7MFF58IX4nisvjG9/VrD2MFrt85I31yTiIm59rZo=;
        b=fSwmjP64V3VYp4y+3HDOYBO1XW9EAqGOzlkX1I6toqVvIOTFQeb4R/KUnWsGFFedvT
         SsM3IulpbUzeBP96OMZkfMKjCfuHarWX1kVKN4pC/n7QU7WERcV7fIlBtap4XeG9ZFOA
         erfU9ez68xWAlhf2qTD0hnq13toq5bT90d95OsEMQ7Y5RwTTFziHmtp02rvQKpUW7wco
         wj12V+dlbAEPnhrpe6LQMj2f62OCxenJgsk8wohftHPfD+FPYHCbup/esYEW76ZF6j0o
         BUiE/tFdcSh0XMemybE1zFLmJkm4Rs3wv9KyWen12qpPfkls+jaVomHghCVUK2B0hJe1
         Et/Q==
X-Gm-Message-State: AOAM531xrP4O9E6DB7Bg38zorfXigeYVnZA92hCDH8yN3nQL2Kwk1+fc
        nNa5z2gDZm/VjOF0pfhWU/f7gACAGnb4RQ==
X-Google-Smtp-Source: ABdhPJwk46XAW+R8doqTMod7d6Op/to3GIzhoFKig55zwpWzSCzKSQCyDSXpcKKYoXBnT5nIUmyHXg==
X-Received: by 2002:a92:2a06:: with SMTP id r6mr6149641ile.121.1591315720859;
        Thu, 04 Jun 2020 17:08:40 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id y3sm557661ioy.40.2020.06.04.17.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:08:40 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
X-Google-Original-From: YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add cgroup_skb/egress test for load_bytes_relative
Date:   Thu,  4 Jun 2020 19:07:39 -0500
Message-Id: <ad9b83fe804595ec2f2ab804cea475f1d35db1b8.1591315176.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591315176.git.zhuyifei@google.com>
References: <cover.1591315176.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When cgroup_skb/egress triggers the MAC header is not set. Added a
test that asserts reading MAC header is a -EFAULT but NET header
succeeds. The test result from within the eBPF program is stored in
an 1-element array map that the userspace then reads and asserts on.

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/load_bytes_relative.c      | 71 +++++++++++++++++++
 .../selftests/bpf/progs/load_bytes_relative.c | 44 ++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
 create mode 100644 tools/testing/selftests/bpf/progs/load_bytes_relative.c

diff --git a/tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c b/tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
new file mode 100644
index 000000000000..c1168e4a9036
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+
+void test_load_bytes_relative(void)
+{
+	int server_fd, cgroup_fd, prog_fd, map_fd, client_fd;
+	int err;
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	struct bpf_map *test_result;
+	__u32 duration = 0;
+
+	__u32 map_key = 0;
+	__u32 map_value = 0;
+
+	cgroup_fd = test__join_cgroup("/load_bytes_relative");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM);
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_cgroup_fd;
+
+	err = bpf_prog_load("./load_bytes_relative.o", BPF_PROG_TYPE_CGROUP_SKB,
+			    &obj, &prog_fd);
+	if (CHECK_FAIL(err))
+		goto close_server_fd;
+
+	test_result = bpf_object__find_map_by_name(obj, "test_result");
+	if (CHECK_FAIL(!test_result))
+		goto close_bpf_object;
+
+	map_fd = bpf_map__fd(test_result);
+	if (map_fd < 0)
+		goto close_bpf_object;
+
+	prog = bpf_object__find_program_by_name(obj, "load_bytes_relative");
+	if (CHECK_FAIL(!prog))
+		goto close_bpf_object;
+
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS,
+			      BPF_F_ALLOW_MULTI);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+
+	client_fd = connect_to_fd(AF_INET, SOCK_STREAM, server_fd);
+	if (CHECK_FAIL(client_fd < 0))
+		goto close_bpf_object;
+	close(client_fd);
+
+	err = bpf_map_lookup_elem(map_fd, &map_key, &map_value);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+
+	CHECK(map_value != 1, "bpf", "bpf program returned failure");
+
+close_bpf_object:
+	bpf_object__close(obj);
+
+close_server_fd:
+	close(server_fd);
+
+close_cgroup_fd:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/load_bytes_relative.c b/tools/testing/selftests/bpf/progs/load_bytes_relative.c
new file mode 100644
index 000000000000..4311d406d75f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/load_bytes_relative.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <errno.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} test_result SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int load_bytes_relative(struct __sk_buff *skb)
+{
+	struct ethhdr eth;
+	struct iphdr iph;
+
+	__u32 map_key = 0;
+	__u32 test_passed = 0;
+
+	/* MAC header is not set by the time cgroup_skb/egress triggers */
+	if (bpf_skb_load_bytes_relative(skb, 0, &eth, sizeof(eth),
+					BPF_HDR_START_MAC) != -EFAULT)
+		goto fail;
+
+	if (bpf_skb_load_bytes_relative(skb, 0, &iph, sizeof(iph),
+					BPF_HDR_START_NET))
+		goto fail;
+
+	test_passed = 1;
+
+fail:
+	bpf_map_update_elem(&test_result, &map_key, &test_passed, BPF_ANY);
+
+	return 1;
+}
-- 
2.27.0

