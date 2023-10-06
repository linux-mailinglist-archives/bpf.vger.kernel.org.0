Return-Path: <bpf+bounces-11584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE607BC200
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC32F1C20B9E
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52A450FC;
	Fri,  6 Oct 2023 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FsVwmQdN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA042450DE
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:07:11 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E4C2
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VTU4pC+2vYp/g/9Dqh2XdHYO+xFsF/lWNjBMJswyRDU=; b=FsVwmQdN9qloh7xbXakF7jCvO9
	WLwaBsAS4Z8BcOlzbUHfnzg4x99KTRWWyaS/XupJO1b1y+ST6BqWut3+hGlcL41aNi0ij3mN/QPee
	b8urRwDUTUCohqJdY5HoKXK/53DkDH2v1Jc+cK+uAfGnvRR1xioI4u6Wv9wd598muq4bkPJ9vikAv
	4xmYc4tQZp5oqXB6GRYlznmu8iKDlu8GhARECL8Xt5xcQLu4Bux3hyRmXbBU8W/pSHwvVlotVEl2h
	v/0iaUdaobQZsbt7ykKwOiXgjSPEOsKBdv40kuWoGsGKaXjtZgTQCoth1S/xV7cvkhN3zTPXA9v92
	uhpboTgQ==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qosyQ-0001kF-BB; Sat, 07 Oct 2023 00:07:06 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: lmb@isovalent.com,
	martin.lau@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 4/7] selftests/bpf: Test bpf_mprog query API via libbpf and raw syscall
Date: Sat,  7 Oct 2023 00:06:52 +0200
Message-Id: <20231006220655.1653-4-daniel@iogearbox.net>
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

Add a new test case which performs double query of the bpf_mprog through
libbpf API, but also via raw bpf(2) syscall. This is testing to gather
first the count and then in a subsequent probe the full information with
the program array without clearing passed structs in between.

  # ./vmtest.sh -- ./test_progs -t tc_opts
  [...]
  ./test_progs -t tc_opts
  [    1.398818] tsc: Refined TSC clocksource calibration: 3407.999 MHz
  [    1.400263] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd336761, max_idle_ns: 440795243819 ns
  [    1.402734] clocksource: Switched to clocksource tsc
  [    1.426639] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.428112] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
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
  #268     tc_opts_query:OK            <--- (new test)
  #269     tc_opts_replace:OK
  #270     tc_opts_revision:OK
  Summary: 19/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_opts.c        | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index 99af79ea21a9..aeec10bb3396 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2462,3 +2462,170 @@ void serial_test_tc_opts_max(void)
 	test_tc_opts_max_target(BPF_TCX_INGRESS, BPF_F_AFTER, true);
 	test_tc_opts_max_target(BPF_TCX_EGRESS, BPF_F_AFTER, false);
 }
+
+static void test_tc_opts_query_target(int target)
+{
+	const size_t attr_size = offsetofend(union bpf_attr, query);
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
+	union bpf_attr attr;
+	__u32 prog_ids[5];
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	fd2 = bpf_program__fd(skel->progs.tc2);
+	fd3 = bpf_program__fd(skel->progs.tc3);
+	fd4 = bpf_program__fd(skel->progs.tc4);
+
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(fd3);
+	id4 = id_from_prog_fd(fd4);
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision = 1,
+	);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision = 2,
+	);
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision = 3,
+	);
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision = 4,
+	);
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(target, 4);
+
+	/* Test 1: Double query via libbpf API */
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids, NULL, "prog_ids");
+	ASSERT_EQ(optq.link_ids, NULL, "link_ids");
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.prog_ids = prog_ids;
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id3, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids, NULL, "link_ids");
+
+	/* Test 2: Double query via bpf_attr & bpf(2) directly */
+	memset(&attr, 0, attr_size);
+	attr.query.target_ifindex = loopback;
+	attr.query.attach_type = target;
+
+	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(attr.query.count, 4, "count");
+	ASSERT_EQ(attr.query.revision, 5, "revision");
+	ASSERT_EQ(attr.query.query_flags, 0, "query_flags");
+	ASSERT_EQ(attr.query.attach_flags, 0, "attach_flags");
+	ASSERT_EQ(attr.query.target_ifindex, loopback, "target_ifindex");
+	ASSERT_EQ(attr.query.attach_type, target, "attach_type");
+	ASSERT_EQ(attr.query.prog_ids, 0, "prog_ids");
+	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
+	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
+	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	attr.query.prog_ids = ptr_to_u64(prog_ids);
+
+	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(attr.query.count, 4, "count");
+	ASSERT_EQ(attr.query.revision, 5, "revision");
+	ASSERT_EQ(attr.query.query_flags, 0, "query_flags");
+	ASSERT_EQ(attr.query.attach_flags, 0, "attach_flags");
+	ASSERT_EQ(attr.query.target_ifindex, loopback, "target_ifindex");
+	ASSERT_EQ(attr.query.attach_type, target, "attach_type");
+	ASSERT_EQ(attr.query.prog_ids, ptr_to_u64(prog_ids), "prog_ids");
+	ASSERT_EQ(prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(prog_ids[2], id3, "prog_ids[2]");
+	ASSERT_EQ(prog_ids[3], id4, "prog_ids[3]");
+	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
+	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
+	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
+
+cleanup4:
+	err = bpf_prog_detach_opts(fd4, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 3);
+
+cleanup3:
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 2);
+
+cleanup2:
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+cleanup1:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_query(void)
+{
+	test_tc_opts_query_target(BPF_TCX_INGRESS);
+	test_tc_opts_query_target(BPF_TCX_EGRESS);
+}
-- 
2.34.1


