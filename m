Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5543635C
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJUNuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhJUNut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 09:50:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D1C0613B9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:48:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f11so669279pfc.12
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOE4lK296m9L6da4WuOTEcb7qddg9J08gatHpRhQgQE=;
        b=Ml8DvUq+M/b3Yff49inTaCp4+H3LHbNI/B+n7GnlcCxQ3ZVtqZmmmmATpEr2b5Y4aX
         05iO+Ka3Yk6foVQAkpgF2v8T0C1W0Sx5giaDJ7yW9hUf74LFhC0IA/EP5PNacAxb0U3B
         GSbocZ3qPkZtGBzmfElfcXzpX+DmQclnOSD0Dc475gEXYfg2lCb2C2lmiZsbh6tRVYSp
         6UIHYQjcKS093yeP3zIfSRyQaEurt/3NpaE+ZtdJZhEwxuaQ/SGji8fLtc5g+Qgx9u5g
         xoYLa4ARQThD4kitmxWFyy9zEVEhd4M4epTwP63BU4xdPXcQG76j2Jkyxb5AV7sGdupm
         Yp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOE4lK296m9L6da4WuOTEcb7qddg9J08gatHpRhQgQE=;
        b=IdCWrR+JaH5Zoiu3WjrKRBmHxnOKw8YNFBNfxGKklpyLf4eDVck1cEyrqNFuHNCzJK
         S/210LJgj3fqVF2tgBL06b7N1squ9NsENp53lurepA8q5P2YckdNoFSn6gnCiMJHlLov
         /sJccnHhppVtfdEpg4xUBa7lO/LHU/NznrTqtEltTS+V/sb87VW68HwcV4zE2/x1WlYK
         qRQt1zMWzJMg8CNXEOM9iFJeWSFy01udIUczSROufUyNQj4auigDxCeOiE1BMnEfHEpQ
         T+9hXPawuTS0iTdewdY++5/r6+lC/LZ4lwVpDFCaBDiduyqHr0ZHsdG4EYOdip86P26J
         5D6w==
X-Gm-Message-State: AOAM533/vVJyddmjpuihtm0QTpoXhRMF34dcjG+kXXoBlsDGZ2GHLv30
        VZr+NlQew9PVtohN2HNn3TUNXr4nsPX5yA==
X-Google-Smtp-Source: ABdhPJyjDUeQ5a9gOfdDApaCru2BbfpeealCIh05ckC9UOiVVRY21XLPHMmvNfoHybr6GVf7blBFlw==
X-Received: by 2002:a62:7cd8:0:b0:44d:4574:ea8a with SMTP id x207-20020a627cd8000000b0044d4574ea8amr5726707pfc.80.1634824113012;
        Thu, 21 Oct 2021 06:48:33 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id f21sm6830067pfc.203.2021.10.21.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:48:32 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test bpf_skc_to_unix_sock() helper
Date:   Thu, 21 Oct 2021 21:47:52 +0800
Message-Id: <20211021134752.1223426-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021134752.1223426-1-hengqi.chen@gmail.com>
References: <20211021134752.1223426-1-hengqi.chen@gmail.com>
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
 .../bpf/progs/test_skc_to_unix_sock.c         | 40 ++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
new file mode 100644
index 000000000000..3eefdfed1db9
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
+static const char *sock_path = "@skc_to_unix_sock";
+
+void test_skc_to_unix_sock(void)
+{
+	struct test_skc_to_unix_sock *skel;
+	struct sockaddr_un sockaddr;
+	int err, sockfd = 0;
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
+	/* trigger unix_listen */
+	sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (!ASSERT_GT(sockfd, 0, "socket failed"))
+		goto cleanup;
+
+	memset(&sockaddr, 0, sizeof(sockaddr));
+	sockaddr.sun_family = AF_UNIX;
+	strncpy(sockaddr.sun_path, sock_path, strlen(sock_path));
+	sockaddr.sun_path[0] = '\0';
+
+	err = bind(sockfd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
+	if (!ASSERT_OK(err, "bind failed"))
+		goto cleanup;
+
+	err = listen(sockfd, 1);
+	if (!ASSERT_OK(err, "listen failed"))
+		goto cleanup;
+
+	ASSERT_EQ(strcmp(skel->bss->path, sock_path), 0, "bpf_skc_to_unix_sock failed");
+
+cleanup:
+	if (sockfd)
+		close(sockfd);
+	test_skc_to_unix_sock__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
new file mode 100644
index 000000000000..a408ec95cba4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+
+const volatile pid_t my_pid = 0;
+char path[256] = {};
+
+SEC("fentry/unix_listen")
+int BPF_PROG(unix_listen, struct socket *sock, int backlog)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	struct unix_sock *unix_sk;
+	int i, len;
+
+	if (pid != my_pid)
+		return 0;
+
+	unix_sk = (struct unix_sock *)bpf_skc_to_unix_sock(sock->sk);
+	if (!unix_sk)
+		return 0;
+
+	if (!UNIX_ABSTRACT(unix_sk))
+		return 0;
+
+	len = unix_sk->addr->len - sizeof(short);
+	path[0] = '@';
+	for (i = 1; i < len; i++) {
+		if (i >= sizeof(struct sockaddr_un))
+			break;
+
+		path[i] = unix_sk->addr->name->sun_path[i];
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

