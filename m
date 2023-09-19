Return-Path: <bpf+bounces-10413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599607A6E8E
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 00:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630AD1C204F8
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40FB3C69D;
	Tue, 19 Sep 2023 22:15:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B23B788;
	Tue, 19 Sep 2023 22:15:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53739D8;
	Tue, 19 Sep 2023 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d0HioYZKyXay6hHxTJK1WFxa9hlPbFJmhfqfWx+ai4A=; b=flMHtCANXl75Zo3gGIrTeg0leW
	uoJxGOvDO2RHyWSp0c6oV6fhgtitLbvcRI7x+J6kS19wxB4FpmZxhvOTafZlSNRnfB9dqgfsSeWi2
	JyPnvm7cfFZRS9qz2I08cc6NvYz7yD/Yxqj8LaUlWJHWvE59m/vgkz/tYORNV8nBaHE8YtuJXknFD
	e4fQVkY8gwGW1KS1iUodyTKwe4hBMuZaDPsmMVlXtnitCC+jo8fNgfjnmz9PwP/MOvySVXhVCSWT6
	RVolgFqdnbpY8FSEF1P40wPx8vpuVXpW6G+TLxaOoV7nAtLGXhCL+VVh6iii0daCpRgdckFw1b/sV
	eQn6ylkA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qiizy-000NfG-OD; Wed, 20 Sep 2023 00:15:14 +0200
Received: from [194.230.148.14] (helo=localhost.localdomain)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qiizy-000AW7-5l; Wed, 20 Sep 2023 00:15:14 +0200
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return
 code
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paulb@nvidia.com
Cc: netdev@vger.kernel.org, kernel@mojatatu.com, martin.lau@linux.dev,
 bpf@vger.kernel.org
References: <20230919145951.352548-1-victor@mojatatu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
Date: Wed, 20 Sep 2023 00:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230919145951.352548-1-victor@mojatatu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27036/Tue Sep 19 09:42:31 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ +Martin, bpf ]

