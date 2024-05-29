Return-Path: <bpf+bounces-30838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3A8D3703
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712F11C20F6E
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A210A03;
	Wed, 29 May 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoWnyYJ+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BFB10A24;
	Wed, 29 May 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987892; cv=none; b=mJsPaL5boX2BOPGbRtlS/qIFEVgDb+W9ibdYcqYWWLyFGc8jteZo0VgetdlIZ2n47KkPmE6VttJ1Qk7purgvQN0CyIJ5Fv4ZvPmLoFGatlXrEY7RweYytEk37YLArkFsSzSyJlOEAEwZcMvC5+OcnB6F7+AHuvRfFakaEg51aJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987892; c=relaxed/simple;
	bh=0aNXTXOtZbIARkfMlno8bzAXpQ7Qtonfryf4Et0zh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNqbVfKXXgDPd0+eQCv34bjfhnRQKRvwfcbpP0Y7gMn7al2ccRrOB9/AtNg16EfNhnYXqVHEVhwc6hM4LWYgAwZOOcyy1cAXDBgwD+FueaznAbBmffiwBnXdbe2zHsXfUKVgqGfBDlewhocYK3jUa5xvXiHW+JL4tiS3Y3V6Buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoWnyYJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DDFC2BD10;
	Wed, 29 May 2024 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716987891;
	bh=0aNXTXOtZbIARkfMlno8bzAXpQ7Qtonfryf4Et0zh6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoWnyYJ+xvIoI8KJyrPgyC9v9zB7BVQSF3VVUKr9ILMiD31tm8ClTKCuX+VFhN/PO
	 z1cmdYFkfG7fNuHdgEf3De2V8plsG9cbHBhqMlpdNBKe/TrieEoL5pt9XmduXSieOK
	 Rm8fdn+PPKH8+cA7CNpQ9Qj0YkkAgIhCiYaevL+osDd+xsTLeUUtrHYaZaZHs74HeX
	 Jfle6exS+aCsrsBBhKViwa1VV9asiMu14a09NFNnfijPx6duO+IrbNfQPY6XJVl7qs
	 sH1QlLlPtDY4HoDGqiaDWlbWEVmDAQ0eKiTd14yEHgCqTG1WcCdcl54tvBNXbvH/7L
	 zuJ/i23nhUXbA==
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
Subject: [PATCH v4 bpf-next 2/3] netfilter: add bpf_xdp_flow_lookup kfunc
Date: Wed, 29 May 2024 15:04:31 +0200
Message-ID: <db46e0e2abd192c7db498046f5ce170a742a0e95.1716987534.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716987534.git.lorenzo@kernel.org>
References: <cover.1716987534.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_xdp_flow_lookup kfunc in order to perform the lookup
of a given flowtable entry based on a fib tuple of incoming traffic.
bpf_xdp_flow_lookup can be used as building block to offload in xdp
the processing of sw flowtable when hw flowtable is not available.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/netfilter/nf_flow_table.h |  10 +++
 net/netfilter/Makefile                |   5 ++
 net/netfilter/nf_flow_table_bpf.c     | 117 ++++++++++++++++++++++++++
 net/netfilter/nf_flow_table_inet.c    |   2 +-
 4 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 688e02b287cc4..cc52234ef71af 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -318,6 +318,16 @@ unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 				       const struct nf_hook_state *state);
 
