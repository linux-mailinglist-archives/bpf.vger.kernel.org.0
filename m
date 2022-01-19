Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9683493EB0
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356247AbiASQ6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 11:58:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59286 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiASQ6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 11:58:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F8EA615A7
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 16:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B80C004E1;
        Wed, 19 Jan 2022 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642611532;
        bh=Z0zaWYULmRksnbJA4QVQChY4o9e6lY01A/Eiy8Fefwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLleRdzWf6YLMzmirYCqe4cWZHFfXvYpL9VJKQnNTeNGqfV0rK8SJ9WDRFriod4h2
         uv/AFahQk66dJVJ9pSiKx8KQJxmXKGlgW+VmqfondNsDYsfZTW2kfR87p1QUnzviUc
         poS7USzuP4MbsPbj32wzv1Y7vJr/OMJIRn3BwXlq3rtcA8h3ZmBMlBplLTkSEAnEs3
         gljGTIOnElCbvZ1RjNQm/QoOzR2SzidTVEpaKH51ZwZNI9+MC8FhGxbo90Cti/UIxV
         6ptBC6OfNYq+GlqgpGrfpEf+hov8DSntzkH8pT7vzhhg50ggVA0G2SxKoNZAoFluFd
         A9PMtUTV3oQEg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next 2/2] bpf: selftests: get rid of CHECK macro in xdp_bpf2bpf.c
Date:   Wed, 19 Jan 2022 17:58:27 +0100
Message-Id: <ec0dbfecc37e9900001bfbd5744d917eb48de870.1642611050.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642611050.git.lorenzo@kernel.org>
References: <cover.1642611050.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rely on ASSERT* macros and get rid of deprecated CHECK ones in
xdp_bpf2bpf bpf selftest.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 43 ++++++++-----------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
index c98a897ad692..951ce1fc535d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
@@ -12,25 +12,21 @@ struct meta {
 
 static void on_sample(void *ctx, int cpu, void *data, __u32 size)
 {
-	int duration = 0;
 	struct meta *meta = (struct meta *)data;
 	struct ipv4_packet *trace_pkt_v4 = data + sizeof(*meta);
 
-	if (CHECK(size < sizeof(pkt_v4) + sizeof(*meta),
-		  "check_size", "size %u < %zu\n",
-		  size, sizeof(pkt_v4) + sizeof(*meta)))
+	if (!ASSERT_GE(size, sizeof(pkt_v4) + sizeof(*meta), "check_size"))
 		return;
 
-	if (CHECK(meta->ifindex != if_nametoindex("lo"), "check_meta_ifindex",
-		  "meta->ifindex = %d\n", meta->ifindex))
+	if (!ASSERT_EQ(meta->ifindex, if_nametoindex("lo"),
+		       "check_meta_ifindex"))
 		return;
 
-	if (CHECK(meta->pkt_len != sizeof(pkt_v4), "check_meta_pkt_len",
-		  "meta->pkt_len = %zd\n", sizeof(pkt_v4)))
+	if (!ASSERT_EQ(meta->pkt_len, sizeof(pkt_v4), "check_meta_pkt_len"))
 		return;
 
-	if (CHECK(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)),
-		  "check_packet_content", "content not the same\n"))
+	if (!ASSERT_EQ(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)),
+		       0, "check_packet_content"))
 		return;
 
 	*(bool *)ctx = true;
@@ -52,7 +48,7 @@ void test_xdp_bpf2bpf(void)
 
 	/* Load XDP program to introspect */
 	pkt_skel = test_xdp__open_and_load();
-	if (CHECK(!pkt_skel, "pkt_skel_load", "test_xdp skeleton failed\n"))
+	if (!ASSERT_OK_PTR(pkt_skel, "test_xdp__open_and_load"))
 		return;
 
 	pkt_fd = bpf_program__fd(pkt_skel->progs._xdp_tx_iptunnel);
@@ -62,7 +58,7 @@ void test_xdp_bpf2bpf(void)
 
 	/* Load trace program */
 	ftrace_skel = test_xdp_bpf2bpf__open();
-	if (CHECK(!ftrace_skel, "__open", "ftrace skeleton failed\n"))
+	if (!ASSERT_OK_PTR(ftrace_skel, "test_xdp_bpf2bpf__open"))
 		goto out;
 
 	/* Demonstrate the bpf_program__set_attach_target() API rather than
@@ -77,11 +73,11 @@ void test_xdp_bpf2bpf(void)
 	bpf_program__set_attach_target(prog, pkt_fd, "_xdp_tx_iptunnel");
 
 	err = test_xdp_bpf2bpf__load(ftrace_skel);
-	if (CHECK(err, "__load", "ftrace skeleton failed\n"))
+	if (!ASSERT_OK(err, "test_xdp_bpf2bpf__load"))
 		goto out;
 
 	err = test_xdp_bpf2bpf__attach(ftrace_skel);
-	if (CHECK(err, "ftrace_attach", "ftrace attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "test_xdp_bpf2bpf__attach"))
 		goto out;
 
 	/* Set up perf buffer */
@@ -94,30 +90,25 @@ void test_xdp_bpf2bpf(void)
 	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
 	memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
-	if (CHECK(err || retval != XDP_TX || size != 74 ||
-		  iph.protocol != IPPROTO_IPIP, "ipv4",
-		  "err %d errno %d retval %d size %d\n",
-		  err, errno, retval, size))
+	if (!ASSERT_OK(err || retval != XDP_TX || size != 74 ||
+		       iph.protocol != IPPROTO_IPIP, "ipv4"))
 		goto out;
 
 	/* Make sure bpf_xdp_output() was triggered and it sent the expected
 	 * data to the perf ring buffer.
 	 */
 	err = perf_buffer__poll(pb, 100);
-	if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
+	if (!ASSERT_GE(err, 0, "perf_buffer__poll"))
 		goto out;
 
-	CHECK_FAIL(!passed);
+	ASSERT_TRUE(passed, "test passed");
 
 	/* Verify test results */
-	if (CHECK(ftrace_skel->bss->test_result_fentry != if_nametoindex("lo"),
-		  "result", "fentry failed err %llu\n",
-		  ftrace_skel->bss->test_result_fentry))
+	if (!ASSERT_EQ(ftrace_skel->bss->test_result_fentry, if_nametoindex("lo"),
+		       "fentry result"))
 		goto out;
 
-	CHECK(ftrace_skel->bss->test_result_fexit != XDP_TX, "result",
-	      "fexit failed err %llu\n", ftrace_skel->bss->test_result_fexit);
-
+	ASSERT_EQ(ftrace_skel->bss->test_result_fexit, XDP_TX, "fexit result");
 out:
 	if (pb)
 		perf_buffer__free(pb);
-- 
2.34.1

