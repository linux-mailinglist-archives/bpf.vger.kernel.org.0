Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA94438FEF9
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEYKYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 06:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEYKYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 06:24:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2833BC061574
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 03:23:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b7so15831755wmh.5
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMS8iIdobCtaptRmgJD0nFF2xUY0oQ7PKnIbPcfyTR4=;
        b=ntLZWlcOYF7FTvDZv2KXYWD1JLFXqqJBI4dxzNQDSsr1Inc+hLcr4UHvU1lxLReLCG
         bSjd41brMawsNS8/57j3YYGSTk3//etjNx3IV6X013EjbNgYOsYT0/fjQOv8Lt1my8Yt
         5H9oWzjzDQsYdNzJ8lmcPA7Mn5hpnU9nQ8jP5uGNf7LdF+pQNwbVwM9neJe2nMy9eZku
         r8Ir5Y/2Pr1qEZYBXLswF9QPddIvG3VNO8muwwstcXcRTfmE40nZu7ogIhU1FJ1CpmQx
         3pU7SkjIlMVanCe98u1H2jsXae3NLPx4X4XX/wuU0fiNCrnNZEZGsZk8xsIeDy9uWCD4
         DCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMS8iIdobCtaptRmgJD0nFF2xUY0oQ7PKnIbPcfyTR4=;
        b=HEwJNWKf4hFwc5yL4B7kvB6r5mTi3tSZigV7BDHzl3FYi1b0Gd98uSeQAAMnxhwsUV
         zpNqErJ3AB/3Zfn3RUbMmitfYqlAkgUfqqxk0rBNkH7gNaYm6ikJdB4HnpPG3CMhTyVS
         no22O5h5xmnsZVR0RglFR7e2ln88QhenAdrrF5gjlLISAdGyEdcfUM9mUthZuSKO3GHE
         mL+qWieXcP5xThBaQuGwT8fn1MA2BEP9G70QP+0ksnYEN8VPoir7+XTtbXulX5+Gt3W1
         YbhOOos5ySNCrrziKHrqEP0BD3bltv9LhPBT6reklNw2bkvi6lPmevZCHoUhQkn0m7kY
         YW4Q==
X-Gm-Message-State: AOAM533lMnrtPt2m3MsI307mXqOfTESdLO+6wkC6FnJ27xvMOXiTkmg9
        HEuBhLr/UAYbA1Y6CLBszh+Sete/A2Nl
X-Google-Smtp-Source: ABdhPJySgUBdD9cZnG9VrBNBTBA+inIJZOqi21NgVhw6Zr5u1sxRkJ1HFDmlYZDMtKoBdDso/mzICg==
X-Received: by 2002:a05:600c:2114:: with SMTP id u20mr3196856wml.124.1621938183724;
        Tue, 25 May 2021 03:23:03 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id p14sm15343280wrm.70.2021.05.25.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:23:03 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf v5] selftests/bpf: Add test for l3 use of bpf_redirect_peer
Date:   Tue, 25 May 2021 10:22:55 +0000
Message-Id: <20210525102255.2808518-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <15663d70-b984-28a6-9326-f0711f11e423@iogearbox.net>
References: <15663d70-b984-28a6-9326-f0711f11e423@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test case for using bpf_skb_change_head in combination with
bpf_redirect_peer to redirect a packet from a L3 device to veth and back.

The test uses a BPF program that adds L2 headers to the packet coming
from a L3 device and then calls bpf_redirect_peer to redirect the packet
to a veth device. The test fails as skb->mac_len is not set properly and
thus the ethernet headers are not properly skb_pull'd in cls_bpf_classify,
causing tcp_v4_rcv to point the TCP header into middle of the IP header.

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 553 ++++++++++++------
 .../selftests/bpf/progs/test_tc_peer.c        |  31 +
 2 files changed, 406 insertions(+), 178 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 95ef9fcd31d8..1b42b15c390e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -11,14 +11,17 @@
  */
 
 #define _GNU_SOURCE
