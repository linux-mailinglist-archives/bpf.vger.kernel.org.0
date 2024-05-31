Return-Path: <bpf+bounces-31007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65728D5E82
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FE41C2152F
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119C1422CB;
	Fri, 31 May 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rS7+8pb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLvv0vE+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rS7+8pb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLvv0vE+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1085624;
	Fri, 31 May 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148188; cv=none; b=QpEwP15hHLKoTiBerSG1ZJbDmBJ8ZhqOSVY1tCVbpYy1d39Jt1efBvrHbifmWl2+tRnZ4WrkzjTBOHY3UvCE0O5bl28vvW+1Qmh+nqirMM7mO/YiVbmYmdEch0uVJgn/9cyoZtcYG7jrlKKgLO7LkUdt+efZohC4qo5K3UTinBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148188; c=relaxed/simple;
	bh=Vu7w8m1msBeA/uve33Z1NcEBHf/upBAxGGQ8MCl/OKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2e7pz+j19QVEEPwcnWsj+D5hJfTAqA+AmgXaDYWFVjE+ykaSZxMUyBWQgEbwi5uh8MSy5q9BTK3uWoQK8gXOe+HcyB8oU+kFv2TmutTjC7LrbgmR6KX81/XTENoENTasotnnEcQtTXg4ReOZh3DOvJlzTo2A2HNFrY5gbOR0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rS7+8pb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLvv0vE+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rS7+8pb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLvv0vE+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6218F1F820;
	Fri, 31 May 2024 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8kgU6Sd9jj8yoPtUU3IcnMPSu4EmXnUcRqzPbVvLTX0=;
	b=1rS7+8pbblH+0/nXH4PGdLL+gYURL6NrtvAO768THyzuNwlhjHYz+Wv/QeZUeFBL9/FBvn
	qV8N6zGOivcb+Sfl/SQ01hkN9zHsBQ+3MYnw7AokcL0ZXp0vmUnt+QAlqgj1pnf3g9geQ9
	OJdtcLQUM7Vu6czyECTv5X3qqTi81lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8kgU6Sd9jj8yoPtUU3IcnMPSu4EmXnUcRqzPbVvLTX0=;
	b=BLvv0vE+1ln4X1WMCIj8szCIJwhBxaLMbWGIsNW0+ByBGN/+fTFylvu14lhka++Woe0MxE
	3GCCd7RjNnfu/0Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1rS7+8pb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BLvv0vE+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8kgU6Sd9jj8yoPtUU3IcnMPSu4EmXnUcRqzPbVvLTX0=;
	b=1rS7+8pbblH+0/nXH4PGdLL+gYURL6NrtvAO768THyzuNwlhjHYz+Wv/QeZUeFBL9/FBvn
	qV8N6zGOivcb+Sfl/SQ01hkN9zHsBQ+3MYnw7AokcL0ZXp0vmUnt+QAlqgj1pnf3g9geQ9
	OJdtcLQUM7Vu6czyECTv5X3qqTi81lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8kgU6Sd9jj8yoPtUU3IcnMPSu4EmXnUcRqzPbVvLTX0=;
	b=BLvv0vE+1ln4X1WMCIj8szCIJwhBxaLMbWGIsNW0+ByBGN/+fTFylvu14lhka++Woe0MxE
	3GCCd7RjNnfu/0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 397EB132C2;
	Fri, 31 May 2024 09:36:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rHqcDReaWWY2HgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 31 May 2024 09:36:23 +0000
Message-ID: <12c1dbf0-d458-49a3-b4b3-b0e8a8bd2cd8@suse.cz>
Date: Fri, 31 May 2024 11:36:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
Content-Language: en-US
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Howard McLauchlan <hmclauchlan@fb.com>,
 bpf@vger.kernel.org, torvalds@linux-foundation.org
References: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
 <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>
 <3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6218F1F820
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,kvack.org,linux-foundation.org,kernel.org,iogearbox.net,fb.com,linux.com,google.com,lge.com,gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]

On 5/27/24 11:34 AM, Mateusz Guzik wrote:
> +cc Linus
> 
> On Thu, Oct 07, 2021 at 05:32:52PM +0200, Vlastimil Babka wrote:
>> On 10/5/21 17:31, Jens Axboe wrote:
>> > Allocations can be a very hot path, and this out-of-line function
>> > call is noticeable.
>> > 
>> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> 
>> It used to be inline b4 (hi, Konstantin!) and then was converted to be like
>> this intentionally :/
>> 
>> See 4f6923fbb352 ("mm: make should_failslab always available for fault
>> injection")
>> 
>> And now also kernel/bpf/verifier.c contains:
>> BTF_ID(func, should_failslab)
>> 
>> I think either your or Andrew's version will break this BTF_ID thing, at the
>> very least.
>> 
>> But I do strongly agree that putting unconditionally a non-inline call into
>> slab allocator fastpath sucks. Can we make it so that bpf can only do these
>> overrides when CONFIG_FAILSLAB is enabled?
>> I don't know, perhaps putting this BTF_ID() in #ifdef as well, or providing
>> a dummy that is always available (so that nothing breaks), but doesn't
>> actually affect slab_pre_alloc_hook() unless CONFIG_FAILSLAB has been enabled?
>> 
> 
> I just ran into it while looking at kmalloc + kfree pair.
> 
> A toy test which calls this in a loop like so:
> static long noinline custom_bench(void)
> {
>         void *buf;
> 
>         while (!signal_pending(current)) {
>                 buf = kmalloc(16, GFP_KERNEL);
>                 kfree(buf);
>                 cond_resched();
>         }
> 
>         return -EINTR;
> }
> 
> ... shows this with perf top:
>    57.88%  [kernel]           [k] kfree
>    31.38%  [kernel]           [k] kmalloc_trace_noprof
>     3.20%  [kernel]           [k] should_failslab.constprop.0
> 
> A side note is that I verified majority of the time in kfree and
> kmalloc_trace_noprof is cmpxchg16b, which is both good and bad news.
> 
> As for should_failslab, it compiles to an empty func on production
> kernels and is present even when there are no supported means of
> instrumenting it. As in everyone pays for its existence, even if there
> is no way to use it.
> 
> Also note there are 3 unrelated mechanisms to alter the return code,
> which imo is 2 too many. But more importantly they are not even
> coordinated.
> 
> A hard requirement for a long term solution is to not alter the fast
> path beyond nops for hot patching.
> 
> So far I think implementing this in a clean manner would require
> agreeing on some namespace for bpf ("failprobes"?) and coordinating
> hotpatching between different mechanisms. Maybe there is a better, I
> don't know.

I've attempted something (not complete yet) here:

https://lore.kernel.org/all/20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz/

> Here is the crux of my e-mail though:
> 1. turning should_failslab into a mandatory func call is an ok local
>    hack for the test farm, not a viable approach for production
> 2. as such it is up to the original submitter (or whoever else
>    who wants to pick up the slack) to implement something which
>    hotpatches the callsite as opposed to inducing a function call for
>    everyone
> 
> In the meantime the routine should disappear unless explicitly included
> in kernel config. The patch submitted here would be one way to do it.


