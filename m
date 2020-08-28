Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA642557F9
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 11:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgH1JtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1JtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 05:49:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450EC06121B
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so703923wrl.4
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJJrBLnUK02XOLSfBNkg9sJ8M9pmMGgqCS2Hxkfo1Jk=;
        b=y1O/lyDb4QewGMWg7QE58v64J6dA9/n5JRxZQox/IBht2mRQlNBPb0U6wEzdumABaf
         lT6RVceI58bV78WlPBeAJV+DIYRXqK1t/ZV5i4JUPDVi0tqNUttNNvlK/hMm6S4s6kcN
         I2tnGiUYpL3eJozA4dP4OwBwLP65Bfp4J5aak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJJrBLnUK02XOLSfBNkg9sJ8M9pmMGgqCS2Hxkfo1Jk=;
        b=m78iCX1Nw58uZVcLOe3uVGkEwE1abt6NB9o3Tk1cYLXZue5ODGJjQym5hnJysmnf4K
         dzYKaqsinnPh9OlCHXC6q13tfxRbZZtHsz/Zg1lVqjJlbRoRQ+MQMdB8Dj82gFG7FGSk
         Hq57ggBEx8Lh4hZt6i5uNt55D2Tz2QoAJpk9pwJDuSODqGiOFHMrZ1vQVWVBATXIKl7B
         tJY1M2PxOEmSbsFqiC9IlGSDhrT9XfFw1HGU1FgC63fssqHOzNI7CNIObGzFdsNLNNOW
         KH7drErcRtHKGqcrW2WG9qhvoPm2GmYk5WtSPKi8pSrmlJko07KhVeH+5+iOrTLoG8l/
         lp2Q==
X-Gm-Message-State: AOAM532+AhyEep2O3FMk1s4pJwdxqCIYAGfSKRvxh9s/qHtnO+cKe2FC
        hhHgcMW5sJtofcQNuurn/G0qRg==
X-Google-Smtp-Source: ABdhPJzK/MDGjj6GdJ9x+5mbg7QzrOipZfBSVFDrw8wtvy9fabpKG3anL67jMxz730nphneZGiWRmg==
X-Received: by 2002:adf:e904:: with SMTP id f4mr735625wrm.300.1598608143265;
        Fri, 28 Aug 2020 02:49:03 -0700 (PDT)
Received: from antares.lan (5.8.0.7.f.1.6.5.2.2.a.f.0.8.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:80:fa22:561f:7085])
        by smtp.gmail.com with ESMTPSA id z203sm1371119wmc.31.2020.08.28.02.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:49:02 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 2/3] selftests: bpf: Add helper to compare socket cookies
Date:   Fri, 28 Aug 2020 10:48:33 +0100
Message-Id: <20200828094834.23290-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828094834.23290-1-lmb@cloudflare.com>
References: <20200828094834.23290-1-lmb@cloudflare.com>
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
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 ++++++++++++++-----
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 0b79d78b98db..b989f8760f1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -47,6 +47,38 @@ static int connected_socket_v4(void)
 	return -1;
 }
 
+static void compare_cookies(struct bpf_map *src, struct bpf_map *dst)
+{
+	__u32 i, max_entries = bpf_map__max_entries(src);
+	int err, duration, src_fd, dst_fd;
+
+	src_fd = bpf_map__fd(src);
+	dst_fd = bpf_map__fd(src);
+
+	for (i = 0; i < max_entries; i++) {
+		__u64 src_cookie, dst_cookie;
+
+		err = bpf_map_lookup_elem(src_fd, &i, &src_cookie);
+		if (err && errno == ENOENT) {
+			err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
+			if (err && errno == ENOENT)
+				continue;
+
+			CHECK(err, "map_lookup_elem(dst)", "element not deleted\n");
+			continue;
+		}
+		if (CHECK(err, "lookup_elem(src, cookie)", "%s\n", strerror(errno)))
+			continue;
+
+		err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
+		if (CHECK(err, "lookup_elem(dst, cookie)", "%s\n", strerror(errno)))
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
@@ -106,9 +138,9 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
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
@@ -124,18 +156,14 @@ static void test_sockmap_update(enum bpf_map_type map_type)
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
@@ -148,12 +176,7 @@ static void test_sockmap_update(enum bpf_map_type map_type)
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

