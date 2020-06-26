Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7D20B651
	for <lists+bpf@lfdr.de>; Fri, 26 Jun 2020 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFZQwl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgFZQwk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 12:52:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5C2C03E979
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 09:52:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w9so10486329ybt.2
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZvkbolhDYPZ077HIxq1Xu+VvR7JsvXtNZjKWk9szn7I=;
        b=lVZlNdrHjJmnHZp1C/Mg4IVHrfILElZYzw0HVZGylOCwI80f3ZVmy78tN1n/g/txMm
         5EXo102ng9XtkGkuDDSMFZdnJVBYW0Ck2BlCaU6lj5aWqMKsQ67afYYBPu0HBEurBOUx
         5vAmqQD8qiKvaxjt0bivJUkg6hx3WhzjVC8C/XeYNfa3Ft2TaKiV6NY+e7RzHKOFOfsA
         5tbvCBmV/obWNPm/5qnixlRs+CJGKulSsQgM3KZjr+lKfIdFbQDSgNfzzAee3/YSidOa
         1b/DFHo+z3dvsZo8x1LxNvTfPCotb89C8SpcadvsdNsOrqQpRA0TkWHgMwBOczMgIlHf
         oFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZvkbolhDYPZ077HIxq1Xu+VvR7JsvXtNZjKWk9szn7I=;
        b=P4RFI9brdcrpL6CgzZ75RBlRrM3RGO2SuaboJYOnvTPDmsqvc/muu7/meinLX6d4za
         frAoED646vhTnF51T+mUuBwVF0lUBIBdasn7iY7C2fV4SQMz+pM0dN6FzIbI5AXrOT3f
         mABWGLVKFB31auOSL58TWI0NyHuqNfV7LXcsrWTUceWUTQMyCpDCXZ5zRqsL//vsqJS9
         oHUE7zafcLkq5Y8sv44fEVP+l0Tc8iPurXFcXY72p0ZZtiAPVBWP4aFLIV284zXqQ3n2
         I0dkVnD4r9ce/Fd8o9tgt1YJIKi4+d6Ww6gpC7EsCXctTG8Q8URC97gmf/yOhfwmjCG1
         R5wQ==
X-Gm-Message-State: AOAM532bA7hjLcsWC7hUHzCTWFkO07WKk+LLnDKQE94ncu/MPpPJ9ui1
        p1sIt2g6bGteEg7WfoWkRJhEBSo=
X-Google-Smtp-Source: ABdhPJzf7JX+OydvL4GIEdUgbNsNk/nEcox1xCQ5ruP6iYvqKcxyq+EsHIOXFOvWCaXuAkuwGNQJhe0=
X-Received: by 2002:a25:abd2:: with SMTP id v76mr6280518ybi.111.1593190358970;
 Fri, 26 Jun 2020 09:52:38 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:52:31 -0700
In-Reply-To: <20200626165231.672001-1-sdf@google.com>
Message-Id: <20200626165231.672001-4-sdf@google.com>
Mime-Version: 1.0
References: <20200626165231.672001-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: test BPF_CGROUP_INET_SOCK_RELEASE
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simple test that enforces a single SOCK_DGRAM socker per cgroup.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/udp_limit.c      | 71 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/udp_limit.c | 42 +++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/udp_limit.c
 create mode 100644 tools/testing/selftests/bpf/progs/udp_limit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/udp_limit.c b/tools/testing/selftests/bpf/prog_tests/udp_limit.c
new file mode 100644
index 000000000000..fe359a927d92
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/udp_limit.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "udp_limit.skel.h"
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+void test_udp_limit(void)
+{
+	struct udp_limit *skel;
+	int cgroup_fd;
+	int fd1, fd2;
+	int err;
+
+	cgroup_fd = test__join_cgroup("/udp_limit");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
+
+	skel = udp_limit__open_and_load();
+	if (CHECK_FAIL(!skel))
+		goto close_cgroup_fd;
+
+	err = bpf_prog_attach(bpf_program__fd(skel->progs.sock),
+			      cgroup_fd, BPF_CGROUP_INET_SOCK_CREATE, 0);
+	if (CHECK_FAIL(err))
+		goto close_skeleton;
+
+	err = bpf_prog_attach(bpf_program__fd(skel->progs.sock_release),
+			      cgroup_fd, BPF_CGROUP_INET_SOCK_RELEASE, 0);
+	if (CHECK_FAIL(err))
+		goto close_skeleton;
+
+	/* BPF program enforces a single UDP socket per cgroup,
+	 * verify that.
+	 */
+	fd1 = socket(AF_INET, SOCK_DGRAM, 0);
+	if (CHECK_FAIL(fd1 < 0))
+		goto close_skeleton;
+
+	fd2 = socket(AF_INET, SOCK_DGRAM, 0);
+	if (CHECK_FAIL(fd2 != -1))
+		goto close_fd1;
+
+	/* We can reopen again after close. */
+	close(fd1);
+
+	fd1 = socket(AF_INET, SOCK_DGRAM, 0);
+	if (CHECK_FAIL(fd1 < 0))
+		goto close_skeleton;
+
+	/* Make sure the program was invoked the expected
+	 * number of times:
+	 * - open fd1           - BPF_CGROUP_INET_SOCK_CREATE
+	 * - attempt to openfd2 - BPF_CGROUP_INET_SOCK_CREATE
+	 * - close fd1          - BPF_CGROUP_INET_SOCK_RELEASE
+	 * - open fd1 again     - BPF_CGROUP_INET_SOCK_CREATE
+	 */
+	if (CHECK_FAIL(skel->bss->invocations != 4))
+		goto close_fd1;
+
+	/* We should still have a single socket in use */
+	if (CHECK_FAIL(skel->bss->in_use != 1))
+		goto close_fd1;
+
+close_fd1:
+	close(fd1);
+close_skeleton:
+	udp_limit__destroy(skel);
+close_cgroup_fd:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/udp_limit.c b/tools/testing/selftests/bpf/progs/udp_limit.c
new file mode 100644
index 000000000000..98fe294d9c21
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/udp_limit.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <sys/socket.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int invocations, in_use;
+
+SEC("cgroup/sock")
+int sock(struct bpf_sock *ctx)
+{
+	__u32 key;
+
+	if (ctx->type != SOCK_DGRAM)
+		return 1;
+
+	__sync_fetch_and_add(&invocations, 1);
+
+	if (&in_use > 0) {
+		/* BPF_CGROUP_INET_SOCK_RELEASE is _not_ called
+		 * when we return an error from the BPF
+		 * program!
+		 */
+		return 0;
+	}
+
+	__sync_fetch_and_add(&in_use, 1);
+	return 1;
+}
+
+SEC("cgroup/sock_release")
+int sock_release(struct bpf_sock *ctx)
+{
+	__u32 key;
+
+	if (ctx->type != SOCK_DGRAM)
+		return 1;
+
+	__sync_fetch_and_add(&invocations, 1);
+	__sync_fetch_and_add(&in_use, -1);
+	return 1;
+}
-- 
2.27.0.212.ge8ba1cc988-goog

