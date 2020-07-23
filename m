Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3D22AE55
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgGWLuw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgGWLun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:50:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96982C0619E2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 04:50:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so4308819edz.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCdePlC5Qk4ANnxojSlJVNKfMf8cx3/y+Fhw96oUEdo=;
        b=ISS3v6JiFS5D5zVuVxdW+4lIUQGfg3JA8qNnaUAlBGLX8MLgPkDN+ba09GkrrKvnvY
         t3tT75PTvwhQOk50auhAx+1z7d0VZ1fNHTBjNUpcWT3uA/82zPE2tPAVOFcaPe93YaX/
         DNMQMQ/D4fjoUOtZLwtQ4Fg74tWSFZrNEvUtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCdePlC5Qk4ANnxojSlJVNKfMf8cx3/y+Fhw96oUEdo=;
        b=LPVGkqqHwWXTqKKnekb8jeT3t5WZD/wYTgeM+WDNTU5ZEXRcqiaQl6FBAEWCzsfrJy
         /fR17rB9mh5lXa/YoqQYzDbF2QoI3Xs8Aw0KEfvBeLeqsY522fHFiABinCtiw2zc7/uc
         nU1SsYQHLpro3RIamEeRb7WC8/J+q2wuE/gP+nAP0JRyUGhvuegxAIZ39CMo62YviYUr
         IdQ8WbH7qR2Gvgj46+aj+6zKpgD700Bgf0C3FcKjhBiWittD/kHrC7S8UwncRn/oNTLk
         zHSiQWQ6a0fikvZd5L3s/3O5k5RCp/Topfm/c2ML0ZmOMlCOWnesefztHdkjURMZPJnM
         3d/w==
X-Gm-Message-State: AOAM5324Z7TxOrhPN8CXJmsR/styMjkkyT+bUjCPnpY97Y6F49qOKt7k
        p9vYuzjakNotIyNUED6H/fudcw==
X-Google-Smtp-Source: ABdhPJxLvVshmZPJO6b28tvMh2IpXbmJYAYmqKEGili6RlOkdNX8aF7VGUrUTeNAX91NkCQ0yCVI4A==
X-Received: by 2002:aa7:c3d7:: with SMTP id l23mr3784859edr.18.1595505041256;
        Thu, 23 Jul 2020 04:50:41 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id h27sm579302eje.23.2020.07.23.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 04:50:40 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v6 7/7] bpf: Add selftests for local_storage
Date:   Thu, 23 Jul 2020 13:50:32 +0200
Message-Id: <20200723115032.460770-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200723115032.460770-1-kpsingh@chromium.org>
References: <20200723115032.460770-1-kpsingh@chromium.org>
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
2.28.0.rc0.105.gf9edc3c819-goog

