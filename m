Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41152494D66
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiATLu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 06:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiATLuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 06:50:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B4C06173F
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 03:50:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E00236168C
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D27EC340E0;
        Thu, 20 Jan 2022 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642679450;
        bh=XHBOWvNKhO2UCPGzlzWmjzL2nV27uFDIj3vDyVSbYEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdl0VUoUYzYNZ0t6B1mSb7vJhA5T14Bp4rH2TxQf0oH1MsPiKrlA9qf1lDLcnwtx4
         i1KtHsSDyggeuqEaAJQRDKGrKFna9xlqAPe2O3XIXWo6YYoobMWICwibPnjOXNFzel
         PCZ9JUNRx5jVEwTDTmHvxyudgVKXvFJIxytUR5OTHi2coeUtfBO0QHY+PU3dxetc3R
         uIdHrlheFBrPYem0ZSnCLNr71VSwnSzGBwDcauK0aLlsaP1PL3UdeUUrZaq0L6V+rA
         C7XTcxV3xMfL1233VqZ60QXRXs+dYKCEP53jb1D/lRSDVZ+sdpDc2zPrt7BCZ2C1M4
         67ScQy/7ezbiQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH v2 bpf-next 2/2] bpf: selftests: get rid of CHECK macro in xdp_bpf2bpf.c
Date:   Thu, 20 Jan 2022 12:50:27 +0100
Message-Id: <df7e5098465016e27d91f2c69a376a35d63a7621.1642679130.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642679130.git.lorenzo@kernel.org>
References: <cover.1642679130.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rely on ASSERT* macros and get rid of deprecated CHECK ones in
xdp_bpf2bpf bpf selftest.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 60 +++++++------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
index c98a897ad692..500a302cb3e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
@@ -12,26 +12,14 @@ struct meta {
 
 static void on_sample(void *ctx, int cpu, void *data, __u32 size)
 {
-	int duration = 0;
 	struct meta *meta = (struct meta *)data;
 	struct ipv4_packet *trace_pkt_v4 = data + sizeof(*meta);
 
-	if (CHECK(size < sizeof(pkt_v4) + sizeof(*meta),
-		  "check_size", "size %u < %zu\n",
-		  size, sizeof(pkt_v4) + sizeof(*meta)))
-		return;
-
-	if (CHECK(meta->ifindex != if_nametoindex("lo"), "check_meta_ifindex",
-		  "meta->ifindex = %d\n", meta->ifindex))
-		return;
-
-	if (CHECK(meta->pkt_len != sizeof(pkt_v4), "check_meta_pkt_len",
-		  "meta->pkt_len = %zd\n", sizeof(pkt_v4)))
-		return;
-
-	if (CHECK(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)),
-		  "check_packet_content", "content not the same\n"))
-		return;
+	ASSERT_GE(size, sizeof(pkt_v4) + sizeof(*meta), "check_size");
+	ASSERT_EQ(meta->ifindex, if_nametoindex("lo"), "check_meta_ifindex");
+	ASSERT_EQ(meta->pkt_len, sizeof(pkt_v4), "check_meta_pkt_len");
+	ASSERT_EQ(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)), 0,
+		  "check_packet_content");
 
 	*(bool *)ctx = true;
 }
@@ -52,7 +40,7 @@ void test_xdp_bpf2bpf(void)
 
 	/* Load XDP program to introspect */
 	pkt_skel = test_xdp__open_and_load();
-	if (CHECK(!pkt_skel, "pkt_skel_load", "test_xdp skeleton failed\n"))
+	if (!ASSERT_OK_PTR(pkt_skel, "test_xdp__open_and_load"))
 		return;
 
 	pkt_fd = bpf_program__fd(pkt_skel->progs._xdp_tx_iptunnel);
@@ -62,7 +50,7 @@ void test_xdp_bpf2bpf(void)
 
 	/* Load trace program */
 	ftrace_skel = test_xdp_bpf2bpf__open();
-	if (CHECK(!ftrace_skel, "__open", "ftrace skeleton failed\n"))
+	if (!ASSERT_OK_PTR(ftrace_skel, "test_xdp_bpf2bpf__open"))
 		goto out;
 
 	/* Demonstrate the bpf_program__set_attach_target() API rather than
@@ -77,11 +65,11 @@ void test_xdp_bpf2bpf(void)
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
@@ -94,33 +82,25 @@ void test_xdp_bpf2bpf(void)
 	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
 	memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
-	if (CHECK(err || retval != XDP_TX || size != 74 ||
-		  iph.protocol != IPPROTO_IPIP, "ipv4",
-		  "err %d errno %d retval %d size %d\n",
-		  err, errno, retval, size))
-		goto out;
+
+	ASSERT_OK(err, "ipv4");
+	ASSERT_EQ(retval, XDP_TX, "ipv4 retval");
+	ASSERT_EQ(size, 74, "ipv4 size");
+	ASSERT_EQ(iph.protocol, IPPROTO_IPIP, "ipv4 proto");
 
 	/* Make sure bpf_xdp_output() was triggered and it sent the expected
 	 * data to the perf ring buffer.
 	 */
 	err = perf_buffer__poll(pb, 100);
-	if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
-		goto out;
-
-	CHECK_FAIL(!passed);
 
+	ASSERT_GE(err, 0, "perf_buffer__poll");
+	ASSERT_TRUE(passed, "test passed");
 	/* Verify test results */
-	if (CHECK(ftrace_skel->bss->test_result_fentry != if_nametoindex("lo"),
-		  "result", "fentry failed err %llu\n",
-		  ftrace_skel->bss->test_result_fentry))
-		goto out;
-
-	CHECK(ftrace_skel->bss->test_result_fexit != XDP_TX, "result",
-	      "fexit failed err %llu\n", ftrace_skel->bss->test_result_fexit);
-
+	ASSERT_EQ(ftrace_skel->bss->test_result_fentry, if_nametoindex("lo"),
+		  "fentry result");
+	ASSERT_EQ(ftrace_skel->bss->test_result_fexit, XDP_TX, "fexit result");
 out:
-	if (pb)
-		perf_buffer__free(pb);
+	perf_buffer__free(pb);
 	test_xdp__destroy(pkt_skel);
 	test_xdp_bpf2bpf__destroy(ftrace_skel);
 }
-- 
2.34.1

