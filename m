Return-Path: <bpf+bounces-28109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4678B5DCA
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145B51F21B9F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FEA82498;
	Mon, 29 Apr 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="L4T1hQZL"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896B7F487;
	Mon, 29 Apr 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404801; cv=none; b=iN6p4h1E/0n94MLYKfKal+LTdSuyLPMwyEeyEY6NdjDQMoZ54MWXdusMz+QFcwc1SYI0UKOmPX8nJffm+Uxn8CW+ks573yHF/hs8BsYKA8BQ99P3UGkZsWAQMFQCXZUx6yHcxKvmJoPDDCX9X/Z7VTSGAayFSiUEow8I4LoKzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404801; c=relaxed/simple;
	bh=5lUrzbRnav5ASy/K91woXmOubyfpP/gFyJtvSyPlnPI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c/3lmJXWgtmr4SbIZc2DdaUSAJe8nc6B79FqZuJ1XCJZWdNygNNuiqmdHLTORZGLgBpE4MWCNjOqmkph/lYcMWv2UAzQgR2Qm1SDhBxkJGEB9knZd47ef/DS8qwNId7/mu93TbFAeGhg6XwQs7qcXz0KDTX4DsnuhWpQJKCwhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=L4T1hQZL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7Klarb4qZOjJN4ysw7kPerEyVRGPC0HwcmCCWjik+kQ=; b=L4T1hQZLQ1rernFS2URgulJUpj
	WYuwM58IbdB7VaSzlhLb5dN+iTprtebgB/jktzM3TmoIkYdWc2hn5SeiVp/eTLWMSH8zHJ5Z0HlG/
	xlNj+sUHp8XYd2jkIVtFl3NOXEK+0WPtSLdhj6aGfKWbsTYqwTaDPgbOmDY2nhY/56S1GKzMEcyN9
	H6nSIdoTuP1Cn+QYG38dnhamZrpmDr8z6P2Lg/LKZwrqnhKQKo0S/8xOKthmtmG3xo+Z+dHZRc5LX
	Gpv7f0Lb3cXPeC9l0UIBL3uhq+Sa1BIVZun/k6PO6RGcJUKXXTXG2TUXky0Z3anH5bpt0AgozhvM8
	f6YW6I7g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1SfO-000N2m-02; Mon, 29 Apr 2024 17:11:42 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1SfN-004ZCo-06;
	Mon, 29 Apr 2024 17:11:41 +0200
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
 <5cc1c662-1cec-101c-8184-c32c210eeadc@iogearbox.net>
 <bd9d5fef2fa6154e162e963f5d669ff618b95229.camel@mediatek.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <880367ab-e9a2-d9b4-c6d6-9e2efdf04a0f@iogearbox.net>
Date: Mon, 29 Apr 2024 17:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bd9d5fef2fa6154e162e963f5d669ff618b95229.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27260/Mon Apr 29 10:23:47 2024)

