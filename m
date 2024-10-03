Return-Path: <bpf+bounces-40855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10DE98F5C7
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D877282039
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A91AB6DC;
	Thu,  3 Oct 2024 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GhLZSLgI"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237F1A76CF;
	Thu,  3 Oct 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978613; cv=none; b=qjMdUuaud5n7fK2XiaBOX4azDgT9Zh1YI1UI65igjgFVwuMxsUJGEAWijgNBzIS/nnIqOULyjGrGdLsjL5lQj4CeqM6bYoCEx5UnM1GCSV8G4Fk9mQHKtMYo9MaANK1MTA/ibEHcwG7c4lSypkXINhIJFZFPV7g3/FqtubGn9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978613; c=relaxed/simple;
	bh=pIATfDLY3eHxDv/6Tju+aPh4JAyq6y/R1hh+kz+4sMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s926FBMEGCvfdQ1oZBe+31atnFtxZWuP+g4WlAVEvoN30DRI7wjjSJhprqNZ0/iUI0HKKd4ijlwZwH4IlAI+k5hPcABJdbAOA2AycWNhMG+xaQ0HVa11ZXEGMkuqKAJDa6wdtKvQzldxE07eS6rpUJbpwCal0IzEcsTaxGBEyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GhLZSLgI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=trdebJaQoOOg2KNHBWb6sySsRrnLfnR9Du3D0sqwzd8=; b=GhLZSLgIH0OmJfpZnQGAvwXtg4
	Nw3bBmng02OmQfQ7tack/EpLY00uYpB9/fi5qKND3sY1z4ZbRxUQ7vjFk/BkLXJKxpV2yGKXr/Bna
	BXV905d+5ZdiROigFW1yCJ9w5cmY/j4olT/oaJsdAm9iLDiJsFrEhc5xpTnHcBc+9cwKj++ApKSLS
	FNY6LK9MxsiIllydA7NYVphr4Q/y95XYsdJLghJiNtYgeICGZnAg7f6R7LjOJngsDAiV1N4puZkhf
	6LOWDKPgrlzWpCZvr1+LyhFhBKtOUVUx3SeAu4g2S/niafmEcod2Wp/tAfax6rYtLzy20qlzQ52vX
	2UmtKseQ==;
Received: from 44.249.197.178.dynamic.cust.swisscom.net ([178.197.249.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swQAd-0006Dv-IL; Thu, 03 Oct 2024 20:03:23 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	jrife@google.com,
	tangchen.1@bytedance.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: Extend netkit tests to validate skb meta data
Date: Thu,  3 Oct 2024 20:03:20 +0200
Message-Id: <20241003180320.113002-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003180320.113002-1-daniel@iogearbox.net>
References: <20241003180320.113002-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27416/Thu Oct  3 10:37:25 2024)

Add a small netkit test to validate skb mark and priority under the
default scrubbing as well as with mark and priority scrubbing off.

  # ./vmtest.sh -- ./test_progs -t netkit
  [...]
  ./test_progs -t netkit
  [    1.419662] tsc: Refined TSC clocksource calibration: 3407.993 MHz
  [    1.420151] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcd52370, max_idle_ns: 440795242006 ns
  [    1.420897] clocksource: Switched to clocksource tsc
  [    1.447996] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.448447] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #357     tc_netkit_basic:OK
  #358     tc_netkit_device:OK
  #359     tc_netkit_multi_links:OK
  #360     tc_netkit_multi_opts:OK
  #361     tc_netkit_neigh_links:OK
  #362     tc_netkit_pkt_type:OK
  #363     tc_netkit_scrub:OK
  Summary: 7/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_netkit.c      | 94 +++++++++++++++++--
 .../selftests/bpf/progs/test_tc_link.c        | 12 +++
 2 files changed, 97 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index b9135720024c..6c49b67155b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -14,7 +14,9 @@
 #include "netlink_helpers.h"
 #include "tc_helpers.h"
 
-#define ICMP_ECHO 8
+#define MARK		42
+#define PRIO		0xeb9f
+#define ICMP_ECHO	8
 
 struct icmphdr {
 	__u8		type;
@@ -33,7 +35,7 @@ struct iplink_req {
 };
 
 static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
-			 bool same_netns)
+			 bool same_netns, int scrub, int peer_scrub)
 {
 	struct rtnl_handle rth = { .fd = -1 };
 	struct iplink_req req = {};
@@ -58,6 +60,8 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
 	data = addattr_nest(&req.n, sizeof(req), IFLA_INFO_DATA);
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_POLICY, policy);
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_PEER_POLICY, peer_policy);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_SCRUB, scrub);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_PEER_SCRUB, peer_scrub);
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, mode);
 	addattr_nest_end(&req.n, data);
 	addattr_nest_end(&req.n, linkinfo);
