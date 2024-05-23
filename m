Return-Path: <bpf+bounces-30387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9D8CD1CD
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 14:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE332845E5
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D8A1487F0;
	Thu, 23 May 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4zXr4b/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527013C68F;
	Thu, 23 May 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466001; cv=none; b=Ge7a5N4G9tQVRjmdblULrk/3NGEivw5aQQUGsWbWZKza1fapAC1qNbxlOo92tfHKBdRm6PZvAowUvRR3oGIMudrvzKj8aI0Q3M+bcx6LjPM89fs+nwyCFzF7HyVF6ysL785Wzv4OK47WmF4jj3tiBQqWjLkMCzYolRXvQ8N6RnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466001; c=relaxed/simple;
	bh=cHxdY5rQnl/OYxu/qxAmYp6xekcAmya/32+1oaqPr08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2/AgPPKVAzTy9f5CFII70xkBA327XXlIPcEC0D2WAa3zCf8Wy0odGq9RoClWkdIBSc4tFaCZ8oIPTwnqQewCBKcgm8ggsJCNqVWg0NsRyJOmz4V1HD06qkmX2oauz9Y2QnkS0puOTlWunNzCtWV9Yoz3WCv5wHGBioDoGEFfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4zXr4b/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED794C2BD10;
	Thu, 23 May 2024 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716466001;
	bh=cHxdY5rQnl/OYxu/qxAmYp6xekcAmya/32+1oaqPr08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4zXr4b/wldHQWgZMTS0VIJauAq/02wowFodVjU53O8pJbDPR0zK3UqQts1V+oE9n
	 NMf/TlnWmhecIbyTSmiJ/OudN9zlHnduaVyfI5QVsMfR6J5rTPjdgxfbawo8OoEumo
	 GMyFby5rrhgCwZNE0oxB95yaE6t27J+6UxDoTFnUBRslIilwVY6biIe6wghO7rDZpp
	 w+YoxXbLUXhTCBlwnHKtaPGEMERpqZn00GOF9OuomrC8Yn4s1+4PThJ9ThrDjtzYnG
	 zhShdIa7Lpq+lcvquJ51qLptDfAIj54s1qQ8yPcaAqYakiKzWchnj37CGHdsh1dhyg
	 go/apnZXnfQ5Q==
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
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com,
	toke@redhat.com,
	fw@strlen.de,
	hawk@kernel.org,
	horms@kernel.org,
	donhunte@redhat.com,
	memxor@gmail.com
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc
Date: Thu, 23 May 2024 14:06:18 +0200
Message-ID: <203ce044d388661609457aa529c73651072ec37b.1716465377.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716465377.git.lorenzo@kernel.org>
References: <cover.1716465377.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce e2e selftest for bpf_xdp_flow_lookup kfunc through
xdp_flowtable utility.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/config            |  13 ++
 .../selftests/bpf/prog_tests/xdp_flowtable.c  | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_flowtable.c       | 145 +++++++++++++++
 3 files changed, 326 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2fb16da78dce8..5291e97df7494 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -83,6 +83,19 @@ CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