On 4/29/24 1:45 PM, Lena Wang (王娜) wrote:
> On Mon, 2024-04-29 at 12:15 +0200, Daniel Borkmann wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   On 4/28/24 9:48 AM, Lena Wang (王娜) wrote:
>>> On Sat, 2024-04-27 at 09:28 -0400, Willem de Bruijn wrote:
>>>>    
>>>> External email : Please do not click links or open attachments
>> until
>>>> you have verified the sender or the content.
>>>>    
>>>> Daniel Borkmann wrote:
>>>>> On 4/26/24 11:52 AM, Lena Wang (王娜) wrote:
>>>>> [...]
>>>>>>>>    From 301da5c9d65652bac6091d4cd64b751b3338f8bb Mon Sep 17
>>>> 00:00:00
>>>>>>> 2001
>>>>>>>> From: Shiming Cheng <shiming.cheng@mediatek.com>
>>>>>>>> Date: Wed, 24 Apr 2024 13:42:35 +0800
>>>>>>>> Subject: [PATCH net] net: prevent BPF pulling SKB_GSO_FRAGLIST
>>>> skb
>>>>>>>>
>>>>>>>> A SKB_GSO_FRAGLIST skb can't be pulled data
>>>>>>>> from its fraglist as it may result an invalid
>>>>>>>> segmentation or kernel exception.
>>>>>>>>
>>>>>>>> For such structured skb we limit the BPF pulling
>>>>>>>> data length smaller than skb_headlen() and return
>>>>>>>> error if exceeding.
>>>>>>>>
>>>>>>>> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist
>> chaining.")
>>>>>>>> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>>>>>>>> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
>>>>>>>> ---
>>>>>>>>     net/core/filter.c | 5 +++++
>>>>>>>>     1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>>>>> index 8adf95765cdd..8ed4d5d87167 100644
>>>>>>>> --- a/net/core/filter.c
>>>>>>>> +++ b/net/core/filter.c
>>>>>>>> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct
>>>> bpf_scratchpad,
>>>>>>>> bpf_sp);
>>>>>>>>     static inline int __bpf_try_make_writable(struct sk_buff
>>>> *skb,
>>>>>>>>       unsigned int write_len)
>>>>>>>>     {
>>>>>>>> +if (skb_is_gso(skb) &&
>>>>>>>> +    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
>>>>>>>> +     write_len > skb_headlen(skb)) {
>>>>>>>> +return -ENOMEM;
>>>>>>>> +}
>>>>>>>>     return skb_ensure_writable(skb, write_len);
>>>>>
>>>>> Dumb question, but should this guard be more generically part of
>>>> skb_ensure_writable()
>>>>> internals, presumably that would be inside
>> pskb_may_pull_reason(),
>>>> or only if we ever
>>>>> see more code instances similar to this?
>>>>
>>>> Good point. Most callers of skb_ensure_writable correctly pull
>> only
>>>> headers, so wouldn't cause this problem. But it also adds coverage
>> to
>>>> things like tc pedit.
>>>
>>> Updated:
>>>
>>>   From 3be30b8cf6e629f2615ef4eafe3b2a1c0d68c530 Mon Sep 17 00:00:00
>> 2001
>>> From: Shiming Cheng <shiming.cheng@mediatek.com>
>>> Date: Sun, 28 Apr 2024 15:03:12 +0800
>>> Subject: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
>>>
>>> BPF or TC callers may pull in a length longer than skb_headlen()
>>> for a SKB_GSO_FRAGLIST skb. The data in fraglist will be pulled
>>> into the linear space. However it destroys the skb's structure
>>> and may result in an invalid segmentation or kernel exception.
>>>
>>> So we should add protection to stop the operation and return
>>> error to remind callers.
>>>
>>> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
>>> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>>> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
>>> ---
>>>    include/linux/skbuff.h | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index 9d24aec064e8..3eef65b3db24 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -2740,6 +2740,12 @@ pskb_may_pull_reason(struct sk_buff *skb,
>>> unsigned int len)
>>>    if (unlikely(len > skb->len))
>>>    return SKB_DROP_REASON_PKT_TOO_SMALL;
>>>    
>>> +if (skb_is_gso(skb) &&
>>> +    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
>>> +     write_len > skb_headlen(skb)) {
>>> +return SKB_DROP_REASON_NOMEM;
>>> +}
>>
>> The 'write_len > skb_headlen(skb)' test is redundant, no ?
>>
>> It is covered by the earlier test :
>>
>>           if (likely(len <= skb_headlen(skb)))
>>                   return SKB_NOT_DROPPED_YET;
>>
> Daniel, it is not redundant. The bpf pulls a len between
> skb_headlen(skb) and skb->len that results in error. Here it will stop
> this operation. For other skbs(not SKB_GSO_FRAGLIST) it could be a
> normal behaviour and will continue to do next pulling.

I meant something like the below. The len <= skb_headlen(skb) case you
already return earlier with SKB_NOT_DROPPED_YET. Willem, do you see a
case where this should not live in pskb_may_pull_reason() but rather
specifically in skb_ensure_writable()?

Thanks,
Daniel

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 517e546a120a..ef2a0328ff2b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1687,6 +1687,11 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
  /* Internal */
  #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))

+static inline bool skb_is_gso(const struct sk_buff *skb)
+{
+	return skb_shinfo(skb)->gso_size;
+}
+
  static inline struct skb_shared_hwtstamps *skb_hwtstamps(struct sk_buff *skb)
  {
  	return &skb_shinfo(skb)->hwtstamps;
@@ -2740,6 +2745,10 @@ pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
  	if (unlikely(len > skb->len))
  		return SKB_DROP_REASON_PKT_TOO_SMALL;

+	if (unlikely(skb_is_gso(skb) &&
+		     (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
+		return SKB_DROP_REASON_FRAGLIST_PULL;
+
  	if (unlikely(!__pskb_pull_tail(skb, len - skb_headlen(skb))))
  		return SKB_DROP_REASON_NOMEM;

@@ -4953,11 +4962,6 @@ static inline struct sec_path *skb_sec_path(const struct sk_buff *skb)
  #endif
  }

-static inline bool skb_is_gso(const struct sk_buff *skb)
-{
-	return skb_shinfo(skb)->gso_size;
-}
-
  /* Note: Should be called only if skb_is_gso(skb) is true */
  static inline bool skb_is_gso_v6(const struct sk_buff *skb)
  {
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 9707ab54fdd5..9d6c97a6b2b6 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -418,6 +418,12 @@ enum skb_drop_reason {
  	 * iterations.
  	 */
  	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
+	/**
+	 * @SKB_DROP_REASON_FRAGLIST_PULL: attempting to pull GSO fraglist
+	 * which destroys the skb's structure and may then result in an
+	 * invalid segmentation or kernel exception.
+	 */
+	SKB_DROP_REASON_FRAGLIST_PULL,
  	/**
  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
  	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.21.0

