Return-Path: <bpf+bounces-11536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675F37BB642
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457541C20AF3
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D33B1C68F;
	Fri,  6 Oct 2023 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FdgtmMML"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208464414;
	Fri,  6 Oct 2023 11:18:56 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D200CA;
	Fri,  6 Oct 2023 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OGI0pPwk2FR/duGs5TyGw73gmcwOeWFF7cdEH0RH02k=; b=FdgtmMMLLnfBBGNTuDcbHhli/y
	woucuxwTfdf6gC82nUmBHaDA2l4x9poHCLYq7C/khR0aYxgLBHSifSaIwbl9nCixVwuBqVkIrDsGx
	5yuKJkWdSNcxaNElJbabUch62a6SY6ljBtNIFUWtunAKSVppCD3Us414eiR8nrvJyZ8HEIcgo57QW
	qdEbcM5oPNYuq7EOS+lSEtCfIBxdiWjBMKIUIebbPr/MEeQVKDejptURfFgMjH15Bqr9Y8jfNwHRM
	fuu1S73o3Vu6hSLEposW0JcXAuMfbrJPjEYdxR74aq6WRnp3WJYBIcSUzBCdRCu7TYNnY36DyqSfd
	Of+AkT2g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qoiqv-00097b-Mn; Fri, 06 Oct 2023 13:18:42 +0200
Received: from [178.197.249.17] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qoiqv-000GpT-6o; Fri, 06 Oct 2023 13:18:41 +0200
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return
 code
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, paulb@nvidia.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, martin.lau@linux.dev, bpf@vger.kernel.org
References: <20230919145951.352548-1-victor@mojatatu.com>
 <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
 <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
 <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
 <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
 <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
 <CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
 <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
 <CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
 <96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net>
 <CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net>
Date: Fri, 6 Oct 2023 13:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jamal,

On 10/3/23 11:36 PM, Jamal Hadi Salim wrote:
[...]
> I did look, Daniel. You are lumping all the error codes into one -
> which doesnt change my view on disambiguation. If i was to debug
> closely and run kprobe now i am seeing only one error code
> TC_ACT_ABORT instead of -EINVAL vs -ENOMEM, etc. Easier for me to find
> the source manually (and possibly even better with Andrii's tool i saw
> once if it would work in the datapath - iirc, i think it prints return
> codes on the code paths).

That should be possible with some work this way, agree. I've been toying a bit
more on this issue, and actually there is an even better way which would cleanly
solve all use cases and we likely would utilize it for bpf as well in future.
I wasn't aware of it before, but the drop reason actually has per-subsystem infra
already which so far only mac80211 and ovs makes use of.

I wrote up below patch as a starting point to get the base infra up and with
TC_DROP_MAX_RECLASSIFY as the initial example on how to utilize it. Then you can
simply just use regular tooling and get more detailed kfree_skb_reason() codes,
which would also remove the need for kprobes/kretprobes to gather the error.

Let me know if this looks like a good path forward, then I'll cook a proper one
and you or Victor can extend it further with more drop reasons. The nice thing is
also that this can be extended successively with more reasons whenever needed.

Best & thanks,
Daniel

 From d62b4a52f9c725d4a63d5c76a576d4e3bbbea4ef Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 6 Oct 2023 08:42:19 +0000
Subject: [PATCH net-next] net, tc: Add extensible drop reason subsystem codes

