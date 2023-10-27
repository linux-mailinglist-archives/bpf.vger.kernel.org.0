Return-Path: <bpf+bounces-13421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFA7D9A76
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21263282504
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7D2D020;
	Fri, 27 Oct 2023 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jOdiNrd0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA631EB28;
	Fri, 27 Oct 2023 13:51:53 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE41118A;
	Fri, 27 Oct 2023 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=bZFuNIvNr+O7sWZ0ED5meKlY7g9oTmwwM9BLzW/byYY=; b=jOdiNrd0hsEbFcTm51HsecGzeq
	Vm9TztWuMZOoJDbHvDdCV1rAVVtC5kL7BFuZy3Yz4y8vNwnPMsJW65Bk7eT1nUBy9rwqHuuGPW9KF
	zCN55FX+xrWf5iFDZuGr1XlKhsBvhAxMuKNuIC9ZTQPqJHHjU8AuhaB8vc6PROaA9KLJ8PbFWyGYE
	iMe1H8wMgYRGgyuDYDGNAeDpqZHFI+dt3GzdCZop4YHUKxDMC2XgdwHMYp1s2Y3kJdQ5qzLrJlaFk
	9S9FeIQjSSW8J/7oPw9qdb/c9GIIJ2zM3dFCUUe69MxgmYd/BV+/24rUx4qgXRTmvnAVH49B0bnGL
	KcaLzRgA==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qwNFc-000HL6-2U; Fri, 27 Oct 2023 15:51:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: idosch@idosch.org,
	jhs@mojatatu.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat under debug config
Date: Fri, 27 Oct 2023 15:51:42 +0200
Message-Id: <20231027135142.11555-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27074/Fri Oct 27 09:58:36 2023)

Ido reported:

  [...] getting the following splat [1] with CONFIG_DEBUG_NET=y and this
  reproducer [2]. Problem seems to be that classifiers clear 'struct
  tcf_result::drop_reason', thereby triggering the warning in
  __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0). [...]

  [1]
  WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
  Modules linked in:
  CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
  RIP: 0010:kfree_skb_reason+0x38/0x130
  [...]
  Call Trace:
   <IRQ>
   __netif_receive_skb_core.constprop.0+0x837/0xdb0
   __netif_receive_skb_one_core+0x3c/0x70
   process_backlog+0x95/0x130
   __napi_poll+0x25/0x1b0
   net_rx_action+0x29b/0x310
   __do_softirq+0xc0/0x29b
   do_softirq+0x43/0x60
   </IRQ>

  [2]
  #!/bin/bash

  ip link add name veth0 type veth peer name veth1
  ip link set dev veth0 up
  ip link set dev veth1 up
  tc qdisc add dev veth1 clsact
  tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
  mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1

What happens is that inside most classifiers the tcf_result is copied over
from a filter template e.g. *res = f->res which then implicitly overrides
the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which was
set via sch_handle_{ingress,egress}() for kfree_skb_reason().

Add a small helper tcf_set_result() and convert classifiers over to it.
The latter leaves the drop code intact and classifiers, actions as well
as the action engine in tcf_exts_exec() can then in future make use of
tcf_set_drop_reason(), too.

Tested that the splat is fixed under CONFIG_DEBUG_NET=y with the repro.

Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more flexible")
Reported-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
---
 include/net/pkt_cls.h    | 12 ++++++++++++
 net/sched/cls_basic.c    |  2 +-
 net/sched/cls_bpf.c      |  2 +-
 net/sched/cls_flower.c   |  2 +-
 net/sched/cls_fw.c       |  2 +-
 net/sched/cls_matchall.c |  2 +-
 net/sched/cls_route.c    |  4 ++--
 net/sched/cls_u32.c      |  2 +-
 8 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a76c9171db0e..31d8e8587824 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct tcf_result *res,
 	res->drop_reason = reason;
 }
 
