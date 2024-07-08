Return-Path: <bpf+bounces-34078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE6192A3AD
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 15:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A182838B7
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FB13A26B;
	Mon,  8 Jul 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XE5m2BaS"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577F6A022;
	Mon,  8 Jul 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445524; cv=none; b=FVCpmOzwr43jMoh6aqEGdyMbnEou48ivSnVYj6QQ78R4CSb5/zl3KIQrGKuX3KChsi1j80DyWIxDHLx/WMFCHxpduGTK0vidiFLszAbL3yolGUtJHwNSFSEtHS+i26lw4BwJnCYfabx9mU5lc6NqcJdMMjPG5BJP34Fick3vGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445524; c=relaxed/simple;
	bh=o74FhIsgE5QVbCYSvLfdl8LlrzxrgE5iZPu60ofT23g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DuyRLQxwA8pHtQKvNnaUyMjHDmgSm2UmsC1vftBtx78sXgOpf/V35ejBOmMoZaRgk1dERTOZaly7Ar7fdvA5RR1g89VguEohT4AfpKyEcaa/hdvEsVip+LQNuuIRSzzgv2QravGtJ1EZ/+jkeKbBIWwRMH6OYn68Aa91+0pUipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XE5m2BaS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=XpZcLntI1cJlzeZFzI/bR/58CLmyJ3qAK54rf0/i7K0=; b=XE5m2BaSPzf1clo7UmWUn84wPE
	mxcfHvAWbt/NfN4aXTXa4poeG6B/BrKurk8riYh21aFkfbIIKHZzBPPMihHUbD/NByuWJCZSXnPYo
	qCShrCNZrnfqomqqP1+5bT3tTFO0RySII0B+366kUKzCM1v+Necj3Zymd8AQhCzwEDMdf5TZhjF4f
	X79vjP5ETtcsUqH41SqKlp+Y7bWeQmGnh/BB6kfD5VT43Gav91BBwhbni27o2C/VB2z+hkG77+aBw
	tkTyIc14OFbRIBmYndnTUqm/W6GzVFbzsQjc0gFF0p0SV5FKCzwrHaKGDYxuk5JGpCIVF2w1VEDbG
	TarUnIZQ==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQoT8-000NDZ-JS; Mon, 08 Jul 2024 15:31:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Pedro Pinto <xten@osec.io>,
	Hyunwoo Kim <v4bel@theori.io>,
	Wongi Lee <qwerty@theori.io>
Subject: [PATCH bpf 1/2] bpf: Fix too early release of tcx_entry
Date: Mon,  8 Jul 2024 15:31:29 +0200
Message-Id: <20240708133130.11609-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

Pedro Pinto and later independently also Hyunwoo Kim and Wongi Lee reported
an issue that the tcx_entry can be released too early leading to a use
after free (UAF) when an active old-style ingress or clsact qdisc with a
shared tc block is later replaced by another ingress or clsact instance.

Essentially, the sequence to trigger the UAF (one example) can be as follows:

  1. A network namespace is created
  2. An ingress qdisc is created. This allocates a tcx_entry, and
     &tcx_entry->miniq is stored in the qdisc's miniqp->p_miniq. At the
     same time, a tcf block with index 1 is created.
  3. chain0 is attached to the tcf block. chain0 must be connected to
     the block linked to the ingress qdisc to later reach the function
     tcf_chain0_head_change_cb_del() which triggers the UAF.
  4. Create and graft a clsact qdisc. This causes the ingress qdisc
     created in step 1 to be removed, thus freeing the previously linked
     tcx_entry:

     rtnetlink_rcv_msg()
       => tc_modify_qdisc()
         => qdisc_create()
           => clsact_init() [a]
         => qdisc_graft()
           => qdisc_destroy()
             => __qdisc_destroy()
               => ingress_destroy() [b]
                 => tcx_entry_free()
                   => kfree_rcu() // tcx_entry freed

  5. Finally, the network namespace is closed. This registers the
     cleanup_net worker, and during the process of releasing the
     remaining clsact qdisc, it accesses the tcx_entry that was
     already freed in step 4, causing the UAF to occur:

     cleanup_net()
       => ops_exit_list()
         => default_device_exit_batch()
           => unregister_netdevice_many()
             => unregister_netdevice_many_notify()
               => dev_shutdown()
                 => qdisc_put()
                   => clsact_destroy() [c]
                     => tcf_block_put_ext()
                       => tcf_chain0_head_change_cb_del()
                         => tcf_chain_head_change_item()
                           => clsact_chain_head_change()
                             => mini_qdisc_pair_swap() // UAF

