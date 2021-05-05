Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89F83736AA
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEEJAi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 05:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhEEJAi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 05:00:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75B9C061574
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 01:59:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so647902wmh.4
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HspVwC6iWu5oG2eMtz7y4pi/RzsKWEp5yVJkmQYfvuU=;
        b=JGeBXcr6gCyGWk+/0Iukw6+Tol4z9rRQ/lmQCNNwNOfRZLKu096hevqrMLDfsbgYmv
         YNJYKz3O/hJXdls0UuKmehkofATS7pArj/G65T5pvHieLCLDVxSFp7b9kPYTVltHfSkr
         ZntPydg/GP1Aq4pKeHtTHDnIrq5ppuhMYm/xIKa2n4A6tFOZQq96sjeWQJgtDCIXPqjk
         lFTeWoCbC1H+S+tfRA9Kh0YLKRa1ro4MD/LPpqaKKedxt+uI2FXkZ6Sy1hcoQiQNYI1c
         gj08GCaWRuC+VPF28h7yQO2S1hdAK4b61tpbIBTtg+sBtCLU1YPQFprybADv83w4S0kW
         kabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HspVwC6iWu5oG2eMtz7y4pi/RzsKWEp5yVJkmQYfvuU=;
        b=I2ywuhdM0J3o9/mwX521cCk5akuNyATEL7NhpxtcBfXKB6C5WJVyHCxutubC01hDDY
         sOPyPLeHBhhHV29+HsyqvlRhz7kVY5Vl4ocBbpxCQqQ4CH5xrvNzcHAD7oGdWLuoiAcV
         /RlD2MopkPY3OCUgvV1mpXjZCfffwm23yHYzc0ipauLzAtkfYThThmfI9OyguCVR8Dzh
         T4EeqrEkflXYFBngwluZ/PwKg62XsjpZVn4YK5Bes2iRqjWNzuc5iSL1N7c4zEJ2bX1h
         WptEIyY5iW78621x0uFaHuRplgaYdwGnfqZz4WgH5ZKSEZM520nplAGbPvt3McPlvvpR
         XZ4g==
X-Gm-Message-State: AOAM530JFAtGu7nJsL+FqITyvL+ZtPpoHjy/PkpDkcTVJQcojE8Y4T8O
        Zn8P78G+gmUYyDl7zuSOjPmPvy/vL1a4
X-Google-Smtp-Source: ABdhPJyn62+kXOke4IHBGPFbtD6iyeQYe/m0bm8IV5aHxxMezdC1DBOWbMQnQCzVgyf/j7jGJZAKfw==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr8889932wmc.188.1620205178460;
        Wed, 05 May 2021 01:59:38 -0700 (PDT)
Received: from balnab.. (212-51-151-38.fiber7.init7.net. [212.51.151.38])
        by smtp.gmail.com with ESMTPSA id n7sm18284854wri.14.2021.05.05.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 01:59:37 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf v3] selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.c
Date:   Wed,  5 May 2021 08:59:25 +0000
Message-Id: <20210505085925.783985-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210429153043.3145478-1-joamaki@gmail.com>
References: <20210429153043.3145478-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ports test_tc_redirect.sh to the test_progs framework and removes the
old test. This makes it more in line with rest of the tests and makes
it possible to run this test with vmtest.sh and under the bpf CI.

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/tc_redirect.c    | 589 ++++++++++++++++++
 .../selftests/bpf/progs/test_tc_neigh.c       |  33 +-
 .../selftests/bpf/progs/test_tc_neigh_fib.c   |   9 +-
 .../selftests/bpf/progs/test_tc_peer.c        |  33 +-
 .../testing/selftests/bpf/test_tc_redirect.sh | 216 -------
 7 files changed, 617 insertions(+), 266 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_redirect.c
 delete mode 100755 tools/testing/selftests/bpf/test_tc_redirect.sh

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 12ee40284da0..2060bc122c53 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -40,7 +40,7 @@ struct ipv6_packet pkt_v6 = {
 	.tcp.doff = 5,
 };
 
