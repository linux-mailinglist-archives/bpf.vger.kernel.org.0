Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9E9F6216
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2019 03:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKJCCP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Nov 2019 21:02:15 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43019 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726537AbfKJCCP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 Nov 2019 21:02:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0ThbLYBI_1573351320;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0ThbLYBI_1573351320)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 10 Nov 2019 10:02:09 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com,
        Wen Yang <wenyang@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Kevin Athey <kda@google.com>,
        Xiaotian Pei <xiaotian@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: core: fix unbalanced qdisc_run_begin/qdisc_run_end
Date:   Sun, 10 Nov 2019 10:01:49 +0800
Message-Id: <20191110020149.65307-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

3598 static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
3599                                  struct net_device *dev,
3600                                  struct netdev_queue *txq)
3601 {
...
3650         } else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
3651                    qdisc_run_begin(q)) {

---> Those multiple *and conditions* in this if statement are not
     necessarily executed sequentially. If the qdisc_run_begin(q)
     statement is executed first and the other conditions are not
     satisfied, qdisc_run_end will have no chance to be executed,
     and the lowest bit of q->running will always be 1.
     This may lead to a softlockup:
     https://bugzilla.kernel.org/show_bug.cgi?id=205427
...
3657
3658                 qdisc_bstats_update(q, skb);
...
3661                         if (unlikely(contended)) {
3662                                 spin_unlock(&q->busylock);
3663                                 contended = false;
3664                         }
3665                         __qdisc_run(q);
3666                 }
3667
3668                 qdisc_run_end(q);
3669                 rc = NET_XMIT_SUCCESS;
3670         }
...

We ensure the correct execution order by explicitly
specifying those dependencies.
Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Kevin Athey <kda@google.com>
Cc: Xiaotian Pei <xiaotian@google.com>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/core/dev.c | 63 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 20c7a67..d2690ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3602,27 +3602,28 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	spinlock_t *root_lock = qdisc_lock(q);
 	struct sk_buff *to_free = NULL;
 	bool contended;
-	int rc;
+	int rc = NET_XMIT_SUCCESS;
 
 	qdisc_calculate_pkt_len(skb, q);
 
 	if (q->flags & TCQ_F_NOLOCK) {
-		if ((q->flags & TCQ_F_CAN_BYPASS) && q->empty &&
-		    qdisc_run_begin(q)) {
-			if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED,
-					      &q->state))) {
-				__qdisc_drop(skb, &to_free);
-				rc = NET_XMIT_DROP;
-				goto end_run;
-			}
-			qdisc_bstats_cpu_update(q, skb);
+		if ((q->flags & TCQ_F_CAN_BYPASS) && q->empty) {
+			if (qdisc_run_begin(q)) {
+				if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED,
+						      &q->state))) {
+					__qdisc_drop(skb, &to_free);
+					rc = NET_XMIT_DROP;
+					goto end_run;
+				}
+				qdisc_bstats_cpu_update(q, skb);
 
-			rc = NET_XMIT_SUCCESS;
-			if (sch_direct_xmit(skb, q, dev, txq, NULL, true))
-				__qdisc_run(q);
+				if (sch_direct_xmit(skb, q, dev, txq, NULL,
+						    true))
+					__qdisc_run(q);
 
 end_run:
-			qdisc_run_end(q);
+				qdisc_run_end(q);
+			}
 		} else {
 			rc = q->enqueue(skb, q, &to_free) & NET_XMIT_MASK;
 			qdisc_run(q);
@@ -3647,26 +3648,28 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
 		__qdisc_drop(skb, &to_free);
 		rc = NET_XMIT_DROP;
-	} else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
-		   qdisc_run_begin(q)) {
-		/*
-		 * This is a work-conserving queue; there are no old skbs
-		 * waiting to be sent out; and the qdisc is not running -
-		 * xmit the skb directly.
-		 */
+	} else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q)) {
+		if (qdisc_run_begin(q)) {
+			/* This is a work-conserving queue;
+			 * there are no old skbs waiting to be sent out;
+			 * and the qdisc is not running -
+			 * xmit the skb directly.
+			 */
 
-		qdisc_bstats_update(q, skb);
+			qdisc_bstats_update(q, skb);
 
-		if (sch_direct_xmit(skb, q, dev, txq, root_lock, true)) {
-			if (unlikely(contended)) {
-				spin_unlock(&q->busylock);
-				contended = false;
+			if (sch_direct_xmit(skb, q, dev, txq, root_lock,
+					    true)) {
+				if (unlikely(contended)) {
+					spin_unlock(&q->busylock);
+					contended = false;
+				}
+				__qdisc_run(q);
 			}
-			__qdisc_run(q);
-		}
 
-		qdisc_run_end(q);
-		rc = NET_XMIT_SUCCESS;
+			qdisc_run_end(q);
+			rc = NET_XMIT_SUCCESS;
+		}
 	} else {
 		rc = q->enqueue(skb, q, &to_free) & NET_XMIT_MASK;
 		if (qdisc_run_begin(q)) {
-- 
1.8.3.1

