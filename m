Return-Path: <bpf+bounces-45416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E3E9D5529
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D44B22504
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 22:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692211DA103;
	Thu, 21 Nov 2024 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEV++uf/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C81A4F20
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226683; cv=none; b=oFKhoFR9h+AJPbk/Cmw0TmD3iJCE3RPljoevlXtP6B6idADyYduQR0MwTQ7qjgTSYp0PFra5gwQbVv61VKp/S2jzAHXbNwYg1SyHiaIQimENLSlT2cYcMvoRgMUPVrdQSN28BUCbi+nV+bhe4zDSZi5BN3feUXPysB1lSOqPUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226683; c=relaxed/simple;
	bh=t2L/E3UzzPDfVQBhWoWgRtWph1B81U74fF5oxgYLAXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJBBO+tNt+QLuDy4fFUpKgpY2UmVzLRddqXXIBbAhdmmpcSO4OSwgFb+YmWz2r5ILUyMwnuNJPP4mXyHPo7Y7zGMMKFTxZ0XSDgABZwrROjHMOTkGbbdE0B5j23LrhNm5re2JOKV0J0AA+R3QUPfskaMICQUdSKx6A6cNjszC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEV++uf/; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso16639731fa.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 14:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732226679; x=1732831479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FTwkHWmFvIQbSA3h/UlfgB5YmwFsTo2G+wVmtp+thOo=;
        b=IEV++uf/sGQe1skm0LLC/2YCtWO8l6i4ljPuIo2wr2EfOu01fsKxvMJEWiZo9vrlG+
         Y0KGXKyBZbyVWZbRC/TuMQ0hNB0As6Fls5pnH+YLlnqowBOjhAeUX+5POxoEP35ynKHn
         jXAU376P9P8wME3vT3gnPlL5L2lQtVwNnxRr5u822DY49F7G9U4UyIxO7WOlnnsrCoTl
         wNyyj9AmTGWNUOaWv9Fmm9ES0kEGC7I1qAolb0SNWBq+rmwqnyhRuCqO51/FpTXFGmwP
         Vi55r+9+Y54j+yKdBLkS5/FPu1r8K7zW5XtKgJiLkm4mOl5obLDumBUIXAxrms1aj8dj
         QYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226679; x=1732831479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTwkHWmFvIQbSA3h/UlfgB5YmwFsTo2G+wVmtp+thOo=;
        b=kAHvcZErwkrC91l1Czk22Z7LKO9LhekhoOig6hmXofxKCkFZGpj2Uv8WrjxFYE1mPX
         2O5v3t4bUcJ8nR1o0P8Mwg4Fgrhp1pmQFEgU65Ggg4/jn6KRTWFNR9YgXysIe0jb9J7k
         ekBKS9roUmH8H9XN9Qusvn3+vg92YJXSXpd0NwUpSV0Lt3cIxMoB7vJ32fenD3Ko/AbB
         6mU7bMtZW+MR3fxsnjAtiUNLEkVaQyv/19R2PZ/9jlJkedNfY2hPjBgXQlFFygbNK8xr
         WgnXrAdstIcS4xJBpGd5Idj1vnYnw4DDvXmecS5+qkLCVLvTXKhQ/kU5tpmyQZ/mLS9M
         VyLw==
X-Gm-Message-State: AOJu0YwT26b37vPbVXViZJg1EVD7FWODeIVpttFu3e2Yk8g6ARVKbcdM
	FE7rwViv50vrkRmJJJANfhzI9NEZaQbYs7kADE9OF5HHofEWVskxrDLzEvdyqqfjpkcEAYmeJPB
	cJ45XsEBtwhU4k9uCI5qWleyjOWw=
X-Gm-Gg: ASbGncvUSv1+1Mavjk9e84P+aqx5bdeZ+e3w/7paFdBUObGp0vS9JeukoL5eKxGs2Qd
	tPLuz4cyAhLIHaYZy+LVwUli1W4vrQvwgsQ==
X-Google-Smtp-Source: AGHT+IFu8z6QrbDoj5HJD7GbFewvB/cHK/UqheHny7FjniEKcrvS+3o/Phh1Kuv1mq18++lvHe0sRI+1CDXqfF5Zapc=
X-Received: by 2002:a05:651c:b0f:b0:2fb:65c8:b4ae with SMTP id
 38308e7fff4ca-2ffa71a7b98mr1630521fa.31.1732226678975; Thu, 21 Nov 2024
 14:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-4-memxor@gmail.com>
 <dfe594d893ce83a3be0ddaa3559043908465eaec.camel@gmail.com>
 <CAP01T75sz0YB7dj3fchyw-E2kjftaewcXhWJP_=hf_OBnWBDQA@mail.gmail.com> <763a88cb28f66ac5c62ddbeef763b77fc6833418.camel@gmail.com>
In-Reply-To: <763a88cb28f66ac5c62ddbeef763b77fc6833418.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Nov 2024 23:04:02 +0100
Message-ID: <CAP01T766TUw03pB2B9GMX61_6N1m4xLKJht74dgsC96sp9A7_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Consolidate RCU and preempt locks in bpf_func_state
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 19:54, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-11-21 at 19:12 +0100, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 21 Nov 2024 at 19:09, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > > > To ensure consistency in resource handling, move RCU and preemption
> > > > state counters to bpf_func_state, and convert all users to access them
> > > > through cur_func(env).
> > > >
> > > > For the sake of consistency, also compare active_locks in ressafe as a
> > > > quick way to eliminate iteration and entry matching if the number of
> > > > locks are not the same.
> > > >
> > > > OTOH, the comparison of active_preempt_locks and active_rcu_lock is
> > > > needed for correctness, as state exploration cannot be avoided if these
> > > > counters do not match, and not comparing them will lead to problems
> > > > since they lack an actual entry in the acquired_res array.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > >
> > > This change is a bit confusing to me.
> > > The following is done currently:
> > > - in setup_func_entry() called from check_func_call():
> > >   copy_resource_state(callee, caller);
> > > - in prepare_func_exit():
> > >   copy_resource_state(caller, callee);
> > >
> > > So it seems that it is logical to track resources in the
> > > bpf_verifier_state and avoid copying.
> > > There is probably something I don't understand.
> > >
> >
> > This is what we were doing all along, and you're right, it is sort of
> > a global entity.
>
> Right, but since this patch-set does a refactoring,
> might be a good time to change.
>
> > But we've moved active_locks to bpf_func_state, where references reside, while
> > RCU and preempt lock state stays in verifier state. Either everything
> > should be in
> > cur_func, or in bpf_verifier_state. I am fine with either of them,
> > because it would
> > materially does not matter too much.
> >
> > Alexei's preference has been stashing this in bpf_func_state instead in [0].
> > Let me know what you think.
> >
> >   [0] https://lore.kernel.org/bpf/CAADnVQKxgE7=WhjNckvMDTZ5GZujPuT3Dqd+sY=pW8CWoaF9FA@mail.gmail.com
>
> As far as I understand check_func_call(), function calls to static
> functions are allowed while holding each kind of resources currently
> tracked. So it seems odd to track it as a part of function state.
> The way I understand Alexei in the thread [0] the idea is more
> to track all counters in one place.
>
> Let's wait what Alexei has to say.
>

Discussed with Alexei (who discussed with you I presume) that we're
doing this in bpf_verifier_state, will fix.

