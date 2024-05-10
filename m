Return-Path: <bpf+bounces-29478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD7F8C2638
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 16:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEEA1C222B8
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5B16D4C4;
	Fri, 10 May 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTBqSdMU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC312C80F;
	Fri, 10 May 2024 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349717; cv=none; b=vAXzcSSPXj5qfdF4BjJzivI+MnaK3/CdhsAQm/WWBf0qsKV3oL55qF8h+xI8PMalZxmuQfg88vpXOrGvzlBpsYNhYfADUeByIiqBGlICtUNNRZ0sLLpZMbOcI6mCrg7uXrQgOkf/Leu8/Hq8ibm6+4ZF8ISIfRPq4gKh/Adhtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349717; c=relaxed/simple;
	bh=v0uuuhUE2wqCSiEzBC0tUksx8Sxag17ovvMsswnSdSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsc2+9OtIvF6YdC2b6pVmMe59CVMZsagqmsmZBnu7MZuiXvWlIPrBGAHEoLiLcpt/4eupn80H03yMyzdtIeK99xzPcROmn3cDNmnQe6e2F0gPYPVnpBtHEw6hAauWGlvUGDhh5yn+XONgJJ6SK+va0DgIPWe46mS1YWX2Qm+bHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTBqSdMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F4AC113CC;
	Fri, 10 May 2024 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349717;
	bh=v0uuuhUE2wqCSiEzBC0tUksx8Sxag17ovvMsswnSdSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTBqSdMUoByfCJWB1pA5d5Q7JetvqxYSqvkgQVnSTG/vFPYK3Mbe/Xm5pJBB13mH9
	 0x3qxlC+dYFmcKnu+bkSoBPREk6QKmdSERihVvveBoWK0QPJki9/OJwHrSsHJXyY+k
	 WlDrGu44lOW9W6bqenuc/5bphlb5tohJK4jkkfIiGKatmua1Igt4gsjuwUxvONLg1I
	 JDuqe30xADqj62PuzwTh6wQu5fxacmRqaGx0oP2J3YRmbPZxWoMmj7LUB7MssgtbAt
	 p4/4Qx9VnXmssImYgN5Ft4yXLxU46JFGgg1FWeoRZuunbNFXBpfLCGVabZ9xi22zaD
	 pc5nl+F2A3O3A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	lorenzo.bianconi@redhat.com,
	toke@redhat.com,
	fw@strlen.de,
	hawk@kernel.org,
	horms@kernel.org,
	donhunte@redhat.com
