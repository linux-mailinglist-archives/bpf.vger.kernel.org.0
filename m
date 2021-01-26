Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C82305C07
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 13:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313228AbhAZWwH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbhAZRFN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 12:05:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607BC0610D6
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 08:51:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t14so9996805plr.15
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FJcc6MaSwZQRYOWrg1XK9d9cSH1sraaN8OpW2J95iRQ=;
        b=QSkfO0h4d/vctYI3z52+MQly82DrobeOliUI16mTKFwNS9EsEjBU7YOSzIkr1BG7Jz
         +euw2Fr8jmX5MtDMVJXBsHp/XtSO5LUKZGQiG2TtxCDqF5YiAtXW0OwAtl4meNlw6Bsc
         5/+NvZLmB4ulBnxBi+rH/b6gSPuJ0yYgO0pP4LInAgzeKi+e5x/U8PTn8X0YMfyuaCGb
         vMSLmt6Z/ps7LoVFxJijVY2jLI0Z5AWmTmcmaOzr9En+8DFy1j1rsAYJEqQJGWkuPFta
         0s8MUNTm1sqkweir7vwns+3f8vbZ8GKkxrnmdz7EFZzYrIJ7eYlGP4QV+SMO5cGJ8/xv
         S2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FJcc6MaSwZQRYOWrg1XK9d9cSH1sraaN8OpW2J95iRQ=;
        b=W5R9HWkd+WyqHJnPe3I6roHOeykqudoH6bdUumI8j3aXBho0Andl6QOzUlVER8ZuVX
         2n0aOeDLAqhHY89wiCHw02/GstscLtDr7p/1TKkNiNmnSzsFziUE96fmt9XDKauP3gxg
         C/TRWALpLHDo1y5CSmv2orIjb57AIFk+QAreEMi69qFX056IwT9mK4SFqjZHQOBed5nz
         0cP16akXUcz6YPiEGQHiUE0PvkgfiCRYJw3A7UOCQFx+XWFr9wy+rKmEiL1xR7DDzaM6
         5v1YNlZoUd2UWZhHcxJndsehPdJLoQHNt7U45QmL5Zp4XFrtNWQu6o5uH2wRqp+kkaW/
         pMXA==
X-Gm-Message-State: AOAM533YGBw5ruSHbYdcAP/TBEJ3qpTxb+t1vOW/4qiRAao3hfZg0NZ5
        UdHBdECUzHZfBZx8dEpYxKypP5o=
X-Google-Smtp-Source: ABdhPJwv4t7xSnFbkbrmYAgMUBcmRK0xqfqrObkr8p7LyBbF01J1rr3ChaxGxiUgFcwu+4vxm1aiKnU=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a62:6047:0:b029:1ac:6091:cf50 with SMTP id
 u68-20020a6260470000b02901ac6091cf50mr6087096pfb.40.1611679867930; Tue, 26
 Jan 2021 08:51:07 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:51:04 -0800
In-Reply-To: <20210126165104.891536-1-sdf@google.com>
Message-Id: <20210126165104.891536-2-sdf@google.com>
Mime-Version: 1.0
References: <20210126165104.891536-1-sdf@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: verify that rebinding to port
 < 1024 from BPF works
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Return 3 to indicate that permission check for port 111
should be skipped.

Cc: Andrey Ignatov <rdna@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/bind_perm.c      | 80 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bind_perm.c | 36 +++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bind_perm.c
 create mode 100644 tools/testing/selftests/bpf/progs/bind_perm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
new file mode 100644
index 000000000000..763de148e511
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "bind_perm.skel.h"
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/capability.h>
+
+static int duration;
+
+void try_bind(int port, int expected_errno)
+{
+	struct sockaddr_in sin = {};
+	int fd = -1;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (CHECK(fd < 0, "fd", "errno %d", errno))
+		goto close_socket;
+
+	sin.sin_family = AF_INET;
+	sin.sin_port = htons(port);
+
+	errno = 0;
+	bind(fd, (struct sockaddr *)&sin, sizeof(sin));
+	ASSERT_EQ(errno, expected_errno, "bind");
+
+close_socket:
+	if (fd >= 0)
+		close(fd);
+}
+
+void cap_net_bind_service(cap_flag_value_t flag)
+{
+	const cap_value_t cap_net_bind_service = CAP_NET_BIND_SERVICE;
+	cap_t caps;
+
+	caps = cap_get_proc();
+	if (CHECK(!caps, "cap_get_proc", "errno %d", errno))
+		goto free_caps;
+
+	if (CHECK(cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_net_bind_service,
+			       flag),
+		  "cap_set_flag", "errno %d", errno))
+		goto free_caps;
+
+	if (CHECK(cap_set_proc(caps), "cap_set_proc", "errno %d", errno))
+		goto free_caps;
+
+free_caps:
+	if (CHECK(cap_free(caps), "cap_free", "errno %d", errno))
+		goto free_caps;
+}
+
+void test_bind_perm(void)
+{
+	struct bind_perm *skel;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/bind_perm");
+	if (CHECK(cgroup_fd < 0, "cg-join", "errno %d", errno))
+		return;
+
+	skel = bind_perm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto close_cgroup_fd;
+
+	skel->links.bind_v4_prog = bpf_program__attach_cgroup(skel->progs.bind_v4_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel, "bind_v4_prog"))
+		goto close_skeleton;
+
+	cap_net_bind_service(CAP_CLEAR);
+	try_bind(110, EACCES);
+	try_bind(111, 0);
+	cap_net_bind_service(CAP_SET);
+
+close_skeleton:
+	bind_perm__destroy(skel);
+close_cgroup_fd:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/bind_perm.c b/tools/testing/selftests/bpf/progs/bind_perm.c
new file mode 100644
index 000000000000..e89bd264ed26
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bind_perm.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/stddef.h>
+#include <linux/bpf.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+SEC("cgroup/bind4")
+int bind_v4_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock *sk;
+	__u32 user_ip4;
+	__u16 user_port;
+
+	sk = ctx->sk;
+	if (!sk)
+		return 0;
+
+	if (sk->family != AF_INET)
+		return 0;
+
+	if (ctx->type != SOCK_STREAM)
+		return 0;
+
+	/* Return 1 OR'ed with the first bit set to indicate
+	 * that CAP_NET_BIND_SERVICE should be bypassed.
+	 */
+	if (ctx->user_port == bpf_htons(111))
+		return (1 | 2);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.0.280.ga3ce27912f-goog

