Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDB3BE89B
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhGGNQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhGGNQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 09:16:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F40EC06175F;
        Wed,  7 Jul 2021 06:13:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u18so3971979lff.9;
        Wed, 07 Jul 2021 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m3fFJUM5TUVc6C7AowOZtiRQYfZF/Tu07bFPg8gbzvk=;
        b=avBxc5pTOrEgOHuxOygbHVxaaOT6NRAmDKH1XpI1skzS0C55PWiVe7+UA6+fgh/5hs
         EgS4PSNZRs9HOnQ8050Z8M6TqWMwQWmz7krH8ZPqUajRIegbfrHpLlMTfEFwBjEEjPVG
         vMmORt8BsLz4RV1tO5RONYeVbwy5ivcZdr4L0RQlj5anZziGky1AEq7fuBA+k4vJ1x+n
         1CEp5E+0jDdN+b0/vaArdWq7YzNOBWzImjbyMbK7xtf0TLIAjQ0Y1GaSMEu+adQgRPo5
         8X/0X28+AOX6BVfJRQft3MB3P/RnynXEasnRW2t9jdbBFx8JW1xLnpq5E0EFq5yYewKo
         BmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m3fFJUM5TUVc6C7AowOZtiRQYfZF/Tu07bFPg8gbzvk=;
        b=aysqrWa7DVTbpuJYrZV/IaCRHKkE8SOLFlgw4c67RjhHoCng5+wPHfgpeOKBADEfOb
         2Me8Fr7K4DBYAMAdw5g25px2HWsO0z/fBy3XiI/zQey0FXtJx+NhvbTyK7JfajZCePK2
         sVbYeoLfxw3Z4mkIjgs9MF+MPAFZXNd/W8zQgDCPmdr4j2pWDJHUHwYXgVA7Ip1ec+Ni
         EKl9IlPBpDlhHj7ElV7cZ6KTxsT9k+5RwpHPPf89M8UOGdgLxLYnWYeW1sDfC2pRojm1
         hqd7XJT57lsLdCFl1b53Dj911Qxvbx/QXNTkDwbf38njUAdQzuc3NsnFpd90Q4SkhwM1
         aCVQ==
X-Gm-Message-State: AOAM532k+6sg/g53Pt8ZmW6WU4qm3Iayn8BOxgML3sjPOvftnskBTKZp
        3gwZxJ3ssB8TOJnWhJT8IZzaynLxk9bUw/hGPQ==
X-Google-Smtp-Source: ABdhPJxxUF8kkgJbuG2ZRpWiqbd84V6JnzVREiJkvgeDBHXsUhmJd4SuNIt7Ci7JONN/AOAE3jGG7w==
X-Received: by 2002:ac2:48a3:: with SMTP id u3mr2658869lfg.38.1625663626979;
        Wed, 07 Jul 2021 06:13:46 -0700 (PDT)
Received: from localhost.localdomain ([89.42.43.188])
        by smtp.gmail.com with ESMTPSA id u9sm1423571lfm.127.2021.07.07.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:13:46 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, daniel@iogearbox.net, j.vosburgh@gmail.com,
        andy@greyhouse.net, vfalico@gmail.com, andrii@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf-next v3 1/5] net: bonding: Refactor bond_xmit_hash for use with xdp_buff
Date:   Wed,  7 Jul 2021 11:25:47 +0000
Message-Id: <20210707112551.9782-2-joamaki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707112551.9782-1-joamaki@gmail.com>
References: <20210609135537.1460244-1-joamaki@gmail.com>
 <20210707112551.9782-1-joamaki@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for adding XDP support to the bonding driver
