Return-Path: <bpf+bounces-29479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEA28C263B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E471C22321
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F216F852;
	Fri, 10 May 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3541Fyv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4112CD8A;
	Fri, 10 May 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349721; cv=none; b=VIz54QpYtUTJItew9omEnU/xpLLlNpBymPC5Lq/Wb0CIigS3+MEAhZnpm8KDj2/MQSMTXOA81E58j8jVbjLSmpsfaIQTDmcCci08bE6TQQEeFFzo4UoyRBXoV18/ZKDF2o4CSBTO3YiZ3yavdCPoXmFhrQtKVHqKEas25fDA7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349721; c=relaxed/simple;
	bh=Gsj0JF1o1XJm4oCJPzizUQmX32k4Fi0e9TMvLivDsr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqxYq3IpfEFzZ8ryCzn2dRnUGuOHN+oKhriGAEdPZxd5/Yr9FszxnbxjbcMl9SlfRufeGWaMKD8/BfJZaH8AsGh68c7bOlhqMNe7fKruVnadSRp5JwHKtjw+kebrERPsQo7Nm57IYfnjpuf68Cn4KbM2tOFgKQWkE8KOShFcDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3541Fyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5477C113CC;
	Fri, 10 May 2024 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349721;
	bh=Gsj0JF1o1XJm4oCJPzizUQmX32k4Fi0e9TMvLivDsr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3541Fyvk6WCPY+WrM1g+LH6ApH/3JRNEzzU2cmpRt3Z5MiX1BVZLcHTcdySBvWB0
	 Wm1F4kqC7YhfQld7dG7pDFgpF0LtkK5sgU8edDVN7Ljvd48zA7KnjZ9RgYVRyJP/xU
	 5GIdx8rX0274ld6UKSi5jpfyz9hZ0p7/isbv0Q1Gt0va5FYXehvzCQS3Y3//ij7Y8g
	 8ykbhIw+Iudpz2NqAaC5OitHVLkXlInGHNFSjq2KPXW9/w+yX/w38upr6HXfnjghzN
	 i3V8GSlXHWnrwdTvUr+kZ09wvc13TGOQboKcZ1R7IZsJ5u3k1msUjvlbVryvMhDwBK
	 7k4WQqyUaIoZw==
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
Subject: [RFC bpf-next v1 4/4] selftests/bpf: Add selftest for bpf_xdp_flow_offload_lookup kfunc
Date: Fri, 10 May 2024 16:01:27 +0200
Message-ID: <5bcb91023522707a079475c74befdde5572b6f34.1715348200.git.lorenzo@kernel.org>
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

Introduce e2e selftest for bpf_xdp_flow_offload_lookup kfunc through
xdp_flowtable utility.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  10 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/progs/xdp_flowtable.c       | 142 ++++++++++++++++++
 .../selftests/bpf/test_xdp_flowtable.sh       | 112 ++++++++++++++
 tools/testing/selftests/bpf/xdp_flowtable.c   | 142 ++++++++++++++++++
 5 files changed, 408 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c
 create mode 100755 tools/testing/selftests/bpf/test_xdp_flowtable.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_flowtable.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 135023a357b3b..a5d4cd7d92c0a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -133,7 +133,8 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool_metadata.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
-	test_xdp_features.sh
+	test_xdp_features.sh \
+	test_xdp_flowtable.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
@@ -144,7 +145,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko xdp_flowtable
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -477,6 +478,7 @@ test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
 xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
+xdp_flowtable.skel.h-deps := xdp_flowtable.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
@@ -711,6 +713,10 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
+$(OUTPUT)/xdp_flowtable: xdp_flowtable.c $(OUTPUT)/xdp_flowtable.skel.h | $(OUTPUT)
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
+
 # Make sure we are able to include and link libbpf against c++.
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index eeabd798bc3ae..1a9aea01145f7 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -82,6 +82,10 @@ CONFIG_NF_CONNTRACK=y
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
+CONFIG_NF_TABLES=y
+CONFIG_NETFILTER_INGRESS=y
+CONFIG_NF_FLOW_TABLE=y
+CONFIG_NF_FLOW_TABLE_INET=y
 CONFIG_NF_NAT=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
