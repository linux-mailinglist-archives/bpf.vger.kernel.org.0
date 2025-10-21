Return-Path: <bpf+bounces-71612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C7BF80A6
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886BB427D8D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F92351FA2;
	Tue, 21 Oct 2025 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VEtJkEw4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BLaUuuH/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sm1typx3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gvkiQ3mn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626234E760
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071123; cv=none; b=WkltPCZXpZyE4zq7Lzlku8e9rnVIURd0uAVHyMJZqIWzzGLl7nZos531S7+IEyB0ZMEJe1H4Vjs/K6qaVuBV/ZtWeCwWnFEcb2NlTI3pusuUwi31NgYTwdSRbE4xx1qpwYydt5nDNkz2yVx2RY+3Nhu2YxWgPXR8GENU4IOiBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071123; c=relaxed/simple;
	bh=qzOZ0xEqZr41ShEs0F75G1i6qz3j4pAqSl1NS/UW7Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5qftOiIWX1zD1nJ4GUyx4rcNnXm2ROXlkS/66KWrJSopPe1bwI/oVVaphmQAGBBRrYzpXO2LHimK9Hf4v/+1S9KWlg8IiVlh2Ka9OE+yJ/3kuBL3IAxi2OpU43d8u0eiBUtacQZ+JQPw+kyr0WiOfXBYqRXaCz/+LR6hzwsE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VEtJkEw4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BLaUuuH/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sm1typx3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gvkiQ3mn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BF112119B;
	Tue, 21 Oct 2025 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761071115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5laJCGigRWB3O63qPhWFyh2ZtIa70D/0VNdf/PQZCLE=;
	b=VEtJkEw4fYSBpnsoyzArsjKKrZXg2wKiQHgEWCtYA0fgltI1UKmKotqCrJLN4qKVdkHoCS
	sdmKRP1taD+cfj33BIaMbqgCW4ClfxeFifpchfz47BBZFTBMnOwunLoc5Azjw8h23M9QOA
	TfXtVafPBSvrdmFUvhokJ+tirjDxtpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761071115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5laJCGigRWB3O63qPhWFyh2ZtIa70D/0VNdf/PQZCLE=;
	b=BLaUuuH/ykbf/g2Sx+hH9yD0qA0muG4QfS/ZT7eDqDDrtg5bJwhyeuPjDNmvRz4iDLae8b
	zgFRA4/78kEAbjDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Sm1typx3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gvkiQ3mn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761071111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5laJCGigRWB3O63qPhWFyh2ZtIa70D/0VNdf/PQZCLE=;
	b=Sm1typx36jZYYu/VF0cV91k9XmuEDrN55KaCQRk/20uYBs4A4akOa/E2nv31MslmVrg3ke
	HODuoRlsUyiJKoVecMwhrlS7lEcjlm553/xArl7rcYQ71h+ewbKFCpe4nlfCd4qirxrMS1
	HiW2F1gVSYN+VsCwAFOHVDUHav6gJto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761071111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5laJCGigRWB3O63qPhWFyh2ZtIa70D/0VNdf/PQZCLE=;
	b=gvkiQ3mnOf3Z9AwKEbqGWIr9M+pKnZFrEBjAQioUmDvyQq7B8/OauagrWbeFp1v6slmzkW
	7nBijquPcS+wwfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E36139B1;
	Tue, 21 Oct 2025 18:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bx0JKgbQ92gAUAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Oct 2025 18:25:10 +0000
Message-ID: <32086239-2fd5-42bd-a554-d0e3c263bb0c@suse.de>
Date: Tue, 21 Oct 2025 20:25:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: avoid data corruption on cq descriptor number
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, csmate@nop.hu, kerneljasonxing@gmail.com,
 maciej.fijalkowski@intel.com, bjorn@kernel.org, sdf@fomichev.me,
 jonathan.lemon@gmail.com, bpf@vger.kernel.org
References: <20251021150656.6704-1-fmancera@suse.de>
 <aPez6DYh13kmY9NF@horms.kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aPez6DYh13kmY9NF@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3BF112119B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.98 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.17)[-0.867];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,nop.hu,gmail.com,intel.com,kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.98
X-Spam-Level: 



On 10/21/25 6:25 PM, Simon Horman wrote:
> On Tue, Oct 21, 2025 at 05:06:56PM +0200, Fernando Fernandez Mancera wrote:
> 
> ...
> 
>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> 
> ...
> 
>> @@ -774,6 +777,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>   {
>>   	struct net_device *dev = xs->dev;
>>   	struct sk_buff *skb = xs->skb;
>> +	struct page *page;
>>   	int err;
>>   
>>   	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
>> @@ -791,6 +795,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>   		len = desc->len;
>>   
>>   		if (!skb) {
>> +			struct xsk_addr_node *head_addr;
>> +
>>   			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
>>   			tr = dev->needed_tailroom;
>>   			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
>> @@ -804,7 +810,13 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>   			if (unlikely(err))
>>   				goto free_err;
>>   
>> -			xsk_skb_init_misc(skb, xs, desc->addr);
>> +			head_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
>> +			if (!head_addr) {
>> +				__free_page(page);
> 
> Hi Fernando,
> 
> Perhaps the page changes to xsk_build_skb() aren't needed
> because page seems to be uninitialised here.
> 
> Flagged by W=1 builds with Clang 21.1.1, and Smatch.
> 

Ah, I don't know know what I was thinking about.. but yes, that page 
handling isn't needed of course as it isn't initialized. (I even needed 
the page struct because it wasn't available in that context).

I will send a V2 patch if the proposed solution is accepted. In additon, 
the performance impact isn't as bad as I thought.. just 4 bytes pero 
skb.. as the cache must be initialized anyway.

>> +				err = -ENOMEM;
>> +				goto free_err;
>> +			}
>> +			xsk_skb_init_misc(skb, xs, head_addr, desc->addr);
>>   			if (desc->options & XDP_TX_METADATA) {
>>   				err = xsk_skb_metadata(skb, buffer, desc,
>>   						       xs->pool, hr);
>> @@ -814,7 +826,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>   		} else {
>>   			int nr_frags = skb_shinfo(skb)->nr_frags;
>>   			struct xsk_addr_node *xsk_addr;
>> -			struct page *page;
>>   			u8 *vaddr;
>>   
>>   			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
>> @@ -843,7 +854,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>   			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>>   
>>   			xsk_addr->addr = desc->addr;
>> -			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
>> +			list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
>>   		}
>>   	}
>>   
>> -- 
>> 2.51.0
>>
>>


