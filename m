Return-Path: <bpf+bounces-68688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44139B815A7
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAB67B15A6
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9707134BA3C;
	Wed, 17 Sep 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="np3j22qn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYucnUGm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OP6eUHOO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+oWY1LXJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D301FBC91
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134098; cv=none; b=e87OS2sXEWNDorVr5v96dfnmPzAcLwAiGMwKr7aXdaaQhjGME9s2CkwUsguAt8neOweQnrjFANmRdd3D9qUciV3TQgpI7rh7YJBNhrBrerYYcaYpXx5xIoTk2002HoluC4fTQMh4wxzzKoVZIrrPxJVJoG1TYZH0ae7lM4/HhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134098; c=relaxed/simple;
	bh=TiKwTJP7HBiwh4DlC6Cd5P5OcAG3TZX9eliJWSFnvVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZX0OUg67s1wN8daZyjPWBwLZcPhcFPek67dhkRJTo+GubfkGa58IcozFBSkCOQ8V2l7HFG/jYbjtV/2VOSrqDGXP5YNciqHRzByMyWEFjl2U0rzW9UsB5HB4OnFf4B35pX44Ifw9LAxk7qAlkEA2BWhqOXpWAfCA1ahLrGbUOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=np3j22qn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYucnUGm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OP6eUHOO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+oWY1LXJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0F0B5C1CF;
	Wed, 17 Sep 2025 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758134094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFd0G/O72YBJmES7d/dg7RCjBoxZlZ6kvr9UYudRK8E=;
	b=np3j22qn6jEGMJDRyxRTwMfixe33NGTySi4oZ6P9g0GbJrezcKAeaNTD4EgTCJjNlllHbQ
	RtMBdOhU0kOi2mej50/k63WJCVnjWGzHVv6CjLJC+N2zM78LTnl0bnXqOkrijOFmUgck+q
	W69gaE0N5uLXRG9LEsfYfLdjq3oMPTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758134094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFd0G/O72YBJmES7d/dg7RCjBoxZlZ6kvr9UYudRK8E=;
	b=OYucnUGmtgz+O0+jlMmY4Tio3M9VgmZaeCxE5WRwrNSUaZ70zBdVaRS1NTummnnsn1tAFa
	u8R6g1FN7dvhn1BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758134093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFd0G/O72YBJmES7d/dg7RCjBoxZlZ6kvr9UYudRK8E=;
	b=OP6eUHOOsX8YumGFnLmUrUBlv3Z7I5heJsFelRn15Ji+9F2nMG+VIoFPdubm3r2NTeoMs4
	42YDU5+mKw+q+989EZihHpNZXVYlJR4nUorgzvY0F2qXZ8XFC80iCMGb0BQFKijyew4ygy
	R03lvJSD9dFoHrd0qFOW/qhnDhjB+C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758134093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFd0G/O72YBJmES7d/dg7RCjBoxZlZ6kvr9UYudRK8E=;
	b=+oWY1LXJdHjev80VASE9kW340mALsx8oj3jtWoky35wDBJT4i20ZzIFLsFg8iKs3WxQJPT
	CCXIn8+AiUYe67Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E6BD1368D;
	Wed, 17 Sep 2025 18:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOByHU3/ymgPVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Sep 2025 18:34:53 +0000
Message-ID: <ade5442f-6257-498f-bffd-5fc4b1d5858f@suse.cz>
Date: Wed, 17 Sep 2025 20:34:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz> <aMlZ8Au2MBikJgta@hyeyoo>
 <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz>
 <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
 <0beac436-1905-4542-aebe-92074aaea54f@suse.cz>
 <CAADnVQJbj3OqS9x6MOmnmHa=69ACVEKa=QX-KVAncyocjCn1AQ@mail.gmail.com>
 <c370486e-cb8f-4201-b70e-2bdddab9e642@suse.cz>
 <CAADnVQL6xGz8=NTDs=3wPfaEqxUjfQE98h5Q2ex-iyRs4yemiw@mail.gmail.com>
 <aMpdAVKZBLltOElH@hyeyoo> <aMpeADsz1Znaz8AU@hyeyoo>
 <CAADnVQ+sKKV+-Ee61Bxma+=MN4unGLRypAnfqHuLOtHM6T=HEA@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQ+sKKV+-Ee61Bxma+=MN4unGLRypAnfqHuLOtHM6T=HEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 9/17/25 20:26, Alexei Starovoitov wrote:
> On Wed, Sep 17, 2025 at 12:06 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>>
>> On Wed, Sep 17, 2025 at 04:02:25PM +0900, Harry Yoo wrote:
>> > On Tue, Sep 16, 2025 at 01:26:53PM -0700, Alexei Starovoitov wrote:
>> > > On Tue, Sep 16, 2025 at 12:06 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> > > > > It's ok to call __update_cpu_freelist_fast(). It won't break anything.
>> > > > > Because only nmi can make this cpu to be in the middle of freelist update.
>> > > >
>> > > > You're right, freeing uses the "slowpath" (local_lock protected instead of
>> > > > cmpxchg16b) c->freelist manipulation only on RT. So we can't preempt it with
>> > > > a kprobe on !RT because it doesn't exist there at all.
>> >
>> > Right.
>> >
>> > > > The only one is in ___slab_alloc() and that's covered.
>> >
>> > Right.
>> >
>> > and this is a question not relevant to reentrant kmalloc:
>> >
>> > On PREEMPT_RT, disabling fastpath in the alloc path makes sense because
>> > both paths updates c->freelist, but in the free path, by disabling the
>> > lockless fastpath, what are we protecting against?
>> >
>> > the free fastpath updates c->freelist but not slab->freelist, and
>> > the free slowpath updates slab->freelist but not c->freelist?
>> >
>> > I failed to imagine how things can go wrong if we enable the lockless
>> > fastpath in the free path.
>>
>> Oops, sorry. it slipped my mind. Things can go wrong if the free fastpath
>> is executed while the alloc slowpath is executing and gets preempted.
> 
> Agree. All that is very tricky. Probably worth adding a comment.

Ah right, I did add one based on your commit log and this conversation:

+/*
+ * We disallow kprobes in ___slab_alloc() to prevent reentrance
+ *
+ * kmalloc() -> ___slab_alloc() -> local_lock_cpu_slab() protected part of
+ * ___slab_alloc() manipulating c->freelist -> kprobe -> bpf ->
+ * kmalloc_nolock() or kfree_nolock() -> __update_cpu_freelist_fast()
+ * manipulating c->freelist without lock.
+ *
+ * This does not prevent kprobe in functions called from ___slab_alloc() such as
+ * local_lock_irqsave() itself, and that is fine, we only need to protect the
+ * c->freelist manipulation in ___slab_alloc() itself.
+ */
+NOKPROBE_SYMBOL(___slab_alloc);

> Long term though I think RT folks needs to reconsider the lack of
> fastpath. My gut feel is that overall kernel performance is poor on RT
> due to this. sheaves might help though.

Oh they definitely should, thanks for the selling point :)

