Return-Path: <bpf+bounces-41370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D49964D3
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8321285124
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34218B48B;
	Wed,  9 Oct 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qsUUPuSn"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3A18B470
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465428; cv=none; b=BouOMXlvdz5N2EvBZIzVkh4uQPVyOQD563QjKFKRLymko+Zk1ENE+A89hbn8/2G39vzU1xSIXCdd3LivHX2Pm3924jJnEroht5ckCJ2TkI29EKkor/c/G94L9fGOnRRO3zuYtabMefe2DwUDCUWhOQTBz87U958jfTL6FReVEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465428; c=relaxed/simple;
	bh=1bi01EMqWEaA+vrK0+7LEkl25gRd1evQhlIC8Zil7dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEOhz+Twe+I04djy8P4IWy0isK+DHL1Za0KRi5vIVNzBqAXyAQg75Mkuycn2qPT3xcn39BBXecxXaQgeUh6n+sLK0X7PJT2lj8Wzd7L9+twf1X0bfBfjLksKiGbN/tCXlT5jrCNUdO56okFFZ6I/bHwdmxVpPFwhcEcG9x7Vn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qsUUPuSn; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <842adc49-b75e-49b1-89ea-9c5229a44447@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728465419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eirhv/tXpQ82QkTFoIxmPOYSAd/dxtreJiwAdIXrTeM=;
	b=qsUUPuSnvP1tOQtKd9j0i0Ef2JXFL1J07jlPvoT0Yjznvavo61+zW0jcryS1bIhKz53pz4
	M0K70crPYumtzp23jQvumhvXNnaa7+uktKpD4oOi+4vXCSlCautXaFRr8YqPOfXCurv8xR
	V9wGNrB+OsNRuhgh+4UvNdCFZZ0IKQU=
Date: Wed, 9 Oct 2024 10:16:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/9] net-timestamp: ready to turn on the button
 to generate tx timestamps
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-6-kerneljasonxing@gmail.com>
 <b82d7025-188d-41dc-a70c-06aa0fb26d24@linux.dev>
 <CAL+tcoAbYF2k88r84VW-3COU5W8dOQ2gFHBq3OiXig3Ze+reXg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAL+tcoAbYF2k88r84VW-3COU5W8dOQ2gFHBq3OiXig3Ze+reXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 09/10/2024 00:48, Jason Xing wrote:
> On Wed, Oct 9, 2024 at 3:18 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 08/10/2024 10:51, Jason Xing wrote:
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> Once we set BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG flag here, there
>>> are three points in the previous patches where generating timestamps
>>> works. Let us make the basic bpf mechanism for timestamping feature
>>>    work finally.
>>>
>>> We can use like this as a simple example in bpf program:
>>> __section("sockops")
>>>
>>> case BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB:
>>>        dport = bpf_ntohl(skops->remote_port);
>>>        sport = skops->local_port;
>>>        skops->reply = SOF_TIMESTAMPING_TX_SCHED;
>>>        bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG);
>>> case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
>>>        bpf_printk(...);
>>>
>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>> ---
>>>    include/uapi/linux/bpf.h       |  8 ++++++++
>>>    net/ipv4/tcp.c                 | 27 ++++++++++++++++++++++++++-
>>>    tools/include/uapi/linux/bpf.h |  8 ++++++++
>>>    3 files changed, 42 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 1b478ec18ac2..6bf3f2892776 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -7034,6 +7034,14 @@ enum {
>>>                                         * feature is on. It indicates the
>>>                                         * recorded timestamp.
>>>                                         */
>>> +     BPF_SOCK_OPS_TX_TS_OPT_CB,      /* Called when the last skb from
>>> +                                      * sendmsg is going to push when
>>> +                                      * SO_TIMESTAMPING feature is on.
>>> +                                      * Let user have a chance to switch
>>> +                                      * on BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG
>>> +                                      * flag for other three tx timestamp
>>> +                                      * use.
>>> +                                      */
>>>    };
>>>
>>>    /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index 82cc4a5633ce..ddf4089779b5 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -477,12 +477,37 @@ void tcp_init_sock(struct sock *sk)
>>>    }
>>>    EXPORT_SYMBOL(tcp_init_sock);
>>>
>>> +static u32 bpf_tcp_tx_timestamp(struct sock *sk)
>>> +{
>>> +     u32 flags;
>>> +
>>> +     flags = tcp_call_bpf(sk, BPF_SOCK_OPS_TX_TS_OPT_CB, 0, NULL);
>>> +     if (flags <= 0)
>>> +             return 0;
>>> +
>>> +     if (flags & ~SOF_TIMESTAMPING_MASK)
>>> +             return 0;
>>> +
>>> +     if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
>>> +             return 0;
>>> +
>>> +     return flags;
>>> +}
>>> +
>>>    static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>>>    {
>>>        struct sk_buff *skb = tcp_write_queue_tail(sk);
>>>        u32 tsflags = sockc->tsflags;
>>> +     u32 flags;
>>> +
>>> +     if (!skb)
>>> +             return;
>>> +
>>> +     flags = bpf_tcp_tx_timestamp(sk);
>>> +     if (flags)
>>> +             tsflags = flags;
>>
>> In this case it's impossible to clear timestamping flags from bpf
> 
> It cannot be cleared only from the last skb until the next round of
> recvmsg. Since the last skb is generated and bpf program is attached,
> I would like to know why we need to clear the related fields in the
> skb? Please note that I didn't hack the sk_tstflags in struct sock :)

>> program, but it may be very useful. Consider providing flags from
>> socket cookie to the program or maybe add an option to combine them?
> 
> Thanks for this idea. May I ask what the benefits are through adding
> an option because the bpf test statement (BPF_SOCK_OPS_TEST_FLAG) is a
> good option to take a whole control? Or could you provide more details
> about how you expect to do so?

Well, as Willem mentioned, you are overriding flags completely. But what
if an application is waiting for some type of timestamp to arrive, but
bpf program rewrites flags and disables this type of timestamp? It will
confuse application.

Thinking twice, clearing flags might not be useful because of the very
same issue though.


> 
> Thanks,
> Jason