+CONFIG_NF_TABLES=y
+CONFIG_NF_TABLES_INET=y
+CONFIG_NF_TABLES_NETDEV=y
+CONFIG_NF_TABLES_IPV4=y
+CONFIG_NF_TABLES_IPV6=y
+CONFIG_NETFILTER_INGRESS=y
+CONFIG_NF_FLOW_TABLE=y
+CONFIG_NF_FLOW_TABLE_INET=y
+CONFIG_NETFILTER_NETLINK=y
+CONFIG_NFT_FLOW_OFFLOAD=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP6_NF_IPTABLES=y
+CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
new file mode 100644
index 0000000000000..e1bf141d34015
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <bpf/btf.h>
+#include <linux/if_link.h>
+#include <linux/udp.h>
+#include <net/if.h>
+#include <unistd.h>
+
+#include "xdp_flowtable.skel.h"
+
+#define TX_NETNS_NAME	"ns0"
+#define RX_NETNS_NAME	"ns1"
+
+#define TX_NAME		"v0"
+#define FORWARD_NAME	"v1"
+#define RX_NAME		"d0"
+
+#define TX_MAC		"00:00:00:00:00:01"
+#define FORWARD_MAC	"00:00:00:00:00:02"
+#define RX_MAC		"00:00:00:00:00:03"
+#define DST_MAC		"00:00:00:00:00:04"
+
+#define TX_ADDR		"10.0.0.1"
+#define FORWARD_ADDR	"10.0.0.2"
+#define RX_ADDR		"20.0.0.1"
+#define DST_ADDR	"20.0.0.2"
+
+#define PREFIX_LEN	"8"
+#define N_PACKETS	10
+#define UDP_PORT	12345
+#define UDP_PORT_STR	"12345"
+
+static int send_udp_traffic(void)
+{
+	struct sockaddr_storage addr;
+	int i, sock;
+
+	if (make_sockaddr(AF_INET, DST_ADDR, UDP_PORT, &addr, NULL))
+		return -EINVAL;
+
+	sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return sock;
+
+	for (i = 0; i < N_PACKETS; i++) {
+		unsigned char buf[] = { 0xaa, 0xbb, 0xcc };
+		int n;
+
+		n = sendto(sock, buf, sizeof(buf), MSG_NOSIGNAL | MSG_CONFIRM,
+			   (struct sockaddr *)&addr, sizeof(addr));
+		if (n != sizeof(buf)) {
+			close(sock);
+			return -EINVAL;
+		}
+
+		usleep(50000); /* 50ms */
+	}
+	close(sock);
+
+	return 0;
+}
+
+void test_xdp_flowtable(void)
+{
+	struct xdp_flowtable *skel = NULL;
+	struct nstoken *tok = NULL;
+	int iifindex, stats_fd;
+	__u32 value, key = 0;
+	struct bpf_link *link;
+
+	if (SYS_NOFAIL("nft -v")) {
+		fprintf(stdout, "Missing required nft tool\n");
+		test__skip();
+		return;
+	}
+
+	SYS(out, "ip netns add " TX_NETNS_NAME);
+	SYS(out, "ip netns add " RX_NETNS_NAME);
+
+	tok = open_netns(RX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "sysctl -qw net.ipv4.conf.all.forwarding=1");
+
+	SYS(out, "ip link add " TX_NAME " type veth peer " FORWARD_NAME);
+	SYS(out, "ip link set " TX_NAME " netns " TX_NETNS_NAME);
+	SYS(out, "ip link set dev " FORWARD_NAME " address " FORWARD_MAC);
+	SYS(out,
+	    "ip addr add " FORWARD_ADDR "/" PREFIX_LEN " dev " FORWARD_NAME);
+	SYS(out, "ip link set dev " FORWARD_NAME " up");
+
+	SYS(out, "ip link add " RX_NAME " type dummy");
+	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
+	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
+	SYS(out, "ip link set dev " RX_NAME " up");
+
+	/* configure the flowtable */
+	SYS(out, "nft add table ip filter");
+	SYS(out,
+	    "nft add flowtable ip filter f { hook ingress priority 0\\; "
+	    "devices = { " FORWARD_NAME ", " RX_NAME " }\\; }");
+	SYS(out,
+	    "nft add chain ip filter forward "
+	    "{ type filter hook forward priority 0\\; }");
+	SYS(out,
+	    "nft add rule ip filter forward ip protocol udp th dport "
+	    UDP_PORT_STR " flow add @f");
+
+	/* Avoid ARP calls */
+	SYS(out,
+	    "ip -4 neigh add " DST_ADDR " lladdr " DST_MAC " dev " RX_NAME);
+
+	close_netns(tok);
+	tok = open_netns(TX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
+	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
+	SYS(out, "ip link set dev " TX_NAME " up");
+	SYS(out, "ip route add default via " FORWARD_ADDR);
+
+	close_netns(tok);
+	tok = open_netns(RX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	iifindex = if_nametoindex(FORWARD_NAME);
+	if (!ASSERT_NEQ(iifindex, 0, "iifindex"))
+		goto out;
+
+	skel = xdp_flowtable__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto out;
+
+	link = bpf_program__attach_xdp(skel->progs.xdp_flowtable_do_lookup,
+				       iifindex);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		goto out;
+
+	close_netns(tok);
+	tok = open_netns(TX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	if (!ASSERT_OK(send_udp_traffic(), "send udp"))
+		goto out;
+
+	close_netns(tok);
+	tok = open_netns(RX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	stats_fd = bpf_map__fd(skel->maps.stats);
+	if (!ASSERT_OK(bpf_map_lookup_elem(stats_fd, &key, &value),
+		       "bpf_map_update_elem stats"))
+		goto out;
+
+	ASSERT_GE(value, N_PACKETS - 2, "bpf_xdp_flow_lookup failed");
+out:
+	xdp_flowtable__destroy(skel);
+	if (tok)
+		close_netns(tok);
+	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
+	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
new file mode 100644
index 0000000000000..fb7f6fac57459
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define MAX_ERRNO	4095
+
+#define ETH_P_IP	0x0800
+#define ETH_P_IPV6	0x86dd
+#define IP_MF		0x2000	/* "More Fragments" */
+#define IP_OFFSET	0x1fff	/* "Fragment Offset" */
+#define AF_INET		2
+#define AF_INET6	10
+
+struct bpf_flowtable_opts___local {
+	s32 error;
+};
+
+struct flow_offload_tuple_rhash *
+bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
+		    struct bpf_flowtable_opts___local *, u32) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1);
+} stats SEC(".maps");
+
+static bool xdp_flowtable_offload_check_iphdr(struct iphdr *iph)
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
+static bool xdp_flowtable_offload_check_tcp_state(void *ports, void *data_end,
+						  u8 proto)
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
+	struct bpf_flowtable_opts___local opts = {};
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
+	tuplehash = bpf_xdp_flow_lookup(ctx, &tuple, &opts, sizeof(opts));
+	if (!tuplehash)
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
-- 
2.45.1


