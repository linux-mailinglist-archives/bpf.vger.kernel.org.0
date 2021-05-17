Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7C38298D
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhEQKM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhEQKM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 06:12:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9B8C06174A
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 03:11:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so3652990wrm.13
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBuDRBvtCqKszw4aNrO1hM8CglrVYn3M7m7lQpkXEZ4=;
        b=gtatSet+wuXaSWeFP+kLAvlSFDSd5W3aj/3hiqF7zVkhTA3fgQ9W9S7HStWQ7qp1ug
         M2DyOkJJQ6jG2OqDckV+IzncUtlCZG4SWYP66zLcV0fdXM1x6maX1yggpJlI3QYSEJ6G
         Auwrj4yNQI9ftiuu5IHOtETFZgzH8YGMxKwVivRqYlboMq3Z9wTpCcbm8nWX/DmNXNJz
         BtDL6PktJvVNho40PVBxK7t/V6koNmpU86nMBu2fDfxtJNIjxUuLtKYUrYtFZcT2XoeX
         EfRHiQ9uQhI6CMuUptG9JI+9FYEiEIhpDITHQZmtM/AWGQ4UmnDkGTt+6+uBuosd1XdG
         xJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBuDRBvtCqKszw4aNrO1hM8CglrVYn3M7m7lQpkXEZ4=;
        b=H1YTFgeVB9eLDQn88henBU9/yWDC/f/yEUNOB+EtpIWyPl8TjoTDAmaledwMu5bpMq
         LjkPzakWIYgnpUHEDETMvJzgUVaTQEmRfZ+2Qu+6lbAS4q0oWm6Wqg67c+r1WqqPZt8s
         gjp9Ie7mYHLZj1h85oI0QCYNknx2S2jBfxb43xKQxoP4C8u9v3Jcz4EunzXGNzDGAcyg
         YrgOZN/P3coxazv6UkTgrd+k3soWYvzDQpFwhfdMyDWK4VFDJ2LDFfW5gYS3MG/MkWfL
         7j8iWHmY2s7iBukC7LIE/aUtRauoEJx1FnuHFkYi63rPo+s4L8fukBcHYSrZIZyLK47H
         1bgg==
X-Gm-Message-State: AOAM5325dmQnSJIjwcYnbODp3VkOwKWKQPpY2nr5sMEoNTfZLu9ClYrH
        ibxz1r0IiIb3yO5pjhWei9Q0PFdY89Ao81s=
X-Google-Smtp-Source: ABdhPJzbOGSsiis9aAoAxkhyqjiFpaPlpxoHJJl5NmpIY0sdQHw1R64YkmCofqb8j+r6GkpXRfd35A==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr9459804wrv.286.1621246297505;
        Mon, 17 May 2021 03:11:37 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id q12sm16993265wrx.17.2021.05.17.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:11:37 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf v2 1/2] selftests/bpf: Add test for l3 use of bpf_redirect_peer
Date:   Mon, 17 May 2021 10:11:27 +0000
Message-Id: <20210517101128.641827-2-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517101128.641827-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210517101128.641827-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a failing test to try and use bpf_skb_change_head in combination
with bpf_redirect_peer to redirect a packet from a L3 device to veth.

The test uses a BPF program that adds L2 headers to the packet coming
from a L3 device and then calls bpf_redirect_peer to redirect the packet
to a veth device. The test fails as skb->mac_len is not set properly and
thus the ethernet headers are not properly skb_pull'd in cls_bpf_classify,
causing tcp_v4_rcv to point the TCP header into middle of the IP header.

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 238 +++++++++++++++++-
 .../selftests/bpf/progs/test_tc_peer.c        |  26 ++
 2 files changed, 251 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 95ef9fcd31d8..aa844f282e8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -11,16 +11,18 @@
  */
 
 #define _GNU_SOURCE
-#include <fcntl.h>
+
+#include "test_progs.h"
+
 #include <linux/limits.h>
 #include <linux/sysctl.h>
+#include <linux/if_tun.h>
+#include <linux/if.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <sys/stat.h>
-#include <sys/types.h>
 
-#include "test_progs.h"
 #include "network_helpers.h"
 #include "test_tc_neigh_fib.skel.h"
 #include "test_tc_neigh.skel.h"
@@ -32,16 +34,23 @@
 
 #define IP4_SRC "172.16.1.100"
 #define IP4_DST "172.16.2.100"
