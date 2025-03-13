Return-Path: <bpf+bounces-53956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D281A5F7DF
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF8319C3BC3
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D2267F57;
	Thu, 13 Mar 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QBheAwx+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LCVHwT1x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QBheAwx+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LCVHwT1x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BA267B91
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875718; cv=none; b=EjTOjdDaAGWZFhKZ7tgb3Nos7FY/V7Vr8vnNCMj1dUxvMgF9oryDtB4yE0DjROcwT82kh5HInhsyfro1Babr6A2yMENZDTst1PU6O/90WqwGyL9wWE1AXpww6EOAxh9u6Sh6Z3s1s0Zdpf9DWBR7BMsebdyVyC6reUCQ8nb3NoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875718; c=relaxed/simple;
	bh=sf07GbI+fvvAw3U3/dOhzQw4W4UZJUSfLxseMo/nSK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odf+R+l95ND3TUhp06P3AW8LSaouYIr2YgGlWYizppqx7wu/qgCDVqoIc0Z2YfUmJKp2wf36dIP8M1pUYM00ITdwr3bUXdc4kwriuSbemqi2vLwQh1gvBYIMAPU4YpldtvGanLdlVMS508DOL+Yu/f/qMrGwH7PwGnrZXB/V9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QBheAwx+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LCVHwT1x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QBheAwx+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LCVHwT1x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B818F1F390;
	Thu, 13 Mar 2025 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741875708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSrY7tgSY5ZQNoZ60wgvqc0lXyP8OzsU9q7L4o35Neo=;
	b=QBheAwx+nUZ4LHfhrCAyCKy6aRAG45GX1HfJmONEwYipcnxOkm6aQgx8YYGKRL2COYkqGZ
	BGcYqvWPkw0zTIv2JxdpmOJV9ET9eoCKVV194i3erzQdtspXgtiLa8V+taqdlZ21CBRNML
	UJxq0PQYO0Vm36WGc8pSKdLbIuK5eNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741875708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSrY7tgSY5ZQNoZ60wgvqc0lXyP8OzsU9q7L4o35Neo=;
	b=LCVHwT1xfmTtKU5RMaG97g/jhrIGiD3OF+dwoiDr3xND8q2Nd7yacLTthKTKcKOBWS/VGO
	uGBdV3x5Gnpn8+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741875708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSrY7tgSY5ZQNoZ60wgvqc0lXyP8OzsU9q7L4o35Neo=;
	b=QBheAwx+nUZ4LHfhrCAyCKy6aRAG45GX1HfJmONEwYipcnxOkm6aQgx8YYGKRL2COYkqGZ
	BGcYqvWPkw0zTIv2JxdpmOJV9ET9eoCKVV194i3erzQdtspXgtiLa8V+taqdlZ21CBRNML
	UJxq0PQYO0Vm36WGc8pSKdLbIuK5eNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741875708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSrY7tgSY5ZQNoZ60wgvqc0lXyP8OzsU9q7L4o35Neo=;
	b=LCVHwT1xfmTtKU5RMaG97g/jhrIGiD3OF+dwoiDr3xND8q2Nd7yacLTthKTKcKOBWS/VGO
	uGBdV3x5Gnpn8+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96DF413797;
	Thu, 13 Mar 2025 14:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJJ7JPzp0mdtCgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 13 Mar 2025 14:21:48 +0000
Message-ID: <4a52db5b-f5fe-4a60-ba17-a634a2d0b7af@suse.cz>
Date: Thu, 13 Mar 2025 15:21:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
 Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Kernel Team <kernel-team@fb.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com>
 <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
 <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
 <igjisv7v3o2efey3qkhcrqjchlqvjn54c4dneo2atmown6pweq@jwohzvtldfzf>
 <Z9KbAZJh5uENfQtn@tiehlicka>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z9KbAZJh5uENfQtn@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,vger.kernel.org,kernel.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,google.com,kvack.org,fb.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/13/25 09:44, Michal Hocko wrote:
> On Wed 12-03-25 12:06:10, Shakeel Butt wrote:
>> On Wed, Mar 12, 2025 at 11:00:20AM +0100, Vlastimil Babka wrote:
>> [...]
>> > 
>> > But if we can achieve the same without such reserved objects, I think it's
>> > even better. Performance and maintainability doesn't need to necessarily
>> > suffer. Maybe it can even improve in the process. E.g. if we build upon
>> > patches 1+4 and swith memcg stock locking to the non-irqsave variant, we
>> > should avoid some overhead there (something similar was tried there in the
>> > past but reverted when making it RT compatible).
>> 
>> In hindsight that revert was the bad decision. We accepted so much
>> complexity in memcg code for RT without questioning about a real world
>> use-case. Are there really RT users who want memcg or are using memcg? I
>> can not think of some RT user fine with memcg limits enforcement
>> (reclaim and throttling).
> 
> I do not think that there is any reasonable RT workload that would use
> memcg limits or other memcg features. On the other hand it is not
> unusual to have RT and non-RT workloads mixed on the same machine. They
> usually use some sort of CPU isolation to prevent from CPU contention
> but that doesn't help much if there are other resources they need to
> contend for (like shared locks). 
> 
>> I am on the path to bypass per-cpu memcg stocks for RT kernels.
> 
> That would cause regressions for non-RT tasks running on PREEMPT_RT
> kernels, right?

For the context, this is about commit 559271146efc ("mm/memcg: optimize user
context object stock access")

reverted in fead2b869764 ("mm/memcg: revert ("mm/memcg: optimize user
context object stock access")")

I think at this point we don't have to recreate the full approach of the
first commit and introduce separate in_task() and in-interrupt stocks again.

The localtry_lock itself should make it possible to avoid the
irqsave/restore overhead (which was the main performance benefit of
559271146efc [1]) and only end up bypassing the stock when an allocation
from irq context actually interrupts an allocation from task context - which
would be very rare. And it should be already RT compatible. Let me see how
hard it would be on top of patch 4/6 "memcg: Use trylock to access memcg
stock_lock" to switch to the variant without _irqsave...

[1] the revert cites benchmarks that irqsave/restore can be actually cheaper
than preempt disable/enable, but I believe those were flawed

