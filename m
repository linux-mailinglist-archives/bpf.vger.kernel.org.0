Return-Path: <bpf+bounces-30513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8768CE8C9
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65EF283D3D
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD712FF99;
	Fri, 24 May 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aQeGtdlJ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47312DD88;
	Fri, 24 May 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568586; cv=none; b=YvshMlTxtrw7gi7menCvVtETAKsa22L0lbNtaWZaeWJIErV8LHaFvOwXXYeqqLXwFPAEnLqq+vPJThbi3RojfFxsqMwxtdoGj2uAHBHfLnNhWIHt88HHNHMRkGV4nIZX3ENx1DROxWpf/ycLXsJUPJJ6rdmi8V6K8U9EBkqoQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568586; c=relaxed/simple;
	bh=vYhoh7Evj7fvL1CpiTXfGuR9JwaZc/s4zd1AFHbg7ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojDXOEl/iOYxmeLAXV3vD2azD8yVK3rngl9nZC2EyXFEOTSAkQR5E7G3dEOWA+zWoVj6AjGgEP+d7OklZUBjgzlDBqZRuNHQj8mqbIfMdPydbTKZVUdDsbcQXXYIaF/RXSstGJbKghFfgdffX0swUk3t8YFqgO1KB84b6GVERwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=aQeGtdlJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bYID8mnHlzGQBZlKz8yvAL4VKhIqNcWB0PTYfqywLwQ=; b=aQeGtdlJ0ZyP6CLHDkb+09g7X0
	Q9w1H2QSd3pnLibRqTW/a7ncnMuF9WXIOWpw3dIIrnfqAfnt1Pm62yPiyJAMEBdwR4490j4Lhiycn
	VtlbgDJiHDAoQmfhJN3iC2mPiS22YN/orysjUs6moEv3RACkxoh5+GRcWHRcgUr86EO8mk9oWxg5h
	XfJOLxZ2qX8ybFXtulV7R6DrurgOICZDnYUqsv9mCLnGNm3pY1Pe+IWHTOQWsTcbGezzxBEB2ZMvI
	N7alkCLRzJVWRLO0Svmz9wag/GBdIASPyZoXSYwAsNWD4Mgdkab4DJRfPDzO2whpDKgA/LqsQukYL
	e4cIFbZA==;
Received: from 14.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.14] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXu3-000IRq-2d; Fri, 24 May 2024 18:36:23 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 4/4] selftests/bpf: Add netkit test for pkt_type
Date: Fri, 24 May 2024 18:36:19 +0200
Message-Id: <20240524163619.26001-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240524163619.26001-1-daniel@iogearbox.net>
References: <20240524163619.26001-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

Add a test case to assert that the skb->pkt_type which was set from the BPF
program is retained from the netkit xmit side to the peer's device at tcx
ingress location.

  # ./vmtest.sh -- ./test_progs -t netkit
  [...]
  ./test_progs -t netkit
  [    1.140780] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.141127] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  [    1.284601] tsc: Refined TSC clocksource calibration: 3408.006 MHz
  [    1.286672] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd9b189d, max_idle_ns: 440795225691 ns
  [    1.290384] clocksource: Switched to clocksource tsc
  #345     tc_netkit_basic:OK
  #346     tc_netkit_device:OK
  #347     tc_netkit_multi_links:OK
  #348     tc_netkit_multi_opts:OK
  #349     tc_netkit_neigh_links:OK
  #350     tc_netkit_pkt_type:OK
  Summary: 6/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_netkit.c      | 84 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_link.c        | 33 ++++++++
 2 files changed, 117 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index 18b2e969a456..b9135720024c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -99,6 +99,16 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
 	return err;
 }
 
+static void move_netkit(void)
+{
+	ASSERT_OK(system("ip link set " netkit_peer " netns foo"),
+			 "move peer");
+	ASSERT_OK(system("ip netns exec foo ip link set dev "
+			 netkit_peer " up"), "up peer");
+	ASSERT_OK(system("ip netns exec foo ip addr add dev "
+			 netkit_peer " 10.0.0.2/24"), "addr peer");
+}
+
 static void destroy_netkit(void)
 {
 	ASSERT_OK(system("ip link del dev " netkit_name), "del primary");
@@ -695,3 +705,77 @@ void serial_test_tc_netkit_neigh_links(void)
 	serial_test_tc_netkit_neigh_links_target(NETKIT_L2, BPF_NETKIT_PRIMARY);
 	serial_test_tc_netkit_neigh_links_target(NETKIT_L3, BPF_NETKIT_PRIMARY);
 }
