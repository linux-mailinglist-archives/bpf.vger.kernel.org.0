Return-Path: <bpf+bounces-56774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732CA9DA22
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8CE1BA5C1B
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159F22370A;
	Sat, 26 Apr 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="BsxY6/GI"
X-Original-To: bpf@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977454A11;
	Sat, 26 Apr 2025 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664158; cv=none; b=jkrEgYtmaNdaL4wx5jQuQAYANyKXlrRliBcZ1Va7ODWBx8bVHQWMpJhC68cyLLjPJbnlFthhle7qw8hjP40aX2p9PTz7KxiY2Bw5xQHWWP/S84yOjqxwAiieM4LS/K8WN6bnXWX4uIqQG2loULH66HZMBz6CkRwt5vjNCJGRvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664158; c=relaxed/simple;
	bh=syAC0nIhx/IzZ9cs+2fbRHm/RrvyLvqr234Zh1733+Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cMJGG8d5WEDQqsYYr/qGqJ+PtY+qCdJaRP5bJCSJa+YZzBKdILg+bJ9jEU3MmFD3Davu+Q5lM5dPDxuUsWk7CIOYr/EIMtSTXsQ0GouQnhu1ya4kS1/Z89b5RZN21AYfGn+RjLpcEyBRyucnlKJGjZeQeyLz9vZEktFARbCop1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=BsxY6/GI; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tta21mMLGTn3K2tn7y/mZmOLIBCqpI/zDg0q/+0iZrY=;
  b=BsxY6/GIz4yYQnPeJ4rraSi74jJFmOXgRQ8FBe86HvDPPB6vsN02m5e1
   tm8WoafQPSrgoQtF4FVmIWrpJIFS7IWaPEgAHQ+Ey0tpQCzaDNhoKTbvO
   oqMz/3NLoFM5mf0TL+f7gIfxzN+r5KGhZ8Zh+qReTtC5gIXzG9NDu/BC/
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.15,241,1739833200"; 
   d="scan'208";a="219554437"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 12:41:23 +0200
Date: Sat, 26 Apr 2025 12:41:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Andrew Morton <akpm@linux-foundation.org>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
    Kees Cook <kees@kernel.org>, bpf@vger.kernel.org, 
    Tejun Heo <tj@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Subject: Re: [RFC][PATCH 0/2] Add is_user_thread() and is_kernel_thread()
 helper functions
In-Reply-To: <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
Message-ID: <alpine.DEB.2.22.394.2504261157210.3375@hadrien>
References: <20250425204120.639530125@goodmis.org> <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 25 Apr 2025, Andrew Morton wrote:

> On Fri, 25 Apr 2025 16:41:20 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > While working on the deferred stacktrace code, Peter Zijlstra told
> > me to use task->flags & PF_KTHREAD instead of checking task->mm for NULL.
> > This seemed reasonable, but while working on it, as there were several
> > places that check if the task is a kernel thread and other places that
> > check if the task is a user space thread I found it a bit confusing
> > when looking at both:
> >
> > 	if (task->flags & PF_KTHREAD)
> > and
> > 	if (!(task->flags & PF_KTHREAD))
> >
> > Where I mixed them up sometimes, and checked for a user space thread when I
> > really wanted to check for a kernel thread. I found these mistakes before
> > sending out my patches, but going back and reviewing the code, I always had
> > to stop and spend a few unnecessary seconds making sure the check was
> > testing that flag correctly.
> >
> > To make this a bit more obvious, I introduced two helper functions:
> >
> > 	is_user_thread(task)
> > 	is_kernel_thread(task)
> >
> > which simply test the flag for you. Thus, seeing:
> >
> > 	if (is_user_thread(task))
> > or
> > 	if (is_kernel_thread(task))
> >
> > it was very obvious to which test you wanted to make.
>
> Seems sensible.  Please consider renaming PF_KTHREAD in order to break
> missed conversion sites.

Maybe:

@r depends on !(file in "include/linux/sched.h")@ // Kees's suggestion
position p;
expression e;
@@

(
e = (PF_KTHREAD | ...)
|
e |= (PF_KTHREAD | ...)
|
PF_KTHREAD@p
)

@script:ocaml@ // change to python if desired
p << r.p;
@@

Printf.printf "%s:%d: Warning: remaining use of PF_KTHREAD\n" (List.hd p).file (List.hd p).line

julia


