Return-Path: <bpf+bounces-47488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084459F9D43
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 00:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151D71893682
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 23:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F0228C96;
	Fri, 20 Dec 2024 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p5vpkCFX"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101F2206B5;
	Fri, 20 Dec 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738430; cv=none; b=oR4J2OK9SQRkz24a+sF8ka86HOAdEaGOzqge9fXMuxzBC4vw/wIAWsa/fR1epVEDpEvt97W/QJK2LdUTI+S4regUbhaWxPLzVfgtYNVX70uo835DqS62Q8HcFT8tyeXrq7R+QCInOJ02j3Ml1BOaBP+B/NMEKQ5/ADpF3p+4jdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738430; c=relaxed/simple;
	bh=Z/LdRIvY620pygs5zgVRdsJFWIkHF6hgs+XnHWEMtq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUVKs2SI14WEZ1tiDDn13iJNLhYDloJ+w3YgIAuiE62BK8OM2FgQ4hlhbbggF28wUmAz6WZrTHOOIryB22cxpCWzcsIsF7O6NQgikH8EfbzJupJCUm6CIi6TvxpfPPwAD95K6wWrr9V45BMY/U2+PPFQXRcAobXJExK38jfGRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=p5vpkCFX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FEbnGn9GnSTZj0GETED4Of/KjHNRULwfIHoHmgRf7UE=; b=p5vpkCFXLFVhc72GEwHDQhnEXM
	4NldN36R9N/Nkfnu7N+efS2C1J1iLpslsk/tWgrIFeYWlC2rCIwy8lrRfPnzTNME9fTDvsjyzFu0D
	3D7a2PnXPUbHl0kP48bF4NhFNmZZlmA6n+j62IOu9uyHmauSr4f86R27sdIfwuet4Fa0uBGOaNHQj
	pQ9odJiAeT25KI0ZTFtu3tPXtcSaN7uB7p2Jgii0sQ0P/s+aV/M18CdKrYiuyXAASDu/52EeN2Wb6
	T0M1GFBJpdaCd7OzGmbJVmwkI5PmBuUCg4EPYrjTTTUwrVq3l7OlLWfd1TXOMmq4JmmWK3LtVIsxv
	8cXt1HHg==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tOmhw-000ISw-Ct; Sat, 21 Dec 2024 00:47:00 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Extend netkit tests to validate set {head,tail}room
Date: Sat, 21 Dec 2024 00:46:58 +0100
Message-ID: <20241220234658.490686-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220234658.490686-1-daniel@iogearbox.net>
References: <20241220234658.490686-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27493/Fri Dec 20 10:46:49 2024)

Extend the netkit selftests to specify and validate the {head,tail}room
on the netdevice:

  # ./vmtest.sh -- ./test_progs -t netkit
  [...]
  ./test_progs -t netkit
  [    1.174147] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.174585] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  [    1.422307] tsc: Refined TSC clocksource calibration: 3407.983 MHz
  [    1.424511] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc3e5084, max_idle_ns: 440795359833 ns
  [    1.428092] clocksource: Switched to clocksource tsc
  #363     tc_netkit_basic:OK
  #364     tc_netkit_device:OK
  #365     tc_netkit_multi_links:OK
  #366     tc_netkit_multi_opts:OK
  #367     tc_netkit_neigh_links:OK
  #368     tc_netkit_pkt_type:OK
  #369     tc_netkit_scrub:OK
  Summary: 7/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
  v2:
    - Rework to pass flags to create_netkit

 .../selftests/bpf/prog_tests/tc_netkit.c      | 49 ++++++++++++-------
 .../selftests/bpf/progs/test_tc_link.c        | 15 ++++++
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index 151a4210028f..2461d183dee5 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -14,10 +14,16 @@
 #include "netlink_helpers.h"
 #include "tc_helpers.h"
 
+#define NETKIT_HEADROOM	32
+#define NETKIT_TAILROOM	8
+
 #define MARK		42
 #define PRIO		0xeb9f
 #define ICMP_ECHO	8
 
+#define FLAG_ADJUST_ROOM (1 << 0)
+#define FLAG_SAME_NETNS  (1 << 1)
+
 struct icmphdr {
 	__u8		type;
 	__u8		code;
@@ -35,7 +41,7 @@ struct iplink_req {
 };
 
 static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
-			 bool same_netns, int scrub, int peer_scrub)
+			 int scrub, int peer_scrub, __u32 flags)
 {
 	struct rtnl_handle rth = { .fd = -1 };
 	struct iplink_req req = {};
@@ -63,6 +69,10 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_SCRUB, scrub);
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_PEER_SCRUB, peer_scrub);
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, mode);
+	if (flags & FLAG_ADJUST_ROOM) {
+		addattr16(&req.n, sizeof(req), IFLA_NETKIT_HEADROOM, NETKIT_HEADROOM);
+		addattr16(&req.n, sizeof(req), IFLA_NETKIT_TAILROOM, NETKIT_TAILROOM);
+	}
 	addattr_nest_end(&req.n, data);
 	addattr_nest_end(&req.n, linkinfo);
 
@@ -87,7 +97,7 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
 				 " addr ee:ff:bb:cc:aa:dd"),
 				 "set hwaddress");
 	}
