Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7447D3B22
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfJKI3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 04:29:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42840 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJKI3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 04:29:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so6402839lfg.9
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sozellMjvmgbNPebVlIzszVANoZi+GDHppQugK+TDS0=;
        b=w14h8XL8KniYZtB0+V0rqauj29r8ZaV0TBz4PR7idtaONMPa7ZxzdVQFO7Qnt26ecQ
         ip1i37tYzmVPKvTAv8ZEsDi/Yv7EHbLzTgAJYsr5rYDMMUxDbeR7yNWHaXMQuAz0NqA8
         mINFuN46SqMx25IJSXiUK+hzGs80CWPs/v8s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sozellMjvmgbNPebVlIzszVANoZi+GDHppQugK+TDS0=;
        b=EMvW6MnSt5Z8tEVroZtY7m8luQth9s/L6NrI7kAYnnOw7FWKFsBd8iLvTr0aUzr/fa
         WO1H9iDmPZ2GX4+8m0NSNzygHLFPTBalfsG4/sXh9Hm7goP86deviXmA4CRUBg+OjtSs
         WyVkNTvwRwnNTkjhRDGEkzFxx5WPEWWj+DHeTKJFDmFbRI+KZmK1XNYio7CeXqBUQjOS
         8E5k0GVgZ+eSXvu39kHqS3ZxU2GqmYkfwW4TplpoaxJwpSf6MMdXFDabhOZ1v/u5ZM0T
         E7Ds5I3OfRLNXAnCsLZey1wYc2Kg+EGvb7hmkz1bzq9Nmmw0UENF8YEK0F009tZNY7E+
         a1bg==
X-Gm-Message-State: APjAAAUQNWVQHkQKwF7hQpAr3kqxAXzz8RqnZfT6EhmJnU2MRzYsWiuU
        Tm4RzDCXgj9qWsM8C1KkqT7ePJxOeE15sA==
X-Google-Smtp-Source: APXvYqxsVHJoauSSXMOadchyC3meldt3EVJfMy2GGyNWVWeb24Rj1c6CBlL/CIV6SXbxxranDDpXvQ==
X-Received: by 2002:a19:f610:: with SMTP id x16mr7508356lfe.139.1570782591718;
        Fri, 11 Oct 2019 01:29:51 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id h12sm1733535ljg.24.2019.10.11.01.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:29:51 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Check that flow dissector can be re-attached
Date:   Fri, 11 Oct 2019 10:29:46 +0200
Message-Id: <20191011082946.22695-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011082946.22695-1-jakub@cloudflare.com>
References: <20191011082946.22695-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure a new flow dissector program can be attached to replace the old
one with a single syscall. Also check that attaching the same program twice
is prohibited.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 .../bpf/prog_tests/flow_dissector_reattach.c  | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
new file mode 100644
index 000000000000..777faffc4639
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that the flow_dissector program can be updated with a single
+ * syscall by attaching a new program that replaces the existing one.
+ *
+ * Corner case - the same program cannot be attached twice.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <unistd.h>
+
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+
+#include "test_progs.h"
+
+static bool is_attached(int netns)
+{
+	__u32 cnt;
+	int err;
+
+	err = bpf_prog_query(netns, BPF_FLOW_DISSECTOR, 0, NULL, NULL, &cnt);
+	if (CHECK_FAIL(err)) {
+		perror("bpf_prog_query");
+		return true; /* fail-safe */
+	}
+
+	return cnt > 0;
+}
+
+static int load_prog(void)
+{
+	struct bpf_insn prog[] = {
+		BPF_MOV64_IMM(BPF_REG_0, BPF_OK),
+		BPF_EXIT_INSN(),
+	};
+	int fd;
+
+	fd = bpf_load_program(BPF_PROG_TYPE_FLOW_DISSECTOR, prog,
+			      ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
+	if (CHECK_FAIL(fd < 0))
+		perror("bpf_load_program");
+
+	return fd;
+}
+
+static void do_flow_dissector_reattach(void)
+{
+	int prog_fd[2] = { -1, -1 };
+	int err;
+
+	prog_fd[0] = load_prog();
+	if (prog_fd[0] < 0)
+		return;
+
+	prog_fd[1] = load_prog();
+	if (prog_fd[1] < 0)
+		goto out_close;
+
+	err = bpf_prog_attach(prog_fd[0], 0, BPF_FLOW_DISSECTOR, 0);
+	if (CHECK_FAIL(err)) {
+		perror("bpf_prog_attach-0");
+		goto out_close;
+	}
+
+	/* Expect success when attaching a different program */
+	err = bpf_prog_attach(prog_fd[1], 0, BPF_FLOW_DISSECTOR, 0);
+	if (CHECK_FAIL(err)) {
+		perror("bpf_prog_attach-1");
+		goto out_detach;
+	}
+
+	/* Expect failure when attaching the same program twice */
+	err = bpf_prog_attach(prog_fd[1], 0, BPF_FLOW_DISSECTOR, 0);
+	if (CHECK_FAIL(!err || errno != EINVAL))
+		perror("bpf_prog_attach-2");
+
+out_detach:
+	err = bpf_prog_detach(0, BPF_FLOW_DISSECTOR);
+	if (CHECK_FAIL(err))
+		perror("bpf_prog_detach");
+
+out_close:
+	close(prog_fd[1]);
+	close(prog_fd[0]);
+}
+
+void test_flow_dissector_reattach(void)
+{
+	int init_net, err;
+
+	init_net = open("/proc/1/ns/net", O_RDONLY);
+	if (CHECK_FAIL(init_net < 0)) {
+		perror("open(/proc/1/ns/net)");
+		return;
+	}
+
+	err = setns(init_net, CLONE_NEWNET);
+	if (CHECK_FAIL(err)) {
+		perror("setns(/proc/1/ns/net)");
+		goto out_close;
+	}
+
+	if (is_attached(init_net)) {
+		test__skip();
+		printf("Can't test with flow dissector attached to init_net\n");
+		return;
+	}
+
+	/* First run tests in root network namespace */
+	do_flow_dissector_reattach();
+
+	/* Then repeat tests in a non-root namespace */
+	err = unshare(CLONE_NEWNET);
+	if (CHECK_FAIL(err)) {
+		perror("unshare(CLONE_NEWNET)");
+		goto out_close;
+	}
+	do_flow_dissector_reattach();
+
+out_close:
+	close(init_net);
+}
-- 
2.20.1

