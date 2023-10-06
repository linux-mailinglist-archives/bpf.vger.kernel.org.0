Return-Path: <bpf+bounces-11563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2113C7BBF95
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353D91C20BA4
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7073E46A;
	Fri,  6 Oct 2023 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="i/avGYiQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DF3AC2E;
	Fri,  6 Oct 2023 19:10:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1DB9;
	Fri,  6 Oct 2023 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=RbZNONu5gInerpLX+fVfpeTjKYHISNx3MMfUkZ8hEps=; b=i/avGYiQJOMTxcHpTrXpjyMAnb
	kGOQr9abYXOPPzU7PaUiTCE8UyzfeBdskRJiYxPgouV8UmperjrD6l1ZbklghfV0Tn8Z1jQi8Yd44
	2e+1H3NSeFC2RH7GlW7xVMFZhH9iDDzbQCmpx9fx0ngoT56MyPaVupCLv2GrOhLQE+K3UujhrAn3R
	8kEfN3nQEspRLpqZqz/gbc9iVTPDsOcoHXpj71VhqXRkkSyA/nW6x4AyBM9H94rBAnCZVtOf+z8ln
	VsMB9XOY3HoeF1UQ2HfRdFeejiyuHo7d9lhUng+GUuooweRbd3xCgFGbaf+5TWEk4tPlYPQWm/XXw
	1eJvXC6g==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qoqDD-0009PX-0g; Fri, 06 Oct 2023 21:10:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	jhs@mojatatu.com,
	victor@mojatatu.com,
	martin.lau@linux.dev,
	dxu@dxuuu.xyz,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next 1/2] net, tc: Make tc-related drop reason more flexible
Date: Fri,  6 Oct 2023 21:09:55 +0200
Message-Id: <20231006190956.18810-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the kfree_skb_reason() in sch_handle_{ingress,egress}() can only
express a basic SKB_DROP_REASON_TC_INGRESS or SKB_DROP_REASON_TC_EGRESS reason.

Victor kicked-off an initial proposal to make this more flexible by disambiguating
verdict from return code by moving the verdict into struct tcf_result and
letting tcf_classify() return a negative error. If hit, then two new drop
reasons were added in the proposal, that is SKB_DROP_REASON_TC_INGRESS_ERROR
as well as SKB_DROP_REASON_TC_EGRESS_ERROR. Further analysis of the actual
error codes would have required to attach to tcf_classify via kprobe/kretprobe
to more deeply debug skb and the returned error.

In order to make the kfree_skb_reason() in sch_handle_{ingress,egress}() more
extensible, it can be addressed in a more straight forward way, that is: Instead
of placing the verdict into struct tcf_result, we can just put the drop reason
in there, which does not require changes throughout various classful schedulers
given the existing verdict logic can stay as is.

Then, SKB_DROP_REASON_TC_ERROR{,_*} can be added to the enum skb_drop_reason
to disambiguate between an error or an intentional drop. New drop reason error
codes can be added successively to the tc code base.

For internal error locations which have not yet been annotated with a
SKB_DROP_REASON_TC_ERROR{,_*}, the fallback is SKB_DROP_REASON_TC_INGRESS and
SKB_DROP_REASON_TC_EGRESS, respectively. Generic errors could be marked with a
SKB_DROP_REASON_TC_ERROR code until they are converted to more specific ones
if it is found that they would be useful for troubleshooting.

While drop reasons have infrastructure for subsystem specific error codes which
are currently used by mac80211 and ovs, Jakub mentioned that it is preferred
for tc to use the enum skb_drop_reason core codes given it is a better fit and
currently the tooling support is better.

With regards to the latter:

  [...] I think Alastair (bpftrace) is working on auto-prettifying enums when
  bpftrace outputs maps. So we can do something like:

  $ bpftrace -e 'tracepoint:skb:kfree_skb { @[args->reason] = count(); }'
  Attaching 1 probe...
  ^C

  @[SKB_DROP_REASON_TC_INGRESS]: 2
  @[SKB_CONSUMED]: 34

  ^^^^^^^^^^^^ names!!

  Auto-magically. [...]

Add a small helper tc_set_drop_reason() which can be used to set the drop reason
into tcf_result.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20231006063233.74345d36@kernel.org
---
 include/net/sch_generic.h |  9 +++++++--
 net/core/dev.c            | 15 ++++++++++-----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c7318c73cfd6..90774cb2ac03 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -324,7 +324,6 @@ struct Qdisc_ops {
 	struct module		*owner;
 };
 
-
 struct tcf_result {
 	union {
 		struct {
@@ -332,8 +331,8 @@ struct tcf_result {
 			u32		classid;
 		};
 		const struct tcf_proto *goto_tp;
-
 	};
+	enum skb_drop_reason		drop_reason;
 };
 
 struct tcf_chain;
@@ -667,6 +666,12 @@ static inline int tc_classid_to_hwtc(struct net_device *dev, u32 classid)
 	return (hwtc < netdev_get_num_tc(dev)) ? hwtc : -EINVAL;
 }
 
+static inline void tc_set_drop_reason(struct tcf_result *res,
+				      enum skb_drop_reason reason)
+{
+	res->drop_reason = reason;
+}
+
 int qdisc_class_hash_init(struct Qdisc_class_hash *);
 void qdisc_class_hash_insert(struct Qdisc_class_hash *,
 			     struct Qdisc_class_common *);
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc209..664426285fa3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
 #endif /* CONFIG_NET_EGRESS */
 
 #ifdef CONFIG_NET_XGRESS
-static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
+static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
+		  enum skb_drop_reason *drop_reason)
 {
 	int ret = TC_ACT_UNSPEC;
 #ifdef CONFIG_NET_CLS_ACT
@@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
+	res.drop_reason = *drop_reason;
 
 	mini_qdisc_bstats_cpu_update(miniq, skb);
 	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
 	/* Only tcf related quirks below. */
 	switch (ret) {
 	case TC_ACT_SHOT:
+		*drop_reason = res.drop_reason;
 		mini_qdisc_qstats_cpu_drop(miniq);
 		break;
 	case TC_ACT_OK:
@@ -3977,6 +3980,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
 	int sch_ret;
 
 	if (!entry)
@@ -3994,7 +3998,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		if (sch_ret != TC_ACT_UNSPEC)
 			goto ingress_verdict;
 	}
-	sch_ret = tc_run(tcx_entry(entry), skb);
+	sch_ret = tc_run(tcx_entry(entry), skb, &drop_reason);
 ingress_verdict:
 	switch (sch_ret) {
 	case TC_ACT_REDIRECT:
@@ -4011,7 +4015,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		*ret = NET_RX_SUCCESS;
 		return NULL;
 	case TC_ACT_SHOT:
-		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
+		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_RX_DROP;
 		return NULL;
 	/* used by tc_run */
@@ -4032,6 +4036,7 @@ static __always_inline struct sk_buff *
 sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
 	int sch_ret;
 
 	if (!entry)
@@ -4045,7 +4050,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		if (sch_ret != TC_ACT_UNSPEC)
 			goto egress_verdict;
 	}
-	sch_ret = tc_run(tcx_entry(entry), skb);
+	sch_ret = tc_run(tcx_entry(entry), skb, &drop_reason);
 egress_verdict:
 	switch (sch_ret) {
 	case TC_ACT_REDIRECT:
@@ -4054,7 +4059,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		*ret = NET_XMIT_SUCCESS;
 		return NULL;
 	case TC_ACT_SHOT:
-		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
+		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_XMIT_DROP;
 		return NULL;
 	/* used by tc_run */
-- 
2.34.1


