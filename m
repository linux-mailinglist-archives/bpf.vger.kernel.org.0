Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015959B5DF
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiHUSOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 14:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiHUSOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 14:14:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581D205DA
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 11:14:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so6624052wma.4
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0NOhQ+9Eg1hYodEfeL4gY+mnmGuJvDz8XKjUQSHxK6g=;
        b=EsnC0JiN4V6KxQAjlJACxefoYvBe1qQYc/yLnwQS9oeHzz0YvelIyPrJVcL8Gh0WZb
         W3yTG3CRo15sH6rvYAyKsil3vjZ/7pPezUQdGZs6zx0vfQWUpqOoF/PsWh1gZob5tKCD
         yQ+VryhkIEnB7RCyJt/gPJABwKEdbVwdm59Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0NOhQ+9Eg1hYodEfeL4gY+mnmGuJvDz8XKjUQSHxK6g=;
        b=qeUd7NdqA9oYyWE9xsfdX3fHxNd3B/jtV75rjkfe/L5QHucfp6i4viaHZUVH5DU+M/
         BYR/mjuvUvYgPgRzXbVKy/XETL9FmAYg671Gqbj0g4VyNoFmwLuLWN0MnPt/lN/1lKU3
         jXdC30Wnh84URPWfY9c13Uxj32D09QK8LFVgYxqiblMYRx5Ly63Lu5aqzFjzpzNuP7NO
         JEcBBnctDuOSs/03I2ZmEFJnoNnYXlnO4Y+CT1GiPuNT/Tc+WJ2hVjH4/2M5mDzZLNDd
         CNSMDEooF8RvGNRjRcRk1/cc970XNdvHYPRJm2L3zspl+gotdIZn+DULWxhmMPnYXfNR
         MTgw==
X-Gm-Message-State: ACgBeo3lGju6auOJk8ToGGN9ZYOislpWN8c+cDbkVAQf1EyeGnpNRYxZ
        dizg0v6NB/70JRtklW7FNlhgf2zB69HbW1/5ITilHU5hYGJEgLQgRt/mQpFYsrXmWzIPhHyr3QS
        h+GUL1TLSI7lvELJFhNkE3fLiDT0foqzyKBi1+q0myG0C65sNO1Tp+32z1Yg+Gs4ZQPy6TSWY
X-Google-Smtp-Source: AA6agR6LmoB4TuHuvkNFTHXnxjuG+EvA+koRoZAZJFyct30dmauDA/MEAqWWDRZcpcPEQ1SGoUJUIA==
X-Received: by 2002:a05:600c:20f:b0:3a5:a785:7f2a with SMTP id 15-20020a05600c020f00b003a5a7857f2amr13242865wmi.94.1661105649307;
        Sun, 21 Aug 2022 11:14:09 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4851000000b0021eff2ecb31sm9509303wrs.95.2022.08.21.11.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:14:08 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: Simplify test_tunnel setup for allowing non-local tunnel traffic
Date:   Sun, 21 Aug 2022 21:13:44 +0300
Message-Id: <20220821181345.337014-3-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181345.337014-1-shmulik.ladkani@gmail.com>
References: <20220821181345.337014-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 1115169f47ae ("selftests/bpf: Don't assign outer source IP to host")
removed the secondary IP (IP4_ADDR2_VETH1) assigned to veth1, in order
to test bpf_skb_set_tunnel_key's functionality when tunnel destination
isn't assigned to an interface.