refactor the packet hashing functions to be able to work with
any linear data buffer without an skb.

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 drivers/net/bonding/bond_main.c | 147 +++++++++++++++++++-------------
 1 file changed, 90 insertions(+), 57 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0ff7567bd04f..78284c451668 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3487,55 +3487,80 @@ static struct notifier_block bond_netdev_notifier = {
 
 /*---------------------------- Hashing Policies -----------------------------*/
 
+/* Helper to access data in a packet, with or without a backing skb.
+ * If skb is given the data is linearized if necessary via pskb_may_pull.
+ */
+static inline const void *bond_pull_data(struct sk_buff *skb,
+					 const void *data, int hlen, int n)
+{
+	if (likely(n <= hlen))
+		return data;
+	else if (skb && likely(pskb_may_pull(skb, n)))
+		return skb->head;
+
+	return NULL;
+}
+
 /* L2 hash helper */
-static inline u32 bond_eth_hash(struct sk_buff *skb)
+static inline u32 bond_eth_hash(struct sk_buff *skb, const void *data, int mhoff, int hlen)
 {
-	struct ethhdr *ep, hdr_tmp;
+	struct ethhdr *ep;
 
-	ep = skb_header_pointer(skb, 0, sizeof(hdr_tmp), &hdr_tmp);
-	if (ep)
-		return ep->h_dest[5] ^ ep->h_source[5] ^ ep->h_proto;
-	return 0;
+	data = bond_pull_data(skb, data, hlen, mhoff + sizeof(struct ethhdr));
+	if (!data)
+		return 0;
+
+	ep = (struct ethhdr *)(data + mhoff);
+	return ep->h_dest[5] ^ ep->h_source[5] ^ ep->h_proto;
 }
 
-static bool bond_flow_ip(struct sk_buff *skb, struct flow_keys *fk,
-			 int *noff, int *proto, bool l34)
+static bool bond_flow_ip(struct sk_buff *skb, struct flow_keys *fk, const void *data,
+			 int hlen, __be16 l2_proto, int *nhoff, int *ip_proto, bool l34)
 {
 	const struct ipv6hdr *iph6;
 	const struct iphdr *iph;
 
-	if (skb->protocol == htons(ETH_P_IP)) {
-		if (unlikely(!pskb_may_pull(skb, *noff + sizeof(*iph))))
+	if (l2_proto == htons(ETH_P_IP)) {
+		data = bond_pull_data(skb, data, hlen, *nhoff + sizeof(*iph));
+		if (!data)
 			return false;
-		iph = (const struct iphdr *)(skb->data + *noff);
+
+		iph = (const struct iphdr *)(data + *nhoff);
 		iph_to_flow_copy_v4addrs(fk, iph);
-		*noff += iph->ihl << 2;
+		*nhoff += iph->ihl << 2;
 		if (!ip_is_fragment(iph))
-			*proto = iph->protocol;
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
-		if (unlikely(!pskb_may_pull(skb, *noff + sizeof(*iph6))))
+			*ip_proto = iph->protocol;
+	} else if (l2_proto == htons(ETH_P_IPV6)) {
+		data = bond_pull_data(skb, data, hlen, *nhoff + sizeof(*iph6));
+		if (!data)
 			return false;
-		iph6 = (const struct ipv6hdr *)(skb->data + *noff);
+
+		iph6 = (const struct ipv6hdr *)(data + *nhoff);
 		iph_to_flow_copy_v6addrs(fk, iph6);
-		*noff += sizeof(*iph6);
-		*proto = iph6->nexthdr;
+		*nhoff += sizeof(*iph6);
+		*ip_proto = iph6->nexthdr;
 	} else {
 		return false;
 	}
 
-	if (l34 && *proto >= 0)
-		fk->ports.ports = skb_flow_get_ports(skb, *noff, *proto);
+	if (l34 && *ip_proto >= 0)
+		fk->ports.ports = __skb_flow_get_ports(skb, *nhoff, *ip_proto, data, hlen);
 
 	return true;
 }
 
-static u32 bond_vlan_srcmac_hash(struct sk_buff *skb)
+static u32 bond_vlan_srcmac_hash(struct sk_buff *skb, const void *data, int mhoff, int hlen)
 {
-	struct ethhdr *mac_hdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *mac_hdr;
 	u32 srcmac_vendor = 0, srcmac_dev = 0;
 	u16 vlan;
 	int i;
 
+	data = bond_pull_data(skb, data, hlen, mhoff + sizeof(struct ethhdr));
+	if (!data)
+		return 0;
+	mac_hdr = (struct ethhdr *)(data + mhoff);
+
 	for (i = 0; i < 3; i++)
 		srcmac_vendor = (srcmac_vendor << 8) | mac_hdr->h_source[i];
 
@@ -3551,26 +3576,25 @@ static u32 bond_vlan_srcmac_hash(struct sk_buff *skb)
 }
 
 /* Extract the appropriate headers based on bond's xmit policy */
-static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb,
-			      struct flow_keys *fk)
+static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb, const void *data,
+			      __be16 l2_proto, int nhoff, int hlen, struct flow_keys *fk)
 {
 	bool l34 = bond->params.xmit_policy == BOND_XMIT_POLICY_LAYER34;
-	int noff, proto = -1;
+	int ip_proto = -1;
 
 	switch (bond->params.xmit_policy) {
 	case BOND_XMIT_POLICY_ENCAP23:
 	case BOND_XMIT_POLICY_ENCAP34:
 		memset(fk, 0, sizeof(*fk));
 		return __skb_flow_dissect(NULL, skb, &flow_keys_bonding,
-					  fk, NULL, 0, 0, 0, 0);
+					  fk, data, l2_proto, nhoff, hlen, 0);
 	default:
 		break;
 	}
 
 	fk->ports.ports = 0;
 	memset(&fk->icmp, 0, sizeof(fk->icmp));
