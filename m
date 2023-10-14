Return-Path: <bpf+bounces-12225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED67C95D5
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ACC281E94
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C9224F8;
	Sat, 14 Oct 2023 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="avllHDy6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE91F5F6
	for <bpf@vger.kernel.org>; Sat, 14 Oct 2023 18:09:34 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17354BB
	for <bpf@vger.kernel.org>; Sat, 14 Oct 2023 11:09:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c8a1541232so28059555ad.0
        for <bpf@vger.kernel.org>; Sat, 14 Oct 2023 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697306971; x=1697911771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVMVJ4jemtqM/CFZTAq6R0IqmrJOLFnJjsPA7/6qbLE=;
        b=avllHDy6DZkfkYVQV7a05q1g8l4jD2iUeKWC/YRIEVMjw70BfR+Z1dAg/ZgO7gVLf4
         3OE/valsG8Dwsxy+jYOpYTkpqOtCkDzSy+yA45bhPCL2hNc4u47Cwa/mrVB2Kro3WSd7
         97CgKvZjB+d4OPl+gVZvVNUidLaZOOSz7s6ZRTbgYvyLrq7p4W+zL68XsvKu0wjM5Bpd
         YTBDa74Au4irmSNwlpOQU3JhvjlRETAItvb6xUx+Ay5H0h3CBsIH6k8eUCDnFm1p7NcP
         9J9NZlTwryeq0lCqWctG5yOkwzg/e9jyKSmoD9u3JdqM2G1IE+YBqEjTOxU1Pb9jLHvS
         wZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697306971; x=1697911771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVMVJ4jemtqM/CFZTAq6R0IqmrJOLFnJjsPA7/6qbLE=;
        b=qUDBCXWXR1iq7jxMU5kqsG3D6aeHCs9ZY1KIpDFKRFFRhx48WL8KM4epL/AtnF8Bcy
         ww/SntKWXy8U3rueKr1jYoFk+v9UnLKq64h4G3nREfk8F4Nzn+LofGoQFMSJt6a3X93N
         RdNDUYkYx44cl+xZsj2u/m0oTpniVaOl8pA5v8Rx89Xld609+64k/43FsacllJVWKzto
         yrbrwWvSkZgUWb3xAEnAmVbKEbgT2lrLSVS5YXUiP8AuxyzPnCUMV5FdEVG16Sywd0kI
         pSTz+EPCjhBHjn0YTIHe9u1ZNTC/0njfqOx/Iu6/w9GyKHfuGGEwJGRcB0syXMpYvK/y
         GGWg==
X-Gm-Message-State: AOJu0YxuVE4Nj4pIrlQ/25vgu7HLz4FVhK1SjfhletM+dLewzNOMHSnw
	Peko72HxMzV8Q9uYXICMhze5Og==
X-Google-Smtp-Source: AGHT+IGP+2HUJHxVq7X7jNQXWKW5WkisfpKGloa2zrGNHR8NbBfmW4BBWCaDJtaNYmDLl7eSFmw3uw==
X-Received: by 2002:a17:902:f688:b0:1c9:e830:160d with SMTP id l8-20020a170902f68800b001c9e830160dmr7878747plg.22.1697306971311;
        Sat, 14 Oct 2023 11:09:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:efb6:effb:2e2a:5b29:df5])
        by smtp.gmail.com with ESMTPSA id ij6-20020a170902ab4600b001c0c79b386esm5955826plb.95.2023.10.14.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 11:09:30 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	paulb@nvidia.com
Cc: bpf@vger.kernel.org,
	mleitner@redhat.com,
	martin.lau@linux.dev,
	dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH RFC net-next v2 1/1] net: sched: Disambiguate verdict from return code
Date: Sat, 14 Oct 2023 15:09:21 -0300
Message-ID: <20231014180921.833820-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently there is no way to distinguish between an error and a
classification verdict. Which has caused us a lot of pain with buggy qdiscs
and syzkaller. This patch does 2 things - one is it disambiguates between
an error and policy decisions. The reasons are added under the auspices of
skb drop reason. We add the drop reason as a part of struct tcf_result.
That way, tcf_classify can set a proper drop reason when it fails,
and we keep the classification result as the tcf_classify's return value.

This patch also adds a variety of drop reasons which are more fine grained
on why a packet was dropped by the TC classification action subsystem.

Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---

v1 -> v2:
- Make tcf_classify set drop reason instead of verdict in struct
  tcf_result