-#include <fcntl.h>
+
+#include <arpa/inet.h>
 #include <linux/limits.h>
 #include <linux/sysctl.h>
+#include <linux/if_tun.h>
+#include <linux/if.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <sys/stat.h>
-#include <sys/types.h>
+#include <sys/mount.h>
 
 #include "test_progs.h"
 #include "network_helpers.h"
@@ -32,18 +35,25 @@
 
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
-#define PING_ARGS "-c 3 -w 10 -q"
+#define PING_ARGS "-i 0.2 -c 3 -w 10 -q"
 
 #define SRC_PROG_PIN_FILE "/sys/fs/bpf/test_tc_src"
 #define DST_PROG_PIN_FILE "/sys/fs/bpf/test_tc_dst"
@@ -51,120 +61,104 @@
 
 #define TIMEOUT_MILLIS 10000
 
-#define MAX_PROC_MODS 128
-#define MAX_PROC_VALUE_LEN 16
-
 #define log_err(MSG, ...) \
 	fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
 		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
 
-struct proc_mod {
-	char path[PATH_MAX];
-	char oldval[MAX_PROC_VALUE_LEN];
-	int oldlen;
-};
-
 static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
-static int root_netns_fd = -1;
-static int num_proc_mods;
-static struct proc_mod proc_mods[MAX_PROC_MODS];
 
-/**
- * modify_proc() - Modify entry in /proc
- *
- * Modifies an entry in /proc and saves the original value for later
- * restoration with restore_proc().
- */
-static int modify_proc(const char *path, const char *newval)
+static int write_file(const char *path, const char *newval)
 {
-	struct proc_mod *mod;
 	FILE *f;
 
-	if (num_proc_mods + 1 > MAX_PROC_MODS)
-		return -1;
-
 	f = fopen(path, "r+");
 	if (!f)
 		return -1;
-
-	mod = &proc_mods[num_proc_mods];
-	num_proc_mods++;
-
-	strncpy(mod->path, path, PATH_MAX);
-
-	if (!fread(mod->oldval, 1, MAX_PROC_VALUE_LEN, f)) {
-		log_err("reading from %s failed", path);
-		goto fail;
-	}
-	rewind(f);
 	if (fwrite(newval, strlen(newval), 1, f) != 1) {
 		log_err("writing to %s failed", path);
-		goto fail;
+		fclose(f);
+		return -1;
 	}
-
 	fclose(f);
 	return 0;
-
-fail:
-	fclose(f);
-	num_proc_mods--;
-	return -1;
 }
 
-/**
- * restore_proc() - Restore all /proc modifications
- */
-static void restore_proc(void)
+struct nstoken {
+	int orig_netns_fd;
+};
+
+static int setns_by_fd(int nsfd)
 {
-	int i;
+	int err;
 
-	for (i = 0; i < num_proc_mods; i++) {
-		struct proc_mod *mod = &proc_mods[i];
-		FILE *f;
+	err = setns(nsfd, CLONE_NEWNET);
+	close(nsfd);
 
-		f = fopen(mod->path, "w");
-		if (!f) {
-			log_err("fopen of %s failed", mod->path);
-			continue;
-		}
+	if (!ASSERT_OK(err, "setns"))
+		return err;
 
-		if (fwrite(mod->oldval, mod->oldlen, 1, f) != 1)
-			log_err("fwrite to %s failed", mod->path);
+	/* Switch /sys to the new namespace so that e.g. /sys/class/net
+	 * reflects the devices in the new namespace.
+	 */
+	err = unshare(CLONE_NEWNS);
+	if (!ASSERT_OK(err, "unshare"))
+		return err;
 
-		fclose(f);
-	}
-	num_proc_mods = 0;
+	err = umount2("/sys", MNT_DETACH);
+	if (!ASSERT_OK(err, "umount2 /sys"))
+		return err;
+
+	err = mount("sysfs", "/sys", "sysfs", 0, NULL);
+	if (!ASSERT_OK(err, "mount /sys"))
+		return err;
+
+	err = mount("bpffs", "/sys/fs/bpf", "bpf", 0, NULL);
+	if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
+		return err;
+
+	return 0;
 }
 
 /**
- * setns_by_name() - Set networks namespace by name
+ * open_netns() - Switch to specified network namespace by name.
+ *
+ * Returns token with which to restore the original namespace
+ * using close_netns().
  */