+
+static void serial_test_tc_netkit_pkt_type_mode(int mode)
+{
+	LIBBPF_OPTS(bpf_netkit_opts, optl_nk);
+	LIBBPF_OPTS(bpf_tcx_opts, optl_tcx);
+	int err, ifindex, ifindex2;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+
+	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
+			    &ifindex, true);
+	if (err)
+		return;
+
+	ifindex2 = if_nametoindex(netkit_peer);
+	ASSERT_NEQ(ifindex, ifindex2, "ifindex_1_2");
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1,
+		  BPF_NETKIT_PRIMARY), 0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc7,
+		  BPF_TCX_INGRESS), 0, "tc7_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	assert_mprog_count_ifindex(ifindex,  BPF_NETKIT_PRIMARY, 0);
+	assert_mprog_count_ifindex(ifindex2, BPF_TCX_INGRESS, 0);
+
+	link = bpf_program__attach_netkit(skel->progs.tc1, ifindex, &optl_nk);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	assert_mprog_count_ifindex(ifindex,  BPF_NETKIT_PRIMARY, 1);
+	assert_mprog_count_ifindex(ifindex2, BPF_TCX_INGRESS, 0);
+
+	link = bpf_program__attach_tcx(skel->progs.tc7, ifindex2, &optl_tcx);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc7 = link;
+
+	assert_mprog_count_ifindex(ifindex,  BPF_NETKIT_PRIMARY, 1);
+	assert_mprog_count_ifindex(ifindex2, BPF_TCX_INGRESS, 1);
+
+	move_netkit();
+
+	tc_skel_reset_all_seen(skel);
+	skel->bss->set_type = true;
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc7, true, "seen_tc7");
+
+	ASSERT_EQ(skel->bss->seen_host,  true, "seen_host");
+	ASSERT_EQ(skel->bss->seen_mcast, true, "seen_mcast");
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count_ifindex(ifindex,  BPF_NETKIT_PRIMARY, 0);
+	destroy_netkit();
+}
+
+void serial_test_tc_netkit_pkt_type(void)
+{
+	serial_test_tc_netkit_pkt_type_mode(NETKIT_L2);
+	serial_test_tc_netkit_pkt_type_mode(NETKIT_L3);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
index 992400acb957..b64fcb70ef2f 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_link.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
@@ -4,6 +4,7 @@
 
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
+#include <linux/if_packet.h>
 
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
@@ -16,7 +17,13 @@ bool seen_tc3;
 bool seen_tc4;
 bool seen_tc5;
 bool seen_tc6;
+bool seen_tc7;
+
+bool set_type;
+
 bool seen_eth;
+bool seen_host;
+bool seen_mcast;
 
 SEC("tc/ingress")
 int tc1(struct __sk_buff *skb)
@@ -28,8 +35,16 @@ int tc1(struct __sk_buff *skb)
 	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)))
 		goto out;
 	seen_eth = eth.h_proto == bpf_htons(ETH_P_IP);
+	seen_host = skb->pkt_type == PACKET_HOST;
+	if (seen_host && set_type) {
+		eth.h_dest[0] = 4;
+		if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0))
+			goto fail;
+		bpf_skb_change_type(skb, PACKET_MULTICAST);
+	}
 out:
 	seen_tc1 = true;
+fail:
 	return TCX_NEXT;
 }
 
@@ -67,3 +82,21 @@ int tc6(struct __sk_buff *skb)
 	seen_tc6 = true;
 	return TCX_PASS;
 }
+
+SEC("tc/ingress")
+int tc7(struct __sk_buff *skb)
+{
+	struct ethhdr eth = {};
+
+	if (skb->protocol != __bpf_constant_htons(ETH_P_IP))
+		goto out;
+	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)))
+		goto out;
+	if (eth.h_dest[0] == 4 && set_type) {
+		seen_mcast = skb->pkt_type == PACKET_MULTICAST;
+		bpf_skb_change_type(skb, PACKET_HOST);
+	}
+out:
+	seen_tc7 = true;
+	return TCX_PASS;
+}
-- 
2.34.1


