Return-Path: <bpf+bounces-75156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAFC739ED
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30BFA4EAC33
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33432ED46;
	Thu, 20 Nov 2025 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bNG6f+pU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VNUQjxHC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bNG6f+pU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VNUQjxHC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C7276038
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636658; cv=none; b=KZVlTodRf92MGsXo52bklTLcZ3qGZWtQVqKKP2pJy678wnp9Lm1AwucnDJXEBoeKDvYlshtMsAoy7kpHeDeHkguvjAKKffwa+A0wPLJDtCQIx/qYRJCkiff32GojboRRmdpRbbHAs4+xsqAsM8bF2ujnJ7wbBNFzmgqJRVuCl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636658; c=relaxed/simple;
	bh=k2QtaQ90/Dinwsv1EhV9eXrz94V7LsYgGtuuENetjPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI8IWAMXyr+09rFYyRZsrVN7K8xGBUnK3phZ6P3AO+pWFTrYohPA2uyrOCGHJL0qhK9fAj4McubfzzqZfiiYQPwCTsUOhXGg/FD/QX4A51T9WW+FBYf/hpZObcYDmX+jyNpw5UpmB/wqdwZ+8sQC0SPwXgZsDoNJNfxSSqeM108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bNG6f+pU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VNUQjxHC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bNG6f+pU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VNUQjxHC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F80F2128B;
	Thu, 20 Nov 2025 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763636653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdpcw5J8PTkdpBb4QrJuu7pSVbCsL0j3e4eeS9KOidQ=;
	b=bNG6f+pUwzo3722u9ZOy1+6SZ8PYmD/60a0e97m0c63Dizi0ohghBtopG5ZGYIuxtsYlxk
	8DVcZOkip2D7CbCqacRzpyCsl5DyEipjTHaKElDBdEImKJ8ZjelJKCu07ZSCQ7avPOty7c
	Y1luOvz7953I2Nn7Vkf1xOSCD7wOclM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763636653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdpcw5J8PTkdpBb4QrJuu7pSVbCsL0j3e4eeS9KOidQ=;
	b=VNUQjxHCBAUkiRKlQcRARUG8Kpzts8aFUxG2TYZTRORSwwo2ZR1X7G/94fW0MNz6b7rcde
	W7P1xdyXngOQplCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763636653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdpcw5J8PTkdpBb4QrJuu7pSVbCsL0j3e4eeS9KOidQ=;
	b=bNG6f+pUwzo3722u9ZOy1+6SZ8PYmD/60a0e97m0c63Dizi0ohghBtopG5ZGYIuxtsYlxk
	8DVcZOkip2D7CbCqacRzpyCsl5DyEipjTHaKElDBdEImKJ8ZjelJKCu07ZSCQ7avPOty7c
	Y1luOvz7953I2Nn7Vkf1xOSCD7wOclM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763636653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdpcw5J8PTkdpBb4QrJuu7pSVbCsL0j3e4eeS9KOidQ=;
	b=VNUQjxHCBAUkiRKlQcRARUG8Kpzts8aFUxG2TYZTRORSwwo2ZR1X7G/94fW0MNz6b7rcde
	W7P1xdyXngOQplCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E08393EA61;
	Thu, 20 Nov 2025 11:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /TG1M6z1HmlLfgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 20 Nov 2025 11:04:12 +0000
Message-ID: <0485e77a-1566-48e7-a33e-5651a8e4beb5@suse.de>
Date: Thu, 20 Nov 2025 12:04:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] xsk: avoid data corruption on cq descriptor number
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20251118124807.3229-1-fmancera@suse.de>
 <CAL+tcoCthXqJS=z3-HhMSn3nfGzrqt8co3jKru-=YX0iJ2Yd6w@mail.gmail.com>
 <c7fb0c73-12e9-4a6d-94d9-65f7fc9514ce@suse.de>
 <CAL+tcoC3ZkhV5d7rStShghVFdmGDx9pb13S4ZUqSo9KmrJesLg@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAL+tcoC3ZkhV5d7rStShghVFdmGDx9pb13S4ZUqSo9KmrJesLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30



On 11/20/25 11:56 AM, Jason Xing wrote:
> On Thu, Nov 20, 2025 at 5:06 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>>
>>
>> On 11/20/25 4:07 AM, Jason Xing wrote:
>>> On Tue, Nov 18, 2025 at 8:48 PM Fernando Fernandez Mancera
>>> <fmancera@suse.de> wrote:
>> [...]>> @@ -828,11 +840,20 @@ static struct sk_buff
>> *xsk_build_skb(struct xdp_sock *xs,
>>>>                                   goto free_err;
>>>>                           }
>>>>
>>>> -                       xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
>>>> -                       if (!xsk_addr) {
>>>> -                               __free_page(page);
>>>> -                               err = -ENOMEM;
>>>> -                               goto free_err;
>>>> +                       if (xsk_skb_destructor_is_addr(skb)) {
>>>> +                               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
>>>> +                                                            GFP_KERNEL);
>>>> +                               if (!xsk_addr) {
>>>> +                                       __free_page(page);
>>>> +                                       err = -ENOMEM;
>>>> +                                       goto free_err;
>>>> +                               }
>>>> +
>>>> +                               xsk_addr->num_descs = 1;
>>>> +                               xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
>>>> +                               skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
>>>> +                       } else {
>>>> +                               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>>>>                           }
>>>>
>>>>                           vaddr = kmap_local_page(page);
>>>> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>>>                           skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>>>>                           refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>>>>
>>>> -                       xsk_addr->addr = desc->addr;
>>>> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
>>>> +                       xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>>>> +                       xsk_addr->num_descs++;
>>>
>>> Wait, it's too late to increment it... Please find below.
>>>
>>>>                   }
>>>>           }
>>>>
>>>> -       xsk_inc_num_desc(skb);
>>>> -
>>
>>
>>
>>>>           return skb;
>>>>
>>>>    free_err:
>>>> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>>>
>>>>           if (err == -EOVERFLOW) {
>>>>                   /* Drop the packet */
>>>> -               xsk_inc_num_desc(xs->skb);
>>>
>>> Why did you remove this line? The error can occur in the above hidden
>>> snippet[1] without IFF_TX_SKB_NO_LINEAR setting and then we will fail
>>> to increment it by one.
>>>
>>>
>> That is a good catch. Let me fix this logic.. I missed that the
>> -EOVERFLOW is returned in different moments for xsk_build_skb_zerocopy()
>> and xsk_build_skb(). Keeping the increment logic as it was it is better.
> 
> Right. Thanks!
> 
> My new solution based on net-next with your patch is ready now :)
> 

Awesome, thanks!

I just sent out the v5.

@Maciej I dropped your ACK since I changed the code. Feel free to add it 
back and sorry for making you take it a look to it again.

> Thanks,
> Jason
> 


