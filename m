Return-Path: <bpf+bounces-4638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43E74DEFC
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03791C20B40
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02118168CE;
	Mon, 10 Jul 2023 20:12:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB8168A9;
	Mon, 10 Jul 2023 20:12:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA75BB;
	Mon, 10 Jul 2023 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=emsGQ8Rg9GHYfo1L5zL+d5fJYhcG4VEGnvO7wbeSu08=; b=PANr4wwl2mRzvl2MAKVwAKrYQy
	TeRaRFdTWSD8piqDRUAp5SS29yLBdNkWMOnkl6m1pI30Z1cZ2Gg4/ik6cz4sUebVtr6Dg8CI0kKJe
	oGZZPitLy3pVNuLO3W2MuH55UvWetddZhOFNtCSa+4GF8vmZg5d9aixB7ZcQZwO3QAe3aLw9341Ev
	sRNa8WDF9wxpklSI98aeOythz1CeKm7CaKrqhnv1HRE9qyNBY93DuOmv/Q9Thu/yCUrfAesiJ9uJI
	WJarC5KoVwarJ+y9zUovX/ccKwlOtx5sHCvGFVX9c4SO0E9QCWWFLxsdGUGTAdnfux4VWWChrgX4n
	1I1JvT1Q==;
Received: from 12.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIxFF-000E66-Qv; Mon, 10 Jul 2023 22:12:30 +0200
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
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: Add mprog API tests for BPF tcx opts
Date: Mon, 10 Jul 2023 22:12:17 +0200
Message-Id: <20230710201218.19460-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230710201218.19460-1-daniel@iogearbox.net>
References: <20230710201218.19460-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a big batch of test coverage to assert all aspects of the tcx opts
attach, detach and query API:

  # ./vmtest.sh -- ./test_progs -t tc_opts
  [...]
  #238     tc_opts_after:OK
  #239     tc_opts_append:OK
  #240     tc_opts_basic:OK
  #241     tc_opts_before:OK
  #242     tc_opts_chain_classic:OK
  #243     tc_opts_demixed:OK
  #244     tc_opts_detach:OK
  #245     tc_opts_detach_after:OK
  #246     tc_opts_detach_before:OK
  #247     tc_opts_dev_cleanup:OK
  #248     tc_opts_invalid:OK
  #249     tc_opts_mixed:OK
  #250     tc_opts_prepend:OK
  #251     tc_opts_replace:OK
  #252     tc_opts_revision:OK
  Summary: 15/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_helpers.h     |   72 +
 .../selftests/bpf/prog_tests/tc_opts.c        | 2182 +++++++++++++++++
 .../selftests/bpf/progs/test_tc_link.c        |   40 +
 3 files changed, 2294 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_link.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
