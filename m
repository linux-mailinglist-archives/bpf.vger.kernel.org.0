Return-Path: <bpf+bounces-11542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC67BBC0F
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF311C20AFE
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234128691;
	Fri,  6 Oct 2023 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Pmz+iDsc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6099273E4;
	Fri,  6 Oct 2023 15:45:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66298B6;
	Fri,  6 Oct 2023 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pi3D6PdBd4+prqT3v45yDT9uN1mBDTDIXQhr9Orzap4=; b=Pmz+iDscFLr1wzinFIzWIXHum+
	R7x18ZSVe19Pymy4uRaBevV/8ZG1yqtF74iWLrecmriyf0FRl3Zl5+WLfmDr+Sdd7de4bqe+yaoYa
	A6eb/hPlvCdgCBPUyh51FJbfbywff5EIf4sVx1mMcsSrwbi2F+LHQX0wOHSlh2MjFx6emF3N2usJN
	g1O3Fax6APpJqDjgoF2lsG1ou6S6rnIu7TcMCvh1y6Txw+k0ZqT1PUWqXjGIqjvRUzU6n8Uzyyu14
	AVNhiLgSYE1eljZLTERWkhAMZUq1Dp24hOMYq7xcGy/lZ2VzHlwpu5fc13vfKPez06sLB0QI3iZka
	xSErPNjA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qon1J-000DaH-CU; Fri, 06 Oct 2023 17:45:41 +0200
Received: from [178.197.249.17] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qon1I-0001nL-T1; Fri, 06 Oct 2023 17:45:40 +0200
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return
 code
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
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
 <2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net>
 <20231006063233.74345d36@kernel.org>
 <686dd999-bee4-ecf8-8dc4-c85a098c4a92@iogearbox.net>
 <20231006071215.4a28b348@kernel.org>
 <CAM0EoM=SHrPg2j3pmp-CG7v1g_7KaENEjgdwQ7HWOhN3NxUnng@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <647b0742-8806-cb66-d880-3d25fd9c3480@iogearbox.net>
Date: Fri, 6 Oct 2023 17:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoM=SHrPg2j3pmp-CG7v1g_7KaENEjgdwQ7HWOhN3NxUnng@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------9E6BC4784E46AF2BE03838D6"
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------9E6BC4784E46AF2BE03838D6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/23 5:25 PM, Jamal Hadi Salim wrote:
> On Fri, Oct 6, 2023 at 10:12 AM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Fri, 6 Oct 2023 15:49:18 +0200 Daniel Borkmann wrote:
>>>> Which will no longer work with the "pack multiple values into
>>>> the reason" scheme of subsys-specific values :(
>>>
>>> Too bad, do you happen to know why it won't work?
>>
>> I'm just guessing but the reason is enum skb_drop_reason
>> and the values of subsystem specific reasons won't be part
>> of that enum.
> 
> IIUC, this would gives us the readability and never require any
> changes to bpftrace, whereas the major:minor encoding would require
> further logic in bpftrace.

Makes sense, agree.

>>> Given they went into the
>>> length of extending this for subsystems, they presumably would also like to
>>> benefit from above. :/
>>>
>>>> What I'm saying is that there is a trade-off here between providing
>>>> as much info as possible vs basic user getting intelligible data..
>>>
>>> Makes sense. I think we can drop that aspect for the subsys specific error
>>> codes. Fwiw, TCP has 22 drop codes in the core section alone, so this should
>>> be fine if you think it's better. The rest of the patch shown should still
>>> apply the same way. I can tweak it to use the core section for codes, and
>>> then it can be successively extended if that looks good to you - unless you
>>> are saying from above, that just one error code is better and then going via
>>> detailed stats for specific errors is preferred.
>>
>> No, no, multiple reasons are perfectly fine. The non-technical
>> advantage of mac80211 error codes being separate is that there
>> are no git conflicts when we add new ones. TC codes can just
>> be added to the main enum like TCP 🤷️
> 
> We still need to differentiate policy vs error - I suppose we could go
> with Daniel's idea of introducing TC_ACT_ABORT/ERROR and ensure all
> the callees set the drop_reason.

