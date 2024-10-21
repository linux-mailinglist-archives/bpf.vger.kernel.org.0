Return-Path: <bpf+bounces-42616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413D9A6840
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33FE1F26C12
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D991FB3D6;
	Mon, 21 Oct 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNHdQ0fG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BCB1FB3C1;
	Mon, 21 Oct 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513333; cv=none; b=PNi86J5KYEzQbiorVN5m+4aUNp53vM1Hr+TmYFikf8+kdi7hJCVt9SMnaIRc3vaUQ/4SyiijzYcyVZDwF/RRlQYIb73cqKPmpUH4ABl4nUQGBogpFCTxMIvGmvmt/Bx/7dhWZzkr4Im1LpUsjN1REbjShKhL7odTOHz2CG+Hclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513333; c=relaxed/simple;
	bh=c8L0VpdriMONmtoRlW2frKvu4VJmvuZBqyXENZuKGNQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpVt9umXZX2F0CYrMC/UDoThHzE4xxkGeDXMFy74vXewIoyclmXt2r/IaRLwAnV0iq/lsOIUwMKY3we3QoICpmzULU6j0lNU6esTNyASfT8sP5GzKbX8cSHtMbVMErEjDp+f3oZX0s8epTcYH7SYRGqi+9svcO8pXP5u+0xv/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNHdQ0fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17C7C4CEE4;
	Mon, 21 Oct 2024 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513332;
	bh=c8L0VpdriMONmtoRlW2frKvu4VJmvuZBqyXENZuKGNQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nNHdQ0fGTbVmymWgcizfMY7q1QsD0sF12JAOVPKoGuq6hX7e57v+sBc+UxNwunBAD
	 dOXDgrU6SBfbvt5PW04qoQZXeoUInUq4ie9jpi7kfNjtNpav/7OWrdBFkqHaePe7kn
	 Nbs7T3X/2WICOqFOfoLYjSEQ04f0l9ddY+57yUH8KcTvy9qzRq4AiErk61F0fb+L58
	 PetUVz/TWk2V6OK4mz3PkxqPmnsnV5hKT9rFKlXGXZCh0yk7fR24OmruakqRHMPvh/
	 Kpa4SlIRe4B/NS/a3w6LA3vHUituYKv+HeZOsUJD6oEO2rSZaspwNbro7rKjWLwjep
	 2x/TxXL1Nn5rA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Helge Deller <deller@gmx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add a selftest for bpf_csum_diff()
Date: Mon, 21 Oct 2024 12:21:12 +0000
Message-Id: <20241021122112.101513-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241021122112.101513-1-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest for the bpf_csum_diff() helper. This selftests runs the
helper in all three configurations(push, pull, and diff) and verifies
its output. The correct results have been computed by hand and by the
helper's older implementation.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/test_csum_diff.c | 408 ++++++++++++++++++
 .../selftests/bpf/progs/csum_diff_test.c      |  42 ++
 2 files changed, 450 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_csum_diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_csum_diff.c b/tools/testing/selftests/bpf/prog_tests/test_csum_diff.c
