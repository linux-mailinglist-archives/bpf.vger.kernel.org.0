Return-Path: <bpf+bounces-11248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4C7B6240
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AE261281AB8
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 07:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D29D28D;
	Tue,  3 Oct 2023 07:10:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101EED270;
	Tue,  3 Oct 2023 07:10:46 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DAD10A;
	Tue,  3 Oct 2023 00:10:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E94555C0327;
	Tue,  3 Oct 2023 03:10:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Oct 2023 03:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1696317043; x=
	1696403443; bh=6oShYutR0xb1seJg1U46ZCkjGsG9F3gMW3ba8RkEXnY=; b=I
	2iJBIlYqOu5xaeiR1scthYSAKc3cs2N5RXVghHxZE75D5aeHAnLvcYL8RIxSaYqC
	+RDjOK7gnvVcot7XrzXwbKxMnmNnOC/5W7roy1fh8rddNodVRHnEgDbxgnMNvfPN
	HEoYsmS7lEBgLVMC96YkFGWJ7F+jdSBPZaHXcW86sKrhxAP1aKGsSySMPDiV2d3r
	8Ny138kTRaBBVU6bBGMZWdTRHuCRCcfoqIWKOHGlQVY2VipHbrGG0YScewn5D8SN
	YvV6Q6448vZzFeharV2NXBE+XzhhFsdcnD5Pl8lCbn0lqnrqkqE/geKAA2Dn+FFa
	5i16Wgn5riL3p1TjjfnwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696317043; x=
	1696403443; bh=6oShYutR0xb1seJg1U46ZCkjGsG9F3gMW3ba8RkEXnY=; b=n
	bZzY3AvR4MmDMGTLFsDDAGGQdG1rfuBSxyL6X4hBpmnUdqZ452OoGKZoTpltYZOi
	6eifkyT14gRDGHKSJW77jA52DcRu6UHOZW9DgDb5cAaHyhUCeEKQaU9A5cpxn/4o
	774BCD98s1j7qElfP2V2oO4+hcUqQVqqHq/GwIDOBobHaeLcInlFA5KWlZEOpY09
	UQC5cLjXg5n5S0TdvfS+vCH6jQ9U/V69mcnJ8Bkdsi6gmgnva1a48oqpKQIS6+/f
	pHNEzQ+A2/GmvEXl5HVCDjfTX6zy/NPzZ4i/LbynKPmtibXsv4YL4yrL9qSjxydG
	sEh6sR0ClwPFeeQ5lc2jA==
X-ME-Sender: <xms:c74bZappZREIn__-ABGvicEHVzOJvgMOF8DVUP7Mwe0Z4UDyu55mDw>
    <xme:c74bZYrVyqFlDkASjGEhmtemhN_9IvnchazvOUXGJ55NFQ-g9UbKoExLubnqd2gUW
    F5hMu9jKABp-ihlmgQ>
X-ME-Received: <xmr:c74bZfM_z53qGqQEZt7GldkkpqeQ-lxpMvHAKMynO2_UBVtW-7cXaevhn-8KWXAF4VvIRobEPcgp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepffeiffetgfejleetgedtteduveekudeftddtfeelkedvffehgeehfeevkeevieeh
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:c74bZZ74mVcSkILPb5e_jyjDej_gVVwCApqCVGlkBzI6t8HSCLXzng>
    <xmx:c74bZZ6T2BOVz9ZHG5IWmEgMRy9K_5DoAqZqEgfHhS6Jh8MAvY7MJA>
    <xmx:c74bZZhqZaLTXIgv7z6sI2bmXAuMgjyi15gAeYCOLhwMJ-koOd3r6g>
    <xmx:c74bZc0cy5UYopZWb__Uq-uTQQH-RLsrKx2eJ0OuTBfji7NHqRbGzQ>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 03:10:42 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf v2 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Date: Tue,  3 Oct 2023 09:10:12 +0200
Message-ID: <20231003071013.824623-2-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003071013.824623-1-m@lambda.lt>
References: <20231003071013.824623-1-m@lambda.lt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
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
 include/net/ipv6_stubs.h       |  5 +++++
 include/uapi/linux/bpf.h       |  9 +++++++++
 net/core/filter.c              | 19 ++++++++++++++++++-
 net/ipv6/af_inet6.c            |  1 +
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 5 files changed, 43 insertions(+), 1 deletion(-)

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
index a094694899c9..f3777ef1840b 100644
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
@@ -5992,6 +5995,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	params->rt_metric = res.f6i->fib6_metric;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SET_SRC) {
+		if (res.f6i->fib6_prefsrc.plen) {
+			*(struct in6_addr *)params->ipv6_src = res.f6i->fib6_prefsrc.addr;
+		} else {
+			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
+								&fl6.daddr, 0,
+								(struct in6_addr *)
+								params->ipv6_src);
+			if (err)
+				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
+		}
+	}
+
 	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
 		goto set_fwd_params;
 
@@ -6010,7 +6026,8 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
-			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID)
+			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
+			     BPF_FIB_LOOKUP_SET_SRC)
 
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


