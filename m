Return-Path: <bpf+bounces-11688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F57BD6F5
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 11:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F30E1C20BD8
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71303168A4;
	Mon,  9 Oct 2023 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="edyY+OY+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9B3D67;
	Mon,  9 Oct 2023 09:27:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8C1109;
	Mon,  9 Oct 2023 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4hv5dv1Eb94akuTr3AEp4L7fjW17wvcI8nFrS8Tsv5w=; b=edyY+OY+FamtmZcdUn3Mm7R08d
	8Me6TkT3iWgbPh+VgLnfaEwPdDliXu6XqwsLNAzdeP9h6fdwj7YipIHQSLNn2Ims9FKWZy/sonszq
	ru5j76+3G24iARQA3BLCryIsTc8VbKE9rorxisXXWMac7NsXMQfHLvYQNdO7rFBhFiJ64Qwvcgy88
	OoN8GSBudLlDp6IO0Sx2RO4QoyCdKXq9MRVscb7Z/p5To1ctx6GqA1FQ2OF5MxE2ptJHr4JpgFgI0
	Razx8nJV++J9XGAfRvzsCHDJsTXVKjZgRHyjAVf5By/ecmgQ9jHstsAR6wbIG8zCUarkdRGx5CdNd
	tErQczkA==;
Received: from 27.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.27] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qpmXT-000MDe-8V; Mon, 09 Oct 2023 11:26:59 +0200
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
Subject: [PATCH net-next v2 2/2] net, sched: Add tcf_set_drop_reason for {__,}tcf_classify
Date: Mon,  9 Oct 2023 11:26:55 +0200
Message-Id: <20231009092655.22025-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231009092655.22025-1-daniel@iogearbox.net>
References: <20231009092655.22025-1-daniel@iogearbox.net>
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

Add an initial user for the newly added tcf_set_drop_reason() helper to set the
drop reason for internal errors leading to TC_ACT_SHOT inside {__,}tcf_classify().

Right now this only adds a very basic SKB_DROP_REASON_TC_ERROR as a generic
fallback indicator to mark drop locations. Where needed, such locations can be
converted to more specific codes, for example, when hitting the reclassification
limit, etc.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 include/net/dropreason-core.h |  3 +++
 net/sched/cls_api.c           | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a587e83fc169..845dce805de7 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -80,6 +80,7 @@
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
+	FN(TC_ERROR)			\
 	FNe(MAX)
 
 /**
@@ -345,6 +346,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
 	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
 	SKB_DROP_REASON_QUEUE_PURGE,
+	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
+	SKB_DROP_REASON_TC_ERROR,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..1daeb2182b70 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1681,12 +1681,16 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 * time we got here with a cookie from hardware.
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
-				     !tp->ops->get_exts))
+				     !tp->ops->get_exts)) {
+				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
+			}
 
 			exts = tp->ops->get_exts(tp, n->handle);
-			if (unlikely(!exts || n->exts != exts))
+			if (unlikely(!exts || n->exts != exts)) {
+				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
+			}
 
 			n = NULL;
 			err = tcf_exts_exec_ex(skb, exts, act_index, res);
@@ -1712,8 +1716,10 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			return err;
 	}
 
-	if (unlikely(n))
+	if (unlikely(n)) {
+		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
+	}
 
 	return TC_ACT_UNSPEC; /* signal: continue lookup */
 #ifdef CONFIG_NET_CLS_ACT
@@ -1723,6 +1729,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
+		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1759,8 +1766,10 @@ int tcf_classify(struct sk_buff *skb,
 			if (ext->act_miss) {
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
-				if (!n)
+				if (!n) {
+					tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 					return TC_ACT_SHOT;
+				}
 
 				chain = n->chain_index;
 			} else {
@@ -1768,8 +1777,10 @@ int tcf_classify(struct sk_buff *skb,
 			}
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
-			if (!fchain)
+			if (!fchain) {
+				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
+			}
 
 			/* Consume, so cloned/redirect skbs won't inherit ext */
 			skb_ext_del(skb, TC_SKB_EXT);
@@ -1788,8 +1799,11 @@ int tcf_classify(struct sk_buff *skb,
 			struct tc_skb_cb *cb = tc_skb_cb(skb);
 
 			ext = tc_skb_ext_alloc(skb);
-			if (WARN_ON_ONCE(!ext))
+			if (WARN_ON_ONCE(!ext)) {
+				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
+			}
+
 			ext->chain = last_executed_chain;
 			ext->mru = cb->mru;
 			ext->post_ct = cb->post_ct;
-- 
2.34.1


