Return-Path: <bpf+bounces-11112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAD7B365C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8392EB20D29
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3751B86;
	Fri, 29 Sep 2023 15:08:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A876C2CF;
	Fri, 29 Sep 2023 15:08:03 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2DFDE;
	Fri, 29 Sep 2023 08:08:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 41B1B5C2616;
	Fri, 29 Sep 2023 11:08:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 29 Sep 2023 11:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1696000081; x=
	1696086481; bh=3FI4eDbxM43bVbKjrlxha4v/ndcIVOL5uf/jOZIvigc=; b=t
	68MYFm0ga6RzPmkpQc0PuI9ITefUyeFnrwNlDVhQt9J/54aeGeOCB4e8pyqh688P
	QM+yhr3ev2CJBrsQjRRiDwhLrp/wm6w1lzBF/QgnspEcYO5mhv65yy7rhW8SDAJa
	+7GGl2dd/cjfjeh90MiMfzcfLDVUqalCn/WWqG/ek+EUUZcpTmMO7G4VDOIPN00l
	X+Gu9gLxAVlr3AOpFI3DDEHtZCWYEXi/KtVREiEfZbUoLYKPhz3ZgK1Ctfue1ABe
	zmIXE5G6wRX7xM77svXUNc+qj41IXp4aAglfmoHoHTIfpBi4IiXw/i3y+00vHpL5
	8IdXMVIudTqhKvCCNbcZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696000081; x=
	1696086481; bh=3FI4eDbxM43bVbKjrlxha4v/ndcIVOL5uf/jOZIvigc=; b=h
	r3pBpLR0T0ID1tY3DMbB0FlYS4Trl4i+5wqOZ+AFVqG2fqxhaP666eEC3R6/aFb6
	mmCp5L1XcPhM/MvHOAdRy0cyoynypHT0T7pCM+vIQSc0/VmFt6Mt3hszdz2lPlmm
	FWWoVRUfsGpelpEoFxtOt5MrX4o+d3AHeShrMqhr+RSe9mOJVcbnhMHVOBnUwcjo
	kkfFy4jEQcgiR3UaKj2IqrE+Yvh/aELDvc/CY3KCJta02P78Eic4mSAesuM7b4bA
	ldBMJTM5Jfyw6U/KbGvmml89hmWDMGIfL/hBAOqxfpudLHNRvAVxZ/KIbtfPi0c9
	4b1NyXTyTkBvWRuXy6C0Q==
X-ME-Sender: <xms:SugWZXK_MMIPi85QNEVIxmQ2AE0sRavW8dboJ7VNP9lrtStbTl7HOA>
    <xme:SugWZbIL0Bu-WOKzoks7R_1k3xPZWQ4VzVhMoLaUptOO9WUd0Tw8xAOUf3Sb7dczl
    o3fSAdR4HWQVUEsFog>
X-ME-Received: <xmr:SugWZfs-j90Qk9Ol6iDIHGhuBe4-39vLR5nSrGxCSVG-B4_YwPnoVHkT8FMIg3UP1RyFozgxdcP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepffeiffetgfejleetgedtteduveekudeftddtfeelkedvffehgeehfeevkeevieeh
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:SugWZQa_2gYfhDiz6ZMiPrxaAR4bzoegkbFVOsWam1QZw2MRjyI7gA>
    <xmx:SugWZeZ9jvwTdP9W4vtAof-8kbcrmic_mhoYmJuSjs5eTy9ZhxcSZg>
    <xmx:SugWZUDbtpKRT0Ec3TXaT0uD6bekLdoaCIrIrUIP1uIb-EfOgufRwg>
    <xmx:UegWZVVtgVIurvjo0rhleLilT3YMLPM1L0VlsqLR3wVOpzhvM8GTCA>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 11:07:52 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Date: Fri, 29 Sep 2023 17:07:16 +0200
Message-ID: <20230929150717.120463-2-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929150717.120463-1-m@lambda.lt>
References: <20230929150717.120463-1-m@lambda.lt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend the bpf_fib_lookup() helper by making it to return the source
IPv4/IPv6 address if the BPF_FIB_LOOKUP_SET_SRC flag is set.

For example, the following snippet can be used to derive the desired
source IP address:

    struct bpf_fib_lookup p = { .ipv4_dst = ip4->daddr };

    ret = bpf_skb_fib_lookup(skb, p, sizeof(p),
            BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH);
    if (ret != BPF_FIB_LKUP_RET_SUCCESS)
        return TC_ACT_SHOT;

    /* the p.ipv4_src now contains the source address */

The inability to derive the proper source address may cause malfunctions
in BPF-based dataplanes for hosts containing netdevs with more than one
routable IP address or for multi-homed hosts.

For example, Cilium implements packet masquerading in BPF. If an
egressing netdev to which the Cilium's BPF prog is attached has
multiple IP addresses, then only one [hardcoded] IP address can be used for
masquerading. This breaks connectivity if any other IP address should have
been selected instead, for example, when a public and private addresses
are attached to the same egress interface.

The change was tested with Cilium [1].

Nikolay Aleksandrov helped to figure out the IPv6 addr selection.

[1]: https://github.com/cilium/cilium/pull/28283

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 include/uapi/linux/bpf.h       |  9 +++++++++
 net/core/filter.c              | 13 ++++++++++++-
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0448700890f7..a6bf686eecbc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3257,6 +3257,10 @@ union bpf_attr {
  *			and *params*->smac will not be set as output. A common
  *			use case is to call **bpf_redirect_neigh**\ () after
  *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SET_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6953,6 +6957,7 @@ enum {
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SET_SRC = (1U << 4),
 };
 
 enum {
@@ -6965,6 +6970,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6999,6 +7005,9 @@ struct bpf_fib_lookup {
 		__u32	rt_metric;
 	};
 
+	/* input: source address to consider for lookup
+	 * output: source address result from lookup
+	 */
 	union {
 		__be32		ipv4_src;
 		__u32		ipv6_src[4];  /* in6_addr; network order */
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..e9cdcf49df62 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5850,6 +5850,9 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	params->rt_metric = res.fi->fib_priority;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SET_SRC)
+		params->ipv4_src = fib_result_prefsrc(net, &res);
+
 	/* xdp and cls_bpf programs are run in RCU-bh so
 	 * rcu_read_lock_bh is not needed here
 	 */
@@ -5992,6 +5995,13 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	params->rt_metric = res.f6i->fib6_metric;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SET_SRC) {
+		err = ip6_route_get_saddr(net, res.f6i, &fl6.daddr, 0,
+					  (struct in6_addr *)&params->ipv6_src);
+		if (err)
+			return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
+	}
+
 	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
 		goto set_fwd_params;
 
@@ -6010,7 +6020,8 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
-			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID)
+			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
+			     BPF_FIB_LOOKUP_SET_SRC)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0448700890f7..72cd0ca97689 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3257,6 +3257,10 @@ union bpf_attr {
  *			and *params*->smac will not be set as output. A common
  *			use case is to call **bpf_redirect_neigh**\ () after
  *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SET_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6953,6 +6957,7 @@ enum {
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SET_SRC = (1U << 4),
 };
 
 enum {
@@ -6965,6 +6970,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6999,6 +7005,10 @@ struct bpf_fib_lookup {
 		__u32	rt_metric;
 	};
 
+
+	/* input: source address to consider for lookup
+	 * output: source address result from lookup
+	 */
 	union {
 		__be32		ipv4_src;
 		__u32		ipv6_src[4];  /* in6_addr; network order */
-- 
2.42.0