-static int setns_by_name(const char *name)
+static struct nstoken *open_netns(const char *name)
 {
 	int nsfd;
 	char nspath[PATH_MAX];
 	int err;
+	struct nstoken *token;
+
+	token = malloc(sizeof(struct nstoken));
+	if (!ASSERT_OK_PTR(token, "malloc token"))
+		return NULL;
+
+	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
+		goto fail;
 
 	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
 	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
-	if (nsfd < 0)
-		return nsfd;
+	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
+		goto fail;
 
-	err = setns(nsfd, CLONE_NEWNET);
-	close(nsfd);
+	err = setns_by_fd(nsfd);
+	if (!ASSERT_OK(err, "setns_by_fd"))
+		goto fail;
 
-	return err;
+	return token;
+fail:
+	free(token);
+	return NULL;
 }
 
-/**
- * setns_root() - Set network namespace to original (root) namespace
- *
- * Not expected to ever fail, so error not returned, but failure logged
- * and test marked as failed.
- */
-static void setns_root(void)
+static void close_netns(struct nstoken *token)
 {
-	ASSERT_OK(setns(root_netns_fd, CLONE_NEWNET), "setns root");
+	ASSERT_OK(setns_by_fd(token->orig_netns_fd), "setns_by_fd");
+	free(token);
 }
 
 static int netns_setup_namespaces(const char *verb)
@@ -237,15 +231,17 @@ static int get_ifindex(const char *name)
 
 static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
+	struct nstoken *nstoken = NULL;
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
@@ -260,7 +256,8 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS("ip link set veth_dst netns " NS_DST);
 
 	/** setup in 'src' namespace */
-	if (!ASSERT_OK(setns_by_name(NS_SRC), "setns src"))
+	nstoken = open_netns(NS_SRC);
+	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto fail;
 
 	SYS("ip addr add " IP4_SRC "/32 dev veth_src");
@@ -276,8 +273,11 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS("ip neigh add " IP6_DST " dev veth_src lladdr %s",
 	    veth_src_fwd_addr);
 
+	close_netns(nstoken);
+
 	/** setup in 'fwd' namespace */
-	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
 		goto fail;
 
 	/* The fwd netns automatically gets a v6 LL address / routes, but also
@@ -294,8 +294,11 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS("ip route add " IP4_DST "/32 dev veth_dst_fwd scope global");
 	SYS("ip route add " IP6_DST "/128 dev veth_dst_fwd scope global");
 
+	close_netns(nstoken);
+
 	/** setup in 'dst' namespace */
-	if (!ASSERT_OK(setns_by_name(NS_DST), "setns dst"))
+	nstoken = open_netns(NS_DST);
+	if (!ASSERT_OK_PTR(nstoken, "setns dst"))
 		goto fail;
 
 	SYS("ip addr add " IP4_DST "/32 dev veth_dst");
@@ -306,23 +309,20 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS("ip route add " IP4_NET "/16 dev veth_dst scope global");
 	SYS("ip route add " IP6_SRC "/128 dev veth_dst scope global");
 
