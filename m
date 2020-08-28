Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3342557FA
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgH1JtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgH1JtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 05:49:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D8C061232
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so345878wme.5
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qR8VWUSftgKEzO0XNFqMMxHOeRQBd71aEYXYDTM4bF0=;
        b=c2RBnblRSroAQ7UXSWYd56aztlCSF6aljhNmrM+4TDptJRe1/6SB51zIcjad55aSR3
         A65hnVdgsunIdj5ojRZFIpHxFLxD9K3DoxNf+VDODf+hdypQQ8J/C8X87RvX/D7LIx9C
         edjwC3LiFku1NYoFnqhFj68aEpUsUwNiwIjsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qR8VWUSftgKEzO0XNFqMMxHOeRQBd71aEYXYDTM4bF0=;
        b=msvzvb8T4FcrYValqyLa85mOwobevhmYItnNI/5jchKsWFyS8xhlP+kRbh5OQ+KSHb
         /E3AmHxW+txhoCM4gPXRMXs9q59IAFnfG/++tSywaRc1MFYrp3gmaKxenUnCJtCiBj79
         7paDaDqjOFgvhEWxJEq5IfB4X6ZxrZbIfYtkX5kVyY9EQdSbEnVe0MsdsbVhKyZJFkno
         2xIC47i5DCxe6158SVN0i+3UVW1zIdEZSrlGz/AqHMP395MrVUCOWuHN7Bf5S5EUekL7
         v/HAc+zl1hKNX2zd9T0Z2k6TLnj3xe9TOcQ+6VcJ0ZPcoSZAQ/HqgNuREhrm+LfWb8q4
         8jcg==
X-Gm-Message-State: AOAM532TXRFSdmKE4nxhHYr4pj10j3McnkZwM9tvEydzLIXvrkx6/an6
        okNidRwCwzfnNczZTV7jU1rl1A==
X-Google-Smtp-Source: ABdhPJx4GKKd44ZsjgOWoWoYGlkpsrgLwGCo/ts9kmY9jWwkohk8ffN8KusiniZXSRGedF22nJSjog==
X-Received: by 2002:a05:600c:410b:: with SMTP id j11mr865471wmi.38.1598608144731;
        Fri, 28 Aug 2020 02:49:04 -0700 (PDT)
Received: from antares.lan (5.8.0.7.f.1.6.5.2.2.a.f.0.8.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:80:fa22:561f:7085])
        by smtp.gmail.com with ESMTPSA id z203sm1371119wmc.31.2020.08.28.02.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:49:04 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 3/3] selftests: bpf: Test copying a sockmap via bpf_iter
Date:   Fri, 28 Aug 2020 10:48:34 +0100
Message-Id: <20200828094834.23290-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828094834.23290-1-lmb@cloudflare.com>
References: <20200828094834.23290-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test that exercises a basic sockmap / sockhash copy using bpf_iter.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 78 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 +++
 .../selftests/bpf/progs/bpf_iter_sockmap.c    | 50 ++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index b989f8760f1a..386aecf1f7ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -6,6 +6,7 @@
 #include "test_skmsg_load_helpers.skel.h"
 #include "test_sockmap_update.skel.h"
 #include "test_sockmap_invalid_update.skel.h"
+#include "bpf_iter_sockmap.skel.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
@@ -194,6 +195,79 @@ static void test_sockmap_invalid_update(void)
 		test_sockmap_invalid_update__destroy(skel);
 }
 
+static void test_sockmap_copy(enum bpf_map_type map_type)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int err, i, len, src_fd, iter_fd, num_sockets, duration;
+	struct bpf_iter_sockmap *skel;
+	struct bpf_map *src, *dst;
+	union bpf_iter_link_info linfo = {0};
+	__s64 sock_fd[2] = {-1, -1};
+	struct bpf_link *link;
+	char buf[64];
+	__u32 max_elems;
+
+	skel = bpf_iter_sockmap__open_and_load();
+	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	if (map_type == BPF_MAP_TYPE_SOCKMAP)
+		src = skel->maps.sockmap;
+	else
+		src = skel->maps.sockhash;
+
+	dst = skel->maps.dst;
+	src_fd = bpf_map__fd(src);
+	max_elems = bpf_map__max_entries(src);
+
+	num_sockets = ARRAY_SIZE(sock_fd);
+	for (i = 0; i < num_sockets; i++) {
+		sock_fd[i] = connected_socket_v4();
+		if (CHECK(sock_fd[i] == -1, "connected_socket_v4", "cannot connect\n"))
+			goto out;
+
+		err = bpf_map_update_elem(src_fd, &i, &sock_fd[i], BPF_NOEXIST);
+		if (CHECK(err, "map_update", "map_update failed\n"))
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
@@ -210,4 +284,8 @@ void test_sockmap_basic(void)
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
index 000000000000..1b4268c9cd31
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Cloudflare */
+#include "bpf_iter.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} sockmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} sockhash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} dst SEC(".maps");
+
+__u32 elems = 0;
+
+SEC("iter/sockmap")
+int copy_sockmap(struct bpf_iter__sockmap *ctx)
+{
+	__u32 tmp, *key = ctx->key;
+	struct bpf_sock *sk = ctx->sk;
+
+	if (key == (void *)0)
+		return 0;
+
+	elems++;
+	tmp = *key;
+
+	if (sk != (void *)0)
+		return bpf_map_update_elem(&dst, &tmp, sk, 0) != 0;
+
+	bpf_map_delete_elem(&dst, &tmp);
+	return 0;
+}
-- 
2.25.1