There are also other variants, the gist is to add an ingress (or clsact)
qdisc with a specific shared block, then to replace that qdisc, waiting
for the tcx_entry kfree_rcu() to be executed and subsequently accessing
the current active qdisc's miniq one way or another.

The correct fix is to turn the miniq_active boolean into a counter. What
can be observed, at step 2 above, the counter transitions from 0->1, at
step [a] from 1->2 (in order for the miniq object to remain active during
the replacement), then in [b] from 2->1 and finally [c] 1->0 with the
eventual release. The reference counter in general ranges from [0,2] and
it does not need to be atomic since all access to the counter is protected
by the rtnl mutex. With this in place, there is no longer a UAF happening
and the tcx_entry is freed at the correct time.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: Pedro Pinto <xten@osec.io>
Co-developed-by: Pedro Pinto <xten@osec.io>
Signed-off-by: Pedro Pinto <xten@osec.io>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hyunwoo Kim <v4bel@theori.io>
Cc: Wongi Lee <qwerty@theori.io>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 [ Apparently both parties found this issue as part of Google KernelCTF.
   Pedro reported the issue to us several days earlier than Hyunwoo &
   Wongi. I would have loved to place all parties into the Reported-by
   tag in addition to the informal mention above, but apparently this
   causes issues wrt the KernelCTF organisers despite that the commit
   message mentions the report timing. Hence in the tag only first come
   first serve this time. Thank you all in any case for reporting! ]

 include/net/tcx.h       | 13 +++++++++----
 net/sched/sch_ingress.c | 12 ++++++------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/tcx.h b/include/net/tcx.h
index 72a3e75e539f..5ce0ce9e0c02 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -13,7 +13,7 @@ struct mini_Qdisc;
 struct tcx_entry {
 	struct mini_Qdisc __rcu *miniq;
 	struct bpf_mprog_bundle bundle;
-	bool miniq_active;
+	u32 miniq_active;
 	struct rcu_head rcu;
 };
 
@@ -125,11 +125,16 @@ static inline void tcx_skeys_dec(bool ingress)
 	tcx_dec();
 }
 
-static inline void tcx_miniq_set_active(struct bpf_mprog_entry *entry,
-					const bool active)
+static inline void tcx_miniq_inc(struct bpf_mprog_entry *entry)
 {
 	ASSERT_RTNL();
-	tcx_entry(entry)->miniq_active = active;
+	tcx_entry(entry)->miniq_active++;
+}
+
+static inline void tcx_miniq_dec(struct bpf_mprog_entry *entry)
+{
+	ASSERT_RTNL();
+	tcx_entry(entry)->miniq_active--;
 }
 
 static inline bool tcx_entry_is_active(struct bpf_mprog_entry *entry)
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index c2ef9dcf91d2..cc6051d4f2ef 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -91,7 +91,7 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, true, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, true);
@@ -121,7 +121,7 @@ static void ingress_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->block, sch, &q->block_info);
 
 	if (entry) {
-		tcx_miniq_set_active(entry, false);
+		tcx_miniq_dec(entry);
 		if (!tcx_entry_is_active(entry)) {
 			tcx_entry_update(dev, NULL, true);
 			tcx_entry_free(entry);
@@ -257,7 +257,7 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, true, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp_ingress, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, true);
@@ -276,7 +276,7 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, false, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp_egress, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, false);
@@ -302,7 +302,7 @@ static void clsact_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
 
 	if (ingress_entry) {
-		tcx_miniq_set_active(ingress_entry, false);
+		tcx_miniq_dec(ingress_entry);
 		if (!tcx_entry_is_active(ingress_entry)) {
 			tcx_entry_update(dev, NULL, true);
 			tcx_entry_free(ingress_entry);
@@ -310,7 +310,7 @@ static void clsact_destroy(struct Qdisc *sch)
 	}
 
 	if (egress_entry) {
-		tcx_miniq_set_active(egress_entry, false);
+		tcx_miniq_dec(egress_entry);
 		if (!tcx_entry_is_active(egress_entry)) {
 			tcx_entry_update(dev, NULL, false);
 			tcx_entry_free(egress_entry);
-- 
2.43.0


