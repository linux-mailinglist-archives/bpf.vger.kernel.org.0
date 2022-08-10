Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0D58F4BF
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 01:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiHJXRE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 19:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHJXRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 19:17:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364477B1F8;
        Wed, 10 Aug 2022 16:17:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 97AC15C01AC;
        Wed, 10 Aug 2022 19:17:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 Aug 2022 19:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1660173420; x=1660259820; bh=nL
        ro8cQBeWjBQVLKe9zdq8YjGojgw6Hz8KTza5GUtTo=; b=Wn1vjlNdRaLgf7kLcD
        2CM1ZKpo88GXRpevHRfjczRnX2tPu87G1nZxhM8ejr8Ov/Ty/5ZnhGU0sRk8gK1b
        8u6t0Hq7yiOiMBw4iiEYEFYGiJMCc5FPhzZLTa5bDFK4kYuuxy1D4hCt1VeuIK55
        ouYnioOxSjcpno1RzOCBzjJlNe0E0J3t3/zQPx2aIndZRQKTw95vYKtrOS3xSB8S
        8Pj2h3ecVyT19G0tqCys6ydxELVX2PnaHUntz8MFMyhrQ+3094ePRkt3hFJRBgYU
        otYYzXhkGXx2+kYcMA4mcwxyF+gLOvY+bGeveQFfQ0QwS6gFbkyLhmKXTT3dpTyo
        cTFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660173420; x=1660259820; bh=nLro8cQBeWjBQ
        VLKe9zdq8YjGojgw6Hz8KTza5GUtTo=; b=RQCmIQapsxpdbL8+B+5/lbraB0Xu5
        TSMYK4hDMGrtjouXPmPSIO/wsJ8hDfisEn4m4XPQ4nPLLcznTTrZfGTiV6REQ1gB
        fYawrPIVa2wb+qtR7dE00iitMtCacoh02q4Uz/n/IsGQIx14prFnxIMbfcN3fRVE
        smAW3LBU776K03PLwCnnLOmk+JMiK2osGAgrOEyl13yGNUPHEGYZpMESonPhqupj
        c2gTeZGgUNGGQ3TWMenoMYIUg7kjyja3OybA9DODlhj6XCFzYzCGMdMkVRS/u6vP
        49VS7mec58ljK3JB3WfsEqj6qvhfjJZCD6lmQ4xszI+sLR/EcVsRGphig==
X-ME-Sender: <xms:bDz0YtsbF5VaX5AvoJdcrsqg7m8hpeQJZFTd-vVZUYqgAzERoXX6ig>
    <xme:bDz0Yme6tx06LOeS3CEebCbqtR_-Wf14RyTULeTHAVAF8IcNzvq_L4wWr0bcnvXom
    aZOWNfPI1WiGlzgfg>
X-ME-Received: <xmr:bDz0YgxAB9ljAL4Njzsqv96AEjJAnezm5hU3jekzdvgChfupMqii3WGi3M4fvqsB1sA9GsdgC-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegfedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:bDz0YkN5lKPLXOcCjXSoXbvLGEBO-8gc_bGdaJak75QGaE_a2scfZg>
    <xmx:bDz0Yt-XMSuLsJJxFIkBXkOoHKjnw2Mr1ugqyZBJ7mBOWF0xrN8Xeg>
    <xmx:bDz0YkWgCteEIMY7vvM8dNy-rBfprrzw56QU2waEaBgtSqsi5vPylw>
    <xmx:bDz0YgkXMRrUX5UvpBZKSeSjGi6ZZ_b78BVGjTpq7_QjnOVQhbBS0A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 19:16:59 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Add connmark read test
Date:   Wed, 10 Aug 2022 17:16:43 -0600
Message-Id: <912801642acb4ec3719a46af723accd775a2ecd5.1660173222.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660173222.git.dxu@dxuuu.xyz>
References: <cover.1660173222.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test that the prog can read from the connection mark. This test is nice
because it ensures progs can interact with netfilter subsystem
correctly.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 3 ++-
 tools/testing/selftests/bpf/progs/test_bpf_nf.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index 317978cac029..7232f6dcd252 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -44,7 +44,7 @@ static int connect_to_server(int srv_fd)
 
 static void test_bpf_nf_ct(int mode)
 {
-	const char *iptables = "iptables -t raw %s PREROUTING -j CT";
+	const char *iptables = "iptables -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
 	int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
 	struct sockaddr_in peer_addr = {};
 	struct test_bpf_nf *skel;
@@ -114,6 +114,7 @@ static void test_bpf_nf_ct(int mode)
 	/* expected status is IPS_SEEN_REPLY */
 	ASSERT_EQ(skel->bss->test_status, 2, "Test for ct status update ");
 	ASSERT_EQ(skel->data->test_exist_lookup, 0, "Test existing connection lookup");
+	ASSERT_EQ(skel->bss->test_exist_lookup_mark, 43, "Test existing connection lookup ctmark");
 end:
 	if (srv_client_fd != -1)
 		close(srv_client_fd);
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 84e0fd479794..2722441850cc 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -28,6 +28,7 @@ __be16 sport = 0;
 __be32 daddr = 0;
 __be16 dport = 0;
 int test_exist_lookup = -ENOENT;
+u32 test_exist_lookup_mark = 0;
 
 struct nf_conn;
 
@@ -174,6 +175,8 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 		       sizeof(opts_def));
 	if (ct) {
 		test_exist_lookup = 0;
+		if (ct->mark == 42)
+			test_exist_lookup_mark = 43;
 		bpf_ct_release(ct);
 	} else {
 		test_exist_lookup = opts_def.error;
-- 
2.37.1