-	SYS("ip neigh add " IP4_SRC " dev veth_dst lladdr %s",
-	    veth_dst_fwd_addr);
-	SYS("ip neigh add " IP6_SRC " dev veth_dst lladdr %s",
-	    veth_dst_fwd_addr);
+	SYS("ip neigh add " IP4_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+	SYS("ip neigh add " IP6_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+
+	close_netns(nstoken);
 
-	setns_root();
 	return 0;
 fail:
-	setns_root();
+	if (nstoken)
+		close_netns(nstoken);
 	return -1;
 }
 
 static int netns_load_bpf(void)
 {
-	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
-		return -1;
-
 	SYS("tc qdisc add dev veth_src_fwd clsact");
 	SYS("tc filter add dev veth_src_fwd ingress bpf da object-pinned "
 	    SRC_PROG_PIN_FILE);
@@ -335,42 +335,29 @@ static int netns_load_bpf(void)
 	SYS("tc filter add dev veth_dst_fwd egress bpf da object-pinned "
 	    CHK_PROG_PIN_FILE);
 
-	setns_root();
-	return -1;
-fail:
-	setns_root();
-	return -1;
-}
-
-static int netns_unload_bpf(void)
-{
-	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
-		goto fail;
-	SYS("tc qdisc delete dev veth_src_fwd clsact");
-	SYS("tc qdisc delete dev veth_dst_fwd clsact");
-
-	setns_root();
 	return 0;
 fail:
-	setns_root();
 	return -1;
 }
 
-
 static void test_tcp(int family, const char *addr, __u16 port)
 {
 	int listen_fd = -1, accept_fd = -1, client_fd = -1;
 	char buf[] = "testing testing";
 	int n;
+	struct nstoken *nstoken;
 
-	if (!ASSERT_OK(setns_by_name(NS_DST), "setns dst"))
+	nstoken = open_netns(NS_DST);
+	if (!ASSERT_OK_PTR(nstoken, "setns dst"))
 		return;
 
 	listen_fd = start_server(family, SOCK_STREAM, addr, port, 0);
 	if (!ASSERT_GE(listen_fd, 0, "listen"))
 		goto done;
 
-	if (!ASSERT_OK(setns_by_name(NS_SRC), "setns src"))
+	close_netns(nstoken);
+	nstoken = open_netns(NS_SRC);
+	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
 
 	client_fd = connect_to_fd(listen_fd, TIMEOUT_MILLIS);
@@ -392,7 +379,8 @@ static void test_tcp(int family, const char *addr, __u16 port)
 	ASSERT_EQ(n, sizeof(buf), "recv from server");
 
 done:
-	setns_root();
+	if (nstoken)
+		close_netns(nstoken);
 	if (listen_fd >= 0)
 		close(listen_fd);
 	if (accept_fd >= 0)
@@ -405,7 +393,7 @@ static int test_ping(int family, const char *addr)
 {
 	const char *ping = family == AF_INET6 ? "ping6" : "ping";
 
-	SYS("ip netns exec " NS_SRC " %s " PING_ARGS " %s", ping, addr);
+	SYS("ip netns exec " NS_SRC " %s " PING_ARGS " %s > /dev/null", ping, addr);
 	return 0;
 fail:
 	return -1;
@@ -419,19 +407,37 @@ static void test_connectivity(void)
 	test_ping(AF_INET6, IP6_DST);
 }
 
+static int set_forwarding(bool enable)
+{
+	int err;
+
+	err = write_file("/proc/sys/net/ipv4/ip_forward", enable ? "1" : "0");
+	if (!ASSERT_OK(err, "set ipv4.ip_forward=0"))
+		return err;
+
+	err = write_file("/proc/sys/net/ipv6/conf/all/forwarding", enable ? "1" : "0");
+	if (!ASSERT_OK(err, "set ipv6.forwarding=0"))
+		return err;
+
+	return 0;
+}
+
 static void test_tc_redirect_neigh_fib(struct netns_setup_result *setup_result)
 {
-	struct test_tc_neigh_fib *skel;
+	struct nstoken *nstoken = NULL;
+	struct test_tc_neigh_fib *skel = NULL;
 	int err;
 
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
+		return;
+
 	skel = test_tc_neigh_fib__open();
 	if (!ASSERT_OK_PTR(skel, "test_tc_neigh_fib__open"))
-		return;
+		goto done;
 
-	if (!ASSERT_OK(test_tc_neigh_fib__load(skel), "test_tc_neigh_fib__load")) {
-		test_tc_neigh_fib__destroy(skel);
-		return;
-	}
+	if (!ASSERT_OK(test_tc_neigh_fib__load(skel), "test_tc_neigh_fib__load"))
+		goto done;
 
 	err = bpf_program__pin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
 	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE))
@@ -449,46 +455,37 @@ static void test_tc_redirect_neigh_fib(struct netns_setup_result *setup_result)
 		goto done;
 
 	/* bpf_fib_lookup() checks if forwarding is enabled */
-	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
+	if (!ASSERT_OK(set_forwarding(true), "enable forwarding"))
 		goto done;
 
-	err = modify_proc("/proc/sys/net/ipv4/ip_forward", "1");
-	if (!ASSERT_OK(err, "set ipv4.ip_forward"))
-		goto done;
-
-	err = modify_proc("/proc/sys/net/ipv6/conf/all/forwarding", "1");
-	if (!ASSERT_OK(err, "set ipv6.forwarding"))
-		goto done;
-	setns_root();
-
 	test_connectivity();
+
 done:
-	bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
-	bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
-	bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
-	test_tc_neigh_fib__destroy(skel);
-	netns_unload_bpf();
-	setns_root();
-	restore_proc();
+	if (skel)
+		test_tc_neigh_fib__destroy(skel);
+	close_netns(nstoken);
 }
 
 static void test_tc_redirect_neigh(struct netns_setup_result *setup_result)
 {
-	struct test_tc_neigh *skel;
+	struct nstoken *nstoken = NULL;
+	struct test_tc_neigh *skel = NULL;
 	int err;
 
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
+		return;
+
 	skel = test_tc_neigh__open();
 	if (!ASSERT_OK_PTR(skel, "test_tc_neigh__open"))
-		return;
+		goto done;
 
 	skel->rodata->IFINDEX_SRC = setup_result->ifindex_veth_src_fwd;
 	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
 
 	err = test_tc_neigh__load(skel);
-	if (!ASSERT_OK(err, "test_tc_neigh__load")) {
-		test_tc_neigh__destroy(skel);
-		return;
-	}
+	if (!ASSERT_OK(err, "test_tc_neigh__load"))
+		goto done;
 
 	err = bpf_program__pin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
 	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE))
