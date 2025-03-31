Return-Path: <bpf+bounces-54922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A03A75E3A
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 05:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FCD188A48F
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC78D15747C;
	Mon, 31 Mar 2025 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QMBMBWyO"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A841147C9B
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743391633; cv=none; b=KQvokwT7VrO0no59Dr3Y85xFNKFrKQsr/CcbcVIbvvHuL+bCkoZq8WljvRLwl1aUos2+7L+kR8lFAgkkPlQ9t2FOqxtQwrC5HkLrTNEfiR6R6Pi5aSJ4RxvpxEjwKsf1J2D9ud+pm4xut6liYP9vWbj9HmLC9evCXOLT3AFatBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743391633; c=relaxed/simple;
	bh=fFET+nuw/dYayGSpiSR3tJTz7FXHCTINYko7sjU3emY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2SDI5XCH1YVEX3bBY/Rt/QsT5qMMHgkpcOyzSp+LK2uloV56AyXtEHdYtCBBW4dbgwgOnv2k2j9XEqSasHru8O3eTHWimjE88p/zDwOYUKpTbhtxsVRUh/yN7wEIO21GWl45gqm724Y+EFpJLHqhnwG0t1DZ+BHz6aK/7AyKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QMBMBWyO; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743391629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V56JHxGDjzAKXxuLKm6oU1GXbFgBBKVmUWh6K/pxAuw=;
	b=QMBMBWyOQxrknWYxNUz4AUQOJDB7RKJva5mOywTeoDX4qDdDsODwoNc1baDjzo90QKTG0L
	XC4ySD1p5q3ew8LckBYVLQsu25cNir/cLvZVwjceFXrZpVYg2hdRoaDavrLm3GJ+2qAj0A
	gz4T8iZcv37UV1WLSgbG+HpVRuDRV5I=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: add perf test for adjust_{head,meta}
Date: Mon, 31 Mar 2025 11:23:45 +0800
Message-ID: <20250331032354.75808-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250331032354.75808-1-jiayuan.chen@linux.dev>
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We added a memset operation during the adjust operation, which may cause
performance issues.

Therefore, we added perf testing, and testing found that for common header
length operations, memset() operation increased the performance overhead
by 2ns, which is negligible for the net stack.

Before memset
./test_progs -a xdp_adjust_head_perf -v
run adjust head with size 6 cost 56 ns
run adjust head with size 20 cost 56 ns
run adjust head with size 40 cost 56 ns
run adjust head with size 200 cost 56 ns

After memset
./test_progs -a xdp_adjust_head_perf -v
run adjust head with size 6 cost 58 ns
run adjust head with size 20 cost 58 ns
run adjust head with size 40 cost 58 ns
run adjust head with size 200 cost 66 ns

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_perf.c       | 52 ++++++++++++++++---
 tools/testing/selftests/bpf/progs/xdp_dummy.c | 14 +++++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_perf.c b/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
index ec5369f247cb..1b4260c6e5d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
+#include "xdp_dummy.skel.h"
 
 void test_xdp_perf(void)
 {
-	const char *file = "./xdp_dummy.bpf.o";
-	struct bpf_object *obj;
+	struct xdp_dummy *skel;
 	char in[128], out[128];
 	int err, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
@@ -15,14 +16,51 @@ void test_xdp_perf(void)
 		.repeat = 1000000,
 	);
 
-	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
-	if (CHECK_FAIL(err))
-		return;
-
+	skel = xdp_dummy__open_and_load();
+	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, XDP_PASS, "test_run retval");
 	ASSERT_EQ(topts.data_size_out, 128, "test_run data_size_out");
 
-	bpf_object__close(obj);
+	xdp_dummy__destroy(skel);
+}
+
+void test_xdp_adjust_head_perf(void)
+{
+	struct xdp_dummy *skel;
+	int repeat = 9000000;
+	struct xdp_md ctx_in;
+	char data[100];
+	int err, prog_fd;
+	size_t test_header_size[] = {
+		ETH_ALEN,
+		sizeof(struct iphdr),
+		sizeof(struct ipv6hdr),
+		200,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, topts,
+			    .data_in = &data,
+			    .data_size_in = sizeof(data),
+			    .repeat = repeat,
+	);
+
+	topts.ctx_in = &ctx_in;
+	topts.ctx_size_in = sizeof(ctx_in);
+	memset(&ctx_in, 0, sizeof(ctx_in));
+	ctx_in.data_meta = 0;
+	ctx_in.data_end = ctx_in.data + sizeof(data);
+
+	skel = xdp_dummy__open_and_load();
+	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_adjust_head);
+
+	for (int i = 0; i < ARRAY_SIZE(test_header_size); i++) {
+		skel->bss->head_size = test_header_size[i];
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "test_run");
+		ASSERT_EQ(topts.retval, XDP_PASS, "test_run retval");
+		fprintf(stdout, "run adjust head with size %zd cost %d ns\n",
+			test_header_size[i], topts.duration);
+	}
+	xdp_dummy__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/xdp_dummy.c b/tools/testing/selftests/bpf/progs/xdp_dummy.c
index d988b2e0cee8..7bebedbbc949 100644
--- a/tools/testing/selftests/bpf/progs/xdp_dummy.c
+++ b/tools/testing/selftests/bpf/progs/xdp_dummy.c
@@ -4,10 +4,24 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+int head_size;
+
 SEC("xdp")
 int xdp_dummy_prog(struct xdp_md *ctx)
 {
 	return XDP_PASS;
 }
 
+SEC("xdp")
+int xdp_dummy_adjust_head(struct xdp_md *ctx)
+{
+	if (bpf_xdp_adjust_head(ctx, -head_size))
+		return XDP_DROP;
+
+	if (bpf_xdp_adjust_head(ctx, head_size))
+		return XDP_DROP;
+
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


