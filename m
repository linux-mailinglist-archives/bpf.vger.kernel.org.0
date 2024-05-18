Return-Path: <bpf+bounces-30006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FACE8C9059
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 12:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ADF1C20E20
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E932C184;
	Sat, 18 May 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCPVmidO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB429CE3;
	Sat, 18 May 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716027210; cv=none; b=q4plS1hc6IobTlXX4tOiKQRpBa50sL62lQ/zTGVJxbCnNYOjlc8lRAEQlp2zXmOmG8Jhf1z5+fxvwsFE1FuE77r2hVF6bq48/vje79mYEVIt27a8OMLKM5tJbansdWHO/XLozf8DIi6PArbOimgVRVkjJKNLcBMN7RTEQFqQH+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716027210; c=relaxed/simple;
	bh=5nkuhRXE3xoDHPpfoIsQjTJ3mPTNe79ghGeTe+M65lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4LUyWuvaaAy+SVxAqGTHZ5ffnRwwHtQAq7YdEs17DwYrheuBAvWh2x2TtuZRDodz5g8AHDMFR9gNQQKfMv2gQGN4hsMceUG1GEl5u53J7s4c494L3+ElQbF3/b6XDToogYPIpO5mXG/lnoPCPeSbHQnweOIk7l4m14SevDSThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCPVmidO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4E7C113CC;
	Sat, 18 May 2024 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716027209;
	bh=5nkuhRXE3xoDHPpfoIsQjTJ3mPTNe79ghGeTe+M65lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCPVmidOIwa7vyXvKR8YptZZVTz9y1/d6Njy+DKsP1Z9A1+9RVzf+JIbejg8m5VVa
	 8RW4wxHOxd8i/LO+OD7Lecd1hPukFZfsgXCuwXsTU1Gj4etv/LvbgMfI85EqBuQeFL
	 lmFFzcGQCgQHqZehk+vJnPsTpPebmkLJ0yImAoE+Ivy/OATmEYEZAX+Bo+JDI5+vdr
	 /f9dWTnEgeGk+KLf1XyaDZy4Qz9P4k3cc6wJ5nz0owmmHHzRRYiDHdPgoW/zYOfvX3
	 H+8E9UReuXyNRIfzh5cUjcLhyowWGtn1/rPPG+JYIaBVN9PL7WnDBUgASi5b0WBsdk
	 4nr5GiCY2ldvw==
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
	donhunte@redhat.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 2/4] netfilter: add bpf_xdp_flow_offload_lookup kfunc
Date: Sat, 18 May 2024 12:12:36 +0200
Message-ID: <0ddc5e4fcc6a38c74c185063e73ef4c496eaa7ca.1716026761.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716026761.git.lorenzo@kernel.org>
References: <cover.1716026761.git.lorenzo@kernel.org>
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
 include/net/netfilter/nf_flow_table.h | 10 +++
 net/netfilter/Makefile                |  5 ++
 net/netfilter/nf_flow_table_bpf.c     | 94 +++++++++++++++++++++++++++
 net/netfilter/nf_flow_table_inet.c    |  2 +-
 4 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 0bbe6ea8e0651..085660cbcd3f2 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -312,6 +312,16 @@ unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 				       const struct nf_hook_state *state);
 
+#if (IS_BUILTIN(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
+    (IS_MODULE(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
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
index 614815a3ed738..18b09cec92024 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -144,6 +144,11 @@ obj-$(CONFIG_NF_FLOW_TABLE)	+= nf_flow_table.o
 nf_flow_table-objs		:= nf_flow_table_core.o nf_flow_table_ip.o \
 				   nf_flow_table_offload.o
 nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
+ifeq ($(CONFIG_NF_FLOW_TABLE),m)
+nf_flow_table-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_flow_table_bpf.o
+else ifeq ($(CONFIG_NF_FLOW_TABLE),y)
+nf_flow_table-$(CONFIG_DEBUG_INFO_BTF) += nf_flow_table_bpf.o
+endif
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
 
diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
new file mode 100644
index 0000000000000..f999ed9712796
--- /dev/null
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -0,0 +1,94 @@
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
+		return NULL;
+
+	tuplehash = flow_offload_lookup(flow_table, tuple);
+	if (!tuplehash)
+		return NULL;
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
+			    struct bpf_fib_lookup *fib_tuple)
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
+		return NULL;
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
index 6eef15648b7b0..6175f7556919d 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -98,7 +98,7 @@ static int __init nf_flow_inet_module_init(void)
 	nft_register_flowtable_type(&flowtable_ipv6);
 	nft_register_flowtable_type(&flowtable_inet);
 
-	return 0;
+	return nf_flow_offload_register_bpf();
 }
 
 static void __exit nf_flow_inet_module_exit(void)
-- 
2.45.1