@@ -505,34 +502,37 @@ static void test_tc_redirect_neigh(struct netns_setup_result *setup_result)
 	if (netns_load_bpf())
 		goto done;
 
+	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
+		goto done;
+
 	test_connectivity();
 
 done:
-	bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
-	bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
-	bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
-	test_tc_neigh__destroy(skel);
-	netns_unload_bpf();
-	setns_root();
+	if (skel)
+		test_tc_neigh__destroy(skel);
+	close_netns(nstoken);
 }
 
 static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 {
+	struct nstoken *nstoken;
 	struct test_tc_peer *skel;
 	int err;
 
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
+		return;
+
 	skel = test_tc_peer__open();
 	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
-		return;
+		goto done;
 
 	skel->rodata->IFINDEX_SRC = setup_result->ifindex_veth_src_fwd;
 	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
 
 	err = test_tc_peer__load(skel);
-	if (!ASSERT_OK(err, "test_tc_peer__load")) {
-		test_tc_peer__destroy(skel);
-		return;
-	}
+	if (!ASSERT_OK(err, "test_tc_peer__load"))
+		goto done;
 
 	err = bpf_program__pin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
 	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE))
@@ -549,41 +549,238 @@ static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 	if (netns_load_bpf())
 		goto done;
 
+	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
+		goto done;
+
 	test_connectivity();
 
 done:
-	bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
-	bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
-	bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
-	test_tc_peer__destroy(skel);
-	netns_unload_bpf();
-	setns_root();
+	if (skel)
+		test_tc_peer__destroy(skel);
+	close_netns(nstoken);
 }
 
