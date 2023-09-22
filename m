Return-Path: <bpf+bounces-10614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C47AAC1E
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 10:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B622E283F2B
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0251DDD9;
	Fri, 22 Sep 2023 08:13:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1E1775A;
	Fri, 22 Sep 2023 08:12:57 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3175EA9;
	Fri, 22 Sep 2023 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ljjOdUaoap5Z8D018AOwKborDABtvhzhbb2uLbV79m8=; b=TSX+EQ73gk/HBbw/E1MCFTUDPP
	ExbNotsBvSAVNZEFUSQGIsqMQblgFH8abFTuegMVEPv4UfVu/hTroKr3xrPu2uoZPYu/Oj68elLix
	NL+0ngDyPCKP35WgLrAgZshHldjPciwfNlxVEjtTbB4UnunEWXfjJMG43l8ucH/8TP5u4CzjB5Dqc
	aMuA9AxA1WwXM1NQifI00SJQMM1kv+pWVuG63jr1ob3M6Hea6H7qc/StnZTTc8k2klWo9W9N3qwKZ
	gtgYbDRsEdrUmgWlbETkjGAi30OTjbf7R4cwgY5+o3aszgWw0IJm9bSBCCakuBjVz+jOIatluUtpV
	TdI/jMrQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qjbHC-00063A-Bv; Fri, 22 Sep 2023 10:12:38 +0200