@@ -118,9 +122,9 @@ static void destroy_netkit(void)
 
 static int __send_icmp(__u32 dest)
 {
+	int sock, ret, mark = MARK, prio = PRIO;
 	struct sockaddr_in addr;
 	struct icmphdr icmp;
-	int sock, ret;
 
 	ret = write_sysctl("/proc/sys/net/ipv4/ping_group_range", "0 0");
 	if (!ASSERT_OK(ret, "write_sysctl(net.ipv4.ping_group_range)"))
@@ -135,6 +139,15 @@ static int __send_icmp(__u32 dest)
 	if (!ASSERT_OK(ret, "setsockopt(SO_BINDTODEVICE)"))
 		goto out;
 
+	ret = setsockopt(sock, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
+	if (!ASSERT_OK(ret, "setsockopt(SO_MARK)"))
+		goto out;
+
+	ret = setsockopt(sock, SOL_SOCKET, SO_PRIORITY,
+			 &prio, sizeof(prio));
+	if (!ASSERT_OK(ret, "setsockopt(SO_PRIORITY)"))
+		goto out;
+
 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = htonl(dest);
@@ -171,7 +184,8 @@ void serial_test_tc_netkit_basic(void)
 	int err, ifindex;
 
 	err = create_netkit(NETKIT_L2, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false);
+			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT);
 	if (err)
 		return;
 
@@ -285,7 +299,8 @@ static void serial_test_tc_netkit_multi_links_target(int mode, int target)
 	int err, ifindex;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false);
+			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT);
 	if (err)
 		return;
 
@@ -413,7 +428,8 @@ static void serial_test_tc_netkit_multi_opts_target(int mode, int target)
 	int err, ifindex;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false);
+			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT);
 	if (err)
 		return;
 
@@ -527,7 +543,8 @@ void serial_test_tc_netkit_device(void)
 	int err, ifindex, ifindex2;
 
 	err = create_netkit(NETKIT_L3, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, true);
+			    &ifindex, true, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT);
 	if (err)
 		return;
 
@@ -638,7 +655,8 @@ static void serial_test_tc_netkit_neigh_links_target(int mode, int target)
 	int err, ifindex;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false);
+			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT);
 	if (err)
 		return;
 
@@ -715,7 +733,8 @@ static void serial_test_tc_netkit_pkt_type_mode(int mode)
 	struct bpf_link *link;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, true);
+			    &ifindex, true, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT);
 	if (err)
 		return;
 
@@ -779,3 +798,60 @@ void serial_test_tc_netkit_pkt_type(void)
 	serial_test_tc_netkit_pkt_type_mode(NETKIT_L2);
 	serial_test_tc_netkit_pkt_type_mode(NETKIT_L3);
 }
+
+void serial_test_tc_netkit_scrub_type(int scrub)
+{
+	LIBBPF_OPTS(bpf_netkit_opts, optl);
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, ifindex;
+
+	err = create_netkit(NETKIT_L2, NETKIT_PASS, NETKIT_PASS,
+			    &ifindex, false, scrub, scrub);
+	if (err)
+		return;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc8,
+		  BPF_NETKIT_PRIMARY), 0, "tc8_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PRIMARY, 0);
+	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PEER, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc8, false, "seen_tc8");
+
+	link = bpf_program__attach_netkit(skel->progs.tc8, ifindex, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc8 = link;
+
+	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PRIMARY, 1);
+	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PEER, 0);
+
+	tc_skel_reset_all_seen(skel);
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc8, true, "seen_tc8");
+	ASSERT_EQ(skel->bss->mark, scrub == NETKIT_SCRUB_NONE ? MARK : 0, "mark");
+	ASSERT_EQ(skel->bss->prio, scrub == NETKIT_SCRUB_NONE ? PRIO : 0, "prio");
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PRIMARY, 0);
+	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PEER, 0);
+	destroy_netkit();
+}
+
+void serial_test_tc_netkit_scrub(void)
+{
+	serial_test_tc_netkit_scrub_type(NETKIT_SCRUB_DEFAULT);
+	serial_test_tc_netkit_scrub_type(NETKIT_SCRUB_NONE);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
index ab3eae3d6af8..10d825928499 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_link.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
@@ -18,6 +18,7 @@ bool seen_tc4;
 bool seen_tc5;
 bool seen_tc6;
 bool seen_tc7;
+bool seen_tc8;
 
 bool set_type;
 
@@ -25,6 +26,8 @@ bool seen_eth;
 bool seen_host;
 bool seen_mcast;
 
+int mark, prio;
+
 SEC("tc/ingress")
 int tc1(struct __sk_buff *skb)
 {
@@ -100,3 +103,12 @@ int tc7(struct __sk_buff *skb)
 	seen_tc7 = true;
 	return TCX_PASS;
 }
+
+SEC("tc/egress")
+int tc8(struct __sk_buff *skb)
+{
+	seen_tc8 = true;
+	mark = skb->mark;
+	prio = skb->priority;
+	return TCX_PASS;
+}
-- 
2.43.0


