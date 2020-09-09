Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B198C2631D3
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgIIQ2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbgIIQ1t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046EC061757
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 09:27:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so3025445wmi.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtsqvNaSHRzCnXBII+0kyAhJnLOvNJ6BcwljUxH8UBk=;
        b=queMOmYsiqOwRt63RiZ39vvwzgyZBbtMJdcUzQz4UBh/3TyfGVqdnzjK2e45U3rjHe
         zdUj0FC+XaCIQz0uPAzo4XkPCxbP0Ym6Hxn85GKMD4r2VgxHL6bVoxNb7iAtL1PAbqzN
         gv5REjf28wbmAKZHkdnNRgKHHk7zPNd/OkqdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtsqvNaSHRzCnXBII+0kyAhJnLOvNJ6BcwljUxH8UBk=;
        b=T13jriVM0yKzhKV6mN/FxAe2JJV6TLYLuRoADKGKOCoYIHsMDc4E5ZfulkjJDpzGML
         zFoyz5Qmx19bo9GNWgWK051pfhBR3E/vOgG0LrdmpCebJ/JoHUF3MIR40jpcAAOCcVRI
         oQim8yDMkEqPhvIH6jwuYms8kV1hR4kfz4YRh2DHR1DTt6ev0etBZnXJCLy2iAmLB9VM
         NyIeAkt/BKe/JW3jhk6seEqtXAT/IP0W9PD9uqhTjD2TVF4kX3LzlmZphfgKYCk+VQx3
         aDAwTA7ozll1qmT4CYimowx8kFvNO+3LYCK1JH9fiOvb1z5bXTGUbNbDwrJjjoVsZnDA
         bApQ==
X-Gm-Message-State: AOAM530zgQEUkXBvgkngB8tyjLhAxNWQtGnT0Nw8yOjrHLwwHyavGaLc
        Ce5UrNnyN8L3lTv5IpcXp0UYkg==
X-Google-Smtp-Source: ABdhPJyY2fgojew0kKZt0rz0jAEzDXXI3MZGQn5osxGu5wBgIyAvALeXJYzBfulmIDi/sxsCmi1mVw==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr4586697wmc.161.1599668867287;
        Wed, 09 Sep 2020 09:27:47 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l16sm5644276wrb.70.2020.09.09.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:27:46 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v5 3/3] selftests: bpf: Test iterating a sockmap
Date:   Wed,  9 Sep 2020 17:27:12 +0100
Message-Id: <20200909162712.221874-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909162712.221874-1-lmb@cloudflare.com>
References: <20200909162712.221874-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test that exercises a basic sockmap / sockhash iteration. For
now we simply count the number of elements seen. Once sockmap update
from iterators works we can extend this to perform a full copy.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 89 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 ++
 .../selftests/bpf/progs/bpf_iter_sockmap.c    | 43 +++++++++
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 +
 4 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 0b79d78b98db..3215f4d22720 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -6,6 +6,9 @@
 #include "test_skmsg_load_helpers.skel.h"
 #include "test_sockmap_update.skel.h"
 #include "test_sockmap_invalid_update.skel.h"
+#include "bpf_iter_sockmap.skel.h"
+
+#include "progs/bpf_iter_sockmap.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
@@ -171,6 +174,88 @@ static void test_sockmap_invalid_update(void)
 		test_sockmap_invalid_update__destroy(skel);
 }
 
