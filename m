Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51052752B9
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2019 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbfGYPeF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jul 2019 11:34:05 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47745 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389195AbfGYPeF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 11:34:05 -0400
Received: by mail-pf1-f202.google.com with SMTP id f25so31064601pfk.14
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2019 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cwc6MFuQeVYESzjjmb98s1+UYBUaqh95Zn6ch0zENRw=;
        b=TETaKcXejX2FlpfjkqWWHA4Gf5x0ixuRBfgqI1bh+V3+PVgISKvJ2r+geazwh4H+sl
         8NwfLm7XEy9gQtWItzVw/RRza0tpUiuhpXC3tByEdl8HMJGjHppV9ykVSy7nSDfMMtMi
         xdkjM7w1Lk14V4Nk9OZiO6j+vZeCJ1DPFBJ5yTC7x+bZLRifgVlawu0BTYcHZnrb37Iu
         MjGEP/HFGfMPsdMgKztzQr/m9u9oO+qVV3bKng17yjqCuKIKPLyyqv+exIMWCDcuM/rc
         eK5/97NR5wgXWYuO0lf+zQE6N5DsnZ9vmE7fRJ3S05EIQnvN6hplurIJi4drGsJoeNBK
         udLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cwc6MFuQeVYESzjjmb98s1+UYBUaqh95Zn6ch0zENRw=;
        b=fgJCAaoVgIRus4DTltCqlX5YqlTEIwWRgGdyljpZ5xTM2PSLlQ6/dVxd32MXkzEG1n
         2mXDpYUUzXX0NAjbsXG3I62Rk84KxFPNu20CvTgU4F16xyiryfCqHHGfb6w8qYoDBodP
         nSJwLcCbjHWheQr6P6NMOUo/p7b/yVjpleOj54pbQw4sOqyo4w+XliNYwGiGzGWl31n4
         js8EBlD8UJfgH9XCTRq13GJhXk/NgBjLlOMYPLgq9yAWGgNSepDveMKqQQJrldkKFyc9
         jVDXtSoZuXAtx9AeaCINrqzoRuFuvS134O9Svql+A1sDSc4rnaeLL6wxhmC9BhMTe25r
         4MrA==
X-Gm-Message-State: APjAAAX1qeHcbXXUzWij8DoHnoOSDPdA2bPoAConTXj/IsaT/ycsW64Z
        /kUwga0cCWvj/L8YzURE+QSSFj4=
X-Google-Smtp-Source: APXvYqxsaIF0+3j3tO9QIyHUUbsUly3lsHn8bpSIYPZ8k8PLRjL0LFHG319mOWHjfLNH4T5YmHpzGhE=
X-Received: by 2002:a63:dd17:: with SMTP id t23mr59456661pgg.295.1564068843582;
 Thu, 25 Jul 2019 08:34:03 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:33:42 -0700
In-Reply-To: <20190725153342.3571-1-sdf@google.com>
Message-Id: <20190725153342.3571-8-sdf@google.com>
Mime-Version: 1.0
References: <20190725153342.3571-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: support FLOW_DISSECTOR_F_STOP_AT_ENCAP
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Song Liu <songliubraving@fb.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Exit as soon as we found that packet is encapped when
FLOW_DISSECTOR_F_STOP_AT_ENCAP is passed.
Add appropriate selftest cases.

v2:
* Subtract sizeof(struct iphdr) from .iph_inner.tot_len (Willem de Bruijn)

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
index ada032be6199..15265c7a90a3 100644
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