+static inline void tcf_set_result(struct tcf_result *to,
+				  const struct tcf_result *from)
+{
+	/* tcf_result's drop_reason which is the last member must be
+	 * preserved and cannot be copied from the cls'es tcf_result
+	 * template given this is carried all the way and potentially
+	 * set to a concrete tc drop reason upon error or intentional
+	 * drop. See tcf_set_drop_reason() locations.
+	 */
+	memcpy(to, from, offsetof(typeof(*to), drop_reason));
+}
+
 static inline void
 __tcf_bind_filter(struct Qdisc *q, struct tcf_result *r, unsigned long base)
 {
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index 1b92c33b5f81..d7ead3fc3c45 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -50,7 +50,7 @@ TC_INDIRECT_SCOPE int basic_classify(struct sk_buff *skb,
 		if (!tcf_em_tree_match(skb, &f->ematches, NULL))
 			continue;
 		__this_cpu_inc(f->pf->rhit);
-		*res = f->res;
+		tcf_set_result(res, &f->res);
 		r = tcf_exts_exec(skb, &f->exts, res);
 		if (r < 0)
 			continue;
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 382c7a71f81f..e4620a462bc3 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -124,7 +124,7 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 			res->class   = 0;
 			res->classid = filter_res;
 		} else {
-			*res = prog->res;
+			tcf_set_result(res, &prog->res);
 		}
 
 		ret = tcf_exts_exec(skb, &prog->exts, res);
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e5314a31f75a..eb94090fb26c 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -341,7 +341,7 @@ TC_INDIRECT_SCOPE int fl_classify(struct sk_buff *skb,
 
 		f = fl_mask_lookup(mask, &skb_key);
 		if (f && !tc_skip_sw(f->flags)) {
-			*res = f->res;
+			tcf_set_result(res, &f->res);
 			return tcf_exts_exec(skb, &f->exts, res);
 		}
 	}
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index c49d6af0e048..70b873f8771f 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -63,7 +63,7 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
 		for (f = rcu_dereference_bh(head->ht[fw_hash(id)]); f;
 		     f = rcu_dereference_bh(f->next)) {
 			if (f->id == id) {
-				*res = f->res;
+				tcf_set_result(res, &f->res);
 				if (!tcf_match_indev(skb, f->ifindex))
 					continue;
 				r = tcf_exts_exec(skb, &f->exts, res);
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index c4ed11df6254..a4018db80a60 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -37,7 +37,7 @@ TC_INDIRECT_SCOPE int mall_classify(struct sk_buff *skb,
 	if (tc_skip_sw(head->flags))
 		return -1;
 
-	*res = head->res;
+	tcf_set_result(res, &head->res);
 	__this_cpu_inc(head->pf->rhit);
 	return tcf_exts_exec(skb, &head->exts, res);
 }
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 1424bfeaca73..cbfaa1d1820f 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -109,7 +109,7 @@ static inline int route4_hash_wild(void)
 
 #define ROUTE4_APPLY_RESULT()					\
 {								\
-	*res = f->res;						\
+	tcf_set_result(res, &f->res);				\
 	if (tcf_exts_has_actions(&f->exts)) {			\
 		int r = tcf_exts_exec(skb, &f->exts, res);	\
 		if (r < 0) {					\
@@ -152,7 +152,7 @@ TC_INDIRECT_SCOPE int route4_classify(struct sk_buff *skb,
 			goto failure;
 		}
 
-		*res = f->res;
+		tcf_set_result(res, &f->res);
 		spin_unlock(&fastmap_lock);
 		return 0;
 	}
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 6663e971a13e..f50ae40a29d5 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -172,7 +172,7 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
 check_terminal:
 			if (n->sel.flags & TC_U32_TERMINAL) {
 
-				*res = n->res;
+				tcf_set_result(res, &n->res);
 				if (!tcf_match_indev(skb, n->ifindex)) {
 					n = rcu_dereference_bh(n->next);
 					goto next_knode;
-- 
2.34.1


