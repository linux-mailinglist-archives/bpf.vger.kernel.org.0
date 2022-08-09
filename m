Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5E58DC2D
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbiHIQfL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245106AbiHIQfE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:35:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648BB20BD1;
        Tue,  9 Aug 2022 09:35:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 246EE3200918;
        Tue,  9 Aug 2022 12:35:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 09 Aug 2022 12:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1660062901; x=1660149301; bh=nL
        ro8cQBeWjBQVLKe9zdq8YjGojgw6Hz8KTza5GUtTo=; b=Fx8mxLmse48CzD012y
        Ru/EmnZJwWb8wd5VtWnckZFWzfZUpXaGHj5xHY6uUT22zfbyXYFbU84pwdHWG50l
        KPM67Dcs+9sAIYWEr5+kwC2RW2G1acbUDhSY4jftAxhoFsR2pzdqsZtyNXqQ/LHK
        Tnb9RfIqBpUH2wTx3N4w6hqAqnM+7KJHQotwxWKtu1cJOffH6p8SAZfJ6FxgH8In
        9BkXoiCIuFSGDyBquKXaatKQd4jy29IlwFSRFyNt2+kU4cR3iIaJK3hHPJU3V7SI
        sWKcMtsEHbSnY/NBoclWXb+HbmrjxBWmEYx/PtAzSaSofd8EyhZSABZpUWpYttbi
        qZdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660062901; x=1660149301; bh=nLro8cQBeWjBQ
        VLKe9zdq8YjGojgw6Hz8KTza5GUtTo=; b=uZETU2Hp+WkSx6Q5CWBJyoB7Jf40Q
        hMcKPTdx3rqDEuLfULPLXkWqdPRQP7xV3mo9W5ciDkWWaUVI7B7s5Yqq98o9j7fs
        tPwh718GKdU5Dus8JUxplbldn4DONLOBrbY73hRH52EGb8RRkc8He0HbSSOKbl34
        lwrw6ZZrfzhGcJU7MCHGA8piDrlgUZcImTYsYxC1/iBSN5YcqreRfoCVB0YIIgrb
        HPWqbwXrYYeYC6EPwH1nu863vEnayc4Gm0vm6m1JQwMeUN78/dtWu7e14EhvW45m
        Xwhov4sRYhKNLQtgI4/A6LfPi6ZGRl6D1T0jsCkc6ADyN2CV2gKx3RB6g==
X-ME-Sender: <xms:tYzyYjL12iOXo_GWyb5Nr0dGkcEHJ83BjYh93iOmKqzUFHi6riu-bw>
    <xme:tYzyYnJuk6q3YA_97yq1-JTTT21hTdeVfgvEteflp2o8EuMHmHHOKAmeF_BQoShL2
    4ay51E3FLCvUoqQXA>
X-ME-Received: <xmr:tYzyYrvKeLrsd4TNDMVeXBAbN_mvc4OQ6YjiD7rAWTKQz7Y4pZQXZwJzXCgRDDjsINM_K8qEuys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:tYzyYsa_2T4aGwqiaeo4TqPtDeh3sT9DepcTNahNsbEaZG4QutxthA>
    <xmx:tYzyYqZPzh9qzjlIxPrP0Lqybxgp2d63n_90vn2PRCALNMs-ZiOMZw>
    <xmx:tYzyYgCqVciMj4LZV9dPsx2WBVEQy5yWFeTjaiOG8oh8ApqfSZhkIg>
    <xmx:tYzyYhwGZjDJEY_WuQCnB9NHQi6acUl9fNwpZCb-3EuGW0BhXzhhdg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 12:35:00 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add connmark read test
Date:   Tue,  9 Aug 2022 10:34:42 -0600
Message-Id: <6436220efacfa99f343ffc451e3d5dc8b7f31f05.1660062725.git.dxu@dxuuu.xyz>
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

