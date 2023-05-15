Return-Path: <bpf+bounces-578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B8703FEE
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 23:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3661E1C20B59
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BCB19BC0;
	Mon, 15 May 2023 21:38:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29E18C1B
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 21:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8575CC433D2;
	Mon, 15 May 2023 21:38:25 +0000 (UTC)
Date: Mon, 15 May 2023 17:38:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, David Vernet
 <void@manifault.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230515173822.2e571869@gandalf.local.home>
In-Reply-To: <20230515193532.GA153@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
	<CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
	<20230509130111.62d587f1@rorschach.local.home>
	<20230509163050.127d5123@rorschach.local.home>
	<20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
	<20230515143305.4f731fa9@gandalf.local.home>
	<20230515193532.GA153@W11-BEAU-MD.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 May 2023 12:35:32 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > static int user_event_mm_fault_in()
> > {
> > 	bool unlocked = false;
> > 
> > 	[..]
> > 
> > out:
> > 	if (!unlocked)
> > 		mmap_read_unlock(mm->mm);
> > }
> > 
> > Good catch!
> >   
> 
> I don't believe that's correct. fixup_user_fault() re-acquires the
> mmap lock, and when it does, it lets you know via unlocked getting set
> to true. IE: Something COULD have changed in the mmap during this call,
> but the lock is still held.
> 
> See comments here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/gup.c#n1287

Ah you're right. I thought it said "mmap_read_unlock()" before returning,
but it's actually doing a "mmap_read_lock()". Note, I just got back home
yesterday, so I blame jetlag ;-)

OK, this is good as-is.

The "unlocked" is only if you want to know if the mm_read_lock() was
unlocked in the function. You need to set it if you want it to retry, but
you don't need to initialize it if you don't care if it was released.

Probably could use a comment there.

-- Steve

