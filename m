Return-Path: <bpf+bounces-11602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505F7BC600
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A1282393
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0716A168CB;
	Sat,  7 Oct 2023 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lambda.lt header.i=@lambda.lt header.b="ZGH0afJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9llKY4d"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8114ABC;
	Sat,  7 Oct 2023 08:14:55 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0BC6;
	Sat,  7 Oct 2023 01:14:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D81993200A1D;
	Sat,  7 Oct 2023 04:14:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 07 Oct 2023 04:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1696666491; x=
	1696752891; bh=ZrHxhPVM9+43kzr1VYk9viRGE8X4Cmjfwp+t9zG2BMU=; b=Z
	GH0afJIgzwJyGvpn0xfMLNz/Bw86O7uryLbcNVlacFvr0ZxhyHY9MTkHG6mRFMxr
	9sgyTEy0kXeCzSdVaC2+CRfzBed68bdz+w6EImKPl0hmMzJ382QHHCTZC/zjenrd
	lh16g9dRP47HOmca/B6gRiPCpSVo+Hlt5w17VVp2acmYc8XBQXkv8UokhWaHikq3
	XcZEg+4cRNCNWEHrc28iNpuk0nnf1KMSZOhxqPeU4QD4+3etdLnNMx1GYmCHWwSf
	oD+4CegJNxxv6gl9/RY0groSUb5L5QQUHX0Vtio4l7GCPLfHahAB6p+ABwzkcUOs
	wA/ID9iud9wwQJEE44RhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696666491; x=
	1696752891; bh=ZrHxhPVM9+43kzr1VYk9viRGE8X4Cmjfwp+t9zG2BMU=; b=J
	9llKY4dZHxGiYafTZdSSoP9IajScQ+2NgoTOZqO+6FaCw/ex9HadFSpzunHjgNqy
	colOHCFJyr1AAJlUb+3pOzhRULMl8xayaUH3RPslQtxCKNDVf7LpJf4MnXq9LAex
	IvnJLxV4eBeG/BqM1DH+yy+ulK2+sjT4IY4q4dGxg1eWZV3zzg8L3DrI4sQccPMh
	6SlFpY2XJWPKT5n38aqDfiVbxeWUpSlg6vYSvO5NylJq89a0ex5DiZI78PnQQjOB
	11XxTSXBehRULCsLfXo+r6CvhS14wPdGgmjtY75ZE5cEXmpK2QJ//fw2Oc5BwKWh
	1gtxOH7GFO239JCz41bCQ==
X-ME-Sender: <xms:exMhZUxkC0zdZzJLnttYqHtDmKMLgPFdeENcvzPC60USkVKgAOL6Cg>
    <xme:exMhZYQY_EJGF2R3oDlx-nV_3U4nwUW21kEwjwAJeIbFUp_AH32nL6VRlYwvHw_W2
    wttp6QlxGKfqBOfEJ4>
X-ME-Received: <xmr:exMhZWVgbQyjTtGbeRejkXCmL-5pFwjP-4kdeACVxZFoRRjvJ2Kc8Hrw7UusTBMPr_tNp1zZqU62O9wDvmm7pZf5xD469ikDQVvhjTa4jrKrTJLi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepffeiffetgfejleetgedtteduveekudeftddtfeelkedvffehgeehfeevkeevieeh
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:exMhZSg1LEe0wo5sJCYNLLUICqt9m8AYRkMlTKTS6SVnxuqmpGAi3A>
    <xmx:exMhZWBWuPKtnLyQMwMBdBuNOX4NUpvsj9lxCMAiY7y1rCCbViga2Q>
    <xmx:exMhZTKjfVeUXUCsDXA3iX9nyoZf1A2JkKcu-VVXdrIHBg2dh16tVg>
    <xmx:exMhZZ_yW0Uq2WvR3e6-BpLhnZBHokQ7f_k2xJYaFf9OaF4Rczh24Q>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 04:14:49 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf v3 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Date: Sat,  7 Oct 2023 10:14:14 +0200
