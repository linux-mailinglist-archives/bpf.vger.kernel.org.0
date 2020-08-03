Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0828A23AACE
	for <lists+bpf@lfdr.de>; Mon,  3 Aug 2020 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgHCQrV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 12:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHCQrJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 12:47:09 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDDBC06174A
        for <bpf@vger.kernel.org>; Mon,  3 Aug 2020 09:47:09 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id df16so11374168edb.9
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAvQqYLNqENG5P4WF9eHdtOffvT73vophgktB3OBGIM=;
        b=PX7Mq3EN1wryjiLANo3RjZxhLhS55ghqlm92TTh3gQ/N9nBt2PSelbQMckStTdB+h2
         6HLbgVPbwqpZTAZ5SWTlSxe3F+siSmoQnPsU97uoReh1IzYpqIHbTwImVcGNbg/SO5Ib
         aGu5S5P4W+ZUCD/dmqz2PH0PR8FhSTXqb+WYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tAvQqYLNqENG5P4WF9eHdtOffvT73vophgktB3OBGIM=;
        b=e/mD+b+ifB3jBRJxgfHeZUwmstZZXdExIuNU+HW3AI5un8Twn46xASXmMrbnUfVFXb
         3UI4iNOLEyNnXgLEGkp7+4sfEl7SGdLb6mZWi2GcHNt0F0LyZ4T8W5X0Kl2nxJEnVCPR
         mW8rQtoU4MMv/hJPJjffd9hGMREnhSBrq+xuUt6n96YBC9uS397VYYtuCkz9sbvim8yq
         aP5KNVpg9rChvSNGfaNQedQ7lRFIgUazMBEwa3TsQ51yr6JMl+u0r0qLoViLTpbgHjEC
         bmWt2RylXXRNRNn/slXKv4e51tlurwDgpGi0YSuJt8RO8j+leOqEyi2O2A2tyuvVszgZ
         C6Mg==
X-Gm-Message-State: AOAM530Em1Z3XUNkTwuMtZ01zp4oUa8zKTJFNsRErWFpvocTeLd6s/Zi
        9cAhwQ491ut1N4hfMGean9UortUL8EZr1Q==
X-Google-Smtp-Source: ABdhPJwMiFnfI7HZsOWG0ZIqgM01s7Am7ys35hjDSRyU/f6Tw31TGEtjXT0uZnXNI3/JfrvaSUmvvQ==
X-Received: by 2002:a50:9e6f:: with SMTP id z102mr16959862ede.300.1596473227622;
        Mon, 03 Aug 2020 09:47:07 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id j7sm16385654ejb.64.2020.08.03.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:47:06 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v8 7/7] bpf: Add selftests for local_storage
Date:   Mon,  3 Aug 2020 18:46:55 +0200
Message-Id: <20200803164655.1924498-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803164655.1924498-1-kpsingh@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
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
 .../selftests/bpf/progs/local_storage.c       | 140 ++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
new file mode 100644
index 000000000000..91cd6f357246
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
+	CHECK(skel->data->inode_storage_result != 0, "inode_storage_result",
+	      "inode_local_storage not set\n");
+
+	serv_sk = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"))
+		goto close_prog;
+
+	CHECK(skel->data->sk_storage_result != 0, "sk_storage_result",
+	      "sk_local_storage not set\n");
+
+	close(serv_sk);
+
+close_prog:
+	local_storage__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
new file mode 100644
index 000000000000..0758ba229ae0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -0,0 +1,140 @@
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
+int inode_storage_result = -1;
+int sk_storage_result = -1;
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
+		inode_storage_result = -1;
+
+	inode_storage_result =
+		bpf_inode_storage_delete(&inode_storage_map, victim->d_inode);
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
+		sk_storage_result = -1;
+
+	sk_storage_result = bpf_sk_storage_delete(&sk_storage_map, sock->sk);
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
+int BPF_PROG(file_open, struct file *file)
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
2.28.0.163.g6104cc2f0b6-goog

