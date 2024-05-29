Return-Path: <bpf+bounces-30837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DCB8D3700
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C298128B70F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20FAFC1D;
	Wed, 29 May 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irhNJig/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B31E552;
	Wed, 29 May 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987888; cv=none; b=vEK6GZ8zMw1l37VkF9m28szZ1o17oAL1ahjdnAFwsS5MiusebwgZNWz0igVXX067MLTACSK/eLqhmyIhXxTLfGDjEqUIiC+PtTMaH9As1BJvfjTg8JOyrz6NQYWbOosgYLAqYihXy592sy/tsqaDN2NanMSPx0hayQBs2Oi+klI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987888; c=relaxed/simple;
	bh=JaUQ3/ByCpcodrgFcDdq/x3Oi4tjCpjTDvSbzxNG/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIVCUd3+yxEytOt3UQf/ijayeGkszfhZhBgALfEFC/i9jJhd+ejk+6ZWKRXvPLut27YjbTmyVNdPSbHmY7IUlc073E0wCq0gJTpaJHIHsxbrv29bORc76vnYp6n9W6hIYKQx58CkmQAEo+nt3RKQBjcWW92YSgr6k26irwOHD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irhNJig/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2CDC2BD10;
	Wed, 29 May 2024 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716987887;
	bh=JaUQ3/ByCpcodrgFcDdq/x3Oi4tjCpjTDvSbzxNG/94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irhNJig/WHexz/N9Dti2h1AiS7ny/eezdYA0o9S6hQZMMlCLJViiccdH1m0JjzlhZ
	 tsUZCx8mYDzzmOjFeZuflpzA8MpRSo5IFYVjpVAbhdp253K2wAQAq5wHEbnGvsxE60
	 VqIoO6S9hrpXVFIiyHt722o6eRP1JsLHT1hFeWjocxJgKfEq6NWj3/AAFl7S7DehIB
	 kzk/oYzHoFZ/zy/Gqud+gnAqfKMQloYUnRLJZJT9jbS0q4cFdmy0AlczudT0XwnwTW
	 mn/9ZAdnDsYJE+UlUUna96I++ffrwW0+M1sr05+8sX3JNPGOPRnQ4Gqn/F9D4leRwu
	 xAO7iy+UeQVXw==
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
Subject: [PATCH v4 bpf-next 1/3] netfilter: nf_tables: add flowtable map for xdp offload
Date: Wed, 29 May 2024 15:04:30 +0200
Message-ID: <1298eb8587c50a73da315516fbb1ea0305587dd5.1716987534.git.lorenzo@kernel.org>
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

Signed-off-by: Florian Westphal <fw@strlen.de>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/netfilter/nf_flow_table.h |   8 ++
 net/netfilter/Makefile                |   2 +-
 net/netfilter/nf_flow_table_offload.c |   6 +-
 net/netfilter/nf_flow_table_xdp.c     | 163 ++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 3 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_xdp.c

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 9abb7ee40d72f..688e02b287cc4 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -305,6 +305,14 @@ struct flow_ports {
 	__be16 source, dest;
 };
 
+struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev);
+int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
+			      struct net_device *dev,
+			      enum flow_block_command cmd);
+void nf_flow_offload_xdp_cancel(struct nf_flowtable *flowtable,
+				struct net_device *dev,
+				enum flow_block_command cmd);
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
index a010b25076ca0..d9b019c98694b 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1192,7 +1192,7 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	int err;
 
 	if (!nf_flowtable_hw_offload(flowtable))
-		return 0;
+		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
 
 	if (dev->netdev_ops->ndo_setup_tc)
 		err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
@@ -1200,8 +1200,10 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	else
 		err = nf_flow_table_indr_offload_cmd(&bo, flowtable, dev, cmd,
 						     &extack);
-	if (err < 0)
+	if (err < 0) {
+		nf_flow_offload_xdp_cancel(flowtable, dev, cmd);
 		return err;
+	}
 
 	return nf_flow_table_block_setup(flowtable, &bo, cmd);
 }
diff --git a/net/netfilter/nf_flow_table_xdp.c b/net/netfilter/nf_flow_table_xdp.c
new file mode 100644
index 0000000000000..b9bdf27ba9bd3
--- /dev/null
+++ b/net/netfilter/nf_flow_table_xdp.c
@@ -0,0 +1,163 @@
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
+
+void nf_flow_offload_xdp_cancel(struct nf_flowtable *flowtable,
+				struct net_device *dev,
+				enum flow_block_command cmd)
+{
+	switch (cmd) {
+	case FLOW_BLOCK_BIND:
+		nf_flowtable_by_dev_remove(flowtable, dev);
+		return;
+	case FLOW_BLOCK_UNBIND:
+		/* We do not re-bind in case hw offload would report error
+		 * on *unregister*.
+		 */
+		break;
+	}
+}
-- 
2.45.1


