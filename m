Return-Path: <bpf+bounces-54964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC1A7669A
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820EB188A884
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230CD211472;
	Mon, 31 Mar 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x640sivD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3+KbWedF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x640sivD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3+KbWedF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3242AE8D
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426677; cv=none; b=UwbyJEoSX0OxhFUOHogfDQkfnICjFwcBhB3dq3kkBrtM//l+AjynyppBekxXe7daIJZG3arc5gcoelSSl1ppX5Hr/F50Rp4pH2qQtjIgEvD7l/KSlZLiJFxpDuVTYGJ8yAc99/yHkra+tRozGxbGFBUyzSGLlv/+T+dIeyEONp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426677; c=relaxed/simple;
	bh=XsiVREOjhw29kcY3WPjKFPMMC7UkyCeZrRkUJaVt+SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPXJCq+zgAQ7cZH+iieeNFIBCq9dcsJhcxkpQ8V8KYJljUSu3dxGkkyjzOsY7zMWQH9l/3ZTKGYts6YBTeaH0NM6MH05CpFkETDntAQRxYp6VqWNx9XYDDAgy6M+O5DOPa1b4/qW2AuDqqXk7B3yKo9V2fX5w3XVinbP1uAyCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x640sivD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3+KbWedF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x640sivD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3+KbWedF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 599FF1F38E;
	Mon, 31 Mar 2025 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743426674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgHcXmdY3VYM46vtSTqvA/3bmTusiv5oR1yMTgeGHpw=;
	b=x640sivDOeNTg2VAWeZtzy9wMxv3xFubRMhWJtCop2T4kZSHhT9++QzXXWxWYC3yL819aX
	l4hS+wBcyBtY3M128IFsHvd8w6uZCAmXud75W3tgglS3Yhzh8KY45j/bQbZ2KVg58gkQfU
	4igBVLmji9aCytVcfN4Dw7BMRjqbz5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743426674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgHcXmdY3VYM46vtSTqvA/3bmTusiv5oR1yMTgeGHpw=;
	b=3+KbWedFrTOCKhtVcsXXdV7dLz3SQlwCNw37K5Ey76cxjk4s8nPzdOG3a4ysAsFjaCcLYc
	vDSKQH/5OlGZm+Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743426674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgHcXmdY3VYM46vtSTqvA/3bmTusiv5oR1yMTgeGHpw=;
	b=x640sivDOeNTg2VAWeZtzy9wMxv3xFubRMhWJtCop2T4kZSHhT9++QzXXWxWYC3yL819aX
	l4hS+wBcyBtY3M128IFsHvd8w6uZCAmXud75W3tgglS3Yhzh8KY45j/bQbZ2KVg58gkQfU
	4igBVLmji9aCytVcfN4Dw7BMRjqbz5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743426674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgHcXmdY3VYM46vtSTqvA/3bmTusiv5oR1yMTgeGHpw=;
	b=3+KbWedFrTOCKhtVcsXXdV7dLz3SQlwCNw37K5Ey76cxjk4s8nPzdOG3a4ysAsFjaCcLYc
	vDSKQH/5OlGZm+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 252E613A1F;
	Mon, 31 Mar 2025 13:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6tu3CHKU6mdxHAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 31 Mar 2025 13:11:14 +0000
Message-ID: <c50d94ff-cd22-426a-8ede-21d9d045e2a1@suse.cz>
Date: Mon, 31 Mar 2025 15:11:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
 <CAADnVQJBHPbq6+TQhM2kmWNBTiPoB50_fnVcwC+yLOtpjUWujA@mail.gmail.com>
 <CAHk-=wgpYOGdQ+f62nbAB4xKLRbxnuJD+2uPBmRzSWCo5XkEGA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=wgpYOGdQ+f62nbAB4xKLRbxnuJD+2uPBmRzSWCo5XkEGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/31/25 00:08, Linus Torvalds wrote:
> On Sun, 30 Mar 2025 at 14:30, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> But to avoid being finger pointed, I'll switch to checking alloc_flags
>> first. It does seem a better trade off to avoid cache bouncing because
>> of 2nd cmpxchg. Though when I wrote it this way I convinced myself and
>> others that it's faster to do trylock first to avoid branch misprediction.
> 
> Yes, the really hot paths (ie core locking) do the "trylock -> read
> spinning" for that reason. Then for the normal case, _only_ the
> trylock is in the path, and that's the best of both worlds.

I've been wondering if spin locks could expose the contended slowpath so we
can trylock, and on failure do the check and then call the slowpath directly
that doesn't include another trylock.

It would also be nice if the trylock part could become inline and only the
slowpath would be a function call - even during normal spin_lock_*()
operation. AFAIK right now everything is a function call on x86_64. Not sure
how feasible would that be with the alternatives and paravirt stuff we do.

> And in practice, the "do two compare-and-exchange" operations actually
> does work fine, because the cacheline will generally be sticky enough
> that you don't actually get many extra cachline bouncing.
> 
> So I'm not sure it matters in the end, but I did react to it.
> 
>              Linus