[ commit msg tbd ]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
  include/net/dropreason-core.h |  4 ++--
  include/net/dropreason.h      |  6 ++++++
  include/net/sch_drop.h        | 35 +++++++++++++++++++++++++++++++++++
  include/net/sch_generic.h     | 11 +++++++++--
  net/core/dev.c                | 15 ++++++++++-----
  net/sched/cls_api.c           |  1 +
  6 files changed, 63 insertions(+), 9 deletions(-)
  create mode 100644 include/net/sch_drop.h

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a587e83fc169..670eac9923aa 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -235,7 +235,7 @@ enum skb_drop_reason {
  	SKB_DROP_REASON_NEIGH_QUEUEFULL,
  	/** @SKB_DROP_REASON_NEIGH_DEAD: neigh entry is dead */
  	SKB_DROP_REASON_NEIGH_DEAD,
-	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
+	/** @SKB_DROP_REASON_TC_EGRESS: Unused, see TC_DROP_EGRESS instead */
  	SKB_DROP_REASON_TC_EGRESS,
  	/**
  	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
@@ -250,7 +250,7 @@ enum skb_drop_reason {
  	SKB_DROP_REASON_CPU_BACKLOG,
  	/** @SKB_DROP_REASON_XDP: dropped by XDP in input path */
  	SKB_DROP_REASON_XDP,
-	/** @SKB_DROP_REASON_TC_INGRESS: dropped in TC ingress HOOK */
+	/** @SKB_DROP_REASON_TC_INGRESS: Unused, see TC_DROP_INGRESS instead */
  	SKB_DROP_REASON_TC_INGRESS,
  	/** @SKB_DROP_REASON_UNHANDLED_PROTO: protocol not implemented or not supported */
  	SKB_DROP_REASON_UNHANDLED_PROTO,
diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 56cb7be92244..434ed2124836 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -29,6 +29,12 @@ enum skb_drop_reason_subsys {
  	 */
  	SKB_DROP_REASON_SUBSYS_OPENVSWITCH,

+	/**
+	 * @SKB_DROP_REASON_SUBSYS_TC: traffic control (tc) drop reasons,
+	 * see include/net/sch_drop.h
+	 */
+	SKB_DROP_REASON_SUBSYS_TC,
+
  	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
  	SKB_DROP_REASON_SUBSYS_NUM
  };
diff --git a/include/net/sch_drop.h b/include/net/sch_drop.h
new file mode 100644
index 000000000000..c2471a62c10b
--- /dev/null
+++ b/include/net/sch_drop.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Traffic control drop reason list. */
+
+#ifndef NET_SCH_DROP_H
+#define NET_SCH_DROP_H
+
+#include <linux/skbuff.h>
+#include <net/dropreason.h>
+
+/**
+ * @TC_DROP_INGRESS: dropped in tc ingress hook (generic, catch-all code)
+ * @TC_DROP_EGRESS: dropped in tc egress hook (generic, catch-all code)
+ * @TC_DROP_MAX_RECLASSIFY: dropped due to hitting maximum reclassify limit
+ */
+#define TC_DROP_REASONS(R)			\
+	R(TC_DROP_INGRESS)			\
+	R(TC_DROP_EGRESS)			\
+	R(TC_DROP_MAX_RECLASSIFY)		\
+	/* deliberate comment for trailing \ */
+
+enum tc_drop_reason {
+	__TC_DROP_REASON = SKB_DROP_REASON_SUBSYS_TC <<
+		SKB_DROP_REASON_SUBSYS_SHIFT,
+#define ENUM(x) x,
+	TC_DROP_REASONS(ENUM)
+#undef ENUM
+	TC_DROP_MAX,
+};
+
+static inline void
+tc_kfree_skb_reason(struct sk_buff *skb, enum tc_drop_reason reason)
+{
+	kfree_skb_reason(skb, (u32)reason);
+}
+#endif /* NET_SCH_DROP_H */
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c7318c73cfd6..e50a281ff1af 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -16,9 +16,11 @@
  #include <linux/rwsem.h>
  #include <linux/atomic.h>
  #include <linux/hashtable.h>
+
  #include <net/gen_stats.h>
  #include <net/rtnetlink.h>
  #include <net/flow_offload.h>
+#include <net/sch_drop.h>

  struct Qdisc_ops;
  struct qdisc_walker;
@@ -324,15 +326,14 @@ struct Qdisc_ops {
  	struct module		*owner;
  };

-
  struct tcf_result {
+	enum tc_drop_reason		drop_reason;
  	union {
  		struct {
  			unsigned long	class;
  			u32		classid;
  		};
  		const struct tcf_proto *goto_tp;
-
  	};
  };

@@ -667,6 +668,12 @@ static inline int tc_classid_to_hwtc(struct net_device *dev, u32 classid)
  	return (hwtc < netdev_get_num_tc(dev)) ? hwtc : -EINVAL;
  }

+static inline void tc_set_drop_reason(struct tcf_result *res,
+				      enum tc_drop_reason reason)
+{
+	res->drop_reason = reason;
+}
+
  int qdisc_class_hash_init(struct Qdisc_class_hash *);
  void qdisc_class_hash_insert(struct Qdisc_class_hash *,
  			     struct Qdisc_class_common *);
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc209..93cebe374082 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
  #endif /* CONFIG_NET_EGRESS */

  #ifdef CONFIG_NET_XGRESS
-static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
+static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
+		  enum tc_drop_reason *drop_reason)
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
+	enum tc_drop_reason drop_reason = TC_DROP_INGRESS;
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
+		tc_kfree_skb_reason(skb, drop_reason);
  		*ret = NET_RX_DROP;
  		return NULL;
  	/* used by tc_run */
@@ -4032,6 +4036,7 @@ static __always_inline struct sk_buff *
  sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
  {
  	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
+	enum tc_drop_reason drop_reason = TC_DROP_EGRESS;
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
+		tc_kfree_skb_reason(skb, drop_reason);
  		*ret = NET_XMIT_DROP;
  		return NULL;
  	/* used by tc_run */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..5d56ddb1462f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1723,6 +1723,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
  				       tp->chain->block->index,
  				       tp->prio & 0xffff,
  				       ntohs(tp->protocol));
+		tc_set_drop_reason(res, TC_DROP_MAX_RECLASSIFY);
  		return TC_ACT_SHOT;
  	}

-- 
2.34.1


