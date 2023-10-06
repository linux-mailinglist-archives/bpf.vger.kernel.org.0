Return-Path: <bpf+bounces-11586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F47BC203
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AECC282630
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB365450E7;
	Fri,  6 Oct 2023 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NOwgjU2C"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B65450EB
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:07:13 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C093CA
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+ubIxpjophnDAOfZM1nZXyfSujj9sB7JjWRKoRjLNHo=; b=NOwgjU2CjKgzYxgDbT9CJCfW2i
	5Q1sj46ZZrmr4zhFvGAAgtVrVzwf4VYe7bJ4EDjExH3HJTynVtZr98Zawf3Rhv5Ps7dHNOiQ2LMzg
	jIC7jhSDxfQgO1EOBWywoq0oneLRyKRhoTTWvi26WVgfEJUp9N9gfo+pa6Vgi0eZI7Wu7sc7Bm1s6
	JcQmmJp7t0aUtN3uyw5j/1rSAgEGrHA0OvwCV0sitix8dHjl7lqOnhXb4qBtB1JnmpbDzgnGGL14O
	L3rznDdyAi1g0sozUFwA+DHuIGXjloLqKXQtuYZkYXjHCoT/z1t3xFzg3wm025j059taix9Ty98Bf
	15ne2oRg==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qosyS-0001ki-78; Sat, 07 Oct 2023 00:07:08 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: lmb@isovalent.com,
	martin.lau@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 7/7] selftests/bpf: Make seen_tc* variable tests more robust
Date: Sat,  7 Oct 2023 00:06:55 +0200
Message-Id: <20231006220655.1653-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231006220655.1653-1-daniel@iogearbox.net>
References: <20231006220655.1653-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Martin reported that on his local dev machine the test_tc_chain_mixed() fails as
"test_tc_chain_mixed:FAIL:seen_tc5 unexpected seen_tc5: actual 1 != expected 0"
and others occasionally, too.

However, when running in a more isolated setup (qemu in particular), it works fine
for him. The reason is that there is a small race-window where seen_tc* could turn
into true for various test cases when there is background traffic, e.g. after the
asserts they often get reset. In such case when subsequent detach takes place,
unrelated background traffic could have already flipped the bool to true beforehand.

Add a small helper tc_skel_reset_all_seen() to reset all bools before we do the ping
test. At this point, everything is set up as expected and therefore no race can occur.
All tc_{opts,links} tests continue to pass after this change.

Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_helpers.h     |  5 ++
 .../selftests/bpf/prog_tests/tc_links.c       | 62 +++++++------------
 .../selftests/bpf/prog_tests/tc_opts.c        | 39 ++++++------
 3 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
index c88dce27a958..67f985f7d215 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
@@ -66,4 +66,9 @@ static inline void assert_mprog_count_ifindex(int ifindex, int target, int expec
 	__assert_mprog_count(target, expected, ifindex);
 }
 
