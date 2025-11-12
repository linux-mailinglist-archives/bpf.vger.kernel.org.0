Return-Path: <bpf+bounces-74337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB19C54CCC
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 00:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A37334E0741
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 23:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE322F2619;
	Wed, 12 Nov 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcZguUuC"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA0278E63
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762989854; cv=none; b=r7QI+J0Xve1C4D6Na4cX/PhAuGqsozVWyrgJYIUwHxLfZ0MwAQTssClHMHRU8zi/SCFC5Jz8JbiTDfMQJCzi6bl9noBs7lKEXpVbeG/4kus/iQs2U1c1mudBhwjczpOZdzk3C1PG4Zflu8xeTDoH0/gikCZB6vtTi8Zsx63iGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762989854; c=relaxed/simple;
	bh=l9lN7lp0++mmIOFkRAkbNQ9oR6dF0BER0pTD69UpuSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OztVC88+tfutz7+A63ve6hBWVXstp9CwefXZ//PdUjaGeihPdBIVGbpQGk8Niiv22nygp7M7q56fVmbBqwa8tTtwLfYgMFsz9FhtNiRZbxBAncbFAbJwdAx6xMv7sJiTUSco5qkOJ0RvruQR8K2oOiNnOPJCm2tez8bLucolmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcZguUuC; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762989849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xer3eO9KF7g9JfEkIncqpMpp6r9qiuGWx5sYuf4J0mk=;
	b=pcZguUuCmnCo9sjcj2nSUeqCeMGgrRSNMfGk2qc9M34V9qRimzdwQpcYYZeyuln5yVeOjK
	gPHyjbM5PWWOs04G6LrRCKkcgsB4QV/LCk0PluLcg4n6UFePml5z+WJvTqCXcaurttmE2Q
	lIff3nWb9j56yIwm0XnQqsMjoWS7M7E=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set
Date: Wed, 12 Nov 2025 15:23:31 -0800
Message-ID: <20251112232331.1566074-2-martin.lau@linux.dev>
In-Reply-To: <20251112232331.1566074-1-martin.lau@linux.dev>
References: <20251112232331.1566074-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

Add a test to check that bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) is
rejected (-EINVAL) if skb->transport_header is not set. The test
needs to lower the MTU of the loopback device. Thus, take this
opportunity to run the test in a netns by adding "ns_" to the test
name. The "serial_" prefix can then be removed.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/check_mtu.c      | 23 ++++++++++++++++++-
 .../selftests/bpf/progs/test_check_mtu.c      | 12 ++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
index 2a9a30650350..65b4512967e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -153,6 +153,26 @@ static void test_check_mtu_run_tc(struct test_check_mtu *skel,
 	ASSERT_EQ(mtu_result, mtu_expect, "MTU-compare-user");
 }
 
+static void test_chk_segs_flag(struct test_check_mtu *skel, __u32 mtu)
+{
+	int err, prog_fd = bpf_program__fd(skel->progs.tc_chk_segs_flag);
+	struct __sk_buff skb = {
+		.gso_size = 10,
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .ctx_in = &skb,
+		    .ctx_size_in = sizeof(skb),
+	);
+
+	/* Lower the mtu to test the BPF_MTU_CHK_SEGS */
+	SYS_NOFAIL("ip link set dev lo mtu 10");
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	SYS_NOFAIL("ip link set dev lo mtu %u", mtu);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, BPF_OK, "retval");
+}
 
 static void test_check_mtu_tc(__u32 mtu, __u32 ifindex)
 {
@@ -177,11 +197,12 @@ static void test_check_mtu_tc(__u32 mtu, __u32 ifindex)
 	test_check_mtu_run_tc(skel, skel->progs.tc_minus_delta, mtu);
 	test_check_mtu_run_tc(skel, skel->progs.tc_input_len, mtu);
 	test_check_mtu_run_tc(skel, skel->progs.tc_input_len_exceed, mtu);
+	test_chk_segs_flag(skel, mtu);
 cleanup:
 	test_check_mtu__destroy(skel);
 }
 
-void serial_test_check_mtu(void)
+void test_ns_check_mtu(void)
 {
 	int mtu_lo;
 
diff --git a/tools/testing/selftests/bpf/progs/test_check_mtu.c b/tools/testing/selftests/bpf/progs/test_check_mtu.c
index 2ec1de11a3ae..7b6b2b342c1d 100644
--- a/tools/testing/selftests/bpf/progs/test_check_mtu.c
+++ b/tools/testing/selftests/bpf/progs/test_check_mtu.c
@@ -7,6 +7,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
+#include <errno.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -288,3 +289,14 @@ int tc_input_len_exceed(struct __sk_buff *ctx)
 	global_bpf_mtu_xdp = mtu_len;
 	return retval;
 }
+
+SEC("tc")
+int tc_chk_segs_flag(struct __sk_buff *ctx)
+{
+	__u32 mtu_len = 0;
+	int err;
+
+	err = bpf_check_mtu(ctx, GLOBAL_USER_IFINDEX, &mtu_len, 0, BPF_MTU_CHK_SEGS);
+
+	return err == -EINVAL ? BPF_OK : BPF_DROP;
+}
-- 
2.47.3