Received: from [109.164.252.253] (helo=localhost.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qjbHB-000Ark-Ry; Fri, 22 Sep 2023 10:12:37 +0200
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
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
Date: Fri, 22 Sep 2023 10:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27038/Thu Sep 21 09:39:42 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 1:20 AM, Jamal Hadi Salim wrote:
> On Tue, Sep 19, 2023 at 6:15 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> [ +Martin, bpf ]
>>
>> On 9/19/23 4:59 PM, Victor Nogueira wrote:
>>> Currently there is no way to distinguish between an error and a
>>> classification verdict. This patch adds the verdict field as a part of
>>> struct tcf_result. That way, tcf_classify can return a proper
>>> error number when it fails, and we keep the classification result
>>> information encapsulated in struct tcf_result.
>>>
>>> Also add values SKB_DROP_REASON_TC_EGRESS_ERROR and
>>> SKB_DROP_REASON_TC_INGRESS_ERROR to enum skb_drop_reason.
>>> With that we can distinguish between a drop from a processing error versus
>>> a drop from classification.
>>>
>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>>> ---
>>>    include/net/dropreason-core.h |  6 +++++
>>>    include/net/sch_generic.h     |  7 ++++++
>>>    net/core/dev.c                | 42 ++++++++++++++++++++++++++---------
>>>    net/sched/cls_api.c           | 38 ++++++++++++++++++++-----------
>>>    net/sched/sch_cake.c          | 32 +++++++++++++-------------
>>>    net/sched/sch_drr.c           | 33 +++++++++++++--------------
>>>    net/sched/sch_ets.c           |  6 +++--
>>>    net/sched/sch_fq_codel.c      | 29 ++++++++++++------------
>>>    net/sched/sch_fq_pie.c        | 28 +++++++++++------------
>>>    net/sched/sch_hfsc.c          |  6 +++--
>>>    net/sched/sch_htb.c           |  6 +++--
>>>    net/sched/sch_multiq.c        |  6 +++--
>>>    net/sched/sch_prio.c          |  7 ++++--
>>>    net/sched/sch_qfq.c           | 34 +++++++++++++---------------
>>>    net/sched/sch_sfb.c           | 29 ++++++++++++------------
>>>    net/sched/sch_sfq.c           | 28 +++++++++++------------
>>>    16 files changed, 195 insertions(+), 142 deletions(-)
>>>
>>> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
>>> index a587e83fc169..b1c069c8e7f2 100644
>>> --- a/include/net/dropreason-core.h
>>> +++ b/include/net/dropreason-core.h
>>> @@ -80,6 +80,8 @@
>>>        FN(IPV6_NDISC_BAD_OPTIONS)      \
>>>        FN(IPV6_NDISC_NS_OTHERHOST)     \
>>>        FN(QUEUE_PURGE)                 \
>>> +     FN(TC_EGRESS_ERROR)             \
>>> +     FN(TC_INGRESS_ERROR)            \
>>>        FNe(MAX)
>>>
>>>    /**
>>> @@ -345,6 +347,10 @@ enum skb_drop_reason {
>>>        SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
>>>        /** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
>>>        SKB_DROP_REASON_QUEUE_PURGE,
>>> +     /** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOOK due to error */
>>> +     SKB_DROP_REASON_TC_EGRESS_ERROR,
>>> +     /** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress HOOK due to error */
>>> +     SKB_DROP_REASON_TC_INGRESS_ERROR,
>>>        /**
>>>         * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>>>         * shouldn't be used as a real 'reason' - only for tracing code gen
>>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>>> index f232512505f8..9a3f71d2545e 100644
>>> --- a/include/net/sch_generic.h
>>> +++ b/include/net/sch_generic.h
>>> @@ -326,6 +326,7 @@ struct Qdisc_ops {
>>>
>>>
>>>    struct tcf_result {
>>> +     u32 verdict;
>>>        union {
>>>                struct {
>>>                        unsigned long   class;
>>> @@ -336,6 +337,12 @@ struct tcf_result {
>>>        };
>>>    };
>>>
>>> +static inline void tcf_result_set_verdict(struct tcf_result *res,
>>> +                                       const u32 verdict)
>>> +{
>>> +     res->verdict = verdict;
>>> +}
>>> +
>>>    struct tcf_chain;
>>>
>>>    struct tcf_proto_ops {
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index ccff2b6ef958..1450f4741d9b 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -3910,31 +3910,39 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
>>>    #endif /* CONFIG_NET_EGRESS */
>>>
>>>    #ifdef CONFIG_NET_XGRESS
>>> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
>>> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>>> +               struct tcf_result *res)
>>>    {
>>> -     int ret = TC_ACT_UNSPEC;
>>> +     int ret = 0;
>>>    #ifdef CONFIG_NET_CLS_ACT
>>>        struct mini_Qdisc *miniq = rcu_dereference_bh(entry->miniq);
>>> -     struct tcf_result res;
>>>
>>> -     if (!miniq)
>>> +     if (!miniq) {
>>> +             tcf_result_set_verdict(res, TC_ACT_UNSPEC);
>>>                return ret;
>>> +     }
>>>
>>>        tc_skb_cb(skb)->mru = 0;
>>>        tc_skb_cb(skb)->post_ct = false;
>>>
>>>        mini_qdisc_bstats_cpu_update(miniq, skb);
>>> -     ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
>>> +     ret = tcf_classify(skb, miniq->block, miniq->filter_list, res, false);
>>> +     if (ret < 0) {
>>> +             mini_qdisc_qstats_cpu_drop(miniq);
>>> +             return ret;
>>> +     }
>>>        /* Only tcf related quirks below. */
>>> -     switch (ret) {
>>> +     switch (res->verdict) {
>>>        case TC_ACT_SHOT:
>>>                mini_qdisc_qstats_cpu_drop(miniq);
>>>                break;
>>>        case TC_ACT_OK:
>>>        case TC_ACT_RECLASSIFY:
>>> -             skb->tc_index = TC_H_MIN(res.classid);
>>> +             skb->tc_index = TC_H_MIN(res->classid);
>>>                break;
>>>        }
>>> +#else
>>> +     tcf_result_set_verdict(res, TC_ACT_UNSPEC);
>>>    #endif /* CONFIG_NET_CLS_ACT */
>>>        return ret;
>>>    }
>>> @@ -3977,6 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>>>                   struct net_device *orig_dev, bool *another)
>>>    {
>>>        struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
>>> +     struct tcf_result res = {0};
>>>        int sch_ret;
>>>
>>>        if (!entry)
>>> @@ -3994,9 +4003,14 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>>>                if (sch_ret != TC_ACT_UNSPEC)
>>>                        goto ingress_verdict;
>>>        }
>>> -     sch_ret = tc_run(tcx_entry(entry), skb);
>>> +     sch_ret = tc_run(tcx_entry(entry), skb, &res);
>>> +     if (sch_ret < 0) {
>>> +             kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR);
>>> +             *ret = NET_RX_DROP;
>>> +             return NULL;
>>> +     }
>>>    ingress_verdict:
>>> -     switch (sch_ret) {
>>> +     switch (res.verdict) {
>>
>> This breaks tcx, please move all this logic into tc_run(). No changes to sch_handle_ingress()
>> or sch_handle_egress should be necessary, you can then just remap the return code to TC_ACT_SHOT
>> in such case.
> 
> I think it is valuable to have a good reason code like
> SKB_DROP_REASON_TC_XXX_ERROR to disambiguate between errors vs
> verdicts in the case of tc_run() variant.
> For tcx_run(), does this look ok (for consistency)?:
> 
> if (static_branch_unlikely(&tcx_needed_key)) {
>                  sch_ret = tcx_run(entry, skb, true);
>                  if (sch_ret != TC_ACT_UNSPEC) {
>                          res.verdict = sch_ret;
>                          goto ingress_verdict;
>                  }
> }

In the above case we don't have 'internal' errors which you want to trace, so I would
also love to avoid the cost of zeroing struct tcf_result res which should be 3x 8b for
every packet.

I was more thinking like something below could be a better choice. I presume your main
goal is to trace where these errors originated in the first place, so it might even be
useful to capture the actual return code as well.

Then you can use perf script, bpf and whatnot to gather further insights into what
happened while being less invasive and avoiding the need to extend struct tcf_result.

This would be quite similar to trace_xdp_exception() as well, and I think you can guarantee
that in fast path all errors are < TC_ACT_UNSPEC anyway.

diff --git a/net/core/dev.c b/net/core/dev.c
index 85df22f05c38..4089d195144d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3925,6 +3925,10 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)

  	mini_qdisc_bstats_cpu_update(miniq, skb);
  	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
+	if (unlikely(ret < TC_ACT_UNSPEC)) {
+		trace_tc_exception(skb->dev, skb->tc_at_ingress, ret);
+		ret = TC_ACT_SHOT;
+	}
  	/* Only tcf related quirks below. */
  	switch (ret) {
  	case TC_ACT_SHOT:

Best,
Daniel

