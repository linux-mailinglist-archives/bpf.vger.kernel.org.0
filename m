Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879B35F5631
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJEONu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiJEONp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A494786CA
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 07:13:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1og59Y-0001f6-RW; Wed, 05 Oct 2022 16:13:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v2 4/9] netfilter: make hook functions accept only one argument
Date:   Wed,  5 Oct 2022 16:13:04 +0200
Message-Id: <20221005141309.31758-5-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005141309.31758-1-fw@strlen.de>
References: <20221005141309.31758-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF conversion requirement: one pointer-to-structure as argument.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 drivers/net/ipvlan/ipvlan_l3s.c            |  4 +-
 include/linux/netfilter.h                  | 10 ++--
 include/linux/netfilter_arp/arp_tables.h   |  3 +-
 include/linux/netfilter_bridge/ebtables.h  |  3 +-
 include/linux/netfilter_ipv4/ip_tables.h   |  4 +-
 include/linux/netfilter_ipv6/ip6_tables.h  |  3 +-
 include/net/netfilter/br_netfilter.h       |  7 +--
 include/net/netfilter/nf_flow_table.h      |  6 +--
 include/net/netfilter/nf_synproxy.h        |  6 +--
 net/bridge/br_netfilter_hooks.c            | 27 +++++------
 net/bridge/br_netfilter_ipv6.c             |  5 +-
 net/bridge/netfilter/ebtable_broute.c      |  9 ++--
 net/bridge/netfilter/ebtables.c            |  6 +--
 net/bridge/netfilter/nf_conntrack_bridge.c |  8 ++--
 net/ipv4/netfilter/arp_tables.c            |  7 ++-
 net/ipv4/netfilter/ip_tables.c             |  7 ++-
 net/ipv4/netfilter/ipt_CLUSTERIP.c         |  6 +--
 net/ipv4/netfilter/iptable_mangle.c        | 15 +++---
 net/ipv4/netfilter/nf_defrag_ipv4.c        |  5 +-
 net/ipv6/ila/ila_xlat.c                    |  6 +--
 net/ipv6/netfilter/ip6_tables.c            |  6 +--
 net/ipv6/netfilter/ip6table_mangle.c       | 13 +++--
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c  |  5 +-
 net/netfilter/core.c                       |  5 +-
 net/netfilter/ipvs/ip_vs_core.c            | 13 +++--
 net/netfilter/nf_conntrack_proto.c         | 34 +++++--------
 net/netfilter/nf_flow_table_inet.c         |  8 ++--
 net/netfilter/nf_flow_table_ip.c           | 12 ++---
 net/netfilter/nf_nat_core.c                | 10 ++--
 net/netfilter/nf_nat_proto.c               | 56 +++++++++++-----------
 net/netfilter/nf_synproxy_core.c           |  8 ++--
 net/netfilter/nft_chain_filter.c           | 48 +++++++++----------
 net/netfilter/nft_chain_nat.c              |  7 ++-
 net/netfilter/nft_chain_route.c            | 22 ++++-----
 security/apparmor/lsm.c                    |  5 +-
 security/selinux/hooks.c                   | 22 ++++-----
 security/smack/smack_netfilter.c           |  8 ++--
 37 files changed, 201 insertions(+), 228 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index 943d26cbf39f..a6af569fcc27 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -90,9 +90,9 @@ static const struct l3mdev_ops ipvl_l3mdev_ops = {
 	.l3mdev_l3_rcv = ipvlan_l3_rcv,
 };
 