new file mode 100644
index 0000000000000..cf725699e21d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define MAX_ERRNO	4095
+#define IS_ERR_VALUE(x)	(unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO
+
+#define ETH_P_IP	0x0800
+#define ETH_P_IPV6	0x86dd
+#define IP_MF		0x2000	/* "More Fragments" */
+#define IP_OFFSET	0x1fff	/* "Fragment Offset" */
+#define AF_INET		2
+#define AF_INET6	10
+
+struct flow_offload_tuple_rhash *
+bpf_xdp_flow_offload_lookup(struct xdp_md *,
+			    struct bpf_fib_lookup *, __u32) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1);
+} stats SEC(".maps");
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
+SEC("xdp.frags")
+int xdp_flowtable_do_lookup(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	struct flow_offload_tuple_rhash *tuplehash;
+	struct bpf_fib_lookup tuple = {
+		.ifindex = ctx->ingress_ifindex,
+	};
+	void *data = (void *)(long)ctx->data;
+	struct ethhdr *eth = data;
+	struct flow_ports *ports;
+	__u32 *val, key = 0;
+
+	if (eth + 1 > data_end)
+		return XDP_DROP;
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
+	val = bpf_map_lookup_elem(&stats, &key);
+	if (val)
+		__sync_add_and_fetch(val, 1);
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_xdp_flowtable.sh b/tools/testing/selftests/bpf/test_xdp_flowtable.sh
new file mode 100755
index 0000000000000..1a8a40aebbdf1
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_xdp_flowtable.sh
@@ -0,0 +1,112 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+readonly NS0="ns0-$(mktemp -u XXXXXX)"
+readonly NS1="ns1-$(mktemp -u XXXXXX)"
+readonly infile="$(mktemp)"
+readonly outfile="$(mktemp)"
+
+xdp_flowtable_pid=""
+ret=1
+
+setup_flowtable() {
+nft -f /dev/stdin <<EOF
+table inet nat {
+	chain postrouting {
+		type nat hook postrouting priority filter; policy accept;
+		meta oif v10 masquerade
+	}
+}
+table inet filter {
+	flowtable ft {
+		hook ingress priority filter
+		devices = { v01, v10 }
+	}
+	chain forward {
+		type filter hook forward priority filter
+		meta l4proto { tcp, udp } flow add @ft
+	}
+}
+EOF
+}
+
+setup() {
+	sysctl -w net.ipv4.ip_forward=1
+	sysctl -w net.ipv6.conf.all.forwarding=1
+
+	ip netns add ${NS0}
+	ip netns add ${NS1}
+
+	ip link add v01 type veth peer name v00 netns ${NS0}
+	ip link add v10 type veth peer name v11 netns ${NS1}
+
+	ip -n ${NS0} addr add 192.168.0.1/24 dev v00
+	ip -6 -n ${NS0} addr add 2001:db8::1/64 dev v00
+	ip -n ${NS0} link set dev v00 up
+	ip -n ${NS0} route add default via 192.168.0.2
+	ip -6 -n ${NS0} route add default via 2001:db8::2
+
+	ip addr add 192.168.0.2/24 dev v01
+	ip -6 addr add 2001:db8::2/64 dev v01
+	ip link set dev v01 up
+	ip addr add 192.168.1.1/24 dev v10
+	ip -6 addr add 2001:db8:1::1/64 dev v10
+	ip link set dev v10 up
+
+	ip -n ${NS1} addr add 192.168.1.2/24 dev v11
+	ip -6 -n ${NS1} addr add 2001:db8:1::2/64 dev v11
+	ip -n ${NS1} link set dev v11 up
+	ip -n ${NS1} route add default via 192.168.1.1
+	ip -6 -n ${NS1} route add default via 2001:db8:1::1
+
+	# Load XDP program
+	./xdp_flowtable v01 &
+	xdp_flowtable_pid=$!
+
+	setup_flowtable
+
+	dd if=/dev/urandom of="${infile}" bs=8192 count=16 status=none
+}
+
+wait_for_nc_server() {
+	while sleep 1; do
+		ip netns exec ${NS1} ss -nutlp | grep -q ":$1"
+		[ $? -eq 0 ] && break
+	done
+}
+
+cleanup() {
+	{
+		rm -f "${infile}" "${outfile}"
+
+		nft delete table inet filter
+		nft delete table inet nat
+
+		ip link del v01
+		ip link del v10
+
+		ip netns del ${NS0}
+		ip netns del ${NS1}
+	} >/dev/null 2>/dev/null
+}
+
+test_xdp_flowtable_lookup() {
+	## Run IPv4 test
+	ip netns exec ${NS1} nc -4 --no-shutdown -l 8084 > ${outfile} &
+	wait_for_nc_server 8084
+	ip netns exec ${NS0} timeout 2 nc -4 192.168.1.2 8084 < ${infile}
+
+	## Run IPv6 test
+	ip netns exec ${NS1} nc -6 --no-shutdown -l 8086 > ${outfile} &
+	wait_for_nc_server 8086
+	ip netns exec ${NS0} timeout 2 nc -6 2001:db8:1::2 8086 < ${infile}
+
+	wait $xdp_flowtable_pid && ret=0
+}
+
+trap cleanup 0 2 3 6 9
+setup
+
+test_xdp_flowtable_lookup
+
+exit $ret
diff --git a/tools/testing/selftests/bpf/xdp_flowtable.c b/tools/testing/selftests/bpf/xdp_flowtable.c
new file mode 100644
index 0000000000000..dea24deda7359
--- /dev/null
+++ b/tools/testing/selftests/bpf/xdp_flowtable.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <uapi/linux/bpf.h>
+#include <linux/if_link.h>
+#include <net/if.h>
+#include <unistd.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <signal.h>
+#include <argp.h>
+
+#include "xdp_flowtable.skel.h"
+
+#define MAX_ITERATION	10
+
+static volatile bool exiting, verbosity;
+static char ifname[IF_NAMESIZE];
+static int ifindex = -ENODEV;
+const char *argp_program_version = "xdp-flowtable 0.0";
+const char argp_program_doc[] =
+"XDP flowtable application.\n"
+"\n"
+"USAGE: ./xdp-flowtable [-v] <iface-name>\n";
+
+static const struct argp_option opts[] = {
+	{ "verbose", 'v', NULL, 0, "Verbose debug output" },
+	{},
+};
+
+static void sig_handler(int sig)
+{
+	exiting = true;
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level,
+			   const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbosity)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case 'v':
+		verbosity = true;
+		break;
+	case ARGP_KEY_ARG:
+		errno = 0;
+		if (strlen(arg) >= IF_NAMESIZE) {
+			fprintf(stderr, "Invalid device name: %s\n", arg);
+			argp_usage(state);
+			return ARGP_ERR_UNKNOWN;
+		}
+
+		ifindex = if_nametoindex(arg);
+		if (!ifindex)
+			ifindex = strtoul(arg, NULL, 0);
+		if (!ifindex || !if_indextoname(ifindex, ifname)) {
+			fprintf(stderr,
+				"Bad interface index or name (%d): %s\n",
+				errno, strerror(errno));
+			argp_usage(state);
+			return ARGP_ERR_UNKNOWN;
+		}
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static const struct argp argp = {
+	.options = opts,
+	.parser = parse_arg,
+	.doc = argp_program_doc,
+};
+
+int main(int argc, char **argv)
+{
+	unsigned int count = 0, key = 0;
+	struct xdp_flowtable *skel;
+	int i, err;
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+	libbpf_set_print(libbpf_print_fn);
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	/* Parse command line arguments */
+	err = argp_parse(&argp, argc, argv, 0, NULL, NULL);
+	if (err)
+		return err;
+
+	/* Load and verify BPF application */
+	skel = xdp_flowtable__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to open and load BPF skeleton\n");
+		return -EINVAL;
+	}
+
+	/* Load & verify BPF programs */
+	err = xdp_flowtable__load(skel);
+	if (err) {
+		fprintf(stderr, "Failed to load and verify BPF skeleton\n");
+		goto cleanup;
+	}
+
+	/* Attach the XDP program */
+	err = xdp_flowtable__attach(skel);
+	if (err) {
+		fprintf(stderr, "Failed to attach BPF skeleton\n");
+		goto cleanup;
+	}
+
+	err = bpf_xdp_attach(ifindex,
+			     bpf_program__fd(skel->progs.xdp_flowtable_do_lookup),
+			     XDP_FLAGS_DRV_MODE, NULL);
+	if (err) {
+		fprintf(stderr, "Failed attaching XDP program to device %s\n",
+			ifname);
+		goto cleanup;
+	}
+
+	/* Collect stats */
+	for (i = 0; i < MAX_ITERATION && !exiting; i++)
+		sleep(1);
+
+	/* Check results */
+	err = bpf_map__lookup_elem(skel->maps.stats, &key, sizeof(key),
+				   &count, sizeof(count), 0);
+	if (!err && !count)
+		err = -EINVAL;
+
+	bpf_xdp_detach(ifindex, XDP_FLAGS_DRV_MODE, NULL);
+cleanup:
+	xdp_flowtable__destroy(skel);
+
+	return err;
+}
-- 
2.45.0


