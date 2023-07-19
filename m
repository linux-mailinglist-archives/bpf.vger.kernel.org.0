Return-Path: <bpf+bounces-5362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F1759DBB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA73E1C21101
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F822EF6;
	Wed, 19 Jul 2023 18:42:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F122EE2;
	Wed, 19 Jul 2023 18:42:07 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BABDC7;
	Wed, 19 Jul 2023 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792124; x=1721328124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJaJz0ig+i2WnBzcPD71z2/Mcu2XGwRzXhvrAdLhgeA=;
  b=mE21zcGlmuc5sRREmeQei9BqnzyUA91EJfRPeijbCQdeaui6ELCDBNtL
   lND9dx/MOTkrqiOFWzA0sYFdKSOodAXm0hITtcP64PsupuUGQcHTBIQyQ
   nU1xerKLZ+vXx/OzMEv8g4fiGAIIFLaWgttG/zHY5Ip8QUqUWWAKinE4O
   Z2ZfsYdvP022PfEV6xCZrKMG3WOhILc+zl2QwNTIPcdcihT/iHblddDkP
   QGQ8jN//z+3F631RVXpzG3xtFZCHTtVluy0Za6KwG7N8tbHmEfJxmYv22
   +j7HjibyOBwiYnzBiRK8TMO3uP9GvNR4SGIoG8O/sQMEArJaCHtast7Xj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370111179"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="370111179"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794146638"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794146638"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 11:41:55 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E846B34F1B;
	Wed, 19 Jul 2023 19:41:53 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 07/21] ice: Support RX hash XDP hint
Date: Wed, 19 Jul 2023 20:37:20 +0200
Message-ID: <20230719183734.21681-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183734.21681-1-larysa.zaremba@intel.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RX hash XDP hint requests both hash value and type.
Type is XDP-specific, so we need a separate way to map
these values to the hardware ptypes, so create a lookup table.

Instead of creating a new long list, reuse contents
of ice_decode_rx_desc_ptype[] through preprocessor.

Current hash type enum does not contain ICMP packet type,
but ice devices support it, so also add a new type into core code.

