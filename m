Return-Path: <bpf+bounces-11583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11117BC201
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3817C282216
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D58A450D3;
	Fri,  6 Oct 2023 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BqpiozE2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95B450E1
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:07:12 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04419C6
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vmjt1zucbNReqKZHFcgq4P0pS9RiDVa24Zh8J5ZgTS4=; b=BqpiozE2ia25S5FUKKfGJDJtEt
	dweeUQwPpc5v6/xaTRiKHflV3nLCuxr+pvKD5VTl12I179/G6H/CeZRCPRTNKJDxUF/p2lv8JRK2K
	3A7jhsvJolwDvZzI30EMMBNI4E6Pm0uxZE6V3sBn66i8LYm9n2gPughAeEDhzYBLz/2JgoTC/hXTa
	8TgENHCPQrf/LkoS4lITXgDFykLY6d3ToRnUjHjZWHrqC3Xu0w/KoMr+VvtzL8Z+mW9d8AqD0oYjI
	wfUes4mOIReQgpeFOJUkKT4Fd6+2LTpu5qHiP2ForGqv51WQP/XB/vFSk9nUBGPaLJiXImtaBZIlm
	p7BhvEAw==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qosyR-0001kb-Pi; Sat, 07 Oct 2023 00:07:07 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: lmb@isovalent.com,
	martin.lau@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 6/7] selftests/bpf: Test query on empty mprog and pass revision into attach
Date: Sat,  7 Oct 2023 00:06:54 +0200
Message-Id: <20231006220655.1653-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231006220655.1653-1-daniel@iogearbox.net>
References: <20231006220655.1653-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new test case to query on an empty bpf_mprog and pass the revision
directly into expected_revision for attachment to assert that this does
succeed.

  ./test_progs -t tc_opts
  [    1.406778] tsc: Refined TSC clocksource calibration: 3407.990 MHz
  [    1.408863] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcaf6eb0, max_idle_ns: 440795321766 ns
  [    1.412419] clocksource: Switched to clocksource tsc
  [    1.428671] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.430260] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #252     tc_opts_after:OK
  #253     tc_opts_append:OK
  #254     tc_opts_basic:OK
  #255     tc_opts_before:OK
  #256     tc_opts_chain_classic:OK
  #257     tc_opts_chain_mixed:OK
  #258     tc_opts_delete_empty:OK
  #259     tc_opts_demixed:OK
  #260     tc_opts_detach:OK
  #261     tc_opts_detach_after:OK
  #262     tc_opts_detach_before:OK
  #263     tc_opts_dev_cleanup:OK
  #264     tc_opts_invalid:OK
  #265     tc_opts_max:OK
  #266     tc_opts_mixed:OK
  #267     tc_opts_prepend:OK
  #268     tc_opts_query:OK
  #269     tc_opts_query_attach:OK     <--- (new test)
  #270     tc_opts_replace:OK
  #271     tc_opts_revision:OK
  Summary: 20/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_opts.c        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index 2174bea3427e..ba91b0226839 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2629,3 +2629,62 @@ void serial_test_tc_opts_query(void)
 	test_tc_opts_query_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_target(BPF_TCX_EGRESS);
 }
+
+static void test_tc_opts_query_attach_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	struct test_tc_link *skel;
+	__u32 prog_ids[2];
+	__u32 fd1, id1;
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	id1 = id_from_prog_fd(fd1);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 0, "count");
+	ASSERT_EQ(optq.revision, 1, "revision");
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision = optq.revision,
+	);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.prog_ids = prog_ids;
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup1;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+
+cleanup1:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_query_attach(void)
+{
+	test_tc_opts_query_attach_target(BPF_TCX_INGRESS);
+	test_tc_opts_query_attach_target(BPF_TCX_EGRESS);
+}
-- 
2.34.1


