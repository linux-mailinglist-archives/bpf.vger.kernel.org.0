Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFB7347C
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfGXRAk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 13:00:40 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46735 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfGXRAj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 13:00:39 -0400
Received: by mail-pg1-f202.google.com with SMTP id u1so28680093pgr.13
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FRNcRu6lDB1xBr2PsV6vHeQry9zflSkPR0VRFovMcCM=;
        b=sKogE6EVxLd6hnxUxXZdL1LW5vrdjutf18p7yL1gwUisRRpBpS+19pGtYqKj8uHZCv
         8Ecis7k9yKgG9GKiBpUftao5xZYoCcCBhWrDC5JRH6RMPLFaElXgHOedMrvdX0bI+GB+
         +8afVrxJkxfACUEqwUMbntYetKv4GT2I9hdkvUhWKmPVa7f+S4PMOq5Mb001cs5THkRk
         P53hyCeK2+94SqdSR2xuNR8fWki3PXp9iaubEmHpFGTER8j5Emh6WQ8V1sQ2t+wWunon
         dnE9giUuDVzBxdgt3/l2YdRWX3pnd/jZgxLjsSP0paUHw4zJzWHqP1QJ3E62+dvWO4VB
         4wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FRNcRu6lDB1xBr2PsV6vHeQry9zflSkPR0VRFovMcCM=;
        b=I9cr/lHGk5Pp0bzP5jJPXtDJOmFf6s4Lt7iY5bNsFSym5GOXwgAO6sURZ8rH488h+M
         FcSwR2TPYlv+kZTm+9uBAE0l2Zg+1XdkKJM/H9TxFHYmrnIFNtDO+OSP6GB1lGtx4hFv
         4XQaMrRpu8FX6rlN+Q2QBtIW/DQ9ljRwIjKc8mL2x+I+5jo+5eUPS+Ff/mN+FSjK2d45
         VhCLrt+F5rILlOMTH1cI/ufPRKy9LLfjAPvpDj0u7lnbcTtOvoM4wDMu139LCiA2wGFe
         2BNvUVPdaCs4RGBKDa1itY3PKNXa6n8IGWtL4tgiss6wwTBXeyOL94p7fimcszgLqESo
         lTOA==
X-Gm-Message-State: APjAAAUvs6tXuUcRiG6HZF92jJXqOwM+v0dQh/jc39bg8zbYzcYlum6F
        Sr+wDs6iUaXpGKpV9PmFfnqqLrk=
X-Google-Smtp-Source: APXvYqzOVy+j7WJJns5lw5LsSY3MEvQu+tIk4RP4vIyx02wnzV6/OK2b2A7bLI+5DN7lwsNrYgxKJ1g=
X-Received: by 2002:a65:4489:: with SMTP id l9mr84811810pgq.207.1563987638862;
 Wed, 24 Jul 2019 10:00:38 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:00:18 -0700
In-Reply-To: <20190724170018.96659-1-sdf@google.com>
Message-Id: <20190724170018.96659-8-sdf@google.com>
Mime-Version: 1.0
References: <20190724170018.96659-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 7/7] selftests/bpf: support FLOW_DISSECTOR_F_STOP_AT_ENCAP
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Exit as soon as we found that packet is encapped when
FLOW_DISSECTOR_F_STOP_AT_ENCAP is passed.
Add appropriate selftest cases.

Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c | 60 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  8 +++
 2 files changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 1ea921c4cdc0..e382264fbc40 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -41,6 +41,13 @@ struct ipv4_pkt {
 	struct tcphdr tcp;
 } __packed;
 
+struct ipip_pkt {
+	struct ethhdr eth;
+	struct iphdr iph;
+	struct iphdr iph_inner;
+	struct tcphdr tcp;
+} __packed;
+
 struct svlan_ipv4_pkt {
 	struct ethhdr eth;
 	__u16 vlan_tci;
@@ -82,6 +89,7 @@ struct test {
 	union {
 		struct ipv4_pkt ipv4;
 		struct svlan_ipv4_pkt svlan_ipv4;
+		struct ipip_pkt ipip;
 		struct ipv6_pkt ipv6;
 		struct ipv6_frag_pkt ipv6_frag;
 		struct dvlan_ipv6_pkt dvlan_ipv6;
@@ -303,6 +311,58 @@ struct test tests[] = {
 		},
 		.flags = FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
 	},
+	{
+		.name = "ipip-encap",
+		.pkt.ipip = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+			.iph.ihl = 5,
+			.iph.protocol = IPPROTO_IPIP,
+			.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.iph_inner.ihl = 5,
+			.iph_inner.protocol = IPPROTO_TCP,
+			.iph_inner.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.nhoff = 0,
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct iphdr) +
+				sizeof(struct iphdr),
+			.addr_proto = ETH_P_IP,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IP),
+			.is_encap = true,
+			.sport = 80,
+			.dport = 8080,
+		},
+	},
+	{
+		.name = "ipip-no-encap",
+		.pkt.ipip = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+			.iph.ihl = 5,
+			.iph.protocol = IPPROTO_IPIP,
+			.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.iph_inner.ihl = 5,
+			.iph_inner.protocol = IPPROTO_TCP,
+			.iph_inner.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.flags = FLOW_DISSECTOR_F_STOP_AT_ENCAP,
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct iphdr),
+			.addr_proto = ETH_P_IP,
+			.ip_proto = IPPROTO_IPIP,
+			.n_proto = __bpf_constant_htons(ETH_P_IP),
+			.is_encap = true,
+		},
+		.flags = FLOW_DISSECTOR_F_STOP_AT_ENCAP,
+	},
 };
 
 static int create_tap(const char *ifname)
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index 7d73b7bfe609..b6236cdf8564 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -167,9 +167,15 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 		return export_flow_keys(keys, BPF_OK);
 	case IPPROTO_IPIP:
 		keys->is_encap = true;
+		if (keys->flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP)
+			return export_flow_keys(keys, BPF_OK);
+
 		return parse_eth_proto(skb, bpf_htons(ETH_P_IP));
 	case IPPROTO_IPV6:
 		keys->is_encap = true;
+		if (keys->flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP)
+			return export_flow_keys(keys, BPF_OK);
+
 		return parse_eth_proto(skb, bpf_htons(ETH_P_IPV6));
 	case IPPROTO_GRE:
 		gre = bpf_flow_dissect_get_header(skb, sizeof(*gre), &_gre);
@@ -189,6 +195,8 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 			keys->thoff += 4; /* Step over sequence number */
 
 		keys->is_encap = true;
+		if (keys->flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP)
+			return export_flow_keys(keys, BPF_OK);
 
 		if (gre->proto == bpf_htons(ETH_P_TEB)) {
 			eth = bpf_flow_dissect_get_header(skb, sizeof(*eth),
-- 
2.22.0.657.g960e92d24f-goog

