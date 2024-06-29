Return-Path: <bpf+bounces-33439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E835A91CF74
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 00:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8BF1C20C67
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA214387F;
	Sat, 29 Jun 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmiIZGyb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD28142E77;
	Sat, 29 Jun 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719700068; cv=none; b=YBXy3a0qe8dTXq4bMm6Ox20wv4XklWg+nWBQfxsuvXpkLb1VCCmPi1VyDM/b7kvFkNX+GkANbNFQog/CHrAX/1QtogSfEBZ7nCmV8b1i40z2CYAaus2Xjt+PKd6AQxYrE0j/LMwiRuCXJ5w2yuI0xdjcsFrc2tGLQYVrvwjJdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719700068; c=relaxed/simple;
	bh=FdXGJquKvlCA/FJD20KbmTwsHFx5VUj05zyEx3VmkSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5MeuiIn0CZ4GGG0EVsNGfrHHXFkUu9cJ3820YWPCrUmX64+zSyFk1Ad/puLDZGYq1uY/JXLTTj4EctQBWkbEfgQQSLZ15arWEIF2ymnC8iT65DcC36iECQ9oqe5R/49Af0XqfLI/Gya7shiZz4GMGOmGg5e9jHLpZuc/ke4/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmiIZGyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F43C2BBFC;
	Sat, 29 Jun 2024 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719700068;
	bh=FdXGJquKvlCA/FJD20KbmTwsHFx5VUj05zyEx3VmkSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmiIZGybi45h3oEkv5/ny8pxD3fzTbX3dImxAbSS31UvXT7qBECa/1vaOSxsmaNj4
	 Zp9EH2s3u9PGS+thFuMkYISXKahTPhVppKK02qGX0Z9ywrEH+V0vapd6zbWR6cBrLx
	 aGwZhDkDrKLQDskX9c3MEIkMS9SV2tZy8lS9vI7EXCg287QraFqjC9mOFNNrxS9nwj
	 YWbCqgudTnaR3BABLaOIptsKf38AkcLc/R3f2owLyvOxFw4HiPFyhhcI5Z0d7NvLyZ
	 qGo66RMYLpdvhqm1aWdfkxJo2gF8IErEETi/1DgnX+cwOfjGxcrP2oJGsMjP8TvcW6
	 7e6mXg1fVzoEA==
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
Subject: [PATCH v6 bpf-next 1/3] netfilter: nf_tables: add flowtable map for xdp offload
Date: Sun, 30 Jun 2024 00:26:48 +0200
Message-ID: <9f20e2c36f494b3bf177328718367f636bb0b2ab.1719698275.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719698275.git.lorenzo@kernel.org>
References: <cover.1719698275.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

This adds a small internal mapping table so that a new bpf (xdp) kfunc
can perform lookups in a flowtable.

As-is, xdp program has access to the device pointer, but no way to do a
lookup in a flowtable -- there is no way to obtain the needed struct
without questionable stunts.

This allows to obtain an nf_flowtable pointer given a net_device
structure.

In order to keep backward compatibility, the infrastructure allows the
user to add a given device to multiple flowtables, but it will always
return the first added mapping performing the lookup since it assumes
the right configuration is 1:1 mapping between flowtables and net_devices.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/netfilter/nf_flow_table.h |   5 +
 net/netfilter/Makefile                |   2 +-
 net/netfilter/nf_flow_table_offload.c |   2 +-
 net/netfilter/nf_flow_table_xdp.c     | 147 ++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_xdp.c

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 9abb7ee40d72f..d845745207d2d 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -305,6 +305,11 @@ struct flow_ports {
 	__be16 source, dest;
 };
 
+struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev);
+int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
+			      struct net_device *dev,
+			      enum flow_block_command cmd);
+
 unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state);
 unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 614815a3ed738..18046872a38aa 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -142,7 +142,7 @@ obj-$(CONFIG_NFT_FWD_NETDEV)	+= nft_fwd_netdev.o
 # flow table infrastructure
 obj-$(CONFIG_NF_FLOW_TABLE)	+= nf_flow_table.o
 nf_flow_table-objs		:= nf_flow_table_core.o nf_flow_table_ip.o \
-				   nf_flow_table_offload.o
+				   nf_flow_table_offload.o nf_flow_table_xdp.o
 nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index a010b25076ca0..ff1a4e36c2b5d 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1192,7 +1192,7 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	int err;
 
 	if (!nf_flowtable_hw_offload(flowtable))
-		return 0;
+		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
 
 	if (dev->netdev_ops->ndo_setup_tc)
 		err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
