Return-Path: <bpf+bounces-11687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E129F7BD6F3
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 11:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D97E2816E8
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B5416411;
	Mon,  9 Oct 2023 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="i1UoHY9m"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831323C0;
	Mon,  9 Oct 2023 09:27:07 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8FDE;
	Mon,  9 Oct 2023 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ocTO3pH2h41IV6q8jYj8bfEHgOz3hrbnpnCDEQZWoUY=; b=i1UoHY9mAyRcvy4uTMIPmJzvKY
	A1BOYv//PsxzFEQxfps5O2pPQULH8VVbP5XlzQEf/G2x3E6lUWFg67pdnY0aUjRtY276X2FtzHUXB
	JpGZKhtAoJdNTU4G16DsM4BhAJqoHjn6W1fakEwgCFt5JQN5vXsOm0p6ZRXEmaCsu6VnWqhUI13GD
	8cVsipvhY6BMx2ob9Vwgmf0+avMJ3yHZP7+V2EmgiAj2ms1Juq27fJZm1iNSFTJTcZOsL6tuDp2/N
	BXOMWn/5yPXshJtovdZWcBRAESrkGxvZxpmAfcwmHWfJaLtTKuBpcnhsA1JDC+Mwq7esiMMiI4XXL
	SyQ80kkQ==;
Received: from 27.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.27] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qpmXS-000MCf-K1; Mon, 09 Oct 2023 11:26:58 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	jhs@mojatatu.com,
	victor@mojatatu.com,
	martin.lau@linux.dev,
	dxu@dxuuu.xyz,
	xiyou.wangcong@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason more flexible
Date: Mon,  9 Oct 2023 11:26:54 +0200
Message-Id: <20231009092655.22025-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27056/Mon Oct  9 09:40:11 2023)
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
currently the tooling support is better, too.

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

Add a small helper tcf_set_drop_reason() which can be used to set the drop reason
into the tcf_result.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20231006063233.74345d36@kernel.org
---
 v1 -> v2:
   - Renamed tc_set_drop_reason -> tcf_set_drop_reason
   - Moved tcf_set_drop_reason into pkt_cls.h (Cong)

 include/net/pkt_cls.h     |  6 ++++++
 include/net/sch_generic.h |  3 +--
 net/core/dev.c            | 15 ++++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index f308e8268651..a76c9171db0e 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -154,6 +154,12 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
 	return xchg(clp, cl);
 }
 
+static inline void tcf_set_drop_reason(struct tcf_result *res,
+				       enum skb_drop_reason reason)
+{
+	res->drop_reason = reason;
+}
+
 static inline void
 __tcf_bind_filter(struct Qdisc *q, struct tcf_result *r, unsigned long base)
 {
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c7318c73cfd6..dcb9160e6467 100644
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


