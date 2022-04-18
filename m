Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54956504A7A
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 03:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiDRBen (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiDRBen (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 21:34:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458813E99
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:32:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q12so16142216pgj.13
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTHP+tl0neKx2xvNBxZxEma7FDOX174GvsmgzgAuC5A=;
        b=k8Jk33+hgJ5NadfJ7JKn+ijSLU/h7iZUHWrras/OLTF+X37D5IdyeJTErGg4vP1M6X
         yDp9MMb314/++pPdvwvbfflPmWGlMNnXhIDuz4KZxZfytzU8hLlB4ySuMA0jLxcByqFv
         12R/Ak8zi9fBumH8/1l+HQjcrYqIlmJLoFJuvkcwqxes0VQ68lqAixxzHFB5lNfpSNLH
         Q/a7c6XG0zm0svJk1KATp3id+LU0ueSaIxog9223AK74bJVvTt8LIn200SqoFbbkXIzX
         6uJ58wOz7Vum5UfnnH+8uRvz74sxr/uYdk+5BirsvK78UI+Ytjo2mJzy09PTpA/6QDqF
         eknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTHP+tl0neKx2xvNBxZxEma7FDOX174GvsmgzgAuC5A=;
        b=YvI5/eGvEiKiurhTxO0o9tWRD25GPqazDddvlxdKJNgjam07pFrJbQ2EA/0hXwonE6
         nxeD9DXqMc+C9Mx+n4ef04HvGXdsqrym7e00pqe/Cv5aYBUnXAUuPOraApUkE9lho0wf
         cc+AhHIoHjGpTusTNVqgl6pXSm7V19Tr0/vBiYspcqBEy4YkbtXiuD2pPEOGeNysRK5I
         gGg1EZsLedQ5lKEP5PPgLTJXP3u1IrVWerOGobW4kW32fh8oEYULHJ21YY987lgYrTmZ
         Ov1JqKh+RVXm+NU3HrcAIlHqH3fVvf6A7b9dxKiIMgO2zV8nfqAr88N1enVMKcZTU7MS
         0W4w==
X-Gm-Message-State: AOAM53222CQM418XVh4duaF0Od5iLFkap2JkgydnhOP7+Np1kmUwQome
        HWi2y9fpqF4l5l/Pzgm5a9nhvA==
X-Google-Smtp-Source: ABdhPJxOHcyRqqIMicfEcH6RuESwInMtgsJSbJrwajF2VC3Ey9cXcEYnkbnyiGZZdCcxIY2pcHPytQ==
X-Received: by 2002:a05:6a00:2405:b0:4e1:5008:adcc with SMTP id z5-20020a056a00240500b004e15008adccmr9579947pfh.35.1650245523972;
        Sun, 17 Apr 2022 18:32:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:590a:cbcb:f71b:54e5])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a442000000b0039cc5a6af1csm10807333pgp.30.2022.04.17.18.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:32:03 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v4 2/3] selftests/bpf: move vxlan tunnel testcases to test_progs
Date:   Mon, 18 Apr 2022 09:31:35 +0800
Message-Id: <20220418013136.26098-3-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220418013136.26098-1-fankaixi.li@bytedance.com>
References: <20220418013136.26098-1-fankaixi.li@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kaixi Fan <fankaixi.li@bytedance.com>

Move vxlan tunnel testcases from test_tunnel.sh to test_progs.
And add vxlan tunnel source testcases also. Other tunnel testcases
will be moved to test_progs step by step in the future.
Rename bpf program section name as SEC("tc") because test_progs
bpf loader could not load sections with name SEC("gre_set_tunnel").
Because of this, add bpftool to load bpf programs in test_tunnel.sh.

Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 461 ++++++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 155 ++++--
 tools/testing/selftests/bpf/test_tunnel.sh    | 124 +----
 3 files changed, 577 insertions(+), 163 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tunnel.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
