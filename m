Return-Path: <bpf+bounces-33083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C09916F9F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27961F23177
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FF1779B1;
	Tue, 25 Jun 2024 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0SVB2G5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6+cg1lJd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0SVB2G5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6+cg1lJd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4014EC44;
	Tue, 25 Jun 2024 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338029; cv=none; b=Sget9Qrv9I7z6WkWR8fuzlDMkSVZ0JSgSg3bhN+ZoMMGi9Fa5y478eiZtRpznCOdCbZ//F4eRs5RFZQbcNcnOIz6dkpk/h7dvbDSAl0dlZVX0ToVuqPOlX/Ek3xWwmr/tPrfCLbkDkGit3LmQ3MWL7fYzZBSUG4PV6YD5kjnk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338029; c=relaxed/simple;
	bh=KRxmmfhj8VirFtTMm7wZK/yWFNhQUl38+IfPmeOnv/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lv8NKMQ2JAPt/f/FsSsKXfpJHnRkz6bCT+yGdmLEFNNm9TQgyhrakXASrx0CfD6fumk+5BwTeBP3kWzpd37xf6SvboD4bgkQFAzxlZ+8GDEXocWN9C2WBLjKSn2RWMksvogNk7NZqZbP36Ag0gmbqh5rT6sVIKwenBVVqPXrmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0SVB2G5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6+cg1lJd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0SVB2G5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6+cg1lJd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B330F1F896;
	Tue, 25 Jun 2024 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719338025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZiLxFwiIBIRrsw6YD+1R7GROuRlYmXnVOEUWPLcacXE=;
	b=x0SVB2G5OGcnn4ojzKkzAqQ6fmlXJd2CVyCCQltrORtV1S+M25LnstyYr8SrNuLwLyrsar
	/fSU1nz/CoopCJSfr/8NLv+bcTo6JGBmFxtZmaOMoFGJe5p2oObPsDstGfxyJZ1KoniHK/
	XWyE4I+AUbAtpds8Pm1Xz8NXhC6mfZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719338025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZiLxFwiIBIRrsw6YD+1R7GROuRlYmXnVOEUWPLcacXE=;
	b=6+cg1lJd8fnnaSvzeG96seusvkRpKtZO7JNj3HEYffQ2Z7Hj/WyfU7ZxaUYRlbYlVEdjOe
	YQk8xRWnYBzDacAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719338025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZiLxFwiIBIRrsw6YD+1R7GROuRlYmXnVOEUWPLcacXE=;
	b=x0SVB2G5OGcnn4ojzKkzAqQ6fmlXJd2CVyCCQltrORtV1S+M25LnstyYr8SrNuLwLyrsar
	/fSU1nz/CoopCJSfr/8NLv+bcTo6JGBmFxtZmaOMoFGJe5p2oObPsDstGfxyJZ1KoniHK/
	XWyE4I+AUbAtpds8Pm1Xz8NXhC6mfZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719338025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZiLxFwiIBIRrsw6YD+1R7GROuRlYmXnVOEUWPLcacXE=;
	b=6+cg1lJd8fnnaSvzeG96seusvkRpKtZO7JNj3HEYffQ2Z7Hj/WyfU7ZxaUYRlbYlVEdjOe
	YQk8xRWnYBzDacAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24F9213A9A;
	Tue, 25 Jun 2024 17:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id prMzACkEe2YWawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 25 Jun 2024 17:53:44 +0000
Message-ID: <84eaa356-eafd-45b5-add2-2c44cb9509f5@suse.cz>
Date: Tue, 25 Jun 2024 19:53:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm, slab: add static key for should_failslab()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
 <20240620-fault-injection-statickeys-v2-6-e23947d3d84b@suse.cz>
 <78177ff2-e140-4e81-9b2a-be5bece34cfc@suse.cz>
 <CAADnVQJrirvzu8fqwRChM1aUvHUNoszNpLhXHB9EHVesuD_YJA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAADnVQJrirvzu8fqwRChM1aUvHUNoszNpLhXHB9EHVesuD_YJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,google.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,arm.com,linux.dev,vger.kernel.org,kvack.org];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On 6/25/24 7:12 PM, Alexei Starovoitov wrote:
> On Tue, Jun 25, 2024 at 7:24 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 6/20/24 12:49 AM, Vlastimil Babka wrote:
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -3874,13 +3874,37 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>> >                       0, sizeof(void *));
>> >  }
>> >
>> > -noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>> > +#if defined(CONFIG_FUNCTION_ERROR_INJECTION) || defined(CONFIG_FAILSLAB)
>> > +DEFINE_STATIC_KEY_FALSE(should_failslab_active);
>> > +
>> > +#ifdef CONFIG_FUNCTION_ERROR_INJECTION
>> > +noinline
>> > +#else
>> > +static inline
>> > +#endif
>> > +int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>>
>> Note that it has been found that (regardless of this series) gcc may clone
>> this to a should_failslab.constprop.0 in case the function is empty because
>> __should_failslab is compiled out (CONFIG_FAILSLAB=n). The "noinline"
>> doesn't help - the original function stays but only the clone is actually
>> being called, thus overriding the original function achieves nothing, see:
>> https://github.com/bpftrace/bpftrace/issues/3258
>>
>> So we could use __noclone to prevent that, and I was thinking by adding
>> something this to error-injection.h:
>>
>> #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>> #define __error_injectable(alternative)         noinline __noclone
> 
> To prevent such compiler transformations we typically use
> __used noinline
> 
> We didn't have a need for __noclone yet. If __used is enough I'd stick to that.

__used made no difference here (gcc 13.3), __noclone did

