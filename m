Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9B25D589
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIDJ7e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgIDJ7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 05:59:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460BC061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 02:59:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so6113017wrx.7
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ycv2LQ1rQbHAkz0iq7QhpQk+4LCrq+rjRQEPfWaxh9M=;
        b=KqoATMug73m0CbTqtrYFoNnm3aW7GbezJF6JqoaDhmRo5Tja5PiRMy2eMDlmTvXEVj
         0kavYi1GuQmjQsPQifl5iqo1wsOPsbWm1PWya/iPKdgI3UkcpfPkqsOjRV+g4EfrHglJ
         vVm7V/UHdLxyjtYPLha78IYVqvd6AddczBZ9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycv2LQ1rQbHAkz0iq7QhpQk+4LCrq+rjRQEPfWaxh9M=;
        b=BV4vZlyNZ254ZUNTSsD1LhFQ0n3Xy5+1TMExYj40hKTXdkhleXpPKOFKK7BHp3aD5d
         IMADquhrA6VV3C/B/O0QDPBmZFdIASAvmuMVOhPr4GCW6Uhxh2mxxGUvAoqsJ4zRj21K
         9aKvJb7Z1d3eByqT5N9D+JvrJxsZF1HeOueiKWWxqPe0pKjNjWq4TQzdyExuO9L4O46C
         3xsTOCFtmDGFZ3i86IFL54sm5Je3RmagZABppgCAX2gDqN9K3XLq1LRKtuO9R7DLVME1
         RhKO48MsUIID/MSaEHwnRnn7B8LK6V9CwL/4HM3YghbytK5HZSyUzDXQNzP9tC/LQo5t
         WE9Q==
X-Gm-Message-State: AOAM530Ums0WNxPfFQ+WnrnfP78wYE+PoezybJH5Ff/u2L0B2E2pwvVO
        1OoyyybPpwCSUgpCoTgxGjMV8A==
X-Google-Smtp-Source: ABdhPJwIl9quoB5JrQ4NRr7wdhraRS30AhnIQ3QwInr6fV/SKYroPu0uvMJJAbMP84bqiP9YEpRGGw==
X-Received: by 2002:adf:b784:: with SMTP id s4mr7273436wre.116.1599213569432;
        Fri, 04 Sep 2020 02:59:29 -0700 (PDT)
Received: from antares.lan (a.6.f.d.9.5.a.d.2.b.c.0.f.d.4.2.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:24df:cb2:da59:df6a])
        by smtp.gmail.com with ESMTPSA id c18sm11648088wrx.63.2020.09.04.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:59:28 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 5/6] selftests: bpf: Add helper to compare socket cookies
Date:   Fri,  4 Sep 2020 10:59:03 +0100
Message-Id: <20200904095904.612390-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904095904.612390-1-lmb@cloudflare.com>
References: <20200904095904.612390-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We compare socket cookies to ensure that insertion into a sockmap worked.
Pull this out into a helper function for use in other tests.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 50 +++++++++++++------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 0b79d78b98db..0fe2a737fc8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -47,6 +47,37 @@ static int connected_socket_v4(void)
 	return -1;
 }
 
+static void compare_cookies(struct bpf_map *src, struct bpf_map *dst)
+{
+	__u32 i, max_entries = bpf_map__max_entries(src);
+	int err, duration, src_fd, dst_fd;
+
+	src_fd = bpf_map__fd(src);
+	dst_fd = bpf_map__fd(dst);
+
+	for (i = 0; i < max_entries; i++) {
+		__u64 src_cookie, dst_cookie;
+
+		err = bpf_map_lookup_elem(src_fd, &i, &src_cookie);
+		if (err && errno == ENOENT) {
+			err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
+			CHECK(!err, "map_lookup_elem(dst)", "element %u not deleted\n", i);
+			CHECK(err && errno != ENOENT, "map_lookup_elem(dst)", "%s\n",
+			      strerror(errno));
+			continue;
+		}
+		if (CHECK(err, "lookup_elem(src)", "%s\n", strerror(errno)))
+			continue;
+
+		err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
+		if (CHECK(err, "lookup_elem(dst)", "%s\n", strerror(errno)))
+			continue;
+
+		CHECK(dst_cookie != src_cookie, "cookie mismatch",
+		      "%llu != %llu (pos %u)\n", dst_cookie, src_cookie, i);
+	}
+}
+
 /* Create a map, populate it with one socket, and free the map. */
 static void test_sockmap_create_update_free(enum bpf_map_type map_type)
 {
@@ -106,9 +137,9 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
 static void test_sockmap_update(enum bpf_map_type map_type)
 {
 	struct bpf_prog_test_run_attr tattr;
-	int err, prog, src, dst, duration = 0;
+	int err, prog, src, duration = 0;
 	struct test_sockmap_update *skel;
-	__u64 src_cookie, dst_cookie;
+	struct bpf_map *dst_map;
 	const __u32 zero = 0;
 	char dummy[14] = {0};
 	__s64 sk;
@@ -124,18 +155,14 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 	prog = bpf_program__fd(skel->progs.copy_sock_map);
 	src = bpf_map__fd(skel->maps.src);
 	if (map_type == BPF_MAP_TYPE_SOCKMAP)
-		dst = bpf_map__fd(skel->maps.dst_sock_map);
+		dst_map = skel->maps.dst_sock_map;
 	else
-		dst = bpf_map__fd(skel->maps.dst_sock_hash);
+		dst_map = skel->maps.dst_sock_hash;
 
 	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
 	if (CHECK(err, "update_elem(src)", "errno=%u\n", errno))
 		goto out;
 
-	err = bpf_map_lookup_elem(src, &zero, &src_cookie);
-	if (CHECK(err, "lookup_elem(src, cookie)", "errno=%u\n", errno))
-		goto out;
-
 	tattr = (struct bpf_prog_test_run_attr){
 		.prog_fd = prog,
 		.repeat = 1,
@@ -148,12 +175,7 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 		       "errno=%u retval=%u\n", errno, tattr.retval))
 		goto out;
 
-	err = bpf_map_lookup_elem(dst, &zero, &dst_cookie);
-	if (CHECK(err, "lookup_elem(dst, cookie)", "errno=%u\n", errno))
-		goto out;
-
-	CHECK(dst_cookie != src_cookie, "cookie mismatch", "%llu != %llu\n",
-	      dst_cookie, src_cookie);
+	compare_cookies(skel->maps.src, dst_map);
 
 out:
 	test_sockmap_update__destroy(skel);
-- 
2.25.1

