Return-Path: <bpf+bounces-42169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785F9A044C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CD81F28783
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB31F8923;
	Wed, 16 Oct 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmbWoCR0"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D121F80BD
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067522; cv=none; b=a6SEvAhHLEy0skOnpzWz16WdWPoI80cXiAFiPogArSUVn3XNw+zdLkxdCS8ce1WulEl/ZHSKozTGPknhArkcMkiLQXQkeB0eLyNSOgp2CDUJs/swyPxxfpXMSsSFtLHlfrwSH3GAS2vlDvZQEtV10Rsr9LkFKtb2x7RlPTNfgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067522; c=relaxed/simple;
	bh=tROI3bah+krsLcG2f1qdU1xCWFygYtBlzuavQPiowf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8pY4QJqQTNEQAT1Gmc5R/oLXlnqhq62rjNJ8cV2TczHpI7Nc5EvDA8km8V1P6e+KUQlsvxfNv1stkrZy2c3kK/pjV01i00IF0/96duzkVK3dskmotbAHMLADu3S0PHPt/Co9LDDcyPoueKPpzbqGNwOJbTcHOs+PJCTYwvlT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmbWoCR0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c669769f-8437-46cc-95b4-d3f84c1c95b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729067516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6be43xv2Svj+3BE1cQiOFuYI3VXwQJv9e0dPmIoBRzY=;
	b=cmbWoCR0oFziiBtiEakVb8KPBXTTS8sjA0l2p0XhPm/m4jLY/pwnYeE0ES9CwAmrfCMtQG
	QeE4J0maXiMX5oWCZW+FFHTLJ0qFOpH5egrTpecxOFyufHkoBOXfdg/OHjexUI73YSrb1x
	3ovxexlGs26VvzL8ekpWZ1Xq2stKNf8=
Date: Wed, 16 Oct 2024 01:31:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
 <CAL+tcoBXj=EO-sk-dS+dN-pCZf8OKeOZ4LXb9GZnja3EfOhXYg@mail.gmail.com>
 <9f050a5c-644f-4fbb-ac37-53edfd160edc@linux.dev>
 <CAL+tcoDyt=3hjwdx8Wk-abKg=qQsY=7UKu9=TU4iUAk5gMT2MQ@mail.gmail.com>
 <5398c020-e9b4-49d2-a5fa-dca047296ddd@linux.dev>
 <CAL+tcoDb84bgUUpK9PjijWDt+xw=u2nKkoWf1Gjvkjf--XJ6VA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoDb84bgUUpK9PjijWDt+xw=u2nKkoWf1Gjvkjf--XJ6VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 12:54 AM, Jason Xing wrote:
> On Wed, Oct 16, 2024 at 3:01 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/15/24 11:30 PM, Jason Xing wrote:
>>> On Wed, Oct 16, 2024 at 2:13 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 10/15/24 6:32 PM, Jason Xing wrote:
>>>>> On Wed, Oct 16, 2024 at 9:04 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>>>>>
>>>>>> On Wed, Oct 16, 2024 at 8:10 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>>>
>>>>>>> On 10/11/24 9:06 PM, Jason Xing wrote:
>>>>>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>>>>>
>>>>>>>> Willem suggested that we use a static key to control. The advantage
>>>>>>>> is that we will not affect the existing applications at all if we
>>>>>>>> don't load BPF program.
>>>>>>>>
>>>>>>>> In this patch, except the static key, I also add one logic that is
>>>>>>>> used to test if the socket has enabled its tsflags in order to
>>>>>>>> support bpf logic to allow both cases to happen at the same time.
>>>>>>>> Or else, the skb carring related timestamp flag doesn't know which
>>>>>>>> way of printing is desirable.
>>>>>>>>
>>>>>>>> One thing important is this patch allows print from both applications
>>>>>>>> and bpf program at the same time. Now we have three kinds of print:
>>>>>>>> 1) only BPF program prints
>>>>>>>> 2) only application program prints
>>>>>>>> 3) both can print without side effect
>>>>>>>>
>>>>>>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>>>>>>> ---
>>>>>>>>      include/net/sock.h |  1 +
>>>>>>>>      net/core/filter.c  |  3 +++
>>>>>>>>      net/core/skbuff.c  | 38 ++++++++++++++++++++++++++++++++++++++
>>>>>>>>      3 files changed, 42 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>>>>>>> index 66ecd78f1dfe..b7c51b95c92d 100644
>>>>>>>> --- a/include/net/sock.h
>>>>>>>> +++ b/include/net/sock.h
>>>>>>>> @@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
>>>>>>>>      void sock_def_readable(struct sock *sk);
>>>>>>>>
>>>>>>>>      int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
>>>>>>>> +DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
>>>>>>>>      void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
>>>>>>>>      int sock_get_timestamping(struct so_timestamping *timestamping,
>>>>>>>>                            sockptr_t optval, unsigned int optlen);
>>>>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>>>>> index 996426095bd9..08135f538c99 100644
>>>>>>>> --- a/net/core/filter.c
>>>>>>>> +++ b/net/core/filter.c
>>>>>>>> @@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
>>>>>>>>          .arg1_type      = ARG_PTR_TO_CTX,
>>>>>>>>      };
>>>>>>>>
>>>>>>>> +DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
>>>>>>>> +
>>>>>>>>      static int bpf_sock_set_timestamping(struct sock *sk,
>>>>>>>>                                       struct so_timestamping *timestamping)
>>>>>>>>      {
>>>>>>>> @@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struct sock *sk,
>>>>>>>>                  return -EINVAL;
>>>>>>>>
>>>>>>>>          WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
>>>>>>>> +     static_branch_enable(&bpf_tstamp_control);
>>>>>>>
>>>>>>> Not sure when is a good time to do static_branch_disable().
>>>>>>
>>>>>> Thanks for the review.
>>>>>>
>>>>>> To be honest, I considered how to disable the static key. Like you
>>>>>> said, I failed to find a good chance that I can accurately disable it.
>>>>>>
>>>>>>>
>>>>>>> The bpf prog may be detached also. (IF) it ends up staying with the
>>>>>>> cgroup/sockops interface, it should depend on the existing static key in
>>>>>>> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.
>>>>>>
>>>>>> Are you suggesting that we need to remove the current static key? In
>>>>>> the previous thread, the reason why Willem came up with this idea is,
>>>>>> I think, to avoid affect the non-bpf timestamping feature.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>          return 0;
>>>>>>>>      }
>>>>>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>>>>>> index f36eb9daa31a..d0f912f1ff7b 100644
>>>>>>>> --- a/net/core/skbuff.c
>>>>>>>> +++ b/net/core/skbuff.c
>>>>>>>> @@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>>>>>>>>      }
>>>>>>>>      EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>>>>>>>>
>>>>>>>> +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tstype)
>>>>>>>
>>>>>>> sk is unused.
>>>>>>
>>>>>> Thanks for the careful check.
>>>>>>
>>>>>>>
>>>>>>>> +{
>>>>>>>> +     u32 testflag;
>>>>>>>> +
>>>>>>>> +     switch (tstype) {
>>>>>>>> +     case SCM_TSTAMP_SCHED:
>>>>>>>
>>>>>>> Instead of doing this translation,
>>>>>>> is it easier to directly store the bpf prog desired ts"type" (i.e. the
>>>>>>> SCM_TSTAMP_*) in the sk->sk_tsflags_bpf?
>>>>>>> or there is a specific need to keep the SOF_TIMESTAMPING_* value in
>>>>>>> sk->sk_tsflags_bpf?
>>>>>>
>>>>>> We have to reuse SOF_TIMESTAMPING_* because there are more flags, say,
>>>>>> SOF_TIMESTAMPING_OPT_ID, that we need to support.
>>>>>>
>>>>>>>
>>>>>>>> +             testflag = SOF_TIMESTAMPING_TX_SCHED;
>>>>>>>> +             break;
>>>>>>>> +     case SCM_TSTAMP_SND:
>>>>>>>> +             testflag = SOF_TIMESTAMPING_TX_SOFTWARE;
>>>>>>>> +             break;
>>>>>>>> +     case SCM_TSTAMP_ACK:
>>>>>>>> +             testflag = SOF_TIMESTAMPING_TX_ACK;
>>>>>>>> +             break;
>>>>>>>> +     default:
>>>>>>>> +             return false;
>>>>>>>> +     }
>>>>>>>> +     if (tsflags & testflag)
>>>>>>>> +             return true;
>>>>>>>> +
>>>>>>>> +     return false;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>>>>>>>>                                   const struct sk_buff *ack_skb,
>>>>>>>>                                   struct skb_shared_hwtstamps *hwtstamps,
>>>>>>>> @@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>>>>>>>>          if (!skb_may_tx_timestamp(sk, tsonly))
>>>>>>>>                  return;
>>>>>>>>
>>>>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
>>>>>>>
>>>>>>> This is a new test. tsflags is the sk->sk_tsflags here if I read it correctly.
>>>>>>
>>>>>> This test will be used in bpf and non-bpf cases. Because of this, we
>>>>>> can support BPF extension. In this function, if skb has tsflags but we
>>>>>> don't know which approach the user expects, sk_tstamp_tx_flags() can
>>>>>> help us.
>>>>>>
>>>>>>>
>>>>>>> My understanding is the sendmsg can provide SOF_TIMESTAMPING_* for individual
>>>>>>> skb. Would it break?
>>>>>>
>>>>>> Oh, you're right. I didn't support cmsg mode...
>>>>>
>>>>> I think I only need to test if it's in the bpf mode, or else let the
>>>>> original way print the timestamp, which can solve the issue.
>>>>
>>>>    From looking at the existing "__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
>>>> SCM_TSTAMP_SCHED);":
>>>>
>>>> int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>>>> {
>>>>           /* ... */
>>>>
>>>>           if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
>>>>                   __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
>>>>
>>>>           /* ... */
>>>> }
>>>>
>>>> I am still puzzling how __skb_tstamp_tx() will be called if only bpf has enabled
>>>> the timestamping. I may have missed somewhere in the patch set that the skb's
>>>> tx_flags is changed by sk->sk_tsflags_bpf alone?
>>>
>>> If sk_tsflags_bpf is set, tcp_sendmsg() -> tcp_tx_timestamp() will be
>>> helpful, which initializes every last skb, please see patch [10/12].
>>
>> Ah. ok. It is the thing I missed. Thanks for the pointer.
>>
>>>>
>>>> I think a skb tskey is still desired (?), so eventually we want some spaces in
>>>
>>> tskey function is optional I think. It depends whether users want to
>>> use it or not. It can controlled by SOF_TIMESTAMPING_OPT_ID flag.
>>>
>>>> the skb for bpf. Jakub Sitnicki (cc-ed) has presented in LPC about extending
>>>> skb->data_meta usage outside of xdp and tc. I think here we want to have it
>>>> available at the tx side to store the tx_flags and tskey but probably want them
>>>> at a specific place/offset at the data_meta.
>>>
>>> If we have the plan to store extra information in data_meta, I can
>>> give it a try:)
>>>
>>>>
>>>> For now, is there thing we can explore to share in the skb_shared_info?
>>>
>>> My initial thought is just to reuse these fields in skb. It can work
>>> without interfering one another.
>>
>> After reading closer to patch 10, I am likely still missing something. How can
>> it tell if the tx_flags is set by the bpf or by the user space cmsg?
> 
> If the skb carries the timestamp, there are three cases:
> 1) non-bpf case and users uses setsockopt()
> 2) cmsg case
> 3) bpf case
> 
> #1 and #2 are already handled well before this patch. I only need to
> test if sk_tsflags_bpf has those flags. If so, it means we hit #3, or
> else it could be #1 or #2, then we will let the old way print
> timestamps in __skb_tstamp_tx().