+static inline void tc_skel_reset_all_seen(struct test_tc_link *skel)
+{
+	memset(skel->bss, 0, sizeof(*skel->bss));
+}
+
 #endif /* TC_HELPERS */
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 073fbdbea968..bc9841144685 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -65,6 +65,7 @@ void serial_test_tc_links_basic(void)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -97,6 +98,7 @@ void serial_test_tc_links_basic(void)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -187,6 +189,7 @@ static void test_tc_links_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -194,9 +197,6 @@ static void test_tc_links_before_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-
 	LIBBPF_OPTS_RESET(optl,
 		.flags = BPF_F_BEFORE,
 		.relative_fd = bpf_program__fd(skel->progs.tc2),
@@ -246,6 +246,7 @@ static void test_tc_links_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -342,6 +343,7 @@ static void test_tc_links_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -349,9 +351,6 @@ static void test_tc_links_after_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-
 	LIBBPF_OPTS_RESET(optl,
 		.flags = BPF_F_AFTER,
 		.relative_fd = bpf_program__fd(skel->progs.tc1),
@@ -401,6 +400,7 @@ static void test_tc_links_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -502,6 +502,7 @@ static void test_tc_links_revision_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -581,22 +582,20 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 	assert_mprog_count(target, 2);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	err = bpf_link__detach(skel->links.tc2);
 	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup;
 
 	assert_mprog_count(target, 1);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -707,16 +706,13 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	LIBBPF_OPTS_RESET(optl,
 		.flags = BPF_F_REPLACE,
 		.relative_fd = bpf_program__fd(skel->progs.tc2),
@@ -781,16 +777,13 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	err = bpf_link__detach(skel->links.tc2);
 	if (!ASSERT_OK(err, "link_detach"))
 		goto cleanup;
@@ -812,16 +805,13 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	err = bpf_link__update_program(skel->links.tc1, skel->progs.tc1);
 	if (!ASSERT_OK(err, "link_update_self"))
 		goto cleanup;
@@ -843,6 +833,7 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1254,6 +1245,7 @@ static void test_tc_links_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1261,9 +1253,6 @@ static void test_tc_links_prepend_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-
 	LIBBPF_OPTS_RESET(optl,
 		.flags = BPF_F_BEFORE,
 	);
@@ -1311,6 +1300,7 @@ static void test_tc_links_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1411,6 +1401,7 @@ static void test_tc_links_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1418,9 +1409,6 @@ static void test_tc_links_append_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-
 	LIBBPF_OPTS_RESET(optl,
 		.flags = BPF_F_AFTER,
 	);
@@ -1468,6 +1456,7 @@ static void test_tc_links_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1637,38 +1626,33 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 1);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
 	ASSERT_EQ(skel->bss->seen_tc5, false, "seen_tc5");
 	ASSERT_EQ(skel->bss->seen_tc6, true, "seen_tc6");
 
-	skel->bss->seen_tc4 = false;
-	skel->bss->seen_tc5 = false;
-	skel->bss->seen_tc6 = false;
-
 	err = bpf_link__update_program(skel->links.tc6, skel->progs.tc4);
 	if (!ASSERT_OK(err, "link_update"))
 		goto cleanup;
 
 	assert_mprog_count(target, 1);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
 	ASSERT_EQ(skel->bss->seen_tc5, true, "seen_tc5");
 	ASSERT_EQ(skel->bss->seen_tc6, false, "seen_tc6");
 
-	skel->bss->seen_tc4 = false;
-	skel->bss->seen_tc5 = false;
-	skel->bss->seen_tc6 = false;
-
 	err = bpf_link__detach(skel->links.tc6);
 	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup;
 
 	assert_mprog_count(target, 0);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
@@ -1758,22 +1742,20 @@ static void test_tc_links_ingress(int target, bool chain_tc_old,
 
 	assert_mprog_count(target, 2);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	err = bpf_link__detach(skel->links.tc2);
 	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup;
 
 	assert_mprog_count(target, 1);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index ba91b0226839..ca506d2fcf58 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -59,6 +59,7 @@ void serial_test_tc_opts_basic(void)
 	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -83,6 +84,7 @@ void serial_test_tc_opts_basic(void)
 	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -163,6 +165,7 @@ static void test_tc_opts_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -219,6 +222,7 @@ static void test_tc_opts_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id2, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -313,6 +317,7 @@ static void test_tc_opts_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -369,6 +374,7 @@ static void test_tc_opts_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -514,6 +520,7 @@ static void test_tc_opts_revision_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -608,22 +615,20 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 	assert_mprog_count(target, 2);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	err = bpf_prog_detach_opts(fd2, loopback, target, &optd);
 	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup_detach;
 
 	assert_mprog_count(target, 1);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -730,16 +735,13 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(optq.prog_attach_flags[1], 0, "prog_flags[1]");
 	ASSERT_EQ(optq.prog_attach_flags[2], 0, "prog_flags[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	LIBBPF_OPTS_RESET(opta,
 		.flags = BPF_F_REPLACE,
 		.replace_prog_fd = fd2,
@@ -767,16 +769,13 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
 
-	skel->bss->seen_tc1 = false;
-	skel->bss->seen_tc2 = false;
-	skel->bss->seen_tc3 = false;
-
 	LIBBPF_OPTS_RESET(opta,
 		.flags = BPF_F_REPLACE | BPF_F_BEFORE,
 		.replace_prog_fd = fd3,
@@ -805,6 +804,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1084,6 +1084,7 @@ static void test_tc_opts_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1124,6 +1125,7 @@ static void test_tc_opts_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id1, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1222,6 +1224,7 @@ static void test_tc_opts_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1262,6 +1265,7 @@ static void test_tc_opts_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -2316,16 +2320,13 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 1);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
 	ASSERT_EQ(skel->bss->seen_tc5, false, "seen_tc5");
 	ASSERT_EQ(skel->bss->seen_tc6, true, "seen_tc6");
 
-	skel->bss->seen_tc4 = false;
-	skel->bss->seen_tc5 = false;
-	skel->bss->seen_tc6 = false;
-
 	LIBBPF_OPTS_RESET(opta,
 		.flags = BPF_F_REPLACE,
 		.replace_prog_fd = fd3,
@@ -2339,21 +2340,19 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 1);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
 	ASSERT_EQ(skel->bss->seen_tc5, true, "seen_tc5");
 	ASSERT_EQ(skel->bss->seen_tc6, false, "seen_tc6");
 
-	skel->bss->seen_tc4 = false;
-	skel->bss->seen_tc5 = false;
-	skel->bss->seen_tc6 = false;
-
 cleanup_opts:
 	err = bpf_prog_detach_opts(detach_fd, loopback, target, &optd);
 	ASSERT_OK(err, "prog_detach");
 	assert_mprog_count(target, 0);
 
+	tc_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
-- 
2.34.1