-static unsigned int ipvlan_nf_input(void *priv, struct sk_buff *skb,
-				    const struct nf_hook_state *state)
+static unsigned int ipvlan_nf_input(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct ipvl_addr *addr;
 	unsigned int len;
 
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index ec416d79352e..7c604ef8e8cb 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -65,6 +65,8 @@ struct nf_hook_ops;
 struct sock;
 
 struct nf_hook_state {
+	struct sk_buff *skb;
+	void *priv;
 	u8 hook;
 	u8 pf;
 	u16 hook_index; /* index in hook_entries->hook[] */
@@ -75,9 +77,7 @@ struct nf_hook_state {
 	int (*okfn)(struct net *, struct sock *, struct sk_buff *);
 };
 
-typedef unsigned int nf_hookfn(void *priv,
-			       struct sk_buff *skb,
-			       const struct nf_hook_state *state);
+typedef unsigned int nf_hookfn(const struct nf_hook_state *state);
 enum nf_hook_ops_type {
 	NF_HOOK_OP_UNDEFINED,
 	NF_HOOK_OP_NF_TABLES,
@@ -140,7 +140,9 @@ static inline int
 nf_hook_entry_hookfn(const struct nf_hook_entry *entry, struct sk_buff *skb,
 		     struct nf_hook_state *state)
 {
-	return entry->hook(entry->priv, skb, state);
+	state->skb = skb;
+	state->priv = entry->priv;
+	return entry->hook(state);
 }
 
 static inline void nf_hook_state_init(struct nf_hook_state *p,
diff --git a/include/linux/netfilter_arp/arp_tables.h b/include/linux/netfilter_arp/arp_tables.h
index a40aaf645fa4..651462358ee1 100644
--- a/include/linux/netfilter_arp/arp_tables.h
+++ b/include/linux/netfilter_arp/arp_tables.h
@@ -54,8 +54,7 @@ int arpt_register_table(struct net *net, const struct xt_table *table,
 			const struct nf_hook_ops *ops);
 void arpt_unregister_table(struct net *net, const char *name);
 void arpt_unregister_table_pre_exit(struct net *net, const char *name);
-extern unsigned int arpt_do_table(void *priv, struct sk_buff *skb,
-				  const struct nf_hook_state *state);
+extern unsigned int arpt_do_table(const struct nf_hook_state *state);
 
 #ifdef CONFIG_NETFILTER_XTABLES_COMPAT
 #include <net/compat.h>
diff --git a/include/linux/netfilter_bridge/ebtables.h b/include/linux/netfilter_bridge/ebtables.h
index fd533552a062..3d664027e14f 100644
--- a/include/linux/netfilter_bridge/ebtables.h
+++ b/include/linux/netfilter_bridge/ebtables.h
@@ -108,8 +108,7 @@ extern int ebt_register_table(struct net *net,
 			      const struct nf_hook_ops *ops);
 extern void ebt_unregister_table(struct net *net, const char *tablename);
 void ebt_unregister_table_pre_exit(struct net *net, const char *tablename);
-extern unsigned int ebt_do_table(void *priv, struct sk_buff *skb,
-				 const struct nf_hook_state *state);
+extern unsigned int ebt_do_table(const struct nf_hook_state *state);
 
 /* True if the hook mask denotes that the rule is in a base chain,
  * used in the check() functions */
diff --git a/include/linux/netfilter_ipv4/ip_tables.h b/include/linux/netfilter_ipv4/ip_tables.h
index 132b0e4a6d4d..270963c73245 100644
--- a/include/linux/netfilter_ipv4/ip_tables.h
+++ b/include/linux/netfilter_ipv4/ip_tables.h
@@ -63,9 +63,7 @@ struct ipt_error {
 }
 
 extern void *ipt_alloc_initial_table(const struct xt_table *);
-extern unsigned int ipt_do_table(void *priv,
-				 struct sk_buff *skb,
-				 const struct nf_hook_state *state);
+extern unsigned int ipt_do_table(const struct nf_hook_state *state);
 
 #ifdef CONFIG_NETFILTER_XTABLES_COMPAT
 #include <net/compat.h>
diff --git a/include/linux/netfilter_ipv6/ip6_tables.h b/include/linux/netfilter_ipv6/ip6_tables.h
index 8b8885a73c76..f786fb7ef47f 100644
--- a/include/linux/netfilter_ipv6/ip6_tables.h
+++ b/include/linux/netfilter_ipv6/ip6_tables.h
@@ -29,8 +29,7 @@ int ip6t_register_table(struct net *net, const struct xt_table *table,
 			const struct nf_hook_ops *ops);
 void ip6t_unregister_table_pre_exit(struct net *net, const char *name);
 void ip6t_unregister_table_exit(struct net *net, const char *name);
-extern unsigned int ip6t_do_table(void *priv, struct sk_buff *skb,
-				  const struct nf_hook_state *state);
+extern unsigned int ip6t_do_table(const struct nf_hook_state *state);
 
 #ifdef CONFIG_NETFILTER_XTABLES_COMPAT
 #include <net/compat.h>
diff --git a/include/net/netfilter/br_netfilter.h b/include/net/netfilter/br_netfilter.h
index 371696ec11b2..9c37bf316077 100644
--- a/include/net/netfilter/br_netfilter.h
+++ b/include/net/netfilter/br_netfilter.h
@@ -57,9 +57,7 @@ struct net_device *setup_pre_routing(struct sk_buff *skb,
 
 #if IS_ENABLED(CONFIG_IPV6)
 int br_validate_ipv6(struct net *net, struct sk_buff *skb);
-unsigned int br_nf_pre_routing_ipv6(void *priv,
-				    struct sk_buff *skb,
-				    const struct nf_hook_state *state);
+unsigned int br_nf_pre_routing_ipv6(const struct nf_hook_state *state);
 #else
 static inline int br_validate_ipv6(struct net *net, struct sk_buff *skb)
 {
@@ -67,8 +65,7 @@ static inline int br_validate_ipv6(struct net *net, struct sk_buff *skb)
 }
 
 static inline unsigned int
-br_nf_pre_routing_ipv6(void *priv, struct sk_buff *skb,
-		       const struct nf_hook_state *state)
+br_nf_pre_routing_ipv6(const struct nf_hook_state *state)
 {
 	return NF_ACCEPT;
 }
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index cd982f4a0f50..fc86c2573c3c 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -291,10 +291,8 @@ struct flow_ports {
 	__be16 source, dest;
 };
 
-unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
-				     const struct nf_hook_state *state);
-unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
-				       const struct nf_hook_state *state);
+unsigned int nf_flow_offload_ip_hook(const struct nf_hook_state *state);
+unsigned int nf_flow_offload_ipv6_hook(const struct nf_hook_state *state);
 
 #define MODULE_ALIAS_NF_FLOWTABLE(family)	\
 	MODULE_ALIAS("nf-flowtable-" __stringify(family))
diff --git a/include/net/netfilter/nf_synproxy.h b/include/net/netfilter/nf_synproxy.h
index a336f9434e73..9cf8db712e88 100644
--- a/include/net/netfilter/nf_synproxy.h
+++ b/include/net/netfilter/nf_synproxy.h
@@ -60,8 +60,7 @@ bool synproxy_recv_client_ack(struct net *net,
 
 struct nf_hook_state;
 
-unsigned int ipv4_synproxy_hook(void *priv, struct sk_buff *skb,
-				const struct nf_hook_state *nhs);
+unsigned int ipv4_synproxy_hook(const struct nf_hook_state *nhs);
 int nf_synproxy_ipv4_init(struct synproxy_net *snet, struct net *net);
 void nf_synproxy_ipv4_fini(struct synproxy_net *snet, struct net *net);
 
@@ -75,8 +74,7 @@ bool synproxy_recv_client_ack_ipv6(struct net *net, const struct sk_buff *skb,
 				   const struct tcphdr *th,
 				   struct synproxy_options *opts, u32 recv_seq);
 
-unsigned int ipv6_synproxy_hook(void *priv, struct sk_buff *skb,
-				const struct nf_hook_state *nhs);
+unsigned int ipv6_synproxy_hook(const struct nf_hook_state *nhs);
 int nf_synproxy_ipv6_init(struct synproxy_net *snet, struct net *net);
 void nf_synproxy_ipv6_fini(struct synproxy_net *snet, struct net *net);
 #else
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index cc4b5a19ca31..f42faf572c21 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -474,10 +474,9 @@ struct net_device *setup_pre_routing(struct sk_buff *skb, const struct net *net)
  * receiving device) to make netfilter happy, the REDIRECT
  * target in particular.  Save the original destination IP
  * address to be able to detect DNAT afterwards. */
-static unsigned int br_nf_pre_routing(void *priv,
-				      struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int br_nf_pre_routing(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nf_bridge_info *nf_bridge;
 	struct net_bridge_port *p;
 	struct net_bridge *br;
@@ -504,7 +503,7 @@ static unsigned int br_nf_pre_routing(void *priv,
 		}
 
 		nf_bridge_pull_encap_header_rcsum(skb);
-		return br_nf_pre_routing_ipv6(priv, skb, state);
+		return br_nf_pre_routing_ipv6(state);
 	}
 
 	if (!brnet->call_iptables && !br_opt_get(br, BROPT_NF_CALL_IPTABLES))
@@ -574,10 +573,9 @@ static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff
  * but we are still able to filter on the 'real' indev/outdev
  * because of the physdev module. For ARP, indev and outdev are the
  * bridge ports. */
-static unsigned int br_nf_forward_ip(void *priv,
-				     struct sk_buff *skb,
-				     const struct nf_hook_state *state)
+static unsigned int br_nf_forward_ip(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nf_bridge_info *nf_bridge;
 	struct net_device *parent;
 	u_int8_t pf;
@@ -640,10 +638,9 @@ static unsigned int br_nf_forward_ip(void *priv,
 	return NF_STOLEN;
 }
 
-static unsigned int br_nf_forward_arp(void *priv,
-				      struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int br_nf_forward_arp(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct net_bridge_port *p;
 	struct net_bridge *br;
 	struct net_device **d = (struct net_device **)(skb->cb);
@@ -813,10 +810,9 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 }
 
 /* PF_BRIDGE/POST_ROUTING ********************************************/
-static unsigned int br_nf_post_routing(void *priv,
-				       struct sk_buff *skb,
-				       const struct nf_hook_state *state)
+static unsigned int br_nf_post_routing(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct net_device *realoutdev = bridge_parent(skb->dev);
 	u_int8_t pf;
@@ -862,10 +858,9 @@ static unsigned int br_nf_post_routing(void *priv,
 /* IP/SABOTAGE *****************************************************/
 /* Don't hand locally destined packets to PF_INET(6)/PRE_ROUTING
  * for the second time. */
-static unsigned int ip_sabotage_in(void *priv,
-				   struct sk_buff *skb,
-				   const struct nf_hook_state *state)
+static unsigned int ip_sabotage_in(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 
 	if (nf_bridge && !nf_bridge->in_prerouting &&
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index 6b07f30675bb..87e5c7f60ae2 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -213,11 +213,10 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 /* Replicate the checks that IPv6 does on packet reception and pass the packet
  * to ip6tables.
  */
-unsigned int br_nf_pre_routing_ipv6(void *priv,
-				    struct sk_buff *skb,
-				    const struct nf_hook_state *state)
+unsigned int br_nf_pre_routing_ipv6(const struct nf_hook_state *state)
 {
 	struct nf_bridge_info *nf_bridge;
+	struct sk_buff *skb = state->skb;
 
 	if (br_validate_ipv6(state->net, skb))
 		return NF_DROP;
diff --git a/net/bridge/netfilter/ebtable_broute.c b/net/bridge/netfilter/ebtable_broute.c
index 8f19253024b0..e98791176341 100644
--- a/net/bridge/netfilter/ebtable_broute.c
+++ b/net/bridge/netfilter/ebtable_broute.c
@@ -43,9 +43,9 @@ static const struct ebt_table broute_table = {
 	.me		= THIS_MODULE,
 };
 
-static unsigned int ebt_broute(void *priv, struct sk_buff *skb,
-			       const struct nf_hook_state *s)
+static unsigned int ebt_broute(const struct nf_hook_state *s)
 {
+	struct sk_buff *skb = s->skb;
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
 	struct nf_hook_state state;
 	unsigned char *dest;
@@ -58,7 +58,10 @@ static unsigned int ebt_broute(void *priv, struct sk_buff *skb,
 			   NFPROTO_BRIDGE, s->in, NULL, NULL,
 			   s->net, NULL);
 
-	ret = ebt_do_table(priv, skb, &state);
+	state.skb = skb;
+	state.priv = s->priv;
+
+	ret = ebt_do_table(&state);
 	if (ret != NF_DROP)
 		return ret;
 
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index ce5dfa3babd2..8e99e72e90e9 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -189,10 +189,10 @@ ebt_get_target_c(const struct ebt_entry *e)
 }
 
 /* Do some firewalling */
-unsigned int ebt_do_table(void *priv, struct sk_buff *skb,
-			  const struct nf_hook_state *state)
+unsigned int ebt_do_table(const struct nf_hook_state *state)
 {
-	struct ebt_table *table = priv;
+	struct ebt_table *table = state->priv;
+	struct sk_buff *skb = state->skb;
 	unsigned int hook = state->hook;
 	int i, nentries;
 	struct ebt_entry *point;
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 73242962be5d..b0a9187cd399 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -237,10 +237,10 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	return 0;
 }
 
-static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
-				     const struct nf_hook_state *state)
+static unsigned int nf_ct_bridge_pre(const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	struct sk_buff *skb = state->skb;
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
 	u32 len;
@@ -396,9 +396,9 @@ static unsigned int nf_ct_bridge_confirm(struct sk_buff *skb)
 	return nf_confirm(skb, protoff, ct, ctinfo);
 }
 
-static unsigned int nf_ct_bridge_post(void *priv, struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int nf_ct_bridge_post(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	int ret;
 
 	ret = nf_ct_bridge_confirm(skb);
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index ffc0cab7cf18..b870773590ba 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -179,11 +179,10 @@ struct arpt_entry *arpt_next_entry(const struct arpt_entry *entry)
 	return (void *)entry + entry->next_offset;
 }
 
-unsigned int arpt_do_table(void *priv,
-			   struct sk_buff *skb,
-			   const struct nf_hook_state *state)
+unsigned int arpt_do_table(const struct nf_hook_state *state)
 {
-	const struct xt_table *table = priv;
+	const struct xt_table *table = state->priv;
+	struct sk_buff *skb = state->skb;
 	unsigned int hook = state->hook;
 	static const char nulldevname[IFNAMSIZ] __attribute__((aligned(sizeof(long))));
 	unsigned int verdict = NF_DROP;
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 2ed7c58b471a..c49d3e324f99 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -222,11 +222,10 @@ struct ipt_entry *ipt_next_entry(const struct ipt_entry *entry)
 
 /* Returns one of the generic firewall policies, like NF_ACCEPT. */
 unsigned int
-ipt_do_table(void *priv,
-	     struct sk_buff *skb,
-	     const struct nf_hook_state *state)
+ipt_do_table(const struct nf_hook_state *state)
 {
-	const struct xt_table *table = priv;
+	const struct xt_table *table = state->priv;
+	struct sk_buff *skb = state->skb;
 	unsigned int hook = state->hook;
 	static const char nulldevname[IFNAMSIZ] __attribute__((aligned(sizeof(long))));
 	const struct iphdr *ip;
diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index f8e176c77d1c..60ea95739a35 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -75,7 +75,7 @@ struct clusterip_net {
 	unsigned int hook_users;
 };
 
-static unsigned int clusterip_arp_mangle(void *priv, struct sk_buff *skb, const struct nf_hook_state *state);
+static unsigned int clusterip_arp_mangle(const struct nf_hook_state *state);
 
 static const struct nf_hook_ops cip_arp_ops = {
 	.hook = clusterip_arp_mangle,
@@ -638,9 +638,9 @@ static void arp_print(struct arp_payload *payload)
 #endif
 
 static unsigned int
-clusterip_arp_mangle(void *priv, struct sk_buff *skb,
-		     const struct nf_hook_state *state)
+clusterip_arp_mangle(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct arphdr *arp = arp_hdr(skb);
 	struct arp_payload *payload;
 	struct clusterip_config *c;
diff --git a/net/ipv4/netfilter/iptable_mangle.c b/net/ipv4/netfilter/iptable_mangle.c
index 3abb430af9e6..dca4637ad844 100644
--- a/net/ipv4/netfilter/iptable_mangle.c
+++ b/net/ipv4/netfilter/iptable_mangle.c
@@ -33,9 +33,9 @@ static const struct xt_table packet_mangler = {
 	.priority	= NF_IP_PRI_MANGLE,
 };
 
-static unsigned int
-ipt_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
+static unsigned int ipt_mangle_out(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	unsigned int ret;
 	const struct iphdr *iph;
 	u_int8_t tos;
@@ -50,7 +50,7 @@ ipt_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *stat
 	daddr = iph->daddr;
 	tos = iph->tos;
 
-	ret = ipt_do_table(priv, skb, state);
+	ret = ipt_do_table(state);
 	/* Reroute for ANY change. */
 	if (ret != NF_DROP && ret != NF_STOLEN) {
 		iph = ip_hdr(skb);
@@ -69,14 +69,11 @@ ipt_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *stat
 }
 
 /* The work comes in here from netfilter.c. */
-static unsigned int
-iptable_mangle_hook(void *priv,
-		     struct sk_buff *skb,
-		     const struct nf_hook_state *state)
+static unsigned int iptable_mangle_hook(const struct nf_hook_state *state)
 {
 	if (state->hook == NF_INET_LOCAL_OUT)
-		return ipt_mangle_out(priv, skb, state);
-	return ipt_do_table(priv, skb, state);
+		return ipt_mangle_out(state);
+	return ipt_do_table(state);
 }
 
 static struct nf_hook_ops *mangle_ops __read_mostly;
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index e61ea428ea18..8fda6f06fe2b 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -58,10 +58,9 @@ static enum ip_defrag_users nf_ct_defrag_user(unsigned int hooknum,
 		return IP_DEFRAG_CONNTRACK_OUT + zone_id;
 }
 
-static unsigned int ipv4_conntrack_defrag(void *priv,
-					  struct sk_buff *skb,
-					  const struct nf_hook_state *state)
+static unsigned int ipv4_conntrack_defrag(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct sock *sk = skb->sk;
 
 	if (sk && sk_fullsock(sk) && (sk->sk_family == PF_INET) &&
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 47447f0241df..94d21bbed412 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -184,10 +184,10 @@ static void ila_free_cb(void *ptr, void *arg)
 static int ila_xlat_addr(struct sk_buff *skb, bool sir2ila);
 
 static unsigned int
-ila_nf_input(void *priv,
-	     struct sk_buff *skb,
-	     const struct nf_hook_state *state)
+ila_nf_input(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
+
 	ila_xlat_addr(skb, false);
 	return NF_ACCEPT;
 }
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 2d816277f2c5..4da1d61b9b42 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -247,10 +247,10 @@ ip6t_next_entry(const struct ip6t_entry *entry)
 
 /* Returns one of the generic firewall policies, like NF_ACCEPT. */
 unsigned int
-ip6t_do_table(void *priv, struct sk_buff *skb,
-	      const struct nf_hook_state *state)
+ip6t_do_table(const struct nf_hook_state *state)
 {
-	const struct xt_table *table = priv;
+	const struct xt_table *table = state->priv;
+	struct sk_buff *skb = state->skb;
 	unsigned int hook = state->hook;
 	static const char nulldevname[IFNAMSIZ] __attribute__((aligned(sizeof(long))));
 	/* Initializing verdict to NF_DROP keeps gcc happy. */
diff --git a/net/ipv6/netfilter/ip6table_mangle.c b/net/ipv6/netfilter/ip6table_mangle.c
index a88b2ce4a3cb..33b0e3ab3399 100644
--- a/net/ipv6/netfilter/ip6table_mangle.c
+++ b/net/ipv6/netfilter/ip6table_mangle.c
@@ -28,9 +28,9 @@ static const struct xt_table packet_mangler = {
 	.priority	= NF_IP6_PRI_MANGLE,
 };
 
-static unsigned int
-ip6t_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
+static unsigned int ip6t_mangle_out(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	unsigned int ret;
 	struct in6_addr saddr, daddr;
 	u_int8_t hop_limit;
@@ -46,7 +46,7 @@ ip6t_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *sta
 	/* flowlabel and prio (includes version, which shouldn't change either */
 	flowlabel = *((u_int32_t *)ipv6_hdr(skb));
 
-	ret = ip6t_do_table(priv, skb, state);
+	ret = ip6t_do_table(state);
 
 	if (ret != NF_DROP && ret != NF_STOLEN &&
 	    (!ipv6_addr_equal(&ipv6_hdr(skb)->saddr, &saddr) ||
@@ -64,12 +64,11 @@ ip6t_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *sta
 
 /* The work comes in here from netfilter.c. */
 static unsigned int
-ip6table_mangle_hook(void *priv, struct sk_buff *skb,
-		     const struct nf_hook_state *state)
+ip6table_mangle_hook(const struct nf_hook_state *state)
 {
 	if (state->hook == NF_INET_LOCAL_OUT)
-		return ip6t_mangle_out(priv, skb, state);
-	return ip6t_do_table(priv, skb, state);
+		return ip6t_mangle_out(state);
+	return ip6t_do_table(state);
 }
 
 static struct nf_hook_ops *mangle_ops __read_mostly;
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index cb4eb1d2c620..25aae7deb7cc 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -48,10 +48,9 @@ static enum ip6_defrag_users nf_ct6_defrag_user(unsigned int hooknum,
 		return IP6_DEFRAG_CONNTRACK_OUT + zone_id;
 }
 
-static unsigned int ipv6_defrag(void *priv,
-				struct sk_buff *skb,
-				const struct nf_hook_state *state)
+static unsigned int ipv6_defrag(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	int err;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index a8176351f120..593fec9434d7 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -88,9 +88,7 @@ static void nf_hook_entries_free(struct nf_hook_entries *e)
 	call_rcu(&head->head, __nf_hook_entries_free);
 }
 
-static unsigned int accept_all(void *priv,
-			       struct sk_buff *skb,
-			       const struct nf_hook_state *state)
+static unsigned int accept_all(const struct nf_hook_state *state)
 {
 	return NF_ACCEPT; /* ACCEPT makes nf_hook_slow call next hook */
 }
@@ -610,6 +608,7 @@ int nf_hook_slow(struct sk_buff *skb, struct nf_hook_state *state,
 	unsigned int verdict, s = state->hook_index;
 	int ret;
 
+	state->skb = skb;
 	for (; s < e->num_hook_entries; s++) {
 		verdict = nf_hook_entry_hookfn(&e->hooks[s], skb, state);
 		switch (verdict & NF_VERDICT_MASK) {
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 51ad557a525b..8c36e2aa7f82 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1330,10 +1330,11 @@ handle_response(int af, struct sk_buff *skb, struct ip_vs_proto_data *pd,
  *	Check if outgoing packet belongs to the established ip_vs_conn.
  */
 static unsigned int
-ip_vs_out_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
+ip_vs_out_hook(const struct nf_hook_state *state)
 {
 	struct netns_ipvs *ipvs = net_ipvs(state->net);
 	unsigned int hooknum = state->hook;
+	struct sk_buff *skb = state->skb;
 	struct ip_vs_iphdr iph;
 	struct ip_vs_protocol *pp;
 	struct ip_vs_proto_data *pd;
@@ -1910,10 +1911,11 @@ static int ip_vs_in_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
  *	and send it on its way...
  */
 static unsigned int
-ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
+ip_vs_in_hook(const struct nf_hook_state *state)
 {
 	struct netns_ipvs *ipvs = net_ipvs(state->net);
 	unsigned int hooknum = state->hook;
+	struct sk_buff *skb = state->skb;
 	struct ip_vs_iphdr iph;
 	struct ip_vs_protocol *pp;
 	struct ip_vs_proto_data *pd;
@@ -2103,12 +2105,15 @@ ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state
  *      and send them to ip_vs_in_icmp.
  */
 static unsigned int
-ip_vs_forward_icmp(void *priv, struct sk_buff *skb,
-		   const struct nf_hook_state *state)
+ip_vs_forward_icmp(const struct nf_hook_state *state)
 {
 	struct netns_ipvs *ipvs = net_ipvs(state->net);
+	struct sk_buff *skb = state->skb;
 	int r;
 
+	if (ip_hdr(skb)->protocol != IPPROTO_ICMP)
+		return NF_ACCEPT;
+
 	/* ipvs enabled in this netns ? */
 	if (unlikely(sysctl_backup_only(ipvs) || !ipvs->enable))
 		return NF_ACCEPT;
diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index 895b09cbd7cf..95e2f5a87dc3 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -165,10 +165,9 @@ static bool in_vrf_postrouting(const struct nf_hook_state *state)
 	return false;
 }
 
-static unsigned int ipv4_confirm(void *priv,
-				 struct sk_buff *skb,
-				 const struct nf_hook_state *state)
+static unsigned int ipv4_confirm(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
 
@@ -184,17 +183,15 @@ static unsigned int ipv4_confirm(void *priv,
 			  ct, ctinfo);
 }
 
-static unsigned int ipv4_conntrack_in(void *priv,
-				      struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int ipv4_conntrack_in(const struct nf_hook_state *state)
 {
-	return nf_conntrack_in(skb, state);
+	return nf_conntrack_in(state->skb, state);
 }
 
-static unsigned int ipv4_conntrack_local(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
+static unsigned int ipv4_conntrack_local(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
+
 	if (ip_is_fragment(ip_hdr(skb))) { /* IP_NODEFRAG setsockopt set */
 		enum ip_conntrack_info ctinfo;
 		struct nf_conn *tmpl;
@@ -373,10 +370,9 @@ static struct nf_sockopt_ops so_getorigdst6 = {
 	.owner		= THIS_MODULE,
 };
 
-static unsigned int ipv6_confirm(void *priv,
-				 struct sk_buff *skb,
-				 const struct nf_hook_state *state)
+static unsigned int ipv6_confirm(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nf_conn *ct;
 	enum ip_conntrack_info ctinfo;
 	unsigned char pnum = ipv6_hdr(skb)->nexthdr;
@@ -400,18 +396,14 @@ static unsigned int ipv6_confirm(void *priv,
 	return nf_confirm(skb, protoff, ct, ctinfo);
 }
 
-static unsigned int ipv6_conntrack_in(void *priv,
-				      struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int ipv6_conntrack_in(const struct nf_hook_state *state)
 {
-	return nf_conntrack_in(skb, state);
+	return nf_conntrack_in(state->skb, state);
 }
 
-static unsigned int ipv6_conntrack_local(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
+static unsigned int ipv6_conntrack_local(const struct nf_hook_state *state)
 {
-	return nf_conntrack_in(skb, state);
+	return nf_conntrack_in(state->skb, state);
 }
 
 static const struct nf_hook_ops ipv6_conntrack_ops[] = {
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 0ccabf3fa6aa..315db69f4ca8 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -9,9 +9,9 @@
 #include <linux/if_vlan.h>
 
 static unsigned int
-nf_flow_offload_inet_hook(void *priv, struct sk_buff *skb,
-			  const struct nf_hook_state *state)
+nf_flow_offload_inet_hook(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct vlan_ethhdr *veth;
 	__be16 proto;
 
@@ -30,9 +30,9 @@ nf_flow_offload_inet_hook(void *priv, struct sk_buff *skb,
 
 	switch (proto) {
 	case htons(ETH_P_IP):
-		return nf_flow_offload_ip_hook(priv, skb, state);
+		return nf_flow_offload_ip_hook(state);
 	case htons(ETH_P_IPV6):
-		return nf_flow_offload_ipv6_hook(priv, skb, state);
+		return nf_flow_offload_ipv6_hook(state);
 	}
 
 	return NF_ACCEPT;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index b350fe9d00b0..98c7e7272ab4 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -337,12 +337,12 @@ static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 }
 
 unsigned int
-nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
-			const struct nf_hook_state *state)
+nf_flow_offload_ip_hook(const struct nf_hook_state *state)
 {
+	struct nf_flowtable *flow_table = state->priv;
 	struct flow_offload_tuple_rhash *tuplehash;
-	struct nf_flowtable *flow_table = priv;
 	struct flow_offload_tuple tuple = {};
+	struct sk_buff *skb = state->skb;
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
 	struct net_device *outdev;
@@ -599,12 +599,12 @@ static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 }
 
 unsigned int
-nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
-			  const struct nf_hook_state *state)
+nf_flow_offload_ipv6_hook(const struct nf_hook_state *state)
 {
+	struct nf_flowtable *flow_table = state->priv;
 	struct flow_offload_tuple_rhash *tuplehash;
-	struct nf_flowtable *flow_table = priv;
 	struct flow_offload_tuple tuple = {};
+	struct sk_buff *skb = state->skb;
 	enum flow_offload_tuple_dir dir;
 	const struct in6_addr *nexthop;
 	struct flow_offload *flow;
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index bd5ac4ff03f9..71d860b049c2 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -710,20 +710,24 @@ static bool in_vrf_postrouting(const struct nf_hook_state *state)
 }
 
 static unsigned int nf_nat_inet_run_hooks(const struct nf_hook_state *state,
-					  struct sk_buff *skb,
 					  struct nf_conn *ct,
 					  struct nf_nat_lookup_hook_priv *lpriv)
 {
 	enum nf_nat_manip_type maniptype = HOOK2MANIP(state->hook);
 	struct nf_hook_entries *e = rcu_dereference(lpriv->entries);
+	struct nf_hook_state __state;
 	unsigned int ret;
 	int i;
 
 	if (!e)
 		goto null_bind;
 
+	__state = *state;
+
 	for (i = 0; i < e->num_hook_entries; i++) {
-		ret = e->hooks[i].hook(e->hooks[i].priv, skb, state);
+		__state.priv = e->hooks[i].priv;
+
+		ret = e->hooks[i].hook(&__state);
 		if (ret != NF_ACCEPT)
 			return ret;
 
@@ -768,7 +772,7 @@ nf_nat_inet_fn(void *priv, struct sk_buff *skb,
 			struct nf_nat_lookup_hook_priv *lpriv = priv;
 			unsigned int ret;
 
-			ret = nf_nat_inet_run_hooks(state, skb, ct, lpriv);
+			ret = nf_nat_inet_run_hooks(state, ct, lpriv);
 			if (ret != NF_ACCEPT)
 				return ret;
 		} else {
diff --git a/net/netfilter/nf_nat_proto.c b/net/netfilter/nf_nat_proto.c
index 48cc60084d28..9d1d6a20ae1e 100644
--- a/net/netfilter/nf_nat_proto.c
+++ b/net/netfilter/nf_nat_proto.c
@@ -622,11 +622,12 @@ int nf_nat_icmp_reply_translation(struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(nf_nat_icmp_reply_translation);
 
 static unsigned int
-nf_nat_ipv4_fn(void *priv, struct sk_buff *skb,
-	       const struct nf_hook_state *state)
+nf_nat_ipv4_fn(const struct nf_hook_state *state)
 {
-	struct nf_conn *ct;
+	struct sk_buff *skb = state->skb;
+	void *priv = state->priv;
 	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (!ct)
@@ -646,13 +647,13 @@ nf_nat_ipv4_fn(void *priv, struct sk_buff *skb,
 }
 
 static unsigned int
-nf_nat_ipv4_pre_routing(void *priv, struct sk_buff *skb,
-			const struct nf_hook_state *state)
+nf_nat_ipv4_pre_routing(const struct nf_hook_state *state)
 {
-	unsigned int ret;
+	struct sk_buff *skb = state->skb;
 	__be32 daddr = ip_hdr(skb)->daddr;
+	unsigned int ret;
 
-	ret = nf_nat_ipv4_fn(priv, skb, state);
+	ret = nf_nat_ipv4_fn(state);
 	if (ret == NF_ACCEPT && daddr != ip_hdr(skb)->daddr)
 		skb_dst_drop(skb);
 
@@ -698,14 +699,14 @@ static int nf_xfrm_me_harder(struct net *net, struct sk_buff *skb, unsigned int
 #endif
 
 static unsigned int
-nf_nat_ipv4_local_in(void *priv, struct sk_buff *skb,
-		     const struct nf_hook_state *state)
+nf_nat_ipv4_local_in(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	__be32 saddr = ip_hdr(skb)->saddr;
 	struct sock *sk = skb->sk;
 	unsigned int ret;
 
-	ret = nf_nat_ipv4_fn(priv, skb, state);
+	ret = nf_nat_ipv4_fn(state);
 
 	if (ret == NF_ACCEPT && sk && saddr != ip_hdr(skb)->saddr &&
 	    !inet_sk_transparent(sk))
@@ -715,17 +716,17 @@ nf_nat_ipv4_local_in(void *priv, struct sk_buff *skb,
 }
 
 static unsigned int
-nf_nat_ipv4_out(void *priv, struct sk_buff *skb,
-		const struct nf_hook_state *state)
+nf_nat_ipv4_out(const struct nf_hook_state *state)
 {
 #ifdef CONFIG_XFRM
+	struct sk_buff *skb = state->skb;
 	const struct nf_conn *ct;
 	enum ip_conntrack_info ctinfo;
 	int err;
 #endif
 	unsigned int ret;
 
-	ret = nf_nat_ipv4_fn(priv, skb, state);
+	ret = nf_nat_ipv4_fn(state);
 #ifdef CONFIG_XFRM
 	if (ret != NF_ACCEPT)
 		return ret;
@@ -752,15 +753,15 @@ nf_nat_ipv4_out(void *priv, struct sk_buff *skb,
 }
 
 static unsigned int
-nf_nat_ipv4_local_fn(void *priv, struct sk_buff *skb,
-		     const struct nf_hook_state *state)
+nf_nat_ipv4_local_fn(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	const struct nf_conn *ct;
 	enum ip_conntrack_info ctinfo;
 	unsigned int ret;
 	int err;
 
-	ret = nf_nat_ipv4_fn(priv, skb, state);
+	ret = nf_nat_ipv4_fn(state);
 	if (ret != NF_ACCEPT)
 		return ret;
 
@@ -901,9 +902,10 @@ int nf_nat_icmpv6_reply_translation(struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(nf_nat_icmpv6_reply_translation);
 
 static unsigned int
-nf_nat_ipv6_fn(void *priv, struct sk_buff *skb,
-	       const struct nf_hook_state *state)
+nf_nat_ipv6_fn(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
+	void *priv = state->priv;
 	struct nf_conn *ct;
 	enum ip_conntrack_info ctinfo;
 	__be16 frag_off;
@@ -938,13 +940,13 @@ nf_nat_ipv6_fn(void *priv, struct sk_buff *skb,
 }
 
 static unsigned int
-nf_nat_ipv6_in(void *priv, struct sk_buff *skb,
-	       const struct nf_hook_state *state)
+nf_nat_ipv6_in(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	unsigned int ret;
 	struct in6_addr daddr = ipv6_hdr(skb)->daddr;
 
-	ret = nf_nat_ipv6_fn(priv, skb, state);
+	ret = nf_nat_ipv6_fn(state);
 	if (ret != NF_DROP && ret != NF_STOLEN &&
 	    ipv6_addr_cmp(&daddr, &ipv6_hdr(skb)->daddr))
 		skb_dst_drop(skb);
@@ -953,17 +955,17 @@ nf_nat_ipv6_in(void *priv, struct sk_buff *skb,
 }
 
 static unsigned int
-nf_nat_ipv6_out(void *priv, struct sk_buff *skb,
-		const struct nf_hook_state *state)
+nf_nat_ipv6_out(const struct nf_hook_state *state)
 {
 #ifdef CONFIG_XFRM
+	struct sk_buff *skb = state->skb;
 	const struct nf_conn *ct;
 	enum ip_conntrack_info ctinfo;
 	int err;
 #endif
 	unsigned int ret;
 
-	ret = nf_nat_ipv6_fn(priv, skb, state);
+	ret = nf_nat_ipv6_fn(state);
 #ifdef CONFIG_XFRM
 	if (ret != NF_ACCEPT)
 		return ret;
@@ -990,15 +992,15 @@ nf_nat_ipv6_out(void *priv, struct sk_buff *skb,
 }
 
 static unsigned int
-nf_nat_ipv6_local_fn(void *priv, struct sk_buff *skb,
-		     const struct nf_hook_state *state)
+nf_nat_ipv6_local_fn(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	const struct nf_conn *ct;
 	enum ip_conntrack_info ctinfo;
 	unsigned int ret;
 	int err;
 
-	ret = nf_nat_ipv6_fn(priv, skb, state);
+	ret = nf_nat_ipv6_fn(state);
 	if (ret != NF_ACCEPT)
 		return ret;
 
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 16915f8eef2b..d7bcfd4072c7 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -636,10 +636,10 @@ synproxy_recv_client_ack(struct net *net,
 EXPORT_SYMBOL_GPL(synproxy_recv_client_ack);
 
 unsigned int
-ipv4_synproxy_hook(void *priv, struct sk_buff *skb,
-		   const struct nf_hook_state *nhs)
+ipv4_synproxy_hook(const struct nf_hook_state *nhs)
 {
 	struct net *net = nhs->net;
+	struct sk_buff *skb = nhs->skb;
 	struct synproxy_net *snet = synproxy_pernet(net);
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
@@ -1053,9 +1053,9 @@ synproxy_recv_client_ack_ipv6(struct net *net,
 EXPORT_SYMBOL_GPL(synproxy_recv_client_ack_ipv6);
 
 unsigned int
-ipv6_synproxy_hook(void *priv, struct sk_buff *skb,
-		   const struct nf_hook_state *nhs)
+ipv6_synproxy_hook(const struct nf_hook_state *nhs)
 {
+	struct sk_buff *skb = nhs->skb;
 	struct net *net = nhs->net;
 	struct synproxy_net *snet = synproxy_pernet(net);
 	enum ip_conntrack_info ctinfo;
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index c3563f0be269..f451c081958a 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -11,16 +11,15 @@
 #include <net/netfilter/nf_tables_ipv6.h>
 
 #ifdef CONFIG_NF_TABLES_IPV4
-static unsigned int nft_do_chain_ipv4(void *priv,
-				      struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int nft_do_chain_ipv4(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nft_pktinfo pkt;
 
 	nft_set_pktinfo(&pkt, skb, state);
 	nft_set_pktinfo_ipv4(&pkt);
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
 static const struct nft_chain_type nft_chain_filter_ipv4 = {
@@ -56,15 +55,15 @@ static inline void nft_chain_filter_ipv4_fini(void) {}
 #endif /* CONFIG_NF_TABLES_IPV4 */
 
 #ifdef CONFIG_NF_TABLES_ARP
-static unsigned int nft_do_chain_arp(void *priv, struct sk_buff *skb,
-				     const struct nf_hook_state *state)
+static unsigned int nft_do_chain_arp(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nft_pktinfo pkt;
 
 	nft_set_pktinfo(&pkt, skb, state);
 	nft_set_pktinfo_unspec(&pkt);
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
 static const struct nft_chain_type nft_chain_filter_arp = {
@@ -95,16 +94,15 @@ static inline void nft_chain_filter_arp_fini(void) {}
 #endif /* CONFIG_NF_TABLES_ARP */
 
 #ifdef CONFIG_NF_TABLES_IPV6
-static unsigned int nft_do_chain_ipv6(void *priv,
-				      struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int nft_do_chain_ipv6(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nft_pktinfo pkt;
 
 	nft_set_pktinfo(&pkt, skb, state);
 	nft_set_pktinfo_ipv6(&pkt);
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
 static const struct nft_chain_type nft_chain_filter_ipv6 = {
@@ -140,9 +138,9 @@ static inline void nft_chain_filter_ipv6_fini(void) {}
 #endif /* CONFIG_NF_TABLES_IPV6 */
 
 #ifdef CONFIG_NF_TABLES_INET
-static unsigned int nft_do_chain_inet(void *priv, struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int nft_do_chain_inet(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nft_pktinfo pkt;
 
 	nft_set_pktinfo(&pkt, skb, state);
@@ -158,13 +156,13 @@ static unsigned int nft_do_chain_inet(void *priv, struct sk_buff *skb,
 		break;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
-static unsigned int nft_do_chain_inet_ingress(void *priv, struct sk_buff *skb,
-					      const struct nf_hook_state *state)
+static unsigned int nft_do_chain_inet_ingress(const struct nf_hook_state *state)
 {
 	struct nf_hook_state ingress_state = *state;
+	struct sk_buff *skb = state->skb;
 	struct nft_pktinfo pkt;
 
 	switch (skb->protocol) {
@@ -189,7 +187,7 @@ static unsigned int nft_do_chain_inet_ingress(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
 static const struct nft_chain_type nft_chain_filter_inet = {
@@ -228,10 +226,9 @@ static inline void nft_chain_filter_inet_fini(void) {}
 
 #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
 static unsigned int
-nft_do_chain_bridge(void *priv,
-		    struct sk_buff *skb,
-		    const struct nf_hook_state *state)
+nft_do_chain_bridge(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct nft_pktinfo pkt;
 
 	nft_set_pktinfo(&pkt, skb, state);
@@ -248,7 +245,7 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
 static const struct nft_chain_type nft_chain_filter_bridge = {
@@ -284,14 +281,13 @@ static inline void nft_chain_filter_bridge_fini(void) {}
 #endif /* CONFIG_NF_TABLES_BRIDGE */
 
 #ifdef CONFIG_NF_TABLES_NETDEV
-static unsigned int nft_do_chain_netdev(void *priv, struct sk_buff *skb,
-					const struct nf_hook_state *state)
+static unsigned int nft_do_chain_netdev(const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
 
-	nft_set_pktinfo(&pkt, skb, state);
+	nft_set_pktinfo(&pkt, state->skb, state);
 
-	switch (skb->protocol) {
+	switch (state->skb->protocol) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -303,7 +299,7 @@ static unsigned int nft_do_chain_netdev(void *priv, struct sk_buff *skb,
 		break;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
 static const struct nft_chain_type nft_chain_filter_netdev = {
diff --git a/net/netfilter/nft_chain_nat.c b/net/netfilter/nft_chain_nat.c
index 98e4946100c5..7eff7e499f54 100644
--- a/net/netfilter/nft_chain_nat.c
+++ b/net/netfilter/nft_chain_nat.c
@@ -7,12 +7,11 @@
 #include <net/netfilter/nf_tables_ipv4.h>
 #include <net/netfilter/nf_tables_ipv6.h>
 
-static unsigned int nft_nat_do_chain(void *priv, struct sk_buff *skb,
-				     const struct nf_hook_state *state)
+static unsigned int nft_nat_do_chain(const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
 
-	nft_set_pktinfo(&pkt, skb, state);
+	nft_set_pktinfo(&pkt, state->skb, state);
 
 	switch (state->pf) {
 #ifdef CONFIG_NF_TABLES_IPV4
@@ -29,7 +28,7 @@ static unsigned int nft_nat_do_chain(void *priv, struct sk_buff *skb,
 		break;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	return nft_do_chain(&pkt, state->priv);
 }
 
 #ifdef CONFIG_NF_TABLES_IPV4
diff --git a/net/netfilter/nft_chain_route.c b/net/netfilter/nft_chain_route.c
index 925db0dce48d..8c9f31a96d6f 100644
--- a/net/netfilter/nft_chain_route.c
+++ b/net/netfilter/nft_chain_route.c
@@ -13,10 +13,10 @@
 #include <net/ip.h>
 
 #ifdef CONFIG_NF_TABLES_IPV4
-static unsigned int nf_route_table_hook4(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
+static unsigned int nf_route_table_hook4(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
+	void *priv = state->priv;
 	const struct iphdr *iph;
 	struct nft_pktinfo pkt;
 	__be32 saddr, daddr;
@@ -62,10 +62,10 @@ static const struct nft_chain_type nft_chain_route_ipv4 = {
 #endif
 
 #ifdef CONFIG_NF_TABLES_IPV6
-static unsigned int nf_route_table_hook6(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
+static unsigned int nf_route_table_hook6(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
+	void *priv = state->priv;
 	struct in6_addr saddr, daddr;
 	struct nft_pktinfo pkt;
 	u32 mark, flowlabel;
@@ -112,17 +112,17 @@ static const struct nft_chain_type nft_chain_route_ipv6 = {
 #endif
 
 #ifdef CONFIG_NF_TABLES_INET
-static unsigned int nf_route_table_inet(void *priv,
-					struct sk_buff *skb,
-					const struct nf_hook_state *state)
+static unsigned int nf_route_table_inet(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
+	void *priv = state->priv;
 	struct nft_pktinfo pkt;
 
 	switch (state->pf) {
 	case NFPROTO_IPV4:
-		return nf_route_table_hook4(priv, skb, state);
+		return nf_route_table_hook4(state);
 	case NFPROTO_IPV6:
-		return nf_route_table_hook6(priv, skb, state);
+		return nf_route_table_hook6(state);
 	default:
 		nft_set_pktinfo(&pkt, skb, state);
 		break;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e29cade7b662..582fa381af20 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1788,10 +1788,9 @@ static inline int apparmor_init_sysctl(void)
 #endif /* CONFIG_SYSCTL */
 
 #if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
-static unsigned int apparmor_ip_postroute(void *priv,
-					  struct sk_buff *skb,
-					  const struct nf_hook_state *state)
+static unsigned int apparmor_ip_postroute(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct aa_sk_ctx *ctx;
 	struct sock *sk;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 03bca97c8b29..31d052be21ee 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5612,10 +5612,9 @@ static int selinux_tun_dev_open(void *security)
 }
 
 #ifdef CONFIG_NETFILTER
-
-static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
-				       const struct nf_hook_state *state)
+static unsigned int selinux_ip_forward(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	int ifindex;
 	u16 family;
 	char *addrp;
@@ -5672,9 +5671,9 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
-				      const struct nf_hook_state *state)
+static unsigned int selinux_ip_output(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb;
 	struct sock *sk;
 	u32 sid;
 
@@ -5684,6 +5683,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 	/* we do this in the LOCAL_OUT path and not the POST_ROUTING path
 	 * because we want to make sure we apply the necessary labeling
 	 * before IPsec is applied so we can leverage AH protection */
+	skb = state->skb;
 	sk = skb->sk;
 	if (sk) {
 		struct sk_security_struct *sksec;
@@ -5714,10 +5714,9 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-
-static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
-					const struct nf_hook_state *state)
+static unsigned int selinux_ip_postroute_compat(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	struct sock *sk;
 	struct sk_security_struct *sksec;
 	struct common_audit_data ad;
@@ -5748,10 +5747,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ip_postroute(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
+static unsigned int selinux_ip_postroute(const struct nf_hook_state *state)
 {
+	struct sk_buff *skb = state->skb;
 	u16 family;
 	u32 secmark_perm;
 	u32 peer_sid;
@@ -5767,7 +5765,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	 * special handling.  We do this in an attempt to keep this function
 	 * as fast and as clean as possible. */
 	if (!selinux_policycap_netpeer())
-		return selinux_ip_postroute_compat(skb, state);
+		return selinux_ip_postroute_compat(state);
 
 	secmark_active = selinux_secmark_enabled();
 	peerlbl_active = selinux_peerlbl_enabled();
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index b945c1d3a743..309a2b8191a5 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -18,14 +18,14 @@
 #include <net/net_namespace.h>
 #include "smack.h"
 
-static unsigned int smack_ip_output(void *priv,
-					struct sk_buff *skb,
-					const struct nf_hook_state *state)
+static unsigned int smack_ip_output(const struct nf_hook_state *state)
 {
-	struct sock *sk = skb_to_full_sk(skb);
+	struct sk_buff *skb = state->skb;
 	struct socket_smack *ssp;
 	struct smack_known *skp;
+	struct sock *sk;
 
+	sk = skb_to_full_sk(skb);
 	if (sk && sk->sk_security) {
 		ssp = sk->sk_security;
 		skp = ssp->smk_out;
-- 
2.35.1

