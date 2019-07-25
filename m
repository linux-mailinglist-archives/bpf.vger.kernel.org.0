Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74475AF9
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2019 00:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfGYWwv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jul 2019 18:52:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48857 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfGYWwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 18:52:50 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so31858492pfn.15
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2019 15:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qL7cZRSBHY1VH9elVXnZ18wmVUw/HNyB8hQ7P/vwCwM=;
        b=LUMEgD7ZpfI47zY302IQcxJZSQCQMctM841QfzJO1gxBPHYqw4YVILoEUie0acRIrw
         oV0VLr5J118q7rIsxhUZbwzrX4wH84GWexiNg5IB0qV/5zj7UlqhpITce1RP3ZaHY7Nf
         ltlLHVkoxdGjjjLW7lf1+nDXzoISfV9D/Uke/DvIQGKohZqAqMyivBT8pu5Qzlf6EVtu
         olopwnG6cZ+cttcj/C7FMI0rvFTRGb5Ahc+1hBsOvPHsQMQIXI/xL4Pfpw6ljFVWo32+
         NYWplL4AH5NFIEocgkkZzNCcniWWoGPCfxc8Bpblzqq+qNFw5cVPhoAzYwaiVVJJdNpj
         TcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qL7cZRSBHY1VH9elVXnZ18wmVUw/HNyB8hQ7P/vwCwM=;
        b=WW/suOS3+YdQbHWzrVTkBcAOvoDRkzvifIcELKwS4JwcjslKHs7l0vrYODz063pXtV
         jqeyFLwoLYp0aEtkghC6RhHZy55Aq8rFh32Ljxz7yVvDDmb7mIByxGyYptb/Zk7VoXAi
         E8CTzdEBDujbXFBjdDwnFzNFXahyLuxXaV6fkMTq59Tw5dFG5pNY68bFZtHKYi8Ejtun
         +j4YpxylsxvJ0eJ1G5YdH/ZgX0a/p2/wMIKH+PaYLoNmMSD2ngK8q0kVhaEzj0Y0mEHv
         fYKnoM6KynvyuSEUq5oBR9si7VLhkavGjlHvS2Ru8qNDK9/HLLtszff+l8G0yJGOvixR
         RTRw==
X-Gm-Message-State: APjAAAXjdQ0b4PdaT9rpblvbWlGAmZJCkjrwa/4ipiaRg5fg2D2N4Yez
        qNJUFvwpPSYFUtDQXkOpg5dB6DM=
X-Google-Smtp-Source: APXvYqzCkLsD66O3mUhuFbm+nZa8F/q8RbclzigTlfZ7GGgVjhGoaPlPxhP35dj6As6DswOyn3UeeN8=
X-Received: by 2002:a63:b10f:: with SMTP id r15mr18801078pgf.230.1564095169393;
 Thu, 25 Jul 2019 15:52:49 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:52:30 -0700
In-Reply-To: <20190725225231.195090-1-sdf@google.com>
Message-Id: <20190725225231.195090-7-sdf@google.com>
Mime-Version: 1.0
References: <20190725225231.195090-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next v3 6/7] bpf/flow_dissector: support ipv6 flow_label
 and BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
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

Add support for exporting ipv6 flow label via bpf_flow_keys.
Export flow label from bpf_flow.c and also return early when
BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL is passed.

Acked-by: Petar Penkov <ppenkov@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h                      |  1 +
 net/core/flow_dissector.c                     |  9 ++++
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/flow_dissector.c | 46 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  | 10 ++++
 5 files changed, 67 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 88b9d743036f..e985f07a98ed 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3533,6 +3533,7 @@ struct bpf_flow_keys {
 		};
 	};
 	__u32	flags;
