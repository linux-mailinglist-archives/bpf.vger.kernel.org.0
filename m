Return-Path: <bpf+bounces-75367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C2C81B9A
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645163ABC5E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31E31B80D;
	Mon, 24 Nov 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lekINEIZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WOcjonkZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lekINEIZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WOcjonkZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256131B11D
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003130; cv=none; b=dQ6coy6RqQq3/ESdv/UT0ABFADLVGxWwrZD2db9WsZGK1e3iIp5AqHRKjmP4ORo0jpoEX3AM91AEfgidsGtvxFwwPBI4jsXK6KYyccWOM2LLlq5IEu+tyCrHPE/zFLzkaQq/BAZtMJWhzmnTeLnzL0YVjTlm4h4C46q77Fr9ZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003130; c=relaxed/simple;
	bh=wEhBJ4C3ToukGjoul5gAhGOo/fI1wPd2RutxAt5bS2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyCf9oEGrvZmTtwauzFvmz4Mt/XyMmdZHGBMm66alQR6OS3ABtU7L74yjSsJEajTbIxCKDKEaag/CagvzoAwCBcAaXmBNdiJYHn5RJrzeiVNk5DPBQ935YgoMrkZeJfCv2dluYpv5BQe/7L/pY/+0ebcCZtY2vrOg5CpEbEymlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lekINEIZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WOcjonkZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lekINEIZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WOcjonkZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B03C6221A7;
	Mon, 24 Nov 2025 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcOXyxazT78hhLlrLF2lbx2AmsStAwnHlQ2S/Lu6VhI=;
	b=lekINEIZ7jQsMTHrFC4MHxf1et0J0gasniVJQaQwzRjREOhwZ99bxqpUCYwQW0TFLJszNX
	HRXZhS8RlYSiUrhk4N/bhw6+F8EpzcyYRgsy79aPks3INAiF8000qU4gIVtKH9TQ2d2CgS
	43CASA1wPzb7exjC2bHYDZYCHRoTn0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcOXyxazT78hhLlrLF2lbx2AmsStAwnHlQ2S/Lu6VhI=;
	b=WOcjonkZb55pEvknTL5QVYFtkWS9GToLeyTetQnH20x7xqwbuAcn4dpCcukMCpy1F0OPMI
	gMuJBqmx1bFsR1BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcOXyxazT78hhLlrLF2lbx2AmsStAwnHlQ2S/Lu6VhI=;
	b=lekINEIZ7jQsMTHrFC4MHxf1et0J0gasniVJQaQwzRjREOhwZ99bxqpUCYwQW0TFLJszNX
	HRXZhS8RlYSiUrhk4N/bhw6+F8EpzcyYRgsy79aPks3INAiF8000qU4gIVtKH9TQ2d2CgS
	43CASA1wPzb7exjC2bHYDZYCHRoTn0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcOXyxazT78hhLlrLF2lbx2AmsStAwnHlQ2S/Lu6VhI=;
	b=WOcjonkZb55pEvknTL5QVYFtkWS9GToLeyTetQnH20x7xqwbuAcn4dpCcukMCpy1F0OPMI
	gMuJBqmx1bFsR1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE8283EA63;
	Mon, 24 Nov 2025 16:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dWd3LzWNJGkEHAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 24 Nov 2025 16:52:05 +0000
Message-ID: <5b3e00fe-38c0-45a3-9d34-205472839454@suse.de>
Date: Mon, 24 Nov 2025 17:51:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] xsk: avoid data corruption on cq descriptor number
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, csmate@nop.hu, bpf@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, john.fastabend@gmail.com,
 magnus.karlsson@intel.com
References: <20251120110228.4288-1-fmancera@suse.de>
 <CAL+tcoDKxaOT7DiLg2=jQPLo+6OJqL7ZkDurXZAGXo-xbxoDWw@mail.gmail.com>
 <01a09fe7-9f58-4fc5-a84d-12d5b4b92bbd@suse.de>
 <CAL+tcoBueigrGnKASad7XFybXMHvj5jAOcZS8_bY3J-7XVZShQ@mail.gmail.com>
 <c68423d1-d4e6-4d13-973b-44a791a3c806@suse.de>
 <CAL+tcoAE6_15tOjZFrdif1ixBja3_qeUKL2GUvOyypcimLFJXw@mail.gmail.com>
 <aSSIbjlUGVaLUDKd@boxer>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aSSIbjlUGVaLUDKd@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nop.hu,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,iogearbox.net,gmail.com,intel.com];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80



On 11/24/25 5:31 PM, Maciej Fijalkowski wrote:
>[...]
>>>>>> nit: duplicate if statement
>>>>>>
>>>>>> IIUC, I'm afraid you have to repost this patch after 24 hour...
>>>>>>
>>>>>
>>>>> Thanks, yes this if statement isn't necessary. Thanks! I will repost
>>>>> after 24 hours.
> 
> Fernando, if you repost, maybe we could include a helper function for
> setting destructor arg?
> 
> static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> {
> 	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> }
> 
> when reading code it was sort of missing for me when seeing
> xsk_skb_destructor_{is,get}_addr().
> 

Sure, I am sending a v6 just now removing the if statement Jason 
suggested and adding this helper function. Thank you Maciej and Jason 
for the feedback.

