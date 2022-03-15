Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DB4D99F2
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiCOLHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiCOLHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 07:07:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843AE4C40F
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 04:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11DBBB81369
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A80C340E8;
        Tue, 15 Mar 2022 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647342393;
        bh=OiJxJXPh4zvOWaj6PIKHghKG9YTzCcsIlG9nFNwYOQw=;
        h=From:To:Cc:Subject:Date:From;
        b=gtjwFd/Po6zzniY4v+1A8hMEcnQkT+gXMPrQhwLr90g/3RS8gJwd5ak0AuMevhBHF
         pwUA9XdzuEPweZk/6cZcPc1x1TbHnfXMecDKKV+fY1YjxH+PAPuqlE56NTnfhlcOtR
         7oQIF/FN8ic6PLvXswj/R3Kh3ExM66vdrAm5pLlkzeNd0PXss8UPU0iZ/jtKOtg70L
         SfqvqGyG2pFW8DZH3X21wBC/urS1o8nT/ShM1mG0XQcmTyapNo+X6NFqOFBJxUj0HN
         Kwv1XMQHg/YcOHEq/FOXhmhvOyJ6m8YfBS7guAqi/wzgUrBXvsKnlfcwgqJaMW1IHG
         9ji9FNY0jhzNg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, lorenzo.bianconi@redhat.com,
        andrii@kernel.org
Subject: [PATCH bpf-next] samples: bpf: convert xdp_router_ipv4 to XDP samples helper
Date:   Tue, 15 Mar 2022 12:06:19 +0100
Message-Id: <7c20ed355c2f587d3e1c81a6b398cb8f68304780.1647342110.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rely on the libbpf skeleton facility and other utilities provided by XDP
sample helpers in xdp_router_ipv4 sample.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 samples/bpf/Makefile               |   9 +-
 samples/bpf/xdp_router_ipv4.bpf.c  | 180 +++++++++++
 samples/bpf/xdp_router_ipv4_kern.c | 186 ------------
 samples/bpf/xdp_router_ipv4_user.c | 462 ++++++++++++-----------------
 4 files changed, 377 insertions(+), 460 deletions(-)
 create mode 100644 samples/bpf/xdp_router_ipv4.bpf.c
 delete mode 100644 samples/bpf/xdp_router_ipv4_kern.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 38638845db9d..b4fa0e69aa14 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -96,7 +96,6 @@ test_cgrp2_sock2-objs := test_cgrp2_sock2.o
 xdp1-objs := xdp1_user.o
 # reuse xdp1 source intentionally
 xdp2-objs := xdp1_user.o
-xdp_router_ipv4-objs := xdp_router_ipv4_user.o
 test_current_task_under_cgroup-objs := $(CGROUP_HELPERS) \
 				       test_current_task_under_cgroup_user.o
 trace_event-objs := trace_event_user.o $(TRACE_HELPERS)
@@ -124,6 +123,7 @@ xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o $(XDP_SAMPLE)
 xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
+xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -153,7 +153,6 @@ always-y += parse_varlen.o parse_simple.o parse_ldabs.o
 always-y += test_cgrp2_tc_kern.o
 always-y += xdp1_kern.o
 always-y += xdp2_kern.o
-always-y += xdp_router_ipv4_kern.o
 always-y += test_current_task_under_cgroup_kern.o
 always-y += trace_event_kern.o
 always-y += sampleip_kern.o
@@ -342,6 +341,7 @@ $(obj)/xdp_redirect_map_multi_user.o: $(obj)/xdp_redirect_map_multi.skel.h
 $(obj)/xdp_redirect_map_user.o: $(obj)/xdp_redirect_map.skel.h
 $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