diff --git a/net/netfilter/nf_flow_table_xdp.c b/net/netfilter/nf_flow_table_xdp.c
new file mode 100644
index 0000000000000..e1252d0426991
--- /dev/null
+++ b/net/netfilter/nf_flow_table_xdp.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netfilter.h>
+#include <linux/rhashtable.h>
+#include <linux/netdevice.h>
+#include <net/flow_offload.h>
+#include <net/netfilter/nf_flow_table.h>
+
+struct flow_offload_xdp_ft {
+	struct list_head head;
+	struct nf_flowtable *ft;
+	struct rcu_head rcuhead;
+};
+
+struct flow_offload_xdp {
+	struct hlist_node hnode;
+	unsigned long net_device_addr;
+	struct list_head head;
+};
+
+#define NF_XDP_HT_BITS	4
+static DEFINE_HASHTABLE(nf_xdp_hashtable, NF_XDP_HT_BITS);
+static DEFINE_MUTEX(nf_xdp_hashtable_lock);
+
+/* caller must hold rcu read lock */
+struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev)
+{
+	unsigned long key = (unsigned long)dev;
+	struct flow_offload_xdp *iter;
+
+	hash_for_each_possible_rcu(nf_xdp_hashtable, iter, hnode, key) {
+		if (key == iter->net_device_addr) {
+			struct flow_offload_xdp_ft *ft_elem;
+
+			/* The user is supposed to insert a given net_device
+			 * just into a single nf_flowtable so we always return
+			 * the first element here.
+			 */
+			ft_elem = list_first_or_null_rcu(&iter->head,
+							 struct flow_offload_xdp_ft,
+							 head);
+			return ft_elem ? ft_elem->ft : NULL;
+		}
+	}
+
+	return NULL;
+}
+
+static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
+				      const struct net_device *dev)
+{
+	struct flow_offload_xdp *iter, *elem = NULL;
+	unsigned long key = (unsigned long)dev;
+	struct flow_offload_xdp_ft *ft_elem;
+
+	ft_elem = kzalloc(sizeof(*ft_elem), GFP_KERNEL_ACCOUNT);
+	if (!ft_elem)
+		return -ENOMEM;
+
+	ft_elem->ft = ft;
+
+	mutex_lock(&nf_xdp_hashtable_lock);
+
+	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
+		if (key == iter->net_device_addr) {
+			elem = iter;
+			break;
+		}
+	}
+
+	if (!elem) {
+		elem = kzalloc(sizeof(*elem), GFP_KERNEL_ACCOUNT);
+		if (!elem)
+			goto err_unlock;
+
+		elem->net_device_addr = key;
+		INIT_LIST_HEAD(&elem->head);
+		hash_add_rcu(nf_xdp_hashtable, &elem->hnode, key);
+	}
+	list_add_tail_rcu(&ft_elem->head, &elem->head);
+
+	mutex_unlock(&nf_xdp_hashtable_lock);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&nf_xdp_hashtable_lock);
+	kfree(ft_elem);
+
+	return -ENOMEM;
+}
+
+static void nf_flowtable_by_dev_remove(struct nf_flowtable *ft,
+				       const struct net_device *dev)
+{
+	struct flow_offload_xdp *iter, *elem = NULL;
+	unsigned long key = (unsigned long)dev;
+
+	mutex_lock(&nf_xdp_hashtable_lock);
+
+	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
+		if (key == iter->net_device_addr) {
+			elem = iter;
+			break;
+		}
+	}
+
+	if (elem) {
+		struct flow_offload_xdp_ft *ft_elem, *ft_next;
+
+		list_for_each_entry_safe(ft_elem, ft_next, &elem->head, head) {
+			if (ft_elem->ft == ft) {
+				list_del_rcu(&ft_elem->head);
+				kfree_rcu(ft_elem, rcuhead);
+			}
+		}
+
+		if (list_empty(&elem->head))
+			hash_del_rcu(&elem->hnode);
+		else
+			elem = NULL;
+	}
+
+	mutex_unlock(&nf_xdp_hashtable_lock);
+
+	if (elem) {
+		synchronize_rcu();
+		kfree(elem);
+	}
+}
+
+int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
+			      struct net_device *dev,
+			      enum flow_block_command cmd)
+{
+	switch (cmd) {
+	case FLOW_BLOCK_BIND:
+		return nf_flowtable_by_dev_insert(flowtable, dev);
+	case FLOW_BLOCK_UNBIND:
+		nf_flowtable_by_dev_remove(flowtable, dev);
+		return 0;
+	}
+
+	WARN_ON_ONCE(1);
+	return 0;
+}
-- 
2.45.2


