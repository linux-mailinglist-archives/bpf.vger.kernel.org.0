Return-Path: <bpf+bounces-47340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9EE9F8275
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 18:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546DA1894556
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FA1B6541;
	Thu, 19 Dec 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oJT6giPc"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975E1A2554;
	Thu, 19 Dec 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629976; cv=none; b=Qk8bQT3gjJru31dzuGnrAdwnJ0CLvodnAcIFS0P1nqUxHRvp1fVY+b/tEJR6gE/uvqqoxoEo/BXAHukDj+edYwp8++ZDp55GL6GHh0mDXMgiy2ECpRR1avACyiudayFInojcIO0xr2Bfxe7DPyY/GdxqbqATVr4eBpprhPsYop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629976; c=relaxed/simple;
	bh=GTwTjq+Rcg8H1Cyt8wDmYfDvEDLYXMb8MQFPdfldwcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB+BsUwFcBOaRtxjBS3Vxf7BOv1+qOi9YTR2+nTaYzBi20UFW1cDKUKvWDmQvAwaGn3GL8yhgI/3qC/4iCKfC8vRJ44JpEGM2IXtXdk/a9w/sELUZkMofdLMX8CWT5Wd+v+rfmCiyY/uccl0i+BMcJbgtaqeaO+xC62nR5jry40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oJT6giPc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GO/j2yTqmecGSELJFipHLBGIAXhymxnpJSLXDsM+W6k=; b=oJT6giPc2C55Q8OlWSjq6OWk9o
	6UXReRhTS1jlH9Z/csFdekksB51UgUM21zMGHEMI6dn7+2ixAobZ96F0kDVJ2hjLbPYXT+ynkMZK3
	Wle1W6SxxEQt3TTQuxVxD4m0BcwsihH4t8hRphAc7utBeU8qFheYIdsNTC9awS9lHycG1nbFV7oCy
	i67JYfAXpHKgF8abd/l6fNYC3z7Tv0KbFNhNsYN5/7Eal4cxz93MDzhDAQXTHLi5sClSOuKdIQMu6
	ptkptykM4Jmv5yr9qHh+QusUzI6jeVGF9WYegYhiI/3azOV2ERKf4PRgdQiu2GgW7MkHmOJnpjSt9
	3LHPeGWg==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tOKUk-000Mmk-35; Thu, 19 Dec 2024 18:39:30 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Extend netkit tests to validate set {head,tail}room
Date: Thu, 19 Dec 2024 18:39:28 +0100
Message-ID: <20241219173928.464437-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219173928.464437-1-daniel@iogearbox.net>
References: <20241219173928.464437-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27492/Thu Dec 19 10:44:32 2024)

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
 .../selftests/bpf/prog_tests/tc_netkit.c      | 31 ++++++++++++-------
 .../selftests/bpf/progs/test_tc_link.c        | 15 +++++++++
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index 151a4210028f..7e41dceec58d 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -14,6 +14,9 @@
 #include "netlink_helpers.h"
 #include "tc_helpers.h"
 
+#define NETKIT_HEADROOM	32
+#define NETKIT_TAILROOM	8
+
 #define MARK		42
 #define PRIO		0xeb9f
 #define ICMP_ECHO	8
@@ -35,7 +38,7 @@ struct iplink_req {
 };
 
 static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
-			 bool same_netns, int scrub, int peer_scrub)
+			 bool same_netns, int scrub, int peer_scrub, bool room)
 {
 	struct rtnl_handle rth = { .fd = -1 };
 	struct iplink_req req = {};
@@ -63,6 +66,10 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_SCRUB, scrub);
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_PEER_SCRUB, peer_scrub);
 	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, mode);
+	if (room) {
+		addattr16(&req.n, sizeof(req), IFLA_NETKIT_HEADROOM, NETKIT_HEADROOM);
+		addattr16(&req.n, sizeof(req), IFLA_NETKIT_TAILROOM, NETKIT_TAILROOM);
+	}
 	addattr_nest_end(&req.n, data);
 	addattr_nest_end(&req.n, linkinfo);
 
@@ -185,7 +192,7 @@ void serial_test_tc_netkit_basic(void)
 
 	err = create_netkit(NETKIT_L2, NETKIT_PASS, NETKIT_PASS,
 			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    NETKIT_SCRUB_DEFAULT, false);
 	if (err)
 		return;
 
@@ -300,7 +307,7 @@ static void serial_test_tc_netkit_multi_links_target(int mode, int target)
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
 			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    NETKIT_SCRUB_DEFAULT, false);
 	if (err)
 		return;
 
@@ -429,7 +436,7 @@ static void serial_test_tc_netkit_multi_opts_target(int mode, int target)
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
 			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    NETKIT_SCRUB_DEFAULT, false);
 	if (err)
 		return;
 
@@ -544,7 +551,7 @@ void serial_test_tc_netkit_device(void)
 
 	err = create_netkit(NETKIT_L3, NETKIT_PASS, NETKIT_PASS,
 			    &ifindex, true, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    NETKIT_SCRUB_DEFAULT, false);
 	if (err)
 		return;
 
@@ -656,7 +663,7 @@ static void serial_test_tc_netkit_neigh_links_target(int mode, int target)
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
 			    &ifindex, false, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    NETKIT_SCRUB_DEFAULT, false);
 	if (err)
 		return;
 
@@ -734,7 +741,7 @@ static void serial_test_tc_netkit_pkt_type_mode(int mode)
 
 	err = create_netkit(mode, NETKIT_PASS, NETKIT_PASS,
 			    &ifindex, true, NETKIT_SCRUB_DEFAULT,
-			    NETKIT_SCRUB_DEFAULT);
+			    NETKIT_SCRUB_DEFAULT, false);
 	if (err)
 		return;
 
@@ -799,7 +806,7 @@ void serial_test_tc_netkit_pkt_type(void)
 	serial_test_tc_netkit_pkt_type_mode(NETKIT_L3);
 }
 
-static void serial_test_tc_netkit_scrub_type(int scrub)
+static void serial_test_tc_netkit_scrub_type(int scrub, bool room)
 {
 	LIBBPF_OPTS(bpf_netkit_opts, optl);
 	struct test_tc_link *skel;
@@ -807,7 +814,7 @@ static void serial_test_tc_netkit_scrub_type(int scrub)
 	int err, ifindex;
 
 	err = create_netkit(NETKIT_L2, NETKIT_PASS, NETKIT_PASS,
-			    &ifindex, false, scrub, scrub);
+			    &ifindex, false, scrub, scrub, room);
 	if (err)
 		return;
 
@@ -842,6 +849,8 @@ static void serial_test_tc_netkit_scrub_type(int scrub)
 	ASSERT_EQ(skel->bss->seen_tc8, true, "seen_tc8");
 	ASSERT_EQ(skel->bss->mark, scrub == NETKIT_SCRUB_NONE ? MARK : 0, "mark");
 	ASSERT_EQ(skel->bss->prio, scrub == NETKIT_SCRUB_NONE ? PRIO : 0, "prio");
+	ASSERT_EQ(skel->bss->headroom, room ? NETKIT_HEADROOM : 0, "headroom");
+	ASSERT_EQ(skel->bss->tailroom, room ? NETKIT_TAILROOM : 0, "tailroom");
 cleanup:
 	test_tc_link__destroy(skel);
 
@@ -852,6 +861,6 @@ static void serial_test_tc_netkit_scrub_type(int scrub)
 
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


