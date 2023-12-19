Return-Path: <bpf+bounces-18340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A88190C9
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501E5281CB9
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73C839AC0;
	Tue, 19 Dec 2023 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+qB0NBN"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCF39851
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703014390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFULqfGrXOrtFGhKGhQc9jg8xfjAiJmb5sz/d5R9CnQ=;
	b=R+qB0NBNYBSHrpDMunpUNfbmgQ5i+a/ua47qsU3YmKg1XrNjxN6vJjRj/CeRWgnIXSsEK0
	hOisSYwVLXeoMRpFIQW7KqTIdf8UmOeeDU1vLqfhW3QEmggZBZsOBtjDa6YViN9j3Uht6Z
	/8zlHS47XOREdfnjYGAZCCX3FV9BZ2U=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 2/2] selftests/bpf: Test udp and tcp iter batching
Date: Tue, 19 Dec 2023 11:32:59 -0800
Message-Id: <20231219193259.3230692-2-martin.lau@linux.dev>
In-Reply-To: <20231219193259.3230692-1-martin.lau@linux.dev>
References: <20231219193259.3230692-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The patch adds a test to exercise the bpf_iter_udp batching
logic. It specifically tests the case that there are multiple
so_reuseport udp_sk in a bucket of the udp_table.
The userspace is only reading one udp_sk at a time from
the bpf_iter_udp prog. The true case in
"read_batch(..., bool read_one)". This is the buggy case
that the previous patch fixed.

It also tests the "false" case in "read_batch(..., bool read_one)",
meaning the userspace reads the whole bucket. There is
no bug in this case but adding this test also while
at it.

Considering the way to have multiple tcp_sk in the same
bucket is similar (by using so_reuseport),
this patch also tests the bpf_iter_tcp even though the
bpf_iter_tcp batching logic works correctly.

Both IP v4 and v6 are exercising the same bpf_iter batching
code path, so only v6 is tested.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 101 ++++++++++++++++++
 .../selftests/bpf/progs/sock_iter_batch.c     |  43 ++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_iter_batch.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
new file mode 100644
index 000000000000..38aa564862e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2023 Meta
+
+#include <test_progs.h>
+#include "network_helpers.h"
+#include "sock_iter_batch.skel.h"
+
+#define TEST_NS "sock_iter_batch_netns"
+
+static const char expected_char = 'x';
+static const int nr_soreuse = 4;
+
+static void read_batch(struct bpf_program *prog, bool read_one)
+{
+	int iter_fd, i, nread, total_nread = 0;
+	struct bpf_link *link;
+	char b[nr_soreuse];
+
+	link = bpf_program__attach_iter(prog, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		return;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create")) {
+		bpf_link__destroy(link);
+		return;
+	}
+
+	do {
+		nread = read(iter_fd, b, read_one ? 1 : nr_soreuse);
+		if (nread <= 0)
+			break;
+
+		for (i = 0; i < nread; i++)
+			ASSERT_EQ(b[i], expected_char, "b[i]");
+
+		total_nread += nread;
+	} while (total_nread <= nr_soreuse);
+
+	ASSERT_EQ(nread, 0, "nread");
+	ASSERT_EQ(total_nread, nr_soreuse, "total_nread");
+
+	close(iter_fd);
+	bpf_link__destroy(link);
+}
+
+static void do_test(int sock_type)
+{
+	struct sock_iter_batch *skel;
+	int *fds, err;
+
+	fds = start_reuseport_server(AF_INET6, sock_type, "::1", 0, 0,
+				     nr_soreuse);
+	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
+		return;
+
+	skel = sock_iter_batch__open();
+	if (!ASSERT_OK_PTR(skel, "sock_iter_batch__open"))
+		goto done;
+
+	skel->rodata->local_port = ntohs(get_socket_local_port(fds[0]));
+	skel->rodata->expected_char = expected_char;
+
+	err = sock_iter_batch__load(skel);
+	if (!ASSERT_OK(err, "sock_iter_batch__load"))
+		goto done;
+
+	if (sock_type == SOCK_STREAM) {
+		read_batch(skel->progs.iter_tcp_soreuse, true);
+		read_batch(skel->progs.iter_tcp_soreuse, false);
+	} else {
+		read_batch(skel->progs.iter_udp_soreuse, true);
+		read_batch(skel->progs.iter_udp_soreuse, false);
+	}
+
+done:
+	sock_iter_batch__destroy(skel);
+	free_fds(fds, nr_soreuse);
+}
+
+void test_sock_iter_batch(void)
+{
+	struct nstoken *nstoken = NULL;
+
+	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
+	SYS(done, "ip netns add %s", TEST_NS);
+	SYS(done, "ip -net %s link set dev lo up", TEST_NS);
+
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto done;
+
+	if (test__start_subtest("tcp"))
+		do_test(SOCK_STREAM);
+	if (test__start_subtest("udp"))
+		do_test(SOCK_DGRAM);
+
+done:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
new file mode 100644
index 000000000000..4264df162d83
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2023 Meta
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_tracing_net.h"
+#include "bpf_kfuncs.h"
+
+volatile const __u16 local_port;
+volatile const char expected_char;
+
+SEC("iter/tcp")
+int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
+{
+	struct sock *sk = (struct sock *)ctx->sk_common;
+
+	if (!sk)
+		return 0;
+
+	sk = bpf_rdonly_cast(sk, bpf_core_type_id_kernel(struct sock));
+	if (sk->sk_family == AF_INET6 && sk->sk_num == local_port)
+		bpf_seq_write(ctx->meta->seq, (void *)&expected_char, 1);
+
+	return 0;
+}
+
+SEC("iter/udp")
+int iter_udp_soreuse(struct bpf_iter__udp *ctx)
+{
+	struct sock *sk = (struct sock *)ctx->udp_sk;
+
+	if (!sk)
+		return 0;
+
+	sk = bpf_rdonly_cast(sk, bpf_core_type_id_kernel(struct sock));
+	if (sk->sk_family == AF_INET6 && sk->sk_num == local_port)
+		bpf_seq_write(ctx->meta->seq, (void *)&expected_char, 1);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


