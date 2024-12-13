Return-Path: <bpf+bounces-46851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF719F0E32
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB45C1615C5
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7ED1E048F;
	Fri, 13 Dec 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MvMVN1Vy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcBBSQ1V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MvMVN1Vy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcBBSQ1V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F817548
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098530; cv=none; b=R+ESLkOOTJNFsAGC69zYNIrDdmF31nnEtOANP8e88JxSPIEMuYrDa2aLhWrHUccNAByD4e/LbgF7QQ9Hyc9T0gfFdxTuAZIDbm1rGpsC7aFpAlyv6KNMkWogpmlADNLqo9C7SkTy70VBFITaFverYI5e9yYTL0SjOL2e3wDAiSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098530; c=relaxed/simple;
	bh=rQbU7J8hO89zUqpXOgkqgOpscGhEwv32Humbu46NjNE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pF8dhkJMiXkYEQDoXygTbPDkDWIe2rW56XFwlZ7NZeUVfN+rufwavRSTw5yrb8Ej9KDoztT21WuGMUNGhVKHN6UKfpBs3W5NFXDyx/+CzVs8x6ndOfVidWTK0ImB0QiStf8el0GhNJf9qNWBte6Q/rN5e+WvToARZCOM8DTmnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MvMVN1Vy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcBBSQ1V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MvMVN1Vy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcBBSQ1V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37B501F457;
	Fri, 13 Dec 2024 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734098527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v//T0Q7N5+84Kw93d1hG8IEBXKZFdr1NkGkDrR4j9fQ=;
	b=MvMVN1VyWvGbZfyoYN2u8zfg+H4yqxjErIUcBZqZqB7S8o1X70G2HzJZgJNpBn4yAuVxhk
	IB5BRIG5hFGB3AmMh4Ww7WckCQy0dB6+gNzfJZserpex9WDhHgfm6qxkftQ3ie//jQvbeU
	lO0PTeYoUnBY+2d1OYJGKtA/I+GfpBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734098527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v//T0Q7N5+84Kw93d1hG8IEBXKZFdr1NkGkDrR4j9fQ=;
	b=KcBBSQ1V6k8pCNk2oXB+9RgWHX3s/7d1LOktUanPgMH6l50nkgv/W3kfSEwIauG9YY3yAc
	OiqjZE1q0fgyOrBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734098527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v//T0Q7N5+84Kw93d1hG8IEBXKZFdr1NkGkDrR4j9fQ=;
	b=MvMVN1VyWvGbZfyoYN2u8zfg+H4yqxjErIUcBZqZqB7S8o1X70G2HzJZgJNpBn4yAuVxhk
	IB5BRIG5hFGB3AmMh4Ww7WckCQy0dB6+gNzfJZserpex9WDhHgfm6qxkftQ3ie//jQvbeU
	lO0PTeYoUnBY+2d1OYJGKtA/I+GfpBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734098527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v//T0Q7N5+84Kw93d1hG8IEBXKZFdr1NkGkDrR4j9fQ=;
	b=KcBBSQ1V6k8pCNk2oXB+9RgWHX3s/7d1LOktUanPgMH6l50nkgv/W3kfSEwIauG9YY3yAc
	OiqjZE1q0fgyOrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E0C8137CF;
	Fri, 13 Dec 2024 14:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 66GzAl8+XGeEFQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 13 Dec 2024 14:02:07 +0000
Message-ID: <b67b1a0c-194a-4dd4-bc83-271e6388208f@suse.cz>
Date: Fri, 13 Dec 2024 15:02:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/6] locking/local_lock: Introduce
 local_trylock_irqsave()
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>,
 Jann Horn <jannh@google.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-4-alexei.starovoitov@gmail.com>
 <1c760bf1-14a4-42e4-a55b-438a29987aef@suse.cz>
 <9e5bdef1-a692-47d5-82b9-96a4f2c68463@suse.cz>
 <CAADnVQJtkb3YVM9La_Zo=t_s+DNNrrVhX1gt5KsQUPZTdw_7Eg@mail.gmail.com>
 <60fadf5a-4c96-43b3-8cc2-baf71eb93e3f@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <60fadf5a-4c96-43b3-8cc2-baf71eb93e3f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
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
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,kvack.org,fb.com,google.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 12/12/24 10:15, Vlastimil Babka wrote:
> On 12/12/24 03:49, Alexei Starovoitov wrote:
>> I like your
>> +struct local_tryirq_lock
>> approach, but let's put it in local_lock.h ?
> 
> Sure, that was a proof of concept so kept it local.
> 
>> and it probably needs local_inc_return() instead of READ/WRITE_ONCE.
>> With irq and nmis it's racy.
> 
> Hm guess you are right, thanks!
> 

Ah I remember now, the idea was that if an irq or nmi interrupts someone
else between checking that active is 0 and setting it to 1, it will finish
the critical section and unlock before the interrupted context can continue,
so the race is harmless.

