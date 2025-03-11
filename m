Return-Path: <bpf+bounces-53858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89FA5D0B3
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7103717ACAD
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC52264A7B;
	Tue, 11 Mar 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXDTaAqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qe4NdKfK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXDTaAqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qe4NdKfK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A8264638
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724508; cv=none; b=Qz+UqCU2DE/Dhc/F0xk5OefuYHqBpovXr7YrmwJ1js+KGKrgqzOfcttaMCGyXXwkUsG21rpuOcc7x8LU72omG142RUrUJ9Z09kaeurOBb+VJVwzEB/QcBy8zOicMow1hYCgMahFw5jjUYnEXLlPSjl6X2X1/5S4T8h2oQi0Gc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724508; c=relaxed/simple;
	bh=P9HRftU2jd8wS1F3gu/VTIB7SrXI+0AoJkbernr/z0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOpI3kE9n2MxG49GM5oIiYA9RQpHpERAhT3LvFZICepSK2v8njK2896+K5s/fMjqbnziDn3ON6D2OeyuolrYifEcGG8EqVQ4jNIbgUkaXxbjYktKsuUaEzLUMNhwSMnd15asHDRLCC4NNHSvSKGuR18j+hrxKlkrIN3ORpk4LPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXDTaAqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qe4NdKfK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXDTaAqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qe4NdKfK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A70092117D;
	Tue, 11 Mar 2025 20:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741724504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYxnHgaEKyQ5JNHN6mkyxSYRLuibyl3iozKjcjk0mIw=;
	b=bXDTaAqyp43mxnjf8/aFLXerBj88TRRjiTBDUXLJuVl16MlQGbJmyJrTRHm6VMA1+PWMH/
	glNMlgfrmZv1y6GwWGdoKhImIZ4unNO6J5FqwxasxZIo+cxRKMz5Nj/eIMcpwlvx29i2tv
	bl3epTP/otHl3e5SH3g/O8aiLmD2ATk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741724504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYxnHgaEKyQ5JNHN6mkyxSYRLuibyl3iozKjcjk0mIw=;
	b=qe4NdKfK9hC/x8ZKcMlDnI+RNM+8HVtIE0V/8GmMnzl+yEcsye9f6wPpUekVD8JnevcHrj
	FxIVJn2e6kNFTZCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bXDTaAqy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qe4NdKfK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741724504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYxnHgaEKyQ5JNHN6mkyxSYRLuibyl3iozKjcjk0mIw=;
	b=bXDTaAqyp43mxnjf8/aFLXerBj88TRRjiTBDUXLJuVl16MlQGbJmyJrTRHm6VMA1+PWMH/
	glNMlgfrmZv1y6GwWGdoKhImIZ4unNO6J5FqwxasxZIo+cxRKMz5Nj/eIMcpwlvx29i2tv
	bl3epTP/otHl3e5SH3g/O8aiLmD2ATk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741724504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYxnHgaEKyQ5JNHN6mkyxSYRLuibyl3iozKjcjk0mIw=;
	b=qe4NdKfK9hC/x8ZKcMlDnI+RNM+8HVtIE0V/8GmMnzl+yEcsye9f6wPpUekVD8JnevcHrj
	FxIVJn2e6kNFTZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7135C132CB;
	Tue, 11 Mar 2025 20:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OUh0Glib0GdJQwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 11 Mar 2025 20:21:44 +0000
Message-ID: <b428858a-e985-4acc-95f4-4203afcb500a@suse.cz>
Date: Tue, 11 Mar 2025 21:21:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce
 localtry_lock_t
Content-Language: en-US
To: Mateusz Guzik <mjguzik@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, rostedt@goodmis.org, houtao1@huawei.com,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com,
 willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org,
 linux-mm@kvack.org, kernel-team@fb.com
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com>
 <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
 <20250311162059.BunTzxde@linutronix.de>
 <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A70092117D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,linutronix.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,linux-foundation.org,infradead.org,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,linutronix.de,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 3/11/25 17:31, Mateusz Guzik wrote:
> On Tue, Mar 11, 2025 at 5:21 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> On 2025-03-11 16:44:30 [+0100], Mateusz Guzik wrote:
>> > On Fri, Feb 21, 2025 at 06:44:22PM -0800, Alexei Starovoitov wrote:
>> > > +#define __localtry_lock(lock)                                      \
>> > > +   do {                                                    \
>> > > +           localtry_lock_t *lt;                            \
>> > > +           preempt_disable();                              \
>> > > +           lt = this_cpu_ptr(lock);                        \
>> > > +           local_lock_acquire(&lt->llock);                 \
>> > > +           WRITE_ONCE(lt->acquired, 1);                    \
>> > > +   } while (0)
>> >
>> > I think these need compiler barriers.
>> >
>> > I checked with gcc docs (https://gcc.gnu.org/onlinedocs/gcc/Volatiles.html)
>> > and found this as confirmation:
>> > > Accesses to non-volatile objects are not ordered with respect to volatile accesses.
>> >
>> > Unless the Linux kernel is built with some magic to render this moot(?).
>>
>> You say we need a barrier() after the WRITE_ONCE()? If so, we need it in
>> the whole file…
>>
> 
> I see the original local_lock machinery on the stock kernel works fine
> as it expands to the preempt pair which has the appropriate fences. If
> debug is added, the "locking" remains unaffected, but the debug state
> might be bogus when looked at from the "wrong" context and adding the
> compiler fences would trivially sort it out. I don't think it's a big
> deal for *their* case, but patching that up should not raise any
> eyebrows and may prevent eyebrows from going up later.
> 
> The machinery added in this patch does need the addition for
> correctness in the base operation though.

Yeah my version of this kind of lock in sheaves code had those barrier()'s,
IIRC after you or Jann told me. It's needed so that the *compiler* does not
e.g. reorder a write to the protected data to happen before the
WRITE_ONCE(lt->acquired, 1) (or after the WRITE_ONCE(lt->acquired, 0) in
unlock).

