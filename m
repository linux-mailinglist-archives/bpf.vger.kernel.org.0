Return-Path: <bpf+bounces-29149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F418C0865
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59BD1C210AE
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121B17F3;
	Thu,  9 May 2024 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dOCja/Hv"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C710F7
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214280; cv=none; b=TQx2qV1B4nrba4NOvQ8J+LvZ8ek0gtkfIPWY8nXAzMBXPEqvtRP8BEmJefpdiG9xyg4Y/VYag6YG/rEBJPAcBVSu9SdQKsAWRr+hH3gvfxhMGAUtGANgwD5WbFy/Eq82odvrS9X4nxsuoRAMBiSynqKtF3d1hI97NiwOSkrtkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214280; c=relaxed/simple;
	bh=pjYpRdERIuxMngHTkrRiFHfOOLRpW3ZSJPPzj/EV1yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJkwlBOrNSCV6dpgq8Bkj5bNm+gydmsejQdk32MZQQ0Gvu49BF+CvIc7fT+NWiKjHR9hllfb62S96rZL6dUrZZ9nFEQE2mkGw80jLhPatFakkznixa9rIQm9alkq7Jd/KtdFU/z+0wCKK9IjRFFRM3bjEoO4UIbA/EYxPVztGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dOCja/Hv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07ea0e86-ca28-42e9-9e8f-a4188aef1096@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715214276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FNO9xOT12F+64tUJH2wXpfeIyMfLOAvBkOT50qKu38=;
	b=dOCja/HvFCewbqs+cU6EbcxjEhjfjVLWonNDQz/vawzNtZaS1+GCceknee0L5KR4kdk60z
	pU/A44r9T3lrJU9Xh7plB+BjDrsoYhCg8j5X/87w/nRH6os41yQLOMCqq9+U122smVakDm
	xQel5YXbBuBC2moRUyHRGoHJ85aaHnU=
Date: Wed, 8 May 2024 17:24:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_dynptr_from_skb() for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Daniel Rosenberg <drosen@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, bpf <bpf@vger.kernel.org>
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
 <20240430121805.104618-2-lulie@linux.alibaba.com>
 <5d4f681a-6636-4c98-9b1e-5c5170b79f7c@linux.dev>
 <CAADnVQJ1tycykaGEkD1ubi-kjFapKJBhffYePNsgQH7qh_9ivw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJ1tycykaGEkD1ubi-kjFapKJBhffYePNsgQH7qh_9ivw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 4:29 PM, Alexei Starovoitov wrote:
> On Mon, May 6, 2024 at 2:39 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/30/24 5:18 AM, Philo Lu wrote:
>>> Making tp_btf able to use bpf_dynptr_from_skb(), which is useful for skb
>>> parsing, especially for non-linear paged skb data. This is achieved by
>>> adding KF_TRUSTED_ARGS flag to bpf_dynptr_from_skb and registering it
>>> for TRACING progs. With KF_TRUSTED_ARGS, args from fentry/fexit are
>>> excluded, so that unsafe progs like fexit/__kfree_skb are not allowed.
>>>
>>> We also need the skb dynptr to be read-only in tp_btf. Because
>>> may_access_direct_pkt_data() returns false by default when checking
>>> bpf_dynptr_from_skb, there is no need to add BPF_PROG_TYPE_TRACING to it
>>> explicitly.
>>>
>>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>>> ---
>>>    net/core/filter.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 786d792ac816..399492970b8c 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -11990,7 +11990,7 @@ int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
>>>    }
>>>
>>>    BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>>> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
>>> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>>
>> I can see the usefulness of having the same way parsing the header as the
>> tc-bpf. However, it implicitly means the skb->data and skb_shinfo are trusted
>> also. afaik, it should be as long as skb is not NULL.
>>
>>   From looking at include/trace/events, there is case that skb is NULL. e.g.
>> tcp_send_reset. It is not something new though, e.g. using skb->sk in the tp_btf
>> could be bad already. This should be addressed before allowing more kfunc/helper.
> 
> Good catch.
> We need to fix this part first:
>          if (prog_args_trusted(prog))
>                  info->reg_type |= PTR_TRUSTED;
> 
> Brute force fix by adding PTR_MAYBE_NULL is probably overkill.
> I suspect passing NULL into tracepoint is more of an exception than the rule.
> Maybe we can use kfunc's "__" suffix approach for tracepoint args?
> [43947] FUNC_PROTO '(anon)' ret_type_id=0 vlen=4
>          '__data' type_id=10
>          'sk' type_id=3434
>          'skb' type_id=2386
>          'reason' type_id=39860
> [43948] FUNC '__bpf_trace_tcp_send_reset' type_id=43947 linkage=static
> 
> Then do:
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 49b5ee091cf6..325e8a31729a 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -91,7 +91,7 @@ DEFINE_RST_REASON(FN, FN)
>   TRACE_EVENT(tcp_send_reset,
> 
>          TP_PROTO(const struct sock *sk,
> -                const struct sk_buff *skb,
> +                const struct sk_buff *skb__nullable,
> 
> and detect it in btf_ctx_access().

+1. It is a neat solution. Thanks for the suggestion.

Philo, can you give it a try to fix this in the next re-spin?