The chosen setup for testing the "tunnel to unassigned outer IP"
scenario was rather complex: (1) static ARP entries in order to
bypass ARP (o/w requests will fail as the target address isn't assigned
locally), and (2) a BPF program running on veth1 ingress which
manipulates the IP header's daddr to the actual IP assigned to the
interface (o/w tunnel traffic won't be accepted locally).

This is complex, and adds a dependency on this hidden "dnat"-like eBPF
program, that needs to be replicated when new tunnel tests are added.

Instead, we can have a much simpler setup: Add the secondary IP as a
*local route* in a table pointed by a custom fib rule. No static arp
entries are needed, and the special eBPF program that "dnats" the outer
destination can be removed.

This commit is a revert of 1115169f47ae, with the addition of the local
route of IP4_ADDR2_VETH1 (instead of the original address assignment).

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
v2: Place the local route for the secondary IP in a custom table
    pointed by a custom fib rule; this ensures the IP is not considered
    assigned to a device.
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 23 ++----
 .../selftests/bpf/progs/test_tunnel_kern.c    | 80 +++----------------
 2 files changed, 17 insertions(+), 86 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index eea274110267..852da04ff281 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -82,7 +82,6 @@
 
 #define MAC_TUNL_DEV0 "52:54:00:d9:01:00"
 #define MAC_TUNL_DEV1 "52:54:00:d9:02:00"
-#define MAC_VETH1 "52:54:00:d9:03:00"
 
 #define VXLAN_TUNL_DEV0 "vxlan00"
 #define VXLAN_TUNL_DEV1 "vxlan11"
@@ -109,9 +108,15 @@
 static int config_device(void)
 {
 	SYS("ip netns add at_ns0");
-	SYS("ip link add veth0 address " MAC_VETH1 " type veth peer name veth1");
+	SYS("ip link add veth0 type veth peer name veth1");
 	SYS("ip link set veth0 netns at_ns0");
 	SYS("ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
+	/* Create a custom rule routing IP4_ADDR2_VETH1 as local.
+	 * Do not place it in "local" table, to avoid this IP being considered
+	 * assigned to a device.
+	 */
+	SYS("ip rule add to " IP4_ADDR2_VETH1 " table 20");
+	SYS("ip route add local " IP4_ADDR2_VETH1 "/32 dev veth1 table 20");
 	SYS("ip link set dev veth1 up mtu 1500");
 	SYS("ip netns exec at_ns0 ip addr add " IP4_ADDR_VETH0 "/24 dev veth0");
 	SYS("ip netns exec at_ns0 ip link set dev veth0 up mtu 1500");
@@ -125,6 +130,7 @@ static void cleanup(void)
 {
 	SYS_NOFAIL("test -f /var/run/netns/at_ns0 && ip netns delete at_ns0");
 	SYS_NOFAIL("ip link del veth1 2> /dev/null");
+	SYS_NOFAIL("ip rule del to %s table 20 2> /dev/null", IP4_ADDR2_VETH1);
 	SYS_NOFAIL("ip link del %s 2> /dev/null", VXLAN_TUNL_DEV1);
 	SYS_NOFAIL("ip link del %s 2> /dev/null", IP6VXLAN_TUNL_DEV1);
 }
@@ -140,8 +146,6 @@ static int add_vxlan_tunnel(void)
 	    VXLAN_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
 	SYS("ip netns exec at_ns0 ip neigh add %s lladdr %s dev %s",
 	    IP4_ADDR_TUNL_DEV1, MAC_TUNL_DEV1, VXLAN_TUNL_DEV0);
-	SYS("ip netns exec at_ns0 ip neigh add %s lladdr %s dev veth0",
-	    IP4_ADDR2_VETH1, MAC_VETH1);
 
 	/* root namespace */
 	SYS("ip link add dev %s type vxlan external gbp dstport 4789",
@@ -279,17 +283,6 @@ static void test_vxlan_tunnel(void)
 	if (attach_tc_prog(&tc_hook, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
-	/* load and attach bpf prog to veth dev tc hook point */
-	ifindex = if_nametoindex("veth1");
-	if (!ASSERT_NEQ(ifindex, 0, "veth1 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
-	set_dst_prog_fd = bpf_program__fd(skel->progs.veth_set_outer_dst);
-	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, set_dst_prog_fd, -1))
-		goto done;
-
 	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
 	nstoken = open_netns("at_ns0");
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index df0673c4ecbe..17f2f325b3f3 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -14,24 +14,15 @@
 #include <linux/if_packet.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/icmp.h>
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/pkt_cls.h>
 #include <linux/erspan.h>
-#include <linux/udp.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
 #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
 
-#define VXLAN_UDP_PORT 4789
-
-/* Only IPv4 address assigned to veth1.
- * 172.16.1.200
- */
-#define ASSIGNED_ADDR_VETH1 0xac1001c8
-
 struct geneve_opt {
 	__be16	opt_class;
 	__u8	type;
@@ -42,11 +33,6 @@ struct geneve_opt {
 	__u8	opt_data[8]; /* hard-coded to 8 byte */
 };
 
-struct vxlanhdr {
-	__be32 vx_flags;
-	__be32 vx_vni;
-} __attribute__((packed));
-
 struct vxlan_metadata {
 	__u32     gbp;
 };
@@ -383,8 +369,14 @@ int vxlan_get_tunnel_src(struct __sk_buff *skb)
 	int ret;
 	struct bpf_tunnel_key key;
 	struct vxlan_metadata md;
-	__u32 orig_daddr;
 	__u32 index = 0;
+	__u32 *local_ip = NULL;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
@@ -398,10 +390,11 @@ int vxlan_get_tunnel_src(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	if (key.local_ipv4 != ASSIGNED_ADDR_VETH1 || md.gbp != 0x800FF) {
+	if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {
 		bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",
 			   key.tunnel_id, key.local_ipv4,
 			   key.remote_ipv4, md.gbp);
+		bpf_printk("local_ip 0x%x\n", *local_ip);
 		log_err(ret);
 		return TC_ACT_SHOT;
 	}
@@ -409,61 +402,6 @@ int vxlan_get_tunnel_src(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("tc")
-int veth_set_outer_dst(struct __sk_buff *skb)
-{
-	struct ethhdr *eth = (struct ethhdr *)(long)skb->data;
-	__u32 assigned_ip = bpf_htonl(ASSIGNED_ADDR_VETH1);
-	void *data_end = (void *)(long)skb->data_end;
-	struct udphdr *udph;
-	struct iphdr *iph;
-	__u32 index = 0;
-	int ret = 0;
-	int shrink;
-	__s64 csum;
-
-	if ((void *)eth + sizeof(*eth) > data_end) {
-		log_err(ret);
-		return TC_ACT_SHOT;
-	}
-
-	if (eth->h_proto != bpf_htons(ETH_P_IP))
-		return TC_ACT_OK;
-
-	iph = (struct iphdr *)(eth + 1);
-	if ((void *)iph + sizeof(*iph) > data_end) {
-		log_err(ret);
-		return TC_ACT_SHOT;
-	}
-	if (iph->protocol != IPPROTO_UDP)
-		return TC_ACT_OK;
-
-	udph = (struct udphdr *)(iph + 1);
-	if ((void *)udph + sizeof(*udph) > data_end) {
-		log_err(ret);
-		return TC_ACT_SHOT;
-	}
-	if (udph->dest != bpf_htons(VXLAN_UDP_PORT))
-		return TC_ACT_OK;
-
-	if (iph->daddr != assigned_ip) {
-		csum = bpf_csum_diff(&iph->daddr, sizeof(__u32), &assigned_ip,
-				     sizeof(__u32), 0);
-		if (bpf_skb_store_bytes(skb, ETH_HLEN + offsetof(struct iphdr, daddr),
-					&assigned_ip, sizeof(__u32), 0) < 0) {
-			log_err(ret);
-			return TC_ACT_SHOT;
-		}
-		if (bpf_l3_csum_replace(skb, ETH_HLEN + offsetof(struct iphdr, check),
-					0, csum, 0) < 0) {
-			log_err(ret);
-			return TC_ACT_SHOT;
-		}
-		bpf_skb_change_type(skb, PACKET_HOST);
-	}
-	return TC_ACT_OK;
-}
-
 SEC("tc")
 int ip6vxlan_set_tunnel_dst(struct __sk_buff *skb)
 {
-- 
2.37.2

