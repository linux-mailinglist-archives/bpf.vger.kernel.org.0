Return-Path: <bpf+bounces-19963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43F8332E2
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 07:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0487FB230E5
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5A1FD6;
	Sat, 20 Jan 2024 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wy6nwEBW"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B517D4
	for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705730743; cv=none; b=tFCphGLUr9c1EihvSKvZWmQOC2rb4X0EO7XVDeprwkkXBTRQsmbclBTZJ9FHjQ5f54X68N9o6i4q0cGEXVEgCxTgztegQLNIBjCIUN4Icb22sbbeT46sGzGVB+HBfXAhgAlDv+b6+VW3KOM6jKefORaFroaxF0Z+irtKl1ZTSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705730743; c=relaxed/simple;
	bh=07zpB7nhlm+UulAI8Cl5kQNS8f0PfVi/8BdWRIDof08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oEBSJU3TQjkthXiOT0E1arhhHLgBdBCtIuvcEKkdcR6wHriwhCwxuI5mKBdHgvzFHkB6xxV2oFZd0ZYARKLkECgxCDisWSPYsCUYrAPo+c85K+AI5ilQNfJJfamPA4ZOr/2mXExr8tKG0I7oPDjlnK90XogYXmJgYJi5QhsJlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wy6nwEBW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705730739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QBqTwly3G8u9OnviOfAfWIPij/IRbieYJZLSR9SLic=;
	b=wy6nwEBWJ3OC7wRMTqlvNhT273er9HO+v5zQNq76LuOaKdaj/KHK34MtnUuOCFD+j7IuHL
	x5yAjUIsHMzx769Tc5Ro3ZVcfdTrxbdg3xgsutrEozwe47r/XKgBJWgN9AqRwcPATAO2k5
	yn+gRkH/ueX/xe2n8nj2C8/6UW4Vxas=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Wait for the netstamp_needed_key static key to be turned on
Date: Fri, 19 Jan 2024 22:05:18 -0800
Message-Id: <20240120060518.3604920-2-martin.lau@linux.dev>
In-Reply-To: <20240120060518.3604920-1-martin.lau@linux.dev>
References: <20240120060518.3604920-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

After the previous patch that speeded up the test (by avoiding neigh
discovery in IPv6), the BPF CI occasionally hits this error:

rcv tstamp unexpected pkt rcv tstamp: actual 0 == expected 0

The test complains about the cmsg returned from the recvmsg() does not
have the rcv timestamp. Setting skb->tstamp or not is
controlled by a kernel static key "netstamp_needed_key". The static
key is enabled whenever this is at least one sk with the SOCK_TIMESTAMP
set.

The test_redirect_dtime does use setsockopt() to turn on
the SOCK_TIMESTAMP for the reading sk. In the kernel
net_enable_timestamp() has a delay to enable the "netstamp_needed_key"
when CONFIG_JUMP_LABEL is set. This potential delay is the likely reason
for packet missing rcv timestamp occasionally.

This patch is to create udp sockets with SOCK_TIMESTAMP set.
It sends and receives some packets until the received packet
has a rcv timestamp. It currently retries at most 5 times with 1s
in between. This should be enough to wait for the "netstamp_needed_key".
It then holds on to the socket and only closes it at the end of the test.
This guarantees that the test has the "netstamp_needed_key" key turned
on from the beginning.

To simplify the udp sockets setup, they are sending/receiving packets
in the same netns (ns_dst is used) and communicate over the "lo" dev.
Hence, the patch enables the "lo" dev in the ns_dst.

Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
v2: It is a new patch in v2 to address occasionally missing
    skb->tstamp in the recvmesg().

 .../selftests/bpf/prog_tests/tc_redirect.c    | 79 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 610887157fd8..dbe06aeaa2b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -291,6 +291,7 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS(fail, "ip addr add " IP4_DST "/32 dev dst");
 	SYS(fail, "ip addr add " IP6_DST "/128 dev dst nodad");
 	SYS(fail, "ip link set dev dst up");
+	SYS(fail, "ip link set dev lo up");
 
 	SYS(fail, "ip route add " IP4_SRC "/32 dev dst scope global");
 	SYS(fail, "ip route add " IP4_NET "/16 dev dst scope global");
@@ -468,7 +469,7 @@ static int set_forwarding(bool enable)
 	return 0;
 }
 
