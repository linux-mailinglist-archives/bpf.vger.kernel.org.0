Return-Path: <bpf+bounces-75147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A680FC73043
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FE4C349E15
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C6730F95C;
	Thu, 20 Nov 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y5h8XcZe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQ2Eblao";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y5h8XcZe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQ2Eblao"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CA137923
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629580; cv=none; b=IVSWGalVpblBI493Y324OBKnMBDKq4lKQmPqStSyfFhDFDMa+wkw4YpC6QTyhVrsmH5nECBpvsznQiyPCWKSWV9YsA/Ugxz7+WSg4pwYZYeNkVresNxI7doEeZzD2dmy2sQUiYgGg4EzoVV1Eur6bKMBBvgMhR02SPzGLphPc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629580; c=relaxed/simple;
	bh=nm6n88nu7OQYVsavht02juxlJNgRwSin/OowD8jsfho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQGnQEkvA9T0My2vxcTA4UnLx4w7uEZaSkWKY8wWjxH+7++t4J4UW0G+e0ddFo6OI9Pfn0XT1xXDISfxG76XxInNfcVaSHNbEVSqI1BTJJqjgiwO8cQtIuX9Wk2kErmjd0PZC6W9sBQyNlweXVYnLOda3WpunZVANdJLPQAsYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y5h8XcZe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQ2Eblao; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y5h8XcZe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQ2Eblao; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A56F420948;
	Thu, 20 Nov 2025 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763629576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnMACFI+lNtydjer9xn7VvtdapGzf7zyfntGkIc5Wd8=;
	b=y5h8XcZejthatntG3rr82Ggs4jiPogJJQ+gxQceaQG/FZjYN5h/8FCeQvoI7cqgykbMYLA
	qaw+CjpZ9e8P9HmNE/4+zDFeryM1xbpZwlzblguz1FAMYT/4rtG1AzVLkGcNi8o5BGt36i
	GskLs/JaTXC1rPfIWJi9ipDg7sL0ZLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763629576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnMACFI+lNtydjer9xn7VvtdapGzf7zyfntGkIc5Wd8=;
	b=uQ2Eblao7KJkQ7rE1nQXCo0XycYpufA/tDAB+Q2kUQe4S6datsXuV3a2SkOthdy+dcERmC
	atrDMEmuJ4gtG8CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y5h8XcZe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uQ2Eblao
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763629576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnMACFI+lNtydjer9xn7VvtdapGzf7zyfntGkIc5Wd8=;
	b=y5h8XcZejthatntG3rr82Ggs4jiPogJJQ+gxQceaQG/FZjYN5h/8FCeQvoI7cqgykbMYLA
	qaw+CjpZ9e8P9HmNE/4+zDFeryM1xbpZwlzblguz1FAMYT/4rtG1AzVLkGcNi8o5BGt36i
	GskLs/JaTXC1rPfIWJi9ipDg7sL0ZLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763629576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnMACFI+lNtydjer9xn7VvtdapGzf7zyfntGkIc5Wd8=;
	b=uQ2Eblao7KJkQ7rE1nQXCo0XycYpufA/tDAB+Q2kUQe4S6datsXuV3a2SkOthdy+dcERmC
	atrDMEmuJ4gtG8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E2433EA61;
	Thu, 20 Nov 2025 09:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2oO3AwjaHmkZCwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 20 Nov 2025 09:06:16 +0000
Message-ID: <c7fb0c73-12e9-4a6d-94d9-65f7fc9514ce@suse.de>
Date: Thu, 20 Nov 2025 10:06:01 +0100
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
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAL+tcoCthXqJS=z3-HhMSn3nfGzrqt8co3jKru-=YX0iJ2Yd6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A56F420948
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 



On 11/20/25 4:07 AM, Jason Xing wrote:
> On Tue, Nov 18, 2025 at 8:48 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
[...]>> @@ -828,11 +840,20 @@ static struct sk_buff 
*xsk_build_skb(struct xdp_sock *xs,
>>                                  goto free_err;
>>                          }
>>
>> -                       xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
>> -                       if (!xsk_addr) {
>> -                               __free_page(page);
>> -                               err = -ENOMEM;
>> -                               goto free_err;
>> +                       if (xsk_skb_destructor_is_addr(skb)) {
>> +                               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
>> +                                                            GFP_KERNEL);
>> +                               if (!xsk_addr) {
>> +                                       __free_page(page);
>> +                                       err = -ENOMEM;
>> +                                       goto free_err;
>> +                               }
>> +
>> +                               xsk_addr->num_descs = 1;
>> +                               xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
>> +                               skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
>> +                       } else {
>> +                               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>>                          }
>>
>>                          vaddr = kmap_local_page(page);
>> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>                          skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>>                          refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>>
>> -                       xsk_addr->addr = desc->addr;
>> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
>> +                       xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>> +                       xsk_addr->num_descs++;
> 
> Wait, it's too late to increment it... Please find below.
> 
>>                  }
>>          }
>>
>> -       xsk_inc_num_desc(skb);
>> -



>>          return skb;
>>
>>   free_err:
>> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>
>>          if (err == -EOVERFLOW) {
>>                  /* Drop the packet */
>> -               xsk_inc_num_desc(xs->skb);
> 
> Why did you remove this line? The error can occur in the above hidden
> snippet[1] without IFF_TX_SKB_NO_LINEAR setting and then we will fail
> to increment it by one.
> 
>
That is a good catch. Let me fix this logic.. I missed that the 
-EOVERFLOW is returned in different moments for xsk_build_skb_zerocopy() 
and xsk_build_skb(). Keeping the increment logic as it was it is better.

> [1]: https://elixir.bootlin.com/linux/v6.18-rc6/source/net/xdp/xsk.c#L821
> 
> Thanks,
> Jason