new file mode 100644
index 000000000000..6c93215be8a3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Isovalent */
+#ifndef TC_HELPERS
+#define TC_HELPERS
+#include <test_progs.h>
+
+static inline __u32 id_from_prog_fd(int fd)
+{
+	struct bpf_prog_info prog_info = {};
+	__u32 prog_info_len = sizeof(prog_info);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(fd, &prog_info, &prog_info_len);
+	if (!ASSERT_OK(err, "id_from_prog_fd"))
+		return 0;
+
+	ASSERT_NEQ(prog_info.id, 0, "prog_info.id");
+	return prog_info.id;
+}
+
+static inline __u32 id_from_link_fd(int fd)
+{
+	struct bpf_link_info link_info = {};
+	__u32 link_info_len = sizeof(link_info);
+	int err;
+
+	err = bpf_link_get_info_by_fd(fd, &link_info, &link_info_len);
+	if (!ASSERT_OK(err, "id_from_link_fd"))
+		return 0;
+
+	ASSERT_NEQ(link_info.id, 0, "link_info.id");
+	return link_info.id;
+}
+
+static inline __u32 ifindex_from_link_fd(int fd)
+{
+	struct bpf_link_info link_info = {};
+	__u32 link_info_len = sizeof(link_info);
+	int err;
+
+	err = bpf_link_get_info_by_fd(fd, &link_info, &link_info_len);
+	if (!ASSERT_OK(err, "id_from_link_fd"))
+		return 0;
+
+	return link_info.tcx.ifindex;
+}
+
+static inline void __assert_mprog_count(int target, int expected, bool miniq, int ifindex)
+{
+	__u32 count = 0, attach_flags = 0;
+	int err;
+
+	err = bpf_prog_query(ifindex, target, 0, &attach_flags,
+			     NULL, &count);
+	ASSERT_EQ(count, expected, "count");
+	if (!expected && !miniq)
+		ASSERT_EQ(err, -ENOENT, "prog_query");
+	else
+		ASSERT_EQ(err, 0, "prog_query");
+}
+
+static inline void assert_mprog_count(int target, int expected)
+{
+	__assert_mprog_count(target, expected, false, loopback);
+}
+
+static inline void assert_mprog_count_ifindex(int ifindex, int target, int expected)
+{
+	__assert_mprog_count(target, expected, false, ifindex);
+}
+
+#endif /* TC_HELPERS */
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
new file mode 100644
index 000000000000..c21a2940ea53
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -0,0 +1,2182 @@
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
+void serial_test_tc_opts_basic(void)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, id1, id2;
+	struct test_tc_link *skel;
+	__u32 prog_ids[2];
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	fd2 = bpf_program__fd(skel->progs.tc2);
+
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+
+	assert_mprog_count(BPF_TCX_INGRESS, 0);
+	assert_mprog_count(BPF_TCX_EGRESS, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc1, false, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	err = bpf_prog_attach_opts(fd1, loopback, BPF_TCX_INGRESS, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(BPF_TCX_INGRESS, 1);
+	assert_mprog_count(BPF_TCX_EGRESS, 0);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, BPF_TCX_INGRESS, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_in;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	err = bpf_prog_attach_opts(fd2, loopback, BPF_TCX_EGRESS, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_in;
+
+	assert_mprog_count(BPF_TCX_INGRESS, 1);
+	assert_mprog_count(BPF_TCX_EGRESS, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, BPF_TCX_EGRESS, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_eg;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+
+cleanup_eg:
+	err = bpf_prog_detach_opts(fd2, loopback, BPF_TCX_EGRESS, &optd);
+	ASSERT_OK(err, "prog_detach_eg");
+
+	assert_mprog_count(BPF_TCX_INGRESS, 1);
+	assert_mprog_count(BPF_TCX_EGRESS, 0);
+
+cleanup_in:
+	err = bpf_prog_detach_opts(fd1, loopback, BPF_TCX_INGRESS, &optd);
+	ASSERT_OK(err, "prog_detach_in");
+
+	assert_mprog_count(BPF_TCX_INGRESS, 0);
+	assert_mprog_count(BPF_TCX_EGRESS, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+static void test_tc_opts_before_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target;
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+	opta.relative_fd = fd2;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target2;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target3;
+
+	ASSERT_EQ(optq.count, 3, "count");
+	ASSERT_EQ(optq.revision, 4, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id2, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+	opta.relative_id = id1;
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target3;
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id4, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id3, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id2, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+
+cleanup_target4:
+	err = bpf_prog_detach_opts(fd4, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 3);
+
+cleanup_target3:
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 2);
+
+cleanup_target2:
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+cleanup_target:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_before(void)
+{
+	test_tc_opts_before_target(BPF_TCX_INGRESS);
+	test_tc_opts_before_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_after_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target;
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER;
+	opta.relative_fd = fd1;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target2;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target3;
+
+	ASSERT_EQ(optq.count, 3, "count");
+	ASSERT_EQ(optq.revision, 4, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id2, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER;
+	opta.relative_id = id2;
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target3;
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id2, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+
+cleanup_target4:
+	err = bpf_prog_detach_opts(fd4, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target3;
+
+	ASSERT_EQ(optq.count, 3, "count");
+	ASSERT_EQ(optq.revision, 6, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id2, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
+
+cleanup_target3:
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 7, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+cleanup_target2:
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 8, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+
+cleanup_target:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_after(void)
+{
+	test_tc_opts_after_target(BPF_TCX_INGRESS);
+	test_tc_opts_after_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_revision_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, id1, id2;
+	struct test_tc_link *skel;
+	__u32 prog_ids[3];
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	fd2 = bpf_program__fd(skel->progs.tc2);
+
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.expected_revision = 1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.expected_revision = 1;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, -ESTALE, "prog_attach"))
+		goto cleanup_target;
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.expected_revision = 2;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target;
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.expected_revision = 2;
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_EQ(err, -ESTALE, "prog_detach");
+	assert_mprog_count(target, 2);
+
+cleanup_target2:
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.expected_revision = 3;
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+cleanup_target:
+	LIBBPF_OPTS_CLEAR(optd);
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_revision(void)
+{
+	test_tc_opts_revision_target(BPF_TCX_INGRESS);
+	test_tc_opts_revision_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_chain_classic(int target, bool chain_tc_old)
+{
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = loopback);
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	bool hook_created = false, tc_attached = false;
+	__u32 fd1, fd2, fd3, id1, id2, id3;
+	struct test_tc_link *skel;
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	fd2 = bpf_program__fd(skel->progs.tc2);
+	fd3 = bpf_program__fd(skel->progs.tc3);
+
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(fd3);
+
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
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
+		tc_opts.prog_fd = fd3;
+		err = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(err, "bpf_tc_attach"))
+			goto cleanup;
+		tc_attached = true;
+	}
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_detach;
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
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	if (!ASSERT_OK(err, "prog_detach"))
+		goto cleanup_detach;
+
+	assert_mprog_count(target, 1);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
+
+cleanup_detach:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	if (!ASSERT_OK(err, "prog_detach"))
+		goto cleanup;
+
+	__assert_mprog_count(target, 0, chain_tc_old, loopback);
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
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_opts_chain_classic(void)
+{
+	test_tc_chain_classic(BPF_TCX_INGRESS, false);
+	test_tc_chain_classic(BPF_TCX_EGRESS, false);
+	test_tc_chain_classic(BPF_TCX_INGRESS, true);
+	test_tc_chain_classic(BPF_TCX_EGRESS, true);
+}
+
+static void test_tc_opts_replace_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, id1, id2, id3, detach_fd;
+	__u32 prog_ids[4], prog_flags[4];
+	struct test_tc_link *skel;
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	fd2 = bpf_program__fd(skel->progs.tc2);
+	fd3 = bpf_program__fd(skel->progs.tc3);
+
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(fd3);
+
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.expected_revision = 1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+	opta.relative_id = id1;
+	opta.expected_revision = 2;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target;
+
+	detach_fd = fd2;
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_attach_flags = prog_flags;
+	optq.prog_ids = prog_ids;
+
+	memset(prog_flags, 0, sizeof(prog_flags));
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_EQ(optq.prog_attach_flags[0], 0, "prog_flags[0]");
+	ASSERT_EQ(optq.prog_attach_flags[1], 0, "prog_flags[1]");
+	ASSERT_EQ(optq.prog_attach_flags[2], 0, "prog_flags[2]");
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
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = fd2;
+	opta.expected_revision = 3;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target2;
+
+	detach_fd = fd3;
+
+	assert_mprog_count(target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 4, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id3, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
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
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE | BPF_F_BEFORE;
+	opta.replace_prog_fd = fd3;
+	opta.relative_fd = fd1;
+	opta.expected_revision = 4;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target2;
+
+	detach_fd = fd2;
+
+	assert_mprog_count(target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = fd2;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE | BPF_F_AFTER;
+	opta.replace_prog_fd = fd2;
+	opta.relative_fd = fd1;
+	opta.expected_revision = 5;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	ASSERT_EQ(err, -EDOM, "prog_attach");
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE | BPF_F_AFTER | BPF_F_REPLACE;
+	opta.replace_prog_fd = fd2;
+	opta.relative_fd = fd1;
+	opta.expected_revision = 5;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	ASSERT_EQ(err, -EDOM, "prog_attach");
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+	optd.relative_id = id1;
+	optd.expected_revision = 5;
+
+cleanup_target2:
+	err = bpf_prog_detach_opts(detach_fd, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+cleanup_target:
+	LIBBPF_OPTS_CLEAR(optd);
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_replace(void)
+{
+	test_tc_opts_replace_target(BPF_TCX_INGRESS);
+	test_tc_opts_replace_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_invalid_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	__u32 fd1, fd2, id1, id2;
+	struct test_tc_link *skel;
+	int err;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	fd2 = bpf_program__fd(skel->progs.tc2);
+
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE | BPF_F_AFTER;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EDOM, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE | BPF_F_ID;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER | BPF_F_ID;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.relative_fd = fd2;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE | BPF_F_AFTER;
+	opta.relative_fd = fd2;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_ID;
+	opta.relative_id = id2;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+	opta.relative_fd = fd1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER;
+	opta.relative_fd = fd1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(opta);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+	opta.relative_fd = fd1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER;
+	opta.relative_fd = fd1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.relative_fd = fd1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach_x1");
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = fd1;
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+	assert_mprog_count(target, 1);
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_invalid(void)
+{
+	test_tc_opts_invalid_target(BPF_TCX_INGRESS);
+	test_tc_opts_invalid_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_prepend_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target;
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target2;
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_BEFORE;
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target3;
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id4, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id2, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id1, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+
+cleanup_target4:
+	err = bpf_prog_detach_opts(fd4, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 3);
+
+cleanup_target3:
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 2);
+
+cleanup_target2:
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+cleanup_target:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_prepend(void)
+{
+	test_tc_opts_prepend_target(BPF_TCX_INGRESS);
+	test_tc_opts_prepend_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_append_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER;
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target;
+
+	assert_mprog_count(target, 2);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target2;
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_AFTER;
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_target3;
+
+	assert_mprog_count(target, 4);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_target4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id3, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+
+cleanup_target4:
+	err = bpf_prog_detach_opts(fd4, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 3);
+
+cleanup_target3:
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 2);
+
+cleanup_target2:
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+cleanup_target:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_append(void)
+{
+	test_tc_opts_append_target(BPF_TCX_INGRESS);
+	test_tc_opts_append_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_dev_cleanup_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
+	int err, ifindex;
+
+	ASSERT_OK(system("ip link add dev tcx_opts1 type veth peer name tcx_opts2"), "add veth");
+	ifindex = if_nametoindex("tcx_opts1");
+	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+
+	err = bpf_prog_attach_opts(fd1, ifindex, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count_ifindex(ifindex, target, 1);
+
+	err = bpf_prog_attach_opts(fd2, ifindex, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	assert_mprog_count_ifindex(ifindex, target, 2);
+
+	err = bpf_prog_attach_opts(fd3, ifindex, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count_ifindex(ifindex, target, 3);
+
+	err = bpf_prog_attach_opts(fd4, ifindex, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count_ifindex(ifindex, target, 4);
+
+	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
+	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
+	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+	return;
+cleanup3:
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count_ifindex(ifindex, target, 2);
+cleanup2:
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count_ifindex(ifindex, target, 1);
+cleanup1:
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+cleanup:
+	test_tc_link__destroy(skel);
+
+	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
+	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
+	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+}
+
+void serial_test_tc_opts_dev_cleanup(void)
+{
+	test_tc_opts_dev_cleanup_target(BPF_TCX_INGRESS);
+	test_tc_opts_dev_cleanup_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_mixed_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 pid1, pid2, pid3, pid4, lid2, lid4;
+	__u32 prog_flags[4], link_flags[4];
+	__u32 prog_ids[4], link_ids[4];
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, detach_fd;
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
+	err = bpf_prog_attach_opts(bpf_program__fd(skel->progs.tc1),
+				   loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	detach_fd = bpf_program__fd(skel->progs.tc1);
+
+	assert_mprog_count(target, 1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup1;
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = bpf_program__fd(skel->progs.tc1);
+
+	err = bpf_prog_attach_opts(bpf_program__fd(skel->progs.tc2),
+				   loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = bpf_program__fd(skel->progs.tc2);
+
+	err = bpf_prog_attach_opts(bpf_program__fd(skel->progs.tc1),
+				   loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = bpf_program__fd(skel->progs.tc2);
+
+	err = bpf_prog_attach_opts(bpf_program__fd(skel->progs.tc3),
+				   loopback, target, &opta);
+	ASSERT_EQ(err, -EBUSY, "prog_attach");
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = bpf_program__fd(skel->progs.tc1);
+
+	err = bpf_prog_attach_opts(bpf_program__fd(skel->progs.tc3),
+				   loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	detach_fd = bpf_program__fd(skel->progs.tc3);
+
+	assert_mprog_count(target, 2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc4, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup1;
+	skel->links.tc4 = link;
+
+	lid4 = id_from_link_fd(bpf_link__fd(skel->links.tc4));
+
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(opta);
+	opta.flags = BPF_F_REPLACE;
+	opta.replace_prog_fd = bpf_program__fd(skel->progs.tc4);
+
+	err = bpf_prog_attach_opts(bpf_program__fd(skel->progs.tc2),
+				   loopback, target, &opta);
+	ASSERT_EQ(err, -EEXIST, "prog_attach");
+
+	optq.prog_ids = prog_ids;
+	optq.prog_attach_flags = prog_flags;
+	optq.link_ids = link_ids;
+	optq.link_attach_flags = link_flags;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(prog_flags, 0, sizeof(prog_flags));
+	memset(link_ids, 0, sizeof(link_ids));
+	memset(link_flags, 0, sizeof(link_flags));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup1;
+
+	ASSERT_EQ(optq.count, 3, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid3, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_attach_flags[0], 0, "prog_flags[0]");
+	ASSERT_EQ(optq.link_ids[0], 0, "link_ids[0]");
+	ASSERT_EQ(optq.link_attach_flags[0], 0, "link_flags[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid2, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_attach_flags[1], 0, "prog_flags[1]");
+	ASSERT_EQ(optq.link_ids[1], lid2, "link_ids[1]");
+	ASSERT_EQ(optq.link_attach_flags[1], 0, "link_flags[1]");
+	ASSERT_EQ(optq.prog_ids[2], pid4, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_attach_flags[2], 0, "prog_flags[2]");
+	ASSERT_EQ(optq.link_ids[2], lid4, "link_ids[2]");
+	ASSERT_EQ(optq.link_attach_flags[2], 0, "link_flags[2]");
+	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_attach_flags[3], 0, "prog_flags[3]");
+	ASSERT_EQ(optq.link_ids[3], 0, "link_ids[3]");
+	ASSERT_EQ(optq.link_attach_flags[3], 0, "link_flags[3]");
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+cleanup1:
+	err = bpf_prog_detach_opts(detach_fd, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 2);
+
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_opts_mixed(void)
+{
+	test_tc_opts_mixed_target(BPF_TCX_INGRESS);
+	test_tc_opts_mixed_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_demixed_target(int target)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, optl,
+		.ifindex = loopback,
+	);
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	__u32 pid1, pid2;
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
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(bpf_program__fd(skel->progs.tc1),
+				   loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup1;
+	skel->links.tc2 = link;
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_EQ(err, -EBUSY, "prog_detach");
+
+	assert_mprog_count(target, 2);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 1);
+	goto cleanup;
+
+cleanup1:
+	err = bpf_prog_detach_opts(bpf_program__fd(skel->progs.tc1),
+				   loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 2);
+
+cleanup:
+	test_tc_link__destroy(skel);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_opts_demixed(void)
+{
+	test_tc_opts_demixed_target(BPF_TCX_INGRESS);
+	test_tc_opts_demixed_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_detach_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(target, 2);
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(target, 3);
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(target, 4);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
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
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 3);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 3, "count");
+	ASSERT_EQ(optq.revision, 6, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id4, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 7, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 1);
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(target, 0);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_EQ(err, -ENOENT, "prog_detach");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_EQ(err, -ENOENT, "prog_detach");
+	goto cleanup;
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
+void serial_test_tc_opts_detach(void)
+{
+	test_tc_opts_detach_target(BPF_TCX_INGRESS);
+	test_tc_opts_detach_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_detach_before_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(target, 2);
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(target, 3);
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(target, 4);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
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
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+	optd.relative_fd = fd2;
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 3);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 3, "count");
+	ASSERT_EQ(optq.revision, 6, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id4, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+	optd.relative_fd = fd2;
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_EQ(err, -ENOENT, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+	optd.relative_fd = fd4;
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_EQ(err, -EDOM, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+	optd.relative_fd = fd1;
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_EQ(err, -ENOENT, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+	optd.relative_fd = fd3;
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 7, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id3, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id4, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+	optd.relative_fd = fd4;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 8, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id4, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_BEFORE;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 0);
+	goto cleanup;
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
+void serial_test_tc_opts_detach_before(void)
+{
+	test_tc_opts_detach_before_target(BPF_TCX_INGRESS);
+	test_tc_opts_detach_before_target(BPF_TCX_EGRESS);
+}
+
+static void test_tc_opts_detach_after_target(int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct test_tc_link *skel;
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
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id3, id4, "prog_ids_3_4");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	err = bpf_prog_attach_opts(fd2, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(target, 2);
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(target, 3);
+
+	err = bpf_prog_attach_opts(fd4, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(target, 4);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
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
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+	optd.relative_fd = fd1;
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 3);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 3, "count");
+	ASSERT_EQ(optq.revision, 6, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id4, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+	optd.relative_fd = fd1;
+
+	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
+	ASSERT_EQ(err, -ENOENT, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+	optd.relative_fd = fd4;
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_EQ(err, -EDOM, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+	optd.relative_fd = fd3;
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_EQ(err, -EDOM, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+	optd.relative_fd = fd1;
+
+	err = bpf_prog_detach_opts(fd1, loopback, target, &optd);
+	ASSERT_EQ(err, -EDOM, "prog_detach");
+	assert_mprog_count(target, 3);
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+	optd.relative_fd = fd1;
+
+	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 7, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id4, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+	optd.relative_fd = fd1;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(loopback, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 8, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+
+	LIBBPF_OPTS_CLEAR(optd);
+	optd.flags = BPF_F_AFTER;
+
+	err = bpf_prog_detach_opts(0, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+
+	assert_mprog_count(target, 0);
+	goto cleanup;
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
+void serial_test_tc_opts_detach_after(void)
+{
+	test_tc_opts_detach_after_target(BPF_TCX_INGRESS);
+	test_tc_opts_detach_after_target(BPF_TCX_EGRESS);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
new file mode 100644
index 000000000000..ed1fd0e9cee9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+bool seen_tc1;
+bool seen_tc2;
+bool seen_tc3;
+bool seen_tc4;
+
+SEC("tc/ingress")
+int tc1(struct __sk_buff *skb)
+{
+	seen_tc1 = true;
+	return TCX_NEXT;
+}
+
+SEC("tc/egress")
+int tc2(struct __sk_buff *skb)
+{
+	seen_tc2 = true;
+	return TCX_NEXT;
+}
+
+SEC("tc/egress")
+int tc3(struct __sk_buff *skb)
+{
+	seen_tc3 = true;
+	return TCX_NEXT;
+}
+
+SEC("tc/egress")
+int tc4(struct __sk_buff *skb)
+{
+	seen_tc4 = true;
+	return TCX_NEXT;
+}
-- 
2.34.1


