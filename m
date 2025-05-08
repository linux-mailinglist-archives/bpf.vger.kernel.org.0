Return-Path: <bpf+bounces-57810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8653AB05FF
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE7C9E5386
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEC4227BA9;
	Thu,  8 May 2025 22:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C62229B27
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743747; cv=none; b=pw8j9GDChOwFdh1Z6PcxGMkuK26EIONjBMm4gnUOTQHOGFGL/Dzc1gxBWmNdoIezxbhJithW2En0ubDp2iYinFLLX/1oXFFpieXaxfjZS0cdq9GT/goaXOC2U7xNoHG3NpdGDSmxWN3Ss3kPfzYz7CyhKPislMtjnjClmX5idik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743747; c=relaxed/simple;
	bh=sKSf6WUjwIqMAxlzggcJLMqsC4MECwBj4KXvz+otc2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZLLRwFADZqZfJu8+gLxFmqApx3B0yaHJf2726GUh/L4xik5DdYswLaG0VBAIULdkCZejAaknNCTY8duv9Ine0CMwTkNoPcUw/ADrchNtSDgIMlryIOhgFm2yE6+bs3K7/N7pBFmsH+s1/jw63atzhWbt2xgFqPg7irVh7o94yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8D1017223478; Thu,  8 May 2025 15:35:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add two selftests for mprog API based cgroup progs
Date: Thu,  8 May 2025 15:35:44 -0700
Message-ID: <20250508223544.489804-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508223524.487875-1-yonghong.song@linux.dev>
References: <20250508223524.487875-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two tests are added:
  - cgroup_mprog_opts, which mimics tc_opts.c ([1]). Both prog and link
    attach are tested. Some negative tests are also included.
  - cgroup_mprog_ordering, which actually runs the program with some mpro=
g
    API flags.

  [1] https://github.com/torvalds/linux/blob/master/tools/testing/selftes=
ts/bpf/prog_tests/tc_opts.c

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 752 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_mprog_ordering.c    |  77 ++
 .../selftests/bpf/progs/cgroup_mprog.c        |  30 +
 3 files changed, 859 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
