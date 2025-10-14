Return-Path: <bpf+bounces-70925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C07BDB3A8
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE9C19A33A3
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 20:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7830649C;
	Tue, 14 Oct 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC9dmqqf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783082BE02A
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473239; cv=none; b=XUSJX+ogTHA6x1gXWw1Kfl2DIdGqncyuk/yGKHbfZqVuloyC+vGY2wum7JNVXJrYDsK4Q2KD8BjM9sVDqJXXxDqOQc8bLVgbul8/18R2IHhSVxXTkLfc5PI3lywUfQFG3loE/qRzbIkM/mFOxFMgrk9qCQKhXaGN2elmbYSRQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473239; c=relaxed/simple;
	bh=O3vlScRm5TcpnaPEh+V4zUy9/F79cPMzH1nOhvQifa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLXfU22888sIlsU/C2G/DPxdfVBSHjBChIuaDqdL/MR1NWHl0iydjlJ6xrtRIeT1wf7GyO7OB0mf5LJXRlgmiSq7Svf5LRK8+CHDCFZYcOIbMyvxqDFugJGx/h/VCVo2i82ZrSoFI0ZGNHk7bJRFnEcvjbh3EQn3XhNgj3KkUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC9dmqqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53C6C4CEE7;
	Tue, 14 Oct 2025 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760473239;
	bh=O3vlScRm5TcpnaPEh+V4zUy9/F79cPMzH1nOhvQifa0=;
	h=From:To:Cc:Subject:Date:From;
	b=iC9dmqqfofR5T/15JbAjaqAHE+DqESKNfGnh+6zVBnw8u34cIUNoiAC9zO22KFdXi
	 /bzN7iGEto6asuNSWR/vM+LwToNW2r33xmrnns6JG6Gjb2VrHuIEdipUR/ptSl0QgA
	 dC5nPchdLUubiDl35eqUpvHjxm9VfQ04szBbNqLzRA4dypeUw4qZHNK9lUXpzXsjjw
	 CxUpASeCWvHZeBXopSSQWR2c3H2fY7J7vtD5/d0pnU4vMr0kSeVymcITx0zSWWmHtM
	 PP74BVEdxLWiwkjOYn6IZUqVRGtQ+wrMxFkMQvIsABGZ7/G90Ipn8DD3qhTTGdfTcE
	 0kYjw7QDps10g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: make arg_parsing.c more robust to crashes
Date: Tue, 14 Oct 2025 13:20:37 -0700
Message-ID: <20251014202037.72922-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We started getting a crash in BPF CI, which seems to originate from
test_parse_test_list_file() test and is happening at this line:

  ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");

One way we can crash there is if set.cnt zero, which is checked for with
ASSERT_EQ() above, but we proceed after this regardless of the outcome.
Instead of crashing, we should bail out with test failure early.

Similarly, if parse_test_list_file() fails, we shouldn't be even looking
at set, so bail even earlier if ASSERT_OK() fails.

Fixes: 64276f01dce8 ("selftests/bpf: Test_progs can read test lists from file")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..fbf0d9c2f58b 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -146,9 +146,12 @@ static void test_parse_test_list_file(void)
 
 	init_test_filter_set(&set);
 
-	ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file");
+	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
+		goto out_fclose;
+
+	if (!ASSERT_EQ(set.cnt, 4, "test  count"))
+		goto out_free_set;
 
-	ASSERT_EQ(set.cnt, 4, "test  count");
 	ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");
 	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "test 0 subtest count");
 	ASSERT_OK(strcmp("testA", set.tests[1].name), "test 1 name");
@@ -158,8 +161,8 @@ static void test_parse_test_list_file(void)
 	ASSERT_OK(strcmp("testB", set.tests[2].name), "test 2 name");
 	ASSERT_OK(strcmp("testC_no_eof_newline", set.tests[3].name), "test 3 name");
 
+out_free_set:
 	free_test_filter_set(&set);
-
 out_fclose:
 	fclose(fp);
 out_remove:
-- 
2.47.3


