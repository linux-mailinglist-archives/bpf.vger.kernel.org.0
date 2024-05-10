Return-Path: <bpf+bounces-29477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731B8C2635
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B371F23903
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F56130E53;
	Fri, 10 May 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQL6e/93"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D2127B73;
	Fri, 10 May 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349713; cv=none; b=OtwmGaSV/elCKrxmZ+FoswO15HWL1mwluPcKu/VPxPMXw/RrWdOGIg5lem5IQ+UiG/YbXamqu48k6YswSwQEk0JmAxnPFJNOO01EfhlXekzgivo0rWCLMnb/JCjA0hGneR0ZVdEgk7EZTX6cq8zkZF1vjXoRoe9jDb9niBU/dVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349713; c=relaxed/simple;
	bh=gigbIQ9TeUK6/dpHMO5F9oRq99aeFRnXGE3J80yrO5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/Vgp0mLQ3mU+5+Cey/rTIZYVWletPobU1dz3EpsqkrGxoAXH2xyn8EpH6orzgBF0uyaJQG2S75n7/BvTzP//UtDtJxm4+8MQPr2FIf4i8Q2wpvo0YVCVYQn6d5IdseUwhboVn65ACaVcdh8LRwfIQCLhxqXg4tvnriq20lalnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQL6e/93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9812C113CC;
	Fri, 10 May 2024 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349713;
	bh=gigbIQ9TeUK6/dpHMO5F9oRq99aeFRnXGE3J80yrO5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQL6e/93ZRf8l2U3fICZYj6amTw1VkrDnjGyhxO/8Ym18mYtRiT0chTvXb9OX3tXk
	 x0IkBa/XCBjaBETEV1RsS/ev+M1bsDYWGRSVkPGd/+nl54FsgiG9AQELha5ywkZTeA
	 B8rlbqD/cwlFICYvOoFpwUbdIc4fbEokP2hVU+hOnQ7bnc37zengE4viOAe3xxaB0S
	 /uPebup6x0qwe0w3Dkhu6XwG2mHrkAzMt+1guB+caloL9HjpdW/jMRrmQucQIR0gT3
	 TcGlH3LzsYnXLHSLDHQZzJPvRtINx9C9a6VPpO/fXdQO9fnBc7O9cdb9zfOsv0Hfqh
	 hAEE8b3kgquWw==
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
Subject: [RFC bpf-next v1 2/4] netfilter: add bpf_xdp_flow_offload_lookup kfunc
Date: Fri, 10 May 2024 16:01:25 +0200
Message-ID: <6526cb192be96de940f2e281ca31843d74106ae0.1715348200.git.lorenzo@kernel.org>
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

Introduce bpf_xdp_flow_offload_lookup kfunc in order to perform the
lookup of a given flowtable entry based on a fib tuple of incoming
traffic.
bpf_xdp_flow_offload_lookup can be used as building block to offload
in xdp the processing of sw flowtable when hw flowtable is not
available.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/netfilter/nf_flow_table.h |  9 +++
 net/netfilter/Makefile                |  5 ++
 net/netfilter/nf_flow_table_bpf.c     | 95 +++++++++++++++++++++++++++
 net/netfilter/nf_flow_table_inet.c    |  2 +
 4 files changed, 111 insertions(+)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 0bbe6ea8e0651..2f78bacb45d6a 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -312,6 +312,15 @@ unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 				       const struct nf_hook_state *state);
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF) || IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)
+extern int nf_flow_offload_register_bpf(void);
+#else
+static inline int nf_flow_offload_register_bpf(void)
+{
+	return 0;
+}
+#endif
+
 #define MODULE_ALIAS_NF_FLOWTABLE(family)	\
 	MODULE_ALIAS("nf-flowtable-" __stringify(family))
 
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 614815a3ed738..eb91a54b9fa9a 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -143,6 +143,11 @@ obj-$(CONFIG_NFT_FWD_NETDEV)	+= nft_fwd_netdev.o
 obj-$(CONFIG_NF_FLOW_TABLE)	+= nf_flow_table.o
 nf_flow_table-objs		:= nf_flow_table_core.o nf_flow_table_ip.o \
 				   nf_flow_table_offload.o