pts.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
rdering.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_mprog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c b=
/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
new file mode 100644
index 000000000000..a8374ea2267b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
@@ -0,0 +1,752 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "cgroup_mprog.skel.h"
+
+static __u32 id_from_prog_fd(int fd)
+{
+	struct bpf_prog_info prog_info =3D {};
+	__u32 prog_info_len =3D sizeof(prog_info);
+	int err;
+
+	err =3D bpf_obj_get_info_by_fd(fd, &prog_info, &prog_info_len);
+	if (!ASSERT_OK(err, "id_from_prog_fd"))
+		return 0;
+
+	ASSERT_NEQ(prog_info.id, 0, "prog_info.id");
+	return prog_info.id;
+}
+
+static void assert_mprog_count(int cg, int atype, int expected)
+{
+	__u32 count =3D 0, attach_flags =3D 0;
+	int err;
+
+	err =3D bpf_prog_query(cg, atype, 0, &attach_flags,
+			     NULL, &count);
+	ASSERT_EQ(count, expected, "count");
+	ASSERT_EQ(err, 0, "prog_query");
+}
+
+static void test_prog_attach_detach(int atype)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct cgroup_mprog *skel;
+	__u32 prog_ids[10];
+	int cg, err;
+
+	cg =3D test__join_cgroup("/prog_attach_detach");
+	if (!ASSERT_GE(cg, 0, "join_cgroup /prog_attach_detach"))
+		return;
+
+	skel =3D cgroup_mprog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 =3D bpf_program__fd(skel->progs.getsockopt_1);
+	fd2 =3D bpf_program__fd(skel->progs.getsockopt_2);
+	fd3 =3D bpf_program__fd(skel->progs.getsockopt_3);
+	fd4 =3D bpf_program__fd(skel->progs.getsockopt_4);
+
+	id1 =3D id_from_prog_fd(fd1);
+	id2 =3D id_from_prog_fd(fd2);
+	id3 =3D id_from_prog_fd(fd3);
+	id4 =3D id_from_prog_fd(fd4);
+
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI,
+		.expected_revision =3D 1,
+	);
+
+	/* ordering: [fd1] */
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(cg, atype, 1);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_BEFORE,
+		.expected_revision =3D 2,
+	);
+
+	/* ordering: [fd2, fd1] */
+	err =3D bpf_prog_attach_opts(fd2, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(cg, atype, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_AFTER,
+		.relative_fd =3D fd2,
+		.expected_revision =3D 3,
+	);
+
+	/* ordering: [fd2, fd3, fd1] */
+	err =3D bpf_prog_attach_opts(fd3, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(cg, atype, 3);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI,
+		.expected_revision =3D 4,
+	);
+
+	/* ordering: [fd2, fd3, fd1, fd4] */
+	err =3D bpf_prog_attach_opts(fd4, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(cg, atype, 4);
+
+	/* retrieve optq.prog_cnt */
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	/* optq.prog_cnt will be used in below query */
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.prog_ids =3D prog_ids;
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id1, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids, NULL, "link_ids");
+
+cleanup4:
+	optd.expected_revision =3D 5;
+	err =3D bpf_prog_detach_opts(fd4, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 3);
+
+cleanup3:
+	LIBBPF_OPTS_RESET(optd);
+	err =3D bpf_prog_detach_opts(fd3, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 2);
+
+	/* Check revision after two detach operations */
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	ASSERT_OK(err, "prog_query");
+	ASSERT_EQ(optq.revision, 7, "revision");
+
+cleanup2:
+	err =3D bpf_prog_detach_opts(fd2, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 1);
+
+cleanup1:
+	err =3D bpf_prog_detach_opts(fd1, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 0);
+
+cleanup:
+	cgroup_mprog__destroy(skel);
+	close(cg);
+}
+
+static void test_link_attach_detach(int atype)
+{
+	LIBBPF_OPTS(bpf_cgroup_opts, opta);
+	LIBBPF_OPTS(bpf_cgroup_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	struct bpf_link *link1, *link2, *link3, *link4;
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct cgroup_mprog *skel;
+	__u32 prog_ids[10];
+	int cg, err;
+
+	cg =3D test__join_cgroup("/link_attach_detach");
+	if (!ASSERT_GE(cg, 0, "join_cgroup /link_attach_detach"))
+		return;
+
+	skel =3D cgroup_mprog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 =3D bpf_program__fd(skel->progs.getsockopt_1);
+	fd2 =3D bpf_program__fd(skel->progs.getsockopt_2);
+	fd3 =3D bpf_program__fd(skel->progs.getsockopt_3);
+	fd4 =3D bpf_program__fd(skel->progs.getsockopt_4);
+
+	id1 =3D id_from_prog_fd(fd1);
+	id2 =3D id_from_prog_fd(fd2);
+	id3 =3D id_from_prog_fd(fd3);
+	id4 =3D id_from_prog_fd(fd4);
+
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision =3D 1,
+	);
+
+	/* ordering: [fd1] */
+	link1 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_1, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link1, "link_attach"))
+		goto cleanup;
+
+	assert_mprog_count(cg, atype, 1);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_BEFORE,
+		.expected_revision =3D 2,
+	);
+
+	/* ordering: [fd2, fd1] */
+	link2 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_2, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link2, "link_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(cg, atype, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_AFTER,
+		.relative_fd =3D fd2,
+		.expected_revision =3D 3,
+	);
+
+	/* ordering: [fd2, fd3, fd1] */
+	link3 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_3, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link3, "link_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(cg, atype, 3);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision =3D 4,
+	);
+
+	/* ordering: [fd2, fd3, fd1, fd4] */
+	link4 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_4, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link4, "link_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(cg, atype, 4);
+
+	/* retrieve optq.prog_cnt */
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	/* optq.prog_cnt will be used in below query */
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.prog_ids =3D prog_ids;
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id1, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids, NULL, "link_ids");
+
+cleanup4:
+	bpf_link__destroy(link4);
+	assert_mprog_count(cg, atype, 3);
+
+cleanup3:
+	bpf_link__destroy(link3);
+	assert_mprog_count(cg, atype, 2);
+
+	/* Check revision after two detach operations */
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	ASSERT_OK(err, "prog_query");
+	ASSERT_EQ(optq.revision, 7, "revision");
+
+cleanup2:
+	bpf_link__destroy(link2);
+	assert_mprog_count(cg, atype, 1);
+
+cleanup1:
+	bpf_link__destroy(link1);
+	assert_mprog_count(cg, atype, 0);
+
+cleanup:
+	cgroup_mprog__destroy(skel);
+	close(cg);
+}
+
+static void test_mix_attach_detach(int atype)
+{
+	LIBBPF_OPTS(bpf_cgroup_opts, lopta);
+	LIBBPF_OPTS(bpf_cgroup_opts, loptd);
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	struct bpf_link *link2, *link4;
+	struct cgroup_mprog *skel;
+	__u32 prog_ids[10];
+	int cg, err;
+
+	cg =3D test__join_cgroup("/mix_attach_detach");
+	if (!ASSERT_GE(cg, 0, "join_cgroup /mix_attach_detach"))
+		return;
+
+	skel =3D cgroup_mprog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 =3D bpf_program__fd(skel->progs.getsockopt_1);
+	fd2 =3D bpf_program__fd(skel->progs.getsockopt_2);
+	fd3 =3D bpf_program__fd(skel->progs.getsockopt_3);
+	fd4 =3D bpf_program__fd(skel->progs.getsockopt_4);
+
+	id1 =3D id_from_prog_fd(fd1);
+	id2 =3D id_from_prog_fd(fd2);
+	id3 =3D id_from_prog_fd(fd3);
+	id4 =3D id_from_prog_fd(fd4);
+
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI,
+		.expected_revision =3D 1,
+	);
+
+	/* ordering: [fd1] */
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(cg, atype, 1);
+
+	LIBBPF_OPTS_RESET(lopta,
+		.flags =3D BPF_F_BEFORE,
+		.expected_revision =3D 2,
+	);
+
+	/* ordering: [fd2, fd1] */
+	link2 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_2, cg,=
 &lopta);