Subject: [RFC bpf-next v1 3/4] samples/bpf: Add bpf sample to offload flowtable traffic to xdp
Date: Fri, 10 May 2024 16:01:26 +0200
Message-ID: <958a7051a2bd76026fc2a227c5f02cbee26c6a2e.1715348200.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715348200.git.lorenzo@kernel.org>
References: <cover.1715348200.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce xdp_flowtable_offload bpf sample to offload sw flowtable logic
in xdp layer if hw flowtable is not available or does not support a
specific kind of traffic.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 samples/bpf/Makefile                     |   7 +-
 samples/bpf/xdp_flowtable_offload.bpf.c  | 592 +++++++++++++++++++++++
 samples/bpf/xdp_flowtable_offload_user.c | 128 +++++
 3 files changed, 726 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
 create mode 100644 samples/bpf/xdp_flowtable_offload_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9aa027b144df6..a3d089ca224d5 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -46,6 +46,7 @@ tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += xdp_flowtable_offload
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -98,6 +99,7 @@ ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
+xdp_flowtable_offload-objs := xdp_flowtable_offload_user.o $(XDP_SAMPLE)
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -306,6 +308,7 @@ $(obj)/$(TRACE_HELPERS) $(obj)/$(CGROUP_HELPERS) $(obj)/$(XDP_SAMPLE): | libbpf_
 .PHONY: libbpf_hdrs
 
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
+$(obj)/xdp_flowtable_offload_user.o: $(obj)/xdp_flowtable_offload.skel.h
 
 $(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
@@ -361,6 +364,7 @@ endef
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 
 $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
+$(obj)/xdp_flowtable_offload.bpf.o: $(obj)/xdp_sample.bpf.o
 
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
@@ -370,10 +374,11 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_router_ipv4.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h xdp_flowtable_offload.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
+xdp_flowtable_offload.skel.h-deps := xdp_flowtable_offload.bpf.o xdp_sample.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/bpf/xdp_flowtable_offload.bpf.c b/samples/bpf/xdp_flowtable_offload.bpf.c
new file mode 100644
index 0000000000000..728c859feefae
--- /dev/null
+++ b/samples/bpf/xdp_flowtable_offload.bpf.c
@@ -0,0 +1,592 @@
+/* Copyright (c) 2024 Lorenzo Bianconi <lorenzo@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+
+#include "vmlinux.h"
+#include "xdp_sample.bpf.h"
+#include "xdp_sample_shared.h"
+
+#define MAX_ERRNO	4095
+#define IS_ERR_VALUE(x)	(unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO
+#define BIT(x)		(1 << (x))
+
+#define ETH_P_IP	0x0800
+#define IP_MF		0x2000	/* "More Fragments" */
+#define IP_OFFSET	0x1fff	/* "Fragment Offset" */
+
+#define IPV6_FLOWINFO_MASK	__cpu_to_be32(0x0fffffff)
+
+#define CSUM_MANGLED_0		((__sum16)0xffff)
+
+struct flow_offload_tuple_rhash *
+bpf_xdp_flow_offload_lookup(struct xdp_md *,
+			    struct bpf_fib_lookup *, u32) __ksym;
+
+/* IP checksum utility routines */
+
+static __always_inline __u32 csum_add(__u32 csum, __u32 addend)
+{
+	__u32 res = csum + addend;
+
+	return res + (res < addend);
+}
+
+static __always_inline __u16 csum_fold(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+	return ~csum;
+}
+
+static __always_inline __u16 csum_replace4(__u32 csum, __u32 from, __u32 to)
+{
+	__u32 tmp = csum_add(~csum, ~from);
+
+	return csum_fold(csum_add(tmp, to));
+}
+
+static __always_inline __u16 csum_replace16(__u32 csum, __u32 *from, __u32 *to)
+{
+	__u32 diff[] = {
+		~from[0], ~from[1], ~from[2], ~from[3],
+		to[0], to[1], to[2], to[3],
+	};
+
+	csum = bpf_csum_diff(0, 0, diff, sizeof(diff), ~csum);
+	return csum_fold(csum);
+}
+
+/* IP-TCP header utility routines */
+
+static __always_inline void ip_decrease_ttl(struct iphdr *iph)
+{
+	__u32 check = (__u32)iph->check;
+
+	check += (__u32)bpf_htons(0x0100);
+	iph->check = (__sum16)(check + (check >= 0xffff));
+	iph->ttl--;
+}
+
+static __always_inline bool
+xdp_flowtable_offload_check_iphdr(struct iphdr *iph)
+{
+	/* ip fragmented traffic */
+	if (iph->frag_off & bpf_htons(IP_MF | IP_OFFSET))
+		return false;
+
+	/* ip options */
+	if (iph->ihl * 4 != sizeof(*iph))
+		return false;
+
+	if (iph->ttl <= 1)
+		return false;
+
+	return true;
+}
+
+static __always_inline bool
+xdp_flowtable_offload_check_tcp_state(void *ports, void *data_end, u8 proto)
+{
+	if (proto == IPPROTO_TCP) {
+		struct tcphdr *tcph = ports;
+
+		if (tcph + 1 > data_end)
+			return false;
+
+		if (tcph->fin || tcph->rst)
+			return false;
+	}
+
+	return true;
+}
+
+/* IP nat utility routines */
+
+static __always_inline void
+xdp_flowtable_offload_nat_port(struct flow_ports *ports, void *data_end,
+			       u8 proto, __be16 port, __be16 nat_port)
+{
+	switch (proto) {
+	case IPPROTO_TCP: {
+		struct tcphdr *tcph = (struct tcphdr *)ports;
+
+		if (tcph + 1 > data_end)
+			break;
+
+		tcph->check = csum_replace4((__u32)tcph->check, (__u32)port,
+					    (__u32)nat_port);
+		break;
+	}
+	case IPPROTO_UDP: {
+		struct udphdr *udph = (struct udphdr *)ports;
+
+		if (udph + 1 > data_end)
+			break;
+
+		if (!udph->check)
+			break;
+
+		udph->check = csum_replace4((__u32)udph->check, (__u32)port,
+					    (__u32)nat_port);
+		if (!udph->check)
+			udph->check = CSUM_MANGLED_0;
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static __always_inline void
+xdp_flowtable_offload_snat_port(const struct flow_offload *flow,
+				struct flow_ports *ports, void *data_end,
+				u8 proto, enum flow_offload_tuple_dir dir)
+{
+	__be16 port, nat_port;
+
+	if (ports + 1 > data_end)
+		return;
+
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		port = ports->source;
+		bpf_core_read(&nat_port, bpf_core_type_size(nat_port),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst_port);
+		ports->source = nat_port;
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		port = ports->dest;
+		bpf_core_read(&nat_port, bpf_core_type_size(nat_port),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.src_port);
+		ports->dest = nat_port;
+		break;
+	default:
+		return;
+	}
+
+	xdp_flowtable_offload_nat_port(ports, data_end, proto, port, nat_port);
+}
+
+static __always_inline void
+xdp_flowtable_offload_dnat_port(const struct flow_offload *flow,
+				struct flow_ports *ports, void *data_end,
+				u8 proto, enum flow_offload_tuple_dir dir)
+{
+	__be16 port, nat_port;
+
+	if (ports + 1 > data_end)
+		return;
+
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		port = ports->dest;
+		bpf_core_read(&nat_port, bpf_core_type_size(nat_port),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.src_port);
+		ports->dest = nat_port;
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		port = ports->source;
+		bpf_core_read(&nat_port, bpf_core_type_size(nat_port),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst_port);
+		ports->source = nat_port;
+		break;
+	default:
+		return;
+	}
+
+	xdp_flowtable_offload_nat_port(ports, data_end, proto, port, nat_port);
+}
+
+static __always_inline void
+xdp_flowtable_offload_ip_l4(struct iphdr *iph, void *data_end,
+			    __be32 addr, __be32 nat_addr)
+{
+	switch (iph->protocol) {
+	case IPPROTO_TCP: {
+		struct tcphdr *tcph = (struct tcphdr *)(iph + 1);
+
+		if (tcph + 1 > data_end)
+			break;
+
+		tcph->check = csum_replace4((__u32)tcph->check, addr,
+					    nat_addr);
+		break;
+	}
+	case IPPROTO_UDP: {
+		struct udphdr *udph = (struct udphdr *)(iph + 1);
+
+		if (udph + 1 > data_end)
+			break;
+
+		if (!udph->check)
+			break;
+
+		udph->check = csum_replace4((__u32)udph->check, addr,
+					    nat_addr);
+		if (!udph->check)
+			udph->check = CSUM_MANGLED_0;
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static __always_inline void
+xdp_flowtable_offload_snat_ip(const struct flow_offload *flow,
+			      struct iphdr *iph, void *data_end,
+			      enum flow_offload_tuple_dir dir)
+{
+	__be32 addr, nat_addr;
+
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		addr = iph->saddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst_v4.s_addr);
+		iph->saddr = nat_addr;
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		addr = iph->daddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.src_v4.s_addr);
+		iph->daddr = nat_addr;
+		break;
+	default:
+		return;
+	}
+	iph->check = csum_replace4((__u32)iph->check, addr, nat_addr);
+
+	xdp_flowtable_offload_ip_l4(iph, data_end, addr, nat_addr);
+}
+
+static __always_inline void
+xdp_flowtable_offload_get_dnat_ip(const struct flow_offload *flow,
+				  enum flow_offload_tuple_dir dir,
+				  __be32 *addr)
+{
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		bpf_core_read(addr, sizeof(*addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.src_v4.s_addr);
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		bpf_core_read(addr, sizeof(*addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst_v4.s_addr);
+		break;
+	}
+}
+
+static __always_inline void
+xdp_flowtable_offload_dnat_ip(const struct flow_offload *flow,
+			      struct iphdr *iph, void *data_end,
+			      enum flow_offload_tuple_dir dir)
+{
+	__be32 addr, nat_addr;
+
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		addr = iph->daddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.src_v4.s_addr);
+		iph->daddr = nat_addr;
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		addr = iph->saddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst_v4.s_addr);
+		iph->saddr = nat_addr;
+		break;
+	default:
+		return;
+	}
+	iph->check = csum_replace4((__u32)iph->check, addr, nat_addr);
+
+	xdp_flowtable_offload_ip_l4(iph, data_end, addr, nat_addr);
+}
+
+static __always_inline void
+xdp_flowtable_offload_ipv6_l4(struct ipv6hdr *ip6h, void *data_end,
+			      struct in6_addr *addr, struct in6_addr *nat_addr)
+{
+	switch (ip6h->nexthdr) {
+	case IPPROTO_TCP: {
+		struct tcphdr *tcph = (struct tcphdr *)(ip6h + 1);
+
+		if (tcph + 1 > data_end)
+			break;
+
+		tcph->check = csum_replace16((__u32)tcph->check,
+					     addr->in6_u.u6_addr32,
+					     nat_addr->in6_u.u6_addr32);
+		break;
+	}
+	case IPPROTO_UDP: {
+		struct udphdr *udph = (struct udphdr *)(ip6h + 1);
+
+		if (udph + 1 > data_end)
+			break;
+
+		if (!udph->check)
+			break;
+
+		udph->check = csum_replace16((__u32)udph->check,
+					     addr->in6_u.u6_addr32,
+					     nat_addr->in6_u.u6_addr32);
+		if (!udph->check)
+			udph->check = CSUM_MANGLED_0;
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static __always_inline void
+xdp_flowtable_offload_snat_ipv6(const struct flow_offload *flow,
+				struct ipv6hdr *ip6h, void *data_end,
+				enum flow_offload_tuple_dir dir)
+{
+	struct in6_addr addr, nat_addr;
+
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		addr = ip6h->saddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst_v6);
+		ip6h->saddr = nat_addr;
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		addr = ip6h->daddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.src_v6);
+		ip6h->daddr = nat_addr;
+		break;
+	default:
+		return;
+	}
+
+	xdp_flowtable_offload_ipv6_l4(ip6h, data_end, &addr, &nat_addr);
+}
+
+static __always_inline void
+xdp_flowtable_offload_get_dnat_ipv6(const struct flow_offload *flow,
+				    enum flow_offload_tuple_dir dir,
+				    struct in6_addr *addr)
+{
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		bpf_core_read(addr, sizeof(*addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.src_v6);
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		bpf_core_read(addr, sizeof(*addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst_v6);
+		break;
+	}
+}
+
+static __always_inline void
+xdp_flowtable_offload_dnat_ipv6(const struct flow_offload *flow,
+				struct ipv6hdr *ip6h, void *data_end,
+				enum flow_offload_tuple_dir dir)
+{
+	struct in6_addr addr, nat_addr;
+
+	switch (dir) {
+	case FLOW_OFFLOAD_DIR_ORIGINAL:
+		addr = ip6h->daddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.src_v6);
+		ip6h->daddr = nat_addr;
+		break;
+	case FLOW_OFFLOAD_DIR_REPLY:
+		addr = ip6h->saddr;
+		bpf_core_read(&nat_addr, bpf_core_type_size(nat_addr),
+			      &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst_v6);
+		ip6h->saddr = nat_addr;
+		break;
+	default:
+		return;
+	}
+
+	xdp_flowtable_offload_ipv6_l4(ip6h, data_end, &addr, &nat_addr);
+}
+
+static __always_inline void
+xdp_flowtable_offload_forward_ip(const struct flow_offload *flow,
+				 void *data, void *data_end,
+				 struct flow_ports *ports,
+				 enum flow_offload_tuple_dir dir,
+				 unsigned long flags)
+{
+	struct iphdr *iph = data + sizeof(struct ethhdr);
+
+	if (iph + 1 > data_end)
+		return;
+
+	if (flags & BIT(NF_FLOW_SNAT)) {
+		xdp_flowtable_offload_snat_port(flow, ports, data_end,
+						iph->protocol, dir);
+		xdp_flowtable_offload_snat_ip(flow, iph, data_end, dir);
+	}
+	if (flags & BIT(NF_FLOW_DNAT)) {
+		xdp_flowtable_offload_dnat_port(flow, ports, data_end,
+						iph->protocol, dir);
+		xdp_flowtable_offload_dnat_ip(flow, iph, data_end, dir);
+	}
+
+	ip_decrease_ttl(iph);
+}
+
+static __always_inline void
+xdp_flowtable_offload_forward_ipv6(const struct flow_offload *flow,
+				   void *data, void *data_end,
+				   struct flow_ports *ports,
+				   enum flow_offload_tuple_dir dir,
+				   unsigned long flags)
+{
+	struct ipv6hdr *ip6h = data + sizeof(struct ethhdr);
+
+	if (ip6h + 1 > data_end)
+		return;
+
+	if (flags & BIT(NF_FLOW_SNAT)) {
+		xdp_flowtable_offload_snat_port(flow, ports, data_end,
+						ip6h->nexthdr, dir);
+		xdp_flowtable_offload_snat_ipv6(flow, ip6h, data_end, dir);
+	}
+	if (flags & BIT(NF_FLOW_DNAT)) {
+		xdp_flowtable_offload_dnat_port(flow, ports, data_end,
+						ip6h->nexthdr, dir);
+		xdp_flowtable_offload_dnat_ipv6(flow, ip6h, data_end, dir);
+	}
+
+	ip6h->hop_limit--;
+}
+
+SEC("xdp")
+int xdp_flowtable_offload(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	struct flow_offload_tuple_rhash *tuplehash;
+	struct bpf_fib_lookup tuple = {
+		.ifindex = ctx->ingress_ifindex,
+	};
+	void *data = (void *)(long)ctx->data;
+	enum flow_offload_tuple_dir dir;
+	struct ethhdr *eth = data;
+	struct flow_offload *flow;
+	struct flow_ports *ports;
+	unsigned long flags;
+	int iifindex;
+
+	if (eth + 1 > data_end)
+		return XDP_PASS;
+
+	switch (eth->h_proto) {
+	case bpf_htons(ETH_P_IP): {
+		struct iphdr *iph = data + sizeof(*eth);
+
+		ports = (struct flow_ports *)(iph + 1);
+		if (ports + 1 > data_end)
+			return XDP_PASS;
+
+		/* sanity check on ip header */
+		if (!xdp_flowtable_offload_check_iphdr(iph))
+			return XDP_PASS;
+
+		if (!xdp_flowtable_offload_check_tcp_state(ports, data_end,
+							   iph->protocol))
+			return XDP_PASS;
+
+		tuple.family		= AF_INET;
+		tuple.tos		= iph->tos;
+		tuple.l4_protocol	= iph->protocol;
+		tuple.tot_len		= bpf_ntohs(iph->tot_len);
+		tuple.ipv4_src		= iph->saddr;
+		tuple.ipv4_dst		= iph->daddr;
+		tuple.sport		= ports->source;
+		tuple.dport		= ports->dest;
+		break;
+	}
+	case bpf_htons(ETH_P_IPV6): {
+		struct in6_addr *src = (struct in6_addr *)tuple.ipv6_src;
+		struct in6_addr *dst = (struct in6_addr *)tuple.ipv6_dst;
+		struct ipv6hdr *ip6h = data + sizeof(*eth);
+
+		ports = (struct flow_ports *)(ip6h + 1);
+		if (ports + 1 > data_end)
+			return XDP_PASS;
+
+		if (ip6h->hop_limit <= 1)
+			return XDP_PASS;
+
+		if (!xdp_flowtable_offload_check_tcp_state(ports, data_end,
+							   ip6h->nexthdr))
+			return XDP_PASS;
+
+		tuple.family		= AF_INET6;
+		tuple.l4_protocol	= ip6h->nexthdr;
+		tuple.tot_len		= bpf_ntohs(ip6h->payload_len);
+		*src			= ip6h->saddr;
+		*dst			= ip6h->daddr;
+		tuple.sport		= ports->source;
+		tuple.dport		= ports->dest;
+		break;
+	}
+	default:
+		return XDP_PASS;
+	}
+
+	tuplehash = bpf_xdp_flow_offload_lookup(ctx, &tuple, sizeof(tuple));
+	if (IS_ERR_VALUE(tuplehash))
+		return XDP_PASS;
+
+	dir = tuplehash->tuple.dir;
+	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
+	if (bpf_core_read(&flags, sizeof(flags), &flow->flags))
+		return XDP_PASS;
+
+	switch (tuplehash->tuple.xmit_type) {
+	case FLOW_OFFLOAD_XMIT_NEIGH:
+		/* update the destination address in case of dnatting before
+		 * performing the route lookup
+		 */
+		if (tuple.family == AF_INET6)
+			xdp_flowtable_offload_get_dnat_ipv6(flow, dir,
+					(struct in6_addr *)&tuple.ipv6_dst);
+		else
+			xdp_flowtable_offload_get_dnat_ip(flow, dir, &tuple.ipv4_src);
+
+		if (bpf_fib_lookup(ctx, &tuple, sizeof(tuple), 0))
+			return XDP_PASS;
+
+		if (tuple.family == AF_INET6)
+			xdp_flowtable_offload_forward_ipv6(flow, data, data_end,
+							   ports, dir, flags);
+		else
+			xdp_flowtable_offload_forward_ip(flow, data, data_end,
+							 ports, dir, flags);
+
+		__builtin_memcpy(eth->h_dest, tuple.dmac, ETH_ALEN);
+		__builtin_memcpy(eth->h_source, tuple.smac, ETH_ALEN);
+		iifindex = tuple.ifindex;
+		break;
+	case FLOW_OFFLOAD_XMIT_DIRECT:
+	default:
+		return XDP_PASS;
+	}
+
+	return bpf_redirect(iifindex, 0);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_flowtable_offload_user.c b/samples/bpf/xdp_flowtable_offload_user.c
new file mode 100644
index 0000000000000..179b1f34b48fd
--- /dev/null
+++ b/samples/bpf/xdp_flowtable_offload_user.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+static const char *__doc__ =
+"XDP flowtable integration example\n"
+"Usage: xdp_flowtable_offload <IFINDEX|IFNAME>\n";
+
+#include <linux/bpf.h>
+#include <linux/if_link.h>
+#include <assert.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <net/if.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <getopt.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include "bpf_util.h"
+#include "xdp_sample_user.h"
+#include "xdp_flowtable_offload.skel.h"
+
+static int mask = SAMPLE_RX_CNT | SAMPLE_EXCEPTION_CNT;
+
+DEFINE_SAMPLE_INIT(xdp_flowtable_offload);
+
+static const struct option long_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ "generic", no_argument, NULL, 'g' },
+	{}
+};
+
+int main(int argc, char **argv)
+{
+	struct xdp_flowtable_offload *skel;
+	int ret = EXIT_FAIL_OPTION;
+	char ifname[IF_NAMESIZE];
+	bool generic = false;
+	int ifindex;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "hg",
+				  long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'g':
+			generic = true;
+			break;
+		case 'h':
+		default:
+			sample_usage(argv, long_options, __doc__, mask, false);
+			return ret;
+		}
+	}
+
+	if (argc <= optind) {
+		sample_usage(argv, long_options, __doc__, mask, true);
+		goto end;
+	}
+
+	ifindex = if_nametoindex(argv[optind]);
+	if (!ifindex)
+		ifindex = strtoul(argv[optind], NULL, 0);
+
+	if (!ifindex) {
+		fprintf(stderr, "Bad interface index or name\n");
+		sample_usage(argv, long_options, __doc__, mask, true);
+		goto end;
+	}
+
+	skel = xdp_flowtable_offload__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_flowtable_offload__open: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end;
+	}
+
+	ret = sample_init_pre_load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
+	}
+
+	ret = xdp_flowtable_offload__load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to xdp_flowtable_offload__load: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
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
+	if (sample_install_xdp(skel->progs.xdp_flowtable_offload,
+			       ifindex, generic, false) < 0) {
+		ret = EXIT_FAIL_XDP;
+		goto end_destroy;
+	}
+
+	ret = EXIT_FAIL;
+	if (!if_indextoname(ifindex, ifname)) {
+		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", ifindex,
+			strerror(errno));
+		goto end_destroy;
+	}
+
+	ret = sample_run(2, NULL, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
+	}
+	ret = EXIT_OK;
+end_destroy:
+	xdp_flowtable_offload__destroy(skel);
+end:
+	sample_exit(ret);
+}
-- 
2.45.0


