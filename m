Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CAC25FDD7
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgIGP7M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgIGOtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:49:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB5C061797
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so14475111wmk.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CG6pfa8grmhbhWsnM+Yrdzr0cEQrHTB9JZN/vMnBbo8=;
        b=PvmMw1oNa+Rcn1KwdNg+gTs+dVGEzQ6Auz202r+OnwdXH11O8R6dl/0+mKrCtu0O2J
         PP8pJjUbk7u2F8p9tIsvvvY+W7rOzBU9XIUiGJm5kxWpJGYrK+wPixVMD7HA28pQ5pWj
         OaWx7su0XoUjUoqTIApF8ZfAo682hBUtLd4+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CG6pfa8grmhbhWsnM+Yrdzr0cEQrHTB9JZN/vMnBbo8=;
        b=dgLEvejAQaGoje+10gqUNdJDcx4tWaCZ4ffUymeXixqHSuIc6NKzxj375LQ6hNQAfn
         rR06JkseM8T3c7gOlh4kiEGksIVD9cg12l9BPJq46eMYS3QXpaBJCLAIr8ObtMncs8Xi
         O7O2csTTZ+5H5Ty7S9UUS4L/5aOdjEvsSKIJk9aRnajB390KmscLVcg4YnWAb0H85R2r
         TOfSihj6cSmN01dCbDGAGvlA0W8rbDzfI/OPu9JQpsXohxQ8ZxiPP6bFyFAtvNCeS7jV
         OGiegjR4fpXV7DQO9u8NPQhFBUSehlvLEHSq2hPZAzfvOeyqDfcSM6o9dOrWyhz27Tm3
         yzSA==
X-Gm-Message-State: AOAM53209qgqvWRDOK722MhEfZOchsQmIPSUFmf3rWKbOHXf0OxaFSnm
        jZMnKltyWWUkvp6WI5uWC+YPDg==
X-Google-Smtp-Source: ABdhPJz/xsWSmRnD42infgl/U5iXNuFuQGbUi/KUIQmJLcgEuUgsY6v6LjsMaNGl9gycY9Tmey1iMQ==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr22635774wmk.189.1599490116808;
        Mon, 07 Sep 2020 07:48:36 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:36 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 7/7] selftests: bpf: Test copying a sockmap via bpf_iter
Date:   Mon,  7 Sep 2020 15:47:01 +0100
Message-Id: <20200907144701.44867-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907144701.44867-1-lmb@cloudflare.com>
References: <20200907144701.44867-1-lmb@cloudflare.com>
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
 .../selftests/bpf/progs/bpf_iter_sockmap.c    | 57 ++++++++++++
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 +
 4 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 0fe2a737fc8e..088903bdf10c 100644
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
 
@@ -193,6 +196,87 @@ static void test_sockmap_invalid_update(void)
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
+	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(sock_fd); i++)
+		sock_fd[i] = -1;
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
@@ -209,4 +293,8 @@ void test_sockmap_basic(void)
 		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap update in unsafe context"))
 		test_sockmap_invalid_update();
+	if (test__start_subtest("sockmap copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKHASH);
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
index 000000000000..d8d107c80b7b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -0,0 +1,57 @@
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
+	struct sock *sk = ctx->sk;
+	__u32 tmp, *key = ctx->key;
+	int ret;
+
+	if (!key)
+		return 0;
+
+	elems++;
+
+	/* We need a temporary buffer on the stack, since the verifier doesn't
+	 * let us use the pointer from the context as an argument to the helper.
+	 */
+	tmp = *key;
+
+	if (sk)
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

