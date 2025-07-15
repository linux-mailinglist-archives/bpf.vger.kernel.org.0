Return-Path: <bpf+bounces-63299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37339B05244
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 08:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DDB188B74C
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5505266574;
	Tue, 15 Jul 2025 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ref9yqud";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqGZXpg0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AEJq6YjX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w1pesgHF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA7EC2
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562586; cv=none; b=OPkWl8VugEaVGbLsk2Xrb0GLIsHWzC5YeNBXile1lV+2aMNneqjiQElFOXj9oeMcS5sGDGchuYIz7/8GlgmmwelKKJR5mg2Xrih85knE9EX+6e9A5Oo0E9yF1Pi3XtSUK3bv0hPaBuhypbOda/W1sJxX0bm4gpdg92hLVXsSEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562586; c=relaxed/simple;
	bh=wcSWjDMfXgTZ0fY9mI7odMgwJzBYmzhLoEkBf/J6YGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhZs4ohruQiS5pBVOphQiK7eyeG9+kv8+gHYHiZZ4Llk1qWQgiOlFu+26L5dgjaGEJmFWC0KOf/vTwwFxn3tTNC1NI3C97zENRIFmAWTM/eR54LubeWEC8nav54BIk7DeRODwcBY3JxHuy0HSOLwsNetRNXRFUDiKtrPl8mCr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ref9yqud; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqGZXpg0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AEJq6YjX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w1pesgHF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC3D31F38F;
	Tue, 15 Jul 2025 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752562583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vwgF0009HE3d2upEk2DtDhS/X+bNR5k18tWzHRtz0BU=;
	b=Ref9yqudO/TmRocnHGdncUZ0Gj0K+c2hFVJmCK/yFsBPPlcDET5kDHsDFQ6m8uY1anM/zH
	ggbfgeMc4eyI5UmX7H99A0wIgCjpR9E6V6gzOBMu1PuRIjkKL+H68n/+1TpLDyQAQsDw/b
	TzL52dKMLcBaripfMv8UyrVVfuLDMlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752562583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vwgF0009HE3d2upEk2DtDhS/X+bNR5k18tWzHRtz0BU=;
	b=JqGZXpg0UAjIbYzyj79T94bQw7FohU9O+/kXazX/Xo2tsVcHtR1038aAWFpeY1Lf8C4x8S
	LUO1tJJkqpoaomCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AEJq6YjX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w1pesgHF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752562581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vwgF0009HE3d2upEk2DtDhS/X+bNR5k18tWzHRtz0BU=;
	b=AEJq6YjX5XQK6qrVC5DcRfrpRxdU1Ykuts3B2NFbi9S1Jq/03S2ddxy68rZqwU7xI7AvVh
	SqFb2dbZl1RywzeyN7QhXJ60GqoylcTixteh/Xl2mvtpPNwppcity80EnqpSPYdeN7ow3f
	GY0GcNLKqfaGx8lbul93AOQZ8lje4Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752562581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vwgF0009HE3d2upEk2DtDhS/X+bNR5k18tWzHRtz0BU=;
	b=w1pesgHFSMfP7U1izAJh5batH4u52/Wq/u/Bj0wL6a4EWCxJfLYg34pzh4w7X1LkgJkqtx
	5tgb8g/7pUJ6P7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8489613306;
	Tue, 15 Jul 2025 06:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mhi3H5X7dWjsNgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 15 Jul 2025 06:56:21 +0000
Message-ID: <6835614d-c316-4ecf-ae2b-52687a66ae7c@suse.cz>
Date: Tue, 15 Jul 2025 08:56:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
 <20250714110639.uOaKJEfL@linutronix.de>
 <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
 <d556c4fb-ddc2-4bf0-9510-5c682cd717f5@suse.cz>
 <CAADnVQK3B4ToOOuWOWQdvHO-1as3X2YMGkj45vYQ0Nxoe55Nsw@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQK3B4ToOOuWOWQdvHO-1as3X2YMGkj45vYQ0Nxoe55Nsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: AC3D31F38F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 7/14/25 20:46, Alexei Starovoitov wrote:
> On Mon, Jul 14, 2025 at 11:33 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> When in patch 6/6 __slab_alloc() we should have bailed out via
>>
>>         if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
>> +               if (local_lock_is_locked(&s->cpu_slab->lock)) {
>> +                       /*
>> +                        * EBUSY is an internal signal to kmalloc_nolock() to
>> +                        * retry a different bucket. It's not propagated
>> +                        * to the caller.
>> +                        */
>> +                       p = ERR_PTR(-EBUSY);
>> +                       goto out;
>> +               }
>>
>> So it doesn't seem to me as a lack of lockdep tricking, but we reached
>> something we should not have because the avoidance based on
>> local_lock_is_locked() above didn't work properly? At least if I read the
>> splat and backtrace properly, it doesn't seem to suggest a theoretical
>> scenario but that we really tried to lock something we already had locked.
> 
> It's not theoretical. Such slab re-entrance can happen with
> a tracepoint:
> slab -> some tracepoint -> bpf -> slab
> 
> I simulate it with a stress test:
> +extern void (*debug_callback)(void);
> +#define local_unlock_irqrestore(lock, flags)                   \
> +       do {                    \
> +               if (debug_callback) debug_callback(); \
> +               __local_unlock_irqrestore(lock, flags); \
> +       } while (0)
> 
> and debug_callback() calls kmalloc_nolock(random_size) without any bpf
> to simplify testing.
> 
>> > [   39.819857]  my_debug_callback+0x20e/0x390 [bpf_testmod]
>>
>> What exactly did you instrument here?
>>
>> > [   39.819867]  ? page_alloc_kthread+0x320/0x320 [bpf_testmod]
>> > [   39.819875]  ? lock_is_held_type+0x85/0xe0
>> > [   39.819881]  ___slab_alloc+0x256/0xec0
>>
>> And here we took the lock originally?
> 
> yes, but they are truly different local_locks of different
> kmalloc buckets, and local_lock_is_locked() is working.
> 
> See in the splat:
> 
>> > [   39.819646] page_alloc_kthr/2306 is trying to acquire lock:
>> > [   39.819650] ff110001f5cbea88 ((&c->lock)){+.+.}-{3:3}, at:
>> > ___slab_alloc+0xb7/0xec0
>> > [   39.819667]
>> > [   39.819667] but task is already holding lock:
>> > [   39.819668] ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
>> > ___slab_alloc+0xb7/0xec0
> 
> the addresses of the locks are different and they're different
> kmalloc buckets, but lockdep cannot understand this without
> explicit local_lock_lockdep_start().
> The same thing I'm trying to explain in the commit log.

Thanks for the explanation and sorry for being so dense.
Maybe lockdep's lock classes can be used here somehow instead of having to
teach lockdep completely new tricks, but I don't know enough about those to
know for sure.

