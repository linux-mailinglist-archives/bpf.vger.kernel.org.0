Return-Path: <bpf+bounces-70712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F8BCB4CF
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 02:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB611420ADC
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4FC1F4289;
	Fri, 10 Oct 2025 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WylIKI7F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2253A7;
	Fri, 10 Oct 2025 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056869; cv=none; b=EMQjNeSD+hCfmWCnScA2qG05PgxM2XNO9713UmxoYE25pc6IupQI3S1iE7JhsL+LAYaPvzb2dD884oTN0S2DAvsclyqK1aWZ4e860nNDyo0WYYe3xnMuMhxjx8tagxJtvuTqO+yPCEpKoh9hNDfM9pk54K0NypI5qy/a9neACQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056869; c=relaxed/simple;
	bh=BnSjONbuKcjeBcFTrNUoOvLEJVoEpv6o7xyNm2HalOE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bpYQdCzMFTi+CX6e6/4PSKRQtA/y79bLXrCbXCXbbItHuNjJ3xQEMgi3QYQpqYWahcIW1LJJICMkhuw1VJrZ0e0R6+8BCybS2iVq6VG2GxQHmopGGod7gM7i7lQLS0R2GbcKEimHCOP6kUAH7mq4C86T9fnOW7myHLyNKbqsvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WylIKI7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB77BC4CEE7;
	Fri, 10 Oct 2025 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760056869;
	bh=BnSjONbuKcjeBcFTrNUoOvLEJVoEpv6o7xyNm2HalOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WylIKI7Fy3n3Xh5X9qtDDGCGqoynWEeiLmK+Wz2jHSCH9AHpnuFmGh2Qy231Ih+q4
	 VtjkQjobmYiowvOQ4zXxVAPVjCu63wYiZRr5aES7Mhf+DkXZN8DlXUmSu5MReC43wl
	 9OTvy2AqR3jNXvegQt0EloY78lvZmcBIzrQ2BJw4=
Date: Thu, 9 Oct 2025 17:41:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Brendan Jackman <jackmanb@google.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Michal Hocko
 <mhocko@suse.com>, Network Development <netdev@vger.kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Vlastimil Babka <vbabka@suse.cz>,
 ziy@nvidia.com, bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __set_page_owner (2)
Message-Id: <20251009174108.ad6fea5b1e4bb84b8e2e223b@linux-foundation.org>
In-Reply-To: <CAADnVQK_8bNYEA7TJYgwTYR57=TTFagsvRxp62pFzS_z129eTg@mail.gmail.com>
References: <68e7e6ad.a70a0220.126b66.0043.GAE@google.com>
	<20251009165241.4d78dc5d9fa5525d988806b5@linux-foundation.org>
	<CAADnVQK_8bNYEA7TJYgwTYR57=TTFagsvRxp62pFzS_z129eTg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 9 Oct 2025 17:26:21 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

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

Cool, thanks.

> From: Alexei Starovoitov <ast@kernel.org>
> Subject: mm: don't spin in add_stack_record when gfp flags don't allow
> Date: Thu, 9 Oct 2025 17:15:13 -0700
> 
> syzbot was able to find the following path:
>   add_stack_record_to_list mm/page_owner.c:182 [inline]
>   inc_stack_record_count mm/page_owner.c:214 [inline]
>   __set_page_owner+0x2c3/0x4a0 mm/page_owner.c:333
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
>   prep_new_page mm/page_alloc.c:1859 [inline]
>   get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
>   alloc_pages_nolock_noprof+0x94/0x120 mm/page_alloc.c:7554
> 
> Don't spin in add_stack_record_to_list() when it is called
> from *_nolock() context.

Seems 6.18 will need this.  Do you think it is needed in earlier kernel
versions?


