Return-Path: <bpf+bounces-50563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9BA29B89
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 21:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269533A5D93
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57A214804;
	Wed,  5 Feb 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjjI6+Pj"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D5211A11;
	Wed,  5 Feb 2025 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789093; cv=none; b=ErK9fb4RwHqibUCz6UG5LwU7blu8ZQDPPjSU/WBeUWTT3AGK71FLId6OTrF9IBXCYnE2CwXLk5kV5WdPX9c9KtbznFLYVA1sSJyHxTgFJslEETfd/0AVjNPn1AtaJirMns5EGibvGTTTZtMGq5Vteijdc2HX7YbwnHMknO+bHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789093; c=relaxed/simple;
	bh=974w9WNzre744cwFgClaZJnzz8KW4OIxYs8s+cIDqd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAwhw12yVSZJFB9dsnSlqtAkR843Jxu0J1ktzGiXQY3wVx1UbHAZesttZFgi3W0DadHwisjyLMINdnpAUCMiopI3RDTES+LxkNCHTfA6NPOkbyDr9du4g8p4SdvR+nKgh/eo75Lfut83Aw4lRrRYX2H4mayY+2HCrgRZcT8HnOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjjI6+Pj; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0f3159c8-d2fe-4fc0-8f09-260aa84e12bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738789087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgsSy0OoryuZB1KNdtGOjtxmKZLnYYEerJVr3XcyjS0=;
	b=kjjI6+Pj+ThkxPj57oGs9m9wRYfunuSEoY33ZDrJeI3xfr5mWzHk4zIQAkbfg2wz4eUUAO
	xrjLTP0E5hxSVfs2lLJP9oBfaRecrfGLd9CElYQ5VnyRdprzTyqina0ksCKwJzi67whaZp
	vYTv6D50p1dwGJp2IKJdnSo2MMAgskE=
Date: Wed, 5 Feb 2025 12:57:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 01/12] bpf: add support for bpf_setsockopt()
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-2-kerneljasonxing@gmail.com>
 <67a3821d3ae5b_14e0832944c@willemb.c.googlers.com.notmuch>
 <CAL+tcoA26mQQf-_0Ebi2qqd=qVn1soUoma-3o8NdUFGZL_-L2g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoA26mQQf-_0Ebi2qqd=qVn1soUoma-3o8NdUFGZL_-L2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/5/25 7:34 AM, Jason Xing wrote:
> On Wed, Feb 5, 2025 at 11:22 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> Jason Xing wrote:
>>> Users can write the following code to enable the bpf extension:
>>> int flags = SK_BPF_CB_TX_TIMESTAMPING;
>>> int opts = SK_BPF_CB_FLAGS;
>>> bpf_setsockopt(skops, SOL_SOCKET, opts, &flags, sizeof(flags));
>>>
>>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>>> ---
>>>   include/net/sock.h             |  3 +++
>>>   include/uapi/linux/bpf.h       |  8 ++++++++
>>>   net/core/filter.c              | 23 +++++++++++++++++++++++
>>>   tools/include/uapi/linux/bpf.h |  1 +
>>>   4 files changed, 35 insertions(+)
>>>
>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>> index 8036b3b79cd8..7916982343c6 100644
>>> --- a/include/net/sock.h
>>> +++ b/include/net/sock.h
>>> @@ -303,6 +303,7 @@ struct sk_filter;
>>>     *  @sk_stamp: time stamp of last packet received
>>>     *  @sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
>>>     *  @sk_tsflags: SO_TIMESTAMPING flags
>>> +  *  @sk_bpf_cb_flags: used in bpf_setsockopt()
>>>     *  @sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
>>>     *                     Sockets that can be used under memory reclaim should
>>>     *                     set this to false.
>>> @@ -445,6 +446,8 @@ struct sock {
>>>        u32                     sk_reserved_mem;
>>>        int                     sk_forward_alloc;
>>>        u32                     sk_tsflags;
>>> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
>>> +     u32                     sk_bpf_cb_flags;
>>>        __cacheline_group_end(sock_write_rxtx);
>>>
>>>        __cacheline_group_begin(sock_write_tx);
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 2acf9b336371..6116eb3d1515 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -6913,6 +6913,13 @@ enum {
>>>        BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
>>>   };
>>>
>>> +/* Definitions for bpf_sk_cb_flags */
>>> +enum {
>>> +     SK_BPF_CB_TX_TIMESTAMPING       = 1<<0,
>>> +     SK_BPF_CB_MASK                  = (SK_BPF_CB_TX_TIMESTAMPING - 1) |
>>> +                                        SK_BPF_CB_TX_TIMESTAMPING
>>> +};
>>> +
>>>   /* List of known BPF sock_ops operators.
>>>    * New entries can only be added at the end
>>>    */
>>> @@ -7091,6 +7098,7 @@ enum {
>>>        TCP_BPF_SYN_IP          = 1006, /* Copy the IP[46] and TCP header */
>>>        TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>>>        TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
>>> +     SK_BPF_CB_FLAGS         = 1009, /* Used to set socket bpf flags */
>>>   };
>>>
>>>   enum {
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 2ec162dd83c4..1c6c07507a78 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -5222,6 +5222,25 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
>>>        .arg1_type      = ARG_PTR_TO_CTX,
>>>   };
>>>
>>> +static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
>>> +{
>>> +     u32 sk_bpf_cb_flags;
>>> +
>>> +     if (getopt) {
>>> +             *(u32 *)optval = sk->sk_bpf_cb_flags;
>>> +             return 0;
>>> +     }
>>> +
>>> +     sk_bpf_cb_flags = *(u32 *)optval;
>>> +
>>> +     if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
>>> +             return -EINVAL;
>>> +
>>> +     sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
>>
>> I don't know BPF internals that well:
>>
>> Is there mutual exclusion between these sol_socket_sockopt calls?

Yep. There is a sock_owned_by_me() in the earlier code path of sol_socket_sockopt.

Another reader is at patch 11 tcp_tx_timestamp() which should have owned the 
sock also.

>> Or do these sk field accesses need WRITE_ONCE/READ_ONCE.

> this potential data race issue, just in case bpf program doesn't use
> it as we expect, I think I will add the this annotation in v9.

Jason, it should not have data race issue in sol_socket_sockopt(). bpf program 
cannot use the sol_socket_sockopt without a lock. Patch 4 was added exactly to 
ensure that.

The situation is similar to the existing tcp_sk(sk)->bpf_sock_ops_cb_flags. It 
is also a plain access such that it is clear all read/write is under the 
sock_owned_by_me.