+$(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
 
 $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
@@ -399,6 +399,7 @@ $(obj)/xdp_redirect_map_multi.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_redirect_map.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_redirect.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_monitor.bpf.o: $(obj)/xdp_sample.bpf.o
+$(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
@@ -409,7 +410,8 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-c $(filter %.bpf.c,$^) -o $@
 
 LINKED_SKELS := xdp_redirect_cpu.skel.h xdp_redirect_map_multi.skel.h \
-		xdp_redirect_map.skel.h xdp_redirect.skel.h xdp_monitor.skel.h
+		xdp_redirect_map.skel.h xdp_redirect.skel.h xdp_monitor.skel.h \
+		xdp_router_ipv4.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_redirect_cpu.skel.h-deps := xdp_redirect_cpu.bpf.o xdp_sample.bpf.o
@@ -417,6 +419,7 @@ xdp_redirect_map_multi.skel.h-deps := xdp_redirect_map_multi.bpf.o xdp_sample.bp
 xdp_redirect_map.skel.h-deps := xdp_redirect_map.bpf.o xdp_sample.bpf.o
 xdp_redirect.skel.h-deps := xdp_redirect.bpf.o xdp_sample.bpf.o
 xdp_monitor.skel.h-deps := xdp_monitor.bpf.o xdp_sample.bpf.o
+xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/bpf/xdp_router_ipv4.bpf.c b/samples/bpf/xdp_router_ipv4.bpf.c
new file mode 100644
index 000000000000..248119ca7938
--- /dev/null
+++ b/samples/bpf/xdp_router_ipv4.bpf.c
@@ -0,0 +1,180 @@
+/* Copyright (C) 2017 Cavium, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ */
+
+#include "vmlinux.h"
+#include "xdp_sample.bpf.h"
+#include "xdp_sample_shared.h"
+
+#define ETH_ALEN	6
+#define ETH_P_8021Q	0x8100
+#define ETH_P_8021AD	0x88A8
+
+struct trie_value {
+	__u8 prefix[4];
+	__be64 value;
+	int ifindex;
+	int metric;
+	__be32 gw;
+};
+
+/* Key for lpm_trie */
+union key_4 {
+	u32 b32[2];
+	u8 b8[8];
+};
+
+struct arp_entry {
+	__be64 mac;
+	__be32 dst;
+};
+
+struct direct_map {
+	struct arp_entry arp;
+	int ifindex;
+	__be64 mac;
+};
+
+/* Map for trie implementation */
+struct {
+	__uint(type, BPF_MAP_TYPE_LPM_TRIE);
+	__uint(key_size, 8);
+	__uint(value_size, sizeof(struct trie_value));
+	__uint(max_entries, 50);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} lpm_map SEC(".maps");
+
+/* Map for ARP table */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __be32);
+	__type(value, __be64);
+	__uint(max_entries, 50);
+} arp_table SEC(".maps");
+
+/* Map to keep the exact match entries in the route table */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __be32);
+	__type(value, struct direct_map);
+	__uint(max_entries, 50);
+} exact_match SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__uint(max_entries, 100);
+} tx_port SEC(".maps");
+
+SEC("xdp")
+int xdp_router_ipv4_prog(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct ethhdr *eth = data;
+	u64 nh_off = sizeof(*eth);
+	struct datarec *rec;
+	__be16 h_proto;
+	u32 key = 0;
+
+	rec = bpf_map_lookup_elem(&rx_cnt, &key);
+	if (rec)
+		NO_TEAR_INC(rec->processed);
+
+	if (data + nh_off > data_end)
+		goto drop;
+
+	h_proto = eth->h_proto;
+	if (h_proto == bpf_htons(ETH_P_8021Q) ||
+	    h_proto == bpf_htons(ETH_P_8021AD)) {
+		struct vlan_hdr *vhdr;
+
+		vhdr = data + nh_off;
+		nh_off += sizeof(struct vlan_hdr);
+		if (data + nh_off > data_end)
+			goto drop;
+
+		h_proto = vhdr->h_vlan_encapsulated_proto;
+	}
+
+	switch (bpf_ntohs(h_proto)) {
+	case ETH_P_ARP:
+		if (rec)
+			NO_TEAR_INC(rec->xdp_pass);
+		return XDP_PASS;
+	case ETH_P_IP: {
+		struct iphdr *iph = data + nh_off;
+		struct direct_map *direct_entry;
+		__be64 *dest_mac, *src_mac;
+		int forward_to;
+
+		if (iph + 1 > data_end)
+			goto drop;
+
+		direct_entry = bpf_map_lookup_elem(&exact_match, &iph->daddr);
+
+		/* Check for exact match, this would give a faster lookup */
+		if (direct_entry && direct_entry->mac &&
+		    direct_entry->arp.mac) {
+			src_mac = &direct_entry->mac;
+			dest_mac = &direct_entry->arp.mac;
+			forward_to = direct_entry->ifindex;
+		} else {
+			struct trie_value *prefix_value;
+			union key_4 key4;
+
+			/* Look up in the trie for lpm */
+			key4.b32[0] = 32;
+			key4.b8[4] = iph->daddr & 0xff;
+			key4.b8[5] = (iph->daddr >> 8) & 0xff;
+			key4.b8[6] = (iph->daddr >> 16) & 0xff;
+			key4.b8[7] = (iph->daddr >> 24) & 0xff;
+
+			prefix_value = bpf_map_lookup_elem(&lpm_map, &key4);
+			if (!prefix_value)
+				goto drop;
+
+			forward_to = prefix_value->ifindex;
+			src_mac = &prefix_value->value;
+			if (!src_mac)
+				goto drop;
+
+			dest_mac = bpf_map_lookup_elem(&arp_table, &iph->daddr);
+			if (!dest_mac) {
+				if (!prefix_value->gw)
+					goto drop;
+
+				dest_mac = bpf_map_lookup_elem(&arp_table,
+							       &prefix_value->gw);
+			}
+		}
+
+		if (src_mac && dest_mac) {
+			int ret;
+
+			__builtin_memcpy(eth->h_dest, dest_mac, ETH_ALEN);
+			__builtin_memcpy(eth->h_source, src_mac, ETH_ALEN);
+
+			ret = bpf_redirect_map(&tx_port, forward_to, 0);
+			if (ret == XDP_REDIRECT) {
+				if (rec)
+					NO_TEAR_INC(rec->xdp_redirect);
+				return ret;
+			}
+		}
+	}
+	default:
+		break;
+	}
+drop:
+	if (rec)
+		NO_TEAR_INC(rec->xdp_drop);
+
+	return XDP_DROP;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_router_ipv4_kern.c b/samples/bpf/xdp_router_ipv4_kern.c
deleted file mode 100644
index b37ca2b13063..000000000000
--- a/samples/bpf/xdp_router_ipv4_kern.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/* Copyright (C) 2017 Cavium, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License
- * as published by the Free Software Foundation.
- */
-#define KBUILD_MODNAME "foo"
-#include <uapi/linux/bpf.h>
-#include <linux/in.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/if_vlan.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <bpf/bpf_helpers.h>
-#include <linux/slab.h>
-#include <net/ip_fib.h>
-
-struct trie_value {
-	__u8 prefix[4];
-	__be64 value;
-	int ifindex;
-	int metric;
-	__be32 gw;
-};
-
-/* Key for lpm_trie*/
-union key_4 {
-	u32 b32[2];
-	u8 b8[8];
-};
-
-struct arp_entry {
-	__be64 mac;
-	__be32 dst;
-};
-
-struct direct_map {
-	struct arp_entry arp;
-	int ifindex;
-	__be64 mac;
-};
-
-/* Map for trie implementation*/
-struct {
-	__uint(type, BPF_MAP_TYPE_LPM_TRIE);
-	__uint(key_size, 8);
-	__uint(value_size, sizeof(struct trie_value));
-	__uint(max_entries, 50);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-} lpm_map SEC(".maps");
-
-/* Map for counter*/
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__type(key, u32);
-	__type(value, u64);
-	__uint(max_entries, 256);
-} rxcnt SEC(".maps");
-
-/* Map for ARP table*/
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, __be32);
-	__type(value, __be64);
-	__uint(max_entries, 50);
-} arp_table SEC(".maps");
-
-/* Map to keep the exact match entries in the route table*/
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, __be32);
-	__type(value, struct direct_map);
-	__uint(max_entries, 50);
-} exact_match SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_DEVMAP);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
-	__uint(max_entries, 100);
-} tx_port SEC(".maps");
-
-/* Function to set source and destination mac of the packet */
-static inline void set_src_dst_mac(void *data, void *src, void *dst)
-{
-	unsigned short *source = src;
-	unsigned short *dest  = dst;
-	unsigned short *p = data;
-
-	__builtin_memcpy(p, dest, 6);
-	__builtin_memcpy(p + 3, source, 6);
-}
-
-/* Parse IPV4 packet to get SRC, DST IP and protocol */
-static inline int parse_ipv4(void *data, u64 nh_off, void *data_end,
-			     __be32 *src, __be32 *dest)
-{
-	struct iphdr *iph = data + nh_off;
-
-	if (iph + 1 > data_end)
-		return 0;
-	*src = iph->saddr;
-	*dest = iph->daddr;
-	return iph->protocol;
-}
-
-SEC("xdp_router_ipv4")
-int xdp_router_ipv4_prog(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	__be64 *dest_mac = NULL, *src_mac = NULL;
-	void *data = (void *)(long)ctx->data;
-	struct trie_value *prefix_value;
-	int rc = XDP_DROP, forward_to;
-	struct ethhdr *eth = data;
-	union key_4 key4;
-	long *value;
-	u16 h_proto;
-	u32 ipproto;
-	u64 nh_off;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return rc;
-
-	h_proto = eth->h_proto;
-
-	if (h_proto == htons(ETH_P_8021Q) || h_proto == htons(ETH_P_8021AD)) {
-		struct vlan_hdr *vhdr;
-
-		vhdr = data + nh_off;
-		nh_off += sizeof(struct vlan_hdr);
-		if (data + nh_off > data_end)
-			return rc;
-		h_proto = vhdr->h_vlan_encapsulated_proto;
-	}
-	if (h_proto == htons(ETH_P_ARP)) {
-		return XDP_PASS;
-	} else if (h_proto == htons(ETH_P_IP)) {
-		struct direct_map *direct_entry;
-		__be32 src_ip = 0, dest_ip = 0;
-
-		ipproto = parse_ipv4(data, nh_off, data_end, &src_ip, &dest_ip);
-		direct_entry = bpf_map_lookup_elem(&exact_match, &dest_ip);
-		/* Check for exact match, this would give a faster lookup*/
-		if (direct_entry && direct_entry->mac && direct_entry->arp.mac) {
-			src_mac = &direct_entry->mac;
-			dest_mac = &direct_entry->arp.mac;
-			forward_to = direct_entry->ifindex;
-		} else {
-			/* Look up in the trie for lpm*/
-			key4.b32[0] = 32;
-			key4.b8[4] = dest_ip & 0xff;
-			key4.b8[5] = (dest_ip >> 8) & 0xff;
-			key4.b8[6] = (dest_ip >> 16) & 0xff;
-			key4.b8[7] = (dest_ip >> 24) & 0xff;
-			prefix_value = bpf_map_lookup_elem(&lpm_map, &key4);
-			if (!prefix_value)
-				return XDP_DROP;
-			src_mac = &prefix_value->value;
-			if (!src_mac)
-				return XDP_DROP;
-			dest_mac = bpf_map_lookup_elem(&arp_table, &dest_ip);
-			if (!dest_mac) {
-				if (!prefix_value->gw)
-					return XDP_DROP;
-				dest_ip = prefix_value->gw;
-				dest_mac = bpf_map_lookup_elem(&arp_table, &dest_ip);
-			}
-			forward_to = prefix_value->ifindex;
-		}
-	} else {
-		ipproto = 0;
-	}
-	if (src_mac && dest_mac) {
-		set_src_dst_mac(data, src_mac, dest_mac);
-		value = bpf_map_lookup_elem(&rxcnt, &ipproto);
-		if (value)
-			*value += 1;
-		return  bpf_redirect_map(&tx_port, forward_to, 0);
-	}
-	return rc;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 6dae87d83e1c..c57bd93c111b 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -24,70 +24,36 @@
 #include <bpf/libbpf.h>
 #include <sys/resource.h>
 #include <libgen.h>
+#include <getopt.h>
+#include "xdp_sample_user.h"
+#include "xdp_router_ipv4.skel.h"
 
-int sock, sock_arp, flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-static int total_ifindex;
-static int *ifindex_list;
-static __u32 *prog_id_list;
-char buf[8192];
+static const char *__doc__ =
+"XDP IPv4 router implementation\n"
+"Usage: xdp_router_ipv4 <IFNAME-0> ... <IFNAME-N>\n";
+
+static char buf[8192];
 static int lpm_map_fd;
-static int rxcnt_map_fd;
 static int arp_table_map_fd;
 static int exact_match_map_fd;
 static int tx_port_map_fd;
 
-static int get_route_table(int rtm_family);
-static void int_exit(int sig)
-{
-	__u32 prog_id = 0;
-	int i = 0;
+static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
+		  SAMPLE_DEVMAP_XMIT_CNT_MULTI | SAMPLE_EXCEPTION_CNT;
 
-	for (i = 0; i < total_ifindex; i++) {
-		if (bpf_xdp_query_id(ifindex_list[i], flags, &prog_id)) {
-			printf("bpf_xdp_query_id on iface %d failed\n",
-			       ifindex_list[i]);
-			exit(1);
-		}
-		if (prog_id_list[i] == prog_id)
-			bpf_xdp_detach(ifindex_list[i], flags, NULL);
-		else if (!prog_id)
-			printf("couldn't find a prog id on iface %d\n",
-			       ifindex_list[i]);
-		else
-			printf("program on iface %d changed, not removing\n",
-			       ifindex_list[i]);
-		prog_id = 0;
-	}
-	exit(0);
-}
+DEFINE_SAMPLE_INIT(xdp_router_ipv4);
 
-static void close_and_exit(int sig)
-{
-	close(sock);
-	close(sock_arp);
-
-	int_exit(0);
-}
+static const struct option long_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ "skb-mode", no_argument, NULL, 'S' },
+	{ "force", no_argument, NULL, 'F' },
+	{ "interval", required_argument, NULL, 'i' },
+	{ "verbose", no_argument, NULL, 'v' },
+	{ "stats", no_argument, NULL, 's' },
+	{}
+};
 