new file mode 100644
index 000000000000..8d3efe163f68
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/*
+ * End-to-end eBPF tunnel test suite
+ *   The file tests BPF network tunnel implementation.
+ *
+ * Topology:
+ * ---------
+ *     root namespace   |     at_ns0 namespace
+ *                       |
+ *       -----------     |     -----------
+ *       | tnl dev |     |     | tnl dev |  (overlay network)
+ *       -----------     |     -----------
+ *       metadata-mode   |     native-mode
+ *        with bpf       |
+ *                       |
+ *       ----------      |     ----------
+ *       |  veth1  | --------- |  veth0  |  (underlay network)
+ *       ----------    peer    ----------
+ *
+ *
+ *  Device Configuration
+ *  --------------------
+ *  root namespace with metadata-mode tunnel + BPF
+ *  Device names and addresses:
+ *	veth1 IP 1: 172.16.1.200, IPv6: 00::22 (underlay)
+ *		IP 2: 172.16.1.20, IPv6: 00::bb (underlay)
+ *	tunnel dev <type>11, ex: gre11, IPv4: 10.1.1.200, IPv6: 1::22 (overlay)
+ *
+ *  Namespace at_ns0 with native tunnel
+ *  Device names and addresses:
+ *	veth0 IPv4: 172.16.1.100, IPv6: 00::11 (underlay)
+ *	tunnel dev <type>00, ex: gre00, IPv4: 10.1.1.100, IPv6: 1::11 (overlay)
+ *
+ *
+ * End-to-end ping packet flow
+ *  ---------------------------
+ *  Most of the tests start by namespace creation, device configuration,
+ *  then ping the underlay and overlay network.  When doing 'ping 10.1.1.100'
+ *  from root namespace, the following operations happen:
+ *  1) Route lookup shows 10.1.1.100/24 belongs to tnl dev, fwd to tnl dev.
+ *  2) Tnl device's egress BPF program is triggered and set the tunnel metadata,
+ *     with local_ip=172.16.1.200, remote_ip=172.16.1.100. BPF program choose
+ *     the primary or secondary ip of veth1 as the local ip of tunnel. The
+ *     choice is made based on the value of bpf map local_ip_map.
+ *  3) Outer tunnel header is prepended and route the packet to veth1's egress.
+ *  4) veth0's ingress queue receive the tunneled packet at namespace at_ns0.
+ *  5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet.
+ *  6) Forward the packet to the overlay tnl dev.
+ */
+
+#include <arpa/inet.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <linux/limits.h>
+#include <linux/sysctl.h>
+#include <linux/time_types.h>
+#include <linux/net_tstamp.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "test_tunnel_kern.skel.h"
+
+#define IP4_ADDR_VETH0 "172.16.1.100"
+#define IP4_ADDR1_VETH1 "172.16.1.200"
+#define IP4_ADDR2_VETH1 "172.16.1.20"
+#define IP4_ADDR_TUNL_DEV0 "10.1.1.100"
+#define IP4_ADDR_TUNL_DEV1 "10.1.1.200"
+
+#define IP6_ADDR_VETH0 "::11"
+#define IP6_ADDR1_VETH1 "::22"
+#define IP6_ADDR2_VETH1 "::bb"
+
+#define IP4_ADDR1_HEX_VETH1 0xac1001c8
+#define IP4_ADDR2_HEX_VETH1 0xac100114
+#define IP6_ADDR1_HEX_VETH1 0x22
+#define IP6_ADDR2_HEX_VETH1 0xbb
+
+#define MAC_TUNL_DEV0 "52:54:00:d9:01:00"
+#define MAC_TUNL_DEV1 "52:54:00:d9:02:00"
+
+#define VXLAN_TUNL_DEV0 "vxlan00"
+#define VXLAN_TUNL_DEV1 "vxlan11"
+#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
+#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
+
+#define INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_ingress"
+#define EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_egress"
+
+#define PING_ARGS "-c 3 -w 10 -q"
+
+#define SYS(fmt, ...)						\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (!ASSERT_OK(system(cmd), cmd))		\
+			goto fail;				\
+	})
+
+#define SYS_NOFAIL(fmt, ...)					\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		system(cmd);					\
+	})
+
+static int config_device(void)
+{
+	SYS("ip netns add at_ns0");
+	SYS("ip link add veth0 type veth peer name veth1");
+	SYS("ip link set veth0 netns at_ns0");
+	SYS("ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
+	SYS("ip link set dev veth1 up mtu 1500");
+	SYS("ip netns exec at_ns0 ip addr add " IP4_ADDR_VETH0 "/24 dev veth0");
+	SYS("ip netns exec at_ns0 ip link set dev veth0 up mtu 1500");
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void cleanup(void)
+{
+	SYS_NOFAIL("rm -rf " INGRESS_PROG_PIN_FILE);
+	SYS_NOFAIL("rm -rf " EGRESS_PROG_PIN_FILE);
+	SYS_NOFAIL("rm -rf /sys/fs/bpf/tc/tunnel");
+
+	SYS_NOFAIL("ip netns delete at_ns0");
+	SYS_NOFAIL("ip link del veth1 2> /dev/null");
+	SYS_NOFAIL("ip link del vxlan11 2> /dev/null");
+	SYS_NOFAIL("ip link del ip6vxlan11 2> /dev/null");
+}
+
+static int add_vxlan_tunnel(char *veth1_ip)
+{
+	/*
+	 * Set static ARP entry here because iptables set-mark works
+	 * on L3 packet, as a result not applying to ARP packets,
+	 * causing errors at get_tunnel_{key/opt}.
+	 */
+
+	/* at_ns0 namespace */
+	SYS("ip netns exec at_ns0 ip link add dev %s type vxlan id 2 dstport 4789 gbp local %s remote %s",
+	    VXLAN_TUNL_DEV0, IP4_ADDR_VETH0, veth1_ip);
+	SYS("ip netns exec at_ns0 ip link set dev %s address %s up",
+	    VXLAN_TUNL_DEV0, MAC_TUNL_DEV0);
+	SYS("ip netns exec at_ns0 ip addr add dev %s %s/24",
+	    VXLAN_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
+	SYS("ip netns exec at_ns0 ip neigh add %s lladdr %s dev %s",
+	    IP4_ADDR_TUNL_DEV1, MAC_TUNL_DEV1, VXLAN_TUNL_DEV0);
+	SYS("ip netns exec at_ns0 iptables -A OUTPUT -j MARK --set-mark 0x800FF");
+
+	/* root namespace */
+	SYS("ip link add dev %s type vxlan external gbp dstport 4789",
+	    VXLAN_TUNL_DEV1);
+	SYS("ip link set dev %s address %s up", VXLAN_TUNL_DEV1, MAC_TUNL_DEV1);
+	SYS("ip addr add dev %s %s/24", VXLAN_TUNL_DEV1, IP4_ADDR_TUNL_DEV1);
+	SYS("ip neigh add %s lladdr %s dev %s",
+	    IP4_ADDR_TUNL_DEV0, MAC_TUNL_DEV0, VXLAN_TUNL_DEV1);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int add_ip6vxlan_tunnel(char *veth1_ip6)
+{
+	SYS("ip netns exec at_ns0 ip -6 addr add %s/96 dev veth0",
+	    IP6_ADDR_VETH0);
+	SYS("ip netns exec at_ns0 ip link set dev veth0 up");
+	SYS("ip -6 addr add %s/96 dev veth1", IP6_ADDR1_VETH1);
+	SYS("ip link set dev veth1 up");
+
+	/* at_ns0 namespace */
+	SYS("ip netns exec at_ns0 ip link add dev %s type vxlan id 22 dstport 4789 local %s remote %s",
+	    IP6VXLAN_TUNL_DEV0, IP6_ADDR_VETH0, veth1_ip6);
+	SYS("ip netns exec at_ns0 ip addr add dev %s %s/24",
+	    IP6VXLAN_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
+	SYS("ip netns exec at_ns0 ip link set dev %s address %s up",
+	    IP6VXLAN_TUNL_DEV0, MAC_TUNL_DEV0);
+
+	/* root namespace */
+	SYS("ip link add dev %s type vxlan external dstport 4789",
+	    IP6VXLAN_TUNL_DEV1);
+	SYS("ip addr add dev %s %s/24", IP6VXLAN_TUNL_DEV1, IP4_ADDR_TUNL_DEV1);
+	SYS("ip link set dev %s address %s up",
+	    IP6VXLAN_TUNL_DEV1, MAC_TUNL_DEV1);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int test_ping4(void)
+{
+	/* underlay */
+	SYS("ping " PING_ARGS " %s > /dev/null", IP4_ADDR_VETH0);
+	/* overlay, ping root -> at_ns0 */
+	SYS("ping " PING_ARGS " %s > /dev/null", IP4_ADDR_TUNL_DEV0);
+
+	/* overlay, ping at_ns0 -> root */
+	SYS("ip netns exec at_ns0 ping " PING_ARGS " %s > /dev/null",
+	    IP4_ADDR_TUNL_DEV1);
+	return 0;
+fail:
+	return -1;
+}
+
+static void test_vxlan_tunnel(void)
+{
+	struct test_tunnel_kern *skel = NULL;
+	int local_ip_map_fd = 0, key = 0;
+	uint local_ip;
+	int err;
+
+	/* add vxlan tunnel */
+	err = add_vxlan_tunnel(IP4_ADDR1_VETH1);
+	if (!ASSERT_OK(err, "add vxlan tunnel"))
+		goto done;
+
+	/* load and attach bpf prog to tunnel dev tc hook point */
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		goto done;
+	err = bpf_program__pin(skel->progs.vxlan_set_tunnel,
+			       EGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " EGRESS_PROG_PIN_FILE))
+		goto done;
+	err = bpf_program__pin(skel->progs.vxlan_get_tunnel,
+			       INGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " INGRESS_PROG_PIN_FILE))
+		goto done;
+	SYS("tc qdisc add dev vxlan11 clsact");
+	SYS("tc filter add dev vxlan11 ingress bpf da object-pinned %s",
+	    INGRESS_PROG_PIN_FILE);
+	SYS("tc filter add dev vxlan11 egress bpf da object-pinned %s",
+	    EGRESS_PROG_PIN_FILE);
+
+	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
+	if (!ASSERT_GE(local_ip_map_fd, 0, "get local_ip_map fd "))
+		goto done;
+
+	/* use veth1 ip 1 as tunnel source ip */
+	local_ip = IP4_ADDR1_HEX_VETH1;
+	err = bpf_map_update_elem(local_ip_map_fd, &key, &local_ip, BPF_ANY);
+	if (!ASSERT_OK(err, "update bpf local_ip_map"))
+		goto done;
+
+	/* ping test */
+	err = test_ping4();
+	if (!ASSERT_OK(err, "test ping ipv4"))
+		goto done;
+
+fail:
+done:
+	if (local_ip_map_fd >= 0)
+		close(local_ip_map_fd);
+	if (skel)
+		test_tunnel_kern__destroy(skel);
+}
+
+
+static void test_vxlan_tunnel_source(void)
+{
+	struct test_tunnel_kern *skel = NULL;
+	int local_ip_map_fd = 0, key = 0;
+	uint local_ip;
+	int err;
+
+	/* add vxlan tunnel */
+	err = add_vxlan_tunnel(IP4_ADDR2_VETH1);
+	if (!ASSERT_OK(err, "add vxlan tunnel"))
+		goto done;
+
+	/* load and attach bpf prog to tunnel dev tc hook point */
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		goto done;
+	err = bpf_program__pin(skel->progs.vxlan_set_tunnel,
+			       EGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " EGRESS_PROG_PIN_FILE))
+		goto done;
+	err = bpf_program__pin(skel->progs.vxlan_get_tunnel,
+			       INGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " INGRESS_PROG_PIN_FILE))
+		goto done;
+	SYS("tc qdisc add dev vxlan11 clsact");
+	SYS("tc filter add dev vxlan11 ingress bpf da object-pinned %s",
+	    INGRESS_PROG_PIN_FILE);
+	SYS("tc filter add dev vxlan11 egress bpf da object-pinned %s",
+	    EGRESS_PROG_PIN_FILE);
+
+	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
+	if (!ASSERT_GE(local_ip_map_fd, 0, "get local_ip_map fd "))
+		goto done;
+
+	/* use veth1 ip 2 as tunnel source ip */
+	SYS("ip addr add " IP4_ADDR2_VETH1 "/24 dev veth1");
+	local_ip = IP4_ADDR2_HEX_VETH1;
+	err = bpf_map_update_elem(local_ip_map_fd, &key, &local_ip, BPF_ANY);
+	if (!ASSERT_OK(err, "update bpf local_ip_map"))
+		goto done;
+
+	/* ping test */
+	err = test_ping4();
+	if (!ASSERT_OK(err, "test ping ipv4"))
+		goto done;
+
+fail:
+done:
+	if (local_ip_map_fd >= 0)
+		close(local_ip_map_fd);
+	if (skel)
+		test_tunnel_kern__destroy(skel);
+}
+
+static void test_ip6vxlan_tunnel(void)
+{
+	struct test_tunnel_kern *skel = NULL;
+	int local_ip_map_fd = 0, key = 0;
+	uint local_ip;
+	int err;
+
+	/* add vxlan tunnel */
+	err = add_ip6vxlan_tunnel(IP6_ADDR1_VETH1);
+	if (!ASSERT_OK(err, "add ip6vxlan tunnel"))
+		goto done;
+
+	/* load and attach bpf prog to tunnel dev tc hook point */
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		goto done;
+	err = bpf_program__pin(skel->progs.ip6vxlan_set_tunnel,
+			       EGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " EGRESS_PROG_PIN_FILE))
+		goto done;
+	err = bpf_program__pin(skel->progs.ip6vxlan_get_tunnel,
+			       INGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " INGRESS_PROG_PIN_FILE))
+		goto done;
+	SYS("tc qdisc add dev ip6vxlan11 clsact");
+	SYS("tc filter add dev ip6vxlan11 ingress bpf da object-pinned %s",
+	    INGRESS_PROG_PIN_FILE);
+	SYS("tc filter add dev ip6vxlan11 egress bpf da object-pinned %s",
+	    EGRESS_PROG_PIN_FILE);
+
+	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
+	if (!ASSERT_GE(local_ip_map_fd, 0, "get local_ip_map fd "))
+		goto done;
+
+	/* use veth1 ip 1 as tunnel source ip */
+	local_ip = IP6_ADDR1_HEX_VETH1;
+	err = bpf_map_update_elem(local_ip_map_fd, &key, &local_ip, BPF_ANY);
+	if (!ASSERT_OK(err, "update bpf local_ip_map"))
+		goto done;
+
+	/* ping test */
+	err = test_ping4();
+	if (!ASSERT_OK(err, "test ping ipv4"))
+		goto done;
+
+fail:
+done:
+	if (local_ip_map_fd >= 0)
+		close(local_ip_map_fd);
+	if (skel)
+		test_tunnel_kern__destroy(skel);
+}
+
+static void test_ip6vxlan_tunnel_source(void)
+{
+	struct test_tunnel_kern *skel = NULL;
+	int local_ip_map_fd = 0, key = 0;
+	uint local_ip;
+	int err;
+
+	/* add vxlan tunnel */
+	err = add_ip6vxlan_tunnel(IP6_ADDR2_VETH1);
+	if (!ASSERT_OK(err, "add ip6vxlan tunnel"))
+		goto done;
+
+	/* load and attach bpf prog to tunnel dev tc hook point */
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		goto done;
+	err = bpf_program__pin(skel->progs.ip6vxlan_set_tunnel,
+			       EGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " EGRESS_PROG_PIN_FILE))
+		goto done;
+	err = bpf_program__pin(skel->progs.ip6vxlan_get_tunnel,
+			       INGRESS_PROG_PIN_FILE);
+	if (!ASSERT_OK(err, "pin " INGRESS_PROG_PIN_FILE))
+		goto done;
+	SYS("tc qdisc add dev ip6vxlan11 clsact");
+	SYS("tc filter add dev ip6vxlan11 ingress bpf da object-pinned %s",
+	    INGRESS_PROG_PIN_FILE);
+	SYS("tc filter add dev ip6vxlan11 egress bpf da object-pinned %s",
+	    EGRESS_PROG_PIN_FILE);
+
+	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
+	if (!ASSERT_GE(local_ip_map_fd, 0, "get local_ip_map fd "))
+		goto done;
+
+	/* use veth1 ip 2 as tunnel source ip */
+	SYS("ip -6 addr add " IP6_ADDR2_VETH1 "/96 dev veth1");
+	local_ip = IP6_ADDR2_HEX_VETH1;
+	err = bpf_map_update_elem(local_ip_map_fd, &key, &local_ip, BPF_ANY);
+	if (!ASSERT_OK(err, "update bpf local_ip_map"))
+		goto done;
+
+	/* ping test */
+	err = test_ping4();
+	if (!ASSERT_OK(err, "test ping ipv4"))
+		goto done;
+
+fail:
+done:
+	if (local_ip_map_fd >= 0)
+		close(local_ip_map_fd);
+	if (skel)
+		test_tunnel_kern__destroy(skel);
+}
+
+#define RUN_TEST(name)							\
+	({								\
+		if (test__start_subtest(#name)) {			\
+			if (ASSERT_OK(config_device(), "config device"))\
+				test_ ## name();			\
+			cleanup();					\
+		}							\
+	})
+
+static void *test_tunnel_run_tests(void *arg)
+{
+	cleanup();
+
+	RUN_TEST(vxlan_tunnel);
+	RUN_TEST(ip6vxlan_tunnel);
+	RUN_TEST(vxlan_tunnel_source);
+	RUN_TEST(ip6vxlan_tunnel_source);
+
+	return NULL;
+}
+
+void serial_test_tunnel(void)
+{
+	pthread_t test_thread;
+	int err;
+
+	/* Run the tests in their own thread to isolate the namespace changes
+	 * so they do not affect the environment of other tests.
+	 * (specifically needed because of unshare(CLONE_NEWNS) in open_netns())
+	 */
+	err = pthread_create(&test_thread, NULL, &test_tunnel_run_tests, NULL);
+	if (ASSERT_OK(err, "pthread_create"))
+		ASSERT_OK(pthread_join(test_thread, NULL), "pthread_join");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index ef0dde83b85a..c6ddaea9e3fa 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -40,8 +40,16 @@ struct vxlan_metadata {
 	__u32     gbp;
 };
 
-SEC("gre_set_tunnel")
-int _gre_set_tunnel(struct __sk_buff *skb)
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} local_ip_map SEC(".maps");
+
+
+SEC("tc")
+int gre_set_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
@@ -62,8 +70,8 @@ int _gre_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("gre_get_tunnel")
-int _gre_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int gre_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
@@ -79,8 +87,8 @@ int _gre_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip6gretap_set_tunnel")
-int _ip6gretap_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6gretap_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
 	int ret;
@@ -103,8 +111,8 @@ int _ip6gretap_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip6gretap_get_tunnel")
-int _ip6gretap_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6gretap_get_tunnel(struct __sk_buff *skb)
 {
 	char fmt[] = "key %d remote ip6 ::%x label %x\n";
 	struct bpf_tunnel_key key;
@@ -123,8 +131,8 @@ int _ip6gretap_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("erspan_set_tunnel")
-int _erspan_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int erspan_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
@@ -166,8 +174,8 @@ int _erspan_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("erspan_get_tunnel")
-int _erspan_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int erspan_get_tunnel(struct __sk_buff *skb)
 {
 	char fmt[] = "key %d remote ip 0x%x erspan version %d\n";
 	struct bpf_tunnel_key key;
@@ -207,8 +215,8 @@ int _erspan_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip4ip6erspan_set_tunnel")
-int _ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
@@ -251,8 +259,8 @@ int _ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip4ip6erspan_get_tunnel")
-int _ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 {
 	char fmt[] = "ip6erspan get key %d remote ip6 ::%x erspan version %d\n";
 	struct bpf_tunnel_key key;
@@ -293,14 +301,23 @@ int _ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("vxlan_set_tunnel")
-int _vxlan_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int vxlan_set_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
 	struct vxlan_metadata md;
+	__u32 index = 0;
+	__u32 *local_ip = NULL;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
 
 	__builtin_memset(&key, 0x0, sizeof(key));
+	key.local_ipv4 = *local_ip;
 	key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
 	key.tunnel_id = 2;
 	key.tunnel_tos = 0;
@@ -323,13 +340,22 @@ int _vxlan_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("vxlan_get_tunnel")
-int _vxlan_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int vxlan_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
 	struct vxlan_metadata md;
 	char fmt[] = "key %d remote ip 0x%x vxlan gbp 0x%x\n";
+	char fmt2[] = "local ip 0x%x\n";
+	__u32 index = 0;
+	__u32 *local_ip = NULL;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
@@ -343,19 +369,33 @@ int _vxlan_get_tunnel(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			key.tunnel_id, key.remote_ipv4, md.gbp);
+	if (key.local_ipv4 != *local_ip) {
+		bpf_trace_printk(fmt, sizeof(fmt),
+				 key.tunnel_id, key.remote_ipv4, md.gbp);
+		bpf_trace_printk(fmt2, sizeof(fmt2), key.local_ipv4);
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
 
 	return TC_ACT_OK;
 }
 
-SEC("ip6vxlan_set_tunnel")
-int _ip6vxlan_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6vxlan_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
 	int ret;
+	__u32 index = 0;
+	__u32 *local_ip;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
 
 	__builtin_memset(&key, 0x0, sizeof(key));
+	key.local_ipv6[3] = bpf_htonl(*local_ip);
 	key.remote_ipv6[3] = bpf_htonl(0x11); /* ::11 */
 	key.tunnel_id = 22;
 	key.tunnel_tos = 0;
@@ -371,12 +411,21 @@ int _ip6vxlan_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip6vxlan_get_tunnel")
-int _ip6vxlan_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6vxlan_get_tunnel(struct __sk_buff *skb)
 {
 	char fmt[] = "key %d remote ip6 ::%x label %x\n";
+	char fmt2[] = "local ip6 ::%x\n";
 	struct bpf_tunnel_key key;
 	int ret;
+	__u32 index = 0;
+	__u32 *local_ip;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
@@ -385,14 +434,20 @@ int _ip6vxlan_get_tunnel(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			 key.tunnel_id, key.remote_ipv6[3], key.tunnel_label);
+	if (bpf_ntohl(key.local_ipv6[3]) != *local_ip) {
+		bpf_trace_printk(fmt, sizeof(fmt),
+				 key.tunnel_id,
+				 key.remote_ipv6[3], key.tunnel_label);
+		bpf_trace_printk(fmt2, sizeof(fmt2), key.local_ipv6[3]);
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
 
 	return TC_ACT_OK;
 }
 
-SEC("geneve_set_tunnel")
-int _geneve_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int geneve_set_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
@@ -429,8 +484,8 @@ int _geneve_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("geneve_get_tunnel")
-int _geneve_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int geneve_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
@@ -452,8 +507,8 @@ int _geneve_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip6geneve_set_tunnel")
-int _ip6geneve_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6geneve_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
 	struct geneve_opt gopt;
@@ -490,8 +545,8 @@ int _ip6geneve_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip6geneve_get_tunnel")
-int _ip6geneve_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6geneve_get_tunnel(struct __sk_buff *skb)
 {
 	char fmt[] = "key %d remote ip 0x%x geneve class 0x%x\n";
 	struct bpf_tunnel_key key;
@@ -515,8 +570,8 @@ int _ip6geneve_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ipip_set_tunnel")
-int _ipip_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ipip_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
 	void *data = (void *)(long)skb->data;
@@ -544,8 +599,8 @@ int _ipip_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ipip_get_tunnel")
-int _ipip_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ipip_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
@@ -561,8 +616,8 @@ int _ipip_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ipip6_set_tunnel")
-int _ipip6_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ipip6_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
 	void *data = (void *)(long)skb->data;
@@ -592,8 +647,8 @@ int _ipip6_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ipip6_get_tunnel")
-int _ipip6_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ipip6_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
@@ -611,8 +666,8 @@ int _ipip6_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip6ip6_set_tunnel")
-int _ip6ip6_set_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6ip6_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
 	void *data = (void *)(long)skb->data;
@@ -641,8 +696,8 @@ int _ip6ip6_set_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("ip6ip6_get_tunnel")
-int _ip6ip6_get_tunnel(struct __sk_buff *skb)
+SEC("tc")
+int ip6ip6_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
@@ -660,8 +715,8 @@ int _ip6ip6_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("xfrm_get_state")
-int _xfrm_get_state(struct __sk_buff *skb)
+SEC("tc")
+int xfrm_get_state(struct __sk_buff *skb)
 {
 	struct bpf_xfrm_state x;
 	char fmt[] = "reqid %d spi 0x%x remote ip 0x%x\n";
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 2817d9948d59..e9ebc67d73f7 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -45,6 +45,7 @@
 # 5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet
 # 6) Forward the packet to the overlay tnl dev
 
+BPF_PIN_TUNNEL_DIR="/sys/fs/bpf/tc/tunnel"
 PING_ARG="-c 3 -w 10 -q"
 ret=0
 GREEN='\033[0;92m'
@@ -155,52 +156,6 @@ add_ip6erspan_tunnel()
 	ip link set dev $DEV up
 }
 
-add_vxlan_tunnel()
-{
-	# Set static ARP entry here because iptables set-mark works
-	# on L3 packet, as a result not applying to ARP packets,
-	# causing errors at get_tunnel_{key/opt}.
-
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE \
-		id 2 dstport 4789 gbp remote 172.16.1.200
-	ip netns exec at_ns0 \
-		ip link set dev $DEV_NS address 52:54:00:d9:01:00 up
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-	ip netns exec at_ns0 \
-		ip neigh add 10.1.1.200 lladdr 52:54:00:d9:02:00 dev $DEV_NS
-	ip netns exec at_ns0 iptables -A OUTPUT -j MARK --set-mark 0x800FF
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external gbp dstport 4789
-	ip link set dev $DEV address 52:54:00:d9:02:00 up
-	ip addr add dev $DEV 10.1.1.200/24
-	ip neigh add 10.1.1.100 lladdr 52:54:00:d9:01:00 dev $DEV
-}
-
-add_ip6vxlan_tunnel()
-{
-	#ip netns exec at_ns0 ip -4 addr del 172.16.1.100 dev veth0
-	ip netns exec at_ns0 ip -6 addr add ::11/96 dev veth0
-	ip netns exec at_ns0 ip link set dev veth0 up
-	#ip -4 addr del 172.16.1.200 dev veth1
-	ip -6 addr add dev veth1 ::22/96
-	ip link set dev veth1 up
-
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
-		local ::11 remote ::22
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external dstport 4789
-	ip addr add dev $DEV 10.1.1.200/24
-	ip link set dev $DEV up
-}
-
 add_geneve_tunnel()
 {
 	# at_ns0 namespace
@@ -403,58 +358,6 @@ test_ip6erspan()
         echo -e ${GREEN}"PASS: $TYPE"${NC}
 }
 
-test_vxlan()
-{
-	TYPE=vxlan
-	DEV_NS=vxlan00
-	DEV=vxlan11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_vxlan_tunnel
-	attach_bpf $DEV vxlan_set_tunnel vxlan_get_tunnel
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	check_err $?
-	cleanup
-
-	if [ $ret -ne 0 ]; then
-                echo -e ${RED}"FAIL: $TYPE"${NC}
-                return 1
-        fi
-        echo -e ${GREEN}"PASS: $TYPE"${NC}
-}
-
-test_ip6vxlan()
-{
-	TYPE=vxlan
-	DEV_NS=ip6vxlan00
-	DEV=ip6vxlan11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ip6vxlan_tunnel
-	ip link set dev veth1 mtu 1500
-	attach_bpf $DEV ip6vxlan_set_tunnel ip6vxlan_get_tunnel
-	# underlay
-	ping6 $PING_ARG ::11
-	# ip4 over ip6
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	check_err $?
-	cleanup
-
-	if [ $ret -ne 0 ]; then
-                echo -e ${RED}"FAIL: ip6$TYPE"${NC}
-                return 1
-        fi
-        echo -e ${GREEN}"PASS: ip6$TYPE"${NC}
-}
-
 test_geneve()
 {
 	TYPE=geneve
@@ -641,9 +544,11 @@ test_xfrm_tunnel()
 	config_device
 	> /sys/kernel/debug/tracing/trace
 	setup_xfrm_tunnel
+	mkdir -p ${BPF_PIN_TUNNEL_DIR}
+	bpftool prog loadall ./test_tunnel_kern.o ${BPF_PIN_TUNNEL_DIR}
 	tc qdisc add dev veth1 clsact
-	tc filter add dev veth1 proto ip ingress bpf da obj test_tunnel_kern.o \
-		sec xfrm_get_state
+	tc filter add dev veth1 proto ip ingress bpf da object-pinned \
+		${BPF_PIN_TUNNEL_DIR}/xfrm_get_state
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	sleep 1
 	grep "reqid 1" /sys/kernel/debug/tracing/trace
@@ -666,13 +571,17 @@ attach_bpf()
 	DEV=$1
 	SET=$2
 	GET=$3
+	mkdir -p ${BPF_PIN_TUNNEL_DIR}
+	bpftool prog loadall ./test_tunnel_kern.o ${BPF_PIN_TUNNEL_DIR}/
 	tc qdisc add dev $DEV clsact
-	tc filter add dev $DEV egress bpf da obj test_tunnel_kern.o sec $SET
-	tc filter add dev $DEV ingress bpf da obj test_tunnel_kern.o sec $GET
+	tc filter add dev $DEV egress bpf da object-pinned ${BPF_PIN_TUNNEL_DIR}/$SET
+	tc filter add dev $DEV ingress bpf da object-pinned ${BPF_PIN_TUNNEL_DIR}/$GET
 }
 
 cleanup()
 {
+        rm -rf ${BPF_PIN_TUNNEL_DIR}
+
 	ip netns delete at_ns0 2> /dev/null
 	ip link del veth1 2> /dev/null
 	ip link del ipip11 2> /dev/null
@@ -681,8 +590,6 @@ cleanup()
 	ip link del gretap11 2> /dev/null
 	ip link del ip6gre11 2> /dev/null
 	ip link del ip6gretap11 2> /dev/null
-	ip link del vxlan11 2> /dev/null
-	ip link del ip6vxlan11 2> /dev/null
 	ip link del geneve11 2> /dev/null
 	ip link del ip6geneve11 2> /dev/null
 	ip link del erspan11 2> /dev/null
@@ -714,7 +621,6 @@ enable_debug()
 {
 	echo 'file ip_gre.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file ip6_gre.c +p' > /sys/kernel/debug/dynamic_debug/control
-	echo 'file vxlan.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file geneve.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file ipip.c +p' > /sys/kernel/debug/dynamic_debug/control
 }
@@ -750,14 +656,6 @@ bpf_tunnel_test()
 	test_ip6erspan v2
 	errors=$(( $errors + $? ))
 
-	echo "Testing VXLAN tunnel..."
-	test_vxlan
-	errors=$(( $errors + $? ))
-
-	echo "Testing IP6VXLAN tunnel..."
-	test_ip6vxlan
-	errors=$(( $errors + $? ))
-
 	echo "Testing GENEVE tunnel..."
 	test_geneve
 	errors=$(( $errors + $? ))
-- 
2.20.1

