Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8F265C42
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 11:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKJOZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 05:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgIKJOY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 05:14:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626ECC061573
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:14:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k18so4040495wmj.5
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1C3z1WrlN1bz3omSXNeagaFjrW4qm/dVyWEjBpU1CBo=;
        b=pMGL3WWVxghMBEPuG6UHfCGXlWP578GeLCcYm1kWVnDsQ/EqO/ziw5bPC498DWdJxP
         66maamcPLnKJyLUwjsjWP7Q7CrsgGjzw3hBW8lQ4eojnR1ybBxfwTEL0/uvJ47SZHdQa
         wleJNLWlOg7lbu/aRl9HmrJVDXiYz6gdoO/8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1C3z1WrlN1bz3omSXNeagaFjrW4qm/dVyWEjBpU1CBo=;
        b=SkTVSaY8ZOp/wXHrx6wB0rg/YLuT4GIhpudaWeasVe8T/B4OwXAAsn5jJmmg9WAULq
         EAHFKud27Muu/RlcM9rbD/XlfpiN0tYWQErpJT1VtdqLivLM9aB+uWEXr3nTbMo7QLSG
         kXa+LMzLGoRWZqaeFeA62fF1ZE9fzg1539QiJqjseaPITsb4OaTYnmstA6Q3Gg41XNip
         /g1hqg1Dv7jYFHY2726oI7Q0P0ALsNSH2m1vCbWxJDp8kj6izckvnbjy4XKNo+Wsmct/
         9SBS0yMqFxDoAdo7w1RmDBB/8ESR17+IRW9kchXgVOGAnd827HhoZVzv5R+vBTSlHZP/
         bdPw==
X-Gm-Message-State: AOAM532F6rIXs00Fjlepp2Ln2t89K3wSP+TGQe+fIQWBiF/9MBGV+EPG
        qp+45gNVNx6be1GFVfD+LhCqUg==
X-Google-Smtp-Source: ABdhPJxRN3VbgXcVyYRBw1UOwgcN6iaeMnfbZXo03todQjVKhzZj0844T27rWK1rrZo7lkLmcf6fPg==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr1166760wmj.112.1599815659272;
        Fri, 11 Sep 2020 02:14:19 -0700 (PDT)
Received: from antares.lan (9.d.d.6.5.4.3.7.d.e.f.4.b.1.d.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:9d1b:4fed:7345:6dd9])
        by smtp.gmail.com with ESMTPSA id c145sm3025278wmd.7.2020.09.11.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:14:18 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next] bpf: selftests: remove shared header from sockmap iter test
Date:   Fri, 11 Sep 2020 10:14:11 +0100
Message-Id: <20200911091411.37645-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The shared header to define SOCKMAP_MAX_ENTRIES is a bit overkill.
Dynamically allocate the sock_fd array based on bpf_map__max_entries
instead.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 39 ++++++++++---------
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  5 +--
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 --
 3 files changed, 23 insertions(+), 24 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 4b7a527e7e82..2672a91cd78f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -8,8 +8,6 @@
 #include "test_sockmap_invalid_update.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
-#include "progs/bpf_iter_sockmap.h"
-
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
 #define TCP_REPAIR_ON		1
@@ -179,9 +177,9 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	int err, len, src_fd, iter_fd, duration = 0;
 	union bpf_iter_link_info linfo = {0};
-	__s64 sock_fd[SOCKMAP_MAX_ENTRIES];
-	__u32 i, num_sockets, max_elems;
+	__u32 i, num_sockets, num_elems;
 	struct bpf_iter_sockmap *skel;
+	__s64 *sock_fd = NULL;
 	struct bpf_link *link;
 	struct bpf_map *src;
 	char buf[64];
@@ -190,22 +188,26 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(sock_fd); i++)
-		sock_fd[i] = -1;
-
-	/* Make sure we have at least one "empty" entry to test iteration of
-	 * an empty slot.
-	 */
-	num_sockets = ARRAY_SIZE(sock_fd) - 1;
-
 	if (map_type == BPF_MAP_TYPE_SOCKMAP) {
 		src = skel->maps.sockmap;
-		max_elems = bpf_map__max_entries(src);
+		num_elems = bpf_map__max_entries(src);
 	} else {
 		src = skel->maps.sockhash;
-		max_elems = num_sockets;
+		num_elems = bpf_map__max_entries(src) - 1;
 	}
 
+	/* Make sure we have at least one "empty" entry to test iteration of
+	 * an empty slot.
+	 */
+	num_sockets = bpf_map__max_entries(src) - 1;
+
+	sock_fd = calloc(num_sockets, sizeof(*sock_fd));
+	if (CHECK(!sock_fd, "calloc(sock_fd)", "failed to allocate\n"))
+		goto out;
+
+	for (i = 0; i < num_sockets; i++)
+		sock_fd[i] = -1;
+
 	src_fd = bpf_map__fd(src);
 
 	for (i = 0; i < num_sockets; i++) {
@@ -236,8 +238,8 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 		goto close_iter;
 
 	/* test results */
-	if (CHECK(skel->bss->elems != max_elems, "elems", "got %u expected %u\n",
-		  skel->bss->elems, max_elems))
+	if (CHECK(skel->bss->elems != num_elems, "elems", "got %u expected %u\n",
+		  skel->bss->elems, num_elems))
 		goto close_iter;
 
 	if (CHECK(skel->bss->socks != num_sockets, "socks", "got %u expected %u\n",
@@ -249,10 +251,11 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 free_link:
 	bpf_link__destroy(link);
 out:
-	for (i = 0; i < num_sockets; i++) {
+	for (i = 0; sock_fd && i < num_sockets; i++)
 		if (sock_fd[i] >= 0)
 			close(sock_fd[i]);
-	}
+	if (sock_fd)
+		free(sock_fd);
 	bpf_iter_sockmap__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
index 0e27f73dd803..1af7555f6057 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Cloudflare */
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
-#include "bpf_iter_sockmap.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
@@ -11,14 +10,14 @@ char _license[] SEC("license") = "GPL";
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, SOCKMAP_MAX_ENTRIES);
+	__uint(max_entries, 64);
 	__type(key, __u32);
 	__type(value, __u64);
 } sockmap SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKHASH);
-	__uint(max_entries, SOCKMAP_MAX_ENTRIES);
+	__uint(max_entries, 64);
 	__type(key, __u32);
 	__type(value, __u64);
 } sockhash SEC(".maps");
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
deleted file mode 100644
index 35a675d13c0f..000000000000
--- a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#define SOCKMAP_MAX_ENTRIES (64)
-- 
2.25.1