+static void test_sockmap_iter(enum bpf_map_type map_type)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int err, len, src_fd, iter_fd, duration;
+	union bpf_iter_link_info linfo = {0};
+	__s64 sock_fd[SOCKMAP_MAX_ENTRIES];
+	__u32 i, num_sockets, max_elems;
+	struct bpf_iter_sockmap *skel;
+	struct bpf_link *link;
+	struct bpf_map *src;
+	char buf[64];
+
+	skel = bpf_iter_sockmap__open_and_load();
+	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(sock_fd); i++)
+		sock_fd[i] = -1;
+
+	/* Make sure we have at least one "empty" entry to test iteration of
+	 * an empty slot.
+	 */
+	num_sockets = ARRAY_SIZE(sock_fd) - 1;
+
+	if (map_type == BPF_MAP_TYPE_SOCKMAP) {
+		src = skel->maps.sockmap;
+		max_elems = bpf_map__max_entries(src);
+	} else {
+		src = skel->maps.sockhash;
+		max_elems = num_sockets;
+	}
+
+	src_fd = bpf_map__fd(src);
+
+	for (i = 0; i < num_sockets; i++) {
+		sock_fd[i] = connected_socket_v4();
+		if (CHECK(sock_fd[i] == -1, "connected_socket_v4", "cannot connect\n"))
+			goto out;
+
+		err = bpf_map_update_elem(src_fd, &i, &sock_fd[i], BPF_NOEXIST);
+		if (CHECK(err, "map_update", "failed: %s\n", strerror(errno)))
+			goto out;
+	}
+
+	linfo.map.map_fd = src_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(skel->progs.count_elems, &opts);
+	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
+		goto out;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+		goto free_link;
+
+	/* do some tests */
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	if (CHECK(len < 0, "read", "failed: %s\n", strerror(errno)))
+		goto close_iter;
+
+	/* test results */
+	if (CHECK(skel->bss->elems != max_elems, "elems", "got %u expected %u\n",
+		  skel->bss->elems, max_elems))
+		goto close_iter;
+
+	if (CHECK(skel->bss->socks != num_sockets, "socks", "got %u expected %u\n",
+		  skel->bss->socks, num_sockets))
+		goto close_iter;
+
+close_iter:
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+out:
+	for (i = 0; i < num_sockets; i++) {
+		if (sock_fd[i] >= 0)
+			close(sock_fd[i]);
+	}
+	bpf_iter_sockmap__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -187,4 +272,8 @@ void test_sockmap_basic(void)
 		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap update in unsafe context"))
 		test_sockmap_invalid_update();
+	if (test__start_subtest("sockmap iter"))
+		test_sockmap_iter(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash iter"))
+		test_sockmap_iter(BPF_MAP_TYPE_SOCKHASH);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index c196280df90d..df682af75510 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -13,6 +13,7 @@
 #define udp6_sock udp6_sock___not_used
 #define bpf_iter__bpf_map_elem bpf_iter__bpf_map_elem___not_used
 #define bpf_iter__bpf_sk_storage_map bpf_iter__bpf_sk_storage_map___not_used
+#define bpf_iter__sockmap bpf_iter__sockmap___not_used
 #include "vmlinux.h"
 #undef bpf_iter_meta
 #undef bpf_iter__bpf_map
@@ -26,6 +27,7 @@
 #undef udp6_sock
 #undef bpf_iter__bpf_map_elem
 #undef bpf_iter__bpf_sk_storage_map
+#undef bpf_iter__sockmap
 
 struct bpf_iter_meta {
 	struct seq_file *seq;
@@ -96,3 +98,10 @@ struct bpf_iter__bpf_sk_storage_map {
 	struct sock *sk;
 	void *value;
 };
+
+struct bpf_iter__sockmap {
+	struct bpf_iter_meta *meta;
+	struct bpf_map *map;
+	void *key;
+	struct sock *sk;
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
new file mode 100644
index 000000000000..0e27f73dd803
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Cloudflare */
+#include "bpf_iter.h"
+#include "bpf_tracing_net.h"
+#include "bpf_iter_sockmap.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, SOCKMAP_MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u64);
+} sockmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, SOCKMAP_MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u64);
+} sockhash SEC(".maps");
+
+__u32 elems = 0;
+__u32 socks = 0;
+
+SEC("iter/sockmap")
+int count_elems(struct bpf_iter__sockmap *ctx)
+{
+	struct sock *sk = ctx->sk;
+	__u32 tmp, *key = ctx->key;
+	int ret;
+
+	if (key)
+		elems++;
+
+	if (sk)
+		socks++;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
new file mode 100644
index 000000000000..35a675d13c0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define SOCKMAP_MAX_ENTRIES (64)
-- 
2.25.1

