Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E754324C019
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgHTOHd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbgHTN6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 09:58:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E638C061350
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 06:58:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so2139543wrh.3
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mjkc+uOFGofk3IvrwN78/tWylXT0mT1Xub0o04o3B+A=;
        b=RMZGaVEW5IVGuTA6PbP9MNBnRo5TEV7o9K9/YR0QKsq+59hK1vhRjJIMb0omsq4lUk
         vIryb+QTQUt6ZxOjsFBRj9QteTdzHtsCJOEV8spsa6Bd4G9psvbwGgeCFtv1Eg0dMerz
         cQNzWwlaS+eWMFvlZn0EfDOaeen8+lWXnEIPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mjkc+uOFGofk3IvrwN78/tWylXT0mT1Xub0o04o3B+A=;
        b=rU4Fjxyc7km0tGvradWN7ojF+WM7yoZf8XOMNXgrEj+DxJrrfbkm0/tAMFYw2Bnknl
         Ths4vyz7f5MiaFpnHUL0JW9BL4J78v6u83Y61IAQBPveFZNCF1JJ+7MlfN7z0TUtge1O
         rpCVk+WzErFYH45giS7WOMGp2KYQ6JECeRNI3TNCsBUQghDTu5v+7eLQWv+gFAB7wiME
         e0oZiH273gyq9fM1wTrDwNTb8qU3W4aFwGoG6rGzdcmDeie55SLCw8chuRz/rWryihr2
         /jhB1h4ikQeWgL6AM7395znPbAbYdhV76nI36S1dO91/DMj0jLO1vBaQWE7vPuol4c9F
         JPUQ==
X-Gm-Message-State: AOAM532qX2qoZ/s5g7EdlB0n4wkhUKTHUvwkTMsxA0QiLuS6cOtz2Gi5
        CI/y/5i5I5xKwuQVSplLZQG0Tg==
X-Google-Smtp-Source: ABdhPJyH87ZSVi7lwlb71OnrwdhOs5eqoIN0EC6j3eBTBrVN4KUyVTyeUyzAfJF4d0iy4rXjxT8tdg==
X-Received: by 2002:a5d:4c83:: with SMTP id z3mr3297909wrs.359.1597931893722;
        Thu, 20 Aug 2020 06:58:13 -0700 (PDT)
Received: from antares.lan (d.0.f.e.b.c.7.2.d.c.3.8.4.8.d.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:9d84:83cd:27cb:ef0d])
        by smtp.gmail.com with ESMTPSA id l81sm4494215wmf.4.2020.08.20.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 06:58:12 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 6/6] selftests: bpf: test sockmap update from BPF
Date:   Thu, 20 Aug 2020 14:57:29 +0100
Message-Id: <20200820135729.135783-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820135729.135783-1-lmb@cloudflare.com>
References: <20200820135729.135783-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test which copies a socket from a sockmap into another sockmap
or sockhash. This excercises bpf_map_update_elem support from BPF
context. Compare the socket cookies from source and destination to
ensure that the copy succeeded.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 71 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_copy.c   | 48 +++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_copy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 96e7b7f84c65..cd05ff5e88e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -4,6 +4,7 @@
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
+#include "test_sockmap_copy.skel.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
@@ -101,6 +102,72 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
 
+static void test_sockmap_copy(enum bpf_map_type map_type)
+{
+	struct bpf_prog_test_run_attr tattr;
+	struct test_sockmap_copy *skel;
+	__u64 src_cookie, dst_cookie;
+	int err, prog, src, dst;
+	const __u32 zero = 0;
+	char dummy[14] = {0};
+	__s64 sk;
+
+	sk = connected_socket_v4();
+	if (CHECK_FAIL(sk == -1))
+		return;
+
+	skel = test_sockmap_copy__open_and_load();
+	if (CHECK_FAIL(!skel)) {
+		close(sk);
+		perror("test_sockmap_copy__open_and_load");
+		return;
+	}
+
+	prog = bpf_program__fd(skel->progs.copy_sock_map);
+	src = bpf_map__fd(skel->maps.src);
+	if (map_type == BPF_MAP_TYPE_SOCKMAP)
+		dst = bpf_map__fd(skel->maps.dst_sock_map);
+	else
+		dst = bpf_map__fd(skel->maps.dst_sock_hash);
+
+	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
+	if (CHECK_FAIL(err)) {
+		perror("bpf_map_update");
+		goto out;
+	}
+
+	err = bpf_map_lookup_elem(src, &zero, &src_cookie);
+	if (CHECK_FAIL(err)) {
+		perror("bpf_map_lookup_elem(src)");
+		goto out;
+	}
+
+	tattr = (struct bpf_prog_test_run_attr){
+		.prog_fd = prog,
+		.repeat = 1,
+		.data_in = dummy,
+		.data_size_in = sizeof(dummy),
+	};
+
+	err = bpf_prog_test_run_xattr(&tattr);
+	if (CHECK_ATTR(err || !tattr.retval, "bpf_prog_test_run",
+		       "errno=%u retval=%u\n", errno, tattr.retval))
+		goto out;
+
+	err = bpf_map_lookup_elem(dst, &zero, &dst_cookie);
+	if (CHECK_FAIL(err)) {
+		perror("bpf_map_lookup_elem(dst)");
+		goto out;
+	}
+
+	if (dst_cookie != src_cookie)
+		PRINT_FAIL("cookie %llu != %llu\n", dst_cookie, src_cookie);
+
+out:
+	close(sk);
+	test_sockmap_copy__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -111,4 +178,8 @@ void test_sockmap_basic(void)
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash sk_msg load helpers"))
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
+	if (test__start_subtest("sockmap copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash copy"))
+		test_sockmap_copy(BPF_MAP_TYPE_SOCKHASH);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_copy.c b/tools/testing/selftests/bpf/progs/test_sockmap_copy.c
new file mode 100644
index 000000000000..9d0c9f28cab2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_copy.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Cloudflare
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} src SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} dst_sock_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} dst_sock_hash SEC(".maps");
+
+SEC("classifier/copy_sock_map")
+int copy_sock_map(void *ctx)
+{
+	struct bpf_sock *sk;
+	bool failed = false;
+	__u32 key = 0;
+
+	sk = bpf_map_lookup_elem(&src, &key);
+	if (!sk)
+		return SK_DROP;
+
+	if (bpf_map_update_elem(&dst_sock_map, &key, sk, 0))
+		failed = true;
+
+	if (bpf_map_update_elem(&dst_sock_hash, &key, sk, 0))
+		failed = true;
+
+	bpf_sk_release(sk);
+	return failed ? SK_DROP : SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1

