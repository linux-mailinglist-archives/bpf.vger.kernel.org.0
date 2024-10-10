Return-Path: <bpf+bounces-41605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA4998F04
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272671F25C24
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15B1C1ABE;
	Thu, 10 Oct 2024 17:56:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADAA19A292
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583018; cv=none; b=Og3CcLxXdf1yvfrwJEs7WsbXMbiEDaNIky+SXiO9aK8EugdU5GDuvA/g+uenWaFLQ6dNlfr4JYpmUJRwdz6AAD1Hi5mzFZHYLm36AOY5drDCyzKuIwg/OQv7OJxNCGK+jCBZBK0jztpGlRKURnSh9RWzaJziEcPvMnHtfFTeRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583018; c=relaxed/simple;
	bh=h7oi8MGl3FGBz84eAR+pbpwBbw8O7S+l7TTBl69H8/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJtsJ3TLUMhsEYqw+mR6Vf1Zhwupgfq7zbtz+yUVswblm6r72RXP3SxAtjI2xrE0XEQCC76bijWOGHN34zFXgfMNskkGwB2x4DP3OXxJKFLhBoj1mpg1y1AdXNFe/bVwYkLurmwTxcqRaRbOsBucqDej2/NPY4vBrl8UCGyo2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6A1F59F27C79; Thu, 10 Oct 2024 10:56:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 10/10] selftests/bpf: Add tests for bpf_prog_call()
Date: Thu, 10 Oct 2024 10:56:44 -0700
Message-ID: <20241010175644.1900546-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010175552.1895980-1-yonghong.song@linux.dev>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two subtests for nested bpf_prog_call(). One is recursion in main pro=
g,
and the other is recursion in callback func.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/prog_call.c      | 78 ++++++++++++++++
 tools/testing/selftests/bpf/progs/prog_call.c | 92 +++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_call.c
 create mode 100644 tools/testing/selftests/bpf/progs/prog_call.c

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_call.c b/tools/t=
esting/selftests/bpf/prog_tests/prog_call.c
new file mode 100644
index 000000000000..573c67c9af12
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_call.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "prog_call.skel.h"
+
+static void test_nest_prog_call(int prog_index)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+	);
+	int err, idx =3D 0, prog_fd, map_fd;
+	struct prog_call *skel;
+	struct bpf_program *prog;
+
+	skel =3D prog_call__open();
+	if (!ASSERT_OK_PTR(skel, "prog_call__open"))
+		return;
+
+	switch (prog_index) {
+	case 0:
+		prog =3D skel->progs.entry_no_subprog;
+		break;
+	case 1:
+		prog =3D skel->progs.entry_subprog;
+		break;
+	case 2:
+		prog =3D skel->progs.entry_callback;
+		break;
+	}
+
+	bpf_program__set_autoload(prog, true);
+
+	err =3D prog_call__load(skel);
+	if (!ASSERT_OK(err, "prog_call__load"))
+		return;
+
+	map_fd =3D bpf_map__fd(skel->maps.jmp_table);
+	prog_fd =3D bpf_program__fd(prog);
+	/* maximum recursion level 4 */
+	err =3D bpf_map_update_elem(map_fd, &idx, &prog_fd, 0);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(skel->bss->vali, 4, "i");
+	ASSERT_EQ(skel->bss->valj, 6, "j");
+out:
+	prog_call__destroy(skel);
+}
+
+static void test_prog_call_with_tailcall(void)
+{
+	struct prog_call *skel;
+	int err;
+
+	skel =3D prog_call__open();
+	if (!ASSERT_OK_PTR(skel, "prog_call__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.entry_tail_call, true);
+	err =3D prog_call__load(skel);
+	if (!ASSERT_ERR(err, "prog_call__load"))
+		prog_call__destroy(skel);
+}
+
+void test_prog_call(void)
+{
+	if (test__start_subtest("single_main_prog"))
+		test_nest_prog_call(0);
+	if (test__start_subtest("sub_prog"))
+		test_nest_prog_call(1);
+	if (test__start_subtest("callback_fn"))
+		test_nest_prog_call(2);
+	if (test__start_subtest("with_tailcall"))
+		test_prog_call_with_tailcall();
+}
diff --git a/tools/testing/selftests/bpf/progs/prog_call.c b/tools/testin=
g/selftests/bpf/progs/prog_call.c
new file mode 100644
index 000000000000..c494cfcf653b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/prog_call.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 3);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+struct callback_ctx {
+	struct __sk_buff *skb;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} arraymap SEC(".maps");
+
+int vali, valj;
+
+int glb;
+__noinline static void subprog2(volatile int *a)
+{
+	glb =3D a[20] + a[10];
+}
+
+__noinline static void subprog1(struct __sk_buff *skb)
+{
+	volatile int a[100] =3D {};
+
+	a[10] =3D vali;
+	subprog2(a);
+	vali++;
+	bpf_prog_call(skb, (struct bpf_map *)&jmp_table, 0);
+	valj +=3D a[10];
+}
+
+SEC("?tc")
+int entry_no_subprog(struct __sk_buff *skb)
+{
+	volatile int a[100] =3D {};
+
+	a[10] =3D vali;
+	subprog2(a);
+	vali++;
+	bpf_prog_call(skb, (struct bpf_map *)&jmp_table, 0);
+	valj +=3D a[10];
+	return 0;
+}
+
+SEC("?tc")
+int entry_subprog(struct __sk_buff *skb)
+{
+	subprog1(skb);
+	return 0;
+}
+
+static __u64
+check_array_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+		 struct callback_ctx *data)
+{
+	subprog1(data->skb);
+	return 0;
+}
+
+SEC("?tc")
+int entry_callback(struct __sk_buff *skb)
+{
+	struct callback_ctx data;
+
+	data.skb =3D skb;
+	bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
+	return 0;
+}
+
+SEC("?tc")
+int entry_tail_call(struct __sk_buff *skb)
+{
+	struct callback_ctx data;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+
+	data.skb =3D skb;
+	bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
+	return 0;
+}
+
+char __license[] SEC("license") =3D "GPL";
--=20
2.43.5


