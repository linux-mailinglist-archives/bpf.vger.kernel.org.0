Return-Path: <bpf+bounces-54953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDBA763B1
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C66418865CC
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FD1DF247;
	Mon, 31 Mar 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UJMBgGsb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Us48FF6g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UJMBgGsb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Us48FF6g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1781D90AD
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415149; cv=none; b=R9rl9+qrv/SOh02/sCKOev/wqVJX8seS+32R3yeiYueiznAyZWh2IVoM9BrmC6ltFbVVHZDHwDYxbwUEOeaoiBgA0XO8gOKqY801i7sxDUrxhBKRlHlvR9OGVxaUXd5zJa3di0PtJhDC+BjbCUeAaJ3MDjAXPosQk9UpeVRgSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415149; c=relaxed/simple;
	bh=fE2yV1EfWdOSDD3lTLSFSatOPo4QJYyHJ6sAYEeiirw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJUS9OiWr8DaNLJD81eM28R8XLKnmM1jW6Hrc6C0FX0Cs9dBwy6h1j0qE3WanZMvWZY/ch+d4riWlStufVAtOFgySAFXx7jmxS5/n5SwCLYYZUNTgMpNkEgwH43LHoOinNS9OTSduitiSyWk0hYMfWQdBulhler8sqNnKuOHlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UJMBgGsb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Us48FF6g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UJMBgGsb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Us48FF6g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C0BC1F38D;
	Mon, 31 Mar 2025 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdJX3EPh9zBNVXcfpydPnfMxZ6GfiCP+RhGRVnB0bTs=;
	b=UJMBgGsb89hYXxoQNZR7fxon4nMOezI+Ogxs4FPU/uSPd488PWUX3t4XSkDzJGmPphfBWY
	f6AZ8/j5NtpRLPIZ7pedpQtQAv1g7MYbR8rCAkugodzHyA/NapHfkGWYmXJDfR6NdFWUEM
	W4Hn6hHmT4+qoE6MicMOHW2l31glqk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdJX3EPh9zBNVXcfpydPnfMxZ6GfiCP+RhGRVnB0bTs=;
	b=Us48FF6gfumWf0od57vWzU7yqIIbPhn9LfQpqRxMcSwD+7A8lb89Azbp/uIeoIhb0zNbJ1
	34oigXPf6BORX6DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UJMBgGsb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Us48FF6g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdJX3EPh9zBNVXcfpydPnfMxZ6GfiCP+RhGRVnB0bTs=;
	b=UJMBgGsb89hYXxoQNZR7fxon4nMOezI+Ogxs4FPU/uSPd488PWUX3t4XSkDzJGmPphfBWY
	f6AZ8/j5NtpRLPIZ7pedpQtQAv1g7MYbR8rCAkugodzHyA/NapHfkGWYmXJDfR6NdFWUEM
	W4Hn6hHmT4+qoE6MicMOHW2l31glqk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdJX3EPh9zBNVXcfpydPnfMxZ6GfiCP+RhGRVnB0bTs=;
	b=Us48FF6gfumWf0od57vWzU7yqIIbPhn9LfQpqRxMcSwD+7A8lb89Azbp/uIeoIhb0zNbJ1
	34oigXPf6BORX6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFA2F13A1F;
	Mon, 31 Mar 2025 09:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6IeNmln6mdWWwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 31 Mar 2025 09:59:05 +0000
Message-ID: <39586553-6185-4b83-b18a-3716caf2f3cf@suse.cz>
Date: Mon, 31 Mar 2025 11:59:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
Content-Language: en-US
To: Sebastian Sewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
 <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
 <CAADnVQKBg0ESvDRvs_cHHrwLrpkar9bAZ9JJRnxUwe4zfGym6w@mail.gmail.com>
 <20250331071409.ycI7q6Q2@linutronix.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250331071409.ycI7q6Q2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C0BC1F38D
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
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,linux-foundation.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/31/25 09:14, Sebastian Sewior wrote:
> On 2025-03-30 14:49:25 [-0700], Alexei Starovoitov wrote:
>> On Sun, Mar 30, 2025 at 1:56 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> > So maybe "nmisafe_local_lock_t" or something in that vein?
>> >
>> > Please fix this up, There aren't *that* many users of
>> > "localtry_xyzzy", let's get this fixed before there are more of them.
>> 
>> Ok. Agree with the reasoning that the name doesn't quite fit.
>> 
>> nmisafe_local_lock_t name works for me,
>> though nmisafe_local_lock_irqsave() is a bit verbose.
>> 
>> Don't have better name suggestions at the moment.
>> 
>> Sebastian, Vlastimil,
>> what do you prefer ?
> 
> nmisafe_local_lock_t sounds okay assuming the "nmisafe" part does not
> make it look like it can be used without the trylock part in NMI context.

Yes I was going to point out that e.g. "nmisafe_local_lock_irqsave()" seems
rather misleading to me as this operation is not a nmisafe one?

I think it comes back to what we discussed in previous versions of the
patchset. IMHO conceptually it's still a local_lock, it just supports the
new trylock operations. However, to make them possible (on non-RT) if a
particular lock instance is to be used with the trylock anywhere, it needs
the new "acquired" field, and for the non-trylock operations to work with
the field too.

So (to inform Linus) the earlier attempt [1] was to just change the existing
local_lock_t, but that adds the overhead of the field and manipulating it
for instances that don't use trylock.

The following attempt [2] meant there would be only a new local_trylock_t
type, but the existing locking operations would remain the same, relying on
_Generic() parts inside them.

It was preferred to make the implementation more obvious, but then we have
the naming issue for the operations in addition to the type...

[1]
https://lore.kernel.org/bpf/20241218030720.1602449-4-alexei.starovoitov@gmail.com/
[2]
https://lore.kernel.org/bpf/20250124035655.78899-4-alexei.starovoitov@gmail.com/

> But yeah, it sounds better than the previous one.
> 
> Sebastian


