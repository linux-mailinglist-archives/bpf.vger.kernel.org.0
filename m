Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B264221141B
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGAUNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgGAUNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 16:13:17 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CCCC08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 13:13:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id v24so18798056pgl.5
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ad9C5uLahkSIPyWJgO1D3o2iIwB9TsBxO1NANkErTuM=;
        b=k5De39mpv5M9E4DyG0KPOpg7dz+geldPUSWUvDcQeQ022JKmZlJalx1fLPOyYKrHma
         LDcUqAks+wCM+6bTRbk22M/7sFOfoc/TmpFXRXhd0Nq03TDjoOPHKGpl2ztNadOkc7F5
         1xE01ANFE98ww2sPnBOkQjGqksBi58GgYKf3WB8APKrpGo6YGVWeI6fHBozNwtH680a/
         06KZRBHkz1rRH7Cs3BubONYEoMlNQ4/Ivc32mwqQ0uhXVTNSlL2Yz2HEDPsooC5qvvLa
         HsdkQpsvhRbyC19LfWt7S6JLfAM3kxf/n8OFuRj3Q4HflFErdNOJM6gEdFURLsl/m1cH
         D8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ad9C5uLahkSIPyWJgO1D3o2iIwB9TsBxO1NANkErTuM=;
        b=L/cIsSYDUBKyUIQSPF5dybp8sKDA3oi8MXla+EDTIO1zv+ljsRSbDcxOLC1Rl5B3p2
         mXY3c7DixXfPUqKXxcmNECOc773tQFBSIisN7k8YJUGngUNT8tREGE8QGkJWzBOpdJeW
         hqeKbYRvVoR1yCpse/H3H/z/IiV1qnX7c7/HNJWkaY39yvNjq9UjQxrEfsHNDcZRk+Cd
         AYUr/z2JnCIHsYep9FeNVl4q8ZPGnNVY4x4ewMPWL5hwYIeh8/AeVmPWVR5+qX5+19rE
         5FApVFp6QnU7SfTUTraI6TLY8e0ZzMzH2aP82Kz+PwYxYdSOPHzKpnP7u7a2NHa3YgiN
         g1kQ==
X-Gm-Message-State: AOAM531MYvWc/xySmB7dYEMg79SMVYTiXxFlLGpH534JlW8vNnsnihuI
        f4mPn+0NcxdP6iToyz/oN/gBRg0=
X-Google-Smtp-Source: ABdhPJyHNKxAD7DnQh+lXn42+VFi5PlLvtt3s8loSTq+5XmYVRV4R7c13S6K53SH/Ri889B0suWgMJs=
X-Received: by 2002:a17:90a:1c16:: with SMTP id s22mr29307947pjs.108.1593634396942;
 Wed, 01 Jul 2020 13:13:16 -0700 (PDT)
Date:   Wed,  1 Jul 2020 13:13:07 -0700
In-Reply-To: <20200701201307.855717-1-sdf@google.com>
Message-Id: <20200701201307.855717-5-sdf@google.com>
Mime-Version: 1.0
References: <20200701201307.855717-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: test BPF_CGROUP_INET_SOCK_RELEASE
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
 .../selftests/bpf/prog_tests/udp_limit.c      | 72 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/udp_limit.c | 42 +++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/udp_limit.c
 create mode 100644 tools/testing/selftests/bpf/progs/udp_limit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/udp_limit.c b/tools/testing/selftests/bpf/prog_tests/udp_limit.c
new file mode 100644
index 000000000000..510c928c1496
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/udp_limit.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "udp_limit.skel.h"
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+static int duration;
+
+void test_udp_limit(void)
+{
+	struct udp_limit *skel;
+	int cgroup_fd;
+	int fd1, fd2;
+
+	cgroup_fd = test__join_cgroup("/udp_limit");
+	if (CHECK(cgroup_fd < 0, "cg-join", "errno %d", errno))
+		return;
+
+	skel = udp_limit__open_and_load();
+	if (CHECK(!skel, "skel-load", "errno %d", errno))
+		goto close_cgroup_fd;
+
+	skel->links.sock = bpf_program__attach_cgroup(skel->progs.sock, cgroup_fd);
+	skel->links.sock_release = bpf_program__attach_cgroup(skel->progs.sock_release, cgroup_fd);
+	if (CHECK(IS_ERR(skel->links.sock) || IS_ERR(skel->links.sock_release),
+		  "cg-attach", "sock %ld sock_release %ld",
+		  PTR_ERR(skel->links.sock),
+		  PTR_ERR(skel->links.sock_release)))
+		goto close_skeleton;
+
+	/* BPF program enforces a single UDP socket per cgroup,
+	 * verify that.
+	 */
+	fd1 = socket(AF_INET, SOCK_DGRAM, 0);
+	if (CHECK(fd1 < 0, "fd1", "errno %d", errno))
+		goto close_skeleton;
+
+	fd2 = socket(AF_INET, SOCK_DGRAM, 0);
+	if (CHECK(fd2 >= 0, "fd2", "errno %d", errno))
+		goto close_fd1;
+
+	/* We can reopen again after close. */
+	close(fd1);
+
+	fd1 = socket(AF_INET, SOCK_DGRAM, 0);
+	if (CHECK(fd1 < 0, "fd1-again", "errno %d", errno))
+		goto close_skeleton;
+
+	/* Make sure the program was invoked the expected
+	 * number of times:
+	 * - open fd1           - BPF_CGROUP_INET_SOCK_CREATE
+	 * - attempt to openfd2 - BPF_CGROUP_INET_SOCK_CREATE
+	 * - close fd1          - BPF_CGROUP_INET_SOCK_RELEASE
+	 * - open fd1 again     - BPF_CGROUP_INET_SOCK_CREATE
+	 */
+	if (CHECK(skel->bss->invocations != 4, "bss-invocations",
+		  "invocations=%d", skel->bss->invocations))
+		goto close_fd1;
+
+	/* We should still have a single socket in use */
+	if (CHECK(skel->bss->in_use != 1, "bss-in_use",
+		  "in_use=%d", skel->bss->in_use))
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
index 000000000000..af1154bfb946
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
+	if (in_use > 0) {
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