-static int settimeo(int fd, int timeout_ms)
+int settimeo(int fd, int timeout_ms)
 {
 	struct timeval timeout = { .tv_sec = 3 };
 
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 7205f8afdba1..5e0d51c07b63 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -33,6 +33,7 @@ struct ipv6_packet {
 } __packed;
 extern struct ipv6_packet pkt_v6;
 
+int settimeo(int fd, int timeout_ms);
 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
 int connect_to_fd(int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
new file mode 100644
index 000000000000..95ef9fcd31d8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/*
+ * This test sets up 3 netns (src <-> fwd <-> dst). There is no direct veth link
+ * between src and dst. The netns fwd has veth links to each src and dst. The
+ * client is in src and server in dst. The test installs a TC BPF program to each
+ * host facing veth in fwd which calls into i) bpf_redirect_neigh() to perform the
+ * neigh addr population and redirect or ii) bpf_redirect_peer() for namespace
+ * switch from ingress side; it also installs a checker prog on the egress side
+ * to drop unexpected traffic.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <linux/sysctl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "test_tc_neigh_fib.skel.h"
+#include "test_tc_neigh.skel.h"
+#include "test_tc_peer.skel.h"
+
+#define NS_SRC "ns_src"
+#define NS_FWD "ns_fwd"
+#define NS_DST "ns_dst"
+
+#define IP4_SRC "172.16.1.100"
+#define IP4_DST "172.16.2.100"
+#define IP4_PORT 9004
+
+#define IP6_SRC "::1:dead:beef:cafe"
+#define IP6_DST "::2:dead:beef:cafe"
+#define IP6_PORT 9006
+
+#define IP4_SLL "169.254.0.1"
+#define IP4_DLL "169.254.0.2"
+#define IP4_NET "169.254.0.0"
+
+#define IFADDR_STR_LEN 18
+#define PING_ARGS "-c 3 -w 10 -q"
+
+#define SRC_PROG_PIN_FILE "/sys/fs/bpf/test_tc_src"
+#define DST_PROG_PIN_FILE "/sys/fs/bpf/test_tc_dst"
+#define CHK_PROG_PIN_FILE "/sys/fs/bpf/test_tc_chk"
+
+#define TIMEOUT_MILLIS 10000
+
+#define MAX_PROC_MODS 128
+#define MAX_PROC_VALUE_LEN 16
+
+#define log_err(MSG, ...) \
+	fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
+		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
+
+struct proc_mod {
+	char path[PATH_MAX];
+	char oldval[MAX_PROC_VALUE_LEN];
+	int oldlen;
+};
+
+static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
+static int root_netns_fd = -1;
+static int num_proc_mods;
+static struct proc_mod proc_mods[MAX_PROC_MODS];
+
+/**
+ * modify_proc() - Modify entry in /proc
+ *
+ * Modifies an entry in /proc and saves the original value for later
+ * restoration with restore_proc().
+ */
+static int modify_proc(const char *path, const char *newval)
+{
+	struct proc_mod *mod;
+	FILE *f;
+
+	if (num_proc_mods + 1 > MAX_PROC_MODS)
+		return -1;
+
+	f = fopen(path, "r+");
+	if (!f)
+		return -1;
+
+	mod = &proc_mods[num_proc_mods];
+	num_proc_mods++;
+
+	strncpy(mod->path, path, PATH_MAX);
+
+	if (!fread(mod->oldval, 1, MAX_PROC_VALUE_LEN, f)) {
+		log_err("reading from %s failed", path);
+		goto fail;
+	}
+	rewind(f);
+	if (fwrite(newval, strlen(newval), 1, f) != 1) {
+		log_err("writing to %s failed", path);
+		goto fail;
+	}
+
+	fclose(f);
+	return 0;
+
+fail:
+	fclose(f);
+	num_proc_mods--;
+	return -1;
+}
+
+/**
+ * restore_proc() - Restore all /proc modifications
+ */
+static void restore_proc(void)
+{
+	int i;
+
+	for (i = 0; i < num_proc_mods; i++) {
+		struct proc_mod *mod = &proc_mods[i];
+		FILE *f;
+
+		f = fopen(mod->path, "w");
+		if (!f) {
+			log_err("fopen of %s failed", mod->path);
+			continue;
+		}
+
+		if (fwrite(mod->oldval, mod->oldlen, 1, f) != 1)
+			log_err("fwrite to %s failed", mod->path);
+
+		fclose(f);
+	}
+	num_proc_mods = 0;
+}
+
+/**
+ * setns_by_name() - Set networks namespace by name
+ */
+static int setns_by_name(const char *name)
+{
+	int nsfd;
+	char nspath[PATH_MAX];
+	int err;
+
+	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
+	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
+	if (nsfd < 0)
+		return nsfd;
+
+	err = setns(nsfd, CLONE_NEWNET);
+	close(nsfd);
+
+	return err;
+}
+
+/**
+ * setns_root() - Set network namespace to original (root) namespace
+ *
+ * Not expected to ever fail, so error not returned, but failure logged
+ * and test marked as failed.
+ */
+static void setns_root(void)
+{
+	ASSERT_OK(setns(root_netns_fd, CLONE_NEWNET), "setns root");
+}
+
+static int netns_setup_namespaces(const char *verb)
+{
+	const char * const *ns = namespaces;
+	char cmd[128];
+
+	while (*ns) {
+		snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
+		if (!ASSERT_OK(system(cmd), cmd))
+			return -1;
+		ns++;
+	}
+	return 0;
+}
+
+struct netns_setup_result {
+	int ifindex_veth_src_fwd;
+	int ifindex_veth_dst_fwd;
+};
+
+static int get_ifaddr(const char *name, char *ifaddr)
+{
+	char path[PATH_MAX];
+	FILE *f;
+	int ret;
+
+	snprintf(path, PATH_MAX, "/sys/class/net/%s/address", name);
+	f = fopen(path, "r");
+	if (!ASSERT_OK_PTR(f, path))
+		return -1;
+
+	ret = fread(ifaddr, 1, IFADDR_STR_LEN, f);
+	if (!ASSERT_EQ(ret, IFADDR_STR_LEN, "fread ifaddr")) {
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	return 0;
+}
+
+static int get_ifindex(const char *name)
+{
+	char path[PATH_MAX];
+	char buf[32];
+	FILE *f;
+	int ret;
+
+	snprintf(path, PATH_MAX, "/sys/class/net/%s/ifindex", name);
+	f = fopen(path, "r");
+	if (!ASSERT_OK_PTR(f, path))
+		return -1;
+
+	ret = fread(buf, 1, sizeof(buf), f);
+	if (!ASSERT_GT(ret, 0, "fread ifindex")) {
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	return atoi(buf);
+}
+
+#define SYS(fmt, ...)						\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (!ASSERT_OK(system(cmd), cmd))		\
+			goto fail;				\
+	})
+
+static int netns_setup_links_and_routes(struct netns_setup_result *result)
+{
+	char veth_src_fwd_addr[IFADDR_STR_LEN+1] = {};
+	char veth_dst_fwd_addr[IFADDR_STR_LEN+1] = {};
+
+	SYS("ip link add veth_src type veth peer name veth_src_fwd");
+	SYS("ip link add veth_dst type veth peer name veth_dst_fwd");
+	if (get_ifaddr("veth_src_fwd", veth_src_fwd_addr))
+		goto fail;
+	if (get_ifaddr("veth_dst_fwd", veth_dst_fwd_addr))
+		goto fail;
+
+	result->ifindex_veth_src_fwd = get_ifindex("veth_src_fwd");
+	if (result->ifindex_veth_src_fwd < 0)
+		goto fail;
+	result->ifindex_veth_dst_fwd = get_ifindex("veth_dst_fwd");
+	if (result->ifindex_veth_dst_fwd < 0)
+		goto fail;
+
+	SYS("ip link set veth_src netns " NS_SRC);
+	SYS("ip link set veth_src_fwd netns " NS_FWD);
+	SYS("ip link set veth_dst_fwd netns " NS_FWD);
+	SYS("ip link set veth_dst netns " NS_DST);
+
+	/** setup in 'src' namespace */
+	if (!ASSERT_OK(setns_by_name(NS_SRC), "setns src"))
+		goto fail;
+
+	SYS("ip addr add " IP4_SRC "/32 dev veth_src");
+	SYS("ip addr add " IP6_SRC "/128 dev veth_src nodad");
+	SYS("ip link set dev veth_src up");
+
+	SYS("ip route add " IP4_DST "/32 dev veth_src scope global");
+	SYS("ip route add " IP4_NET "/16 dev veth_src scope global");
+	SYS("ip route add " IP6_DST "/128 dev veth_src scope global");
+
+	SYS("ip neigh add " IP4_DST " dev veth_src lladdr %s",
+	    veth_src_fwd_addr);
+	SYS("ip neigh add " IP6_DST " dev veth_src lladdr %s",
+	    veth_src_fwd_addr);
+
+	/** setup in 'fwd' namespace */
+	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
+		goto fail;
+
+	/* The fwd netns automatically gets a v6 LL address / routes, but also
+	 * needs v4 one in order to start ARP probing. IP4_NET route is added
+	 * to the endpoints so that the ARP processing will reply.
+	 */
+	SYS("ip addr add " IP4_SLL "/32 dev veth_src_fwd");
+	SYS("ip addr add " IP4_DLL "/32 dev veth_dst_fwd");
+	SYS("ip link set dev veth_src_fwd up");
+	SYS("ip link set dev veth_dst_fwd up");
+
+	SYS("ip route add " IP4_SRC "/32 dev veth_src_fwd scope global");
+	SYS("ip route add " IP6_SRC "/128 dev veth_src_fwd scope global");
+	SYS("ip route add " IP4_DST "/32 dev veth_dst_fwd scope global");
+	SYS("ip route add " IP6_DST "/128 dev veth_dst_fwd scope global");
+
+	/** setup in 'dst' namespace */
+	if (!ASSERT_OK(setns_by_name(NS_DST), "setns dst"))
+		goto fail;
+
+	SYS("ip addr add " IP4_DST "/32 dev veth_dst");
+	SYS("ip addr add " IP6_DST "/128 dev veth_dst nodad");
+	SYS("ip link set dev veth_dst up");
+
+	SYS("ip route add " IP4_SRC "/32 dev veth_dst scope global");
+	SYS("ip route add " IP4_NET "/16 dev veth_dst scope global");
+	SYS("ip route add " IP6_SRC "/128 dev veth_dst scope global");
+
+	SYS("ip neigh add " IP4_SRC " dev veth_dst lladdr %s",
+	    veth_dst_fwd_addr);
+	SYS("ip neigh add " IP6_SRC " dev veth_dst lladdr %s",
+	    veth_dst_fwd_addr);
+
+	setns_root();
+	return 0;
+fail:
+	setns_root();
+	return -1;
+}
+
+static int netns_load_bpf(void)
+{
+	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
+		return -1;
+
+	SYS("tc qdisc add dev veth_src_fwd clsact");
+	SYS("tc filter add dev veth_src_fwd ingress bpf da object-pinned "
+	    SRC_PROG_PIN_FILE);
+	SYS("tc filter add dev veth_src_fwd egress bpf da object-pinned "
+	    CHK_PROG_PIN_FILE);
+
+	SYS("tc qdisc add dev veth_dst_fwd clsact");
+	SYS("tc filter add dev veth_dst_fwd ingress bpf da object-pinned "
+	    DST_PROG_PIN_FILE);
+	SYS("tc filter add dev veth_dst_fwd egress bpf da object-pinned "
+	    CHK_PROG_PIN_FILE);
+
+	setns_root();
+	return -1;
+fail:
+	setns_root();
+	return -1;
+}
+
+static int netns_unload_bpf(void)
+{
+	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
+		goto fail;
+	SYS("tc qdisc delete dev veth_src_fwd clsact");
+	SYS("tc qdisc delete dev veth_dst_fwd clsact");
+
+	setns_root();
+	return 0;
+fail:
+	setns_root();
+	return -1;
+}
+
+
+static void test_tcp(int family, const char *addr, __u16 port)
+{
+	int listen_fd = -1, accept_fd = -1, client_fd = -1;
+	char buf[] = "testing testing";
+	int n;
+
+	if (!ASSERT_OK(setns_by_name(NS_DST), "setns dst"))
+		return;
+
+	listen_fd = start_server(family, SOCK_STREAM, addr, port, 0);
+	if (!ASSERT_GE(listen_fd, 0, "listen"))
+		goto done;
+
+	if (!ASSERT_OK(setns_by_name(NS_SRC), "setns src"))
+		goto done;
+
+	client_fd = connect_to_fd(listen_fd, TIMEOUT_MILLIS);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto done;
+
+	accept_fd = accept(listen_fd, NULL, NULL);
+	if (!ASSERT_GE(accept_fd, 0, "accept"))
+		goto done;
+
+	if (!ASSERT_OK(settimeo(accept_fd, TIMEOUT_MILLIS), "settimeo"))
+		goto done;
+
+	n = write(client_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
+		goto done;
+
+	n = read(accept_fd, buf, sizeof(buf));
+	ASSERT_EQ(n, sizeof(buf), "recv from server");
+
+done:
+	setns_root();
+	if (listen_fd >= 0)
+		close(listen_fd);
+	if (accept_fd >= 0)
+		close(accept_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+}
+
+static int test_ping(int family, const char *addr)
+{
+	const char *ping = family == AF_INET6 ? "ping6" : "ping";
+
+	SYS("ip netns exec " NS_SRC " %s " PING_ARGS " %s", ping, addr);
+	return 0;
+fail:
+	return -1;
+}
+
+static void test_connectivity(void)
+{
+	test_tcp(AF_INET, IP4_DST, IP4_PORT);
+	test_ping(AF_INET, IP4_DST);
+	test_tcp(AF_INET6, IP6_DST, IP6_PORT);
+	test_ping(AF_INET6, IP6_DST);
+}
+
+static void test_tc_redirect_neigh_fib(struct netns_setup_result *setup_result)
+{
+	struct test_tc_neigh_fib *skel;
+	int err;
+
+	skel = test_tc_neigh_fib__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_neigh_fib__open"))
+		return;
+
+	if (!ASSERT_OK(test_tc_neigh_fib__load(skel), "test_tc_neigh_fib__load")) {
+		test_tc_neigh_fib__destroy(skel);
+		return;
+	}
+
+	err = bpf_program__pin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE))
+		goto done;
+
+	err = bpf_program__pin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " CHK_PROG_PIN_FILE))
+		goto done;
+
+	err = bpf_program__pin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " DST_PROG_PIN_FILE))
+		goto done;
+
+	if (netns_load_bpf())
+		goto done;
+
+	/* bpf_fib_lookup() checks if forwarding is enabled */
+	if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
+		goto done;
+
+	err = modify_proc("/proc/sys/net/ipv4/ip_forward", "1");
+	if (!ASSERT_OK(err, "set ipv4.ip_forward"))
+		goto done;
+
+	err = modify_proc("/proc/sys/net/ipv6/conf/all/forwarding", "1");
+	if (!ASSERT_OK(err, "set ipv6.forwarding"))
+		goto done;
+	setns_root();
+
+	test_connectivity();
+done:
+	bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
+	bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
+	bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
+	test_tc_neigh_fib__destroy(skel);
+	netns_unload_bpf();
+	setns_root();
+	restore_proc();
+}
+
+static void test_tc_redirect_neigh(struct netns_setup_result *setup_result)
+{
+	struct test_tc_neigh *skel;
+	int err;
+
+	skel = test_tc_neigh__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_neigh__open"))
+		return;
+
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_veth_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
+
+	err = test_tc_neigh__load(skel);
+	if (!ASSERT_OK(err, "test_tc_neigh__load")) {
+		test_tc_neigh__destroy(skel);
+		return;
+	}
+
+	err = bpf_program__pin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE))
+		goto done;
+
+	err = bpf_program__pin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " CHK_PROG_PIN_FILE))
+		goto done;
+
+	err = bpf_program__pin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " DST_PROG_PIN_FILE))
+		goto done;
+
+	if (netns_load_bpf())
+		goto done;
+
+	test_connectivity();
+
+done:
+	bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
+	bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
+	bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
+	test_tc_neigh__destroy(skel);
+	netns_unload_bpf();
+	setns_root();
+}
+
+static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
+{
+	struct test_tc_peer *skel;
+	int err;
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
+	err = bpf_program__pin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " SRC_PROG_PIN_FILE))
+		goto done;
+
+	err = bpf_program__pin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " CHK_PROG_PIN_FILE))
+		goto done;
+
+	err = bpf_program__pin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " DST_PROG_PIN_FILE))
+		goto done;
+
+	if (netns_load_bpf())
+		goto done;
+
+	test_connectivity();
+
+done:
+	bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
+	bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
+	bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
+	test_tc_peer__destroy(skel);
+	netns_unload_bpf();
+	setns_root();
+}
+
+void test_tc_redirect(void)
+{
+	struct netns_setup_result setup_result;
+
+	root_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (!ASSERT_GE(root_netns_fd, 0, "open /proc/self/ns/net"))
+		return;
+
+	if (netns_setup_namespaces("add"))
+		goto done;
+
+	if (netns_setup_links_and_routes(&setup_result))
+		goto done;
+
+	if (test__start_subtest("tc_redirect_peer"))
+		test_tc_redirect_peer(&setup_result);
+
+	if (test__start_subtest("tc_redirect_neigh"))
+		test_tc_redirect_neigh(&setup_result);
+
+	if (test__start_subtest("tc_redirect_neigh_fib"))
+		test_tc_redirect_neigh_fib(&setup_result);
+
+done:
+	close(root_netns_fd);
+	netns_setup_namespaces("delete");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
index b985ac4e7a81..90f64a85998f 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
@@ -33,17 +33,8 @@
 				 a.s6_addr32[3] == b.s6_addr32[3])
 #endif
 