Message-ID: <20231007081415.33502-2-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007081415.33502-1-m@lambda.lt>
References: <20231007081415.33502-1-m@lambda.lt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend the bpf_fib_lookup() helper by making it to return the source
IPv4/IPv6 address if the BPF_FIB_LOOKUP_SRC flag is set.

For example, the following snippet can be used to derive the desired
source IP address:

    struct bpf_fib_lookup p = { .ipv4_dst = ip4->daddr };

    ret = bpf_skb_fib_lookup(skb, p, sizeof(p),
            BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH);
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
 include/net/ipv6_stubs.h       |  5 +++++
 include/uapi/linux/bpf.h       | 10 ++++++++++
 net/core/filter.c              | 18 +++++++++++++++++-
 net/ipv6/af_inet6.c            |  1 +
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index c48186bf4737..21da31e1dff5 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -85,6 +85,11 @@ struct ipv6_bpf_stub {
 			       sockptr_t optval, unsigned int optlen);
 	int (*ipv6_getsockopt)(struct sock *sk, int level, int optname,
 			       sockptr_t optval, sockptr_t optlen);
+	int (*ipv6_dev_get_saddr)(struct net *net,
+				  const struct net_device *dst_dev,
+				  const struct in6_addr *daddr,
+				  unsigned int prefs,
+				  struct in6_addr *saddr);
 };
 extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0448700890f7..0f5135eeee84 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3257,6 +3257,11 @@ union bpf_attr {
  *			and *params*->smac will not be set as output. A common
  *			use case is to call **bpf_redirect_neigh**\ () after
  *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
+ *			case *params*->dmac and *params*->smac are not set.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6953,6 +6958,7 @@ enum {
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 };
 
 enum {
@@ -6965,6 +6971,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6999,6 +7006,9 @@ struct bpf_fib_lookup {
 		__u32	rt_metric;
 	};
 
+	/* input: source address to consider for lookup
+	 * output: source address result from lookup
+	 */
 	union {
 		__be32		ipv4_src;
 		__u32		ipv6_src[4];  /* in6_addr; network order */
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..3880bf0b740d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5850,6 +5850,9 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	params->rt_metric = res.fi->fib_priority;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SRC)
+		params->ipv4_src = fib_result_prefsrc(net, &res);
+
 	/* xdp and cls_bpf programs are run in RCU-bh so
 	 * rcu_read_lock_bh is not needed here
 	 */
@@ -5992,6 +5995,18 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	params->rt_metric = res.f6i->fib6_metric;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SRC) {
+		if (res.f6i->fib6_prefsrc.plen) {
+			*src = res.f6i->fib6_prefsrc.addr;
+		} else {
+			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
+								&fl6.daddr, 0,
+								src);
+			if (err)
+				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
+		}
+	}
+
 	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
 		goto set_fwd_params;
 
@@ -6010,7 +6025,8 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
-			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID)
+			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
+			     BPF_FIB_LOOKUP_SRC)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 368824fe9719..5382c6543d46 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1060,6 +1060,7 @@ static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
 	.udp6_lib_lookup = __udp6_lib_lookup,
 	.ipv6_setsockopt = do_ipv6_setsockopt,
 	.ipv6_getsockopt = do_ipv6_getsockopt,
+	.ipv6_dev_get_saddr = ipv6_dev_get_saddr,
 };
 
 static int __init inet6_init(void)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0448700890f7..3392dd80474f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3257,6 +3257,11 @@ union bpf_attr {
  *			and *params*->smac will not be set as output. A common
  *			use case is to call **bpf_redirect_neigh**\ () after
  *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
+ *			case *params*->dmac and *params*->smac are not set.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6953,6 +6958,7 @@ enum {
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 };
 
 enum {
@@ -6965,6 +6971,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6999,6 +7006,10 @@ struct bpf_fib_lookup {
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


