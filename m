Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238171F5B60
	for <lists+bpf@lfdr.de>; Wed, 10 Jun 2020 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgFJSmA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jun 2020 14:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJSmA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 14:42:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5045BC03E96B
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:42:00 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x18so3003319ilp.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuDKJlFvrWQvHtXyu6wvCFHG/oEtjAHJCgNoRHZmo34=;
        b=tWx62ZlinY6sCnswL+zBLEKNK92wBQHgt1vAEsJMsYSlziSYiH3j9qhUQp/mUSShPX
         CLOhYWcDCm87NTw7cLhv22433FP9fZLdN6mX+//mAXs0kmbdE21M19NaaQjbg1KZgse0
         rRp4CwWGz5XpVjhiwB0utcmQt1NA72f0SLFF4pGzQj6BpEl/puwPG/7eD7UIu8Z2GnNJ
         GIkKGPhVJ7AXcXVY26zg0S1YfDPPwOFv8l6SGEB2ifKuiNXNgM74ftlMuZqy55Yk+oMO
         QZQO077EXRAZEz0Qj0k5fdSttceQL0oOZ3b7ZMvQHfilwKQ8B9aSY9XGkuo1vXk8I9sY
         9pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuDKJlFvrWQvHtXyu6wvCFHG/oEtjAHJCgNoRHZmo34=;
        b=bwCuQsGluc9eSdIrSlooWD839mhZtCdpptX9+Zg4iN+pjSxUeuq1W4h6tL6xUasPWX
         saen+ZeWLn4CoZoj6PGvCr3M5D9kF1Zkk34YoV+aK+DdV5XZLoOYD3g+YhttOZhRyfR1
         NbF9V1Dz5FyG2INJCYLVJt8Hi5Qojjm+9MG4Eig3RYucLJaMpv0NliN08KajdNVmvc4A
         GP5HPRa5v4WmHq6PWjX5W6B8S1rd30ajPiYqqLRlgy+cMibL4G3F0WkIeWMtZHZcBsa7
         +VnDYMJupFtkKLlEnWUxkSGgQqmaGrqZN+hJajZyNY89pdpRlanngFbFl5hZbg3ZREBM
         q4jw==
X-Gm-Message-State: AOAM532qvJMsC5z6MU0A9QifYgfAYj4Yn9jkRhD+FwBLzCJtK9YJ+WD6
        ClTxd10PhMY9qaI+S223YBufbRBhEIVPbg==
X-Google-Smtp-Source: ABdhPJykB5qlwhx1AGjQD78zhXw7yfa9N8G+iSGMYXgVMkk0D4k6WDorrCf0K5oCbuph6I8wYDEuvg==
X-Received: by 2002:a92:c84f:: with SMTP id b15mr4082955ilq.123.1591814519263;
        Wed, 10 Jun 2020 11:41:59 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id b13sm319587ilq.20.2020.06.10.11.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:41:57 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
X-Google-Original-From: YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add cgroup_skb/egress test for load_bytes_relative
Date:   Wed, 10 Jun 2020 13:41:40 -0500
Message-Id: <9028ccbea4385a620e69c0a104f469ffd655c01e.1591812755.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591812755.git.zhuyifei@google.com>
References: <cover.1591812755.git.zhuyifei@google.com>
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

Another assertion is added that reading from a large offset, past
the end of packet, returns -EFAULT.

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/load_bytes_relative.c      | 71 +++++++++++++++++++
 .../selftests/bpf/progs/load_bytes_relative.c | 48 +++++++++++++
 2 files changed, 119 insertions(+)
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
index 000000000000..dc1d04a7a3d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/load_bytes_relative.c
@@ -0,0 +1,48 @@
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
+	if (bpf_skb_load_bytes_relative(skb, 0xffff, &iph, sizeof(iph),
+					BPF_HDR_START_NET) != -EFAULT)
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