-enum {
-	dev_src,
-	dev_dst,
-};
-
-struct bpf_map_def SEC("maps") ifindex_map = {
-	.type		= BPF_MAP_TYPE_ARRAY,
-	.key_size	= sizeof(int),
-	.value_size	= sizeof(int),
-	.max_entries	= 2,
-};
+static volatile const __u32 IFINDEX_SRC;
+static volatile const __u32 IFINDEX_DST;
 
 static __always_inline bool is_remote_ep_v4(struct __sk_buff *skb,
 					    __be32 addr)
@@ -79,14 +70,8 @@ static __always_inline bool is_remote_ep_v6(struct __sk_buff *skb,
 	return v6_equal(ip6h->daddr, addr);
 }
 
-static __always_inline int get_dev_ifindex(int which)
-{
-	int *ifindex = bpf_map_lookup_elem(&ifindex_map, &which);
-
-	return ifindex ? *ifindex : 0;
-}
-
-SEC("chk_egress") int tc_chk(struct __sk_buff *skb)
+SEC("classifier/chk_egress")
+int tc_chk(struct __sk_buff *skb)
 {
 	void *data_end = ctx_ptr(skb->data_end);
 	void *data = ctx_ptr(skb->data);
@@ -98,7 +83,8 @@ SEC("chk_egress") int tc_chk(struct __sk_buff *skb)
 	return !raw[0] && !raw[1] && !raw[2] ? TC_ACT_SHOT : TC_ACT_OK;
 }
 