-static void rcv_tstamp(int fd, const char *expected, size_t s)
+static int __rcv_tstamp(int fd, const char *expected, size_t s, __u64 *tstamp)
 {
 	struct __kernel_timespec pkt_ts = {};
 	char ctl[CMSG_SPACE(sizeof(pkt_ts))];
@@ -489,7 +490,7 @@ static void rcv_tstamp(int fd, const char *expected, size_t s)
 
 	ret = recvmsg(fd, &msg, 0);
 	if (!ASSERT_EQ(ret, s, "recvmsg"))
-		return;
+		return -1;
 	ASSERT_STRNEQ(data, expected, s, "expected rcv data");
 
 	cmsg = CMSG_FIRSTHDR(&msg);
@@ -498,6 +499,12 @@ static void rcv_tstamp(int fd, const char *expected, size_t s)
 		memcpy(&pkt_ts, CMSG_DATA(cmsg), sizeof(pkt_ts));
 
 	pkt_ns = pkt_ts.tv_sec * NSEC_PER_SEC + pkt_ts.tv_nsec;
+	if (tstamp) {
+		/* caller will check the tstamp itself */
+		*tstamp = pkt_ns;
+		return 0;
+	}
+
 	ASSERT_NEQ(pkt_ns, 0, "pkt rcv tstamp");
 
 	ret = clock_gettime(CLOCK_REALTIME, &now_ts);
@@ -507,6 +514,60 @@ static void rcv_tstamp(int fd, const char *expected, size_t s)
 	if (ASSERT_GE(now_ns, pkt_ns, "check rcv tstamp"))
 		ASSERT_LT(now_ns - pkt_ns, 5 * NSEC_PER_SEC,
 			  "check rcv tstamp");
+	return 0;
+}
+
+static void rcv_tstamp(int fd, const char *expected, size_t s)
+{
+	__rcv_tstamp(fd, expected, s, NULL);
+}
+
+static int wait_netstamp_needed_key(void)
+{
+	int opt = 1, srv_fd = -1, cli_fd = -1, nretries = 0, err, n;
+	char buf[] = "testing testing";
+	struct nstoken *nstoken;
+	__u64 tstamp = 0;
+
+	nstoken = open_netns(NS_DST);
+	if (!nstoken)
+		return -1;
+
+	srv_fd = start_server(AF_INET6, SOCK_DGRAM, "::1", 0, 0);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		goto done;
+
+	err = setsockopt(srv_fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+			 &opt, sizeof(opt));
+	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS_NEW)"))
+		goto done;
+
+	cli_fd = connect_to_fd(srv_fd, TIMEOUT_MILLIS);
+	if (!ASSERT_GE(cli_fd, 0, "connect_to_fd"))
+		goto done;
+
+again:
+	n = write(cli_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
+		goto done;
+	err = __rcv_tstamp(srv_fd, buf, sizeof(buf), &tstamp);
+	if (!ASSERT_OK(err, "__rcv_tstamp"))
+		goto done;
+	if (!tstamp && nretries++ < 5) {
+		sleep(1);
+		printf("netstamp_needed_key retry#%d\n", nretries);
+		goto again;
+	}
+
+done:
+	if (!tstamp && srv_fd != -1) {
+		close(srv_fd);
+		srv_fd = -1;
+	}
+	if (cli_fd != -1)
+		close(cli_fd);
+	close_netns(nstoken);
+	return srv_fd;
 }
 
 static void snd_tstamp(int fd, char *b, size_t s)
@@ -843,11 +904,20 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 {
 	struct test_tc_dtime *skel;
 	struct nstoken *nstoken;
-	int err;
+	int hold_tstamp_fd, err;
+
+	/* Hold a sk with the SOCK_TIMESTAMP set to ensure there
+	 * is no delay in the kernel net_enable_timestamp().
+	 * This ensures the following tests must have
+	 * non zero rcv tstamp in the recvmsg().
+	 */
+	hold_tstamp_fd = wait_netstamp_needed_key();
+	if (!ASSERT_GE(hold_tstamp_fd, 0, "wait_netstamp_needed_key"))
+		return;
 
 	skel = test_tc_dtime__open();
 	if (!ASSERT_OK_PTR(skel, "test_tc_dtime__open"))
-		return;
+		goto done;
 
 	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
 	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
@@ -892,6 +962,7 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 
 done:
 	test_tc_dtime__destroy(skel);
+	close(hold_tstamp_fd);
 }
 
 static void test_tc_redirect_neigh_fib(struct netns_setup_result *setup_result)
-- 
2.34.1