- Make tcf_classify return verdict (as it was doing before)
- Only initialise struct tcf_result in tc_run
- Add new drop reasons specific to TC
- Merged v1 patch with Daniel's patch (https://lore.kernel.org/bpf/20231013141722.21165ef3@kernel.org/T/)
  for completeness

 include/net/dropreason-core.h | 26 ++++++++++++++++++++++++
 include/net/pkt_cls.h         |  6 ++++++
 include/net/sch_generic.h     |  3 +--
 net/core/dev.c                | 17 ++++++++++------
 net/sched/cls_api.c           | 37 +++++++++++++++++++++++++++++------
 net/sched/sch_ets.c           |  4 +---
 net/sched/sch_fq_codel.c      |  4 +---
 net/sched/sch_fq_pie.c        |  4 +---
 net/sched/sch_hfsc.c          |  4 +---
 net/sched/sch_htb.c           |  6 +-----
 net/sched/sch_multiq.c        |  6 +-----
 net/sched/sch_prio.c          |  6 +-----
 net/sched/sch_qfq.c           |  4 +---
 net/sched/sch_sfb.c           |  4 +---
 net/sched/sch_sfq.c           |  4 +---
 15 files changed, 85 insertions(+), 50 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a587e83fc169..fe479f75aa1f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -80,6 +80,12 @@
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
+	FN(TC_EXT_COOKIE_NOTFOUND)	\
+	FN(TC_COOKIE_EXT_MISMATCH)	\
+	FN(TC_COOKIE_MISMATCH)		\
+	FN(TC_CHAIN_NOTFOUND)		\
+	FN(TC_ALLOC_SKB_EXT)		\
+	FN(TC_RECLASSIFY_LOOP)		\
 	FNe(MAX)
 
 /**
@@ -345,6 +351,26 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
 	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
 	SKB_DROP_REASON_QUEUE_PURGE,
+	/** @SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was lookuped using ext,
+	 * but was not found.
+	 */
+	SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND,
+	/** @SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was lookup using cookie and
+	 * either was not found or different from expected.
+	 */
+	SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH,
+	/** @SKB_DROP_REASON_TC_COOKIE_MISMATCH: tc cookie available but was
+	 * unable to match to filter.
+	 */
+	SKB_DROP_REASON_TC_COOKIE_MISMATCH,
+	/** @SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed. */
+	SKB_DROP_REASON_TC_CHAIN_NOTFOUND,
+	/** @SKB_DROP_REASON_TC_ALLOC_SKB_EXT: tc failed to allocate skb ext. */
+	SKB_DROP_REASON_TC_ALLOC_SKB_EXT,
+	/** @SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify
+	 * loop iterations.
+	 */
+	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
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
index 606a366cc209..8b899d0a79df 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3910,24 +3910,27 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
 #endif /* CONFIG_NET_EGRESS */
 
 #ifdef CONFIG_NET_XGRESS
-static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
+static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
+		  enum skb_drop_reason *drop_reason)
 {
 	int ret = TC_ACT_UNSPEC;
 #ifdef CONFIG_NET_CLS_ACT
 	struct mini_Qdisc *miniq = rcu_dereference_bh(entry->miniq);
-	struct tcf_result res;
+	struct tcf_result res = {0};
 
 	if (!miniq)
 		return ret;
 
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
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..f3b2b6d2d3ad 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1681,12 +1681,20 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 * time we got here with a cookie from hardware.
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
-				     !tp->ops->get_exts))
+				     !tp->ops->get_exts)) {
+				u32 drop_reason = SKB_DROP_REASON_TC_COOKIE_MISMATCH;
+
+				tcf_set_drop_reason(res, drop_reason);
 				return TC_ACT_SHOT;
+			}
 
 			exts = tp->ops->get_exts(tp, n->handle);
-			if (unlikely(!exts || n->exts != exts))
+			if (unlikely(!exts || n->exts != exts)) {
+				u32 drop_reason = SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH;
+
+				tcf_set_drop_reason(res, drop_reason);
 				return TC_ACT_SHOT;
+			}
 
 			n = NULL;
 			err = tcf_exts_exec_ex(skb, exts, act_index, res);
@@ -1712,8 +1720,11 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			return err;
 	}
 
-	if (unlikely(n))
+	if (unlikely(n)) {
+		tcf_set_drop_reason(res,
+				    SKB_DROP_REASON_TC_COOKIE_MISMATCH);
 		return TC_ACT_SHOT;
+	}
 
 	return TC_ACT_UNSPEC; /* signal: continue lookup */
 #ifdef CONFIG_NET_CLS_ACT
@@ -1723,6 +1734,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
+		tcf_set_drop_reason(res,
+				    SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
 		return TC_ACT_SHOT;
 	}
 
