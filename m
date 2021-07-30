Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7C3E016D
	for <lists+bpf@lfdr.de>; Wed,  4 Aug 2021 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbhHDMqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Aug 2021 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhHDMqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Aug 2021 08:46:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636DEC0617B9;
        Wed,  4 Aug 2021 05:45:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k4so1132556wms.3;
        Wed, 04 Aug 2021 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gZ6FaJLLG9ZRfjblU9BytNupe0ldFYDaj/P6zGG+tqI=;
        b=Axwl2dUl30hJitQcAU6KxQM4vFP8a4KthJjUGHl9WIH1MXJiYtwtyqPR2d+Dt2tKJO
         eFNmZhjZPqHlw+XovxwGL3COErToXjcyEZJY5dd11t7XsrY6yisAPzNvGdLBsm1w279F
         NcA02JGVYW7hPYP8++1tg8dFRv9tZQms7934BuI1jfBPUbWGVUY1gw4P6/PogOvk0x28
         sAK26tFDiWsITqnzKH3CSE+90OVMGcWh0Y1SROVXf150gO8n8n1ACSyYIONfqvUU9xcH
         X/1eJPRzeYNOoZxd82RThHOTWhwgEhhIoEutAGbRUrkcI3DXoYEmFEpAZO/TyYU6631c
         9flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gZ6FaJLLG9ZRfjblU9BytNupe0ldFYDaj/P6zGG+tqI=;
        b=SzANa2f5pn5Uolk76lEC5xaDlCGDI+VnJ5PGZlQI6y/M6bRkKUhXAZZmLLX/iAcBBW
         xJ41TtPchUWkJYXBUKwrymgBXYjIBTS46Wu2LhuNsVacZ2ybej3wrZcMUHjsMuRLUg6m
         APNL1Ex95wYf3sWoL3RtPuQfDwmB10cz5M7a5ZQ5XmaZ2kWGVczoPADKZrUHCfMT5FTI
         hYlbLpZ/AxTm8Lml/hm5Aeu1nUxXKqhhO61xr/TK33KAAzgTuzjPm2S7KY031qQASGI0
         gDn3VCrmQvTyox3k9vtROA3N4SDTazbh857naUROZQQzgHWHDnrq/ZLLbiSEZuVKJWtW
         oLcw==
X-Gm-Message-State: AOAM531ZjxvVWxr/hRFz+Looodx0fdZi+gshJyoNCz2wTluRkOat6sqS
        H38etzXnnvytL2efxcZZ84eGLlBELHt8iY8=
X-Google-Smtp-Source: ABdhPJwT5ZH+/uSr+nXj+0KVvd/zhWpWkyL3iG229DtwYzKIUgOLGrUg69+a5KPyXDeRsqyy2IQOCw==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr27524978wmb.162.1628081152597;
        Wed, 04 Aug 2021 05:45:52 -0700 (PDT)
Received: from localhost.localdomain ([77.109.191.101])
        by smtp.gmail.com with ESMTPSA id y4sm2257923wmi.22.2021.08.04.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:45:52 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, daniel@iogearbox.net, j.vosburgh@gmail.com,
        andy@greyhouse.net, vfalico@gmail.com, andrii@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Add tests for XDP bonding
Date:   Fri, 30 Jul 2021 06:18:22 +0000
Message-Id: <20210730061822.6600-8-joamaki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210730061822.6600-1-joamaki@gmail.com>
References: <20210609135537.1460244-1-joamaki@gmail.com>
 <20210730061822.6600-1-joamaki@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test suite to test XDP bonding implementation
over a pair of veth devices.

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 533 ++++++++++++++++++
 1 file changed, 533 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
