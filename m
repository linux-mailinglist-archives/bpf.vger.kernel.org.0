Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9C58DC28
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbiHIQfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiHIQfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:35:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E41EED2;
        Tue,  9 Aug 2022 09:35:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 58AC63200972;
        Tue,  9 Aug 2022 12:34:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 09 Aug 2022 12:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1660062898; x=1660149298; bh=dP
        xSBr5Vd3gl0nFWhvgR0cMB3HmS0oxvmaY/XsKKQ90=; b=pYPmvYxBzPxIDGqjZC
        OIGJMPi6ztiDTPQb5RDJc7FNYVCZ0I1X9ex/yB5Kdxa8zypA8sS9ZXh5gRjAvdSq
        JiAXgbHYV2MmUiiznDZmGCpBBL2nWkwznjB+RtvE/LrFCFaxcj8f/4fdtTzFD6+q
        97B2SmfyTtfoBXp+8uV3MwQP1+Ux6fGGCDDKDP4qwUs6cEVn3BfGThJ3LqktxnyV
        jBQefiSa6bCQwoYLhPn5sfs3Fnx0flN1PJc4okmmhgaHbKFDC0gXTbq8xY1YqC5f
        JnjX2bS+cBDolDIDGI4IYsrqnn3nLqK2/RBxz8yG6UcauoGQWSqAHH3muSsHyA8R
        2+xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660062898; x=1660149298; bh=dPxSBr5Vd3gl0
        nFWhvgR0cMB3HmS0oxvmaY/XsKKQ90=; b=NAP6bCdzeWfjwfJ7EK/uTZ/2JgstH
        rofMyClaezza3TdDz/5rR05QRML0BSWcXEHZTogRC9Qge9/i+Ng8Tsp9/BFCcFI+
        pgw9fySRIR345Qpx3ikZZ3k5mCAddJED+iWo9jJXoCRwxON8z3ig4sbq+w375Q1h
        Qd+TwSWmQR8dcCBh9CY9PS2RSecPXXATsj3Iqc8Ax/dvAO50Gf0f8fUMYNE6ILot
        Nm4hey2zx/Wa40uNsnEkTHOLRWO/iVvIE9ecFF1Vdx1saJrhiwBXd9DHXOWBOzfE
        KlC4o5cb7wROMnW3W7aLgxz3kjrIm08p/TohFBe//I1B6b1T5gfm2V6sQ==
X-ME-Sender: <xms:sozyYp2VoNDC0dYQFH1qrrLe8JhbLDeRaOlVOWFCMH5IGdPXM5yNnA>
    <xme:sozyYgHefHXVylOZIUwj1Yl6FkJDzL0UCOp5jp9bVXQ18_R8yuLcztqGbIU_ZlicL
    TUenROyzQ3-1G0tIQ>
X-ME-Received: <xmr:sozyYp7E67Oa3oH_QbZyCvdgSiHtUOzBurBBQSc8JyuLrZ9ewtT2YZpIaeIYJ86uG3SKZLPCdlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefhjeehjeeljedtle
    eifedujedvuedtteeuveekheduueehleettefhueektdeifeenucffohhmrghinhepihhp
    vhegrdhsphhorhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:sozyYm0XlPggWMmsW8iutHCLVt83JbNiipgca3Pl4lCpK3mUHO6u0A>
    <xmx:sozyYsGr2T4Tj7_bm1vmDtalfBR51TjTugQug9Qg0CByY3YogqnRhw>
    <xmx:sozyYn8j0IfRJZByx-yWqKCajzTrV3eQdsMtNZmxOjKMX_yp_jO7Ng>
    <xmx:sozyYhN90NhvJtcTp3K1S7YrB_M2POEgoOgqnh_E7j_YjMgbX33T3g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 12:34:57 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Add existing connection bpf_*_ct_lookup() test
Date:   Tue,  9 Aug 2022 10:34:41 -0600
Message-Id: <0ae383f53c83964c0a3440864ebb5ea28f8fec35.1660062725.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660062725.git.dxu@dxuuu.xyz>
References: <cover.1660062725.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test where we do a conntrack lookup on an existing connection.
This is nice because it's a more realistic test than artifically
creating a ct entry and looking it up afterwards.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c | 59 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 18 ++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index 7a74a1579076..317978cac029 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -24,10 +24,34 @@ enum {
 	TEST_TC_BPF,
 };
 
