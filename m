Return-Path: <bpf+bounces-30484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1795F8CE59C
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C2E1F21FEE
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C740127B51;
	Fri, 24 May 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gKzxHv5i"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225184FCE;
	Fri, 24 May 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555692; cv=none; b=YVEKx317bJmKpwN42dBTOKiGwhYZQKStEuAzII6q4ppf4Oj0YP3qR8m3in3rtkE7sG0i+KtcbjNVjif2OgIA2rVHubE/F36hnbfc8f/0sBTH/EXYFjDgKm9v/Tz0wLAbXGdLZ34FNAGdrxz2BRUrZb+q0IVxK53m35n4hdFXxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555692; c=relaxed/simple;
	bh=GiS1HTbH0YK8xKeEQtFFWlZeUwLIMNdIt9eTv8VP7JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7S6A0iGrBmaCto1wg02YegeKwYxIcxa05/yur9FLdTc8GAeI1JVuvjtkpdIkIpawITfINAnAqXeRgnfoabe3lKHf7sKGngEGzWh/Lj3rJHcPbQbzR5zXcI4P3TWpy2L5HEzYJHimLEIovl5kxTqEK6i5vvrEMgYh/09vfNHz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gKzxHv5i; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1MrPLaUcO0RSHDfjdcJKaThFM2MqzZ/ApnVAgxTF2l4=; b=gKzxHv5iTLc2CJ1qX7xmFURk3F
	UmwIYKLxt1+nJ604eTWlWbveNrBVp3c9lRNLIiczp5D9OcX0Owg5IJI9E0/AA4jdSV5i/NPXYN9Xa
	Iel00+ynp2e8kfTNQGFoXodvT3JvDVgKQPMInP7A2duwb8Qq276upy26MsTGa+30pTJydv/1kUjj0
	ZxkiugXsY2FsL6/msYDKyKu1QUAbDnUy+JJYS4Sq3hUvFnIR6q0ebgaeae/KjbCRqMu6ICBLCCdT5
	C8+lFbdXWQa+u87YbO5xKL6DrasUw97FSOJvIMtJNB6KFt3rkSUqWputKk/lt3zfszr/MzNUF1LWN
	a/JgjDig==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAUXz-000K5k-1R; Fri, 24 May 2024 15:01:23 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 5/5] selftests/bpf: Add netkit test for pkt_type
Date: Fri, 24 May 2024 15:01:15 +0200
Message-Id: <20240524130115.9854-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240524130115.9854-1-daniel@iogearbox.net>
References: <20240524130115.9854-1-daniel@iogearbox.net>
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
index 598f9d5e656b..ea669f6ae7c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -108,6 +108,16 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
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
@@ -704,3 +714,77 @@ void serial_test_tc_netkit_neigh_links(void)
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


