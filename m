Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83184236D9
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 06:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhJFEJI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 00:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhJFEJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 00:09:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971AC061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 21:07:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m26so1242283pff.3
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 21:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UV95gCH/A0zUMd47XZZwVHKwhU4S7wZsOsteWRQmQPg=;
        b=CKHFCqPslVPCCqSYLD+PeB8jqWFCmffJc6Ona3pdlFi0d+p5n9/xT5SyzCSgAXHMnH
         xf9ou77grWJp8+i3rc7VOHiBBO7gteQiUhzd1EuXNpbqO7m/Z2xXx3PaVfvVsAVid4TF
         W2AVHmc2nfO4QlcuvZIMHm1JMag9emWu3nwWpQw98U/aEJaJJC0/lm6fJJTtAcNQGb3P
         APNSmaKk7sBC1DIruanzcIMrVauZAG/493582Gv41SNLCJoL5oXDSNXZbPvSY4tPhrTU
         donzDvRH8HqcVGorplgO7mz+aOdOe9Xce4r7Tl1lFTsxHMiuMEAxa2w4iVN1cEkufTpS
         nuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UV95gCH/A0zUMd47XZZwVHKwhU4S7wZsOsteWRQmQPg=;
        b=YZ0uDwhqWrlTqPv1ViE7I90F1Y4w22VjI/8imqRvgFldLh4TUAmcjvhE1T15bGpyzY
         0MCH88vhMnhORTL+vV8yYFA+MgcYkdN0V4ltIh6gMDfSwXRNrgDFuN9haTICiT26NqX7
         Q8friq4LbBwqCPz21MAnVInaBYFWURxYNt7lCaMkFaK8ehqXTzxXpSsb1AtJ34ckZG6B
         YmfI4jDC7CjTtXBO3gEpc3fGmvUy8j3b1SmzAiUupAynsERanGA3ZJefN/5jD4Bg/Lp7
         Ps+4C6BAHBP5fY0adWhykWsebFCzVOkgkJUUo1q12+Hzqjnnurd5R+efa9xwSg92hE9M
         cbEQ==
X-Gm-Message-State: AOAM533n+7t5ZWt5sWh8sxPm4YhNee4pxHEKZRB8hW3ihGyEQmRFj+IQ
        0kquvysebn2SNbB1/MVOL7xdHIt+D2SZ7g==
X-Google-Smtp-Source: ABdhPJwD39R/Mg0OOK7R2AW3xSbskTSL2oqAOz0EuCL2SVTiSw2nLxJQJ/IFLoLBEA/ZpSYILSPSEA==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr17954994pgs.45.1633493235582;
        Tue, 05 Oct 2021 21:07:15 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id b21sm20846965pfv.96.2021.10.05.21.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 21:07:15 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_skc_to_unix_sock()
Date:   Wed,  6 Oct 2021 12:06:23 +0800
Message-Id: <20211006040623.401527-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006040623.401527-1-hengqi.chen@gmail.com>
References: <20211006040623.401527-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new test which triggers unix_listen kernel function
to test bpf_skc_to_unix_sock helper.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../bpf/prog_tests/skc_to_unix_sock.c         | 54 +++++++++++++++++++
 .../bpf/progs/test_skc_to_unix_sock.c         | 28 ++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
new file mode 100644
index 000000000000..5d8ed76a71dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include <test_progs.h>
+#include <sys/un.h>
+#include "test_skc_to_unix_sock.skel.h"
+
+static const char *sock_path = "/tmp/test.sock";
+
+void test_skc_to_unix_sock(void)
+{
+	struct test_skc_to_unix_sock *skel;
+	struct sockaddr_un sockaddr;
+	int err, len, sockfd = 0;
+
+	skel = test_skc_to_unix_sock__open();
+	if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
+		return;
+
+	skel->rodata->my_pid = getpid();
+
+	err = test_skc_to_unix_sock__load(skel);
+	if (!ASSERT_OK(err, "could not load BPF object"))
+		goto cleanup;
+
+	err = test_skc_to_unix_sock__attach(skel);
+	if (!ASSERT_OK(err, "could not attach BPF object"))
+		goto cleanup;
+
+	// trigger unix_listen
+	sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (!ASSERT_GT(sockfd, 0, "socket failed"))
+		goto cleanup;
+
+	sockaddr.sun_family = AF_UNIX;
+	strcpy(sockaddr.sun_path, sock_path);
+	len = sizeof(sockaddr);
+	unlink(sock_path);
+
+	err = bind(sockfd, (struct sockaddr *)&sockaddr, len);
+	if (!ASSERT_OK(err, "bind failed"))
+		goto cleanup;
+
+	err = listen(sockfd, 1);
+	if (!ASSERT_OK(err, "listen failed"))
+		goto cleanup;
+
+	ASSERT_GT(skel->bss->ret, 0, "bpf_skc_to_unix_sock failed");
+
+cleanup:
+	if (sockfd)
+		close(sockfd);
+	test_skc_to_unix_sock__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
new file mode 100644
index 000000000000..544d2ed56d7e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+const volatile pid_t my_pid = 0;
+__u64 ret = 0;
+
+SEC("fentry/unix_listen")
+int BPF_PROG(unix_listen, struct socket *sock, int backlog)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	struct unix_sock *unix_sk;
+
+	if (pid != my_pid)
+		return 0;
+
+	unix_sk = (struct unix_sock *)bpf_skc_to_unix_sock(sock->sk);
+	if (!unix_sk)
+		return 0;
+
+	ret = (__u64)unix_sk;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
--
2.25.1