I've simplified the set (attached). The disambiguation could eventually be on
SKB_DROP_REASON_TC_{INGRESS,EGRESS} == intentional drop vs SKB_DROP_REASON_TC_ERROR_*
which indicates an internal error code once these are covered on all locations.
There could probably also be just a SKB_DROP_REASON_TC_ERROR which could act as
a catch-all for the time being to initially mark all error locations with something
generic. I think this should be flexible where you wouldn't need extra TC_ACT_ABORT.

Thanks,
Daniel

--------------9E6BC4784E46AF2BE03838D6
Content-Type: text/x-patch;
 name="0001-net-tc-Make-tc-related-drop-reason-more-flexible.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-net-tc-Make-tc-related-drop-reason-more-flexible.patch"

From d72cffb57e09dd657007eb108392274dde8793ef Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 6 Oct 2023 08:42:19 +0000
Subject: [PATCH net-next 1/2] net, tc: Make tc-related drop reason more flexible

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
given the existing verdict logic can stay as is. Then, SKB_DROP_REASON_TC_ERROR_*
can be added to the enum skb_drop_reason to disambiguate between an error or an
intentional drop. New drop reason error codes can be added successively to the
tc code base. For internal error locations which have not yet been annotated with
a SKB_DROP_REASON_TC_ERROR_*, the fallback is SKB_DROP_REASON_TC_INGRESS and
SKB_DROP_REASON_TC_EGRESS, respectively.

While drop reasons have infrastructure for subsystem specific error codes which
are currently used by mac80211 and ovs, Jakub mentioned that it is preferred for
tc to use the enum skb_drop_reason core codes given i) it better belongs there,
and ii) the tooling support is better, too:

  And I think Alastair (bpftrace) is working on auto-prettifying enums when
  bpftrace outputs maps. So we can do something like:

  $ bpftrace -e 'tracepoint:skb:kfree_skb { @[args->reason] = count(); }'
  Attaching 1 probe...
  ^C

  @[SKB_DROP_REASON_TC_INGRESS]: 2
  @[SKB_CONSUMED]: 34

  ^^^^^^^^^^^^ names!!

  Auto-magically.

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


--------------9E6BC4784E46AF2BE03838D6
Content-Type: text/x-patch;
 name="0002-net-tc-Add-tc_set_drop_reason-for-reclassify-limit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-net-tc-Add-tc_set_drop_reason-for-reclassify-limit.patc";
 filename*1="h"

From b2c2a9eeb22ab48d4d31b61d2b4980faafb46c83 Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 6 Oct 2023 14:41:21 +0000
Subject: [PATCH net-next 2/2] net, tc: Add tc_set_drop_reason for reclassify limit

Add an initial user for the newly added tc_set_drop_reason() helper to
set the drop reason to SKB_DROP_REASON_TC_ERROR_MAX_LOOP when the maximum
reclassification limit is hit.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 include/net/dropreason-core.h | 3 +++
 net/sched/cls_api.c           | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a587e83fc169..a8503a72fddf 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -80,6 +80,7 @@
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
+	FN(TC_ERROR_MAX_LOOP)		\
 	FNe(MAX)
 
 /**
@@ -345,6 +346,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
 	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
 	SKB_DROP_REASON_QUEUE_PURGE,
+	/** @SKB_DROP_REASON_TC_ERROR_MAX_LOOP: dropped due to hitting maximum reclassify limit. */
+	SKB_DROP_REASON_TC_ERROR_MAX_LOOP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..ed740f070dc4 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1723,6 +1723,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
+		tc_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR_MAX_LOOP);
 		return TC_ACT_SHOT;
 	}
 
-- 
2.34.1


--------------9E6BC4784E46AF2BE03838D6--

