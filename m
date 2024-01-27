Return-Path: <bpf+bounces-20449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF583EA19
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 03:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3735E2879C7
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1898B673;
	Sat, 27 Jan 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EMT5UquM"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E186BA28
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706323830; cv=none; b=BE/ELd31YAiSw5aMyRB5Yn/K7+UWWOsOmcLKaqSKJg6AThotJYw2L/qDTcqu086PW/oFNeenFptUHcbzy/pq9s2ebrd/622nsm1tupCmQwyUIY8XMnayXmTAlFfFIkBWNs1qxAX5M/ykXt1YD3liaE1U6GTNfSgwUxtjaYbpa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706323830; c=relaxed/simple;
	bh=7M0Rsskxu+ywS7CCu5UsNGOQklIR8ffTrDfcrIZgp3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEnWEjVuIX0vUpCADwdG4FSTCGOKCCvCqN3UkfQg0+LD2YCBVoD1H9gn7EwO+oyC7/mosuex4jFgb+FGateEdIHlZryUxoeGJmtrKh2RpG20RJyufjum0Yv4SCSyPnK3enoFaMeo34jXXNJEYo0cPWEEy/ydZUWSnVKhEgT+yJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EMT5UquM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706323826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uV1vT059z1ydih+WYEG6/OLcoQzHsmyrdh4hq6lthh0=;
	b=EMT5UquM3gLaM9i4IUWsRiOvP2zq1F91k0Oybj4D8H5b7i5czji/r3UMpitqpSy07fW/pn
	HLdtBZUmhvWYUQ8j2Odn5S8x6d3xxcpfBBxHcaTXGUeZSCwowO3zYPLkmYXRHHNOJ4IFTg
	GfcgAHEMSoYDmqULw+H7bvrMBHXQu/8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Remove "&>" usage in the selftests
Date: Fri, 26 Jan 2024 18:50:17 -0800
Message-Id: <20240127025017.950825-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

In s390, CI reported that the sock_iter_batch selftest
hits this error very often:

2024-01-26T16:56:49.3091804Z Bind /proc/self/ns/net -> /run/netns/sock_iter_batch_netns failed: No such file or directory
2024-01-26T16:56:49.3149524Z Cannot remove namespace file "/run/netns/sock_iter_batch_netns": No such file or directory
2024-01-26T16:56:49.3772213Z test_sock_iter_batch:FAIL:ip netns add sock_iter_batch_netns unexpected error: 256 (errno 0)

It happens very often in s390 but Manu also noticed it happens very
sparsely in other arch also.

It turns out the default dash shell does not recognize "&>"
as a redirection operator, so the command went to the background.
In the sock_iter_batch selftest, the "ip netns delete" went
into background and then race with the following "ip netns add"
command.

This patch replaces the "&> /dev/null" usage with ">/dev/null 2>&1"
and does this redirection in the SYS_NOFAIL macro instead of doing
it individually by its caller. The SYS_NOFAIL callers do not care
about failure, so it is no harm to do this redirection even if
some of the existing callers do not redirect to /dev/null now.

It touches different test files, so I skipped the Fixes tags
in this patch. Some of the changed tests do not use "&>"
but they use the SYS_NOFAIL, so these tests are also
changed to avoid doing its own redirection because
SYS_NOFAIL does it internally now.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/decap_sanity.c    |  2 +-
 .../selftests/bpf/prog_tests/fib_lookup.c      |  2 +-
 .../selftests/bpf/prog_tests/ip_check_defrag.c |  4 ++--
 .../selftests/bpf/prog_tests/lwt_redirect.c    |  2 +-
 .../selftests/bpf/prog_tests/lwt_reroute.c     |  2 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c |  2 +-
 .../selftests/bpf/prog_tests/sock_destroy.c    |  2 +-
 .../selftests/bpf/prog_tests/sock_iter_batch.c |  4 ++--
 .../selftests/bpf/prog_tests/test_tunnel.c     | 18 +++++++++---------
 tools/testing/selftests/bpf/test_progs.h       |  7 ++++++-
 10 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