new file mode 100644
index 0000000000000..107b20d43e839
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_csum_diff.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates */
+#include <test_progs.h>
+#include "csum_diff_test.skel.h"
+
+#define BUFF_SZ 512
+
+struct testcase {
+	unsigned long long to_buff[BUFF_SZ / 8];
+	unsigned int to_buff_len;
+	unsigned long long from_buff[BUFF_SZ / 8];
+	unsigned int from_buff_len;
+	unsigned short seed;
+	unsigned short result;
+};
+
+#define NUM_PUSH_TESTS 4
+
+struct testcase push_tests[NUM_PUSH_TESTS] = {
+	{
+		.to_buff = {
+			0xdeadbeefdeadbeef,
+		},
+		.to_buff_len = 8,
+		.from_buff = {},
+		.from_buff_len = 0,
+		.seed = 0,
+		.result = 0x3b3b
+	},
+	{
+		.to_buff = {
+			0xdeadbeefdeadbeef,
+			0xbeefdeadbeefdead,
+		},
+		.to_buff_len = 16,
+		.from_buff = {},
+		.from_buff_len = 0,
+		.seed = 0x1234,
+		.result = 0x88aa
+	},
+	{
+		.to_buff = {
+			0xdeadbeefdeadbeef,
+			0xbeefdeadbeefdead,
+		},
+		.to_buff_len = 15,
+		.from_buff = {},
+		.from_buff_len = 0,
+		.seed = 0x1234,
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		.result = 0xcaa9
+#else
+		.result = 0x87fd
+#endif
+	},
+	{
+		.to_buff = {
+			0x327b23c66b8b4567,
+			0x66334873643c9869,
+			0x19495cff74b0dc51,
+			0x625558ec2ae8944a,
+			0x46e87ccd238e1f29,
+			0x507ed7ab3d1b58ba,
+			0x41b71efb2eb141f2,
+			0x7545e14679e2a9e3,
+			0x5bd062c2515f007c,
+			0x4db127f812200854,
+			0x1f16e9e80216231b,
+			0x66ef438d1190cde7,
+			0x3352255a140e0f76,
+			0x0ded7263109cf92e,
+			0x1befd79f7fdcc233,
+			0x6b68079a41a7c4c9,
+			0x25e45d324e6afb66,
+			0x431bd7b7519b500d,
+			0x7c83e4583f2dba31,
+			0x62bbd95a257130a3,
+			0x628c895d436c6125,
+			0x721da317333ab105,
+			0x2d1d5ae92443a858,
+			0x75a2a8d46763845e,
+			0x79838cb208edbdab,
+			0x0b03e0c64353d0cd,
+			0x54e49eb4189a769b,
+			0x2ca8861171f32454,
+			0x02901d820836c40e,
+			0x081386413a95f874,
+			0x7c3dbd3d1e7ff521,
+			0x6ceaf087737b8ddc,
+			0x4516dde922221a70,
+			0x614fd4a13006c83e,
+			0x5577f8e1419ac241,
+			0x05072367440badfc,
+			0x77465f013804823e,
+			0x5c482a977724c67e,
+			0x5e884adc2463b9ea,
+			0x2d51779651ead36b,
+			0x153ea438580bd78f,
+			0x70a64e2a3855585c,
+			0x2a487cb06a2342ec,
+			0x725a06fb1d4ed43b,
+			0x57e4ccaf2cd89a32,
+			0x4b588f547a6d8d3c,
+			0x6de91b18542289ec,
+			0x7644a45c38437fdb,
+			0x684a481a32fff902,
+			0x749abb43579478fe,
+			0x1ba026fa3dc240fb,
+			0x75c6c33a79a1deaa,
+			0x70c6a52912e685fb,
+			0x374a3fe6520eedd1,
+			0x23f9c13c4f4ef005,
+			0x275ac794649bb77c,
+			0x1cf10fd839386575,
+			0x235ba861180115be,
+			0x354fe9f947398c89,
+			0x741226bb15b5af5c,
+			0x10233c990d34b6a8,
+			0x615740953f6ab60f,
+			0x77ae35eb7e0c57b1,
+			0x310c50b3579be4f1,
+		},
+		.to_buff_len = 512,
+		.from_buff = {},
+		.from_buff_len = 0,
+		.seed = 0xffff,
+		.result = 0xca45
+	},
+};
+
+#define NUM_PULL_TESTS 4
+
+struct testcase pull_tests[NUM_PULL_TESTS] = {
+	{
+		.from_buff = {
+			0xdeadbeefdeadbeef,
+		},
+		.from_buff_len = 8,
+		.to_buff = {},
+		.to_buff_len = 0,
+		.seed = 0,
+		.result = 0xc4c4
+	},
+	{
+		.from_buff = {
+			0xdeadbeefdeadbeef,
+			0xbeefdeadbeefdead,
+		},
+		.from_buff_len = 16,
+		.to_buff = {},
+		.to_buff_len = 0,
+		.seed = 0x1234,
+		.result = 0x9bbd
+	},
+	{
+		.from_buff = {
+			0xdeadbeefdeadbeef,
+			0xbeefdeadbeefdead,
+		},
+		.from_buff_len = 15,
+		.to_buff = {},
+		.to_buff_len = 0,
+		.seed = 0x1234,
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		.result = 0x59be
+#else
+		.result = 0x9c6a
+#endif
+	},
+	{
+		.from_buff = {
+			0x327b23c66b8b4567,
+			0x66334873643c9869,
+			0x19495cff74b0dc51,
+			0x625558ec2ae8944a,
+			0x46e87ccd238e1f29,
+			0x507ed7ab3d1b58ba,
+			0x41b71efb2eb141f2,
+			0x7545e14679e2a9e3,
+			0x5bd062c2515f007c,
+			0x4db127f812200854,
+			0x1f16e9e80216231b,
+			0x66ef438d1190cde7,
+			0x3352255a140e0f76,
+			0x0ded7263109cf92e,
+			0x1befd79f7fdcc233,
+			0x6b68079a41a7c4c9,
+			0x25e45d324e6afb66,
+			0x431bd7b7519b500d,
+			0x7c83e4583f2dba31,
+			0x62bbd95a257130a3,
+			0x628c895d436c6125,
+			0x721da317333ab105,
+			0x2d1d5ae92443a858,
+			0x75a2a8d46763845e,
+			0x79838cb208edbdab,
+			0x0b03e0c64353d0cd,
+			0x54e49eb4189a769b,
+			0x2ca8861171f32454,
+			0x02901d820836c40e,
+			0x081386413a95f874,
+			0x7c3dbd3d1e7ff521,
+			0x6ceaf087737b8ddc,
+			0x4516dde922221a70,
+			0x614fd4a13006c83e,
+			0x5577f8e1419ac241,
+			0x05072367440badfc,
+			0x77465f013804823e,
+			0x5c482a977724c67e,
+			0x5e884adc2463b9ea,
+			0x2d51779651ead36b,
+			0x153ea438580bd78f,
+			0x70a64e2a3855585c,
+			0x2a487cb06a2342ec,
+			0x725a06fb1d4ed43b,
+			0x57e4ccaf2cd89a32,
+			0x4b588f547a6d8d3c,
+			0x6de91b18542289ec,
+			0x7644a45c38437fdb,
+			0x684a481a32fff902,
+			0x749abb43579478fe,
+			0x1ba026fa3dc240fb,
+			0x75c6c33a79a1deaa,
+			0x70c6a52912e685fb,
+			0x374a3fe6520eedd1,
+			0x23f9c13c4f4ef005,
+			0x275ac794649bb77c,
+			0x1cf10fd839386575,
+			0x235ba861180115be,
+			0x354fe9f947398c89,
+			0x741226bb15b5af5c,
+			0x10233c990d34b6a8,
+			0x615740953f6ab60f,
+			0x77ae35eb7e0c57b1,
+			0x310c50b3579be4f1,
+		},
+		.from_buff_len = 512,
+		.to_buff = {},
+		.to_buff_len = 0,
+		.seed = 0xffff,
+		.result = 0x35ba
+	},
+};
+
+#define NUM_DIFF_TESTS 4
+
+struct testcase diff_tests[NUM_DIFF_TESTS] = {
+	{
+		.from_buff = {
+			0xdeadbeefdeadbeef,
+		},
+		.from_buff_len = 8,
+		.to_buff = {
+			0xabababababababab,
+		},
+		.to_buff_len = 8,
+		.seed = 0,
+		.result = 0x7373
+	},
+	{
+		.from_buff = {
+			0xdeadbeefdeadbeef,
+		},
+		.from_buff_len = 7,
+		.to_buff = {
+			0xabababababababab,
+		},
+		.to_buff_len = 7,
+		.seed = 0,
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		.result = 0xa673
+#else
+		.result = 0x73b7
+#endif
+	},
+	{
+		.from_buff = {
+			0,
+		},
+		.from_buff_len = 8,
+		.to_buff = {
+			0xabababababababab,
+		},
+		.to_buff_len = 8,
+		.seed = 0,
+		.result = 0xaeae
+	},
+	{
+		.from_buff = {
+			0xdeadbeefdeadbeef
+		},
+		.from_buff_len = 8,
+		.to_buff = {
+			0,
+		},
+		.to_buff_len = 8,
+		.seed = 0xffff,
+		.result = 0xc4c4
+	},
+};
+
+#define NUM_EDGE_TESTS 4
+
+struct testcase edge_tests[NUM_EDGE_TESTS] = {
+	{
+		.from_buff = {},
+		.from_buff_len = 0,
+		.to_buff = {},
+		.to_buff_len = 0,
+		.seed = 0,
+		.result = 0
+	},
+	{
+		.from_buff = {
+			0x1234
+		},
+		.from_buff_len = 0,
+		.to_buff = {
+			0x1234
+		},
+		.to_buff_len = 0,
+		.seed = 0,
+		.result = 0
+	},
+	{
+		.from_buff = {},
+		.from_buff_len = 0,
+		.to_buff = {},
+		.to_buff_len = 0,
+		.seed = 0x1234,
+		.result = 0x1234
+	},
+	{
+		.from_buff = {},
+		.from_buff_len = 512,
+		.to_buff = {},
+		.to_buff_len = 0,
+		.seed = 0xffff,
+		.result = 0xffff
+	},
+};
+
+static unsigned short trigger_csum_diff(const struct csum_diff_test *skel)
+{
+	u8 tmp_out[64 << 2] = {};
+	u8 tmp_in[64] = {};
+	int err;
+	int pfd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = tmp_in,
+		.data_size_in = sizeof(tmp_in),
+		.data_out = tmp_out,
+		.data_size_out = sizeof(tmp_out),
+		.repeat = 1,
+	);
+	pfd = bpf_program__fd(skel->progs.compute_checksum);
+	err = bpf_prog_test_run_opts(pfd, &topts);
+	if (err)
+		return -1;
+
+	return skel->bss->result;
+}
+
+static void test_csum_diff(struct testcase *tests, int num_tests)
+{
+	struct csum_diff_test *skel;
+	unsigned short got;
+	int err;
+
+	for (int i = 0; i < num_tests; i++) {
+		skel = csum_diff_test__open();
+		if (!ASSERT_OK_PTR(skel, "csum_diff_test open"))
+			return;
+
+		skel->rodata->to_buff_len = tests[i].to_buff_len;
+		skel->rodata->from_buff_len = tests[i].from_buff_len;
+
+		err = csum_diff_test__load(skel);
+		if (!ASSERT_EQ(err, 0, "csum_diff_test load"))
+			goto out;
+
+		memcpy(skel->bss->to_buff, tests[i].to_buff, tests[i].to_buff_len);
+		memcpy(skel->bss->from_buff, tests[i].from_buff, tests[i].from_buff_len);
+		skel->bss->seed = tests[i].seed;
+
+		got = trigger_csum_diff(skel);
+		ASSERT_EQ(got, tests[i].result, "csum_diff result");
+
+		csum_diff_test__destroy(skel);
+	}
+
+	return;
+out:
+	csum_diff_test__destroy(skel);
+}
+
+void test_test_csum_diff(void)
+{
+	if (test__start_subtest("csum_diff_push"))
+		test_csum_diff(push_tests, NUM_PUSH_TESTS);
+	if (test__start_subtest("csum_diff_pull"))
+		test_csum_diff(pull_tests, NUM_PULL_TESTS);
+	if (test__start_subtest("csum_diff_diff"))
+		test_csum_diff(diff_tests, NUM_DIFF_TESTS);
+	if (test__start_subtest("csum_diff_edge"))
+		test_csum_diff(edge_tests, NUM_EDGE_TESTS);
+}
diff --git a/tools/testing/selftests/bpf/progs/csum_diff_test.c b/tools/testing/selftests/bpf/progs/csum_diff_test.c
new file mode 100644
index 0000000000000..9438f1773a589
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/csum_diff_test.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define BUFF_SZ 512
+
+/* Will be updated by benchmark before program loading */
+char to_buff[BUFF_SZ];
+const volatile unsigned int to_buff_len = 0;
+char from_buff[BUFF_SZ];
+const volatile unsigned int from_buff_len = 0;
+unsigned short seed = 0;
+
+short result;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tc")
+int compute_checksum(void *ctx)
+{
+	int to_len_half = to_buff_len / 2;
+	int from_len_half = from_buff_len / 2;
+	short result2;
+
+	/* Calculate checksum in one go */
+	result2 = bpf_csum_diff((void *)from_buff, from_buff_len,
+				(void *)to_buff, to_buff_len, seed);
+
+	/* Calculate checksum by concatenating bpf_csum_diff()*/
+	result = bpf_csum_diff((void *)from_buff, from_buff_len - from_len_half,
+			       (void *)to_buff, to_buff_len - to_len_half, seed);
+
+	result = bpf_csum_diff((void *)from_buff + (from_buff_len - from_len_half), from_len_half,
+			       (void *)to_buff + (to_buff_len - to_len_half), to_len_half, result);
+
+	result = (result == result2) ? result : 0;
+
+	return 0;
+}
-- 
2.40.1


