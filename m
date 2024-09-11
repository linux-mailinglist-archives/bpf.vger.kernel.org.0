Return-Path: <bpf+bounces-39559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD609747BF
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4B6288AA3
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 01:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44171EB2A;
	Wed, 11 Sep 2024 01:27:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9529CE5;
	Wed, 11 Sep 2024 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018022; cv=none; b=IV+NqC6E1zobc0IpbbAwBpbmj3ocHTO2n48qphkxMeHT94cSJtWWe3k7jhK5vNYJJ62phK+p8b8Jov1iUF4NCGsS1FbzS4UzMGyJsDJyNxTvZSx6HCZydTpHoN7SbntXuiNtLwbRPjkJNTr1hSGmUR6/kkSpHmLvXqCAlvf0e+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018022; c=relaxed/simple;
	bh=xLdCjw7FOqQYI5zYv1X09+FdDa064DOtOHyioer0Id8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEX3Q2oXG9OeSu1ilzPa2VNH6/QbIgkQT8/dX6x3M0nZzLIiFUJjCCxaTlpjMuoJaXVsamzcxg/If0HBWoMZrtk32o6o9J+VdlSgyZZC1UJOPOX0lEJk+mzDSN3azvgyYkdjQfn+xZz410GscvN4csYmoGBnZxPC1Ge6FIircdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C93DC4CEC3;
	Wed, 11 Sep 2024 01:27:00 +0000 (UTC)
Date: Tue, 10 Sep 2024 21:27:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-ID: <20240910212702.6679f507@gandalf.local.home>
In-Reply-To: <CAEf4Bzb12RE6QvLLb1ptSedO2Q2zEZCvxM73BcKXUodJpi5tiw@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
	<20240910145431.20e9d2e5@gandalf.local.home>
	<CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
	<20240910182209.65ab3452@gandalf.local.home>
	<CAEf4Bzb12RE6QvLLb1ptSedO2Q2zEZCvxM73BcKXUodJpi5tiw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 17:27:06 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
\> >
> > Why do I have to answer to you? Once I saw the "ARM64" in the subject, it
> > immediately went down in priority and honesty, I didn't even read it as I'm
> > not the ARM64 maintainer. I did skim it to see if my name was mentioned as
> > I usually try to do with emails, but when it wasn't I ignored it.  
> 
> So, in the end, it wasn't "And we are busy getting ready for
> Plumbers.", but rather you didn't find the right keywords in my email,
> right? "Masami" and "Steven" would be the right keywords, but
> "CONFIG_FPROBE" and "CONFIG_RETHOOK" aren't. Good to know.

Yep. I'm Cc'd on approximately 300 emails a day. I don't have time to read
them all.


> > >  
> > > >
> > > > Funny part is, I was just about to start reviewing Masami's fprobe patches
> > > > when I read this. Now I feel reluctant to. I'll do it anyway because they
> > > > are Masami's patches, but if they were yours, I would have pushed it off a
> > > > week or two with that attitude.  
> > >
> > > (I'll ignore all the personal stuff)  
> >
> > Maybe you shouldn't ignore it. If you think you can get answers by jumping
> > immediately to "I'm going to tell on you to Linus", you may want to rethink  
> 
> No I don't, and I'd hate to have to do that. Which is why I didn't CC
> Linus. And I get that stuff slips through sometimes, as I said. But I
> don't get your absolutely overblown reaction to a question born out of
> frustration of being ignored.

My reaction was due to the:

> Does Linus have to be in CC to get any reply here? Come on, it's been
> almost a full week.

Which sounds more of a threat. There's a lot of email I miss. Especially
after I come back from vacation, which BTW I did in this case. I came back
on September 3rd, your email was dated September 4th, I had several
thousand unread emails. I don't have time to read them all, so yeah, I do a
lot of skimming, looking for the meat.

You went from sending an email to threatening Cc'ing Linus because I didn't
jump to reply to you. It took me three full days just to get through my
backlog from vacation, and then I have to deal with the emails coming in
while I'm digging through my backlog.

What pissed me off is that comment makes you sound like you think your
email is more important than all my other email. I could have simply not
told you this, and left out sending that reply, but I figured I'd let you
know what perception you gave to me.

> 
> > your approach. A simple "Hey Steve and Masami, what's going on?" would be
> > the "human" thing to do. Especially since you appear to be mad at us for  
> 
> Don't project, Steven. I'm not mad, though definitely frustrated by a
> very unresponsive ML and its maintainers.
> 
> I tried a "hey Masami" approach in [0], and it didn't help much, unfortunately.
> 
> And it's not the first time I'm ghosted on this mailing list. Would
> you say 4.5 months not getting any reply to [1] is long enough?

I'm "ghosted" all the time with other maintainers. When I ask a question or
something, I will wait a while and send a friendly "ping". It's common
practice.

> Though, let me guess, it's x86-specific and you don't have anything to
> do with this, right? Going forward I'll consult get_maintainer.pl
> every time to check if you are *NOT* responsible for something, my
> bad. I didn't live by get_maintainer.pl up until now.

I'm not saying you had to do that. But you should have done that before
threatening to go over my head.

> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzbbVRGROtRn8PM4h1493avHMggz1kSDDJcaNZ1USO_eVw@mail.gmail.com
>   [1] https://lore.kernel.org/linux-trace-kernel/20240425000211.708557-1-andrii@kernel.org/
> 
> > not replying to an email about code we do not maintain.
> >
> > Sorry, but you're not my boss, I don't have to reply to any of your emails.  
> 
> I didn't say I am, not sure where you got that from. But I did expect
> a bit more ownership from you as a linux-trace tree maintainer. I'm
> sorry.
> 
> >  
> > >
> > > You are probably talking about [0]. But I was asking about [1], i.e.,
> > > adding HAVE_RETHOOK support to ARM64. Despite all your emotions above,
> > > can I still get a meaningful answer as for why that wasn't landed and
> > > what prevents it from landing right now before Masami's 20-patch
> > > series lands?
> > >
> > >   [0] https://lore.kernel.org/linux-trace-kernel/172398527264.293426.2050093948411376857.stgit@devnote2/
> > >   [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
> > >  
> > > >
> > > > Again, just letting you know.  
> >
> > Because [1] isn't something I maintain. So I ignored it.  
> 
> Yes, you are doing a great job at ignoring stuff. That I understood
> very well, thank you.

Yes, it's a balancing act of trying to get stuff done. Every time I focus
on one thing I tend to have to ignore something else.

-- Steve


