Return-Path: <bpf+bounces-43678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED169B8724
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5E61F2235D
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12541E47A4;
	Thu, 31 Oct 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MWcn5PRs"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5321CBE84
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730417209; cv=none; b=R52eqxLbejBIFzDSEkgvKQEUO2aD0MqZS9/tAsBwrVnJaOQ0wP4qjx8gS8nUUcZaeKr90slZzzPqvd/r9ZdAMxEjkLhsBrl5PvD2BjLgazLk0jLEu5a/4BQ2rHlv3KGNdFuB989MBv2X53Wndtb6IdvcANIoxqoKDEqVGEhVMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730417209; c=relaxed/simple;
	bh=RjyyU1STs525VCHLiK2K0WaRJ8/Y03OY0offHPy/z2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnQsDkF1cfUaI5KSj1v8mv8x4oRHgWKx+Re0HjL38Eld8SzR6d2n+/1S4z46HcwlIk+/KE7GDJrW1FzGTzJAcU21pr7DM6xiBLtem3wKp/CJdVRlnywZBVdM5D36ed/9jTxvFC4TI2iyRRj0w51vCGtIyfsBe/BRoCa8jcA99yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MWcn5PRs; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730417200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEWDU1bgfaxNPqokWd/jjkn7O1n5/3F0X07dc7Tnwg4=;
	b=MWcn5PRsOdwINjQNTjK7KqzJzny0pMVhZFruI6yZWJXf3/LPH4E0u8g9vJqL5j7gp+D4QC
	124VLDR8X21jTkIRjgjBeCPj2SbBK8mSfZPbc5zp4lule7tGAQWHf25kGUY3d6OYLJ5NTb
	GFGTvLqzmXAHaZMdmxkjOVL1tubuHyw=
Date: Thu, 31 Oct 2024 16:26:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: willemb@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/31/24 6:50 AM, Jason Xing wrote:
> On Thu, Oct 31, 2024 at 8:30 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> Jason Xing wrote:
>>> On Thu, Oct 31, 2024 at 2:27 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 10/30/24 5:13 PM, Jason Xing wrote:
>>>>> I realized that we will have some new sock_opt flags like
>>>>> TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
>>>>> not... For each sock_opt point, they will be called without caring if
>>>>> related flags in skb are set. Well, it's meaningless to add more
>>>>> control of skb tsflags at each TS_xx_OPT_CB point.
>>>>>
>>>>> Am I understanding in a correct way? Now, I'm totally fine with this great idea!
>>>> Yes, I think so.
>>>>
>>>> The sockops prog can choose to ignore any BPF_SOCK_OPS_TS_*_CB. The are only 3:
>>>> SCHED, SND, and ACK. If the hwtstamp is available from a NIC, I think it would
>>>> be quite wasteful to throw it away. ACK can be controlled by the
>>>> TCP_SKB_CB(skb)->bpf_txstamp_ack.
>>>
>>> Right, let me try this:)
>>>
>>>> Going back to my earlier bpf_setsockopt(SOL_SOCKET, BPF_TX_TIMESTAMPING)
>>>> comment. I think it may as well go back to use the "u8
>>>> bpf_sock_ops_cb_flags;" and use the bpf_sock_ops_cb_flags_set() helper to
>>>> enable/disable the timestamp related callback hook. May be add one
>>>> BPF_SOCK_OPS_TX_TIMESTAMPING_CB_FLAG.
>>>
>>> bpf_sock_ops_cb_flags this flag is only used in TCP condition, right?
>>> If that is so, it cannot be suitable for UDP.
>>>
>>> I'm thinking of this solution:
>>> 1) adding a new flag in SOF_TIMESTAMPING_OPT_BPF flag (in
>>> include/uapi/linux/net_tstamp.h) which can be used by sk->sk_tsflags

probably not in include/uapi/linux/net_tstamp.h. This flag can only be used by a 
bpf prog (meaning will not be used by user space syscall). More below.

>>> 2) flags =   SOF_TIMESTAMPING_OPT_BPF;    bpf_setsockopt(skops,
>>> SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
>>> 3) test if sk->sk_tsflags has this new flag in tcp_tx_timestamp() or
>>> in udp_sendmsg()
>>> ...

Not sure how many churns/audits is needed to ensure the user space cannot 
set/clear the SOF_TIMESTAMPING_OPT_BPF bit in sk->sk_tsflags. Could be not much.

May be it is cleaner to leave the sk->sk_tsflags for user space only and having 
a separate field in "struct sock" to track bpf specific needs. More like your 
current sk_tsflags_bpf approach but I was thinking to reuse the 
bpf_sock_ops_cb_flags instead. e.g. "BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), 
BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)" is used to check if it needs to call a bpf 
prog to decide if it needs to add tcp header option. Here we want to test if it 
should call a bpf prog to make a decision on tx timestamp on a skb.