-/* Get the mac address of the interface given interface name */
-static __be64 getmac(char *iface)
-{
-	struct ifreq ifr;
-	__be64 mac = 0;
-	int fd, i;
-
-	fd = socket(AF_INET, SOCK_DGRAM, 0);
-	ifr.ifr_addr.sa_family = AF_INET;
-	strncpy(ifr.ifr_name, iface, IFNAMSIZ - 1);
-	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0) {
-		printf("ioctl failed leaving....\n");
-		return -1;
-	}
-	for (i = 0; i < 6 ; i++)
-		*((__u8 *)&mac + i) = (__u8)ifr.ifr_hwaddr.sa_data[i];
-	close(fd);
-	return mac;
-}
+static int get_route_table(int rtm_family);
 
 static int recv_msg(struct sockaddr_nl sock_addr, int sock)
 {
@@ -130,7 +96,6 @@ static void read_route(struct nlmsghdr *nh, int nll)
 	int i;
 	struct route_table {
 		int  dst_len, iface, metric;
-		char *iface_name;
 		__be32 dst, gw;
 		__be64 mac;
 	} route;
@@ -145,17 +110,7 @@ static void read_route(struct nlmsghdr *nh, int nll)
 		__be64 mac;
 	} direct_entry;
 
-	if (nh->nlmsg_type == RTM_DELROUTE)
-		printf("DELETING Route entry\n");
-	else if (nh->nlmsg_type == RTM_GETROUTE)
-		printf("READING Route entry\n");
-	else if (nh->nlmsg_type == RTM_NEWROUTE)
-		printf("NEW Route entry\n");
-	else
-		printf("%d\n", nh->nlmsg_type);
-
 	memset(&route, 0, sizeof(route));
