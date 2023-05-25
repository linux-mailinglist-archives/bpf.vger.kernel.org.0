Return-Path: <bpf+bounces-1255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70004711A8B
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 01:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A481C20F5F
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895C261C5;
	Thu, 25 May 2023 23:23:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F7259A
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 23:23:06 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A91E7
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 16:23:04 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 32F15240029
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 01:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1685056971; bh=2kzZdrtOS1gQcDyIcKNeUz2twkgcwZdRJJaoVQ54NrM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=eKgDrMzEO4Ga0zLs7SDJTzOsTRoLPo4KtMM8bidp9TyhyP4C7zESpxOG6l9y6GGCt
	 W2xzVEKzGTp4c+CIpEN4jVFpa7nWWIvALoPKBxKyzROxhH+B06jYS8LYv3r4ivyNmC
	 nNV7GIwbLETb7bAk9MoPxIi8kT7tnRGr5KLe0/71Dce3HX8AqJOs5tSgCbS2JmXzPh
	 ul/PpwvkN1Bnm0W0fjhwZPxGQzw6GDp95EcWWbL4szFY6Hhg+upDNMPeCdOrInVCFm
	 aovV/XIDV/0XCX9nRLkU1Ak6/jMEF5XEx2ZB/eFPIDLV/eGFyRqDiTAr97u+pg5kSl
	 aSAk6lQHXg4kw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4QS3xk1KCHz9rxB;
	Fri, 26 May 2023 01:22:50 +0200 (CEST)
From: =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Check whether to run selftest
Date: Thu, 25 May 2023 23:22:48 +0000
Message-Id: <20230525232248.640465-1-deso@posteo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The sockopt test invokes test__start_subtest and then unconditionally
asserts the success. That means that even if deny-listed, any test will
still run and potentially fail.
Evaluate the return value of test__start_subtest() to achieve the
desired behavior, as other tests do.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/prog_tests/sockopt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index 33dd45..9e6a5e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -1060,7 +1060,9 @@ void test_sockopt(void)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		test__start_subtest(tests[i].descr);
+		if (!test__start_subtest(tests[i].descr))
+			continue;
+
 		ASSERT_OK(run_test(cgroup_fd, &tests[i]), tests[i].descr);
 	}
 
-- 
2.34.1