-	if (same_netns) {
+	if (flags & FLAG_SAME_NETNS) {
 		ASSERT_OK(system("ip link set dev " netkit_peer " up"),
 				 "up peer");
 		ASSERT_OK(system("ip addr add dev " netkit_peer " 10.0.0.2/24"),
@@ -184,8 +194,8 @@ void serial_test_tc_netkit_basic(void)
 	int err, ifindex;
 
 	err = create_netkit(NETKIT_L2, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    &ifindex, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT, 0);
 	if (err)
 		return;
 
@@ -299,8 +309,8 @@ static void serial_test_tc_netkit_multi_links_target(int mode, int target)
 	int err, ifindex;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    &ifindex, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT, 0);
 	if (err)
 		return;
 
@@ -428,8 +438,8 @@ static void serial_test_tc_netkit_multi_opts_target(int mode, int target)
 	int err, ifindex;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    &ifindex, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT, 0);
 	if (err)
 		return;
 
@@ -543,8 +553,8 @@ void serial_test_tc_netkit_device(void)
 	int err, ifindex, ifindex2;
 
 	err = create_netkit(NETKIT_L3, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, true, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    &ifindex, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT, FLAG_SAME_NETNS);
 	if (err)
 		return;
 
@@ -655,8 +665,8 @@ static void serial_test_tc_netkit_neigh_links_target(int mode, int target)
 	int err, ifindex;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    &ifindex, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT, 0);
 	if (err)
 		return;
 
@@ -733,8 +743,8 @@ static void serial_test_tc_netkit_pkt_type_mode(int mode)
 	struct bpf_link *link;
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, true, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    &ifindex, NETKIT_SCRUB_DEFAULT,
+			    NETKIT_SCRUB_DEFAULT, FLAG_SAME_NETNS);
 	if (err)
 		return;
 
@@ -799,7 +809,7 @@ void serial_test_tc_netkit_pkt_type(void)
 	serial_test_tc_netkit_pkt_type_mode(NETKIT_L3);
 }
 
-static void serial_test_tc_netkit_scrub_type(int scrub)
+static void serial_test_tc_netkit_scrub_type(int scrub, bool room)
 {
 	LIBBPF_OPTS(bpf_netkit_opts, optl);
 	struct test_tc_link *skel;
@@ -807,7 +817,8 @@ static void serial_test_tc_netkit_scrub_type(int scrub)
 	int err, ifindex;
 
 	err = create_netkit(NETKIT_L2, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false, scrub, scrub);
+			    &ifindex, scrub, scrub,
+			    room ? FLAG_ADJUST_ROOM : 0);
 	if (err)
 		return;
 
@@ -842,6 +853,8 @@ static void serial_test_tc_netkit_scrub_type(int scrub)
 	ASSERT_EQ(skel->bss->seen_tc8, true, "seen_tc8");
 	ASSERT_EQ(skel->bss->mark, scrub == NETKIT_SCRUB_NONE ? MARK : 0, "mark");
 	ASSERT_EQ(skel->bss->prio, scrub == NETKIT_SCRUB_NONE ? PRIO : 0, "prio");
+	ASSERT_EQ(skel->bss->headroom, room ? NETKIT_HEADROOM : 0, "headroom");
+	ASSERT_EQ(skel->bss->tailroom, room ? NETKIT_TAILROOM : 0, "tailroom");
 cleanup:
 	test_tc_link__destroy(skel);
 
@@ -852,6 +865,6 @@ static void serial_test_tc_netkit_scrub_type(int scrub)
 
 void serial_test_tc_netkit_scrub(void)
 {
-	serial_test_tc_netkit_scrub_type(NETKIT_SCRUB_DEFAULT);
-	serial_test_tc_netkit_scrub_type(NETKIT_SCRUB_NONE);
+	serial_test_tc_netkit_scrub_type(NETKIT_SCRUB_DEFAULT, false);
+	serial_test_tc_netkit_scrub_type(NETKIT_SCRUB_NONE, true);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
index 10d825928499..630f12e51b07 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_link.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
@@ -8,6 +8,7 @@
 #include <linux/if_packet.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
 
 char LICENSE[] SEC("license") = "GPL";
 
@@ -27,6 +28,7 @@ bool seen_host;
 bool seen_mcast;
 
 int mark, prio;
+unsigned short headroom, tailroom;
 
 SEC("tc/ingress")
 int tc1(struct __sk_buff *skb)
@@ -104,11 +106,24 @@ int tc7(struct __sk_buff *skb)
 	return TCX_PASS;
 }
 
+struct sk_buff {
+	struct net_device *dev;
+};
+
+struct net_device {
+	unsigned short needed_headroom;
+	unsigned short needed_tailroom;
+};
+
 SEC("tc/egress")
 int tc8(struct __sk_buff *skb)
 {
+	struct net_device *dev = BPF_CORE_READ((struct sk_buff *)skb, dev);
+
 	seen_tc8 = true;
 	mark = skb->mark;
 	prio = skb->priority;
+	headroom = BPF_CORE_READ(dev, needed_headroom);
+	tailroom = BPF_CORE_READ(dev, needed_tailroom);
 	return TCX_PASS;
 }
-- 
2.43.0


