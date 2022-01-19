Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9DA493EB1
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356266AbiASQ6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 11:58:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38686 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356247AbiASQ6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 11:58:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87B6AB81A61
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 16:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50500C340E1;
        Wed, 19 Jan 2022 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642611530;
        bh=hJQozeKP1fs4E06I1pCAYyH4VccT9YZZBROshaGrvho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ia66CwzwiXmT821HTXXpFMFhA9g5XqNbvUtjxkplkO2aE3YGgVV4fVtafx5Qyg3L0
         9ALVK6P+crTPpPDnEOftUkI4eHDGROvc42D+RH65danrbEIwnijjDvFhV2auE7LWR+
         EiZ6nakaZdfHAJpTG8FPOAN2C0sIDCqyMS91arcIDRZFr0933zXjrivlYZKBloOTDV
         lANLHsjgw3gcQLnNNKw+P45Kt4y+A/8ndtKCfKOYXxI2DW34cIjiy26g+q/RjZ2HzL
         1SuZAIxnzQ0Yd3/HlWi9sueEm+1EhziTdRtS/3l1SVUEaL0Lv3vzW11onGYPggakTB
         0qdfsbamaSTeg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: selftests: get rid of CHECK macro in xdp_adjust_tail.c
Date:   Wed, 19 Jan 2022 17:58:26 +0100
Message-Id: <bd3608faf2e9162cc93d54ee93d2d6737750bb30.1642611050.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642611050.git.lorenzo@kernel.org>
References: <cover.1642611050.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rely on ASSERT* macros and get rid of deprecated CHECK ones in
xdp_adjust_tail bpf selftest.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bpf/prog_tests/xdp_adjust_tail.c          | 62 +++++++------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 3f5a17c38be5..dffa21b35503 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -11,22 +11,19 @@ static void test_xdp_adjust_tail_shrink(void)
 	char buf[128];
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
-	if (CHECK_FAIL(err))
+	if (ASSERT_OK(err, "test_xdp_adjust_tail_shrink"))
 		return;
 
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
 
-	CHECK(err || retval != XDP_DROP,
-	      "ipv4", "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
+	ASSERT_OK(err || retval != XDP_DROP, "ipv4");
 
 	expect_sz = sizeof(pkt_v6) - 20;  /* Test shrink with 20 bytes */
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_TX || size != expect_sz,
-	      "ipv6", "err %d errno %d retval %d size %d expect-size %d\n",
-	      err, errno, retval, size, expect_sz);
+	ASSERT_OK(err || retval != XDP_TX || size != expect_sz, "ipv6");
+
 	bpf_object__close(obj);
 }
 
@@ -39,21 +36,17 @@ static void test_xdp_adjust_tail_grow(void)
 	int err, prog_fd;
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
-	if (CHECK_FAIL(err))
+	if (ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;
 
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_DROP,
-	      "ipv4", "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
+	ASSERT_OK(err || retval != XDP_DROP, "ipv4");
 
 	expect_sz = sizeof(pkt_v6) + 40; /* Test grow with 40 bytes */
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6) /* 74 */,
 				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_TX || size != expect_sz,
-	      "ipv6", "err %d errno %d retval %d size %d expect-size %d\n",
-	      err, errno, retval, size, expect_sz);
+	ASSERT_OK(err || retval != XDP_TX || size != expect_sz, "ipv6");
 
 	bpf_object__close(obj);
 }
@@ -76,7 +69,7 @@ static void test_xdp_adjust_tail_grow2(void)
 	};
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &tattr.prog_fd);
-	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+	if (ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;
 
 	/* Test case-64 */
@@ -86,21 +79,17 @@ static void test_xdp_adjust_tail_grow2(void)
 	/* Kernel side alloc packet memory area that is zero init */
 	err = bpf_prog_test_run_xattr(&tattr);
 
-	CHECK_ATTR(errno != ENOSPC /* Due limit copy_size in bpf_test_finish */
-		   || tattr.retval != XDP_TX
-		   || tattr.data_size_out != 192, /* Expected grow size */
-		   "case-64",
-		   "err %d errno %d retval %d size %d\n",
-		   err, errno, tattr.retval, tattr.data_size_out);
+	ASSERT_OK(errno != ENOSPC /* Due limit copy_size in bpf_test_finish */
+		  || tattr.retval != XDP_TX
+		  || tattr.data_size_out != 192, /* Expected grow size */
+		  "case-64");
 
 	/* Extra checks for data contents */
-	CHECK_ATTR(tattr.data_size_out != 192
-		   || buf[0]   != 1 ||  buf[63]  != 1  /*  0-63  memset to 1 */
-		   || buf[64]  != 0 ||  buf[127] != 0  /* 64-127 memset to 0 */
-		   || buf[128] != 1 ||  buf[191] != 1, /*128-191 memset to 1 */
-		   "case-64-data",
-		   "err %d errno %d retval %d size %d\n",
-		   err, errno, tattr.retval, tattr.data_size_out);
+	ASSERT_OK(tattr.data_size_out != 192
+		  || buf[0]   != 1 || buf[63]  != 1  /*  0-63  memset to 1 */
+		  || buf[64]  != 0 || buf[127] != 0  /* 64-127 memset to 0 */
+		  || buf[128] != 1 || buf[191] != 1, /*128-191 memset to 1 */
+		  "case-64-data");
 
 	/* Test case-128 */
 	memset(buf, 2, sizeof(buf));
@@ -109,23 +98,18 @@ static void test_xdp_adjust_tail_grow2(void)
 	err = bpf_prog_test_run_xattr(&tattr);
 
 	max_grow = 4096 - XDP_PACKET_HEADROOM -	tailroom; /* 3520 */
-	CHECK_ATTR(err
-		   || tattr.retval != XDP_TX
-		   || tattr.data_size_out != max_grow,/* Expect max grow size */
-		   "case-128",
-		   "err %d errno %d retval %d size %d expect-size %d\n",
-		   err, errno, tattr.retval, tattr.data_size_out, max_grow);
+	ASSERT_OK(err || tattr.retval != XDP_TX
+		  || tattr.data_size_out != max_grow,/* Expect max grow size */
+		  "case-128");
 
 	/* Extra checks for data content: Count grow size, will contain zeros */
 	for (i = 0, cnt = 0; i < sizeof(buf); i++) {
 		if (buf[i] == 0)
 			cnt++;
 	}
-	CHECK_ATTR((cnt != (max_grow - tattr.data_size_in)) /* Grow increase */
-		   || tattr.data_size_out != max_grow, /* Total grow size */
-		   "case-128-data",
-		   "err %d errno %d retval %d size %d grow-size %d\n",
-		   err, errno, tattr.retval, tattr.data_size_out, cnt);
+	ASSERT_OK((cnt != (max_grow - tattr.data_size_in)) /* Grow increase */
+		  || tattr.data_size_out != max_grow, /* Total grow size */
+		  "case-128-data");
 
 	bpf_object__close(obj);
 }
-- 
2.34.1

