Return-Path: <bpf+bounces-40928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F99900A7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 12:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750411C2119D
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542C1547C9;
	Fri,  4 Oct 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PLMbGjk1"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B614B075;
	Fri,  4 Oct 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036822; cv=none; b=bCE1NH/nT21bVU4tUPAwNBQskc5l2zQXEw/KddRsXrNn3vGxOvZUr9dxWgehKNX5bz7NuoIFFtBzNdxmBqH6hRyAhGrvXIsQUfsKm2C3/Lch7c5cXq6FbPWdoplQPq8b8E3tQyWJBHLYkSt67scm3ODqISswoddfRejjDIoNKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036822; c=relaxed/simple;
	bh=bAe5TGPBiY1O9/hxNR5RhOzLcR3LHONlAmB4jR3B9WU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZbGtZWZJGQALAoR6nmZkiIlLsrjkLaMHILmSo1rLOiVROkaQaIkLDakBNtQUX263vZPkP6OhssYayq8tLtCOl5+vuYe2aooeCuxyf9gY/sZQh7WIpFB3nHHuFjMUxlX3pUOqGu/ecd456uXPOINt/bJAEqHiZ9SUbnRomBsoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PLMbGjk1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YkofudS0wvrGBOsyf0EVZ1OsFaYk2NV9N/M+XbCknnI=; b=PLMbGjk1nGu6I9XKWY7PI7M77P
	yb0gmRbIiOHzQnO56X80JIwtuD/TCC1CVk72bDM+AV7JkJJfNFCT4JQa1n0s8YS+28hfT5JvfglWt
	4u/2ReQ7UHKGrIBQ+HcK1RScG1g7cM0nsaLgt8qsYF+wHCG7U5c5LH6zmLbS8vTD7o42A77X7iBzH
	TbqoQgVXdt7tU+nTx1jci+fucsXqP/rgB+r1RVATsv1sCgaxeTBqaw5b2HtWjP7gzxp9thUUt4v3b
	IhASJwpplkX5RVPvymLSq6mMRi3AnkHgnDxialBLZ4XM4VRNq0adRvEgbXxm+56XrnOCyV77bwgA9
	iQl5Yu1w==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swfJZ-000BVX-W9; Fri, 04 Oct 2024 12:13:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	kuba@kernel.org,
	jrife@google.com,
	tangchen.1@bytedance.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 4/5] tools: Sync if_link.h uapi tooling header
Date: Fri,  4 Oct 2024 12:13:34 +0200
Message-Id: <20241004101335.117711-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004101335.117711-1-daniel@iogearbox.net>
References: <20241004101335.117711-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27417/Fri Oct  4 10:53:24 2024)

