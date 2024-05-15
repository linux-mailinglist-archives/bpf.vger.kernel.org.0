Return-Path: <bpf+bounces-29805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C58C6D92
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 23:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B788D1F222C3
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEBD15B55B;
	Wed, 15 May 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4Kdr17v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B82F877;
	Wed, 15 May 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807594; cv=none; b=J+D+KhuJgZTl8Wti7SknPftNfMM2PxOWsute5EbpKfUMWnMHWywmL11gShMLS8SRRFtj+bKji9gqbyVMKNCaxZFuCZYmN0jzIhca60CFtA4lVVam4veSlb0YKKCgAitasfV2lVY2vwpvqXcR8xlnFniWsCZmoCibLzVRTgmKLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807594; c=relaxed/simple;
	bh=LV0D0I25+4TlL9DWwVTWUbzh60ntnDy0Ap4VeBMVM/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPfE44bkqZBMKaC3k8fySksFyr2Tl66on/Bswf7xGQtBEVwJuvLvBR2OkLCDHS1Br8cvj6K4gfoRw7+778lDFU3GkJUT923Ds1Szbrz1PleHSYL5ufvEoEWKzmnASI/YioOvX95C5rmpCJX88vx49jh8GbJEXhBhxtAHaXY2GCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4Kdr17v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7445FC116B1;
	Wed, 15 May 2024 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715807594;
	bh=LV0D0I25+4TlL9DWwVTWUbzh60ntnDy0Ap4VeBMVM/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4Kdr17vbCIqf9fEleWkYRWwjelk//Z3XES644pp3yCViNENqIKhbKC47+2lH2czB
	 C8uaOUV7qkmdU06Et3MEq6jrutGG1u9pqDkjNrJ/2t45gdYwJ4lotjiC1UszOV2eqG
	 7iyt9f5RCUJuErtvwTfwGZTSfBMmkBlPFzg4MSjXRQL8WBje34f2wS+UQBx/cVL+7e
	 WAleEsQqLGdwG/pErVoGMxK/JQrlw/4Dr54SmbaDYnwzkhCKW2mxdwCrTfhkmfZ54d
	 RsbEseO4Oll1T4OgOcu5yf3fAzZraCqWsNXz5UnBiJSO6aD/YmjUMrXWpnRvFtFVPe
	 EAGWMLB74eMWw==
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
Subject: [PATCH bpf-next 2/4] netfilter: add bpf_xdp_flow_offload_lookup kfunc
Date: Wed, 15 May 2024 23:12:55 +0200
Message-ID: <c87caa37757cdf6e323c89748fd0a0408fd47da2.1715807303.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715807303.git.lorenzo@kernel.org>
References: <cover.1715807303.git.lorenzo@kernel.org>
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
 net/netfilter/nf_flow_table_bpf.c     | 95 +++++++++++++++++++++++++++
 net/netfilter/nf_flow_table_inet.c    |  2 +
 4 files changed, 112 insertions(+)
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


