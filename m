Return-Path: <bpf+bounces-63039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3747B019CF
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A675660B5
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6E283FDE;
	Fri, 11 Jul 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C2kXUbXh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dxNK0uir";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UczSr4Yj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9YDhenHE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F128313F
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229825; cv=none; b=gID2yYXtR8saDjtMSqPXmIodMdA/S5gmzFA1FthyNlOuowVALeFuitU9m1fwzNokABe3eJa2BPIW69k+HC22H/60m4AmVXS7dFz+Tlzuy0YtkuK4qrwD/39VP+uUTeJLDbUdlQqJGaQQZX1xbqsavcy/zfujXJRjRLpj2pUhwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229825; c=relaxed/simple;
	bh=/HFWjNiS22IwQbcoxsigfhzOXygvpprldfGcfDW/x+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2uHE6OfLj6om6M1sQ9SAp2PHTOEMeuuHY01DdUa9R5Ud+WaQGkB+gJYzzJY67gu4bgmyhdAE4xlAEc9HC1acfVC+dlyvsXBowvBNAt1AtTp1HRo6Zr8G4OjnbtA60ldAoUuciRQI5BOYwekg5IHWUsxUqado8qgQBs2gI9vnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C2kXUbXh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dxNK0uir; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UczSr4Yj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9YDhenHE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16F1121134;
	Fri, 11 Jul 2025 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752229822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XQUC9OVOv2qOIqch+zqVEKkeARwMtVSBf+YU+zk8A5M=;
	b=C2kXUbXh2dLW49DX1a+a0l/N6y5kyZlbl/+k+l7F4KqzVxgJhVlcJqB5ckN7oeUktdgOL9
	QE44n9gYuhQr3EuR6QYaESl8latFDuZbGrW+625VXkumc4eeH4ZwV/1NEmr3hy/+1Xg9TG
	zX9DE1BLh9ggXie5Tp6+9vendBwK2N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752229822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XQUC9OVOv2qOIqch+zqVEKkeARwMtVSBf+YU+zk8A5M=;
	b=dxNK0uirsT15sLkOgCcqF1J1gh8GFfUA4Gc5+wkueVhtSdqKOT4t1fmNsXnKcbeS6Erqqv
	j/iroaG5mYKl/sCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UczSr4Yj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9YDhenHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752229820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XQUC9OVOv2qOIqch+zqVEKkeARwMtVSBf+YU+zk8A5M=;
	b=UczSr4YjhlqhVvB7GMsdle7VLN/C7Ags8EyKU3xo5cOizpDnT7v5C6rQoW2wL4GlXmR+ot
	IGCxAfRHe8TOS3ulQ59wIjmCxLOy+kY7C9JZ1/YyKr5Myhj7cWiv0JWXrC/NHt0GIlXEHd
	qe6zXm8G8+R9K5iMia/OM6ezNCsZhOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752229820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XQUC9OVOv2qOIqch+zqVEKkeARwMtVSBf+YU+zk8A5M=;
	b=9YDhenHEapPapsEkGZgEuq9C4jccbgRnIukHgl/SaBfyNavE6s3ug9DmSRt/HDV9fGdmFN
	g6rRS6oprf5y6xBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE2DF138A5;
	Fri, 11 Jul 2025 10:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zO3OObvncGi4AQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Jul 2025 10:30:19 +0000
Message-ID: <59c621bf-17cd-40ac-af99-3c7cb6ecafc3@suse.cz>
Date: Fri, 11 Jul 2025 12:30:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
 <683189c3-934e-4398-b970-34584ac70a69@suse.cz> <aG-UMkt-AQpu8mKq@hyeyoo>
 <e9bab147-5b36-4f9a-85b0-64740b84e826@suse.cz>
 <CAADnVQ+G340va8h2B7nNO00mWxbP_chx3oHW2PYrKt2AfOZS8w@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQ+G340va8h2B7nNO00mWxbP_chx3oHW2PYrKt2AfOZS8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 16F1121134
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,kvack.org,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -3.01

On 7/10/25 21:13, Alexei Starovoitov wrote:
> On Thu, Jul 10, 2025 at 8:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 7/10/25 12:21, Harry Yoo wrote:
>> > On Thu, Jul 10, 2025 at 11:36:02AM +0200, Vlastimil Babka wrote:
>> >> On 7/9/25 03:53, Alexei Starovoitov wrote:
>> >>
>> >> Hm but this is leaking the slab we allocated and have in the "slab"
>> >> variable, we need to free it back in that case.
> 
> ohh. sorry for the silly mistake.
> Re-reading the diff again I realized that I made a similar mistake in
> alloc_single_from_new_slab().
> It has this bit:
> if (!alloc_debug_processing(...))
>   return NULL;
> 
> so I assumed that doing:
> if (!spin_trylock_irqsave(&n->list_lock,..))
>    return NULL;
> 
> is ok too. Now I see that !alloc_debug is purposefully leaking memory.
> 
> Should we add:
> @@ -2841,6 +2841,7 @@ static void *alloc_single_from_new_slab(struct
> kmem_cache *s, struct slab *slab,
>                  * It's not really expected that this would fail on a
>                  * freshly allocated slab, but a concurrent memory
>                  * corruption in theory could cause that.
> +                * Leak newly allocated slab.
>                  */
>                 return NULL;
> 
> so the next person doesn't make the same mistake?

Sure, thanks.

>> So... since we succeeded taking it from the list and thus the spin_trylock,
>> it means it's safe to spinlock n->list_lock again - we might be waiting on
>> other cpu to unlock it but we know we didn't NMI on our own cpu having the
>> lock, right? But we'd probably need to convince lockdep about this somehow,
>> and also remember if we allocated a new slab or taken on from the partial
>> list... or just deal with this unlikely situation in another irq work :/
> 
> irq_work might be the least mind bending.
> Good point about partial vs new slab.
> For partial we can indeed proceed with deactivate_slab() and if
> I'm reading the code correctly, it won't have new.inuse == 0,

Hm I think due to other cpus freeing objects concurrently it might end up
with 0.

> so it won't go to discard_slab() (which won't be safe in this path)
> But teaching lockdep that below bit in deactivate_slab() is safe:
>         } else if (new.freelist) {
>                 spin_lock_irqsave(&n->list_lock, flags);
>                 add_partial(n, slab, tail);
> is a challenge.
> 
> Since defer_free_work is there, I'm leaning to reuse it for
> deactive_slab too. It will process
> static DEFINE_PER_CPU(struct llist_head, defer_free_objects);
> and
> static DEFINE_PER_CPU(struct llist_head, defer_deactivate_slabs);

Should work. Also deactivate_slab() should be the correct operation for both
a slab from partial list and a newly allocated one.
But oops, where do we store all the parameters for deactivate_slab() We can
probably reuse the union with "struct list_head slab_list" for queueing.
kmem_cache pointer can be simply taken from struct slab, it's already tehre.
But the separate flush_freelist pointer? Maybe take advantage of list_head
being two pointers and struct llist_node just one pointer, so what we need
will still fit?

Otherwise we could do the first two phases of deactivate_slab() immediately
and only defer the third phase where the freelists are already merged and
there's no freelist pointer to handle anymore. But if it's not necessary,
let's not complicate.

Also should kmem_cache_destroy() path now get a barrier to flush all pending
irq_work? Does it exist?

> Shouldn't be too ugly. Better ideas?