+ifeq ($(CONFIG_NF_FLOW_TABLE),m)
+nf_flow_table-objs += nf_flow_table_bpf.o
+else ifeq ($(CONFIG_NF_FLOW_TABLE),y)
+nf_flow_table-objs += nf_flow_table_bpf.o
+endif
 nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
new file mode 100644
index 0000000000000..836a1127e4052
--- /dev/null
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unstable Flow Table Helpers for XDP hook
+ *
+ * These are called from the XDP programs.
+ * Note that it is allowed to break compatibility for these functions since
+ * the interface they are exposed through to BPF programs is explicitly
+ * unstable.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <net/netfilter/nf_flow_table.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <net/xdp.h>
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in nf_flow_table BTF");
+
+static struct flow_offload_tuple_rhash *
+bpf_xdp_flow_offload_tuple_lookup(struct net_device *dev,
+				  struct flow_offload_tuple *tuple,
+				  __be16 proto)
+{
+	struct flow_offload_tuple_rhash *tuplehash;
+	struct nf_flowtable *flow_table;
+	struct flow_offload *flow;
+
+	flow_table = nf_flowtable_by_dev(dev);
+	if (!flow_table)
+		return ERR_PTR(-ENOENT);
+
+	tuplehash = flow_offload_lookup(flow_table, tuple);
+	if (!tuplehash)
+		return ERR_PTR(-ENOENT);
+
+	flow = container_of(tuplehash, struct flow_offload,
+			    tuplehash[tuplehash->tuple.dir]);
+	flow_offload_refresh(flow_table, flow, false);
+
+	return tuplehash;
+}
+
+__bpf_kfunc struct flow_offload_tuple_rhash *
+bpf_xdp_flow_offload_lookup(struct xdp_md *ctx,
+			    struct bpf_fib_lookup *fib_tuple,
+			    u32 fib_tuple__sz)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct flow_offload_tuple tuple = {
+		.iifidx = fib_tuple->ifindex,
+		.l3proto = fib_tuple->family,
+		.l4proto = fib_tuple->l4_protocol,
+		.src_port = fib_tuple->sport,
+		.dst_port = fib_tuple->dport,
+	};
+	__be16 proto;
+
+	switch (fib_tuple->family) {
+	case AF_INET:
+		tuple.src_v4.s_addr = fib_tuple->ipv4_src;
+		tuple.dst_v4.s_addr = fib_tuple->ipv4_dst;
+		proto = htons(ETH_P_IP);
+		break;
+	case AF_INET6:
+		tuple.src_v6 = *(struct in6_addr *)&fib_tuple->ipv6_src;
+		tuple.dst_v6 = *(struct in6_addr *)&fib_tuple->ipv6_dst;
+		proto = htons(ETH_P_IPV6);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return bpf_xdp_flow_offload_tuple_lookup(xdp->rxq->dev, &tuple, proto);
+}
+
+__diag_pop()
+
+BTF_KFUNCS_START(nf_ft_kfunc_set)
+BTF_ID_FLAGS(func, bpf_xdp_flow_offload_lookup)
+BTF_KFUNCS_END(nf_ft_kfunc_set)
+
+static const struct btf_kfunc_id_set nf_flow_offload_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &nf_ft_kfunc_set,
+};
+
+int nf_flow_offload_register_bpf(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &nf_flow_offload_kfunc_set);
+}
+EXPORT_SYMBOL_GPL(nf_flow_offload_register_bpf);
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 6eef15648b7b0..b13587238eceb 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -98,6 +98,8 @@ static int __init nf_flow_inet_module_init(void)
 	nft_register_flowtable_type(&flowtable_ipv6);
 	nft_register_flowtable_type(&flowtable_inet);
 
+	nf_flow_offload_register_bpf();
+
 	return 0;
 }
 
-- 
2.45.0