+#define TIMEOUT_MS 3000
+
+static int connect_to_server(int srv_fd)
+{
+	int fd = -1;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto out;
+
+	if (CHECK_FAIL(connect_fd_to_fd(fd, srv_fd, TIMEOUT_MS))) {
+		close(fd);
+		fd = -1;
+	}
+out:
+	return fd;
+}
+
 static void test_bpf_nf_ct(int mode)
 {
+	const char *iptables = "iptables -t raw %s PREROUTING -j CT";
+	int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
+	struct sockaddr_in peer_addr = {};
 	struct test_bpf_nf *skel;
 	int prog_fd, err;
+	socklen_t len;
+	u16 srv_port;
+	char cmd[64];
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = &pkt_v4,
 		.data_size_in = sizeof(pkt_v4),
@@ -38,6 +62,32 @@ static void test_bpf_nf_ct(int mode)
 	if (!ASSERT_OK_PTR(skel, "test_bpf_nf__open_and_load"))
 		return;
 
+	/* Enable connection tracking */
+	snprintf(cmd, sizeof(cmd), iptables, "-A");
+	if (!ASSERT_OK(system(cmd), "iptables"))
+		goto end;
+
+	srv_port = (mode == TEST_XDP) ? 5005 : 5006;
+	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", srv_port, TIMEOUT_MS);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		goto end;
+
+	client_fd = connect_to_server(srv_fd);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_server"))
+		goto end;
+
+	len = sizeof(peer_addr);
+	srv_client_fd = accept(srv_fd, (struct sockaddr *)&peer_addr, &len);
+	if (!ASSERT_GE(srv_client_fd, 0, "accept"))
+		goto end;
+	if (!ASSERT_EQ(len, sizeof(struct sockaddr_in), "sockaddr len"))
+		goto end;
+
+	skel->bss->saddr = peer_addr.sin_addr.s_addr;
+	skel->bss->sport = peer_addr.sin_port;
+	skel->bss->daddr = peer_addr.sin_addr.s_addr;
+	skel->bss->dport = htons(srv_port);
+
 	if (mode == TEST_XDP)
 		prog_fd = bpf_program__fd(skel->progs.nf_xdp_ct_test);
 	else
@@ -63,7 +113,16 @@ static void test_bpf_nf_ct(int mode)
 	ASSERT_LE(skel->bss->test_delta_timeout, 10, "Test for max ct timeout update");
 	/* expected status is IPS_SEEN_REPLY */
 	ASSERT_EQ(skel->bss->test_status, 2, "Test for ct status update ");
+	ASSERT_EQ(skel->data->test_exist_lookup, 0, "Test existing connection lookup");
 end:
+	if (srv_client_fd != -1)
+		close(srv_client_fd);
+	if (client_fd != -1)
+		close(client_fd);
+	if (srv_fd != -1)
+		close(srv_fd);
+	snprintf(cmd, sizeof(cmd), iptables, "-D");
+	system(cmd);
 	test_bpf_nf__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 196cd8dfe42a..84e0fd479794 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -23,6 +23,11 @@ int test_insert_entry = -EAFNOSUPPORT;
 int test_succ_lookup = -ENOENT;
 u32 test_delta_timeout = 0;
 u32 test_status = 0;
+__be32 saddr = 0;
+__be16 sport = 0;
+__be32 daddr = 0;
+__be16 dport = 0;
+int test_exist_lookup = -ENOENT;
 
 struct nf_conn;
 
@@ -160,6 +165,19 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 		}
 		test_alloc_entry = 0;
 	}
+
+	bpf_tuple.ipv4.saddr = saddr;
+	bpf_tuple.ipv4.daddr = daddr;
+	bpf_tuple.ipv4.sport = sport;
+	bpf_tuple.ipv4.dport = dport;
+	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
+		       sizeof(opts_def));
+	if (ct) {
+		test_exist_lookup = 0;
+		bpf_ct_release(ct);
+	} else {
+		test_exist_lookup = opts_def.error;
+	}
 }
 
 SEC("xdp")
-- 
2.37.1