+	if (!ASSERT_OK_PTR(link2, "link_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(cg, atype, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_AFTER,
+		.relative_fd =3D fd2,
+		.expected_revision =3D 3,
+	);
+
+	/* ordering: [fd2, fd3, fd1] */
+	err =3D bpf_prog_attach_opts(fd3, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(cg, atype, 3);
+
+	LIBBPF_OPTS_RESET(lopta,
+		.expected_revision =3D 4,
+	);
+
+	/* ordering: [fd2, fd3, fd1, fd4] */
+	link4 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_4, cg,=
 &lopta);
+	if (!ASSERT_OK_PTR(link4, "link_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(cg, atype, 4);
+
+	/* retrieve optq.prog_cnt */
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	/* optq.prog_cnt will be used in below query */
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.prog_ids =3D prog_ids;
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	ASSERT_EQ(optq.revision, 5, "revision");
+	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], id1, "prog_ids[2]");
+	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
+	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
+	ASSERT_EQ(optq.link_ids, NULL, "link_ids");
+
+cleanup4:
+	bpf_link__destroy(link4);
+	assert_mprog_count(cg, atype, 3);
+
+cleanup3:
+	err =3D bpf_prog_detach_opts(fd3, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 2);
+
+	/* Check revision after two detach operations */
+	err =3D bpf_prog_query_opts(cg, atype, &optq);
+	ASSERT_OK(err, "prog_query");
+	ASSERT_EQ(optq.revision, 7, "revision");
+
+cleanup2:
+	bpf_link__destroy(link2);
+	assert_mprog_count(cg, atype, 1);
+
+cleanup1:
+	err =3D bpf_prog_detach_opts(fd1, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 0);
+
+cleanup:
+	cgroup_mprog__destroy(skel);
+	close(cg);
+}
+
+static void test_preorder_prog_attach_detach(int atype)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	__u32 fd1, fd2, fd3, fd4;
+	struct cgroup_mprog *skel;
+	int cg, err;
+
+	cg =3D test__join_cgroup("/preorder_prog_attach_detach");
+	if (!ASSERT_GE(cg, 0, "join_cgroup /preorder_prog_attach_detach"))
+		return;
+
+	skel =3D cgroup_mprog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 =3D bpf_program__fd(skel->progs.getsockopt_1);
+	fd2 =3D bpf_program__fd(skel->progs.getsockopt_2);
+	fd3 =3D bpf_program__fd(skel->progs.getsockopt_3);
+	fd4 =3D bpf_program__fd(skel->progs.getsockopt_4);
+
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI,
+		.expected_revision =3D 1,
+	);
+
+	/* ordering: [fd1] */
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count(cg, atype, 1);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_PREORDER,
+		.expected_revision =3D 2,
+	);
+
+	/* ordering: [fd1, fd2] */
+	err =3D bpf_prog_attach_opts(fd2, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(cg, atype, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_AFTER,
+		.relative_fd =3D fd2,
+		.expected_revision =3D 3,
+	);
+
+	err =3D bpf_prog_attach_opts(fd3, cg, atype, &opta);
+	if (!ASSERT_EQ(err, -EINVAL, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(cg, atype, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_AFTER | BPF_F_PREORDER,
+		.relative_fd =3D fd2,
+		.expected_revision =3D 3,
+	);
+
+	/* ordering: [fd1, fd2, fd3] */
+	err =3D bpf_prog_attach_opts(fd3, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(cg, atype, 3);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI,
+		.expected_revision =3D 4,
+	);
+
+	/* ordering: [fd2, fd3, fd1, fd4] */
+	err =3D bpf_prog_attach_opts(fd4, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(cg, atype, 4);
+
+	err =3D bpf_prog_detach_opts(fd4, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 3);
+
+cleanup3:
+	err =3D bpf_prog_detach_opts(fd3, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 2);
+
+cleanup2:
+	err =3D bpf_prog_detach_opts(fd2, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 1);
+
+cleanup1:
+	err =3D bpf_prog_detach_opts(fd1, cg, atype, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count(cg, atype, 0);
+
+cleanup:
+	cgroup_mprog__destroy(skel);
+	close(cg);
+}
+
+static void test_preorder_link_attach_detach(int atype)
+{
+	LIBBPF_OPTS(bpf_cgroup_opts, opta);
+	struct bpf_link *link1, *link2, *link3, *link4;
+	struct cgroup_mprog *skel;
+	__u32 fd2;
+	int cg;
+
+	cg =3D test__join_cgroup("/preorder_link_attach_detach");
+	if (!ASSERT_GE(cg, 0, "join_cgroup /preorder_link_attach_detach"))
+		return;
+
+	skel =3D cgroup_mprog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd2 =3D bpf_program__fd(skel->progs.getsockopt_2);
+
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision =3D 1,
+	);
+
+	/* ordering: [fd1] */
+	link1 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_1, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link1, "link_attach"))
+		goto cleanup;
+
+	assert_mprog_count(cg, atype, 1);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_PREORDER,
+		.expected_revision =3D 2,
+	);
+
+	/* ordering: [fd1, fd2] */
+	link2 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_2, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link2, "link_attach"))
+		goto cleanup1;
+
+	assert_mprog_count(cg, atype, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_AFTER,
+		.relative_fd =3D fd2,
+		.expected_revision =3D 3,
+	);
+
+	link3 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_3, cg,=
 &opta);