+#if (IS_BUILTIN(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
+    (IS_MODULE(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+extern int nf_flow_register_bpf(void);
+#else
+static inline int nf_flow_register_bpf(void)
+{
+	return 0;
+}
+#endif
+
 #define MODULE_ALIAS_NF_FLOWTABLE(family)	\
 	MODULE_ALIAS("nf-flowtable-" __stringify(family))
 
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 18046872a38aa..f0aa4d7ef4998 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -144,6 +144,11 @@ obj-$(CONFIG_NF_FLOW_TABLE)	+= nf_flow_table.o
 nf_flow_table-objs		:= nf_flow_table_core.o nf_flow_table_ip.o \
 				   nf_flow_table_offload.o nf_flow_table_xdp.o
 nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
+ifeq ($(CONFIG_NF_FLOW_TABLE),m)
+nf_flow_table-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_flow_table_bpf.o
+else ifeq ($(CONFIG_NF_FLOW_TABLE),y)
+nf_flow_table-$(CONFIG_DEBUG_INFO_BTF) += nf_flow_table_bpf.o
+endif
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
 
diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
new file mode 100644
index 0000000000000..b3f8dffe62535
--- /dev/null
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -0,0 +1,117 @@
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
+/* bpf_flowtable_opts - options for bpf flowtable helpers
+ * @error: out parameter, set for any encountered error
+ */
+struct bpf_flowtable_opts {
+	s32 error;
+};
+
+enum {
+	NF_BPF_FLOWTABLE_OPTS_SZ = 4,
+};
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in nf_flow_table BTF");
+
+static struct flow_offload_tuple_rhash *
+bpf_xdp_flow_tuple_lookup(struct net_device *dev,
+			  struct flow_offload_tuple *tuple, __be16 proto)
+{
+	struct flow_offload_tuple_rhash *tuplehash;
+	struct nf_flowtable *nf_flow_table;
+	struct flow_offload *nf_flow;
+
+	nf_flow_table = nf_flowtable_by_dev(dev);
+	if (!nf_flow_table)
+		return ERR_PTR(-ENOENT);
+
+	tuplehash = flow_offload_lookup(nf_flow_table, tuple);
+	if (!tuplehash)
+		return ERR_PTR(-ENOENT);
+
+	nf_flow = container_of(tuplehash, struct flow_offload,
+			       tuplehash[tuplehash->tuple.dir]);
+	flow_offload_refresh(nf_flow_table, nf_flow, false);
+
+	return tuplehash;
+}
+
+__bpf_kfunc struct flow_offload_tuple_rhash *
+bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple,
+		    struct bpf_flowtable_opts *opts, u32 opts_len)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct flow_offload_tuple tuple = {
+		.iifidx = fib_tuple->ifindex,
+		.l3proto = fib_tuple->family,
+		.l4proto = fib_tuple->l4_protocol,
+		.src_port = fib_tuple->sport,
+		.dst_port = fib_tuple->dport,
+	};
+	struct flow_offload_tuple_rhash *tuplehash;
+	__be16 proto;
+
+	if (opts_len != NF_BPF_FLOWTABLE_OPTS_SZ) {
+		opts->error = -EINVAL;
+		return NULL;
+	}
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
+		opts->error = -EAFNOSUPPORT;
+		return NULL;
+	}
+
+	tuplehash = bpf_xdp_flow_tuple_lookup(xdp->rxq->dev, &tuple, proto);
+	if (IS_ERR(tuplehash)) {
+		opts->error = PTR_ERR(tuplehash);
+		return NULL;
+	}
+
+	return tuplehash;
+}
+
+__diag_pop()
+
+BTF_KFUNCS_START(nf_ft_kfunc_set)
+BTF_ID_FLAGS(func, bpf_xdp_flow_lookup, KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_KFUNCS_END(nf_ft_kfunc_set)
+
+static const struct btf_kfunc_id_set nf_flow_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &nf_ft_kfunc_set,
+};
+
+int nf_flow_register_bpf(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &nf_flow_kfunc_set);
+}
+EXPORT_SYMBOL_GPL(nf_flow_register_bpf);
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 6eef15648b7b0..88787b45e30d6 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -98,7 +98,7 @@ static int __init nf_flow_inet_module_init(void)
 	nft_register_flowtable_type(&flowtable_ipv6);
 	nft_register_flowtable_type(&flowtable_inet);
 
-	return 0;
+	return nf_flow_register_bpf();
 }
 
 static void __exit nf_flow_inet_module_exit(void)
-- 
2.45.1


