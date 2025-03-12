Return-Path: <bpf+bounces-53882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82722A5D833
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D55B3A4FE4
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59282343AF;
	Wed, 12 Mar 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJG+hdaS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZXlk46/t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iNgGKjWW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEXuedyH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335A15CD74
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768160; cv=none; b=CK6zhTwiJwY6EhZW/cT2GH+/vhvf6zQSXRBIEUj2CcLe7vMms+Hd55/dviJoxTDv+muwBL43xqUfcKBH2/85DDWuC1t0EBg/EByN4Cgu07cqGqjAnfi60Dpwp8VGwBZKLH3XoORt5wPGmJPfvuwRqUPiFbiOw6VLYH8sKY5BNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768160; c=relaxed/simple;
	bh=fJF4aAKmFehUoS9heXYNSxH1PkgbHF+n094HhQxUZfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsDi1rY9L0eEcJjVPsSUzAigFW2CTCLTDc1s8e2OSkGu6xv3mZiDZDAxohfa7G+v745b/iJfLYpzFhh+QbKpNbBvHF7HQa/YLv53WvHMMFQx508MsJOLgNKuaFUQM/9WtpNHEPC9VTysT4DcPHa012vXkTyKw1nyowZzouHMZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NJG+hdaS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZXlk46/t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iNgGKjWW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEXuedyH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF1F721191;
	Wed, 12 Mar 2025 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741768156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFDcyHv2rPhwU7HSFXM2u0+Uk0NgStzkjPXTuZ52N0k=;
	b=NJG+hdaSsz+sygZ+7Q5chLxj8q++v2OF3xy9EKD2uS59UUv7PKyFcA7wBo7cowZzvWlG4w
	T1ua+p5cCOhvoHqKuCLLJUXUeGwwGq9IlDY1RBprn+5GwuRu035fdcZAx0IjFEvlHvg022
	4MjhWxnXiLZbOaJO6zBnChGVp6V67Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741768156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFDcyHv2rPhwU7HSFXM2u0+Uk0NgStzkjPXTuZ52N0k=;
	b=ZXlk46/t3khFnobzM8MonAhX7ymwC3DAmDOpGPI7kpujJaPeEOI2qDVR+GATkIAFSi6luz
	5O1NUHjJbGXvQqDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iNgGKjWW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HEXuedyH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741768155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFDcyHv2rPhwU7HSFXM2u0+Uk0NgStzkjPXTuZ52N0k=;
	b=iNgGKjWWqubMBXc2AHhQsOsTIU9sEidWc3AjJCWYYFIphXJfz5D7CJ7+MQvfyQH5IhHKUu
	GKK8g8WUSBrZodybV0FX0PA2rTFMQNRCitzgi7u2OsxeDz4aOsFvPq7IQnKkPLlCvlUK36
	N8X/DhgR71u4MkD6uuc+cQ8m/e3vz3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741768155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFDcyHv2rPhwU7HSFXM2u0+Uk0NgStzkjPXTuZ52N0k=;
	b=HEXuedyHxqfgk7Szj8oplCnUOA/UjOXNudhDqrDaW3xHDt35CaZ+CbXPE84nF4sMOThpN3
	ncfuc6if8IDTE/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C84F1377F;
	Wed, 12 Mar 2025 08:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id syL1IdtF0WeFfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 08:29:15 +0000
Message-ID: <496ff0d2-97ac-41f5-a776-455025fb72db@suse.cz>
Date: Wed, 12 Mar 2025 09:29:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce
 localtry_lock_t
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf
 <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com>
 <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
 <20250311162059.BunTzxde@linutronix.de>
 <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
 <b428858a-e985-4acc-95f4-4203afcb500a@suse.cz>
 <CAADnVQKP-oMrCyC2VPCEEXMxEO6+E2qknY8URLtCNySxwu8h0g@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQKP-oMrCyC2VPCEEXMxEO6+E2qknY8URLtCNySxwu8h0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF1F721191
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linutronix.de,vger.kernel.org,kernel.org,linux-foundation.org,infradead.org,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/11/25 23:24, Alexei Starovoitov wrote:
> On Tue, Mar 11, 2025 at 9:21 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 3/11/25 17:31, Mateusz Guzik wrote:
>> > On Tue, Mar 11, 2025 at 5:21 PM Sebastian Andrzej Siewior
>> > <bigeasy@linutronix.de> wrote:
>> >>
>> >> On 2025-03-11 16:44:30 [+0100], Mateusz Guzik wrote:
>> >> > On Fri, Feb 21, 2025 at 06:44:22PM -0800, Alexei Starovoitov wrote:
>> >> > > +#define __localtry_lock(lock)                                      \
>> >> > > +   do {                                                    \
>> >> > > +           localtry_lock_t *lt;                            \
>> >> > > +           preempt_disable();                              \
>> >> > > +           lt = this_cpu_ptr(lock);                        \
>> >> > > +           local_lock_acquire(&lt->llock);                 \
>> >> > > +           WRITE_ONCE(lt->acquired, 1);                    \
>> >> > > +   } while (0)
>> >> >
>> >> > I think these need compiler barriers.
>> >> >
>> >> > I checked with gcc docs (https://gcc.gnu.org/onlinedocs/gcc/Volatiles.html)
>> >> > and found this as confirmation:
>> >> > > Accesses to non-volatile objects are not ordered with respect to volatile accesses.
>> >> >
>> >> > Unless the Linux kernel is built with some magic to render this moot(?).
>> >>
>> >> You say we need a barrier() after the WRITE_ONCE()? If so, we need it in
>> >> the whole file…
>> >>
>> >
>> > I see the original local_lock machinery on the stock kernel works fine
>> > as it expands to the preempt pair which has the appropriate fences. If
>> > debug is added, the "locking" remains unaffected, but the debug state
>> > might be bogus when looked at from the "wrong" context and adding the
>> > compiler fences would trivially sort it out. I don't think it's a big
>> > deal for *their* case, but patching that up should not raise any
>> > eyebrows and may prevent eyebrows from going up later.
>> >
>> > The machinery added in this patch does need the addition for
>> > correctness in the base operation though.
>>
>> Yeah my version of this kind of lock in sheaves code had those barrier()'s,
>> IIRC after you or Jann told me. It's needed so that the *compiler* does not
>> e.g. reorder a write to the protected data to happen before the
>> WRITE_ONCE(lt->acquired, 1) (or after the WRITE_ONCE(lt->acquired, 0) in
>> unlock).
> 
> I think you all are missing a fine print in gcc doc:
> "Unless...can be aliased".
> The kernel is compiled with -fno-strict-aliasing.
> No need for barrier()s here.

Note I know next to nothing about these things, but I see here [1]:

"Whether GCC actually performs type-based aliasing analysis depends on the
details of the code. GCC has other ways to determine (in some cases) whether
objects alias, and if it gets a reliable answer that way, it won’t fall back
on type-based heuristics. [...] You can turn off type-based aliasing
analysis by giving GCC the option -fno-strict-aliasing."

I'd read that as -fno-strict-aliasing only disables TBAA, but that does not
necessary mean anything can be assumed to be aliased with anything?
An if we e.g. have a pointer to memcg_stock_pcp through which we access the
stock_lock an the other (protected) fields and that pointer doesn't change
between that, I imagine gcc can reliably determine these can't alias?

[1]
https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Aliasing-Type-Rules.html