+	if (!ASSERT_ERR_PTR(link3, "link_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(cg, atype, 2);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_AFTER | BPF_F_PREORDER,
+		.relative_fd =3D fd2,
+		.expected_revision =3D 3,
+	);
+
+	/* ordering: [fd1, fd2, fd3] */
+	link3 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_3, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link3, "link_attach"))
+		goto cleanup2;
+
+	assert_mprog_count(cg, atype, 3);
+
+	LIBBPF_OPTS_RESET(opta,
+		.expected_revision =3D 4,
+	);
+
+	/* ordering: [fd2, fd3, fd1, fd4] */
+	link4 =3D bpf_program__attach_cgroup_opts(skel->progs.getsockopt_4, cg,=
 &opta);
+	if (!ASSERT_OK_PTR(link4, "prog_attach"))
+		goto cleanup3;
+
+	assert_mprog_count(cg, atype, 4);
+
+	bpf_link__destroy(link4);
+	assert_mprog_count(cg, atype, 3);
+
+cleanup3:
+	bpf_link__destroy(link3);
+	assert_mprog_count(cg, atype, 2);
+
+cleanup2:
+	bpf_link__destroy(link2);
+	assert_mprog_count(cg, atype, 1);
+
+cleanup1:
+	bpf_link__destroy(link1);
+	assert_mprog_count(cg, atype, 0);
+
+cleanup:
+	cgroup_mprog__destroy(skel);
+	close(cg);
+}
+
+static void test_invalid_attach_detach(int atype)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	__u32 fd1, fd2, id2;
+	struct cgroup_mprog *skel;
+	int cg, err;
+
+	cg =3D test__join_cgroup("/invalid_attach_detach");
+	if (!ASSERT_GE(cg, 0, "join_cgroup /invalid_attach_detach"))
+		return;
+
+	skel =3D cgroup_mprog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 =3D bpf_program__fd(skel->progs.getsockopt_1);
+	fd2 =3D bpf_program__fd(skel->progs.getsockopt_2);
+
+	id2 =3D id_from_prog_fd(fd2);
+
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_BEFORE | BPF_F_AFTER,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach");
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_BEFORE | BPF_F_ID,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_AFTER | BPF_F_ID,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_BEFORE | BPF_F_AFTER,
+		.relative_id =3D id2,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach");
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_ID,
+		.relative_id =3D id2,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach");
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_BEFORE,
+		.relative_fd =3D fd1,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_AFTER,
+		.relative_fd =3D fd1,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -ENOENT, "prog_attach");
+	assert_mprog_count(cg, atype, 0);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+	assert_mprog_count(cg, atype, 1);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_AFTER,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach");
+	assert_mprog_count(cg, atype, 1);
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags =3D BPF_F_ALLOW_MULTI | BPF_F_REPLACE | BPF_F_AFTER,
+		.replace_prog_fd =3D fd1,
+	);
+
+	err =3D bpf_prog_attach_opts(fd1, cg, atype, &opta);
+	ASSERT_EQ(err, -EINVAL, "prog_attach");
+	assert_mprog_count(cg, atype, 1);
+cleanup:
+	cgroup_mprog__destroy(skel);
+	close(cg);
+}
+
+void test_cgroup_mprog_opts(void)
+{
+	if (test__start_subtest("prog_attach_detach"))
+		test_prog_attach_detach(BPF_CGROUP_GETSOCKOPT);
+	if (test__start_subtest("link_attach_detach"))
+		test_link_attach_detach(BPF_CGROUP_GETSOCKOPT);
+	if (test__start_subtest("mix_attach_detach"))
+		test_mix_attach_detach(BPF_CGROUP_GETSOCKOPT);
+	if (test__start_subtest("preorder_prog_attach_detach"))
+		test_preorder_prog_attach_detach(BPF_CGROUP_GETSOCKOPT);
+	if (test__start_subtest("preorder_link_attach_detach"))
+		test_preorder_link_attach_detach(BPF_CGROUP_GETSOCKOPT);
+	if (test__start_subtest("invalid_attach_detach"))
+		test_invalid_attach_detach(BPF_CGROUP_GETSOCKOPT);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering=
.c b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering.c
new file mode 100644
index 000000000000..4a4e9710b474
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "cgroup_preorder.skel.h"
+
+static int run_getsockopt_test(int cg_parent, int sock_fd, bool has_rela=
tive_fd)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opts);
+	enum bpf_attach_type prog_p_atype, prog_p2_atype;
+	int prog_p_fd, prog_p2_fd;
+	struct cgroup_preorder *skel =3D NULL;
+	struct bpf_program *prog;
+	__u8 *result, buf;
+	socklen_t optlen;
+	int err =3D 0;
+
+	skel =3D cgroup_preorder__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_preorder__open_and_load"))
+		return 0;
+
+	LIBBPF_OPTS_RESET(opts);
+	opts.flags =3D BPF_F_ALLOW_MULTI;
+	prog =3D skel->progs.parent;
+	prog_p_fd =3D bpf_program__fd(prog);
+	prog_p_atype =3D bpf_program__expected_attach_type(prog);
+	err =3D bpf_prog_attach_opts(prog_p_fd, cg_parent, prog_p_atype, &opts)=
;
+	if (!ASSERT_OK(err, "bpf_prog_attach_opts-parent"))
+		goto close_skel;
+
+	opts.flags =3D BPF_F_ALLOW_MULTI | BPF_F_BEFORE;
+	if (has_relative_fd)
+		opts.relative_fd =3D prog_p_fd;
+	prog =3D skel->progs.parent_2;
+	prog_p2_fd =3D bpf_program__fd(prog);
+	prog_p2_atype =3D bpf_program__expected_attach_type(prog);
+	err =3D bpf_prog_attach_opts(prog_p2_fd, cg_parent, prog_p2_atype, &opt=
s);
+	if (!ASSERT_OK(err, "bpf_prog_attach_opts-parent_2"))
+		goto detach_parent;
+
+	err =3D getsockopt(sock_fd, SOL_IP, IP_TOS, &buf, &optlen);
+	if (!ASSERT_OK(err, "getsockopt"))
+		goto detach_parent_2;
+
+	result =3D skel->bss->result;
+	ASSERT_TRUE(result[0] =3D=3D 4 && result[1] =3D=3D 3, "result values");
+
+detach_parent_2:
+	ASSERT_OK(bpf_prog_detach2(prog_p2_fd, cg_parent, prog_p2_atype),
+		  "bpf_prog_detach2-parent_2");
+detach_parent:
+	ASSERT_OK(bpf_prog_detach2(prog_p_fd, cg_parent, prog_p_atype),
+		  "bpf_prog_detach2-parent");
+close_skel:
+	cgroup_preorder__destroy(skel);
+	return err;
+}
+
+void test_cgroup_mprog_ordering(void)
+{
+	int cg_parent =3D -1, sock_fd =3D -1;
+
+	cg_parent =3D test__join_cgroup("/parent");
+	if (!ASSERT_GE(cg_parent, 0, "join_cgroup /parent"))
+		goto out;
+
+	sock_fd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_GE(sock_fd, 0, "socket"))
+		goto out;
+
+	ASSERT_OK(run_getsockopt_test(cg_parent, sock_fd, false), "getsockopt_t=
est_1");
+	ASSERT_OK(run_getsockopt_test(cg_parent, sock_fd, true), "getsockopt_te=
st_2");
+
+out:
+	close(sock_fd);
+	close(cg_parent);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_mprog.c b/tools/tes=
ting/selftests/bpf/progs/cgroup_mprog.c
new file mode 100644
index 000000000000..6a0ea02c4de2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_mprog.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("cgroup/getsockopt")
+int getsockopt_1(struct bpf_sockopt *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int getsockopt_2(struct bpf_sockopt *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int getsockopt_3(struct bpf_sockopt *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int getsockopt_4(struct bpf_sockopt *ctx)
+{
+	return 1;
+}
--=20
2.47.1