-SEC("dst_ingress") int tc_dst(struct __sk_buff *skb)
+SEC("classifier/dst_ingress")
+int tc_dst(struct __sk_buff *skb)
 {
 	__u8 zero[ETH_ALEN * 2];
 	bool redirect = false;
@@ -119,10 +105,11 @@ SEC("dst_ingress") int tc_dst(struct __sk_buff *skb)
 	if (bpf_skb_store_bytes(skb, 0, &zero, sizeof(zero), 0) < 0)
 		return TC_ACT_SHOT;
 
-	return bpf_redirect_neigh(get_dev_ifindex(dev_src), NULL, 0, 0);
+	return bpf_redirect_neigh(IFINDEX_SRC, NULL, 0, 0);
 }
 
-SEC("src_ingress") int tc_src(struct __sk_buff *skb)
+SEC("classifier/src_ingress")
+int tc_src(struct __sk_buff *skb)
 {
 	__u8 zero[ETH_ALEN * 2];
 	bool redirect = false;
@@ -143,7 +130,7 @@ SEC("src_ingress") int tc_src(struct __sk_buff *skb)
 	if (bpf_skb_store_bytes(skb, 0, &zero, sizeof(zero), 0) < 0)
 		return TC_ACT_SHOT;
 
-	return bpf_redirect_neigh(get_dev_ifindex(dev_dst), NULL, 0, 0);
+	return bpf_redirect_neigh(IFINDEX_DST, NULL, 0, 0);
 }
 
 char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c b/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
