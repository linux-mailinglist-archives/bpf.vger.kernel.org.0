Return-Path: <bpf+bounces-4465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C374B5DB
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141E428189E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12517ACB;
	Fri,  7 Jul 2023 17:26:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021A17AA3;
	Fri,  7 Jul 2023 17:26:10 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8FD2729;
	Fri,  7 Jul 2023 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cyNQKLDKuAkvhl/kbP3Ll3w1DlBwgnbhRkvYOBnjRNk=; b=SHNNis2+qgA1IR/GWNk1TBo6uv
	f/8mHOrIpOs481Rf8FPh1zLsHXTWxjE8nJzoaLxAAaLPbL8UoBD7hsAIiC9aU7j/rkGsR7ZvF3f0d
	d93+X/RiDYXasqcAd14ZXcNMDTPeNJy+4JJGXjeuMPb/mYzxex5MB7p/6ZwXNbDIDqy+3UbYmbPPR
	KvddyYhyL+5INwlcbaovFFM2l6VCktlmfMKVkRnJ+qtM5GRys7fPolxjLS7G0ul0UlGXjiOEvymQK
	pivytK0V0td3hEs/9XhVubUxVybjScLeAJSNroIFkbjrFyskqrh6+14V2RXXypWjh3NWb748n9laT
	K4F9Resw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qHpCi-000Azo-Ah; Fri, 07 Jul 2023 19:25:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	sdf@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	dxu@dxuuu.xyz,
	joe@cilium.io,
	toke@kernel.org,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: Add mprog API tests for BPF tcx links
Date: Fri,  7 Jul 2023 19:24:55 +0200
Message-Id: <20230707172455.7634-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230707172455.7634-1-daniel@iogearbox.net>
References: <20230707172455.7634-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26962/Fri Jul  7 09:29:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a big batch of test coverage to assert all aspects of the tcx link API:

  # ./vmtest.sh -- ./test_progs -t tc_links
  [...]
  #225     tc_links_after:OK
  #226     tc_links_append:OK
  #227     tc_links_basic:OK
  #228     tc_links_before:OK
  #229     tc_links_chain_classic:OK
  #230     tc_links_dev_cleanup:OK
  #231     tc_links_invalid:OK
  #232     tc_links_prepend:OK
  #233     tc_links_replace:OK
  #234     tc_links_revision:OK
  Summary: 10/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_links.c       | 1604 +++++++++++++++++
 1 file changed, 1604 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_links.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