Sync if_link uapi header to the latest version as we need the refresher
in tooling for netkit device. Given it's been a while since the last sync
and the diff is fairly big, it has been done as its own commit.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
  - Left the patch as part of the series to not break build

 tools/include/uapi/linux/if_link.h | 553 ++++++++++++++++++++++++++++-
 1 file changed, 552 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index f0d71b2a3f1e..2acc7687e017 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -461,6 +461,286 @@ enum in6_addr_gen_mode {
 
 /* Bridge section */
 
+/**
+ * DOC: Bridge enum definition
+ *
+ * Please *note* that the timer values in the following section are expected
+ * in clock_t format, which is seconds multiplied by USER_HZ (generally
+ * defined as 100).
+ *
+ * @IFLA_BR_FORWARD_DELAY
+ *   The bridge forwarding delay is the time spent in LISTENING state
+ *   (before moving to LEARNING) and in LEARNING state (before moving
+ *   to FORWARDING). Only relevant if STP is enabled.
+ *
+ *   The valid values are between (2 * USER_HZ) and (30 * USER_HZ).
+ *   The default value is (15 * USER_HZ).
+ *
+ * @IFLA_BR_HELLO_TIME
+ *   The time between hello packets sent by the bridge, when it is a root
+ *   bridge or a designated bridge. Only relevant if STP is enabled.
+ *
+ *   The valid values are between (1 * USER_HZ) and (10 * USER_HZ).
+ *   The default value is (2 * USER_HZ).
+ *
+ * @IFLA_BR_MAX_AGE
+ *   The hello packet timeout is the time until another bridge in the
+ *   spanning tree is assumed to be dead, after reception of its last hello
+ *   message. Only relevant if STP is enabled.
+ *
+ *   The valid values are between (6 * USER_HZ) and (40 * USER_HZ).
+ *   The default value is (20 * USER_HZ).
+ *
+ * @IFLA_BR_AGEING_TIME
+ *   Configure the bridge's FDB entries aging time. It is the time a MAC
+ *   address will be kept in the FDB after a packet has been received from
+ *   that address. After this time has passed, entries are cleaned up.
+ *   Allow values outside the 802.1 standard specification for special cases:
+ *
+ *     * 0 - entry never ages (all permanent)
+ *     * 1 - entry disappears (no persistence)
+ *
+ *   The default value is (300 * USER_HZ).
+ *
+ * @IFLA_BR_STP_STATE
+ *   Turn spanning tree protocol on (*IFLA_BR_STP_STATE* > 0) or off
+ *   (*IFLA_BR_STP_STATE* == 0) for this bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_PRIORITY
+ *   Set this bridge's spanning tree priority, used during STP root bridge
+ *   election.
+ *
+ *   The valid values are between 0 and 65535.
+ *
+ * @IFLA_BR_VLAN_FILTERING
+ *   Turn VLAN filtering on (*IFLA_BR_VLAN_FILTERING* > 0) or off
+ *   (*IFLA_BR_VLAN_FILTERING* == 0). When disabled, the bridge will not
+ *   consider the VLAN tag when handling packets.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_VLAN_PROTOCOL
+ *   Set the protocol used for VLAN filtering.
+ *
+ *   The valid values are 0x8100(802.1Q) or 0x88A8(802.1AD). The default value
+ *   is 0x8100(802.1Q).
+ *
+ * @IFLA_BR_GROUP_FWD_MASK
+ *   The group forwarding mask. This is the bitmask that is applied to
+ *   decide whether to forward incoming frames destined to link-local
+ *   addresses (of the form 01:80:C2:00:00:0X).
+ *
+ *   The default value is 0, which means the bridge does not forward any
+ *   link-local frames coming on this port.
+ *
+ * @IFLA_BR_ROOT_ID
+ *   The bridge root id, read only.
+ *
+ * @IFLA_BR_BRIDGE_ID
+ *   The bridge id, read only.
+ *
+ * @IFLA_BR_ROOT_PORT
+ *   The bridge root port, read only.
+ *
+ * @IFLA_BR_ROOT_PATH_COST
+ *   The bridge root path cost, read only.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE
+ *   The bridge topology change, read only.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE_DETECTED
+ *   The bridge topology change detected, read only.
+ *
+ * @IFLA_BR_HELLO_TIMER
+ *   The bridge hello timer, read only.
+ *
+ * @IFLA_BR_TCN_TIMER
+ *   The bridge tcn timer, read only.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE_TIMER
+ *   The bridge topology change timer, read only.
+ *
+ * @IFLA_BR_GC_TIMER
+ *   The bridge gc timer, read only.
+ *
+ * @IFLA_BR_GROUP_ADDR
+ *   Set the MAC address of the multicast group this bridge uses for STP.
+ *   The address must be a link-local address in standard Ethernet MAC address
+ *   format. It is an address of the form 01:80:C2:00:00:0X, with X in [0, 4..f].
+ *
+ *   The default value is 0.
+ *
+ * @IFLA_BR_FDB_FLUSH
+ *   Flush bridge's fdb dynamic entries.
+ *
+ * @IFLA_BR_MCAST_ROUTER
+ *   Set bridge's multicast router if IGMP snooping is enabled.
+ *   The valid values are:
+ *
+ *     * 0 - disabled.
+ *     * 1 - automatic (queried).
+ *     * 2 - permanently enabled.
+ *
+ *   The default value is 1.
+ *
+ * @IFLA_BR_MCAST_SNOOPING
+ *   Turn multicast snooping on (*IFLA_BR_MCAST_SNOOPING* > 0) or off
+ *   (*IFLA_BR_MCAST_SNOOPING* == 0).
+ *
+ *   The default value is 1.
+ *
+ * @IFLA_BR_MCAST_QUERY_USE_IFADDR
+ *   If enabled use the bridge's own IP address as source address for IGMP
+ *   queries (*IFLA_BR_MCAST_QUERY_USE_IFADDR* > 0) or the default of 0.0.0.0
+ *   (*IFLA_BR_MCAST_QUERY_USE_IFADDR* == 0).
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_QUERIER
+ *   Enable (*IFLA_BR_MULTICAST_QUERIER* > 0) or disable
+ *   (*IFLA_BR_MULTICAST_QUERIER* == 0) IGMP querier, ie sending of multicast
+ *   queries by the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_HASH_ELASTICITY
+ *   Set multicast database hash elasticity, It is the maximum chain length in
+ *   the multicast hash table. This attribute is *deprecated* and the value
+ *   is always 16.
+ *
+ * @IFLA_BR_MCAST_HASH_MAX
+ *   Set maximum size of the multicast hash table
+ *
+ *   The default value is 4096, the value must be a power of 2.
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_CNT
+ *   The Last Member Query Count is the number of Group-Specific Queries
+ *   sent before the router assumes there are no local members. The Last
+ *   Member Query Count is also the number of Group-and-Source-Specific
+ *   Queries sent before the router assumes there are no listeners for a
+ *   particular source.
+ *
+ *   The default value is 2.
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_CNT
+ *   The Startup Query Count is the number of Queries sent out on startup,
+ *   separated by the Startup Query Interval.
+ *
+ *   The default value is 2.
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_INTVL
+ *   The Last Member Query Interval is the Max Response Time inserted into
+ *   Group-Specific Queries sent in response to Leave Group messages, and
+ *   is also the amount of time between Group-Specific Query messages.
+ *
+ *   The default value is (1 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_MEMBERSHIP_INTVL
+ *   The interval after which the bridge will leave a group, if no membership
+ *   reports for this group are received.
+ *
+ *   The default value is (260 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_QUERIER_INTVL
+ *   The interval between queries sent by other routers. if no queries are
+ *   seen after this delay has passed, the bridge will start to send its own
+ *   queries (as if *IFLA_BR_MCAST_QUERIER_INTVL* was enabled).
+ *
+ *   The default value is (255 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_QUERY_INTVL
+ *   The Query Interval is the interval between General Queries sent by
+ *   the Querier.
+ *
+ *   The default value is (125 * USER_HZ). The minimum value is (1 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
+ *   The Max Response Time used to calculate the Max Resp Code inserted
+ *   into the periodic General Queries.
+ *
+ *   The default value is (10 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_INTVL
+ *   The interval between queries in the startup phase.
+ *
+ *   The default value is (125 * USER_HZ) / 4. The minimum value is (1 * USER_HZ).
+ *
+ * @IFLA_BR_NF_CALL_IPTABLES
+ *   Enable (*NF_CALL_IPTABLES* > 0) or disable (*NF_CALL_IPTABLES* == 0)
+ *   iptables hooks on the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_NF_CALL_IP6TABLES
+ *   Enable (*NF_CALL_IP6TABLES* > 0) or disable (*NF_CALL_IP6TABLES* == 0)
+ *   ip6tables hooks on the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_NF_CALL_ARPTABLES
+ *   Enable (*NF_CALL_ARPTABLES* > 0) or disable (*NF_CALL_ARPTABLES* == 0)
+ *   arptables hooks on the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_VLAN_DEFAULT_PVID
+ *   VLAN ID applied to untagged and priority-tagged incoming packets.
+ *
+ *   The default value is 1. Setting to the special value 0 makes all ports of
+ *   this bridge not have a PVID by default, which means that they will
+ *   not accept VLAN-untagged traffic.
+ *
+ * @IFLA_BR_PAD
+ *   Bridge attribute padding type for netlink message.
+ *
+ * @IFLA_BR_VLAN_STATS_ENABLED
+ *   Enable (*IFLA_BR_VLAN_STATS_ENABLED* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_ENABLED* == 0) per-VLAN stats accounting.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_STATS_ENABLED
+ *   Enable (*IFLA_BR_MCAST_STATS_ENABLED* > 0) or disable
+ *   (*IFLA_BR_MCAST_STATS_ENABLED* == 0) multicast (IGMP/MLD) stats
+ *   accounting.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_IGMP_VERSION
+ *   Set the IGMP version.
+ *
+ *   The valid values are 2 and 3. The default value is 2.
+ *
+ * @IFLA_BR_MCAST_MLD_VERSION
+ *   Set the MLD version.
+ *
+ *   The valid values are 1 and 2. The default value is 1.
+ *
+ * @IFLA_BR_VLAN_STATS_PER_PORT
+ *   Enable (*IFLA_BR_VLAN_STATS_PER_PORT* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_PER_PORT* == 0) per-VLAN per-port stats accounting.
+ *   Can be changed only when there are no port VLANs configured.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MULTI_BOOLOPT
+ *   The multi_boolopt is used to control new boolean options to avoid adding
+ *   new netlink attributes. You can look at ``enum br_boolopt_id`` for those
+ *   options.
+ *
+ * @IFLA_BR_MCAST_QUERIER_STATE
+ *   Bridge mcast querier states, read only.
+ *
+ * @IFLA_BR_FDB_N_LEARNED
+ *   The number of dynamically learned FDB entries for the current bridge,
+ *   read only.
+ *
+ * @IFLA_BR_FDB_MAX_LEARNED
+ *   Set the number of max dynamically learned FDB entries for the current
+ *   bridge.
+ */
 enum {
 	IFLA_BR_UNSPEC,
 	IFLA_BR_FORWARD_DELAY,
@@ -510,6 +790,8 @@ enum {
 	IFLA_BR_VLAN_STATS_PER_PORT,
 	IFLA_BR_MULTI_BOOLOPT,
 	IFLA_BR_MCAST_QUERIER_STATE,
+	IFLA_BR_FDB_N_LEARNED,
+	IFLA_BR_FDB_MAX_LEARNED,
 	__IFLA_BR_MAX,
 };
 
@@ -520,11 +802,252 @@ struct ifla_bridge_id {
 	__u8	addr[6]; /* ETH_ALEN */
 };
 
+/**
+ * DOC: Bridge mode enum definition
+ *
+ * @BRIDGE_MODE_HAIRPIN
+ *   Controls whether traffic may be sent back out of the port on which it
+ *   was received. This option is also called reflective relay mode, and is
+ *   used to support basic VEPA (Virtual Ethernet Port Aggregator)
+ *   capabilities. By default, this flag is turned off and the bridge will
+ *   not forward traffic back out of the receiving port.
+ */
 enum {
 	BRIDGE_MODE_UNSPEC,
 	BRIDGE_MODE_HAIRPIN,
 };
 
+/**
+ * DOC: Bridge port enum definition
+ *
+ * @IFLA_BRPORT_STATE
+ *   The operation state of the port. Here are the valid values.
+ *
+ *     * 0 - port is in STP *DISABLED* state. Make this port completely
+ *       inactive for STP. This is also called BPDU filter and could be used
+ *       to disable STP on an untrusted port, like a leaf virtual device.
+ *       The traffic forwarding is also stopped on this port.
+ *     * 1 - port is in STP *LISTENING* state. Only valid if STP is enabled
+ *       on the bridge. In this state the port listens for STP BPDUs and
+ *       drops all other traffic frames.
+ *     * 2 - port is in STP *LEARNING* state. Only valid if STP is enabled on
+ *       the bridge. In this state the port will accept traffic only for the
+ *       purpose of updating MAC address tables.
+ *     * 3 - port is in STP *FORWARDING* state. Port is fully active.
+ *     * 4 - port is in STP *BLOCKING* state. Only valid if STP is enabled on
+ *       the bridge. This state is used during the STP election process.
+ *       In this state, port will only process STP BPDUs.
+ *
+ * @IFLA_BRPORT_PRIORITY
+ *   The STP port priority. The valid values are between 0 and 255.
+ *
+ * @IFLA_BRPORT_COST
+ *   The STP path cost of the port. The valid values are between 1 and 65535.
+ *
+ * @IFLA_BRPORT_MODE
+ *   Set the bridge port mode. See *BRIDGE_MODE_HAIRPIN* for more details.
+ *
+ * @IFLA_BRPORT_GUARD
+ *   Controls whether STP BPDUs will be processed by the bridge port. By
+ *   default, the flag is turned off to allow BPDU processing. Turning this
+ *   flag on will disable the bridge port if a STP BPDU packet is received.
+ *
+ *   If the bridge has Spanning Tree enabled, hostile devices on the network
+ *   may send BPDU on a port and cause network failure. Setting *guard on*
+ *   will detect and stop this by disabling the port. The port will be
+ *   restarted if the link is brought down, or removed and reattached.
+ *
+ * @IFLA_BRPORT_PROTECT
+ *   Controls whether a given port is allowed to become a root port or not.
+ *   Only used when STP is enabled on the bridge. By default the flag is off.
+ *
+ *   This feature is also called root port guard. If BPDU is received from a
+ *   leaf (edge) port, it should not be elected as root port. This could
+ *   be used if using STP on a bridge and the downstream bridges are not fully
+ *   trusted; this prevents a hostile guest from rerouting traffic.
+ *
+ * @IFLA_BRPORT_FAST_LEAVE
+ *   This flag allows the bridge to immediately stop multicast traffic
+ *   forwarding on a port that receives an IGMP Leave message. It is only used
+ *   when IGMP snooping is enabled on the bridge. By default the flag is off.
+ *
+ * @IFLA_BRPORT_LEARNING
+ *   Controls whether a given port will learn *source* MAC addresses from
+ *   received traffic or not. Also controls whether dynamic FDB entries
+ *   (which can also be added by software) will be refreshed by incoming
+ *   traffic. By default this flag is on.
+ *
+ * @IFLA_BRPORT_UNICAST_FLOOD
+ *   Controls whether unicast traffic for which there is no FDB entry will
+ *   be flooded towards this port. By default this flag is on.
+ *
+ * @IFLA_BRPORT_PROXYARP
+ *   Enable proxy ARP on this port.
+ *
+ * @IFLA_BRPORT_LEARNING_SYNC
+ *   Controls whether a given port will sync MAC addresses learned on device
+ *   port to bridge FDB.
+ *
+ * @IFLA_BRPORT_PROXYARP_WIFI
+ *   Enable proxy ARP on this port which meets extended requirements by
+ *   IEEE 802.11 and Hotspot 2.0 specifications.
+ *
+ * @IFLA_BRPORT_ROOT_ID
+ *
+ * @IFLA_BRPORT_BRIDGE_ID
+ *
+ * @IFLA_BRPORT_DESIGNATED_PORT
+ *
+ * @IFLA_BRPORT_DESIGNATED_COST
+ *
+ * @IFLA_BRPORT_ID
+ *
+ * @IFLA_BRPORT_NO
+ *
+ * @IFLA_BRPORT_TOPOLOGY_CHANGE_ACK
+ *
+ * @IFLA_BRPORT_CONFIG_PENDING
+ *
+ * @IFLA_BRPORT_MESSAGE_AGE_TIMER
+ *
+ * @IFLA_BRPORT_FORWARD_DELAY_TIMER
+ *
+ * @IFLA_BRPORT_HOLD_TIMER
+ *
+ * @IFLA_BRPORT_FLUSH
+ *   Flush bridge ports' fdb dynamic entries.
+ *
+ * @IFLA_BRPORT_MULTICAST_ROUTER
+ *   Configure the port's multicast router presence. A port with
+ *   a multicast router will receive all multicast traffic.
+ *   The valid values are:
+ *
+ *     * 0 disable multicast routers on this port
+ *     * 1 let the system detect the presence of routers (default)
+ *     * 2 permanently enable multicast traffic forwarding on this port
+ *     * 3 enable multicast routers temporarily on this port, not depending
+ *         on incoming queries.
+ *
+ * @IFLA_BRPORT_PAD
+ *
+ * @IFLA_BRPORT_MCAST_FLOOD
+ *   Controls whether a given port will flood multicast traffic for which
+ *   there is no MDB entry. By default this flag is on.
+ *
+ * @IFLA_BRPORT_MCAST_TO_UCAST
+ *   Controls whether a given port will replicate packets using unicast
+ *   instead of multicast. By default this flag is off.
+ *
+ *   This is done by copying the packet per host and changing the multicast
+ *   destination MAC to a unicast one accordingly.
+ *
+ *   *mcast_to_unicast* works on top of the multicast snooping feature of the
+ *   bridge. Which means unicast copies are only delivered to hosts which
+ *   are interested in unicast and signaled this via IGMP/MLD reports previously.
+ *
+ *   This feature is intended for interface types which have a more reliable
+ *   and/or efficient way to deliver unicast packets than broadcast ones
+ *   (e.g. WiFi).
+ *
+ *   However, it should only be enabled on interfaces where no IGMPv2/MLDv1
+ *   report suppression takes place. IGMP/MLD report suppression issue is
+ *   usually overcome by the network daemon (supplicant) enabling AP isolation
+ *   and by that separating all STAs.
+ *
+ *   Delivery of STA-to-STA IP multicast is made possible again by enabling
+ *   and utilizing the bridge hairpin mode, which considers the incoming port
+ *   as a potential outgoing port, too (see *BRIDGE_MODE_HAIRPIN* option).
+ *   Hairpin mode is performed after multicast snooping, therefore leading
+ *   to only deliver reports to STAs running a multicast router.
+ *
+ * @IFLA_BRPORT_VLAN_TUNNEL
+ *   Controls whether vlan to tunnel mapping is enabled on the port.
+ *   By default this flag is off.
+ *
+ * @IFLA_BRPORT_BCAST_FLOOD
+ *   Controls flooding of broadcast traffic on the given port. By default
+ *   this flag is on.
+ *
+ * @IFLA_BRPORT_GROUP_FWD_MASK
+ *   Set the group forward mask. This is a bitmask that is applied to
+ *   decide whether to forward incoming frames destined to link-local
+ *   addresses. The addresses of the form are 01:80:C2:00:00:0X (defaults
+ *   to 0, which means the bridge does not forward any link-local frames
+ *   coming on this port).
+ *
+ * @IFLA_BRPORT_NEIGH_SUPPRESS
+ *   Controls whether neighbor discovery (arp and nd) proxy and suppression
+ *   is enabled on the port. By default this flag is off.
+ *
+ * @IFLA_BRPORT_ISOLATED
+ *   Controls whether a given port will be isolated, which means it will be
+ *   able to communicate with non-isolated ports only. By default this
+ *   flag is off.
+ *
+ * @IFLA_BRPORT_BACKUP_PORT
+ *   Set a backup port. If the port loses carrier all traffic will be
+ *   redirected to the configured backup port. Set the value to 0 to disable
+ *   it.
+ *
+ * @IFLA_BRPORT_MRP_RING_OPEN
+ *
+ * @IFLA_BRPORT_MRP_IN_OPEN
+ *
+ * @IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT
+ *   The number of per-port EHT hosts limit. The default value is 512.
+ *   Setting to 0 is not allowed.
+ *
+ * @IFLA_BRPORT_MCAST_EHT_HOSTS_CNT
+ *   The current number of tracked hosts, read only.
+ *
+ * @IFLA_BRPORT_LOCKED
+ *   Controls whether a port will be locked, meaning that hosts behind the
+ *   port will not be able to communicate through the port unless an FDB
+ *   entry with the unit's MAC address is in the FDB. The common use case is
+ *   that hosts are allowed access through authentication with the IEEE 802.1X
+ *   protocol or based on whitelists. By default this flag is off.
+ *
+ *   Please note that secure 802.1X deployments should always use the
+ *   *BR_BOOLOPT_NO_LL_LEARN* flag, to not permit the bridge to populate its
+ *   FDB based on link-local (EAPOL) traffic received on the port.
+ *
+ * @IFLA_BRPORT_MAB
+ *   Controls whether a port will use MAC Authentication Bypass (MAB), a
+ *   technique through which select MAC addresses may be allowed on a locked
+ *   port, without using 802.1X authentication. Packets with an unknown source
+ *   MAC address generates a "locked" FDB entry on the incoming bridge port.
+ *   The common use case is for user space to react to these bridge FDB
+ *   notifications and optionally replace the locked FDB entry with a normal
+ *   one, allowing traffic to pass for whitelisted MAC addresses.
+ *
+ *   Setting this flag also requires *IFLA_BRPORT_LOCKED* and
+ *   *IFLA_BRPORT_LEARNING*. *IFLA_BRPORT_LOCKED* ensures that unauthorized
+ *   data packets are dropped, and *IFLA_BRPORT_LEARNING* allows the dynamic
+ *   FDB entries installed by user space (as replacements for the locked FDB
+ *   entries) to be refreshed and/or aged out.
+ *
+ * @IFLA_BRPORT_MCAST_N_GROUPS
+ *
+ * @IFLA_BRPORT_MCAST_MAX_GROUPS
+ *   Sets the maximum number of MDB entries that can be registered for a
+ *   given port. Attempts to register more MDB entries at the port than this
+ *   limit allows will be rejected, whether they are done through netlink
+ *   (e.g. the bridge tool), or IGMP or MLD membership reports. Setting a
+ *   limit of 0 disables the limit. The default value is 0.
+ *
+ * @IFLA_BRPORT_NEIGH_VLAN_SUPPRESS
+ *   Controls whether neighbor discovery (arp and nd) proxy and suppression is
+ *   enabled for a given port. By default this flag is off.
+ *
+ *   Note that this option only takes effect when *IFLA_BRPORT_NEIGH_SUPPRESS*
+ *   is enabled for a given port.
+ *
+ * @IFLA_BRPORT_BACKUP_NHID
+ *   The FDB nexthop object ID to attach to packets being redirected to a
+ *   backup port that has VLAN tunnel mapping enabled (via the
+ *   *IFLA_BRPORT_VLAN_TUNNEL* option). Setting a value of 0 (default) has
+ *   the effect of not attaching any ID.
+ */
 enum {
 	IFLA_BRPORT_UNSPEC,
 	IFLA_BRPORT_STATE,	/* Spanning tree state     */
@@ -769,6 +1292,19 @@ enum netkit_mode {
 	NETKIT_L3,
 };
 
+/* NETKIT_SCRUB_NONE leaves clearing skb->{mark,priority} up to
+ * the BPF program if attached. This also means the latter can
+ * consume the two fields if they were populated earlier.
+ *
+ * NETKIT_SCRUB_DEFAULT zeroes skb->{mark,priority} fields before
+ * invoking the attached BPF program when the peer device resides
+ * in a different network namespace. This is the default behavior.
+ */
+enum netkit_scrub {
+	NETKIT_SCRUB_NONE,
+	NETKIT_SCRUB_DEFAULT,
+};
+
 enum {
 	IFLA_NETKIT_UNSPEC,
 	IFLA_NETKIT_PEER_INFO,
@@ -776,6 +1312,8 @@ enum {
 	IFLA_NETKIT_POLICY,
 	IFLA_NETKIT_PEER_POLICY,
 	IFLA_NETKIT_MODE,
+	IFLA_NETKIT_SCRUB,
+	IFLA_NETKIT_PEER_SCRUB,
 	__IFLA_NETKIT_MAX,
 };
 #define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
@@ -854,6 +1392,7 @@ enum {
 	IFLA_VXLAN_DF,
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
+	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -871,6 +1410,13 @@ enum ifla_vxlan_df {
 	VXLAN_DF_MAX = __VXLAN_DF_END - 1,
 };
 
+enum ifla_vxlan_label_policy {
+	VXLAN_LABEL_FIXED = 0,
+	VXLAN_LABEL_INHERIT = 1,
+	__VXLAN_LABEL_END,
+	VXLAN_LABEL_MAX = __VXLAN_LABEL_END - 1,
+};
+
 /* GENEVE section */
 enum {
 	IFLA_GENEVE_UNSPEC,
@@ -935,6 +1481,8 @@ enum {
 	IFLA_GTP_ROLE,
 	IFLA_GTP_CREATE_SOCKETS,
 	IFLA_GTP_RESTART_COUNT,
+	IFLA_GTP_LOCAL,
+	IFLA_GTP_LOCAL6,
 	__IFLA_GTP_MAX,
 };
 #define IFLA_GTP_MAX (__IFLA_GTP_MAX - 1)
@@ -1240,6 +1788,7 @@ enum {
 	IFLA_HSR_PROTOCOL,		/* Indicate different protocol than
 					 * HSR. For example PRP.
 					 */
+	IFLA_HSR_INTERLINK,		/* HSR interlink network device */
 	__IFLA_HSR_MAX,
 };
 
@@ -1417,7 +1966,9 @@ enum {
 
 enum {
 	IFLA_DSA_UNSPEC,
-	IFLA_DSA_MASTER,
+	IFLA_DSA_CONDUIT,
+	/* Deprecated, use IFLA_DSA_CONDUIT instead */
+	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
 	__IFLA_DSA_MAX,
 };
 
-- 
2.43.0