index d82ed3457030..f7ab69cf018e 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
@@ -75,7 +75,8 @@ static __always_inline int fill_fib_params_v6(struct __sk_buff *skb,
 	return 0;
 }
 
-SEC("chk_egress") int tc_chk(struct __sk_buff *skb)
+SEC("classifier/chk_egress")
+int tc_chk(struct __sk_buff *skb)
 {
 	void *data_end = ctx_ptr(skb->data_end);
 	void *data = ctx_ptr(skb->data);
@@ -142,12 +143,14 @@ static __always_inline int tc_redir(struct __sk_buff *skb)
 /* these are identical, but keep them separate for compatibility with the
  * section names expected by test_tc_redirect.sh
  */
-SEC("dst_ingress") int tc_dst(struct __sk_buff *skb)
+SEC("classifier/dst_ingress")
+int tc_dst(struct __sk_buff *skb)
 {
 	return tc_redir(skb);
 }
 
-SEC("src_ingress") int tc_src(struct __sk_buff *skb)
+SEC("classifier/src_ingress")
+int tc_src(struct __sk_buff *skb)
 {
 	return tc_redir(skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index fc84a7685aa2..72c72950c3bb 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -8,38 +8,25 @@
 
 #include <bpf/bpf_helpers.h>
 
-enum {
-	dev_src,
-	dev_dst,
-};
+static volatile const __u32 IFINDEX_SRC;
+static volatile const __u32 IFINDEX_DST;
 
-struct bpf_map_def SEC("maps") ifindex_map = {
-	.type		= BPF_MAP_TYPE_ARRAY,
-	.key_size	= sizeof(int),
-	.value_size	= sizeof(int),
-	.max_entries	= 2,
-};
-
-static __always_inline int get_dev_ifindex(int which)
-{
-	int *ifindex = bpf_map_lookup_elem(&ifindex_map, &which);
-
-	return ifindex ? *ifindex : 0;
-}
-
-SEC("chk_egress") int tc_chk(struct __sk_buff *skb)
+SEC("classifier/chk_egress")
+int tc_chk(struct __sk_buff *skb)
 {
 	return TC_ACT_SHOT;
 }
 
-SEC("dst_ingress") int tc_dst(struct __sk_buff *skb)
+SEC("classifier/dst_ingress")
+int tc_dst(struct __sk_buff *skb)
 {
-	return bpf_redirect_peer(get_dev_ifindex(dev_src), 0);
+	return bpf_redirect_peer(IFINDEX_SRC, 0);
 }
 
-SEC("src_ingress") int tc_src(struct __sk_buff *skb)
+SEC("classifier/src_ingress")
+int tc_src(struct __sk_buff *skb)
 {
-	return bpf_redirect_peer(get_dev_ifindex(dev_dst), 0);
+	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
 char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tc_redirect.sh b/tools/testing/selftests/bpf/test_tc_redirect.sh
deleted file mode 100755
index 8868aa1ca902..000000000000
--- a/tools/testing/selftests/bpf/test_tc_redirect.sh
+++ /dev/null
@@ -1,216 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# This test sets up 3 netns (src <-> fwd <-> dst). There is no direct veth link
-# between src and dst. The netns fwd has veth links to each src and dst. The
-# client is in src and server in dst. The test installs a TC BPF program to each
-# host facing veth in fwd which calls into i) bpf_redirect_neigh() to perform the
-# neigh addr population and redirect or ii) bpf_redirect_peer() for namespace
-# switch from ingress side; it also installs a checker prog on the egress side
-# to drop unexpected traffic.
-
-if [[ $EUID -ne 0 ]]; then
-	echo "This script must be run as root"
-	echo "FAIL"
-	exit 1
-fi
-
-# check that needed tools are present
-command -v nc >/dev/null 2>&1 || \
-	{ echo >&2 "nc is not available"; exit 1; }
-command -v dd >/dev/null 2>&1 || \
-	{ echo >&2 "dd is not available"; exit 1; }
-command -v timeout >/dev/null 2>&1 || \
-	{ echo >&2 "timeout is not available"; exit 1; }
-command -v ping >/dev/null 2>&1 || \
-	{ echo >&2 "ping is not available"; exit 1; }
-if command -v ping6 >/dev/null 2>&1; then PING6=ping6; else PING6=ping; fi
-command -v perl >/dev/null 2>&1 || \
-	{ echo >&2 "perl is not available"; exit 1; }
-command -v jq >/dev/null 2>&1 || \
-	{ echo >&2 "jq is not available"; exit 1; }
-command -v bpftool >/dev/null 2>&1 || \
-	{ echo >&2 "bpftool is not available"; exit 1; }
-
-readonly GREEN='\033[0;92m'
-readonly RED='\033[0;31m'
-readonly NC='\033[0m' # No Color
-
-readonly PING_ARG="-c 3 -w 10 -q"
-
-readonly TIMEOUT=10
-
-readonly NS_SRC="ns-src-$(mktemp -u XXXXXX)"
-readonly NS_FWD="ns-fwd-$(mktemp -u XXXXXX)"
-readonly NS_DST="ns-dst-$(mktemp -u XXXXXX)"
-
-readonly IP4_SRC="172.16.1.100"
-readonly IP4_DST="172.16.2.100"
-
-readonly IP6_SRC="::1:dead:beef:cafe"
-readonly IP6_DST="::2:dead:beef:cafe"
-
-readonly IP4_SLL="169.254.0.1"
-readonly IP4_DLL="169.254.0.2"
-readonly IP4_NET="169.254.0.0"
-
-netns_cleanup()
-{
-	ip netns del ${NS_SRC}
-	ip netns del ${NS_FWD}
-	ip netns del ${NS_DST}
-}
-
-netns_setup()
-{
-	ip netns add "${NS_SRC}"
-	ip netns add "${NS_FWD}"
-	ip netns add "${NS_DST}"
-
-	ip link add veth_src type veth peer name veth_src_fwd
-	ip link add veth_dst type veth peer name veth_dst_fwd
-
-	ip link set veth_src netns ${NS_SRC}
-	ip link set veth_src_fwd netns ${NS_FWD}
-
-	ip link set veth_dst netns ${NS_DST}
-	ip link set veth_dst_fwd netns ${NS_FWD}
-
-	ip -netns ${NS_SRC} addr add ${IP4_SRC}/32 dev veth_src
-	ip -netns ${NS_DST} addr add ${IP4_DST}/32 dev veth_dst
-
-	# The fwd netns automatically get a v6 LL address / routes, but also
-	# needs v4 one in order to start ARP probing. IP4_NET route is added
-	# to the endpoints so that the ARP processing will reply.
-
-	ip -netns ${NS_FWD} addr add ${IP4_SLL}/32 dev veth_src_fwd
-	ip -netns ${NS_FWD} addr add ${IP4_DLL}/32 dev veth_dst_fwd
-
-	ip -netns ${NS_SRC} addr add ${IP6_SRC}/128 dev veth_src nodad
-	ip -netns ${NS_DST} addr add ${IP6_DST}/128 dev veth_dst nodad
-
-	ip -netns ${NS_SRC} link set dev veth_src up
-	ip -netns ${NS_FWD} link set dev veth_src_fwd up
-
-	ip -netns ${NS_DST} link set dev veth_dst up
-	ip -netns ${NS_FWD} link set dev veth_dst_fwd up
-
-	ip -netns ${NS_SRC} route add ${IP4_DST}/32 dev veth_src scope global
-	ip -netns ${NS_SRC} route add ${IP4_NET}/16 dev veth_src scope global
-	ip -netns ${NS_FWD} route add ${IP4_SRC}/32 dev veth_src_fwd scope global
-
-	ip -netns ${NS_SRC} route add ${IP6_DST}/128 dev veth_src scope global
-	ip -netns ${NS_FWD} route add ${IP6_SRC}/128 dev veth_src_fwd scope global
-
-	ip -netns ${NS_DST} route add ${IP4_SRC}/32 dev veth_dst scope global
-	ip -netns ${NS_DST} route add ${IP4_NET}/16 dev veth_dst scope global
-	ip -netns ${NS_FWD} route add ${IP4_DST}/32 dev veth_dst_fwd scope global
-
-	ip -netns ${NS_DST} route add ${IP6_SRC}/128 dev veth_dst scope global
-	ip -netns ${NS_FWD} route add ${IP6_DST}/128 dev veth_dst_fwd scope global
-
-	fmac_src=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_src_fwd/address)
-	fmac_dst=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_dst_fwd/address)
-
-	ip -netns ${NS_SRC} neigh add ${IP4_DST} dev veth_src lladdr $fmac_src
-	ip -netns ${NS_DST} neigh add ${IP4_SRC} dev veth_dst lladdr $fmac_dst
-
-	ip -netns ${NS_SRC} neigh add ${IP6_DST} dev veth_src lladdr $fmac_src
-	ip -netns ${NS_DST} neigh add ${IP6_SRC} dev veth_dst lladdr $fmac_dst
-}
-
-netns_test_connectivity()
-{
-	set +e
-
-	ip netns exec ${NS_DST} bash -c "nc -4 -l -p 9004 &"
-	ip netns exec ${NS_DST} bash -c "nc -6 -l -p 9006 &"
-
-	TEST="TCPv4 connectivity test"
-	ip netns exec ${NS_SRC} bash -c "timeout ${TIMEOUT} dd if=/dev/zero bs=1000 count=100 > /dev/tcp/${IP4_DST}/9004"
-	if [ $? -ne 0 ]; then
-		echo -e "${TEST}: ${RED}FAIL${NC}"
-		exit 1
-	fi
-	echo -e "${TEST}: ${GREEN}PASS${NC}"
-
-	TEST="TCPv6 connectivity test"
-	ip netns exec ${NS_SRC} bash -c "timeout ${TIMEOUT} dd if=/dev/zero bs=1000 count=100 > /dev/tcp/${IP6_DST}/9006"
-	if [ $? -ne 0 ]; then
-		echo -e "${TEST}: ${RED}FAIL${NC}"
-		exit 1
-	fi
-	echo -e "${TEST}: ${GREEN}PASS${NC}"
-
-	TEST="ICMPv4 connectivity test"
-	ip netns exec ${NS_SRC} ping  $PING_ARG ${IP4_DST}
-	if [ $? -ne 0 ]; then
-		echo -e "${TEST}: ${RED}FAIL${NC}"
-		exit 1
-	fi
-	echo -e "${TEST}: ${GREEN}PASS${NC}"
-
-	TEST="ICMPv6 connectivity test"
-	ip netns exec ${NS_SRC} $PING6 $PING_ARG ${IP6_DST}
-	if [ $? -ne 0 ]; then
-		echo -e "${TEST}: ${RED}FAIL${NC}"
-		exit 1
-	fi
-	echo -e "${TEST}: ${GREEN}PASS${NC}"
-
-	set -e
-}
-
-hex_mem_str()
-{
-	perl -e 'print join(" ", unpack("(H2)8", pack("L", @ARGV)))' $1
-}
-
-netns_setup_bpf()
-{
-	local obj=$1
-	local use_forwarding=${2:-0}
-
-	ip netns exec ${NS_FWD} tc qdisc add dev veth_src_fwd clsact
-	ip netns exec ${NS_FWD} tc filter add dev veth_src_fwd ingress bpf da obj $obj sec src_ingress
-	ip netns exec ${NS_FWD} tc filter add dev veth_src_fwd egress  bpf da obj $obj sec chk_egress
-
-	ip netns exec ${NS_FWD} tc qdisc add dev veth_dst_fwd clsact
-	ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd ingress bpf da obj $obj sec dst_ingress
-	ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd egress  bpf da obj $obj sec chk_egress
-
-	if [ "$use_forwarding" -eq "1" ]; then
-		# bpf_fib_lookup() checks if forwarding is enabled
-		ip netns exec ${NS_FWD} sysctl -w net.ipv4.ip_forward=1
-		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.veth_dst_fwd.forwarding=1
-		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.veth_src_fwd.forwarding=1
-		return 0
-	fi
-
-	veth_src=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_src_fwd/ifindex)
-	veth_dst=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_dst_fwd/ifindex)
-
-	progs=$(ip netns exec ${NS_FWD} bpftool net --json | jq -r '.[] | .tc | map(.id) | .[]')
-	for prog in $progs; do
-		map=$(bpftool prog show id $prog --json | jq -r '.map_ids | .? | .[]')
-		if [ ! -z "$map" ]; then
-			bpftool map update id $map key hex $(hex_mem_str 0) value hex $(hex_mem_str $veth_src)
-			bpftool map update id $map key hex $(hex_mem_str 1) value hex $(hex_mem_str $veth_dst)
-		fi
-	done
-}
-
-trap netns_cleanup EXIT
-set -e
-
-netns_setup
-netns_setup_bpf test_tc_neigh.o
-netns_test_connectivity
-netns_cleanup
-netns_setup
-netns_setup_bpf test_tc_neigh_fib.o 1
-netns_test_connectivity
-netns_cleanup
-netns_setup
-netns_setup_bpf test_tc_peer.o
-netns_test_connectivity
-- 
2.30.2