On 9/19/23 4:59 PM, Victor Nogueira wrote:
> Currently there is no way to distinguish between an error and a
> classification verdict. This patch adds the verdict field as a part of
> struct tcf_result. That way, tcf_classify can return a proper
> error number when it fails, and we keep the classification result
> information encapsulated in struct tcf_result.
> 
> Also add values SKB_DROP_REASON_TC_EGRESS_ERROR and
> SKB_DROP_REASON_TC_INGRESS_ERROR to enum skb_drop_reason.
> With that we can distinguish between a drop from a processing error versus
> a drop from classification.
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>   include/net/dropreason-core.h |  6 +++++
>   include/net/sch_generic.h     |  7 ++++++
>   net/core/dev.c                | 42 ++++++++++++++++++++++++++---------
>   net/sched/cls_api.c           | 38 ++++++++++++++++++++-----------
>   net/sched/sch_cake.c          | 32 +++++++++++++-------------
>   net/sched/sch_drr.c           | 33 +++++++++++++--------------
>   net/sched/sch_ets.c           |  6 +++--
>   net/sched/sch_fq_codel.c      | 29 ++++++++++++------------
>   net/sched/sch_fq_pie.c        | 28 +++++++++++------------
>   net/sched/sch_hfsc.c          |  6 +++--
>   net/sched/sch_htb.c           |  6 +++--
>   net/sched/sch_multiq.c        |  6 +++--
>   net/sched/sch_prio.c          |  7 ++++--
>   net/sched/sch_qfq.c           | 34 +++++++++++++---------------
>   net/sched/sch_sfb.c           | 29 ++++++++++++------------
>   net/sched/sch_sfq.c           | 28 +++++++++++------------
>   16 files changed, 195 insertions(+), 142 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index a587e83fc169..b1c069c8e7f2 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -80,6 +80,8 @@
>   	FN(IPV6_NDISC_BAD_OPTIONS)	\
>   	FN(IPV6_NDISC_NS_OTHERHOST)	\
>   	FN(QUEUE_PURGE)			\
> +	FN(TC_EGRESS_ERROR)		\
> +	FN(TC_INGRESS_ERROR)		\
>   	FNe(MAX)
>   
>   /**
> @@ -345,6 +347,10 @@ enum skb_drop_reason {
>   	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
>   	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
>   	SKB_DROP_REASON_QUEUE_PURGE,
> +	/** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOOK due to error */
> +	SKB_DROP_REASON_TC_EGRESS_ERROR,
> +	/** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress HOOK due to error */
> +	SKB_DROP_REASON_TC_INGRESS_ERROR,
>   	/**
>   	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>   	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index f232512505f8..9a3f71d2545e 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -326,6 +326,7 @@ struct Qdisc_ops {
>   
>   
>   struct tcf_result {
> +	u32 verdict;
>   	union {
>   		struct {
>   			unsigned long	class;
> @@ -336,6 +337,12 @@ struct tcf_result {
>   	};
>   };
>   
> +static inline void tcf_result_set_verdict(struct tcf_result *res,
> +					  const u32 verdict)
> +{
> +	res->verdict = verdict;
> +}
> +
>   struct tcf_chain;
>   
>   struct tcf_proto_ops {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ccff2b6ef958..1450f4741d9b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3910,31 +3910,39 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
>   #endif /* CONFIG_NET_EGRESS */
>   
>   #ifdef CONFIG_NET_XGRESS
> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> +		  struct tcf_result *res)
>   {
> -	int ret = TC_ACT_UNSPEC;
> +	int ret = 0;
>   #ifdef CONFIG_NET_CLS_ACT
>   	struct mini_Qdisc *miniq = rcu_dereference_bh(entry->miniq);
> -	struct tcf_result res;
>   
> -	if (!miniq)
> +	if (!miniq) {
> +		tcf_result_set_verdict(res, TC_ACT_UNSPEC);
>   		return ret;
> +	}
>   
>   	tc_skb_cb(skb)->mru = 0;
>   	tc_skb_cb(skb)->post_ct = false;
>   
>   	mini_qdisc_bstats_cpu_update(miniq, skb);
> -	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
> +	ret = tcf_classify(skb, miniq->block, miniq->filter_list, res, false);
> +	if (ret < 0) {
> +		mini_qdisc_qstats_cpu_drop(miniq);
> +		return ret;
> +	}
>   	/* Only tcf related quirks below. */
> -	switch (ret) {
> +	switch (res->verdict) {
>   	case TC_ACT_SHOT:
>   		mini_qdisc_qstats_cpu_drop(miniq);
>   		break;
>   	case TC_ACT_OK:
>   	case TC_ACT_RECLASSIFY:
> -		skb->tc_index = TC_H_MIN(res.classid);
> +		skb->tc_index = TC_H_MIN(res->classid);
>   		break;
>   	}
> +#else
> +	tcf_result_set_verdict(res, TC_ACT_UNSPEC);
>   #endif /* CONFIG_NET_CLS_ACT */
>   	return ret;
>   }
> @@ -3977,6 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>   		   struct net_device *orig_dev, bool *another)
>   {
>   	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
> +	struct tcf_result res = {0};
>   	int sch_ret;
>   
>   	if (!entry)
> @@ -3994,9 +4003,14 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>   		if (sch_ret != TC_ACT_UNSPEC)
>   			goto ingress_verdict;
>   	}
> -	sch_ret = tc_run(tcx_entry(entry), skb);
> +	sch_ret = tc_run(tcx_entry(entry), skb, &res);
> +	if (sch_ret < 0) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR);
> +		*ret = NET_RX_DROP;
> +		return NULL;
> +	}
>   ingress_verdict:
> -	switch (sch_ret) {
> +	switch (res.verdict) {

This breaks tcx, please move all this logic into tc_run(). No changes to sch_handle_ingress()
or sch_handle_egress should be necessary, you can then just remap the return code to TC_ACT_SHOT
in such case.

>   	case TC_ACT_REDIRECT:
>   		/* skb_mac_header check was done by BPF, so we can safely
>   		 * push the L2 header back before redirecting to another
> @@ -4032,6 +4046,7 @@ static __always_inline struct sk_buff *
>   sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
>   {
>   	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
> +	struct tcf_result res = {0};
>   	int sch_ret;
>   
>   	if (!entry)
> @@ -4045,9 +4060,14 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
>   		if (sch_ret != TC_ACT_UNSPEC)
>   			goto egress_verdict;
>   	}
> -	sch_ret = tc_run(tcx_entry(entry), skb);
> +	sch_ret = tc_run(tcx_entry(entry), skb, &res);
> +	if (sch_ret < 0) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS_ERROR);
> +		*ret = NET_XMIT_DROP;
> +		return NULL;
> +	}
>   egress_verdict:
> -	switch (sch_ret) {
> +	switch (res.verdict) {
>   	case TC_ACT_REDIRECT:
>   		/* No need to push/pop skb's mac_header here on egress! */
>   		skb_do_redirect(skb);

