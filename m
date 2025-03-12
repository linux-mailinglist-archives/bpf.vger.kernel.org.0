Return-Path: <bpf+bounces-53885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4DA5DA10
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 11:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D973A7F33
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328B236A8B;
	Wed, 12 Mar 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ch8DPrb1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFWtFWU2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OhsgD5va";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+jlQNgX3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3421DF979
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773630; cv=none; b=u5f0OsglfC2GQlx1bh9dri4BYnqgcT5udXHt7YXcuragwnuQZ+xzHA7WOeMKGb6NDNKiaM/wzTOzkUMf+rboyNPC1cY49MOCQqHjjMZCj2XidjTUx76a0uCdU7Vzv2cKw9OO/6GG6sC32Wi/O5EgwLUNiGIsCCfnbdnOPG61mRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773630; c=relaxed/simple;
	bh=OY35CyRLH65BAjnx1MusHgfueKnRQPBHjpDkYJNw2C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdFwxOLs0pdfE/bYBLwcpdZcRaGk/eIrMC3it9hH9DPo8SA/sPcPpWWpNya+qb7s3/5pKeFxKRTq0v6F1bFtXQfSUVfW/qpzpvsaLxqUhupCntGMDhluJ8JQtzec2nKYYYu1nzQXwfdGCOzKPJCgBIK9jbDVaomzlFw2fopiLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ch8DPrb1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFWtFWU2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OhsgD5va; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+jlQNgX3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C77DB1F385;
	Wed, 12 Mar 2025 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741773621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNzwwivjxxVIXbRf2brb54TB+ggvTLNkym/2QXw3vh4=;
	b=ch8DPrb1PYEnPCgejqBMpT//JusTOiUka9MmLFbbqgQ7cx1/7CBMKs3Eb+sODb3tjLxyLv
	9q9mZGxJ9dinjHOncXQWP5X55vuZBMHWtOX+QZ9OiPlctIQlfooppW93cjYF7uB/XJ119s
	vcr6JTSdTljCyRMjb2wTUtUStc1XrzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741773621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNzwwivjxxVIXbRf2brb54TB+ggvTLNkym/2QXw3vh4=;
	b=JFWtFWU20NOoP6j48Miqux+YbvQEwDyAObjQG9B4Q6oT2i+XRL7RTDUOy6XmvHSnmb2vD5
	/qUPMVFdrehYP5Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OhsgD5va;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+jlQNgX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741773620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNzwwivjxxVIXbRf2brb54TB+ggvTLNkym/2QXw3vh4=;
	b=OhsgD5vaLM3w9maT9BtwTbmcjmxiA2viK6XuFateXURR4rfYbckvegndeM8Ayu7JFM3yLy
	diveavtiOtWLK7aq4s5NORezs/1iNoHq4naVWkR6v0+O1Vy2iMYcZ1hnBo6EOSARn2D/Gc
	6ewGov0yeUXxdPCPJ+MMSgkLJWI4Tgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741773620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNzwwivjxxVIXbRf2brb54TB+ggvTLNkym/2QXw3vh4=;
	b=+jlQNgX3ZyvIkHcZb9erfSp3cu5N4jcWNtq8t4hXimj8eizN145BzboVfl4J1kUvM3KWOr
	X6/Z2JgTqIbAhGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A24681377F;
	Wed, 12 Mar 2025 10:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hh0dJzRb0WcbHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 10:00:20 +0000
Message-ID: <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
Date: Wed, 12 Mar 2025 11:00:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
 Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Kernel Team <kernel-team@fb.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com>
 <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C77DB1F385
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
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/11/25 14:32, Alexei Starovoitov wrote:
> On Tue, Mar 11, 2025 at 3:04 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Fri, 21 Feb 2025 18:44:23 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>
>> > Tracing BPF programs execute from tracepoints and kprobes where
>> > running context is unknown, but they need to request additional
>> > memory. The prior workarounds were using pre-allocated memory and
>> > BPF specific freelists to satisfy such allocation requests.
>>
>> The "prior workarounds" sound entirely appropriate.  Because the
>> performance and maintainability of Linux's page allocator is about
>> 1,000,040 times more important than relieving BPF of having to carry a
>> "workaround".
> 
> Please explain where performance and maintainability is affected?
> 
> As far as motivation, if I recall correctly, you were present in
> the room when Vlastimil presented the next steps for SLUB at
> LSFMM back in May of last year.
> A link to memory refresher is in the commit log:
> https://lwn.net/Articles/974138/
> 
> Back then he talked about a bunch of reasons including better
> maintainability of the kernel overall, but what stood out to me
> as the main reason to use SLUB for bpf, objpool, mempool,
> and networking needs is prevention of memory waste.
> All these wrappers of slub pin memory that should be shared.
> bpf, objpool, mempools should be good citizens of the kernel
> instead of stealing the memory. That's the core job of the
> kernel. To share resources. Memory is one such resource.

Yes. Although at that time I've envisioned there would still be some
reserved objects set aside for these purposes. The difference would be they
would be under control of the allocator and not in multiple caches outside
of it.

But if we can achieve the same without such reserved objects, I think it's
even better. Performance and maintainability doesn't need to necessarily
suffer. Maybe it can even improve in the process. E.g. if we build upon
patches 1+4 and swith memcg stock locking to the non-irqsave variant, we
should avoid some overhead there (something similar was tried there in the
past but reverted when making it RT compatible).

