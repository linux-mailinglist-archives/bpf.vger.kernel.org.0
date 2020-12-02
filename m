Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7AF2CC875
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 21:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgLBU5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 15:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbgLBU5S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 15:57:18 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F06C061A52
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 12:55:56 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so5588413wrt.0
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+55Li1wljIgJq9y6JYUOqOaM7Nk4+K54jOzXcb9isA=;
        b=Qh1X/leCANR8wn9Y1a1/jZVIZw7mZnAK4DAgx+IGy0uqEejiMoY10N2CNcTab9spsb
         tZrKeb9KGHJCgGbGZ+QtHJ8cJ2opKR+Sa7gfaiBByoMEYliZjdYYF41WwEJM7eBQuWgn
         HTji9fMxCyWGgBwfPfQeG/fvptde7zwC938ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+55Li1wljIgJq9y6JYUOqOaM7Nk4+K54jOzXcb9isA=;
        b=jrtvwf0M7DqBM9KkTWBXRoYktKkdHPtl9dKbjbiUBB8mylYzig+8zrE/MnZ1nrQyA8
         gz7tQOrwwYDVxrKnBaQCZdntheHloTzGcZoMRXAVES7AoE7Exjh56IoIgFZw7+S/uxhR
         GcywDvKMdSU7RIgvM7WMj+WCulqc8i3tnZj1Ev4CPB8wlJ3rFPGQFuM6XZu9wibIlUX+
         PDz61R4aFkdKtAlWuTsvtWkA5C3Ur4OIk9vX2BNviMjfLVANVzrdE0DNesjzMW1lC8Ki
         BCV515kQ7AeAiHpa7iuxoR+RUX7GJUYEzVbq09lkPxHe4B0lM1NSgJXlo1N9c5rDu9mQ
         1rIA==
X-Gm-Message-State: AOAM530M2AIegldY6Gxa3wAX2rXXIXV3GrVh8xxrof46EXI6XANCn7FN
        z3bQRdwgq3tyXPI+aG/Ztlt+oYw0fbxiEA==
X-Google-Smtp-Source: ABdhPJxjWTIoKQTMZ9rTmf1IhrFnfhZakrn0nxVXg++9o3dsSDz+HXUN09OA6xYGS71AJtPqxJnw6A==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr5767347wru.352.1606942554339;
        Wed, 02 Dec 2020 12:55:54 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id d2sm3438486wrn.43.2020.12.02.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:55:53 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 5/6] bpf: Add an iterator selftest for bpf_sk_storage_get
Date:   Wed,  2 Dec 2020 21:55:26 +0100
Message-Id: <20201202205527.984965-5-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202205527.984965-1-revest@google.com>
References: <20201202205527.984965-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The eBPF program iterates over all files and tasks. For all socket
files, it stores the tgid of the last task it encountered with a handle
to that socket. This is a heuristic for finding the "owner" of a socket
similar to what's done by lsof, ss, netstat or fuser. Potentially, this
information could be used from a cgroup_skb/*gress hook to try to
associate network traffic with processes.

The test makes sure that a socket it created is tagged with prog_tests's
pid.

Signed-off-by: Florent Revest <revest@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 40 +++++++++++++++++++
 .../progs/bpf_iter_bpf_sk_storage_helpers.c   | 24 +++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index bb4a638f2e6f..9336d0f18331 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -975,6 +975,44 @@ static void test_bpf_sk_storage_delete(void)
 	bpf_iter_bpf_sk_storage_helpers__destroy(skel);
 }
 
+/* This creates a socket and its local storage. It then runs a task_iter BPF
+ * program that replaces the existing socket local storage with the tgid of the
+ * only task owning a file descriptor to this socket, this process, prog_tests.
+ */
+static void test_bpf_sk_storage_get(void)
+{
+	struct bpf_iter_bpf_sk_storage_helpers *skel;
+	int err, map_fd, val = -1;
+	int sock_fd = -1;
+
+	skel = bpf_iter_bpf_sk_storage_helpers__open_and_load();
+	if (CHECK(!skel, "bpf_iter_bpf_sk_storage_helpers__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (CHECK(sock_fd < 0, "socket", "errno: %d\n", errno))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
+
+	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
+	if (CHECK(err, "bpf_map_update_elem", "map_update_failed\n"))
+		goto close_socket;
+
+	do_dummy_read(skel->progs.fill_socket_owner);
+
+	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
+	CHECK(err || val != getpid(), "bpf_map_lookup_elem",
+	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
+	      getpid(), val, err);
+
+close_socket:
+	close(sock_fd);
+out:
+	bpf_iter_bpf_sk_storage_helpers__destroy(skel);
+}
+
 static void test_bpf_sk_storage_map(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -1131,6 +1169,8 @@ void test_bpf_iter(void)
 		test_bpf_sk_storage_map();
 	if (test__start_subtest("bpf_sk_storage_delete"))
 		test_bpf_sk_storage_delete();
+	if (test__start_subtest("bpf_sk_storage_get"))
+		test_bpf_sk_storage_get();
 	if (test__start_subtest("rdonly-buf-out-of-bound"))
 		test_rdonly_buf_out_of_bound();
 	if (test__start_subtest("buf-neg-offset"))
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
index 01ff3235e413..dde53df37de8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
@@ -21,3 +21,27 @@ int delete_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
 
 	return 0;
 }
+
+SEC("iter/task_file")
+int fill_socket_owner(struct bpf_iter__task_file *ctx)
+{
+	struct task_struct *task = ctx->task;
+	struct file *file = ctx->file;
+	struct socket *sock;
+	int *sock_tgid;
+
+	if (!task || !file)
+		return 0;
+
+	sock = bpf_sock_from_file(file);
+	if (!sock)
+		return 0;
+
+	sock_tgid = bpf_sk_storage_get(&sk_stg_map, sock->sk, 0, 0);
+	if (!sock_tgid)
+		return 0;
+
+	*sock_tgid = task->tgid;
+
+	return 0;
+}
-- 
2.29.2.454.gaff20da3a2-goog

