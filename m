Return-Path: <bpf+bounces-47269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770029F6CD6
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 19:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8001887EDA
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACE1FA270;
	Wed, 18 Dec 2024 18:03:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D21494BB;
	Wed, 18 Dec 2024 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545030; cv=none; b=bCgNKNNZkSMGrX8BUCkVvhjogSaEnqbytfrPfSbZdWizQD7mqqP1gRWf9l0yq0HfhTMKhcOgsTUoCSg8OT4DgvajJ9zPx60ey4W7+4d+8vPI8NlN0IuDt9PWVgS+UnH099432s1pkTSyE7W4hC3QjaiAlrVlBU2ii4pgrObwHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545030; c=relaxed/simple;
	bh=VAB5fxzZ2x0IXVN/AdagorPOX5h+p2+m2KJSDx33UJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSyet6FUcNLCKzVO26QNRwzMIdPKB5vpauljM48SzcRT49xc6rY9q5d9WCOLo3b+SxRj56ATs/kBmGnwsAPad+qRBt3CxHRLlgbbqT2LyIXXXBAmbOfjGq2XPHe07peVrY47ijodW3AcXeoJBOXxqJDdC8TH9NkStl1LUJaXPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0274C4CECD;
	Wed, 18 Dec 2024 18:03:49 +0000 (UTC)
Date: Wed, 18 Dec 2024 13:04:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Florent Revest <revest@google.com>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: simplify number handling
Message-ID: <20241218130427.16c062e3@gandalf.local.home>
In-Reply-To: <CAHk-=whbzEO5sHk777FGWcCjDnX2QLBLX9XszEVh5GnSp+8RWw@mail.gmail.com>
References: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
	<20241218013620.1679088-1-torvalds@linux-foundation.org>
	<20241218103218.7dc82306@gandalf.local.home>
	<CAHk-=whbzEO5sHk777FGWcCjDnX2QLBLX9XszEVh5GnSp+8RWw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 09:32:45 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> As you also point out with your tracing test:
> 
> >         modprobe-905   [003] .....   113.624842: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338e760 buf=ARRAY[]
> >         modprobe-905   [003] .....   113.624843: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338ec40 buf=ARRAY[]
> >         modprobe-905   [003] .....   113.624843: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338e280 buf=ARRAY[]
> >
> > Those "[FAILED TO PARSE]" messages have nothing to do with your code, but
> > it means that it doesn't handle 'h' at all. Even the "unsigned short"
> > printed but still failed to parse properly.  
> 
> Yeah, %h{d,u} and %hh{d,u} are not hugely common, and apparently it's
> not just your tracing tools that don't understand them: Alexei
> reported that the bpf binary printk code also refused them.
> 
> That said, they *do* exist in the kernel, including in tracing:
> 
>     git grep 'TP_printk.*".*%hh*[ud].*"'
> 
> doesn't return lots of hits, but does report a handful.

Those are not processed by vbin_printf() or bstr_printf() the TP_printk()
of the event is a simple vsnprintf() and is executed on the read side.

The TP_printk() macro is basically translated into:

	trace_event_printf(iter, print);

Where that "print" is the TP_printk() passed to TRACE_EVENT(). And that's
the function that I was fixing:

void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	trace_check_vprintf(iter, trace_event_format(iter, fmt), ap);
	va_end(ap);
}

So, if vsnprintf() handles anything, so does TP_printk(). Nothing to do
with the binary formatting.

> 
> > This is because libtraceevent appears to not support "%h" in print formats.
> > That at least means there would be no breakage if they are modified in any
> > way.  
> 
> Oh, %hd is not getting modified (and if I did, that would be a major bug).
> 
> It's very much a part of the standard printf format, and is very much
> inherent to the whole varargs and C integer promotion rules (ie you
> literally *cannot* pass an actual 'char' value to a varargs function -
> the normal C integer type extension rules apply).
> 
> So this is not really some odd kernel extension, and while there are
> only a handful of users in tracing (that apparently trace-cmd cannot
> deal with), it's not even _that_ uncommon in general:

trace-cmd (and libtraceevent for that matter) does handle "%h" and "%hh"
as well.

But the vbin_printf() which trace_printk() uses is a different beast, and
requires rebuilding the arguments so that it can be parsed, and there "%h"
isn't supported.

-- Steve