@@ -1759,7 +1772,10 @@ int tcf_classify(struct sk_buff *skb,
 			if (ext->act_miss) {
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
-				if (!n)
+				if (!n) {
+					u32 drop_reason = SKB_TC_EXT_COOKIE_NOTFOUND;
+
+					tcf_set_drop_reason(res, drop_reason);
 					return TC_ACT_SHOT;
 
 				chain = n->chain_index;
@@ -1768,8 +1784,13 @@ int tcf_classify(struct sk_buff *skb,
 			}
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
-			if (!fchain)
+			if (!fchain) {
+				u32 drop_reason = SKB_DROP_REASON_TC_CHAIN_NOTFOUND;
+
+				tcf_set_drop_reason(res, drop_reason);
+
 				return TC_ACT_SHOT;
+			}
 
 			/* Consume, so cloned/redirect skbs won't inherit ext */
 			skb_ext_del(skb, TC_SKB_EXT);
@@ -1788,8 +1809,12 @@ int tcf_classify(struct sk_buff *skb,
 			struct tc_skb_cb *cb = tc_skb_cb(skb);
 
 			ext = tc_skb_ext_alloc(skb);
-			if (WARN_ON_ONCE(!ext))
+			if (WARN_ON_ONCE(!ext)) {
+				u32 drop_reason = SKB_TC_ALLOC_SKB_EXT;
+
+				tcf_set_drop_reason(res, drop_reason);
 				return TC_ACT_SHOT;
+			}
 			ext->chain = last_executed_chain;
 			ext->mru = cb->mru;
 			ext->post_ct = cb->post_ct;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index b10efeaf0629..e5e3e3834016 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -374,8 +374,8 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct ets_sched *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	u32 band = skb->priority;
-	struct tcf_result res;
 	struct tcf_proto *fl;
 	int err;
 
@@ -383,7 +383,6 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
 		err = tcf_classify(skb, NULL, fl, &res, false);
-#ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
@@ -393,7 +392,6 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_SHOT:
 			return NULL;
 		}
-#endif
 		if (!fl || err < 0) {
 			if (TC_H_MAJ(band))
 				band = 0;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 8c4fee063436..b95fac441ed2 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -77,8 +77,8 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct tcf_proto *filter;
-	struct tcf_result res;
 	int result;
 
 	if (TC_H_MAJ(skb->priority) == sch->handle &&
@@ -93,7 +93,6 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify(skb, NULL, filter, &res, false);
 	if (result >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
@@ -103,7 +102,6 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_SHOT:
 			return 0;
 		}
-#endif
 		if (TC_H_MIN(res.classid) <= q->flows_cnt)
 			return TC_H_MIN(res.classid);
 	}
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 68e6acd0f130..9967d31f2c4e 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -81,8 +81,8 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 				    int *qerr)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct tcf_proto *filter;
-	struct tcf_result res;
 	int result;
 
 	if (TC_H_MAJ(skb->priority) == sch->handle &&
@@ -97,7 +97,6 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify(skb, NULL, filter, &res, false);
 	if (result >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
@@ -107,7 +106,6 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_SHOT:
 			return 0;
 		}
-#endif
 		if (TC_H_MIN(res.classid) <= q->flows_cnt)
 			return TC_H_MIN(res.classid);
 	}
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3554085bc2be..d32e85b6b1f0 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1122,7 +1122,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 {
 	struct hfsc_sched *q = qdisc_priv(sch);
 	struct hfsc_class *head, *cl;
-	struct tcf_result res;
+	struct tcf_result res = {0};
 	struct tcf_proto *tcf;
 	int result;
 
@@ -1135,7 +1135,6 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	head = &q->root;
 	tcf = rcu_dereference_bh(q->root.filter_list);
 	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
 		case TC_ACT_STOLEN:
@@ -1145,7 +1144,6 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 		case TC_ACT_SHOT:
 			return NULL;
 		}
-#endif
 		cl = (struct hfsc_class *)res.class;
 		if (!cl) {
 			cl = hfsc_find_class(res.classid, sch);
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 0d947414e616..e762d53bb469 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -220,8 +220,8 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct htb_sched *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct htb_class *cl;
-	struct tcf_result res;
 	struct tcf_proto *tcf;
 	int result;
 
@@ -243,7 +243,6 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
 		case TC_ACT_STOLEN:
@@ -253,7 +252,6 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_SHOT:
 			return NULL;
 		}
-#endif
 		cl = (void *)res.class;
 		if (!cl) {
 			if (res.classid == sch->handle)
@@ -631,13 +629,11 @@ static int htb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		} else {
 			return qdisc_drop(skb, sch, to_free);
 		}
-#ifdef CONFIG_NET_CLS_ACT
 	} else if (!cl) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
-#endif
 	} else if ((ret = qdisc_enqueue(skb, cl->leaf.q,
 					to_free)) != NET_XMIT_SUCCESS) {
 		if (net_xmit_drop_count(ret)) {
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 75c9c860182b..e6c4e64f18b3 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -30,14 +30,13 @@ static struct Qdisc *
 multiq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 {
 	struct multiq_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	u32 band;
-	struct tcf_result res;
 	struct tcf_proto *fl = rcu_dereference_bh(q->filter_list);
 	int err;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	err = tcf_classify(skb, NULL, fl, &res, false);
-#ifdef CONFIG_NET_CLS_ACT
 	switch (err) {
 	case TC_ACT_STOLEN:
 	case TC_ACT_QUEUED:
@@ -47,7 +46,6 @@ multiq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	case TC_ACT_SHOT:
 		return NULL;
 	}
-#endif
 	band = skb_get_queue_mapping(skb);
 
 	if (band >= q->bands)
@@ -64,7 +62,6 @@ multiq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	int ret;
 
 	qdisc = multiq_classify(skb, sch, &ret);
-#ifdef CONFIG_NET_CLS_ACT
 	if (qdisc == NULL) {
 
 		if (ret & __NET_XMIT_BYPASS)
@@ -72,7 +69,6 @@ multiq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
-#endif
 
 	ret = qdisc_enqueue(skb, qdisc, to_free);
 	if (ret == NET_XMIT_SUCCESS) {
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index fdc5ef52c3ee..3b0fa2fc6926 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -31,8 +31,8 @@ static struct Qdisc *
 prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 {
 	struct prio_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	u32 band = skb->priority;
-	struct tcf_result res;
 	struct tcf_proto *fl;
 	int err;
 
@@ -40,7 +40,6 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
 		err = tcf_classify(skb, NULL, fl, &res, false);
-#ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
@@ -50,7 +49,6 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 		case TC_ACT_SHOT:
 			return NULL;
 		}
-#endif
 		if (!fl || err < 0) {
 			if (TC_H_MAJ(band))
 				band = 0;
@@ -73,7 +71,6 @@ prio_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	int ret;
 
 	qdisc = prio_classify(skb, sch, &ret);
-#ifdef CONFIG_NET_CLS_ACT
 	if (qdisc == NULL) {
 
 		if (ret & __NET_XMIT_BYPASS)
@@ -81,7 +78,6 @@ prio_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
-#endif
 
 	ret = qdisc_enqueue(skb, qdisc, to_free);
 	if (ret == NET_XMIT_SUCCESS) {
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 546c10adcacd..9be6c34aff7e 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -680,8 +680,8 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct qfq_class *cl;
-	struct tcf_result res;
 	struct tcf_proto *fl;
 	int result;
 
@@ -696,7 +696,6 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 	fl = rcu_dereference_bh(q->filter_list);
 	result = tcf_classify(skb, NULL, fl, &res, false);
 	if (result >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
 		case TC_ACT_STOLEN:
@@ -706,7 +705,6 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_SHOT:
 			return NULL;
 		}
-#endif
 		cl = (struct qfq_class *)res.class;
 		if (cl == NULL)
 			cl = qfq_find_class(sch, res.classid);
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 1871a1c0224d..10684fcb5418 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -254,12 +254,11 @@ static bool sfb_rate_limit(struct sk_buff *skb, struct sfb_sched_data *q)
 static bool sfb_classify(struct sk_buff *skb, struct tcf_proto *fl,
 			 int *qerr, u32 *salt)
 {
-	struct tcf_result res;
+	struct tcf_result res = {0};
 	int result;
 
 	result = tcf_classify(skb, NULL, fl, &res, false);
 	if (result >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
@@ -269,7 +268,6 @@ static bool sfb_classify(struct sk_buff *skb, struct tcf_proto *fl,
 		case TC_ACT_SHOT:
 			return false;
 		}
-#endif
 		*salt = TC_H_MIN(res.classid);
 		return true;
 	}
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 66dcb18638fe..3fba247201ef 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -164,7 +164,7 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 				 int *qerr)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
-	struct tcf_result res;
+	struct tcf_result res = {0};
 	struct tcf_proto *fl;
 	int result;
 
@@ -180,7 +180,6 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify(skb, NULL, fl, &res, false);
 	if (result >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
@@ -190,7 +189,6 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_SHOT:
 			return 0;
 		}
-#endif
 		if (TC_H_MIN(res.classid) <= q->divisor)
 			return TC_H_MIN(res.classid);
 	}
-- 
2.25.1


