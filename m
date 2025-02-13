Return-Path: <bpf+bounces-51451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C239A34AEF
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29B11896456
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592DC227EB5;
	Thu, 13 Feb 2025 16:48:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299A28A2DB
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465308; cv=none; b=emwZzaUP9V8B3oqT7xVg/hbzz2XqRPV13qyd4GY8B3wnHAjQ9u690hQ0KQbeFqsdH9Tqr7h9N70J8eFscWNspgK+LMeytLL/yomRg3ioucUSz6+yMcsfW+WTRn5fIYAxnMXN3iRft0aDrpxl3gUVTetwLqbOtyf6DdIIZOyQwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465308; c=relaxed/simple;
	bh=Xysqaq9szONXRtVupRuxzfLjySfwAQ3drwc3UKjbI+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHEoJLAgJYya4iHrtoc/CSqRpbMqOu52CzzFen3FFbxeom9NbCnahVUIv6rx8ZTSYcGpmvXdnemD0e1gjPP7h1Ikt3IRFCo6O3vtHlSNxfJiwJLCMhpXvlCEPhtKJuusbnmm33mUAiR4VNeNNejiFjcqMoTwiVKCSoNBuLz6sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 20E0E88A003; Thu, 13 Feb 2025 08:48:17 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add selftests allowing cgroup prog pre-ordering
Date: Thu, 13 Feb 2025 08:48:17 -0800
Message-ID: <20250213164817.2669096-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250213164812.2668578-1-yonghong.song@linux.dev>
References: <20250213164812.2668578-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a few selftests with cgroup prog pre-ordering.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/cgroup_preorder.c          | 128 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_preorder.c     |  41 ++++++
 2 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_preorde=
r.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_preorder.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c b/t=
ools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
new file mode 100644
index 000000000000..d4d583872fa2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "cgroup_preorder.skel.h"
+
+static int run_getsockopt_test(int cg_parent, int cg_child, int sock_fd,=
 bool all_preorder)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opts);
