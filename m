Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2375AFE
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2019 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfGYWwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jul 2019 18:52:53 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35724 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfGYWwx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 18:52:53 -0400
Received: by mail-qk1-f201.google.com with SMTP id 5so43719701qki.2
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2019 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UlRemZ2kT14YHAylc9y0G5ccVqoKv3zS1dwSBWg5K9Y=;
        b=rNlE+24Xap0dVvBd7hIA2isBhcX4wir3CZWnhEVDWQlSEx3jMFHg1RKh1QHXVePJVa
         kw5n0/3EBvn9ivO6q+FlS8CALwKpB2+LwSjc0hIhAKpOpOu+hJaeE8LnZbLdY0tYXfLS
         dTzNEzhwJ8IP+07ExAwe430IDqv9MCzL3IOOR9hY4LZ8X+HGcPY1yXPMfvEA7GasWkMb
         xCvzh4sbQ4hxeu/gkDysaQDLPumoUzt4EP4ByG35oxVc2aRFR3AjyZ+JEvThA6lu1gEb
         xo7dvl9Ctw87F5NfSPpTb7Ny2EC6yGouX+6RmVrkP3TykfVRg1KpRPXpr2D86nuH/0JE
         IVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UlRemZ2kT14YHAylc9y0G5ccVqoKv3zS1dwSBWg5K9Y=;
        b=W4y5whTam3Id0VKBBRa+dCa1+V0MIEBDZlIK37DEVdgSmU6yNoNIEltn8mTLTt28wi
         om7+nYOPr3EPtR/1e4+mUL80S2tiUyaOfDr+XlQQZsj5g1KGAEdJ25bSs7mfIEj/XzSw
         Y0bqbL5Nf+K16UnE2f/6+KAmD6uclKMyWdCJ1b7x8n5JIR62Pe1k7l4e7gDajEjzUy3c
         DpNCk4D3/acmbp/qMHMfpPLaLsbKvr+SPS6wbBdqk0hYa/qxl0iwS585QnIQeXalJXKy
         /Nq0L8oa3nvlnoJB3/Unp7G2un2a82yfkuFFfXcm1GJDPV8mEk35z1I43opT93K/x6Hd
         48JQ==
X-Gm-Message-State: APjAAAU/bhH2SjGzovouuhgF2i+Ld0/2KiSPMxZetSbxrX3uAeqm5Nch
        gt8rDJfyVSkAL4RRqygDO9LR8uU=
X-Google-Smtp-Source: APXvYqypjifXslPHkH9woXWF5vpWpt5hJxon/sboM5/ybdSHyvPXTsMa85cTxqD9jnMwegm5CRdAgqA=
X-Received: by 2002:a37:4e8f:: with SMTP id c137mr59090880qkb.127.1564095172242;
 Thu, 25 Jul 2019 15:52:52 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:52:31 -0700
In-Reply-To: <20190725225231.195090-1-sdf@google.com>
Message-Id: <20190725225231.195090-8-sdf@google.com>
Mime-Version: 1.0
References: <20190725225231.195090-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: support BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Exit as soon as we found that packet is encapped when
BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP is passed.
Add appropriate selftest cases.

v2:
* Subtract sizeof(struct iphdr) from .iph_inner.tot_len (Willem de Bruijn)

Acked-by: Petar Penkov <ppenkov@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c | 64 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  8 +++
 2 files changed, 72 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index ef83f145a6f1..700d73d2f22a 100644
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
@@ -303,6 +311,62 @@ struct test tests[] = {
 		},
 		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
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
+			.iph_inner.tot_len =
+				__bpf_constant_htons(MAGIC_BYTES) -
+				sizeof(struct iphdr),
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
+			.iph_inner.tot_len =
+				__bpf_constant_htons(MAGIC_BYTES) -
+				sizeof(struct iphdr),
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct iphdr),
+			.addr_proto = ETH_P_IP,
+			.ip_proto = IPPROTO_IPIP,
+			.n_proto = __bpf_constant_htons(ETH_P_IP),
+			.is_encap = true,
+		},
+		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
+	},
 };
 
 static int create_tap(const char *ifname)
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index 7fbfa22f33df..08bd8b9d58d0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -167,9 +167,15 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 		return export_flow_keys(keys, BPF_OK);
 	case IPPROTO_IPIP:
 		keys->is_encap = true;
+		if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP)
+			return export_flow_keys(keys, BPF_OK);
+
 		return parse_eth_proto(skb, bpf_htons(ETH_P_IP));
 	case IPPROTO_IPV6:
 		keys->is_encap = true;
+		if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP)
+			return export_flow_keys(keys, BPF_OK);
+
 		return parse_eth_proto(skb, bpf_htons(ETH_P_IPV6));
 	case IPPROTO_GRE:
 		gre = bpf_flow_dissect_get_header(skb, sizeof(*gre), &_gre);
@@ -189,6 +195,8 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 			keys->thoff += 4; /* Step over sequence number */
 
 		keys->is_encap = true;
+		if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP)
+			return export_flow_keys(keys, BPF_OK);
 
 		if (gre->proto == bpf_htons(ETH_P_TEB)) {
 			eth = bpf_flow_dissect_get_header(skb, sizeof(*eth),
-- 
2.22.0.709.g102302147b-goog