-	printf("Destination     Gateway         Genmask         Metric Iface\n");
 	for (; NLMSG_OK(nh, nll); nh = NLMSG_NEXT(nh, nll)) {
 		rt_msg = (struct rtmsg *)NLMSG_DATA(nh);
 		rtm_family = rt_msg->rtm_family;
@@ -192,11 +147,7 @@ static void read_route(struct nlmsghdr *nh, int nll)
 		route.gw = atoi(gws);
 		route.iface = atoi(ifs);
 		route.metric = atoi(metrics);
-		route.iface_name = alloca(sizeof(char *) * IFNAMSIZ);
-		route.iface_name = if_indextoname(route.iface, route.iface_name);
-		route.mac = getmac(route.iface_name);
-		if (route.mac == -1)
-			int_exit(0);
+		assert(get_mac_addr(route.iface, &route.mac) == 0);
 		assert(bpf_map_update_elem(tx_port_map_fd,
 					   &route.iface, &route.iface, 0) == 0);
 		if (rtm_family == AF_INET) {
@@ -207,7 +158,6 @@ static void read_route(struct nlmsghdr *nh, int nll)
 				int metric;
 				__be32 gw;
 			} *prefix_value;
-			struct in_addr dst_addr, gw_addr, mask_addr;
 
 			prefix_key = alloca(sizeof(*prefix_key) + 3);
 			prefix_value = alloca(sizeof(*prefix_value));
@@ -235,17 +185,6 @@ static void read_route(struct nlmsghdr *nh, int nll)
 			for (i = 0; i < 4; i++)
 				prefix_key->data[i] = (route.dst >> i * 8) & 0xff;
 
-			dst_addr.s_addr = route.dst;
-			printf("%-16s", inet_ntoa(dst_addr));
-
-			gw_addr.s_addr = route.gw;
-			printf("%-16s", inet_ntoa(gw_addr));
-
-			mask_addr.s_addr = htonl(~(0xffffffffU >> route.dst_len));
-			printf("%-16s%-7d%s\n", inet_ntoa(mask_addr),
-			       route.metric,
-			       route.iface_name);
-
 			if (bpf_map_lookup_elem(lpm_map_fd, prefix_key,
 						prefix_value) < 0) {
 				for (i = 0; i < 4; i++)
@@ -261,13 +200,6 @@ static void read_route(struct nlmsghdr *nh, int nll)
 							   ) == 0);
 			} else {
 				if (nh->nlmsg_type == RTM_DELROUTE) {
-					printf("deleting entry\n");
-					printf("prefix key=%d.%d.%d.%d/%d",
-					       prefix_key->data[0],
-					       prefix_key->data[1],
-					       prefix_key->data[2],
-					       prefix_key->data[3],
-					       prefix_key->prefixlen);
 					assert(bpf_map_delete_elem(lpm_map_fd,
 								   prefix_key
 								   ) == 0);
@@ -331,14 +263,14 @@ static int get_route_table(int rtm_family)
 
 	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 	if (sock < 0) {
-		printf("open netlink socket: %s\n", strerror(errno));
-		return -1;
+		fprintf(stderr, "open netlink socket: %s\n", strerror(errno));
+		return -errno;
 	}
 	memset(&sa, 0, sizeof(sa));
 	sa.nl_family = AF_NETLINK;
 	if (bind(sock, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
-		printf("bind to netlink: %s\n", strerror(errno));
-		ret = -1;
+		fprintf(stderr, "bind netlink socket: %s\n", strerror(errno));
+		ret = -errno;
 		goto cleanup;
 	}
 	memset(&req, 0, sizeof(req));
@@ -357,15 +289,15 @@ static int get_route_table(int rtm_family)
 	msg.msg_iovlen = 1;
 	ret = sendmsg(sock, &msg, 0);
 	if (ret < 0) {
-		printf("send to netlink: %s\n", strerror(errno));
-		ret = -1;
+		fprintf(stderr, "send to netlink: %s\n", strerror(errno));
+		ret = -errno;
 		goto cleanup;
 	}
 	memset(buf, 0, sizeof(buf));
 	nll = recv_msg(sa, sock);
 	if (nll < 0) {
-		printf("recv from netlink: %s\n", strerror(nll));
-		ret = -1;
+		fprintf(stderr, "recv from netlink: %s\n", strerror(nll));
+		ret = nll;
 		goto cleanup;
 	}
 	nh = (struct nlmsghdr *)buf;
@@ -395,14 +327,7 @@ static void read_arp(struct nlmsghdr *nh, int nll)
 		__be64 mac;
 	} direct_entry;
 
-	if (nh->nlmsg_type == RTM_GETNEIGH)
-		printf("READING arp entry\n");
-	printf("Address         HwAddress\n");
 	for (; NLMSG_OK(nh, nll); nh = NLMSG_NEXT(nh, nll)) {
-		struct in_addr dst_addr;
-		char mac_str[18];
-		int len = 0, i;
-
 		rt_msg = (struct ndmsg *)NLMSG_DATA(nh);
 		rt_attr = (struct rtattr *)RTM_RTA(rt_msg);
 		ndm_family = rt_msg->ndm_family;
@@ -424,13 +349,6 @@ static void read_arp(struct nlmsghdr *nh, int nll)
 		arp_entry.dst = atoi(dsts);
 		arp_entry.mac = atol(mac);
 
-		dst_addr.s_addr = arp_entry.dst;
-		for (i = 0; i < 6; i++)
-			len += snprintf(mac_str + len, 18 - len, "%02llx%s",
-					((arp_entry.mac >> i * 8) & 0xff),
-					i < 5 ? ":" : "");
-		printf("%-16s%s\n", inet_ntoa(dst_addr), mac_str);
-
 		if (ndm_family == AF_INET) {
 			if (bpf_map_lookup_elem(exact_match_map_fd,
 						&arp_entry.dst,
@@ -481,14 +399,14 @@ static int get_arp_table(int rtm_family)
 
 	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 	if (sock < 0) {
-		printf("open netlink socket: %s\n", strerror(errno));
-		return -1;
+		fprintf(stderr, "open netlink socket: %s\n", strerror(errno));
+		return -errno;
 	}
 	memset(&sa, 0, sizeof(sa));
 	sa.nl_family = AF_NETLINK;
 	if (bind(sock, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
-		printf("bind to netlink: %s\n", strerror(errno));
-		ret = -1;
+		fprintf(stderr, "bind netlink socket: %s\n", strerror(errno));
+		ret = -errno;
 		goto cleanup;
 	}
 	memset(&req, 0, sizeof(req));
@@ -506,15 +424,15 @@ static int get_arp_table(int rtm_family)
 	msg.msg_iovlen = 1;
 	ret = sendmsg(sock, &msg, 0);
 	if (ret < 0) {
-		printf("send to netlink: %s\n", strerror(errno));
-		ret = -1;
+		fprintf(stderr, "send to netlink: %s\n", strerror(errno));
+		ret = -errno;
 		goto cleanup;
 	}
 	memset(buf, 0, sizeof(buf));
 	nll = recv_msg(sa, sock);
 	if (nll < 0) {
-		printf("recv from netlink: %s\n", strerror(nll));
-		ret = -1;
+		fprintf(stderr, "recv from netlink: %s\n", strerror(nll));
+		ret = nll;
 		goto cleanup;
 	}
 	nh = (struct nlmsghdr *)buf;
@@ -527,24 +445,17 @@ static int get_arp_table(int rtm_family)
 /* Function to keep track and update changes in route and arp table
  * Give regular statistics of packets forwarded
  */
-static int monitor_route(void)
+static void monitor_route(void *ctx)
 {
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	const unsigned int nr_keys = 256;
 	struct pollfd fds_route, fds_arp;
-	__u64 prev[nr_keys][nr_cpus];
 	struct sockaddr_nl la, lr;
-	__u64 values[nr_cpus];
+	int sock, sock_arp, nll;
 	struct nlmsghdr *nh;
-	int nll, ret = 0;
-	int interval = 5;
-	__u32 key;
-	int i;
 
 	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 	if (sock < 0) {
-		printf("open netlink socket: %s\n", strerror(errno));
-		return -1;
+		fprintf(stderr, "open netlink socket: %s\n", strerror(errno));
+		return;
 	}
 
 	fcntl(sock, F_SETFL, O_NONBLOCK);
@@ -552,17 +463,19 @@ static int monitor_route(void)
 	lr.nl_family = AF_NETLINK;
 	lr.nl_groups = RTMGRP_IPV6_ROUTE | RTMGRP_IPV4_ROUTE | RTMGRP_NOTIFY;
 	if (bind(sock, (struct sockaddr *)&lr, sizeof(lr)) < 0) {
-		printf("bind to netlink: %s\n", strerror(errno));
-		ret = -1;
-		goto cleanup;
+		fprintf(stderr, "bind netlink socket: %s\n", strerror(errno));
+		close(sock);
+		return;
 	}
+
 	fds_route.fd = sock;
 	fds_route.events = POLL_IN;
 
 	sock_arp = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 	if (sock_arp < 0) {
-		printf("open netlink socket: %s\n", strerror(errno));
-		return -1;
+		fprintf(stderr, "open netlink socket: %s\n", strerror(errno));
+		close(sock);
+		return;
 	}
 
 	fcntl(sock_arp, F_SETFL, O_NONBLOCK);
@@ -570,184 +483,191 @@ static int monitor_route(void)
 	la.nl_family = AF_NETLINK;
 	la.nl_groups = RTMGRP_NEIGH | RTMGRP_NOTIFY;
 	if (bind(sock_arp, (struct sockaddr *)&la, sizeof(la)) < 0) {
-		printf("bind to netlink: %s\n", strerror(errno));
-		ret = -1;
+		fprintf(stderr, "bind netlink socket: %s\n", strerror(errno));
 		goto cleanup;
 	}
+
 	fds_arp.fd = sock_arp;
 	fds_arp.events = POLL_IN;
 
-	memset(prev, 0, sizeof(prev));
-	do {
-		signal(SIGINT, close_and_exit);
-		signal(SIGTERM, close_and_exit);
-
-		sleep(interval);
-		for (key = 0; key < nr_keys; key++) {
-			__u64 sum = 0;
-
-			assert(bpf_map_lookup_elem(rxcnt_map_fd,
-						   &key, values) == 0);
-			for (i = 0; i < nr_cpus; i++)
-				sum += (values[i] - prev[key][i]);
-			if (sum)
-				printf("proto %u: %10llu pkt/s\n",
-				       key, sum / interval);
-			memcpy(prev[key], values, sizeof(values));
+	memset(buf, 0, sizeof(buf));
+	if (poll(&fds_route, 1, 3) == POLL_IN) {
+		nll = recv_msg(lr, sock);
+		if (nll < 0) {
+			fprintf(stderr, "recv from netlink: %s\n",
+				strerror(nll));
+			goto cleanup;
 		}
 
-		memset(buf, 0, sizeof(buf));
-		if (poll(&fds_route, 1, 3) == POLL_IN) {
-			nll = recv_msg(lr, sock);
-			if (nll < 0) {
-				printf("recv from netlink: %s\n", strerror(nll));
-				ret = -1;
-				goto cleanup;
-			}
+		nh = (struct nlmsghdr *)buf;
+		read_route(nh, nll);
+	}
 
-			nh = (struct nlmsghdr *)buf;
-			printf("Routing table updated.\n");
-			read_route(nh, nll);
+	memset(buf, 0, sizeof(buf));
+	if (poll(&fds_arp, 1, 3) == POLL_IN) {
+		nll = recv_msg(la, sock_arp);
+		if (nll < 0) {
+			fprintf(stderr, "recv from netlink: %s\n",
+				strerror(nll));
+			goto cleanup;
 		}
-		memset(buf, 0, sizeof(buf));
-		if (poll(&fds_arp, 1, 3) == POLL_IN) {
-			nll = recv_msg(la, sock_arp);
-			if (nll < 0) {
-				printf("recv from netlink: %s\n", strerror(nll));
-				ret = -1;
-				goto cleanup;
-			}
 
-			nh = (struct nlmsghdr *)buf;
-			read_arp(nh, nll);
-		}
+		nh = (struct nlmsghdr *)buf;
+		read_arp(nh, nll);
+	}
 
-	} while (1);
 cleanup:
+	close(sock_arp);
 	close(sock);
-	return ret;
 }
 
-static void usage(const char *prog)
+static void usage(char *argv[], const struct option *long_options,
+		  const char *doc, int mask, bool error,
+		  struct bpf_object *obj)
 {
-	fprintf(stderr,
-		"%s: %s [OPTS] interface name list\n\n"
-		"OPTS:\n"
-		"    -S    use skb-mode\n"
-		"    -F    force loading prog\n",
-		__func__, prog);
+	sample_usage(argv, long_options, doc, mask, error);
 }
 
-int main(int ac, char **argv)
+int main(int argc, char **argv)
 {
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	const char *optstr = "SF";
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	char filename[256];
-	char **ifname_list;
-	int prog_fd, opt;
-	int err, i = 1;
-
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-
-	total_ifindex = ac - 1;
-	ifname_list = (argv + 1);
-
-	while ((opt = getopt(ac, argv, optstr)) != -1) {
+	bool error = true, generic = false, force = false;
+	struct xdp_router_ipv4 *skel;
+	int i, total_ifindex = argc - 1;
+	char **ifname_list = argv + 1;
+	int opt, interval = 5, ret;
+	int longindex = 0;
+
+	skel = xdp_router_ipv4__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_router_ipv4__open: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end;
+	}
+
+	ret = sample_init_pre_load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to sample_init_pre_load: %s\n",
+			strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
+	}
+
+	ret = xdp_router_ipv4__load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to xdp_router_ipv4__load: %s\n",
+			strerror(errno));
+		goto end_destroy;
+	}
+
+	ret = sample_init(skel, mask);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
+	}
+
+	while ((opt = getopt_long(argc, argv, "si:SFvh",
+				  long_options, &longindex)) != -1) {
 		switch (opt) {
+		case 's':
+			mask |= SAMPLE_REDIRECT_MAP_CNT;
+			total_ifindex--;
+			ifname_list++;
+			break;
+		case 'i':
+			interval = strtoul(optarg, NULL, 0);
+			total_ifindex -= 2;
+			ifname_list += 2;
+			break;
 		case 'S':
-			flags |= XDP_FLAGS_SKB_MODE;
+			generic = true;
 			total_ifindex--;
 			ifname_list++;
 			break;
 		case 'F':
-			flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
+			force = true;
+			total_ifindex--;
+			ifname_list++;
+			break;
+		case 'v':
+			sample_switch_mode();
 			total_ifindex--;
 			ifname_list++;
 			break;
+		case 'h':
+			error = false;
 		default:
-			usage(basename(argv[0]));
-			return 1;
+			usage(argv, long_options, __doc__, mask, error, skel->obj);
+			goto end_destroy;
 		}
 	}
 
-	if (!(flags & XDP_FLAGS_SKB_MODE))
-		flags |= XDP_FLAGS_DRV_MODE;
-
-	if (optind == ac) {
-		usage(basename(argv[0]));
-		return 1;
+	ret = EXIT_FAIL_OPTION;
+	if (optind == argc) {
+		usage(argv, long_options, __doc__, mask, true, skel->obj);
+		goto end_destroy;
 	}
 
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj))
-		return 1;
-
-	prog = bpf_object__next_program(obj, NULL);
-	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
-
-	printf("\n******************loading bpf file*********************\n");
-	err = bpf_object__load(obj);
-	if (err) {
-		printf("bpf_object__load(): %s\n", strerror(errno));
-		return 1;
+	lpm_map_fd = bpf_map__fd(skel->maps.lpm_map);
+	if (lpm_map_fd < 0) {
+		fprintf(stderr, "Failed loading lpm_map %s\n",
+			strerror(-lpm_map_fd));
+		goto end_destroy;
+	}
+	arp_table_map_fd = bpf_map__fd(skel->maps.arp_table);
+	if (arp_table_map_fd < 0) {
+		fprintf(stderr, "Failed loading arp_table_map_fd %s\n",
+			strerror(-arp_table_map_fd));
+		goto end_destroy;
 	}
-	prog_fd = bpf_program__fd(prog);
-
-	lpm_map_fd = bpf_object__find_map_fd_by_name(obj, "lpm_map");
-	rxcnt_map_fd = bpf_object__find_map_fd_by_name(obj, "rxcnt");
-	arp_table_map_fd = bpf_object__find_map_fd_by_name(obj, "arp_table");
-	exact_match_map_fd = bpf_object__find_map_fd_by_name(obj,
-							     "exact_match");
-	tx_port_map_fd = bpf_object__find_map_fd_by_name(obj, "tx_port");
-	if (lpm_map_fd < 0 || rxcnt_map_fd < 0 || arp_table_map_fd < 0 ||
-	    exact_match_map_fd < 0 || tx_port_map_fd < 0) {
-		printf("bpf_object__find_map_fd_by_name failed\n");
-		return 1;
+	exact_match_map_fd = bpf_map__fd(skel->maps.exact_match);
+	if (exact_match_map_fd < 0) {
+		fprintf(stderr, "Failed loading exact_match_map_fd %s\n",
+			strerror(-exact_match_map_fd));
+		goto end_destroy;
+	}
+	tx_port_map_fd = bpf_map__fd(skel->maps.tx_port);
+	if (tx_port_map_fd < 0) {
+		fprintf(stderr, "Failed loading tx_port_map_fd %s\n",
+			strerror(-tx_port_map_fd));
+		goto end_destroy;
 	}
 
-	ifindex_list = (int *)calloc(total_ifindex, sizeof(int *));
+	ret = EXIT_FAIL_XDP;
 	for (i = 0; i < total_ifindex; i++) {
-		ifindex_list[i] = if_nametoindex(ifname_list[i]);
-		if (!ifindex_list[i]) {
-			printf("Couldn't translate interface name: %s",
-			       strerror(errno));
-			return 1;
+		int index = if_nametoindex(ifname_list[i]);
+
+		if (!index) {
+			fprintf(stderr, "Interface %s not found %s\n",
+				ifname_list[i], strerror(-tx_port_map_fd));
+			goto end_destroy;
 		}
+		if (sample_install_xdp(skel->progs.xdp_router_ipv4_prog,
+				       index, generic, force) < 0)
+			goto end_destroy;
 	}
-	prog_id_list = (__u32 *)calloc(total_ifindex, sizeof(__u32 *));
-	for (i = 0; i < total_ifindex; i++) {
-		if (bpf_xdp_attach(ifindex_list[i], prog_fd, flags, NULL) < 0) {
-			printf("link set xdp fd failed\n");
-			int recovery_index = i;
 
-			for (i = 0; i < recovery_index; i++)
-				bpf_xdp_detach(ifindex_list[i], flags, NULL);
+	if (get_route_table(AF_INET) < 0) {
+		fprintf(stderr, "Failed reading routing table\n");
+		goto end_destroy;
+	}
 
-			return 1;
-		}
-		err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
-		if (err) {
-			printf("can't get prog info - %s\n", strerror(errno));
-			return err;
-		}
-		prog_id_list[i] = info.id;
-		memset(&info, 0, sizeof(info));
-		printf("Attached to %d\n", ifindex_list[i]);
+	if (get_arp_table(AF_INET) < 0) {
+		fprintf(stderr, "Failed reading arptable\n");
+		goto end_destroy;
 	}
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
-
-	printf("\n*******************ROUTE TABLE*************************\n");
-	get_route_table(AF_INET);
-	printf("\n*******************ARP TABLE***************************\n");
-	get_arp_table(AF_INET);
-	if (monitor_route() < 0) {
-		printf("Error in receiving route update");
-		return 1;
+
+	ret = sample_run(interval, monitor_route, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
 	}
+	ret = EXIT_OK;
 
-	return 0;
+end_destroy:
+	xdp_router_ipv4__destroy(skel);
+end:
+	sample_exit(ret);
 }
-- 
2.35.1

