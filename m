Return-Path: <bpf+bounces-12393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A17CBD38
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1EB21066
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC293AC16;
	Tue, 17 Oct 2023 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="J4UOSw3V"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28D11CB6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 08:17:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024993
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=PKQdgVnD2ad/TAWGAL0EXkM8vrtDqYy3IApL5y7rkCo=; b=J4UOSw3VUtX7w5giQuvrqK6cmX
	RfSafW6qIyv/TbgQvt50T6iIjEzA+pppuvfuqmuCFDY21Eb2MrXBlfhLSeSYozchtYBQL3gRgqlos
	VLP+PgZSfPYbBnOOgaJ1wzlIkl8QVGKdz3k5ioIj0EG81sKTOr34I1w5yIcoxLqtybn2wCsACxr8G
	7xWVdB6YWnZm4OYcwMe74vf4ivlhxZW8hmWipF3DD0ofjowLSIj8CLd3Szi3sHVqFH9ojNGhzkZ2X
	MKrwC8tBhXdmQwcJSyad5OwbVx+Sd0YdDmWUVObI9DqJyJbfdWEnfVy+hXpNnaH+CIa8zsethHB0n
	e1h+iKJA==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsfGd-000HSA-FD; Tue, 17 Oct 2023 10:17:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] selftests/bpf: Add additional mprog query test coverage
Date: Tue, 17 Oct 2023 10:17:28 +0200
Message-Id: <20231017081728.24769-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add several new test cases which assert corner cases on the mprog query
mechanism, for example, around passing in a too small or a larger array
than the current count.

  ./test_progs -t tc_opts
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
  #269     tc_opts_query_attach:OK
  #270     tc_opts_replace:OK
  #271     tc_opts_revision:OK
  Summary: 20/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_opts.c        | 131 +++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index ca506d2fcf58..51883ccb8020 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2471,7 +2471,7 @@ static void test_tc_opts_query_target(int target)
 	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
 	struct test_tc_link *skel;
 	union bpf_attr attr;
-	__u32 prog_ids[5];
+	__u32 prog_ids[10];
 	int err;
 
 	skel = test_tc_link__open_and_load();
@@ -2599,6 +2599,135 @@ static void test_tc_opts_query_target(int target)
 	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
 	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
 
+	/* Test 3: Query with smaller prog_ids array */
+	memset(&attr, 0, attr_size);
+	attr.query.target_ifindex = loopback;
+	attr.query.attach_type = target;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	attr.query.prog_ids = ptr_to_u64(prog_ids);
+	attr.query.count = 2;
+
+	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
+	ASSERT_EQ(err, -1, "prog_query_should_fail");
+	ASSERT_EQ(errno, ENOSPC, "prog_query_should_fail");
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
+	ASSERT_EQ(prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(prog_ids[3], 0, "prog_ids[3]");
+	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
+	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
+	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
+
+	/* Test 4: Query with larger prog_ids array */
+	memset(&attr, 0, attr_size);
+	attr.query.target_ifindex = loopback;
+	attr.query.attach_type = target;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	attr.query.prog_ids = ptr_to_u64(prog_ids);
+	attr.query.count = 10;
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
+	/* Test 5: Query with NULL prog_ids array but with count > 0 */
+	memset(&attr, 0, attr_size);
+	attr.query.target_ifindex = loopback;
+	attr.query.attach_type = target;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	attr.query.count = sizeof(prog_ids);
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
+	ASSERT_EQ(prog_ids[0], 0, "prog_ids[0]");
+	ASSERT_EQ(prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(prog_ids[3], 0, "prog_ids[3]");
+	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(attr.query.prog_ids, 0, "prog_ids");
+	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
+	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
+	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
+
+	/* Test 6: Query with non-NULL prog_ids array but with count == 0 */
+	memset(&attr, 0, attr_size);
+	attr.query.target_ifindex = loopback;
+	attr.query.attach_type = target;
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
+	ASSERT_EQ(prog_ids[0], 0, "prog_ids[0]");
+	ASSERT_EQ(prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(prog_ids[3], 0, "prog_ids[3]");
+	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(attr.query.prog_ids, ptr_to_u64(prog_ids), "prog_ids");
+	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
+	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
+	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
+
+	/* Test 7: Query with invalid flags */
+	attr.query.attach_flags = 0;
+	attr.query.query_flags = 1;
+
+	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
+	ASSERT_EQ(err, -1, "prog_query_should_fail");
+	ASSERT_EQ(errno, EINVAL, "prog_query_should_fail");
+
+	attr.query.attach_flags = 1;
+	attr.query.query_flags = 0;
+
+	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
+	ASSERT_EQ(err, -1, "prog_query_should_fail");
+	ASSERT_EQ(errno, EINVAL, "prog_query_should_fail");
+
 cleanup4:
 	err = bpf_prog_detach_opts(fd4, loopback, target, &optd);
 	ASSERT_OK(err, "prog_detach");
-- 
2.34.1


