Return-Path: <bpf+bounces-70799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FDBD1E86
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 523424ECA93
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EEB2EB858;
	Mon, 13 Oct 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LqT5YqsW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vgVVVQMS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oEiSGFhA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7whrss6A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4E2AEF5
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342554; cv=none; b=g7ZhQRhosuhFLimNpPt4hrUDSczvkQqG8q4FQVoqP1bUHcIXIYHgXUiDz6ytmpapHbMs+GH8Dngnur+YEe2e/R3Qc3GsSihUP8Ys9VbFswnlwuzmtTpuMfxO7NPfyCnrSbSWwlehyae74YvKnf8RF/VUUB4L1FwBZ7w1COAq3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342554; c=relaxed/simple;
	bh=8y7npeoubO3H8H77lKJkzLHi0X3x+Hnyl5zda7h0GE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/frnBAkPNxi8Uqfx3acBnu5La5q6yFj0jJH+GGERdUDpPRxPi5l5CEw4oLvarp1bD4QUL/KH1kNJFjSiypf0FK3PMQRGE8mG0u/8eobX3zjSeBu347qqIArTLNiNp4ODJb7i0EWhbtOlja56oHGGmf9UX205Kli4wLtS0zwvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LqT5YqsW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vgVVVQMS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oEiSGFhA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7whrss6A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C9F21F798;
	Mon, 13 Oct 2025 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SMGMAUukUxpNjNcKVJwA9a+7Snorm+D13jrnLntxKU=;
	b=LqT5YqsWJ0Vgpux0nxYmAAOYFr7l3RBYqrewCzQXffUENxnRGvclxlDr6L6nV8PBlATwcI
	xc6u+Giab0ktqrnOdOOzmAGYZhnH7m8cusJJJ0QBQxgpWA30Ca2WUNXCjrSlPpShILrmq2
	xzoXL6BivvfunDbvRHAZd9hnJ9rcfdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SMGMAUukUxpNjNcKVJwA9a+7Snorm+D13jrnLntxKU=;
	b=vgVVVQMSlR9JSz7QkBw/COiNTfIyqbaJ8RZ/R+ae7iRS9uxPJ6wOrtgrUUCYf6+4m1syfh
	WxQLeoRnDQ+a9nBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oEiSGFhA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7whrss6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SMGMAUukUxpNjNcKVJwA9a+7Snorm+D13jrnLntxKU=;
	b=oEiSGFhAR2iiY5Lfsas+XhOzSRRyNJtHAnV8zGMdHGiFSVvDG4LKwwTjR+UuZchXcSP8pX
	vCGSl1eG4qMWBOV0FROTQ1vgbsbCM/BgWN9aNu20FXoPGBoYJDNYyyPm6O+NTAaEwt5P4s
	h+DkDrUvD+BV+CX5rsIuSQqEFhkGkH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SMGMAUukUxpNjNcKVJwA9a+7Snorm+D13jrnLntxKU=;
	b=7whrss6AXT0MVcTpt+7UM2abqodWxJ7/XZDk2FsS83j5C8mKART2fb8FVK8G4vJODeCGMG
	JOXtoO6uOci1yWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96E9A13874;
	Mon, 13 Oct 2025 08:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gq0FIhOy7GjQEwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Oct 2025 08:02:27 +0000
Date: Mon, 13 Oct 2025 10:02:25 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	syzbot <syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <jackmanb@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Michal Hocko <mhocko@suse.com>,
	Network Development <netdev@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Vlastimil Babka <vbabka@suse.cz>, ziy@nvidia.com,
	bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __set_page_owner (2)
Message-ID: <aOyyER1uSsPl5b7a@localhost.localdomain>
References: <68e7e6ad.a70a0220.126b66.0043.GAE@google.com>
 <20251009165241.4d78dc5d9fa5525d988806b5@linux-foundation.org>
 <CAADnVQK_8bNYEA7TJYgwTYR57=TTFagsvRxp62pFzS_z129eTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK_8bNYEA7TJYgwTYR57=TTFagsvRxp62pFzS_z129eTg@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5C9F21F798
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5bcbbf19237350b5];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,localhost.localdomain:mid,storage.googleapis.com:url,syzkaller.appspot.com:url,suse.de:dkim,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[8259e1d0e3ae8ed0c490];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -2.01

On Thu, Oct 09, 2025 at 05:26:21PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 9, 2025 at 4:52 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 09 Oct 2025 09:45:33 -0700 syzbot <syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    2c95a756e0cf net: pse-pd: tps23881: Fix current measuremen..
> > > git tree:       net
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16e1852f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5bcbbf19237350b5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8259e1d0e3ae8ed0c490
> > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/8272657e4298/disk-2c95a756.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/4e53ba690f28/vmlinux-2c95a756.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6112d620d6fc/bzImage-2c95a756.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com
> >
> > At 2c95a756e0cf, page_owner.c hasn't been modified in a couple of years.
> >
> > How can add_stack_record_to_list()'s spin_lock_irqsave() be "invalid
> > wait context"?  In NMI, yes, but the trace doesn't indicate that we're
> > in an NMI.
> >
> > Confused.  I'm suspecting BPF involvement.  Cc'ed for help, please.
> 
> The attached patch should fix it.
> There are different options, but this one is the simplest.

Seems quite trivial to backport, so:

Reviewed-by: Oscar Salvador <osalvador@suse.de>




-- 
Oscar Salvador
SUSE Labs

