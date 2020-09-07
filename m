Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E25225FDD6
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 17:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgIGP7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbgIGOtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:49:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A0FC061796
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so16097939wrs.5
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ycv2LQ1rQbHAkz0iq7QhpQk+4LCrq+rjRQEPfWaxh9M=;
        b=ZafEmUnFRg4uyNOqzQLXfM069d6h4Xm6A7CJw40OZxGaKgkJSunroD7xrXj5inD6ps
         LNEhw/jGD9uyoVcb7iE5F0ZT8pUXi5U74wmgAFEMiTz5O1LZxmaAjZRDY4Nv+SrNKOF2
         IQILXaoOuEg5pO5dQI87twTaLNgEN1EHB92w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycv2LQ1rQbHAkz0iq7QhpQk+4LCrq+rjRQEPfWaxh9M=;
        b=Dq6CCP0YNFDk4gSiY6Yf3h1lIZ5HtJ7KW9TNwknUJIN7ba23ZmvkOP57anOa49k722
         OYExitzXsdRjBFPZN8Dx4Anb36afrWxmZTb3y0M4uoOm57S5bl2A7y9phhSFSCuYMt2m
         LaTxaZM0Oqj+TN57NbDk/6HLtWI6/lnMvOMZb5IX29ycPDLVs1NmfPXHEmeQR9bvKEZD
         OKL3xG7vw0aP3JF9LmzykL+HeLBptPNcBK/wexpRU09GV2K/tIksEDYehCmTW042dIoE
         B8NCL4OBropCYJPxrkPjGNu5SXNC3Qz70Nkbl3mDOo3dnLp0aB5ORzFUkjFZu8rER5X8
         42Pg==
X-Gm-Message-State: AOAM530uGndZ0e3GAWRO4x+2LcpKugIj6b7k815m5MQcMW+aah2TtpwH
        6o2vElbdJWV9pGZkmz2hwQ1npw==
X-Google-Smtp-Source: ABdhPJz7brgUlOjNxN4cWCGqg1+jTxo8V0+1m1qzCX1Kg+tazAvndOAOcBDEv/REQGoYphafJ7FKfA==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr23454916wrm.210.1599490115380;
        Mon, 07 Sep 2020 07:48:35 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:34 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 6/7] selftests: bpf: Add helper to compare socket cookies
Date:   Mon,  7 Sep 2020 15:47:00 +0100
Message-Id: <20200907144701.44867-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907144701.44867-1-lmb@cloudflare.com>
References: <20200907144701.44867-1-lmb@cloudflare.com>
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

