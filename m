Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D100278486
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 11:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgIYJ5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 05:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgIYJ4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA8C0613CE
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 02:56:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so2880686wrp.8
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hgo0C+B4MaRA4y0HWxs83icuwRAx25Hc6vqvCgKEaCI=;
        b=hgflbRDP43OZ7SZdMBUgrklofR66d165te97OJ57TYTmIauCiAKaFL/uTtX6sWWwie
         +HFTWwM6RcVFfsXFEi8mmxSxEWrnxq6qtjugy97WrASGz/JRlkrm4iYk0l/2mXxpVa4t
         te5MO5y8ABd/uwNrFf2aGqJTgjGQYmM1OvjBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hgo0C+B4MaRA4y0HWxs83icuwRAx25Hc6vqvCgKEaCI=;
        b=dY0uR82SFaG6Cu5iQ9ufCszC9SAjxqhIyd38NnQtHS6SlQjBUSa8IZFgRDTNbgrL+u
         aNpq67vrCAuKU1tTenM8TEvSAAavZw95tI3L9Itqi+sbn94plZxrafVf2waekHUU1jX1
         sSMusaCNEnMTbdLTZovfG6+fiY57vrff2b2kMbDOGOxNyU+bBnNABxaPrIsvgvqdDPI0
         9YcKmghE11+tF6rp5V348cFXhgNeh9La/9FzBcWamyyCyM5wovf0WYgyPQbn+lWLsruU
         NhUtAYsx+9RNaGG0COPfGdzQAJDGGpTcDzOf0DOvfkuqJgHGdN0BXVcdnlTD4EVOZ71C
         ya+g==
X-Gm-Message-State: AOAM530LMviEaOGKzgRGNuGbDUTn9PJhp6fzO8aTb7nohbMNTNuHeS2T
        p/HFRG5B10kvXseSq9fn4NVF+w==
X-Google-Smtp-Source: ABdhPJxyYFSCZ/adlVgERShTbNj7iNxb/bRt0IxJq0ZdWHSsumlBwGG2ReAw4FCEjcZRGuqiWJ3zTA==
X-Received: by 2002:adf:f903:: with SMTP id b3mr3710169wrr.142.1601027808967;
        Fri, 25 Sep 2020 02:56:48 -0700 (PDT)
Received: from antares.lan (e.0.c.6.b.e.c.e.a.c.9.7.c.2.1.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:12c:79ca:eceb:6c0e])
        by smtp.gmail.com with ESMTPSA id l10sm2225084wru.59.2020.09.25.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:48 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/4] selftests: bpf: Add helper to compare socket cookies
Date:   Fri, 25 Sep 2020 10:56:28 +0100
Message-Id: <20200925095630.49207-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925095630.49207-1-lmb@cloudflare.com>
References: <20200925095630.49207-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 4b7a527e7e82..67d3301bdf81 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -50,6 +50,37 @@ static int connected_socket_v4(void)
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
@@ -109,9 +140,9 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
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
@@ -127,18 +158,14 @@ static void test_sockmap_update(enum bpf_map_type map_type)
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
@@ -151,12 +178,7 @@ static void test_sockmap_update(enum bpf_map_type map_type)
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

