Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95005585BCC
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiG3Tkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jul 2022 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiG3Tko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jul 2022 15:40:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668FA167F0;
        Sat, 30 Jul 2022 12:40:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A00425C00D7;
        Sat, 30 Jul 2022 15:40:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 30 Jul 2022 15:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659210041; x=1659296441; bh=WZ
        EQVb7LXNaO/V7wO/BS4WbF6FIQfaAKzTUD9UnPU88=; b=nCc5TsYiptdA2M6PJF
        /IZ/6cDakk+ZYu63BBwesYGAlTraAsT/cb47g3ewJTckQ/c5kk+en9xrKOvFd0Ne
        3fSinalPLP1lxeEL6eoO0YSTp5MclrEMo/tBks/BfC4FxGkDYwivXBXd2C8zniaS
        2v8kni7819RyEfg2lLj7vGTMvNK3FE8vSJgTOOsqc31FiREdkqitWC1yd6I7qOAs
        wAPN36M4iECgATDXWfvmZVQwPML4VYnNwpLeM9ODKFX2aYHTG1Vr9HHkknUUXZPJ
        QZ6iMGBAQZWAX8VwLl8SenilNxzduaDmL8oaFXARU6x/45eTOCS53c+Bp+EvHuDq
        kQLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659210041; x=1659296441; bh=WZEQVb7LXNaO/
        V7wO/BS4WbF6FIQfaAKzTUD9UnPU88=; b=hmecbVcu6+DwL+6Ykv/60ipkcmeoU
        mJcOCFOHf6vgxk0rq7tPsM1UdOW4nfoeXSieURnbMW2xsfViWaVG0X8EN5A4L4v0
        JnUWYuhDJV1WxE+INRtK5ee1SBdt5gudqn0dFXx4lH9W6MbUhF4ehwdOj35xln+X
        0DmjgRr/WCCsF5Z71VV4nS1XZTpZzlMp4tLmUu5nZwJjS3aTNYQ612TV/wg831iM
        01sRLCQmHl1tjH8Stdc1OeoZV8MbkwJLm5yhG+JRVhIj++8C5FCwMGOKbB6lSXrX
        A5rPODtU/9RsXtbwfkcAxC915s9YFr9dve0zYEfCqO0zZ9/WeFQg4aJfw==
X-ME-Sender: <xms:OYnlYr6UrHpIMQUMRXJCZ-VTdfjocZadbyJnldf5xD7X8URmVzQFaA>
    <xme:OYnlYg4lPHRmqEgtsiY6bVSwgSkEFBoBgznumymSpBuIdSiFD60I9fJGGg6KpnB2L
    s-SzR7z6WpPEjU62A>
X-ME-Received: <xmr:OYnlYiezLss8SbRovMHhtT8_Qsqd6vkWZ8TFN5lClq1iexDdvZgXgWpi02kXtodxyJy0Oflpd_we>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduledgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:OYnlYsK9rrb-NL_aQgOiqxb6Lv6MZ8EFui4hj-j19FYpky9k5Z27iA>
    <xmx:OYnlYvLb_i3BLpfc7gpB6gc3EvL4dCa4x916emA3e5dufAy8PeMBKA>
    <xmx:OYnlYlyuHa_eKBSqoNdikZ0rZcNW6w1rVKgjpET1gItgv1t2J9d1Ww>
    <xmx:OYnlYlhjp91_pYO7r9Dlbsq2Jmv0t9tWMEO02sVBbxNI_kHaN0g9-g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Jul 2022 15:40:40 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add connmark read/write test
Date:   Sat, 30 Jul 2022 14:40:30 -0500
Message-Id: <abd424ee71675e3008acd4a2c1fd136cb7dbf8be.1659209738.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659209738.git.dxu@dxuuu.xyz>
References: <cover.1659209738.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test that the prog can read/write to/from the connection mark. This
test is nice because it ensures progs can interact with netfilter
subsystem correctly.

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