Then use previously refactored code and create a function
that allows XDP code to read RX hash.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  73 ++++
 include/net/xdp.h                             |   3 +
 3 files changed, 284 insertions(+), 204 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 89f986a75cc8..d384ddfcb83e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -673,6 +673,212 @@ struct ice_tlan_ctx {
  *      Use the enum ice_rx_l2_ptype to decode the packet type
  * ENDIF
  */
+#define ICE_PTYPES								\
+	/* L2 Packet types */							\
+	ICE_PTT_UNUSED_ENTRY(0),						\
+	ICE_PTT(1, L2, NONE, NOF, NONE, NONE, NOF, NONE, PAY2),			\
+	ICE_PTT_UNUSED_ENTRY(2),						\
+	ICE_PTT_UNUSED_ENTRY(3),						\
+	ICE_PTT_UNUSED_ENTRY(4),						\
+	ICE_PTT_UNUSED_ENTRY(5),						\
+	ICE_PTT(6, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),			\
+	ICE_PTT(7, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),			\
+	ICE_PTT_UNUSED_ENTRY(8),						\
+	ICE_PTT_UNUSED_ENTRY(9),						\
+	ICE_PTT(10, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),		\
+	ICE_PTT(11, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),		\
+	ICE_PTT_UNUSED_ENTRY(12),						\
+	ICE_PTT_UNUSED_ENTRY(13),						\
+	ICE_PTT_UNUSED_ENTRY(14),						\
+	ICE_PTT_UNUSED_ENTRY(15),						\
+	ICE_PTT_UNUSED_ENTRY(16),						\
+	ICE_PTT_UNUSED_ENTRY(17),						\
+	ICE_PTT_UNUSED_ENTRY(18),						\
+	ICE_PTT_UNUSED_ENTRY(19),						\
+	ICE_PTT_UNUSED_ENTRY(20),						\
+	ICE_PTT_UNUSED_ENTRY(21),						\
+										\
+	/* Non Tunneled IPv4 */							\
+	ICE_PTT(22, IP, IPV4, FRG, NONE, NONE, NOF, NONE, PAY3),		\
+	ICE_PTT(23, IP, IPV4, NOF, NONE, NONE, NOF, NONE, PAY3),		\
+	ICE_PTT(24, IP, IPV4, NOF, NONE, NONE, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(25),						\
+	ICE_PTT(26, IP, IPV4, NOF, NONE, NONE, NOF, TCP,  PAY4),		\
+	ICE_PTT(27, IP, IPV4, NOF, NONE, NONE, NOF, SCTP, PAY4),		\
+	ICE_PTT(28, IP, IPV4, NOF, NONE, NONE, NOF, ICMP, PAY4),		\
+										\
+	/* IPv4 --> IPv4 */							\
+	ICE_PTT(29, IP, IPV4, NOF, IP_IP, IPV4, FRG, NONE, PAY3),		\
+	ICE_PTT(30, IP, IPV4, NOF, IP_IP, IPV4, NOF, NONE, PAY3),		\
+	ICE_PTT(31, IP, IPV4, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(32),						\
+	ICE_PTT(33, IP, IPV4, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),		\
+	ICE_PTT(34, IP, IPV4, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),		\
+	ICE_PTT(35, IP, IPV4, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),		\
+										\
+	/* IPv4 --> IPv6 */							\
+	ICE_PTT(36, IP, IPV4, NOF, IP_IP, IPV6, FRG, NONE, PAY3),		\
+	ICE_PTT(37, IP, IPV4, NOF, IP_IP, IPV6, NOF, NONE, PAY3),		\
+	ICE_PTT(38, IP, IPV4, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(39),						\
+	ICE_PTT(40, IP, IPV4, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),		\
+	ICE_PTT(41, IP, IPV4, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),		\
+	ICE_PTT(42, IP, IPV4, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),		\
+										\
+	/* IPv4 --> GRE/NAT */							\
+	ICE_PTT(43, IP, IPV4, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),		\
+										\
+	/* IPv4 --> GRE/NAT --> IPv4 */						\
+	ICE_PTT(44, IP, IPV4, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),		\
+	ICE_PTT(45, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),		\
+	ICE_PTT(46, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(47),						\
+	ICE_PTT(48, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),		\
+	ICE_PTT(49, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),		\
+	ICE_PTT(50, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),		\
+										\
+	/* IPv4 --> GRE/NAT --> IPv6 */						\
+	ICE_PTT(51, IP, IPV4, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),		\
+	ICE_PTT(52, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),		\
+	ICE_PTT(53, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(54),						\
+	ICE_PTT(55, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),		\
+	ICE_PTT(56, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),		\
+	ICE_PTT(57, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),		\
+										\
+	/* IPv4 --> GRE/NAT --> MAC */						\
+	ICE_PTT(58, IP, IPV4, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),	\
+										\
+	/* IPv4 --> GRE/NAT --> MAC --> IPv4 */					\
+	ICE_PTT(59, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),	\
+	ICE_PTT(60, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),	\
+	ICE_PTT(61, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(62),						\
+	ICE_PTT(63, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),	\
+	ICE_PTT(64, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),	\
+	ICE_PTT(65, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),	\
+										\
+	/* IPv4 --> GRE/NAT -> MAC --> IPv6 */					\
+	ICE_PTT(66, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),	\
+	ICE_PTT(67, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),	\
+	ICE_PTT(68, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(69),						\
+	ICE_PTT(70, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),	\
+	ICE_PTT(71, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),	\
+	ICE_PTT(72, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),	\
+										\
+	/* IPv4 --> GRE/NAT --> MAC/VLAN */					\
+	ICE_PTT(73, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),	\
+										\
+	/* IPv4 ---> GRE/NAT -> MAC/VLAN --> IPv4 */				\
+	ICE_PTT(74, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),	\
+	ICE_PTT(75, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),	\
+	ICE_PTT(76, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(77),						\
+	ICE_PTT(78, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),	\
+	ICE_PTT(79, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),	\
+	ICE_PTT(80, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),	\
+										\
+	/* IPv4 -> GRE/NAT -> MAC/VLAN --> IPv6 */				\
+	ICE_PTT(81, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),	\
+	ICE_PTT(82, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),	\
+	ICE_PTT(83, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(84),						\
+	ICE_PTT(85, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),	\
+	ICE_PTT(86, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),	\
+	ICE_PTT(87, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),	\
+										\
+	/* Non Tunneled IPv6 */							\
+	ICE_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),		\
+	ICE_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),		\
+	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(91),						\
+	ICE_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),		\
+	ICE_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),		\
+	ICE_PTT(94, IP, IPV6, NOF, NONE, NONE, NOF, ICMP, PAY4),		\
+										\
+	/* IPv6 --> IPv4 */							\
+	ICE_PTT(95, IP, IPV6, NOF, IP_IP, IPV4, FRG, NONE, PAY3),		\
+	ICE_PTT(96, IP, IPV6, NOF, IP_IP, IPV4, NOF, NONE, PAY3),		\
+	ICE_PTT(97, IP, IPV6, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(98),						\
+	ICE_PTT(99, IP, IPV6, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),		\
+	ICE_PTT(100, IP, IPV6, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),		\
+	ICE_PTT(101, IP, IPV6, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),		\
+										\
+	/* IPv6 --> IPv6 */							\
+	ICE_PTT(102, IP, IPV6, NOF, IP_IP, IPV6, FRG, NONE, PAY3),		\
+	ICE_PTT(103, IP, IPV6, NOF, IP_IP, IPV6, NOF, NONE, PAY3),		\
+	ICE_PTT(104, IP, IPV6, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(105),						\
+	ICE_PTT(106, IP, IPV6, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),		\
+	ICE_PTT(107, IP, IPV6, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),		\
+	ICE_PTT(108, IP, IPV6, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),		\
+										\
+	/* IPv6 --> GRE/NAT */							\
+	ICE_PTT(109, IP, IPV6, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),		\
+										\
+	/* IPv6 --> GRE/NAT -> IPv4 */						\
+	ICE_PTT(110, IP, IPV6, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),		\
+	ICE_PTT(111, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),		\
+	ICE_PTT(112, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(113),						\
+	ICE_PTT(114, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),		\
+	ICE_PTT(115, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),		\
+	ICE_PTT(116, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),		\
+										\
+	/* IPv6 --> GRE/NAT -> IPv6 */						\
+	ICE_PTT(117, IP, IPV6, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),		\
+	ICE_PTT(118, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),		\
+	ICE_PTT(119, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),		\
+	ICE_PTT_UNUSED_ENTRY(120),						\
+	ICE_PTT(121, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),		\
+	ICE_PTT(122, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),		\
+	ICE_PTT(123, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),		\
+										\
+	/* IPv6 --> GRE/NAT -> MAC */						\
+	ICE_PTT(124, IP, IPV6, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),	\
+										\
+	/* IPv6 --> GRE/NAT -> MAC -> IPv4 */					\
+	ICE_PTT(125, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),	\
+	ICE_PTT(126, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),	\
+	ICE_PTT(127, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(128),						\
+	ICE_PTT(129, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),	\
+	ICE_PTT(130, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),	\
+	ICE_PTT(131, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),	\
+										\
+	/* IPv6 --> GRE/NAT -> MAC -> IPv6 */					\
+	ICE_PTT(132, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),	\
+	ICE_PTT(133, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),	\
+	ICE_PTT(134, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(135),						\
+	ICE_PTT(136, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),	\
+	ICE_PTT(137, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),	\
+	ICE_PTT(138, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),	\
+										\
+	/* IPv6 --> GRE/NAT -> MAC/VLAN */					\
+	ICE_PTT(139, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),	\
+										\
+	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv4 */				\
+	ICE_PTT(140, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),	\
+	ICE_PTT(141, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),	\
+	ICE_PTT(142, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(143),						\
+	ICE_PTT(144, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),	\
+	ICE_PTT(145, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),	\
+	ICE_PTT(146, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),	\
+										\
+	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv6 */				\
+	ICE_PTT(147, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),	\
+	ICE_PTT(148, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),	\
+	ICE_PTT(149, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),	\
+	ICE_PTT_UNUSED_ENTRY(150),						\
+	ICE_PTT(151, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),	\
+	ICE_PTT(152, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),	\
+	ICE_PTT(153, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
+
+#define ICE_NUM_DEFINED_PTYPES	154
 
 /* macro to make the table lines short, use explicit indexing with [PTYPE] */
 #define ICE_PTT(PTYPE, OUTER_IP, OUTER_IP_VER, OUTER_FRAG, T, TE, TEF, I, PL)\
@@ -695,212 +901,10 @@ struct ice_tlan_ctx {
 
 /* Lookup table mapping in the 10-bit HW PTYPE to the bit field for decoding */
 static const struct ice_rx_ptype_decoded ice_ptype_lkup[BIT(10)] = {
-	/* L2 Packet types */
-	ICE_PTT_UNUSED_ENTRY(0),
-	ICE_PTT(1, L2, NONE, NOF, NONE, NONE, NOF, NONE, PAY2),
-	ICE_PTT_UNUSED_ENTRY(2),
-	ICE_PTT_UNUSED_ENTRY(3),
-	ICE_PTT_UNUSED_ENTRY(4),
-	ICE_PTT_UNUSED_ENTRY(5),
-	ICE_PTT(6, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
-	ICE_PTT(7, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
-	ICE_PTT_UNUSED_ENTRY(8),
-	ICE_PTT_UNUSED_ENTRY(9),
-	ICE_PTT(10, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
-	ICE_PTT(11, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
-	ICE_PTT_UNUSED_ENTRY(12),
-	ICE_PTT_UNUSED_ENTRY(13),
-	ICE_PTT_UNUSED_ENTRY(14),
-	ICE_PTT_UNUSED_ENTRY(15),
-	ICE_PTT_UNUSED_ENTRY(16),
-	ICE_PTT_UNUSED_ENTRY(17),
-	ICE_PTT_UNUSED_ENTRY(18),
-	ICE_PTT_UNUSED_ENTRY(19),
-	ICE_PTT_UNUSED_ENTRY(20),
-	ICE_PTT_UNUSED_ENTRY(21),
-
-	/* Non Tunneled IPv4 */
-	ICE_PTT(22, IP, IPV4, FRG, NONE, NONE, NOF, NONE, PAY3),
-	ICE_PTT(23, IP, IPV4, NOF, NONE, NONE, NOF, NONE, PAY3),
-	ICE_PTT(24, IP, IPV4, NOF, NONE, NONE, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(25),
-	ICE_PTT(26, IP, IPV4, NOF, NONE, NONE, NOF, TCP,  PAY4),
-	ICE_PTT(27, IP, IPV4, NOF, NONE, NONE, NOF, SCTP, PAY4),
-	ICE_PTT(28, IP, IPV4, NOF, NONE, NONE, NOF, ICMP, PAY4),
-
-	/* IPv4 --> IPv4 */
-	ICE_PTT(29, IP, IPV4, NOF, IP_IP, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(30, IP, IPV4, NOF, IP_IP, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(31, IP, IPV4, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(32),
-	ICE_PTT(33, IP, IPV4, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(34, IP, IPV4, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(35, IP, IPV4, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv4 --> IPv6 */
-	ICE_PTT(36, IP, IPV4, NOF, IP_IP, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(37, IP, IPV4, NOF, IP_IP, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(38, IP, IPV4, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(39),
-	ICE_PTT(40, IP, IPV4, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(41, IP, IPV4, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(42, IP, IPV4, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),
-
-	/* IPv4 --> GRE/NAT */
-	ICE_PTT(43, IP, IPV4, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),
-
-	/* IPv4 --> GRE/NAT --> IPv4 */
-	ICE_PTT(44, IP, IPV4, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(45, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(46, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(47),
-	ICE_PTT(48, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(49, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(50, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv4 --> GRE/NAT --> IPv6 */
-	ICE_PTT(51, IP, IPV4, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(52, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(53, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(54),
-	ICE_PTT(55, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(56, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(57, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),
-
-	/* IPv4 --> GRE/NAT --> MAC */
-	ICE_PTT(58, IP, IPV4, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),
-
-	/* IPv4 --> GRE/NAT --> MAC --> IPv4 */
-	ICE_PTT(59, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(60, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(61, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(62),
-	ICE_PTT(63, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(64, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(65, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv4 --> GRE/NAT -> MAC --> IPv6 */
-	ICE_PTT(66, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(67, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(68, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(69),
-	ICE_PTT(70, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(71, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(72, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),
-
-	/* IPv4 --> GRE/NAT --> MAC/VLAN */
-	ICE_PTT(73, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),
-
-	/* IPv4 ---> GRE/NAT -> MAC/VLAN --> IPv4 */
-	ICE_PTT(74, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(75, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(76, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(77),
-	ICE_PTT(78, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(79, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(80, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv4 -> GRE/NAT -> MAC/VLAN --> IPv6 */
-	ICE_PTT(81, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(82, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(83, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(84),
-	ICE_PTT(85, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(86, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(87, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
-
-	/* Non Tunneled IPv6 */
-	ICE_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),
-	ICE_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),
-	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(91),
-	ICE_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),
-	ICE_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),
-	ICE_PTT(94, IP, IPV6, NOF, NONE, NONE, NOF, ICMP, PAY4),
-
-	/* IPv6 --> IPv4 */
-	ICE_PTT(95, IP, IPV6, NOF, IP_IP, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(96, IP, IPV6, NOF, IP_IP, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(97, IP, IPV6, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(98),
-	ICE_PTT(99, IP, IPV6, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(100, IP, IPV6, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(101, IP, IPV6, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv6 --> IPv6 */
-	ICE_PTT(102, IP, IPV6, NOF, IP_IP, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(103, IP, IPV6, NOF, IP_IP, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(104, IP, IPV6, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(105),
-	ICE_PTT(106, IP, IPV6, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(107, IP, IPV6, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(108, IP, IPV6, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),
-
-	/* IPv6 --> GRE/NAT */
-	ICE_PTT(109, IP, IPV6, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),
-
-	/* IPv6 --> GRE/NAT -> IPv4 */
-	ICE_PTT(110, IP, IPV6, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(111, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(112, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(113),
-	ICE_PTT(114, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(115, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(116, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv6 --> GRE/NAT -> IPv6 */
-	ICE_PTT(117, IP, IPV6, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(118, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(119, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(120),
-	ICE_PTT(121, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(122, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(123, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),
-
-	/* IPv6 --> GRE/NAT -> MAC */
-	ICE_PTT(124, IP, IPV6, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),
-
-	/* IPv6 --> GRE/NAT -> MAC -> IPv4 */
-	ICE_PTT(125, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(126, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(127, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(128),
-	ICE_PTT(129, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(130, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(131, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv6 --> GRE/NAT -> MAC -> IPv6 */
-	ICE_PTT(132, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(133, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(134, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(135),
-	ICE_PTT(136, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(137, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(138, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),
-
-	/* IPv6 --> GRE/NAT -> MAC/VLAN */
-	ICE_PTT(139, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),
-
-	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv4 */
-	ICE_PTT(140, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),
-	ICE_PTT(141, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),
-	ICE_PTT(142, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(143),
-	ICE_PTT(144, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),
-	ICE_PTT(145, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),
-	ICE_PTT(146, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),
-
-	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv6 */
-	ICE_PTT(147, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),
-	ICE_PTT(148, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),
-	ICE_PTT(149, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),
-	ICE_PTT_UNUSED_ENTRY(150),
-	ICE_PTT(151, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),
-	ICE_PTT(152, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),
-	ICE_PTT(153, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
+	ICE_PTYPES
 
 	/* unused entries */
-	[154 ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+	[ICE_NUM_DEFINED_PTYPES ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
 };
 
 static inline struct ice_rx_ptype_decoded ice_decode_rx_desc_ptype(u16 ptype)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 463d9e5cbe05..b11cfaedb81c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -567,6 +567,79 @@ static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
 	return 0;
 }
 
+/* Define a ptype index -> XDP hash type lookup table.
+ * It uses the same ptype definitions as ice_decode_rx_desc_ptype[],
+ * avoiding possible copy-paste errors.
+ */
+#undef ICE_PTT
+#undef ICE_PTT_UNUSED_ENTRY
+
+#define ICE_PTT(PTYPE, OUTER_IP, OUTER_IP_VER, OUTER_FRAG, T, TE, TEF, I, PL)\
+	[PTYPE] = XDP_RSS_L3_##OUTER_IP_VER | XDP_RSS_L4_##I | XDP_RSS_TYPE_##PL
+
+#define ICE_PTT_UNUSED_ENTRY(PTYPE) [PTYPE] = 0
+
+/* A few supplementary definitions for when XDP hash types do not coincide
+ * with what can be generated from ptype definitions
+ * by means of preprocessor concatenation.
+ */
+#define XDP_RSS_L3_NONE		XDP_RSS_TYPE_NONE
+#define XDP_RSS_L4_NONE		XDP_RSS_TYPE_NONE
+#define XDP_RSS_TYPE_PAY2	XDP_RSS_TYPE_L2
+#define XDP_RSS_TYPE_PAY3	XDP_RSS_TYPE_NONE
+#define XDP_RSS_TYPE_PAY4	XDP_RSS_L4
+
+static const enum xdp_rss_hash_type
+ice_ptype_to_xdp_hash[ICE_NUM_DEFINED_PTYPES] = {
+	ICE_PTYPES
+};
+
+#undef XDP_RSS_L3_NONE
+#undef XDP_RSS_L4_NONE
+#undef XDP_RSS_TYPE_PAY2
+#undef XDP_RSS_TYPE_PAY3
+#undef XDP_RSS_TYPE_PAY4
+
+#undef ICE_PTT
+#undef ICE_PTT_UNUSED_ENTRY
+
+/**
+ * ice_xdp_rx_hash_type - Get XDP-specific hash type from the RX descriptor
+ * @eop_desc: End of Packet descriptor
+ */
+static enum xdp_rss_hash_type
+ice_xdp_rx_hash_type(const union ice_32b_rx_flex_desc *eop_desc)
+{
+	u16 ptype = ice_get_ptype(eop_desc);
+
+	if (unlikely(ptype >= ICE_NUM_DEFINED_PTYPES))
+		return 0;
+
+	return ice_ptype_to_xdp_hash[ptype];
+}
+
+/**
+ * ice_xdp_rx_hash - RX hash XDP hint handler
+ * @ctx: XDP buff pointer
+ * @hash: hash destination address
+ * @rss_type: XDP hash type destination address
+ *
+ * Copy RX hash (if available) and its type to the destination address.
+ */
+static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+			   enum xdp_rss_hash_type *rss_type)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+
+	*hash = ice_get_rx_hash(xdp_ext->pkt_ctx.eop_desc);
+	*rss_type = ice_xdp_rx_hash_type(xdp_ext->pkt_ctx.eop_desc);
+	if (!likely(*hash))
+		return -ENODATA;
+
+	return 0;
+}
+
 const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
+	.xmo_rx_hash			= ice_xdp_rx_hash,
 };
diff --git a/include/net/xdp.h b/include/net/xdp.h
index d1c5381fc95f..6381560efae2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -417,6 +417,7 @@ enum xdp_rss_hash_type {
 	XDP_RSS_L4_UDP		= BIT(5),
 	XDP_RSS_L4_SCTP		= BIT(6),
 	XDP_RSS_L4_IPSEC	= BIT(7), /* L4 based hash include IPSEC SPI */
+	XDP_RSS_L4_ICMP		= BIT(8),
 
 	/* Second part: RSS hash type combinations used for driver HW mapping */
 	XDP_RSS_TYPE_NONE            = 0,
@@ -432,11 +433,13 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV4_UDP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
 	XDP_RSS_TYPE_L4_IPV4_SCTP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
 	XDP_RSS_TYPE_L4_IPV4_IPSEC   = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
+	XDP_RSS_TYPE_L4_IPV4_ICMP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
 
 	XDP_RSS_TYPE_L4_IPV6_TCP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_TCP,
 	XDP_RSS_TYPE_L4_IPV6_UDP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
 	XDP_RSS_TYPE_L4_IPV6_SCTP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
 	XDP_RSS_TYPE_L4_IPV6_IPSEC   = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
+	XDP_RSS_TYPE_L4_IPV6_ICMP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
 
 	XDP_RSS_TYPE_L4_IPV6_TCP_EX  = XDP_RSS_TYPE_L4_IPV6_TCP  | XDP_RSS_L3_DYNHDR,
 	XDP_RSS_TYPE_L4_IPV6_UDP_EX  = XDP_RSS_TYPE_L4_IPV6_UDP  | XDP_RSS_L3_DYNHDR,
-- 
2.41.0