+	enum bpf_attach_type prog_c_atype, prog_c2_atype, prog_p_atype, prog_p2=
_atype;
+	int prog_c_fd, prog_c2_fd, prog_p_fd, prog_p2_fd;
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
+	buf =3D 0x00;
+	err =3D setsockopt(sock_fd, SOL_IP, IP_TOS, &buf, 1);
+	if (!ASSERT_OK(err, "setsockopt"))
+		goto close_skel;
+
+	opts.flags =3D BPF_F_ALLOW_MULTI;
+	if (all_preorder)
+		opts.flags |=3D BPF_F_PREORDER;
+	prog =3D skel->progs.child;
+	prog_c_fd =3D bpf_program__fd(prog);
+	prog_c_atype =3D bpf_program__expected_attach_type(prog);
+	err =3D bpf_prog_attach_opts(prog_c_fd, cg_child, prog_c_atype, &opts);
+	if (!ASSERT_OK(err, "bpf_prog_attach_opts-child"))
+		goto close_skel;
+
+	opts.flags =3D BPF_F_ALLOW_MULTI | BPF_F_PREORDER;
+	prog =3D skel->progs.child_2;
+	prog_c2_fd =3D bpf_program__fd(prog);
+	prog_c2_atype =3D bpf_program__expected_attach_type(prog);
+	err =3D bpf_prog_attach_opts(prog_c2_fd, cg_child, prog_c2_atype, &opts=
);
+	if (!ASSERT_OK(err, "bpf_prog_attach_opts-child_2"))
+		goto detach_child;
+
+	optlen =3D 1;
+	err =3D getsockopt(sock_fd, SOL_IP, IP_TOS, &buf, &optlen);
+	if (!ASSERT_OK(err, "getsockopt"))
+		goto detach_child_2;
+
+	result =3D skel->bss->result;
+	if (all_preorder)
+		ASSERT_TRUE(result[0] =3D=3D 1 && result[1] =3D=3D 2, "child only");
+	else
+		ASSERT_TRUE(result[0] =3D=3D 2 && result[1] =3D=3D 1, "child only");
+
+	skel->bss->idx =3D 0;
+	memset(result, 0, 4);
+
+	opts.flags =3D BPF_F_ALLOW_MULTI;
+	if (all_preorder)
+		opts.flags |=3D BPF_F_PREORDER;
+	prog =3D skel->progs.parent;
+	prog_p_fd =3D bpf_program__fd(prog);
+	prog_p_atype =3D bpf_program__expected_attach_type(prog);
+	err =3D bpf_prog_attach_opts(prog_p_fd, cg_parent, prog_p_atype, &opts)=
;
+	if (!ASSERT_OK(err, "bpf_prog_attach_opts-parent"))
+		goto detach_child_2;
+
+	opts.flags =3D BPF_F_ALLOW_MULTI | BPF_F_PREORDER;
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
+	if (all_preorder)
+		ASSERT_TRUE(result[0] =3D=3D 3 && result[1] =3D=3D 4 && result[2] =3D=3D=
 1 && result[3] =3D=3D 2,
+			    "parent and child");
+	else
+		ASSERT_TRUE(result[0] =3D=3D 4 && result[1] =3D=3D 2 && result[2] =3D=3D=
 1 && result[3] =3D=3D 3,
+			    "parent and child");
+
+detach_parent_2:
+	ASSERT_OK(bpf_prog_detach2(prog_p2_fd, cg_parent, prog_p2_atype),
+		  "bpf_prog_detach2-parent_2");
+detach_parent:
+	ASSERT_OK(bpf_prog_detach2(prog_p_fd, cg_parent, prog_p_atype),
+		  "bpf_prog_detach2-parent");
+detach_child_2:
+	ASSERT_OK(bpf_prog_detach2(prog_c2_fd, cg_child, prog_c2_atype),
+		  "bpf_prog_detach2-child_2");
+detach_child:
+	ASSERT_OK(bpf_prog_detach2(prog_c_fd, cg_child, prog_c_atype),
+		  "bpf_prog_detach2-child");
+close_skel:
+	cgroup_preorder__destroy(skel);
+	return err;
+}
+
+void test_cgroup_preorder(void)
+{
+	int cg_parent =3D -1, cg_child =3D -1, sock_fd =3D -1;
+
+	cg_parent =3D test__join_cgroup("/parent");
+	if (!ASSERT_GE(cg_parent, 0, "join_cgroup /parent"))
+		goto out;
+
+	cg_child =3D test__join_cgroup("/parent/child");
+	if (!ASSERT_GE(cg_child, 0, "join_cgroup /parent/child"))
+		goto out;
+
+	sock_fd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_GE(sock_fd, 0, "socket"))
+		goto out;
+
+	ASSERT_OK(run_getsockopt_test(cg_parent, cg_child, sock_fd, false), "ge=
tsockopt_test_1");
+	ASSERT_OK(run_getsockopt_test(cg_parent, cg_child, sock_fd, true), "get=
sockopt_test_2");
+
+out:
+	close(sock_fd);
+	close(cg_child);
+	close(cg_parent);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_preorder.c b/tools/=
testing/selftests/bpf/progs/cgroup_preorder.c
new file mode 100644
index 000000000000..4ef6202baa0a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_preorder.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+unsigned int idx;
+__u8 result[4];
+
+SEC("cgroup/getsockopt")
+int child(struct bpf_sockopt *ctx)
+{
+	if (idx < 4)
+		result[idx++] =3D 1;
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int child_2(struct bpf_sockopt *ctx)
+{
+	if (idx < 4)
+		result[idx++] =3D 2;
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int parent(struct bpf_sockopt *ctx)
+{
+	if (idx < 4)
+		result[idx++] =3D 3;
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int parent_2(struct bpf_sockopt *ctx)
+{
+	if (idx < 4)
+		result[idx++] =3D 4;
+	return 1;
+}
--=20
2.43.5