The bpf_sock_ops_cb_flags can be moved from struct tcp_sock to struct sock. It 
is doable from the bpf side.

All that said, but, yes, it will add some TCP specific enum flag (e.g. 
BPF_SOCK_OPS_RTO_CB_FLAG) to the struct sock which will not be used by 
UDP/raw/...etc, so may be keep your current sk_tsflags_bpf approach but rename 
it to sk_bpf_cb_flags in struct "sock" so that it can be reused for other non 
tstamp ops in the future? probably a u8 is enough.

This optname is used by the bpf prog only and not usable by user space syscall. 
If it prefers to stay with bpf_setsockopt (which is fine), it needs a bpf 
specific optname like the current TCP_BPF_SOCK_OPS_CB_FLAGS which currently sets 
the tp->bpf_sock_ops_cb_flags. May be a new SK_BPF_CB_FLAGS optname for setting 
the sk->sk_bpf_cb_flags, like bpf_setsockopt(skops_ctx, SOL_SOCKET, 
SK_BPF_CB_FLAGS, &val, sizeof(val)) and handle it in the sol_socket_sockopt() 
alone without calling into sk_{set,get}sockopt. Add a new enum for the optval 
for the sk_bpf_cb_flags:

enum {
	SK_BPF_CB_TX_TIMESTAMPING = (1 << 0),
	SK_BPF_CB_RX_TIEMSTAMPING = (1 << 1),
};


>>>
>>>>
>>>> For tx, one new hook should be at the sendmsg and should be around
>>>> tcp_tx_timestamp (?) for tcp. Another hook is __skb_tstamp_tx() which should be
>>>
>>> I think there are two points we're supposed to record:
>>> 1) the moment tcp/udp_sendmsg() is triggered. It represents the syscall time.
>>> 2) another point in tcp_tx_timestamp(). It represents the timestamp of
>>> the last skb in this sendmsg() call.
>>> Users may happen to send a big packet.

hmm... a big packet and sendmsg is blocked waiting for memory?

>>
>> Err on the side of fewer measurement points. It's always possible to
>> add more later, but not possible to remove them (depending on whether
>> BPF infra is ABI).

I also think it is better to start with tcp_tx_timestamp() alone first to keep 
the patch set simple now. The selftest prog can use a bpf fentry prog to trace 
the tcp_sendmsg_locked(). This can be revisited later if the bpf fentry prog is 
not enough.

>>
>> Overall great suggestion. Thanks a lot for sharing your BPF expertise
>> on this, Martin.

Thanks!

>>
>> On using the raw seqno: this data is accessible to anyone root in
>> namespace (ns_capable) using packet sockets, so as long as it does not
>> open to more than that, it is logically equivalent to the current
>> setting.
>>
>> With seqno the BPF program has to be careful that the same seqno can
>> be retransmitted, so for instance seeing an ACK before a (second) SND
>> must be anticipated. That is true for SO_TIMESTAMPING today too.

Ah. It will be a very useful comment to add to the selftests bpf prog.

>>
>> For datagrams (UDP as well as RAW and many non IP protocols), an
>> alternative still needs to be found.

In udp/raw/..., I don't know how likely is the user space having "cork->tx_flags 
& SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) & 
SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set. If it is 
unlikely, may be we can just disallow bpf prog from directly setting 
skb_shinfo(skb)->tskey for this particular skb.

For all other cases, in __ip[6]_append_data, directly call a bpf prog and also 
pass the kernel decided tskey to the bpf prog.

The kernel passed tskey could be 0 (meaning the user space has not used it). The 
bpf prog can give one for the kernel to use. The bpf prog can store the 
sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to the struct 
sock. The bpf prog does not have to start from 0 (e.g. start from U32_MAX 
instead) if it helps.

If the kernel passed tskey is not 0, the bpf prog can just use that one 
(assuming the user space is doing something sane, like the value in 
SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I hope this 
is very unlikely also (?) but the bpf prog can probably detect this and choose 
to ignore this sk.

To solve the above unsupported corner cases, I think we can allow the bpf prog 
to store something in the shinfo->hwtstamps at the tx path. The bpf-only key 
could be one of the things to store there. Change __ip[6]_append_data to handle 
the shinfo->hwtstamps. I think allowing the bpf prog to write to the 
shinfo->hwtsatmps could be considered later when needed.

[ I may be off tomorrow, so reply could be slower. ]

> 
> It seems that using the tskey for bpf extension is always correct and
> easy to use.
> 
> Could we provide the tskey to users and then let users decide the
> better way to identify the call of sendmsg. We could keep the
> traditional use of tskey. If without it, people need to figure out a
> good way and may find it difficult to use the bpf extension.
> 
> I will keep thinking of alternatives for UDP in the meantime.