+#define IP4_TUN_SRC "172.17.1.100"
+#define IP4_TUN_FWD "172.17.1.200"
 #define IP4_PORT 9004
 
-#define IP6_SRC "::1:dead:beef:cafe"
-#define IP6_DST "::2:dead:beef:cafe"
+#define IP6_SRC "0::1:dead:beef:cafe"
+#define IP6_DST "0::2:dead:beef:cafe"
+#define IP6_TUN_SRC "1::1:dead:beef:cafe"
+#define IP6_TUN_FWD "1::2:dead:beef:cafe"
 #define IP6_PORT 9006
 
 #define IP4_SLL "169.254.0.1"
 #define IP4_DLL "169.254.0.2"
 #define IP4_NET "169.254.0.0"
 
+#define MAC_DST_FWD "00:11:22:33:44:55"
+#define MAC_DST "00:22:33:44:55:66"
+
 #define IFADDR_STR_LEN 18
 #define PING_ARGS "-c 3 -w 10 -q"
 
@@ -92,7 +101,8 @@ static int modify_proc(const char *path, const char *newval)
 
 	strncpy(mod->path, path, PATH_MAX);
 
-	if (!fread(mod->oldval, 1, MAX_PROC_VALUE_LEN, f)) {
+	mod->oldlen = fread(mod->oldval, 1, MAX_PROC_VALUE_LEN, f);
+	if (mod->oldlen < 0) {
 		log_err("reading from %s failed", path);
 		goto fail;
 	}
@@ -238,14 +248,15 @@ static int get_ifindex(const char *name)
 static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
 	char veth_src_fwd_addr[IFADDR_STR_LEN+1] = {};
-	char veth_dst_fwd_addr[IFADDR_STR_LEN+1] = {};
 
 	SYS("ip link add veth_src type veth peer name veth_src_fwd");
 	SYS("ip link add veth_dst type veth peer name veth_dst_fwd");
+
+	SYS("ip link set veth_dst_fwd address " MAC_DST_FWD);
+	SYS("ip link set veth_dst address " MAC_DST);
+
 	if (get_ifaddr("veth_src_fwd", veth_src_fwd_addr))
 		goto fail;
-	if (get_ifaddr("veth_dst_fwd", veth_dst_fwd_addr))
-		goto fail;
 
 	result->ifindex_veth_src_fwd = get_ifindex("veth_src_fwd");
 	if (result->ifindex_veth_src_fwd < 0)
@@ -306,10 +317,8 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS("ip route add " IP4_NET "/16 dev veth_dst scope global");
 	SYS("ip route add " IP6_SRC "/128 dev veth_dst scope global");
 
-	SYS("ip neigh add " IP4_SRC " dev veth_dst lladdr %s",
-	    veth_dst_fwd_addr);
-	SYS("ip neigh add " IP6_SRC " dev veth_dst lladdr %s",
-	    veth_dst_fwd_addr);
+	SYS("ip neigh add " IP4_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+	SYS("ip neigh add " IP6_SRC " dev veth_dst lladdr " MAC_DST_FWD);
 
 	setns_root();
 	return 0;
@@ -560,6 +569,206 @@ static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 	setns_root();
 }
 
+
+static int tun_open(char *name)
+{
+	struct ifreq ifr;
+	int fd, err;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0)
+		return -1;
+
+	memset(&ifr, 0, sizeof(ifr));
+
+	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
+	if (*name)
+		strncpy(ifr.ifr_name, name, IFNAMSIZ);
+
+	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
+	if (!ASSERT_OK(err, "ioctl TUNSETIFF"))
+		goto fail;
+
+	SYS("ip link set dev %s up", name);
+
+	return fd;
+fail:
+	close(fd);
+	return -1;
+}
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+enum {
+	SRC_TO_TARGET = 0,
+	TARGET_TO_SRC = 1,
+};
+
+static int tun_relay_loop(int src_fd, int target_fd)
+{
+	fd_set rfds, wfds;
+
+	FD_ZERO(&rfds);
+	FD_ZERO(&wfds);
+
+	for (;;) {
+		char buf[1500];
+		int direction, nread, nwrite;
+
+		FD_SET(src_fd, &rfds);
+		FD_SET(target_fd, &rfds);
+
+		if (select(1 + MAX(src_fd, target_fd), &rfds, NULL, NULL, NULL) < 0) {
+			fprintf(stderr, "select failed: %s\n", strerror(errno));
+			return 1;
+		}
+
+		direction = FD_ISSET(src_fd, &rfds) ? SRC_TO_TARGET : TARGET_TO_SRC;
+
+		nread = read(direction == SRC_TO_TARGET ? src_fd : target_fd, buf, sizeof(buf));
+		if (nread < 0) {
+			fprintf(stderr, "read failed: %s\n", strerror(errno));
+			return 1;
+		}
+
+		nwrite = write(direction == SRC_TO_TARGET ? target_fd : src_fd, buf, nread);
+		if (nwrite != nread) {
+			fprintf(stderr, "write failed: %s\n", strerror(errno));
+			return 1;
+		}
+	}
+}
+
+static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
+{
+	struct test_tc_peer *skel;
+	int err, tunnel_pid = -1;
+	int src_fd, target_fd;
+
+	skel = test_tc_peer__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
+		return;
+
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_veth_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
+
+	err = test_tc_peer__load(skel);
+	if (!ASSERT_OK(err, "test_tc_peer__load")) {
+		test_tc_peer__destroy(skel);
+		return;
+	}
+
+	err = bpf_program__pin(skel->progs.tc_src_l3, SRC_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE)) {
+		test_tc_peer__destroy(skel);
+		return;
+	}
+
+	/* Start a L3 TUN/TAP tunnel between the src and dst namespaces.
+	 * This test is using TUN/TAP instead of e.g. IPIP or GRE tunnel as those
+	 * expose the L2 headers encapsulating the IP packet to BPF and hence
+	 * don't have skb in suitable state for this test. Alternative to TUN/TAP
+	 * would be e.g. Wireguard which would appear as a pure L3 device to BPF,
+	 * but that requires much more complicated setup.
+	 */
+	if (!ASSERT_OK(setns_by_name(NS_SRC), "setns " NS_SRC))
+		goto fail;
+
+	src_fd = tun_open("tun_src");
+	if (!ASSERT_GE(src_fd, 0, "alloc tun_src"))
+		goto fail;
+
+	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns " NS_FWD))
+		goto fail;
+
+	target_fd = tun_open("tun_fwd");
+	if (!ASSERT_GE(target_fd, 0, "alloc tun_fwd"))
+		goto fail;
+
+	tunnel_pid = fork();
+	if (!ASSERT_GE(tunnel_pid, 0, "fork tun_relay_loop"))
+		goto fail;
+
+	if (tunnel_pid == 0)
+		exit(tun_relay_loop(src_fd, target_fd));
+
+	setns_root();
+
+	/* Load "tc_src_l3" to the tun_fwd interface to redirect packets */
+	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns " NS_FWD))
+		goto fail;
+
+	SYS("tc qdisc add dev tun_fwd clsact");
+	SYS("tc filter add dev tun_fwd ingress bpf da object-pinned "
+	    SRC_PROG_PIN_FILE);
+
+	/* Setup route and neigh tables */
+	SYS("ip -netns " NS_SRC " addr add dev tun_src " IP4_TUN_SRC "/24");
+	SYS("ip -netns " NS_FWD " addr add dev tun_fwd " IP4_TUN_FWD "/24");
+
+	SYS("ip -netns " NS_SRC " addr add dev tun_src " IP6_TUN_SRC "/64 nodad");
+	SYS("ip -netns " NS_FWD " addr add dev tun_fwd " IP6_TUN_FWD "/64 nodad");
+
+	SYS("ip -netns " NS_SRC " route del " IP4_DST "/32 dev veth_src scope global");
+	SYS("ip -netns " NS_SRC " route add " IP4_DST "/32 via " IP4_TUN_FWD
+	    " dev tun_src scope global");
+	SYS("ip -netns " NS_DST " route add " IP4_TUN_SRC "/32 dev veth_dst scope global");
+	SYS("ip -netns " NS_SRC " route del " IP6_DST "/128 dev veth_src scope global");
+	SYS("ip -netns " NS_SRC " route add " IP6_DST "/128 via " IP6_TUN_FWD
+	    " dev tun_src scope global");
+	SYS("ip -netns " NS_DST " route add " IP6_TUN_SRC "/128 dev veth_dst scope global");
+	SYS("ip -netns " NS_DST " route add " IP6_TUN_FWD "/128 dev veth_dst scope global");
+
+	SYS("ip -netns " NS_DST " neigh add " IP4_TUN_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+	SYS("ip -netns " NS_DST " neigh add " IP6_TUN_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+	SYS("ip -netns " NS_DST " neigh add " IP6_TUN_FWD " dev veth_dst lladdr " MAC_DST_FWD);
+
+	/* Enable forwarding back to wards src, but not the other way in order to require the
+	 * BPF redirection.
+	 */
+	err = modify_proc("/proc/sys/net/ipv4/ip_forward", "1");
+	if (!ASSERT_OK(err, "set ipv4.ip_forward"))
+		goto fail;
+
+	err = modify_proc("/proc/sys/net/ipv4/conf/veth_src_fwd/forwarding", "0");
+	if (!ASSERT_OK(err, "set veth_src_fwd.forwarding"))
+		goto fail;
+
+	err = modify_proc("/proc/sys/net/ipv4/conf/tun_fwd/forwarding", "0");
+	if (!ASSERT_OK(err, "set veth_src_fwd.forwarding"))
+		goto fail;
+
+	err = modify_proc("/proc/sys/net/ipv6/conf/all/forwarding", "1");
+	if (!ASSERT_OK(err, "set ipv6.forwarding"))
+		goto fail;
+
+	err = modify_proc("/proc/sys/net/ipv6/conf/veth_src_fwd/forwarding", "0");
+	if (!ASSERT_OK(err, "set ipv6.forwarding"))
+		goto fail;
+
+	err = modify_proc("/proc/sys/net/ipv6/conf/tun_fwd/forwarding", "0");
+	if (!ASSERT_OK(err, "set ipv6.forwarding"))
+		goto fail;
+
+	setns_root();
+
+	test_connectivity();
+
+fail:
+	setns_by_name(NS_FWD);
+	restore_proc();
+	setns_root();
+	if (tunnel_pid > 0) {
+		kill(tunnel_pid, SIGTERM);
+		waitpid(tunnel_pid, NULL, 0);
+	}
+	if (src_fd >= 0)
+		close(src_fd);
+	if (target_fd >= 0)
+		close(target_fd);
+	bpf_program__unpin(skel->progs.tc_src_l3, SRC_PROG_PIN_FILE);
+	test_tc_peer__destroy(skel);
+}
+
 void test_tc_redirect(void)
 {
 	struct netns_setup_result setup_result;
@@ -577,6 +786,9 @@ void test_tc_redirect(void)
 	if (test__start_subtest("tc_redirect_peer"))
 		test_tc_redirect_peer(&setup_result);
 
+	if (test__start_subtest("tc_redirect_peer_l3"))
+		test_tc_redirect_peer_l3(&setup_result);
+
 	if (test__start_subtest("tc_redirect_neigh"))
 		test_tc_redirect_neigh(&setup_result);
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index 72c72950c3bb..aea7bec5a1ab 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -5,12 +5,18 @@
 #include <linux/bpf.h>
 #include <linux/stddef.h>
 #include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
 
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
 
 static volatile const __u32 IFINDEX_SRC;
 static volatile const __u32 IFINDEX_DST;
 
+static const __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
+static const __u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
+
 SEC("classifier/chk_egress")
 int tc_chk(struct __sk_buff *skb)
 {
@@ -29,4 +35,24 @@ int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
+SEC("classifier/src_ingress_l3")
+int tc_src_l3(struct __sk_buff *skb)
+{
+	__u16 proto = skb->protocol;
+
+	if (bpf_skb_change_head(skb, ETH_HLEN, 0) != 0)
+		return TC_ACT_SHOT;
+
+	if (bpf_skb_store_bytes(skb, 0, &src_mac, ETH_ALEN, 0) != 0)
+		return TC_ACT_SHOT;
+
+	if (bpf_skb_store_bytes(skb, ETH_ALEN, &dst_mac, ETH_ALEN, 0) != 0)
+		return TC_ACT_SHOT;
+
+	if (bpf_skb_store_bytes(skb, ETH_ALEN + ETH_ALEN, &proto, sizeof(__u16), 0) != 0)
+		return TC_ACT_SHOT;
+
+	return bpf_redirect_peer(IFINDEX_DST, 0);
+}
+
 char __license[] SEC("license") = "GPL";
-- 
2.30.2