-void test_tc_redirect(void)
+static int tun_open(char *name)
+{
+	struct ifreq ifr;
+	int fd, err;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (!ASSERT_GE(fd, 0, "open /dev/net/tun"))
+		return -1;
+
+	memset(&ifr, 0, sizeof(ifr));
+
+	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
+	if (*name)
+		strncpy(ifr.ifr_name, name, IFNAMSIZ);
+
+	err = ioctl(fd, TUNSETIFF, &ifr);
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
 {
-	struct netns_setup_result setup_result;
+	fd_set rfds, wfds;
+
+	FD_ZERO(&rfds);
+	FD_ZERO(&wfds);
 
-	root_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (!ASSERT_GE(root_netns_fd, 0, "open /proc/self/ns/net"))
+	for (;;) {
+		char buf[1500];
+		int direction, nread, nwrite;
+
+		FD_SET(src_fd, &rfds);
+		FD_SET(target_fd, &rfds);
+
+		if (select(1 + MAX(src_fd, target_fd), &rfds, NULL, NULL, NULL) < 0) {
+			log_err("select failed");
+			return 1;
+		}
+
+		direction = FD_ISSET(src_fd, &rfds) ? SRC_TO_TARGET : TARGET_TO_SRC;
+
+		nread = read(direction == SRC_TO_TARGET ? src_fd : target_fd, buf, sizeof(buf));
+		if (nread < 0) {
+			log_err("read failed");
+			return 1;
+		}
+
+		nwrite = write(direction == SRC_TO_TARGET ? target_fd : src_fd, buf, nread);
+		if (nwrite != nread) {
+			log_err("write failed");
+			return 1;
+		}
+	}
+}
+
+static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
+{
+	struct test_tc_peer *skel = NULL;
+	struct nstoken *nstoken = NULL;
+	int err;
+	int tunnel_pid = -1;
+	int src_fd, target_fd;
+	int ifindex;
+
+	/* Start a L3 TUN/TAP tunnel between the src and dst namespaces.
+	 * This test is using TUN/TAP instead of e.g. IPIP or GRE tunnel as those
+	 * expose the L2 headers encapsulating the IP packet to BPF and hence
+	 * don't have skb in suitable state for this test. Alternative to TUN/TAP
+	 * would be e.g. Wireguard which would appear as a pure L3 device to BPF,
+	 * but that requires much more complicated setup.
+	 */
+	nstoken = open_netns(NS_SRC);
+	if (!ASSERT_OK_PTR(nstoken, "setns " NS_SRC))
 		return;
 
-	if (netns_setup_namespaces("add"))
-		goto done;
+	src_fd = tun_open("tun_src");
+	if (!ASSERT_GE(src_fd, 0, "tun_open tun_src"))
+		goto fail;
 
-	if (netns_setup_links_and_routes(&setup_result))
-		goto done;
+	close_netns(nstoken);
+
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns " NS_FWD))
+		goto fail;
 
-	if (test__start_subtest("tc_redirect_peer"))
-		test_tc_redirect_peer(&setup_result);
+	target_fd = tun_open("tun_fwd");
+	if (!ASSERT_GE(target_fd, 0, "tun_open tun_fwd"))
+		goto fail;
 
-	if (test__start_subtest("tc_redirect_neigh"))
-		test_tc_redirect_neigh(&setup_result);
+	tunnel_pid = fork();
+	if (!ASSERT_GE(tunnel_pid, 0, "fork tun_relay_loop"))
+		goto fail;
 
-	if (test__start_subtest("tc_redirect_neigh_fib"))
-		test_tc_redirect_neigh_fib(&setup_result);
+	if (tunnel_pid == 0)
+		exit(tun_relay_loop(src_fd, target_fd));
 
-done:
-	close(root_netns_fd);
-	netns_setup_namespaces("delete");
+	skel = test_tc_peer__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
+		goto fail;
+
+	ifindex = get_ifindex("tun_fwd");
+	if (!ASSERT_GE(ifindex, 0, "get_ifindex tun_fwd"))
+		goto fail;
+
+	skel->rodata->IFINDEX_SRC = ifindex;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
+
+	err = test_tc_peer__load(skel);
+	if (!ASSERT_OK(err, "test_tc_peer__load"))
+		goto fail;
+
+	err = bpf_program__pin(skel->progs.tc_src_l3, SRC_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE))
+		goto fail;
+
+	err = bpf_program__pin(skel->progs.tc_dst_l3, DST_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " DST_PROG_PIN_FILE))
+		goto fail;
+
+	err = bpf_program__pin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " CHK_PROG_PIN_FILE))
+		goto fail;
+
+	/* Load "tc_src_l3" to the tun_fwd interface to redirect packets
+	 * towards dst, and "tc_dst" to redirect packets
+	 * and "tc_chk" on veth_dst_fwd to drop non-redirected packets.
+	 */
+	SYS("tc qdisc add dev tun_fwd clsact");
+	SYS("tc filter add dev tun_fwd ingress bpf da object-pinned "
+	    SRC_PROG_PIN_FILE);
+
+	SYS("tc qdisc add dev veth_dst_fwd clsact");
+	SYS("tc filter add dev veth_dst_fwd ingress bpf da object-pinned "
+	    DST_PROG_PIN_FILE);
+	SYS("tc filter add dev veth_dst_fwd egress bpf da object-pinned "
+	    CHK_PROG_PIN_FILE);
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
+
+	SYS("ip -netns " NS_DST " neigh add " IP4_TUN_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+	SYS("ip -netns " NS_DST " neigh add " IP6_TUN_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+
+	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
+		goto fail;
+
+	test_connectivity();
+
+fail:
+	if (tunnel_pid > 0) {
+		kill(tunnel_pid, SIGTERM);
+		waitpid(tunnel_pid, NULL, 0);
+	}
+	if (src_fd >= 0)
+		close(src_fd);
+	if (target_fd >= 0)
+		close(target_fd);
+	if (skel)
+		test_tc_peer__destroy(skel);
+	if (nstoken)
+		close_netns(nstoken);
 }
+
+#define RUN_TEST(name)                                                                      \
+	({                                                                                  \
+		struct netns_setup_result setup_result;                                     \
+		if (test__start_subtest(#name))                                             \
+			if (ASSERT_OK(netns_setup_namespaces("add"), "setup namespaces")) { \
+				if (ASSERT_OK(netns_setup_links_and_routes(&setup_result),  \
+					      "setup links and routes"))                    \
+					test_ ## name(&setup_result);                       \
+				netns_setup_namespaces("delete");                           \
+			}                                                                   \
+	})
+
+static void *test_tc_redirect_run_tests(void *arg)
+{
+	RUN_TEST(tc_redirect_peer);
+	RUN_TEST(tc_redirect_peer_l3);
+	RUN_TEST(tc_redirect_neigh);
+	RUN_TEST(tc_redirect_neigh_fib);
+	return NULL;
+}
+
+void test_tc_redirect(void)
+{
+	pthread_t test_thread;
+	int err;
+
+	/* Run the tests in their own thread to isolate the namespace changes
+	 * so they do not affect the environment of other tests.
+	 * (specifically needed because of unshare(CLONE_NEWNS) in open_netns())
+	 */
+	err = pthread_create(&test_thread, NULL, &test_tc_redirect_run_tests, NULL);
+	if (ASSERT_OK(err, "pthread_create"))
+		ASSERT_OK(pthread_join(test_thread, NULL), "pthread_join");
+}
+
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index ef264bced0e6..fe818cd5f010 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -5,12 +5,17 @@
 #include <linux/bpf.h>
 #include <linux/stddef.h>
 #include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
 
 #include <bpf/bpf_helpers.h>
 
 volatile const __u32 IFINDEX_SRC;
 volatile const __u32 IFINDEX_DST;
 
+static const __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
+static const __u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
+
 SEC("classifier/chk_egress")
 int tc_chk(struct __sk_buff *skb)
 {
@@ -29,4 +34,30 @@ int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
+SEC("classifier/dst_ingress_l3")
+int tc_dst_l3(struct __sk_buff *skb)
+{
+	return bpf_redirect(IFINDEX_SRC, 0);
+}
+
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

