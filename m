Return-Path: <bpf+bounces-7004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C17700DD
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA0A282644
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7641BE68;
	Fri,  4 Aug 2023 13:12:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5ECA940
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 13:12:00 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678C46A8
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JW6kJQwI1T84EIc1M685myGKFY6tDYT7PQzXyE1nGps=; b=HkKxibKYeV903XofreWwmbU/pK
	EG22ywtogtS0VqlwOAoQSHlpj+Lp2sQk1ZQ6pTCl6Uah4ywEmBIEoE4yRZgeXA2CaCCnx2SgQqz8O
	ZPEoVKzunAboiTxdDf0BHdDciM5rxltb4KT5ZFyhlD48QA6m3pLh6l6li429b8BL6VJNzEI6DmIq+
	E6RvN4IbjKA7jfPNbXzlZrouj0KRzZ+A2GUkqHVZTuqkF7yjNzviJM6KmA9/M0L1KfFdoGRIoHooV
	0SHManAd7I0fvdsc/krsElDa7wfxu7ZK4TbieLija4uzcHdcZfRHqHisrtWX+fyrbF7aFJ3dCfQ+g
	k/rfr4Ng==;
Received: from [180.200.247.117] (helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qRuaz-000IUK-7M; Fri, 04 Aug 2023 15:11:57 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for detachment on empty mprog entry
Date: Fri,  4 Aug 2023 15:11:12 +0200
Message-Id: <20230804131112.11012-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230804131112.11012-1-daniel@iogearbox.net>
References: <20230804131112.11012-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26990/Fri Aug  4 09:32:00 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a detachment test case with miniq present to assert that with and
without the miniq we get the same error.

  # ./test_progs -t tc_opts
  #244     tc_opts_after:OK
  #245     tc_opts_append:OK
  #246     tc_opts_basic:OK
  #247     tc_opts_before:OK
  #248     tc_opts_chain_classic:OK
  #249     tc_opts_delete_empty:OK
  #250     tc_opts_demixed:OK
  #251     tc_opts_detach:OK
  #252     tc_opts_detach_after:OK
  #253     tc_opts_detach_before:OK
  #254     tc_opts_dev_cleanup:OK
  #255     tc_opts_invalid:OK
  #256     tc_opts_mixed:OK
  #257     tc_opts_prepend:OK
  #258     tc_opts_replace:OK
  #259     tc_opts_revision:OK
  Summary: 16/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_opts.c        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index 7914100f9b46..39bd253e41aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2237,3 +2237,34 @@ void serial_test_tc_opts_detach_after(void)
 	test_tc_opts_detach_after_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_after_target(BPF_TCX_EGRESS);
 }
+
+static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = loopback);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	int err;
+
+	assert_mprog_count(target, 0);
+	if (chain_tc_old) {
+		tc_hook.attach_point = target == BPF_TCX_INGRESS ?
+				       BPF_TC_INGRESS : BPF_TC_EGRESS;
+		err = bpf_tc_hook_create(&tc_hook);
+		ASSERT_OK(err, "bpf_tc_hook_create");
+		__assert_mprog_count(target, 0, true, loopback);
+	}
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_EQ(err, -ENOENT, "prog_detach");
+	if (chain_tc_old) {
+		tc_hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
+		bpf_tc_hook_destroy(&tc_hook);
+	}
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_opts_delete_empty(void)
+{
+	test_tc_opts_delete_empty(BPF_TCX_INGRESS, false);
+	test_tc_opts_delete_empty(BPF_TCX_EGRESS, false);
+	test_tc_opts_delete_empty(BPF_TCX_INGRESS, true);
+	test_tc_opts_delete_empty(BPF_TCX_EGRESS, true);
+}
-- 
2.34.1


