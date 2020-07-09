Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891DB21956C
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGIA5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 20:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgGIA5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 20:57:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A6C035422
        for <bpf@vger.kernel.org>; Wed,  8 Jul 2020 17:57:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so497523wrw.5
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2020 17:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LUxAcH1p2jd4UOhn99gfFC8uQP4AVfDHydIOJan7II=;
        b=VEPpOvKVaaGIO6ll0jLBZoQTx9mHMVlH9xuAIBP1yTosHkOx851zxu1lzn4ZoUfClw
         TkBVbYAOsSa+hB2Xyn1fpHjgnqykKXSnk16BNNCsX5bEcmCiQehbMRcW0Stp2wWriqpf
         9hPwK5Cz5htTUUSLMJhbegnnf/jShGSaagelI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LUxAcH1p2jd4UOhn99gfFC8uQP4AVfDHydIOJan7II=;
        b=EZwg05mpFAvcrczWHyeYlj0wgr76digqVdIrZy2iSnVF7f7GmQjIDs52IjACUSAQz6
         NDvaJCpSmda4Bi0TJN+638ofL+t/RlUc/i1O0fMbdRXqBZOwiw6LTdX8K9PVfR/iCPO3
         ZQJcTGGyt+ZXGukiJDi6xTGfTXRwkNP4DCaNOacywP7Q/CJrq+pzJPEO3JsK0DBVeVmJ
         4wVqPSxdnd/krpi9ft1c44mpECgPXeWgcn5OVNMyZOgYGjgTpIQdMDlB2rVM3zTPqJgY
         5AuAE23UAy9beZKdLzQ9R4EuPPCYwZPOvkGCT+9iddAb4hxUfC2ODL/yVx5AWrk7l5Vm
         Qn5g==
X-Gm-Message-State: AOAM530GdGjnTGkw9SJIE2BA6fDTimCTXrg7Wpl9A27xW3rdXmytAmNT
        IzN1xYu6P5i5KNTr8DQmbRtqLA==
X-Google-Smtp-Source: ABdhPJzyI+jXLPf7mqmyDALcYSrJOmkImq+nqECTtOymvxaH5xzR5NKIa783yY11NP4prI0whh+aRQ==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr61130323wrm.121.1594256221301;
        Wed, 08 Jul 2020 17:57:01 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id f15sm2465498wrx.91.2020.07.08.17.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:57:00 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 4/4] bpf: Add selftests for local_storage
Date:   Thu,  9 Jul 2020 02:56:54 +0200
Message-Id: <20200709005654.3324272-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
In-Reply-To: <20200709005654.3324272-1-kpsingh@chromium.org>
References: <20200709005654.3324272-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

inode_local_storage:

* Hook to the file_open and inode_unlink LSM hooks.
* Create and unlink a temporary file.
* Store some information in the inode's bpf_local_storage during
  file_open.
* Verify that this information exists when the file is unlinked.

sk_local_storage:

* Hook to the socket_post_create and socket_bind LSM hooks.
* Open and bind a socket and set the sk_storage in the
  socket_post_create hook using the start_server helper.
* Verify if the information is set in the socket_bind hook.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c       |  60 ++++++++
 .../selftests/bpf/progs/local_storage.c       | 136 ++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
new file mode 100644
index 000000000000..d4ba89195c43
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <linux/limits.h>
+
+#include "local_storage.skel.h"
+#include "network_helpers.h"
+
+int create_and_unlink_file(void)
+{
+	char fname[PATH_MAX] = "/tmp/fileXXXXXX";
+	int fd;
+
+	fd = mkstemp(fname);
+	if (fd < 0)
+		return fd;
+
+	close(fd);
+	unlink(fname);
+	return 0;
+}
+
+void test_test_local_storage(void)
+{
+	struct local_storage *skel = NULL;
+	int err, duration = 0, serv_sk = -1;
+
+	skel = local_storage__open_and_load();
+	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
+		goto close_prog;
+
+	err = local_storage__attach(skel);
+	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
+		goto close_prog;
+
+	skel->bss->monitored_pid = getpid();
+
+	err = create_and_unlink_file();
+	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	CHECK(!skel->bss->inode_storage_result, "inode_storage_result",
+	      "inode_local_storage not set");
+
+	serv_sk = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"))
+		goto close_prog;
+
+	CHECK(!skel->bss->sk_storage_result, "sk_storage_result",
+	      "sk_local_storage not set");
+
+	close(serv_sk);
+
+close_prog:
+	local_storage__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
new file mode 100644
index 000000000000..cb608b7b90f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <errno.h>
+#include <linux/bpf.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define DUMMY_STORAGE_VALUE 0xdeadbeef
+
+int monitored_pid = 0;
+bool inode_storage_result = false;
+bool sk_storage_result = false;
+
+struct dummy_storage {
+	__u32 value;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct dummy_storage);
+} inode_storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
+	__type(key, int);
+	__type(value, struct dummy_storage);
+} sk_storage_map SEC(".maps");
+
+/* TODO Use vmlinux.h once BTF pruning for embedded types is fixed.
+ */
+struct sock {} __attribute__((preserve_access_index));
+struct sockaddr {} __attribute__((preserve_access_index));
+struct socket {
+	struct sock *sk;
+} __attribute__((preserve_access_index));
+
+struct inode {} __attribute__((preserve_access_index));
+struct dentry {
+	struct inode *d_inode;
+} __attribute__((preserve_access_index));
+struct file {
+	struct inode *f_inode;
+} __attribute__((preserve_access_index));
+
+
+SEC("lsm/inode_unlink")
+int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct dummy_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	storage = bpf_inode_storage_get(&inode_storage_map, victim->d_inode, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0;
+
+	if (storage->value == DUMMY_STORAGE_VALUE)
+		inode_storage_result = true;
+
+	return 0;
+}
+
+SEC("lsm/socket_bind")
+int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
+	     int addrlen)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct dummy_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0;
+
+	if (storage->value == DUMMY_STORAGE_VALUE)
+		sk_storage_result = true;
+
+	return 0;
+}
+
+SEC("lsm/socket_post_create")
+int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
+	     int protocol, int kern)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct dummy_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0;
+
+	storage->value = DUMMY_STORAGE_VALUE;
+
+	return 0;
+}
+
+SEC("lsm/file_open")
+int BPF_PROG(test_int_hook, struct file *file)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct dummy_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	if (!file->f_inode)
+		return 0;
+
+	storage = bpf_inode_storage_get(&inode_storage_map, file->f_inode, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0;
+
+	storage->value = DUMMY_STORAGE_VALUE;
+	return 0;
+}
-- 
2.27.0.389.gc38d7665816-goog