-	noff = skb_network_offset(skb);
-	if (!bond_flow_ip(skb, fk, &noff, &proto, l34))
+	if (!bond_flow_ip(skb, fk, data, hlen, l2_proto, &nhoff, &ip_proto, l34))
 		return false;
 
 	/* ICMP error packets contains at least 8 bytes of the header
@@ -3578,22 +3602,20 @@ static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb,
 	 * to correlate ICMP error packets within the same flow which
 	 * generated the error.
 	 */
-	if (proto == IPPROTO_ICMP || proto == IPPROTO_ICMPV6) {
-		skb_flow_get_icmp_tci(skb, &fk->icmp, skb->data,
-				      skb_transport_offset(skb),
-				      skb_headlen(skb));
-		if (proto == IPPROTO_ICMP) {
+	if (ip_proto == IPPROTO_ICMP || ip_proto == IPPROTO_ICMPV6) {
+		skb_flow_get_icmp_tci(skb, &fk->icmp, data, nhoff, hlen);
+		if (ip_proto == IPPROTO_ICMP) {
 			if (!icmp_is_err(fk->icmp.type))
 				return true;
 
-			noff += sizeof(struct icmphdr);
-		} else if (proto == IPPROTO_ICMPV6) {
+			nhoff += sizeof(struct icmphdr);
+		} else if (ip_proto == IPPROTO_ICMPV6) {
 			if (!icmpv6_is_err(fk->icmp.type))
 				return true;
 
-			noff += sizeof(struct icmp6hdr);
+			nhoff += sizeof(struct icmp6hdr);
 		}
-		return bond_flow_ip(skb, fk, &noff, &proto, l34);
+		return bond_flow_ip(skb, fk, data, hlen, l2_proto, &nhoff, &ip_proto, l34);
 	}
 
 	return true;
@@ -3609,33 +3631,26 @@ static u32 bond_ip_hash(u32 hash, struct flow_keys *flow)
 	return hash >> 1;
 }
 
-/**
- * bond_xmit_hash - generate a hash value based on the xmit policy
- * @bond: bonding device
- * @skb: buffer to use for headers
- *
- * This function will extract the necessary headers from the skb buffer and use
- * them to generate a hash based on the xmit_policy set in the bonding device
+/* Generate hash based on xmit policy. If @skb is given it is used to linearize
+ * the data as required, but this function can be used without it if the data is
+ * known to be linear (e.g. with xdp_buff).
  */
-u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
+static u32 __bond_xmit_hash(struct bonding *bond, struct sk_buff *skb, const void *data,
+			    __be16 l2_proto, int mhoff, int nhoff, int hlen)
 {
 	struct flow_keys flow;
 	u32 hash;
 
-	if (bond->params.xmit_policy == BOND_XMIT_POLICY_ENCAP34 &&
-	    skb->l4_hash)
-		return skb->hash;
-
 	if (bond->params.xmit_policy == BOND_XMIT_POLICY_VLAN_SRCMAC)
-		return bond_vlan_srcmac_hash(skb);
+		return bond_vlan_srcmac_hash(skb, data, mhoff, hlen);
 
 	if (bond->params.xmit_policy == BOND_XMIT_POLICY_LAYER2 ||
-	    !bond_flow_dissect(bond, skb, &flow))
-		return bond_eth_hash(skb);
+	    !bond_flow_dissect(bond, skb, data, l2_proto, nhoff, hlen, &flow))
+		return bond_eth_hash(skb, data, mhoff, hlen);
 
 	if (bond->params.xmit_policy == BOND_XMIT_POLICY_LAYER23 ||
 	    bond->params.xmit_policy == BOND_XMIT_POLICY_ENCAP23) {
-		hash = bond_eth_hash(skb);
+		hash = bond_eth_hash(skb, data, mhoff, hlen);
 	} else {
 		if (flow.icmp.id)
 			memcpy(&hash, &flow.icmp, sizeof(hash));
@@ -3646,6 +3661,25 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
 	return bond_ip_hash(hash, &flow);
 }
 
+/**
+ * bond_xmit_hash - generate a hash value based on the xmit policy
+ * @bond: bonding device
+ * @skb: buffer to use for headers
+ *
+ * This function will extract the necessary headers from the skb buffer and use
+ * them to generate a hash based on the xmit_policy set in the bonding device
+ */
+u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
+{
+	if (bond->params.xmit_policy == BOND_XMIT_POLICY_ENCAP34 &&
+	    skb->l4_hash)
+		return skb->hash;
+
+	return __bond_xmit_hash(bond, skb, skb->head, skb->protocol,
+				skb->mac_header, skb->network_header,
+				skb_headlen(skb));
+}
+
 /*-------------------------- Device entry points ----------------------------*/
 
 void bond_work_init_all(struct bonding *bond)
@@ -4275,8 +4309,7 @@ static netdev_tx_t bond_xmit_roundrobin(struct sk_buff *skb,
 	return bond_tx_drop(bond_dev, skb);
 }
 
-static struct slave *bond_xmit_activebackup_slave_get(struct bonding *bond,
-						      struct sk_buff *skb)
+static struct slave *bond_xmit_activebackup_slave_get(struct bonding *bond)
 {
 	return rcu_dereference(bond->curr_active_slave);
 }
@@ -4290,7 +4323,7 @@ static netdev_tx_t bond_xmit_activebackup(struct sk_buff *skb,
 	struct bonding *bond = netdev_priv(bond_dev);
 	struct slave *slave;
 
-	slave = bond_xmit_activebackup_slave_get(bond, skb);
+	slave = bond_xmit_activebackup_slave_get(bond);
 	if (slave)
 		return bond_dev_queue_xmit(bond, skb, slave->dev);
 
@@ -4588,7 +4621,7 @@ static struct net_device *bond_xmit_get_slave(struct net_device *master_dev,
 		slave = bond_xmit_roundrobin_slave_get(bond, skb);
 		break;
 	case BOND_MODE_ACTIVEBACKUP:
-		slave = bond_xmit_activebackup_slave_get(bond, skb);
+		slave = bond_xmit_activebackup_slave_get(bond);
 		break;
 	case BOND_MODE_8023AD:
 	case BOND_MODE_XOR:
-- 
2.27.0