index 5c0ebe6ba866..dcb9e5070cc3 100644
--- a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
@@ -72,6 +72,6 @@ void test_decap_sanity(void)
 		bpf_tc_hook_destroy(&qdisc_hook);
 		close_netns(nstoken);
 	}
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	SYS_NOFAIL("ip netns del " NS_TEST);
 	decap_sanity__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 4ad4cd69152e..3379df2d4cf2 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -298,6 +298,6 @@ void test_fib_lookup(void)
 fail:
 	if (nstoken)
 		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	SYS_NOFAIL("ip netns del " NS_TEST);
 	fib_lookup__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 57c814f5f6a7..8dd2af9081f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -59,9 +59,9 @@ static int setup_topology(bool ipv6)
 	/* Wait for up to 5s for links to come up */
 	for (i = 0; i < 5; ++i) {
 		if (ipv6)
-			up = !system("ip netns exec " NS0 " ping -6 -c 1 -W 1 " VETH1_ADDR6 " &>/dev/null");
+			up = !SYS_NOFAIL("ip netns exec " NS0 " ping -6 -c 1 -W 1 " VETH1_ADDR6);
 		else
-			up = !system("ip netns exec " NS0 " ping -c 1 -W 1 " VETH1_ADDR " &>/dev/null");
+			up = !SYS_NOFAIL("ip netns exec " NS0 " ping -c 1 -W 1 " VETH1_ADDR);
 
 		if (up)
 			break;
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
index 59b38569f310..beeb3ac1c361 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -85,7 +85,7 @@ static void ping_dev(const char *dev, bool is_ingress)
 		snprintf(ip, sizeof(ip), "20.0.0.%d", link_index);
 
 	/* We won't get a reply. Don't fail here */
-	SYS_NOFAIL("ping %s -c1 -W1 -s %d >/dev/null 2>&1",
+	SYS_NOFAIL("ping %s -c1 -W1 -s %d",
 		   ip, ICMP_PAYLOAD_SIZE);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
index f4bb2d5fcae0..5610bc76928d 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -63,7 +63,7 @@
 static void ping_once(const char *ip)
 {
 	/* We won't get a reply. Don't fail here */
-	SYS_NOFAIL("ping %s -c1 -W1 -s %d >/dev/null 2>&1",
+	SYS_NOFAIL("ping %s -c1 -W1 -s %d",
 		   ip, ICMP_PAYLOAD_SIZE);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7c0be7cf550b..8f8d792307c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -79,7 +79,7 @@ static void cleanup_netns(struct nstoken *nstoken)
 	if (nstoken)
 		close_netns(nstoken);
 
-	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+	SYS_NOFAIL("ip netns del %s", NS_TEST);
 }
 
 static int verify_tsk(int map_fd, int client_fd)
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index b0583309a94e..9c11938fe597 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -214,7 +214,7 @@ void test_sock_destroy(void)
 cleanup:
 	if (nstoken)
 		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
+	SYS_NOFAIL("ip netns del " TEST_NS);
 	if (cgroup_fd >= 0)
 		close(cgroup_fd);
 	sock_destroy_prog__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 0c365f36c73b..d56e18b25528 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -112,7 +112,7 @@ void test_sock_iter_batch(void)
 {
 	struct nstoken *nstoken = NULL;
 
-	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
+	SYS_NOFAIL("ip netns del " TEST_NS);
 	SYS(done, "ip netns add %s", TEST_NS);
 	SYS(done, "ip -net %s link set dev lo up", TEST_NS);
 
@@ -131,5 +131,5 @@ void test_sock_iter_batch(void)
 	close_netns(nstoken);
 
 done:
-	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
+	SYS_NOFAIL("ip netns del " TEST_NS);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 2b3c6dd66259..5f1fb0a2ea56 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -118,9 +118,9 @@ static int config_device(void)
 static void cleanup(void)
 {
 	SYS_NOFAIL("test -f /var/run/netns/at_ns0 && ip netns delete at_ns0");
-	SYS_NOFAIL("ip link del veth1 2> /dev/null");
-	SYS_NOFAIL("ip link del %s 2> /dev/null", VXLAN_TUNL_DEV1);
-	SYS_NOFAIL("ip link del %s 2> /dev/null", IP6VXLAN_TUNL_DEV1);
+	SYS_NOFAIL("ip link del veth1");
+	SYS_NOFAIL("ip link del %s", VXLAN_TUNL_DEV1);
+	SYS_NOFAIL("ip link del %s", IP6VXLAN_TUNL_DEV1);
 }
 
 static int add_vxlan_tunnel(void)
@@ -265,9 +265,9 @@ static int add_ipip_tunnel(enum ipip_encap encap)
 static void delete_ipip_tunnel(void)
 {
 	SYS_NOFAIL("ip -n at_ns0 link delete dev %s", IPIP_TUNL_DEV0);
-	SYS_NOFAIL("ip -n at_ns0 fou del port 5555 2> /dev/null");
+	SYS_NOFAIL("ip -n at_ns0 fou del port 5555");
 	SYS_NOFAIL("ip link delete dev %s", IPIP_TUNL_DEV1);
-	SYS_NOFAIL("ip fou del port 5555 2> /dev/null");
+	SYS_NOFAIL("ip fou del port 5555");
 }
 
 static int add_xfrm_tunnel(void)
@@ -346,13 +346,13 @@ static int add_xfrm_tunnel(void)
 
 static void delete_xfrm_tunnel(void)
 {
-	SYS_NOFAIL("ip xfrm policy delete dir out src %s/32 dst %s/32 2> /dev/null",
+	SYS_NOFAIL("ip xfrm policy delete dir out src %s/32 dst %s/32",
 		   IP4_ADDR_TUNL_DEV1, IP4_ADDR_TUNL_DEV0);
-	SYS_NOFAIL("ip xfrm policy delete dir in src %s/32 dst %s/32 2> /dev/null",
+	SYS_NOFAIL("ip xfrm policy delete dir in src %s/32 dst %s/32",
 		   IP4_ADDR_TUNL_DEV0, IP4_ADDR_TUNL_DEV1);
-	SYS_NOFAIL("ip xfrm state delete src %s dst %s proto esp spi %d 2> /dev/null",
+	SYS_NOFAIL("ip xfrm state delete src %s dst %s proto esp spi %d",
 		   IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT);
-	SYS_NOFAIL("ip xfrm state delete src %s dst %s proto esp spi %d 2> /dev/null",
+	SYS_NOFAIL("ip xfrm state delete src %s dst %s proto esp spi %d",
 		   IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN);
 }
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 2f9f6f250f17..80df51244886 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -385,10 +385,15 @@ int test__join_cgroup(const char *path);
 			goto goto_label;				\
 	})
 
+#define ALL_TO_DEV_NULL " >/dev/null 2>&1"
+
 #define SYS_NOFAIL(fmt, ...)						\
 	({								\
 		char cmd[1024];						\
-		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);		\
+		int n;							\
+		n = snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (n < sizeof(cmd) && sizeof(cmd) - n >= sizeof(ALL_TO_DEV_NULL)) \
+			strcat(cmd, ALL_TO_DEV_NULL);			\
 		system(cmd);						\
 	})
 
-- 
2.34.1