new file mode 100644
index 000000000000..506fd9dc8aef
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/**
+ * Test XDP bonding support
+ *
+ * Sets up two bonded veth pairs between two fresh namespaces
+ * and verifies that XDP_TX program loaded on a bond device
+ * are correctly loaded onto the slave devices and XDP_TX'd
+ * packets are balanced using bonding.
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <net/if.h>
+#include <linux/if_link.h>
+#include "test_progs.h"
+#include "network_helpers.h"
+#include <linux/if_bonding.h>
+#include <linux/limits.h>
+#include <linux/udp.h>
+
+#include "xdp_dummy.skel.h"
+#include "xdp_redirect_multi_kern.skel.h"
+#include "xdp_tx.skel.h"
+
+#define BOND1_MAC {0x00, 0x11, 0x22, 0x33, 0x44, 0x55}
+#define BOND1_MAC_STR "00:11:22:33:44:55"
+#define BOND2_MAC {0x00, 0x22, 0x33, 0x44, 0x55, 0x66}
+#define BOND2_MAC_STR "00:22:33:44:55:66"
+#define NPACKETS 100
+
+static int root_netns_fd = -1;
+
+static void restore_root_netns(void)
+{
+	ASSERT_OK(setns(root_netns_fd, CLONE_NEWNET), "restore_root_netns");
+}
+
+int setns_by_name(char *name)
+{
+	int nsfd, err;
+	char nspath[PATH_MAX];
+
+	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
+	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
+	if (nsfd < 0)
+		return -1;
+
+	err = setns(nsfd, CLONE_NEWNET);
+	close(nsfd);
+	return err;
+}
+
+static int get_rx_packets(const char *iface)
+{
+	FILE *f;
+	char line[512];
+	int iface_len = strlen(iface);
+
+	f = fopen("/proc/net/dev", "r");
+	if (!f)
+		return -1;
+
+	while (fgets(line, sizeof(line), f)) {
+		char *p = line;
+
+		while (*p == ' ')
+			p++; /* skip whitespace */
+		if (!strncmp(p, iface, iface_len)) {
+			p += iface_len;
+			if (*p++ != ':')
+				continue;
+			while (*p == ' ')
+				p++; /* skip whitespace */
+			while (*p && *p != ' ')
+				p++; /* skip rx bytes */
+			while (*p == ' ')
+				p++; /* skip whitespace */
+			fclose(f);
+			return atoi(p);
+		}
+	}
+	fclose(f);
+	return -1;
+}
+
+#define MAX_BPF_LINKS 8
+
+struct skeletons {
+	struct xdp_dummy *xdp_dummy;
+	struct xdp_tx *xdp_tx;
+	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
+
+	int nlinks;
+	struct bpf_link *links[MAX_BPF_LINKS];
+};
+
+static int xdp_attach(struct skeletons *skeletons, struct bpf_program *prog, char *iface)
+{
+	struct bpf_link *link;
+	int ifindex;
+
+	ifindex = if_nametoindex(iface);
+	if (!ASSERT_GT(ifindex, 0, "get ifindex"))
+		return -1;
+
+	if (!ASSERT_LE(skeletons->nlinks, MAX_BPF_LINKS, "too many XDP programs attached"))
+		return -1;
+
+	link = bpf_program__attach_xdp(prog, ifindex);
+	if (!ASSERT_OK_PTR(link, "attach xdp program"))
+		return -1;
+
+	skeletons->links[skeletons->nlinks++] = link;
+	return 0;
+}
+
+enum {
+	BOND_ONE_NO_ATTACH = 0,
+	BOND_BOTH_AND_ATTACH,
+};
+
+static const char * const mode_names[] = {
+	[BOND_MODE_ROUNDROBIN]   = "balance-rr",
+	[BOND_MODE_ACTIVEBACKUP] = "active-backup",
+	[BOND_MODE_XOR]          = "balance-xor",
+	[BOND_MODE_BROADCAST]    = "broadcast",
+	[BOND_MODE_8023AD]       = "802.3ad",
+	[BOND_MODE_TLB]          = "balance-tlb",
+	[BOND_MODE_ALB]          = "balance-alb",
+};
+
+static const char * const xmit_policy_names[] = {
+	[BOND_XMIT_POLICY_LAYER2]       = "layer2",
+	[BOND_XMIT_POLICY_LAYER34]      = "layer3+4",
+	[BOND_XMIT_POLICY_LAYER23]      = "layer2+3",
+	[BOND_XMIT_POLICY_ENCAP23]      = "encap2+3",
+	[BOND_XMIT_POLICY_ENCAP34]      = "encap3+4",
+};
+
+static int bonding_setup(struct skeletons *skeletons, int mode, int xmit_policy,
+			 int bond_both_attach)
+{
+#define SYS(fmt, ...)						\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (!ASSERT_OK(system(cmd), cmd))		\
+			return -1;				\
+	})
+
+	SYS("ip netns add ns_dst");
+	SYS("ip link add veth1_1 type veth peer name veth2_1 netns ns_dst");
+	SYS("ip link add veth1_2 type veth peer name veth2_2 netns ns_dst");
+
+	SYS("ip link add bond1 type bond mode %s xmit_hash_policy %s",
+	    mode_names[mode], xmit_policy_names[xmit_policy]);
+	SYS("ip link set bond1 up address " BOND1_MAC_STR " addrgenmode none");
+	SYS("ip -netns ns_dst link add bond2 type bond mode %s xmit_hash_policy %s",
+	    mode_names[mode], xmit_policy_names[xmit_policy]);
+	SYS("ip -netns ns_dst link set bond2 up address " BOND2_MAC_STR " addrgenmode none");
+
+	SYS("ip link set veth1_1 master bond1");
+	if (bond_both_attach == BOND_BOTH_AND_ATTACH) {
+		SYS("ip link set veth1_2 master bond1");
+	} else {
+		SYS("ip link set veth1_2 up addrgenmode none");
+
+		if (xdp_attach(skeletons, skeletons->xdp_dummy->progs.xdp_dummy_prog, "veth1_2"))
+			return -1;
+	}
+
+	SYS("ip -netns ns_dst link set veth2_1 master bond2");
+
+	if (bond_both_attach == BOND_BOTH_AND_ATTACH)
+		SYS("ip -netns ns_dst link set veth2_2 master bond2");
+	else
+		SYS("ip -netns ns_dst link set veth2_2 up addrgenmode none");
+
+	/* Load a dummy program on sending side as with veth peer needs to have a
+	 * XDP program loaded as well.
+	 */
+	if (xdp_attach(skeletons, skeletons->xdp_dummy->progs.xdp_dummy_prog, "bond1"))
+		return -1;
+
+	if (bond_both_attach == BOND_BOTH_AND_ATTACH) {
+		if (!ASSERT_OK(setns_by_name("ns_dst"), "set netns to ns_dst"))
+			return -1;
+
+		if (xdp_attach(skeletons, skeletons->xdp_tx->progs.xdp_tx, "bond2"))
+			return -1;
+
+		restore_root_netns();
+	}
+
+	return 0;
+
+#undef SYS
+}
+
+static void bonding_cleanup(struct skeletons *skeletons)
+{
+	restore_root_netns();
+	while (skeletons->nlinks) {
+		skeletons->nlinks--;
+		bpf_link__detach(skeletons->links[skeletons->nlinks]);
+	}
+	ASSERT_OK(system("ip link delete bond1"), "delete bond1");
+	ASSERT_OK(system("ip link delete veth1_1"), "delete veth1_1");
+	ASSERT_OK(system("ip link delete veth1_2"), "delete veth1_2");
+	ASSERT_OK(system("ip netns delete ns_dst"), "delete ns_dst");
+}
+
+static int send_udp_packets(int vary_dst_ip)
+{
+	struct ethhdr eh = {
+		.h_source = BOND1_MAC,
+		.h_dest = BOND2_MAC,
+		.h_proto = htons(ETH_P_IP),
+	};
+	uint8_t buf[128] = {};
+	struct iphdr *iph = (struct iphdr *)(buf + sizeof(eh));
+	struct udphdr *uh = (struct udphdr *)(buf + sizeof(eh) + sizeof(*iph));
+	int i, s = -1;
+	int ifindex;
+
+	s = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
+	if (!ASSERT_GE(s, 0, "socket"))
+		goto err;
+
+	ifindex = if_nametoindex("bond1");
+	if (!ASSERT_GT(ifindex, 0, "get bond1 ifindex"))
+		goto err;
+
+	memcpy(buf, &eh, sizeof(eh));
+	iph->ihl = 5;
+	iph->version = 4;
+	iph->tos = 16;
+	iph->id = 1;
+	iph->ttl = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = 1;
+	iph->daddr = 2;
+	iph->tot_len = htons(sizeof(buf) - ETH_HLEN);
+	iph->check = 0;
+
+	for (i = 1; i <= NPACKETS; i++) {
+		int n;
+		struct sockaddr_ll saddr_ll = {
+			.sll_ifindex = ifindex,
+			.sll_halen = ETH_ALEN,
+			.sll_addr = BOND2_MAC,
+		};
+
+		/* vary the UDP destination port for even distribution with roundrobin/xor modes */
+		uh->dest++;
+
+		if (vary_dst_ip)
+			iph->daddr++;
+
+		n = sendto(s, buf, sizeof(buf), 0, (struct sockaddr *)&saddr_ll, sizeof(saddr_ll));
+		if (!ASSERT_EQ(n, sizeof(buf), "sendto"))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	if (s >= 0)
+		close(s);
+	return -1;
+}
+
+void test_xdp_bonding_with_mode(struct skeletons *skeletons, char *name, int mode, int xmit_policy)
+{
+	int bond1_rx;
+
+	if (!test__start_subtest(name))
+		return;
+
+	if (bonding_setup(skeletons, mode, xmit_policy, BOND_BOTH_AND_ATTACH))
+		goto out;
+
+	if (send_udp_packets(xmit_policy != BOND_XMIT_POLICY_LAYER34))
+		goto out;
+
+	bond1_rx = get_rx_packets("bond1");
+	ASSERT_EQ(bond1_rx, NPACKETS, "expected more received packets");
+
+	switch (mode) {
+	case BOND_MODE_ROUNDROBIN:
+	case BOND_MODE_XOR: {
+		int veth1_rx = get_rx_packets("veth1_1");
+		int veth2_rx = get_rx_packets("veth1_2");
+		int diff = abs(veth1_rx - veth2_rx);
+
+		ASSERT_GE(veth1_rx + veth2_rx, NPACKETS, "expected more packets");
+
+		switch (xmit_policy) {
+		case BOND_XMIT_POLICY_LAYER2:
+			ASSERT_GE(diff, NPACKETS,
+				  "expected packets on only one of the interfaces");
+			break;
+		case BOND_XMIT_POLICY_LAYER23:
+		case BOND_XMIT_POLICY_LAYER34:
+			ASSERT_LT(diff, NPACKETS/2,
+				  "expected even distribution of packets");
+			break;
+		default:
+			PRINT_FAIL("Unimplemented xmit_policy=%d\n", xmit_policy);
+			break;
+		}
+		break;
+	}
+	case BOND_MODE_ACTIVEBACKUP: {
+		int veth1_rx = get_rx_packets("veth1_1");
+		int veth2_rx = get_rx_packets("veth1_2");
+		int diff = abs(veth1_rx - veth2_rx);
+
+		ASSERT_GE(diff, NPACKETS,
+			  "expected packets on only one of the interfaces");
+		break;
+	}
+	default:
+		PRINT_FAIL("Unimplemented xmit_policy=%d\n", xmit_policy);
+		break;
+	}
+
+out:
+	bonding_cleanup(skeletons);
+}
+
+
+/* Test the broadcast redirection using xdp_redirect_map_multi_prog and adding
+ * all the interfaces to it and checking that broadcasting won't send the packet
+ * to neither the ingress bond device (bond2) or its slave (veth2_1).
+ */
+void test_xdp_bonding_redirect_multi(struct skeletons *skeletons)
+{
+	static const char * const ifaces[] = {"bond2", "veth2_1", "veth2_2"};
+	int veth1_1_rx, veth1_2_rx;
+	int err;
+
+	if (!test__start_subtest("xdp_bonding_redirect_multi"))
+		return;
+
+	if (bonding_setup(skeletons, BOND_MODE_ROUNDROBIN, BOND_XMIT_POLICY_LAYER23,
+			  BOND_ONE_NO_ATTACH))
+		goto out;
+
+
+	if (!ASSERT_OK(setns_by_name("ns_dst"), "could not set netns to ns_dst"))
+		goto out;
+
+	/* populate the devmap with the relevant interfaces */
+	for (int i = 0; i < ARRAY_SIZE(ifaces); i++) {
+		int ifindex = if_nametoindex(ifaces[i]);
+		int map_fd = bpf_map__fd(skeletons->xdp_redirect_multi_kern->maps.map_all);
+
+		if (!ASSERT_GT(ifindex, 0, "could not get interface index"))
+			goto out;
+
+		err = bpf_map_update_elem(map_fd, &ifindex, &ifindex, 0);
+		if (!ASSERT_OK(err, "add interface to map_all"))
+			goto out;
+	}
+
+	if (xdp_attach(skeletons,
+		       skeletons->xdp_redirect_multi_kern->progs.xdp_redirect_map_multi_prog,
+		       "bond2"))
+		goto out;
+
+	restore_root_netns();
+
+	if (send_udp_packets(BOND_MODE_ROUNDROBIN))
+		goto out;
+
+	veth1_1_rx = get_rx_packets("veth1_1");
+	veth1_2_rx = get_rx_packets("veth1_2");
+
+	ASSERT_EQ(veth1_1_rx, 0, "expected no packets on veth1_1");
+	ASSERT_GE(veth1_2_rx, NPACKETS, "expected packets on veth1_2");
+
+out:
+	restore_root_netns();
+	bonding_cleanup(skeletons);
+}
+
+/* Test that XDP programs cannot be attached to both the bond master and slaves simultaneously */
+void test_xdp_bonding_attach(struct skeletons *skeletons)
+{
+	struct bpf_link *link = NULL;
+	struct bpf_link *link2 = NULL;
+	int veth, bond;
+	int err;
+
+	if (!test__start_subtest("xdp_bonding_attach"))
+		return;
+
+	if (!ASSERT_OK(system("ip link add veth type veth"), "add veth"))
+		goto out;
+	if (!ASSERT_OK(system("ip link add bond type bond"), "add bond"))
+		goto out;
+
+	veth = if_nametoindex("veth");
+	if (!ASSERT_GE(veth, 0, "if_nametoindex veth"))
+		goto out;
+	bond = if_nametoindex("bond");
+	if (!ASSERT_GE(bond, 0, "if_nametoindex bond"))
+		goto out;
+
+	/* enslaving with a XDP program loaded fails */
+	link = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, veth);
+	if (!ASSERT_OK_PTR(link, "attach program to veth"))
+		goto out;
+
+	err = system("ip link set veth master bond");
+	if (!ASSERT_NEQ(err, 0, "attaching slave with xdp program expected to fail"))
+		goto out;
+
+	bpf_link__detach(link);
+	link = NULL;
+
+	err = system("ip link set veth master bond");
+	if (!ASSERT_OK(err, "set veth master"))
+		goto out;
+
+	/* attaching to slave when master has no program is allowed */
+	link = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, veth);
+	if (!ASSERT_OK_PTR(link, "attach program to slave when enslaved"))
+		goto out;
+
+	/* attaching to master not allowed when slave has program loaded */
+	link2 = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, bond);
+	if (!ASSERT_ERR_PTR(link2, "attach program to master when slave has program"))
+		goto out;
+
+	bpf_link__detach(link);
+	link = NULL;
+
+	/* attaching XDP program to master allowed when slave has no program */
+	link = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, bond);
+	if (!ASSERT_OK_PTR(link, "attach program to master"))
+		goto out;
+
+	/* attaching to slave not allowed when master has program loaded */
+	link2 = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, bond);
+	ASSERT_ERR_PTR(link2, "attach program to slave when master has program");
+
+out:
+	if (link)
+		bpf_link__detach(link);
+	if (link2)
+		bpf_link__detach(link2);
+
+	system("ip link del veth");
+	system("ip link del bond");
+}
+
+static int libbpf_debug_print(enum libbpf_print_level level,
+			      const char *format, va_list args)
+{
+	if (level != LIBBPF_WARN)
+		vprintf(format, args);
+	return 0;
+}
+
+struct bond_test_case {
+	char *name;
+	int mode;
+	int xmit_policy;
+};
+
+static	struct bond_test_case bond_test_cases[] = {
+	{ "xdp_bonding_roundrobin", BOND_MODE_ROUNDROBIN, BOND_XMIT_POLICY_LAYER23, },
+	{ "xdp_bonding_activebackup", BOND_MODE_ACTIVEBACKUP, BOND_XMIT_POLICY_LAYER23 },
+
+	{ "xdp_bonding_xor_layer2", BOND_MODE_XOR, BOND_XMIT_POLICY_LAYER2, },
+	{ "xdp_bonding_xor_layer23", BOND_MODE_XOR, BOND_XMIT_POLICY_LAYER23, },
+	{ "xdp_bonding_xor_layer34", BOND_MODE_XOR, BOND_XMIT_POLICY_LAYER34, },
+};
+
+void test_xdp_bonding(void)
+{
+	libbpf_print_fn_t old_print_fn;
+	struct skeletons skeletons = {};
+	int i;
+
+	old_print_fn = libbpf_set_print(libbpf_debug_print);
+
+	root_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (!ASSERT_GE(root_netns_fd, 0, "open /proc/self/ns/net"))
+		goto out;
+
+	skeletons.xdp_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_dummy, "xdp_dummy__open_and_load"))
+		goto out;
+
+	skeletons.xdp_tx = xdp_tx__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_tx, "xdp_tx__open_and_load"))
+		goto out;
+
+	skeletons.xdp_redirect_multi_kern = xdp_redirect_multi_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_redirect_multi_kern,
+			   "xdp_redirect_multi_kern__open_and_load"))
+		goto out;
+
+	test_xdp_bonding_attach(&skeletons);
+
+	for (i = 0; i < ARRAY_SIZE(bond_test_cases); i++) {
+		struct bond_test_case *test_case = &bond_test_cases[i];
+
+		test_xdp_bonding_with_mode(
+			&skeletons,
+			test_case->name,
+			test_case->mode,
+			test_case->xmit_policy);
+	}
+
+	test_xdp_bonding_redirect_multi(&skeletons);
+
+out:
+	if (skeletons.xdp_dummy)
+		xdp_dummy__destroy(skeletons.xdp_dummy);
+	if (skeletons.xdp_tx)
+		xdp_tx__destroy(skeletons.xdp_tx);
+	if (skeletons.xdp_redirect_multi_kern)
+		xdp_redirect_multi_kern__destroy(skeletons.xdp_redirect_multi_kern);
+
+	libbpf_set_print(old_print_fn);
+	if (root_netns_fd)
+		close(root_netns_fd);
+}
-- 
2.17.1

