Return-Path: <bpf+bounces-28067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE28B54D6
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 12:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84871F223F3
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352C2C86A;
	Mon, 29 Apr 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LbpXGuXH"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED882940D;
	Mon, 29 Apr 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385737; cv=none; b=o+3sZRSSffNljqk+Vmfgz1yuGADOLR3LTrx/lm0moYcFkiLJZ3A8AP24rhjHmEWOlhtHC2k+OWLFrkPFZ/opZ0ncRAqsBf/HO4fzrhieBpUIKrA3WvvJJfk+7ws9ba+yoCILfXbVGZavDDP3C23zHwCwPJlFe/mpuKttil26VaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385737; c=relaxed/simple;
	bh=nLArAdMr2jal4mp6LgZ1sjlUXe2KL679GmsRHQcMBYE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nZnbRLjzp30ad64Ei76GsIY3nUa3BKlBu9NfH0DgTBhO75huhRNk06VDwM41gzmYVHtN/83kITJBVqMbr7YclCPrIdzQsgC3SMu5jwJWFMxI3wrOfcOMhlEb8CufFcD4HOEc7D+c4kO187c+PATuTCoPjXHvPoipi+7ysSBLrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LbpXGuXH; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RLKngZJHQpUdyJR5CjVI1+0RCYiuk8UgdVpG4nXdkOY=; b=LbpXGuXH687JoPRdMp4xwLnwfC
	meo+Tux23veztcRY9kdujxM89bVOsEXonCM2esIngwguzWaxnA80NS06eRdke1HY3sldmHJ8zyHY6
	P8HLpIVpk16X8FWYsmZrG4Udtz3ElpprGgQEO+wTDFX1ij+x3GIJ3gxA+7ZQR6oqjUtSX8223KuVB
	NaCfKUYmTAY9bnATuzXfpnYPYn7rnCqPbF40N/4Fi+bwYGHGbI18ZKCtuMVbuJSVFREMR5rtC/sgJ
	BeeSEW5pwmcAi4K69VgFBehXiyENTx0ERtVspSG82JltcO6FXFP657gFmnL6HHrWW/K6siw4tTwLF
	qyCcAWtQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1O2c-0009tw-Up; Mon, 29 Apr 2024 12:15:22 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1O2b-000Dc9-2r;
	Mon, 29 Apr 2024 12:15:22 +0200
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>,
 "maze@google.com" <maze@google.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
 <Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "yan@cloudflare.com" <yan@cloudflare.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
 <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
 <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
 <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
 <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
 <662cfd6db06df_28b9852949a@willemb.c.googlers.com.notmuch>
 <afa6e302244a87c2a834fcc31d48b377e19a34a2.camel@mediatek.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5cc1c662-1cec-101c-8184-c32c210eeadc@iogearbox.net>
Date: Mon, 29 Apr 2024 12:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <afa6e302244a87c2a834fcc31d48b377e19a34a2.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27260/Mon Apr 29 10:23:47 2024)

On 4/28/24 9:48 AM, Lena Wang (王娜) wrote:
> On Sat, 2024-04-27 at 09:28 -0400, Willem de Bruijn wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   
>> Daniel Borkmann wrote:
>>> On 4/26/24 11:52 AM, Lena Wang (王娜) wrote:
>>> [...]
>>>>>>   From 301da5c9d65652bac6091d4cd64b751b3338f8bb Mon Sep 17
>> 00:00:00
>>>>> 2001
>>>>>> From: Shiming Cheng <shiming.cheng@mediatek.com>
>>>>>> Date: Wed, 24 Apr 2024 13:42:35 +0800
>>>>>> Subject: [PATCH net] net: prevent BPF pulling SKB_GSO_FRAGLIST
>> skb
>>>>>>
>>>>>> A SKB_GSO_FRAGLIST skb can't be pulled data
>>>>>> from its fraglist as it may result an invalid
>>>>>> segmentation or kernel exception.
>>>>>>
>>>>>> For such structured skb we limit the BPF pulling
>>>>>> data length smaller than skb_headlen() and return
>>>>>> error if exceeding.
>>>>>>
>>>>>> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
>>>>>> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>>>>>> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
>>>>>> ---
>>>>>>    net/core/filter.c | 5 +++++
>>>>>>    1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>>> index 8adf95765cdd..8ed4d5d87167 100644
>>>>>> --- a/net/core/filter.c
>>>>>> +++ b/net/core/filter.c
>>>>>> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct
>> bpf_scratchpad,
>>>>>> bpf_sp);
>>>>>>    static inline int __bpf_try_make_writable(struct sk_buff
>> *skb,
>>>>>>      unsigned int write_len)
>>>>>>    {
>>>>>> +if (skb_is_gso(skb) &&
>>>>>> +    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
>>>>>> +     write_len > skb_headlen(skb)) {
>>>>>> +return -ENOMEM;
>>>>>> +}
>>>>>>    return skb_ensure_writable(skb, write_len);
>>>
>>> Dumb question, but should this guard be more generically part of
>> skb_ensure_writable()
>>> internals, presumably that would be inside pskb_may_pull_reason(),
>> or only if we ever
>>> see more code instances similar to this?
>>
>> Good point. Most callers of skb_ensure_writable correctly pull only
>> headers, so wouldn't cause this problem. But it also adds coverage to
>> things like tc pedit.
> 
> Updated:
> 
>  From 3be30b8cf6e629f2615ef4eafe3b2a1c0d68c530 Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Sun, 28 Apr 2024 15:03:12 +0800
> Subject: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
> 
> BPF or TC callers may pull in a length longer than skb_headlen()
> for a SKB_GSO_FRAGLIST skb. The data in fraglist will be pulled
> into the linear space. However it destroys the skb's structure
> and may result in an invalid segmentation or kernel exception.
> 
> So we should add protection to stop the operation and return
> error to remind callers.
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>   include/linux/skbuff.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 9d24aec064e8..3eef65b3db24 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2740,6 +2740,12 @@ pskb_may_pull_reason(struct sk_buff *skb,
> unsigned int len)
>   	if (unlikely(len > skb->len))
>   		return SKB_DROP_REASON_PKT_TOO_SMALL;
>   
> +	if (skb_is_gso(skb) &&
> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> +	     write_len > skb_headlen(skb)) {
> +		return SKB_DROP_REASON_NOMEM;
> +	}

The 'write_len > skb_headlen(skb)' test is redundant, no ?

It is covered by the earlier test :

         if (likely(len <= skb_headlen(skb)))
                 return SKB_NOT_DROPPED_YET;

Also, was this patch even compile tested since there is no write_len var ?

>   	if (unlikely(!__pskb_pull_tail(skb, len - skb_headlen(skb))))
>   		return SKB_DROP_REASON_NOMEM;
>   
> 


