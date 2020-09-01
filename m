Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC0258CD7
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgIAKcg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgIAKce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 06:32:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D60C061245
        for <bpf@vger.kernel.org>; Tue,  1 Sep 2020 03:32:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so920954wrx.7
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pP3a3/EeB7co/TfvBLcjXNZma1H5tGE2AY2WdrJgvuI=;
        b=mhmtS40KCKOehzVGm5yYO4ghYyqlX4X6FIhTZhhG+e6tvsrqU2inA1x41EaN/6FDqj
         WSWGRzm1uEIm/Cn282Av9yh2lYKuxEzI1KWhWv9OUfVC1GFuPorPNqiqbsGYm562uNnn
         YkW9UvjNbrOrpE6qvRqQBnOvKr48gDi7d5yrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pP3a3/EeB7co/TfvBLcjXNZma1H5tGE2AY2WdrJgvuI=;
        b=cJShswin2vyqtp2x0y9eZ2N73c+u2B2rMqJZ73hmHkz3IeIKCNvlTwZ1kL5z3CrII7
         J3ngYbswPxwcYwmcRpM8oLB1SSq0qDfQq8jXDOslMWU8ZEBKREaxmZuhZrAL0QZZPmbs
         PfacJpL5r/srLT+rtUPVm/X+B7BBCHVZvsTOR5ThzpNEFzPSmQm9rPH8M2m/VO/ukpld
         oxNqC/LRWvZnWJkKObnRHIdQ1Y36dqmWasEdvgD5+jtIBgBJAYzSyxDKVaUcuRaK0fLw
         /NNF9Ft6XS4q0Xs7yA/YpwgfFyKG7ItsrR/ZEOXWtKAYrWtjHAP2vh1vFm+v45t0Gapv
         28oQ==
X-Gm-Message-State: AOAM530ybj44S336ONEO+zwYRW2qOT2r7k12g7nFgiiYMt7cCvCX3Zus
        vfeoxpuspf+zHPAodC7lU29DFw==
X-Google-Smtp-Source: ABdhPJy6bxpKKbLYvisXSe2FWZJgDPSyHqhY+bYq5IKTR0FXBw/EQZguR16JoDHTceOQJITtVnJqJg==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr1120926wrr.382.1598956349556;
        Tue, 01 Sep 2020 03:32:29 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l10sm1653070wru.59.2020.09.01.03.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:32:28 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 4/4] selftests: bpf: Test copying a sockmap via bpf_iter
Date:   Tue,  1 Sep 2020 11:32:10 +0100
Message-Id: <20200901103210.54607-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901103210.54607-1-lmb@cloudflare.com>
References: <20200901103210.54607-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test that exercises a basic sockmap / sockhash copy using bpf_iter.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 88 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 ++
 .../selftests/bpf/progs/bpf_iter_sockmap.c    | 58 ++++++++++++
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 +
 4 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 9569bbac7f6e..f5b7b27f096f 100644
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
 
@@ -196,6 +199,87 @@ static void test_sockmap_invalid_update(void)
 		test_sockmap_invalid_update__destroy(skel);
 }
 
+static void test_sockmap_copy(enum bpf_map_type map_type)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int err, len, src_fd, iter_fd, duration;
+	union bpf_iter_link_info linfo = {0};
+	__s64 sock_fd[SOCKMAP_MAX_ENTRIES];
+	__u32 i, num_sockets, max_elems;
+	struct bpf_iter_sockmap *skel;
+	struct bpf_map *src, *dst;
+	struct bpf_link *link;
+	char buf[64];
+
+	skel = bpf_iter_sockmap__open_and_load();
+	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	memset(sock_fd, 0xff, sizeof(sock_fd));
+
+	/* Make sure we have at least one "empty" entry to test iteration of
+	 * an empty slot in an array.
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
+	dst = skel->maps.dst;
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
+	link = bpf_program__attach_iter(skel->progs.copy_sockmap, &opts);
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
+	compare_cookies(src, dst);
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
@@ -212,4 +296,8 @@ void test_sockmap_basic(void)
 		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap update in unsafe context"))
 		test_sockmap_invalid_update();
+	if (test__start_subtest("sockmap copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKHASH);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index c196280df90d..ac32a29f5153 100644
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
+	struct bpf_sock *sk;
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
new file mode 100644
index 000000000000..d236bc76cc06
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -0,0 +1,58 @@
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
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, SOCKMAP_MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u64);
+} dst SEC(".maps");
+
+__u32 elems = 0;
+
+SEC("iter/sockmap")
+int copy_sockmap(struct bpf_iter__sockmap *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	__u32 tmp, *key = ctx->key;
+	int ret;
+
+	if (key == (void *)0)
+		return 0;
+
+	elems++;
+
+	/* We need a temporary buffer on the stack, since the verifier doesn't
+	 * let us use the pointer from the context as an argument to the helper.
+	 */
+	tmp = *key;
+	bpf_printk("key: %u\n", tmp);
+
+	if (sk != (void *)0)
+		return bpf_map_update_elem(&dst, &tmp, sk, 0) != 0;
+
+	ret = bpf_map_delete_elem(&dst, &tmp);
+	return ret && ret != -ENOENT;
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
new file mode 100644
index 000000000000..f98ad727ac06
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define SOCKMAP_MAX_ENTRIES (64)
-- 
2.25.1

