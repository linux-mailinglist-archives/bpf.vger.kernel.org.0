Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC5D0B94
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfJIJnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 05:43:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34169 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730590AbfJIJnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 05:43:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so1150919lfm.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jqKgJjrRigHyiU6VMyL23MdzrrSE9bHAepivBIrc2Q=;
        b=Am+LQh/CcWZJJEkM6arbYSrUWD+70GMyUqET9RtTkejyCVCchXePyQoucfk6Mn+bnF
         3lDWwWRAd9o6A7xD5lgUUC+tFajTT32IHWMLxdp5+Z70iMfgOzlnDERtZaShY+K9Zbav
         a7JEfaye+2We0BQcewlGOOyA0uDUWItI+Nb3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jqKgJjrRigHyiU6VMyL23MdzrrSE9bHAepivBIrc2Q=;
        b=O2Szp6j6j7UcgSECFwOWYCDUA0rxeUUqxCHd/Td1PnZO1svggo+rU25XGqis2EKggY
         qSRGHByTKUluXuIWllm2lVAjRTlJDvkNcuxAa8z/MyNW1V4mw13UPSu2SbAAGPw2jQ3r
         VprdaFFcBCOH0NN96F1km1xd8LzpeGE0HDnJZ6z4+rRICXDfWJf38Iof7uPoDw9NVYx2
         7JFecExEzpqcHooqs1XPOkS1oSLQ9rR+4vUol6JJIvycirck1ZzS/QXr2EEWYlD+Ryl4
         /C6YFSa08tACL0Ehut0SPSKW6iCvmFe35ZtF9SxNgMdTKTrEi+8a1cRzXSWGrZWScO0t
         M9OA==
X-Gm-Message-State: APjAAAU4sneivgUaWOr7zaY0ZH7pKUQZpg4f6UhRSjG0By12ImnFoACN
        ZtqYdl7QAgry/MbWsDdrpxCNjuqUuUjHWA==
X-Google-Smtp-Source: APXvYqwa352iwhIIFdOuAAMXoLhAUoUveJCW/dS+u94yV6Nxp7pT8qghixPa9zR2cMGp56/yLFxJqg==
X-Received: by 2002:a19:91:: with SMTP id 139mr1434767lfa.11.1570614195849;
        Wed, 09 Oct 2019 02:43:15 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id q24sm373036lfa.94.2019.10.09.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:43:15 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATH bpf-next 2/2] selftests/bpf: Check that flow dissector can be re-attached
Date:   Wed,  9 Oct 2019 11:43:12 +0200
Message-Id: <20191009094312.15284-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009094312.15284-1-jakub@cloudflare.com>
References: <20191009094312.15284-1-jakub@cloudflare.com>
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
---
 .../bpf/prog_tests/flow_dissector_reattach.c  | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
new file mode 100644
index 000000000000..0f0006c93956
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that the flow_dissector program can be updated with a single
+ * syscall by attaching a new program that replaces the existing one.
+ *
+ * Corner case - the same program cannot be attached twice.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <unistd.h>
+
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+
+#include "test_progs.h"
+
+/* Not used here. For CHECK macro sake only. */
+static int duration;
+
+static bool is_attached(void)
+{
+	bool attached = true;
+	int err, net_fd = -1;
+	__u32 cnt;
+
+	net_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (net_fd < 0)
+		goto out;
+
+	err = bpf_prog_query(net_fd, BPF_FLOW_DISSECTOR, 0, NULL, NULL, &cnt);
+	if (CHECK(err, "bpf_prog_query", "ret %d errno %d\n", err, errno))
+		goto out;
+
+	attached = (cnt > 0);
+out:
+	close(net_fd);
+	return attached;
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
+	CHECK(fd < 0, "bpf_load_program", "ret %d errno %d\n", fd, errno);
+
+	return fd;
+}
+
+void test_flow_dissector_reattach(void)
+{
+	int prog_fd[2] = { -1, -1 };
+	int err;
+
+	if (is_attached())
+		return;
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
+	if (CHECK(err, "bpf_prog_attach-0", "ret %d errno %d\n", err, errno))
+		goto out_close;
+
+	/* Expect success when attaching a different program */
+	err = bpf_prog_attach(prog_fd[1], 0, BPF_FLOW_DISSECTOR, 0);
+	if (CHECK(err, "bpf_prog_attach-1", "ret %d errno %d\n", err, errno))
+		goto out_detach;
+
+	/* Expect failure when attaching the same program twice */
+	err = bpf_prog_attach(prog_fd[1], 0, BPF_FLOW_DISSECTOR, 0);
+	CHECK(!err || errno != EINVAL, "bpf_prog_attach-2",
+	      "ret %d errno %d\n", err, errno);
+
+out_detach:
+	err = bpf_prog_detach(0, BPF_FLOW_DISSECTOR);
+	CHECK(err, "bpf_prog_detach", "ret %d errno %d\n", err, errno);
+
+out_close:
+	close(prog_fd[1]);
+	close(prog_fd[0]);
+}
-- 
2.20.1

