Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF62494D65
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiATLuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 06:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiATLuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 06:50:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B62C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 03:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39F561655
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48153C340E0;
        Thu, 20 Jan 2022 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642679448;
        bh=akYcj4EL+8wiKAZctg7fNEP9ZJKTvlmfAboag3s6AUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDr6OH8NB1+4t5vZzKSHRpREx1Kp+rBDkX4pAFWOAkz/QTAiIk7sNO/0nP3RpmDwn
         g+YPT1d0zl6m/CBBrRxdJIt0u3fo0NTOzy6pLKKbrWK6MM18x88eBUVLFqaY8C+fBN
         Wy35yG4VFO30UelAhdbmPOjPasgl41w82oiAuDP8lpVw/sV1VSRsEjXNASKj0ljraE
         RE98L+yBvzXRSq2ej8z5PtPq35/ODSZ4oWV+1MP4C+RzGbTDHZg/8BYJ5256bmxLN0
         JWXT8WLjlPtU98iqNgxrdOH078BsY/kkifLJ3tDwIwous2UX0VBPLQJ6V3+IQ7xDVm
         7l4AtntnpJifw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH v2 bpf-next 1/2] bpf: selftests: get rid of CHECK macro in xdp_adjust_tail.c
Date:   Thu, 20 Jan 2022 12:50:26 +0100
Message-Id: <c0ab002ffa647a20ec9e584214bf0d4373142b54.1642679130.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642679130.git.lorenzo@kernel.org>
References: <cover.1642679130.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rely on ASSERT* macros and get rid of deprecated CHECK ones in
xdp_adjust_tail bpf selftest.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bpf/prog_tests/xdp_adjust_tail.c          | 68 ++++++++-----------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 3f5a17c38be5..d5ebe92b0ebb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -11,22 +11,21 @@ static void test_xdp_adjust_tail_shrink(void)
 	char buf[128];
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
-	if (CHECK_FAIL(err))
+	if (ASSERT_OK(err, "test_xdp_adjust_tail_shrink"))
 		return;
 
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
-
-	CHECK(err || retval != XDP_DROP,
-	      "ipv4", "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
+	ASSERT_OK(err, "ipv4");
+	ASSERT_EQ(retval, XDP_DROP, "ipv4 retval");
 
 	expect_sz = sizeof(pkt_v6) - 20;  /* Test shrink with 20 bytes */
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_TX || size != expect_sz,
-	      "ipv6", "err %d errno %d retval %d size %d expect-size %d\n",
-	      err, errno, retval, size, expect_sz);
+	ASSERT_OK(err, "ipv6");
+	ASSERT_EQ(retval, XDP_TX, "ipv6 retval");
+	ASSERT_EQ(size, expect_sz, "ipv6 size");
+
 	bpf_object__close(obj);
 }
 
@@ -39,21 +38,20 @@ static void test_xdp_adjust_tail_grow(void)
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
+	ASSERT_OK(err, "ipv4");
+	ASSERT_EQ(retval, XDP_DROP, "ipv4 retval");
 
 	expect_sz = sizeof(pkt_v6) + 40; /* Test grow with 40 bytes */
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6) /* 74 */,
 				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_TX || size != expect_sz,
-	      "ipv6", "err %d errno %d retval %d size %d expect-size %d\n",
-	      err, errno, retval, size, expect_sz);
+	ASSERT_OK(err, "ipv6");
+	ASSERT_EQ(retval, XDP_TX, "ipv6 retval");
+	ASSERT_EQ(size, expect_sz, "ipv6 size");
 
 	bpf_object__close(obj);
 }
@@ -76,7 +74,7 @@ static void test_xdp_adjust_tail_grow2(void)
 	};
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &tattr.prog_fd);
-	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+	if (ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;
 
 	/* Test case-64 */
@@ -86,21 +84,17 @@ static void test_xdp_adjust_tail_grow2(void)
 	/* Kernel side alloc packet memory area that is zero init */
 	err = bpf_prog_test_run_xattr(&tattr);
 
-	CHECK_ATTR(errno != ENOSPC /* Due limit copy_size in bpf_test_finish */
-		   || tattr.retval != XDP_TX
-		   || tattr.data_size_out != 192, /* Expected grow size */
-		   "case-64",
-		   "err %d errno %d retval %d size %d\n",
-		   err, errno, tattr.retval, tattr.data_size_out);
+	ASSERT_EQ(errno, ENOSPC, "case-64 errno"); /* Due limit copy_size in bpf_test_finish */
+	ASSERT_EQ(tattr.retval, XDP_TX, "case-64 retval");
+	ASSERT_EQ(tattr.data_size_out, 192, "case-64 data_size_out"); /* Expected grow size */
 
 	/* Extra checks for data contents */
-	CHECK_ATTR(tattr.data_size_out != 192
-		   || buf[0]   != 1 ||  buf[63]  != 1  /*  0-63  memset to 1 */
-		   || buf[64]  != 0 ||  buf[127] != 0  /* 64-127 memset to 0 */
-		   || buf[128] != 1 ||  buf[191] != 1, /*128-191 memset to 1 */
-		   "case-64-data",
-		   "err %d errno %d retval %d size %d\n",
-		   err, errno, tattr.retval, tattr.data_size_out);
+	ASSERT_EQ(buf[0], 1, "case-64-data buf[0]"); /*  0-63  memset to 1 */
+	ASSERT_EQ(buf[63], 1, "case-64-data buf[63]");
+	ASSERT_EQ(buf[64], 0, "case-64-data buf[64]"); /* 64-127 memset to 0 */
+	ASSERT_EQ(buf[127], 0, "case-64-data buf[127]");
+	ASSERT_EQ(buf[128], 1, "case-64-data buf[128]"); /* 128-191 memset to 1 */
+	ASSERT_EQ(buf[191], 1, "case-64-data buf[191]");
 
 	/* Test case-128 */
 	memset(buf, 2, sizeof(buf));
@@ -109,23 +103,17 @@ static void test_xdp_adjust_tail_grow2(void)
 	err = bpf_prog_test_run_xattr(&tattr);
 
 	max_grow = 4096 - XDP_PACKET_HEADROOM -	tailroom; /* 3520 */
-	CHECK_ATTR(err
-		   || tattr.retval != XDP_TX
-		   || tattr.data_size_out != max_grow,/* Expect max grow size */
-		   "case-128",
-		   "err %d errno %d retval %d size %d expect-size %d\n",
-		   err, errno, tattr.retval, tattr.data_size_out, max_grow);
+	ASSERT_OK(err, "case-128");
+	ASSERT_EQ(tattr.retval, XDP_TX, "case-128 retval");
+	ASSERT_EQ(tattr.data_size_out, max_grow, "case-128 data_size_out"); /* Expect max grow */
 
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
+	ASSERT_EQ(cnt, max_grow - tattr.data_size_in, "case-128-data cnt"); /* Grow increase */
+	ASSERT_EQ(tattr.data_size_out, max_grow, "case-128-data data_size_out"); /* Total grow */
 
 	bpf_object__close(obj);
 }
-- 
2.34.1