hmm... I am still not sure I fully understand...but I think I may start getting it.

Is it the reason that the bpf_setsockopt() cannot clear the sk_tsflags_bpf once 
it is set in patch 2? It is not a usable api tbh. It will be a surprise to many. 
It has to be able to set and clear.

Does it also mean either the bpf or the user space can enable the timetstamping 
but not both? I don't think we can assume this also. It will be hard to deploy 
the bpf prog in production to collect continuous data. The user space may have 
some timestamping enabled but the bpf may want to do its parallel investigation 
also. The user space may rollout timestamping in the future and suddenly break 
the bpf prog.

[ getting late here. will continue later. ]

> 
>>
>>>
>>>> Can the "struct skb_shared_hwtstamps hwtstamps;" be used for the bpf tx_flags and tskey
>>>> only at the "tx" side? There is already another union member.
>>>
>>> tskey is always used in the tx path.
>>>
>>> hwtstamps can be used in both rx and tx cases (please see
>>> tcp_update_recv_tstamps() and skb_tstamp_tx()).
>>
>> hmm... we only need some where to store the bpf tx_flags and bpf tskey in the
>> TX-ing skb.
> 
> And there is one more field we have to take care of: txstamp_ack which
> indicates whether we print timestamp when the last skb is acked.
> Please see tcp_tx_timestamp().
> 
>> You meant the hwtstamps of a Tx-ing skb is not empty?
> 
> Sometimes, it's not empty if the hardware supports the timestamp
> feature and the user wants to see it (by enabling the
> SOF_TIMESTAMPING_TX_HARDWARE flag). As we can see, there are many
> callers calling skb_tstamp_tx().
> 
>>
>> At skb_tstamp_tx (TX side only?), the orig_skb's hwtstamps has not been written yet?
> 
> I'm not that sure about the orig_skb. It seems no. I can see some
> callers reading ptp timestamp from the nic and pass the timestamp to
> skb_tstamp_tx().
> 
> Thanks,
> Jason