+	__be32	flow_label;
 };
 
 struct bpf_func_info {
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 50ed1a688709..9741b593ea53 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -737,6 +737,7 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 	struct flow_dissector_key_basic *key_basic;
 	struct flow_dissector_key_addrs *key_addrs;
 	struct flow_dissector_key_ports *key_ports;
+	struct flow_dissector_key_tags *key_tags;
 
 	key_control = skb_flow_dissector_target(flow_dissector,
 						FLOW_DISSECTOR_KEY_CONTROL,
@@ -781,6 +782,14 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 		key_ports->src = flow_keys->sport;
 		key_ports->dst = flow_keys->dport;
 	}
+
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
+		key_tags = skb_flow_dissector_target(flow_dissector,
+						     FLOW_DISSECTOR_KEY_FLOW_LABEL,
+						     target_container);
+		key_tags->flow_label = ntohl(flow_keys->flow_label);
+	}
 }
 
 bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2e4b0848d795..3d7fc67ec1b8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3530,6 +3530,7 @@ struct bpf_flow_keys {
 		};
 	};
 	__u32	flags;
+	__be32	flow_label;
 };
 
 struct bpf_func_info {
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 8e8c18aced9b..ef83f145a6f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -20,6 +20,7 @@
 	      "is_encap=%u/%u "						\
 	      "ip_proto=0x%x/0x%x "					\
 	      "n_proto=0x%x/0x%x "					\
+	      "flow_label=0x%x/0x%x "					\
 	      "sport=%u/%u "						\
 	      "dport=%u/%u\n",						\
 	      got.nhoff, expected.nhoff,				\
@@ -30,6 +31,7 @@
 	      got.is_encap, expected.is_encap,				\
 	      got.ip_proto, expected.ip_proto,				\
 	      got.n_proto, expected.n_proto,				\
+	      got.flow_label, expected.flow_label,			\
 	      got.sport, expected.sport,				\
 	      got.dport, expected.dport)
 
@@ -257,6 +259,50 @@ struct test tests[] = {
 			.is_first_frag = true,
 		},
 	},
+	{
+		.name = "ipv6-flow-label",
+		.pkt.ipv6 = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+			.iph.nexthdr = IPPROTO_TCP,
+			.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+			.iph.flow_lbl = { 0xb, 0xee, 0xef },
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct ipv6hdr),
+			.addr_proto = ETH_P_IPV6,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+			.sport = 80,
+			.dport = 8080,
+			.flow_label = __bpf_constant_htonl(0xbeeef),
+		},
+	},
+	{
+		.name = "ipv6-no-flow-label",
+		.pkt.ipv6 = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+			.iph.nexthdr = IPPROTO_TCP,
+			.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+			.iph.flow_lbl = { 0xb, 0xee, 0xef },
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct ipv6hdr),
+			.addr_proto = ETH_P_IPV6,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+			.flow_label = __bpf_constant_htonl(0xbeeef),
+		},
+		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
+	},
 };
 
 static int create_tap(const char *ifname)
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index f931cd3db9d4..7fbfa22f33df 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -83,6 +83,12 @@ static __always_inline int export_flow_keys(struct bpf_flow_keys *keys,
 	return ret;
 }
 
+#define IPV6_FLOWLABEL_MASK		__bpf_constant_htonl(0x000FFFFF)
+static inline __be32 ip6_flowlabel(const struct ipv6hdr *hdr)
+{
+	return *(__be32 *)hdr & IPV6_FLOWLABEL_MASK;
+}
+
 static __always_inline void *bpf_flow_dissect_get_header(struct __sk_buff *skb,
 							 __u16 hdr_size,
 							 void *buffer)
@@ -308,6 +314,10 @@ PROG(IPV6)(struct __sk_buff *skb)
 
 	keys->thoff += sizeof(struct ipv6hdr);
 	keys->ip_proto = ip6h->nexthdr;
+	keys->flow_label = ip6_flowlabel(ip6h);
+
+	if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL)
+		return export_flow_keys(keys, BPF_OK);
 
 	return parse_ipv6_proto(skb, ip6h->nexthdr);
 }
-- 
2.22.0.709.g102302147b-goog

