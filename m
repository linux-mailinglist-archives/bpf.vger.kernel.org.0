Return-Path: <bpf+bounces-11254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D697B64E4
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 93EEF281844
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5DDDDDA;
	Tue,  3 Oct 2023 09:00:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689FDDAA;
	Tue,  3 Oct 2023 09:00:47 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D2AB;
	Tue,  3 Oct 2023 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=n6LwwRSc60JjT2wGOKry5g3FrtE4NwWeJc6LbGQnXio=; b=DMo2nf6QwifwnDzNwzNa0/qzFd
	Sqjcfq6IlxI5Vr5c1d3zTqwLg+Zl4BvpjRkDcqxonD4zLg6K2nmbykYrLZuEhRzW+tL+xk8XxM1ZA
	c0HSZIuPLL4AtxOa8fZvB2AGSmarSnB6d6Q/lqZHqn3XiKwUR7I+lfL4RFsRi9SFY3+nxFp5fpFIL
	vA6SnELJkYWocnO8oYtSeYNnISkLbyWQoDJvKsNW26pkPfaThTjP1ttqSfQfyUgww/mwy9vaaN4/A
	tE7DVQ6PvR5tGEZA/hMEf4J0R6D2bB293kwke+bc8wI/La4TZtRH42YJVcPLOkxON0Fy1J5V9DjZx
	dU09V36Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qnbGZ-000D9z-IA; Tue, 03 Oct 2023 11:00:31 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qnbGZ-000Uk7-4N; Tue, 03 Oct 2023 11:00:31 +0200
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
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
Date: Tue, 3 Oct 2023 11:00:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27050/Tue Oct  3 09:39:20 2023)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/2/23 9:54 PM, Jamal Hadi Salim wrote:
> On Fri, Sep 29, 2023 at 11:48 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 9/26/23 1:01 AM, Jamal Hadi Salim wrote:
>>> On Fri, Sep 22, 2023 at 4:12 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> On 9/20/23 1:20 AM, Jamal Hadi Salim wrote:
>>>>> On Tue, Sep 19, 2023 at 6:15 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>> On 9/19/23 4:59 PM, Victor Nogueira wrote:
>> [...]
>>>>
>>>> In the above case we don't have 'internal' errors which you want to trace, so I would
>>>> also love to avoid the cost of zeroing struct tcf_result res which should be 3x 8b for
>>>> every packet.
>>>
>>> We can move the zeroing inside tc_run() but we declare it in the same
>>> spot as we do right now. You will still need to set res.verdict as
>>> above.
>>> Would that work for you?
>>
>> What I'm not following is that with the below you can avoid the unnecessary
>> fast path cost (which is only for corner case which is almost never hit) and
>> get even better visibility. Are you saying it doesn't work?
> 
> I am probably missing something:
> -1/UNSPEC is a legit errno. And the main motivation here for this
> patch is to disambiguate if it was -EPERM vs UNSPEC
> Maybe that is what you are calling a "corner case"?

Yes, but what is the use-case to ever return a -EPERM from the fast-path? This can
be audited for the code in the tree and therefore avoided so that you never run into
this problem.

> There are two options in my mind right now (since you are guaranteed
> in tcx_run you will never return anything below UNSPEC):
> 1) we just have the switch statement invocation inside an inline
> function and you can pass it sch_ret (for tcx case) and we'll pass it
> res.verdit for tc_run() case.
> 2) is something is we leave tcx_run alone and we have something along
> the lines of:
> 
> --------------
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1450f4741d9b..93613bce647c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3985,7 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct
> packet_type **pt_prev, int *ret,
>                     struct net_device *orig_dev, bool *another)
>   {
>          struct bpf_mprog_entry *entry =
> rcu_dereference_bh(skb->dev->tcx_ingress);
> -       struct tcf_result res = {0};
> +       struct tcf_result res;
>          int sch_ret;
> 
>          if (!entry)
> @@ -4003,14 +4003,16 @@ sch_handle_ingress(struct sk_buff *skb, struct
> packet_type **pt_prev, int *ret,
>                  if (sch_ret != TC_ACT_UNSPEC)
>                          goto ingress_verdict;
>          }
> +
> +       res.verdict = 0;
>          sch_ret = tc_run(tcx_entry(entry), skb, &res);
>          if (sch_ret < 0) {
>                  kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR);
>                  *ret = NET_RX_DROP;
>                  return NULL;
>          }
> +       sch_ret = res.verdict;
>   ingress_verdict:
> -       switch (res.verdict) {
> +       switch (sch_ret) {
>          case TC_ACT_REDIRECT:
>                  /* skb_mac_header check was done by BPF, so we can
> safely
>                   * push the L2 header back before redirecting to another
> -----------
> 
> on the drop reason - our thinking is to support drop_watch alongside
> tracepoint given kfree_skb_reason exists already; if i am not mistaken
> what you suggested would require us to create a new tracepoint?

So if the only thing you really care about is the different drop reason for
kfree_skb_reason, then I still don't follow why you need to drag this into
struct tcf_result. This can be done in a much simpler and more efficient way
like the following:

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a587e83fc169..b1c069c8e7f2 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -80,6 +80,8 @@
  	FN(IPV6_NDISC_BAD_OPTIONS)	\
  	FN(IPV6_NDISC_NS_OTHERHOST)	\
  	FN(QUEUE_PURGE)			\
+	FN(TC_EGRESS_ERROR)		\
+	FN(TC_INGRESS_ERROR)		\
  	FNe(MAX)

  /**
@@ -345,6 +347,10 @@ enum skb_drop_reason {
  	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
  	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
  	SKB_DROP_REASON_QUEUE_PURGE,
+	/** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOOK due to error */
+	SKB_DROP_REASON_TC_EGRESS_ERROR,
+	/** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress HOOK due to error */
+	SKB_DROP_REASON_TC_INGRESS_ERROR,
  	/**
  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
  	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index f308e8268651..cd2444dd3745 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -10,6 +10,7 @@

  /* TC action not accessible from user space */
  #define TC_ACT_CONSUMED		(TC_ACT_VALUE_MAX + 1)
+#define TC_ACT_ABORT		(TC_ACT_VALUE_MAX + 2)

  /* Basic packet classifier frontend definitions. */

diff --git a/net/core/dev.c b/net/core/dev.c
index 85df22f05c38..3abb4d71c170 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4011,7 +4011,10 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
  		*ret = NET_RX_SUCCESS;
  		return NULL;
  	case TC_ACT_SHOT:
-		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
+	case TC_ACT_ABORT:
+		kfree_skb_reason(skb, likely(sch_ret == TC_ACT_SHOT) ?
+				 SKB_DROP_REASON_TC_INGRESS :
+				 SKB_DROP_REASON_TC_INGRESS_ERROR);
  		*ret = NET_RX_DROP;
  		return NULL;
  	/* used by tc_run */
@@ -4054,7 +4057,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
  		*ret = NET_XMIT_SUCCESS;
  		return NULL;
  	case TC_ACT_SHOT:
-		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
+	case TC_ACT_ABORT:
+		kfree_skb_reason(skb, likely(sch_ret == TC_ACT_SHOT) ?
+				 SKB_DROP_REASON_TC_EGRESS :
+				 SKB_DROP_REASON_TC_EGRESS_ERROR);
  		*ret = NET_XMIT_DROP;
  		return NULL;
  	/* used by tc_run */

Then you just return the internal TC_ACT_ABORT code for internal 'exceptions',
and you'll get the same result to make it observable for dropwatch.

Thanks,
Daniel

