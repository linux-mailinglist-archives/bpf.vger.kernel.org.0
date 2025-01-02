Return-Path: <bpf+bounces-47772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7469FFF90
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96259160727
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E11ACEAC;
	Thu,  2 Jan 2025 19:44:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8735282E1;
	Thu,  2 Jan 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847079; cv=none; b=ZLE49uI6Q1Dip6nywcGU+k7WPBjPoFKSDRNYhhJeatmeIFojPaII5wRSKLaEsxgxX2dKfv3w2oiWET3X4TwQ2Z9tALe1XJK1E+ExktIRZDjKvWXmRGp5JKV3RhrGZHdIirlflbXEOWN9fTce5LltKqLiY1hyBipk/atYwGvoyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847079; c=relaxed/simple;
	bh=ymhbIz9ABthbuh24LukHUSSunmEcnI46LpWdJPRm7fs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMZVdlDtESAgyxjlw/KGFms2ZPw70JHy7UC7qVLIGpdaMZUd7rvcMNu3hhzUO+d2k8R2VjTTpIZqKz6ASXgPckXbu0Cab4pf9UijKw31DunrJxAKaZ0DWRD9Nl8dd6vJDaoApfBrb/TwEw08jrOTCdWodLlaqXkRExM6cWfQwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8603CC4CED6;
	Thu,  2 Jan 2025 19:44:37 +0000 (UTC)
Date: Thu, 2 Jan 2025 14:45:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250102144553.5b32b0f3@gandalf.local.home>
In-Reply-To: <CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
References: <20250102185845.928488650@goodmis.org>
	<CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 11:30:12 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Please just do this by sorting non-existent functions at the end,
> instead of just zeroing them out.
> 
> That makes the mcount_loc table dense in valid entries. We could then
> just rewrite the size of the table (or just add a variable containing
> the size, if you don't want to change ELF metadata - but you're
> already sorting the table, so why not?)
> 
> Because:
> 
> > Then on boot up, when creating the ftrace tables from the mcount_loc
> > table, it will ignore any function that matches the kaslr_offset()
> > value.  
> 
> Why even do that? Why not just make the mcount_loc table be proper in
> the first place.

I was a bit nervous about changing the stop_mcount_loc value. I thought of
doing that first, but then I noticed that the value is found by looking at
the System.map file and not from the object itself. Changing it in the
object will require some more elf parsing. Just zeroing out didn't require
that.

I'm fine with adding that, but it will take some more elf foo magic, and my
time to work on this is coming near its end.

To do this, I believe the symbol table will need to be searched for the
__stop_mcount_loc. This could be a clean up as well, as I don't really like
that the code does a search of System.map, and reading it from the object
file may be more robust. Then when we have the values from the object file,
we should also be able to modify it.

-- Steve