new file mode 100644
index 000000000000..6a05f75492b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -0,0 +1,1604 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+#include <uapi/linux/if_link.h>
+#include <net/if.h>
+#include <test_progs.h>
+
+#define loopback 1
+#define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
+
+#include "test_tc_link.skel.h"
+#include "tc_helpers.h"
+
+void serial_test_tc_links_basic(void)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_ids[2], link_ids[2];
+	__u32 pid1, pid2, lid1, lid2;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count(BPF_TCX_INGRESS, 0);
+	assert_mprog_count(BPF_TCX_EGRESS, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc1, false, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(BPF_TCX_INGRESS, 1);
+	assert_mprog_count(BPF_TCX_EGRESS, 0);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, BPF_TCX_INGRESS, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+	ASSERT_NEQ(lid1, lid2, "link_ids_1_2");
+
+	assert_mprog_count(BPF_TCX_INGRESS, 1);
+	assert_mprog_count(BPF_TCX_EGRESS, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, BPF_TCX_EGRESS, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid2, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid2, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count(BPF_TCX_INGRESS, 0);
+	assert_mprog_count(BPF_TCX_EGRESS, 0);
+}
+
+static void test_tc_links_before_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_ids[5], link_ids[5];
+	__u32 pid1, pid2, pid3, pid4;
+	__u32 lid1, lid2, lid3, lid4;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc3, target),
+		  0, "tc3_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc4, target),
+		  0, "tc4_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+	pid4 = id_from_prog_fd(bpf_program__fd(skel->progs.tc4));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid3, pid4, "prog_ids_3_4");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(target, 1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid2, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid2, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc3 = link;
+
+	lid3 = id_from_link_fd(bpf_link__fd(skel->links.tc3));
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_LINK;
+	optl.relative_id = lid1;
+
+	link = bpf_program__attach_tcx(skel->progs.tc4, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc4 = link;
+
+	lid4 = id_from_link_fd(bpf_link__fd(skel->links.tc4));
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid4, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid4, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid1, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid1, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], pid3, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], lid3, "link_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], pid2, "prog_ids[3]");
+	ASSERT_EQ(optq.link_ids[3], lid2, "link_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_before(void)
+{
+	test_tc_links_before_target(BPF_TCX_INGRESS);
+	test_tc_links_before_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_links_after_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_ids[5], link_ids[5];
+	__u32 pid1, pid2, pid3, pid4;
+	__u32 lid1, lid2, lid3, lid4;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc3, target),
+		  0, "tc3_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc4, target),
+		  0, "tc4_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+	pid4 = id_from_prog_fd(bpf_program__fd(skel->progs.tc4));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid3, pid4, "prog_ids_3_4");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(target, 1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid2, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid2, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc3 = link;
+
+	lid3 = id_from_link_fd(bpf_link__fd(skel->links.tc3));
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER | BPF_F_LINK;
+	optl.relative_fd = bpf_link__fd(skel->links.tc2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc4, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc4 = link;
+
+	lid4 = id_from_link_fd(bpf_link__fd(skel->links.tc4));
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid3, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid3, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], pid2, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], lid2, "link_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], pid4, "prog_ids[3]");
+	ASSERT_EQ(optq.link_ids[3], lid4, "link_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_after(void)
+{
+	test_tc_links_after_target(BPF_TCX_INGRESS);
+	test_tc_links_after_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_links_revision_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_ids[3], link_ids[3];
+	__u32 pid1, pid2, lid1, lid2;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count(target, 0);
+
+	optl.expected_revision = 1;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(target, 1);
+
+	optl.expected_revision = 1;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 1);
+
+	optl.expected_revision = 2;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid2, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid2, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_revision(void)
+{
+	test_tc_links_revision_target(BPF_TCX_INGRESS);
+	test_tc_links_revision_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_chain_classic(int target, bool chain_tc_old)
+{
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = loopback);
+	bool hook_created = false, tc_attached = false;
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	__u32 pid1, pid2, pid3;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	if (chain_tc_old) {
+		tc_hook.attach_point = target == BPF_TCX_INGRESS ?
+				       BPF_TC_INGRESS : BPF_TC_EGRESS;
+		err = bpf_tc_hook_create(&tc_hook);
+		if (err == 0)
+			hook_created = true;
+		err = err == -EEXIST ? 0 : err;
+		if (!ASSERT_OK(err, "bpf_tc_hook_create"))
+			goto cleanup;
+
+		tc_opts.prog_fd = bpf_program__fd(skel->progs.tc3);
+		err = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(err, "bpf_tc_attach"))
+			goto cleanup;
+		tc_attached = true;
+	}
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	assert_mprog_count(target, 2);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+	skel->bss->seen_tc3 = false;
+
+	err = bpf_link__detach(skel->links.tc2);
+	if (!ASSERT_OK(err, "prog_detach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
+cleanup:
+	if (tc_attached) {
+		tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
+		err = bpf_tc_detach(&tc_hook, &tc_opts);
+		ASSERT_OK(err, "bpf_tc_detach");
+	}
+	if (hook_created) {
+		tc_hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
+		bpf_tc_hook_destroy(&tc_hook);
+	}
+	assert_mprog_count(target, 1);
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_chain_classic(void)
+{
+	test_tc_chain_classic(BPF_TCX_INGRESS, false);
+	test_tc_chain_classic(BPF_TCX_EGRESS, false);
+	test_tc_chain_classic(BPF_TCX_INGRESS, true);
+	test_tc_chain_classic(BPF_TCX_EGRESS, true);
+}
+
+static void test_tc_links_replace_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 pid1, pid2, pid3, lid1, lid2;
+	__u32 prog_ids[4], link_ids[4];
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc3, target),
+		  0, "tc3_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	optl.expected_revision = 1;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE;
+	optl.relative_id = pid1;
+	optl.expected_revision = 2;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid2, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid2, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid1, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid1, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+	skel->bss->seen_tc3 = false;
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_REPLACE;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc2);
+	optl.expected_revision = 3;
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_REPLACE | BPF_F_LINK;
+	optl.relative_fd = bpf_link__fd(skel->links.tc2);
+	optl.expected_revision = 3;
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_REPLACE | BPF_F_LINK | BPF_F_AFTER;
+	optl.relative_id = lid2;
+	optl.expected_revision = 0;
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 2);
+
+	err = bpf_link__update_program(skel->links.tc2, skel->progs.tc3);
+	if (!ASSERT_OK(err, "link_update"))
+		goto cleanup;
+
+	assert_mprog_count(target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 4, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid3, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid2, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid1, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid1, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+	skel->bss->seen_tc3 = false;
+
+	err = bpf_link__detach(skel->links.tc2);
+	if (!ASSERT_OK(err, "link_detach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+	skel->bss->seen_tc3 = false;
+
+	err = bpf_link__update_program(skel->links.tc1, skel->progs.tc1);
+	if (!ASSERT_OK(err, "link_update_self"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_replace(void)
+{
+	test_tc_links_replace_target(BPF_TCX_INGRESS);
+	test_tc_links_replace_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_links_invalid_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 pid1, pid2, lid1;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count(target, 0);
+
+	optl.flags = BPF_F_BEFORE | BPF_F_AFTER;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_ID;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER | BPF_F_ID;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_ID;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_LINK;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_LINK;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_AFTER;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_ID;
+	optl.relative_id = pid2;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_ID;
+	optl.relative_id = 42;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_LINK;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER | BPF_F_LINK;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER | BPF_F_LINK;
+	optl.relative_fd = bpf_program__fd(skel->progs.tc1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_LINK | BPF_F_ID;
+	optl.relative_id = ~0;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_LINK | BPF_F_ID;
+	optl.relative_id = lid1;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_ID;
+	optl.relative_id = pid1;
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE | BPF_F_LINK | BPF_F_ID;
+	optl.relative_id = lid1;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	assert_mprog_count(target, 2);
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_invalid(void)
+{
+	test_tc_links_invalid_target(BPF_TCX_INGRESS);
+	test_tc_links_invalid_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_links_prepend_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_ids[5], link_ids[5];
+	__u32 pid1, pid2, pid3, pid4;
+	__u32 lid1, lid2, lid3, lid4;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc3, target),
+		  0, "tc3_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc4, target),
+		  0, "tc4_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+	pid4 = id_from_prog_fd(bpf_program__fd(skel->progs.tc4));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid3, pid4, "prog_ids_3_4");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid2, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid2, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid1, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid1, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE;
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc3 = link;
+
+	lid3 = id_from_link_fd(bpf_link__fd(skel->links.tc3));
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_BEFORE;
+
+	link = bpf_program__attach_tcx(skel->progs.tc4, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc4 = link;
+
+	lid4 = id_from_link_fd(bpf_link__fd(skel->links.tc4));
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid4, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid4, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid3, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid3, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], pid2, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], lid2, "link_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], pid1, "prog_ids[3]");
+	ASSERT_EQ(optq.link_ids[3], lid1, "link_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_prepend(void)
+{
+	test_tc_links_prepend_target(BPF_TCX_INGRESS);
+	test_tc_links_prepend_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_links_append_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_ids[5], link_ids[5];
+	__u32 pid1, pid2, pid3, pid4;
+	__u32 lid1, lid2, lid3, lid4;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc3, target),
+		  0, "tc3_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc4, target),
+		  0, "tc4_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+	pid4 = id_from_prog_fd(bpf_program__fd(skel->progs.tc4));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid3, pid4, "prog_ids_3_4");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid2, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid2, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER;
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc3 = link;
+
+	lid3 = id_from_link_fd(bpf_link__fd(skel->links.tc3));
+
+	LIBBPF_OPTS_CLEAR(optl);
+	optl.ifindex = loopback;
+	optl.flags = BPF_F_AFTER;
+
+	link = bpf_program__attach_tcx(skel->progs.tc4, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc4 = link;
+
+	lid4 = id_from_link_fd(bpf_link__fd(skel->links.tc4));
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid2, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid2, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], pid3, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], lid3, "link_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], pid4, "prog_ids[3]");
+	ASSERT_EQ(optq.link_ids[3], lid4, "link_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_append(void)
+{
+	test_tc_links_append_target(BPF_TCX_INGRESS);
+	test_tc_links_append_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_links_dev_cleanup_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 pid1, pid2, pid3, pid4;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, ifindex;
+
+	ASSERT_OK(system("ip link add dev tcx_opts1 type veth peer name tcx_opts2"), "add veth");
+	ifindex = if_nametoindex("tcx_opts1");
+	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
+	optl.ifindex = ifindex;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc3, target),
+		  0, "tc3_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc4, target),
+		  0, "tc4_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+	pid4 = id_from_prog_fd(bpf_program__fd(skel->progs.tc4));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid3, pid4, "prog_ids_3_4");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc3 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 3);
+
+	link = bpf_program__attach_tcx(skel->progs.tc4, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc4 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 4);
+
+	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
+	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
+	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc1)), 0, "tc1_ifindex");
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc2)), 0, "tc2_ifindex");
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc3)), 0, "tc3_ifindex");
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc4)), 0, "tc4_ifindex");
+
+	test_tc_link__destroy(skel);
+	return;
+cleanup:
+	test_tc_link__destroy(skel);
+
+	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
+	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
+	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+}
+
+void serial_test_tc_links_dev_cleanup(void)
+{
+	test_tc_links_dev_cleanup_target(BPF_TCX_INGRESS);
+	test_tc_links_dev_cleanup_target(BPF_TCX_EGRESS);
+}
-- 
2.34.1


