Return-Path: <bpf+bounces-66867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B7B3A85C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 19:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B47C37A3
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48677338F22;
	Thu, 28 Aug 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7vDYOmg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1F21B9F1
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402765; cv=none; b=aD+uMNzp1kYkBlQyopHZHYyFSXvUP4l70jvt8D97uuCf+18rNZuV6Vrv3vopDAQHkLrrrG6ZfYfpNG+1/bjj57+LVxD/LTrCDoBK4FXa3r9j2OBxbkqA/YSpHHErH4SfkVf83GpzpYMvuRySutKCSuU0wRzangh3IRsq2ve6ePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402765; c=relaxed/simple;
	bh=Vz7dZ9XpwA8N7+YhHCRhQgw1f+83rsvEBddQl+9Q6tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYrQGvTdf8fypJmYKDS2w383qrpWjS4EzopZ0YRLyRo8PPsqnet6sBXgmyFJHNO5bowbRlzbBqDCkHDcxrEQTb3wToOMMr22V2t6oFEfPlgFFibBM8+eVlWyFFXToCMiNJc0e0PSnR5uhB+fNU/aINhiI0w1uOtC4YMpwL7lBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7vDYOmg; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so1630970a12.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402762; x=1757007562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz7dZ9XpwA8N7+YhHCRhQgw1f+83rsvEBddQl+9Q6tU=;
        b=R7vDYOmg6v/D5Qimn2ZgHssgHyAKqtRtEG+ffb/iZBepW2EUOWZ8b4LVp+Ap7RAETX
         IhwZHEnMvJxRz8JQnm9STCAs/KFreQsE+rGe/FYL70PzaPeCompQe2VDD5XXjYsCnA97
         v40ByROlC1aRU4aYtkN0VbQL96YKMJQ07OMVqniWijPAyZsom/uzPHwhSyuAqtZzKUjd
         RyO0LyfZRDsWuQDPhivrTKv2Vn/W75pZu1X0XQjKRjbeRUTxom8TnyV8ubmFZQfchhWd
         k6xCoUwTMC9R5XOi576XIdLRYsC55eQzvPsV995zIr5kXZfrNge/9C4yZAJoz8xoBuEK
         oljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402762; x=1757007562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vz7dZ9XpwA8N7+YhHCRhQgw1f+83rsvEBddQl+9Q6tU=;
        b=Wm6OL4E9zPqcoaYXtnwFUSf0UfQwjn1xX/k7MWbC0+AYmVjF7N1BQZe9dnjvsTy3xT
         julWhWxWGe7ueGfbi8pHdTULFpf8R5PCFC0Ijo3KFVsmAUeZ2VDuUDh1GNNQwrh8/TwP
         FXuATflcxhdbL3QSVA+2/d3KvUm6Tx7s2TVq/leAf/8eOJ87iARTPV6Vy62OzR8mPkf5
         UrnaZSJbNLw/7V5YLkjeuetyx0bpfC+EGWTRWOUjN3paX/CzElfX+s7U9YiNwc0q3BaK
         b3GjaK6ARPV1iTT1nubx1J6b7eJ12uedFjtQf/5khUqm9RerwN+U35uDNJJLOv1reS7Y
         PJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCW1c7v6i6+P1kYhrwief/dzHppavr7GUxtRsXNCMkf7rU8sgiXPfGmMc2ZeqKLxrK+sFYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4c0HEmLoZDip1lzNgZg67MnAumobirrOuBTQorpaFOsJ7GQow
	dYOdcZE2S7gSY/pVi4uXy1lBIzXg89aS6z3zrauLR4HaVON7NN+OhFUzSvirM3o20ifLoZXvTBn
	3G/xO3n9mKY0G4z8KzPblkpnpJ1VjWwQ=
X-Gm-Gg: ASbGncv0gfpo7BOg3c0HV2IE4XWPkjL4ONgNdLn0Tfxu3CzVxwYQMBm6nU8UHqrvKGO
	o47DtfWkOC6W62J5XyIL1mQfhtlttKsC6s1FQP5I8RA6rII62izoY93k6H1r8kZCV2fVuXzajAC
	R/NORcTM3+twiqJZqAmg9faKyqkRd79TRbk9nzrBw0ZFFRmeJdnG9OJGRsIuRP1iZkTR2q8hSef
	PgJt7dh4dlUWWuALNXfTVbnuUpiPj2XBjK9QI6e8NGR5dRHY7K00o6zkRxu1w==
X-Google-Smtp-Source: AGHT+IEX9DO+UtOuaooWy1HBUBR39g5nYhsTD4SnfYDcvdOQqfD5hTcq5nGLmoRscaFZyMWqcr4u6c1SbJj26ZUQxlM=
X-Received: by 2002:a05:6402:84a:b0:61c:1a89:5d71 with SMTP id
 4fb4d7f45d1cf-61c1b7056d2mr18088209a12.36.1756402762052; Thu, 28 Aug 2025
 10:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
 <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com> <CAP01T74vkbS6yszqe4GjECJq=j5-V7ADde7D6wnTfw=zN8zJyw@mail.gmail.com>
 <CAEf4BzZPcawkrrdd2OoKLT-BWzCYsEpNxw52RKa6dL1B=xvdoA@mail.gmail.com>
 <CAP01T74gKna6WrgZvkoBBmwsbhrqrv4azeKwfk=frQasc9eaXQ@mail.gmail.com>
 <CAEf4BzZadH9NYkYSrgUvZAynBuG=t2TayhFPxzFzbWHsP8HCUw@mail.gmail.com>
 <CAADnVQLCg0KAo-uPL+nmYzwRJDcm0W5w_2=0p1PBgi=pUEONLw@mail.gmail.com> <CAEf4BzagzR6xbbMJn7TQaCeP4trgv4wgWM-tUQYrMutRfx+qUw@mail.gmail.com>
In-Reply-To: <CAEf4BzagzR6xbbMJn7TQaCeP4trgv4wgWM-tUQYrMutRfx+qUw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Aug 2025 19:38:45 +0200
X-Gm-Features: Ac12FXz3td4foUaIMTqLShS10b14pssAJycqeGQaeQyjFafc-7ltHEFBo6GvO6k
Message-ID: <CAP01T77xFRLHj_irvbEr6KaOAcu=GUVr2Hb5Bbf_nB4PhkT9iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Aug 2025 at 19:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Wed, Aug 27, 2025 at 6:34=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Aug 20, 2025 at 11:33=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > >
> > > I don't see why we can't consolidate internals of all these async
> > > callbacks while maintaining a user-facing API that makes most sense
> > > for each specific case. For task_work (and yes, I think for timers it
> > > would make more sense as well), we are talking about a single
> > > conceptual operation: just schedule a callback. So it makes sense to
> > > have a single kfunc that expresses that.
> > >
> > > Having a split into init, set_callback, kick is unnecessary and
> > > cumbersome.
> >
> > For timers the split api of init vs start_timer is mandatory,
> > since it's common usage to start and stop the same timer before
> > it fires. So the moving init operation (which allocates) and
> > set_callback operation (that needs a pointer to callback)
> > out of start/stop is a good thing, since the code that does start/stop
> > may be far away and in a different file than init/set_callback.
>
> Ok, that makes sense, thanks for filling in the context.
>
> > That's how networking stack is written.
> > Where I screwed things up is when I made bpf_timer_cancel() to also
> > clear the callback to NULL. Not sure what I was thinking.
> > The api wasn't modelled by existing kernel timer api, but
> > by how the networking stack is using timers.
> > Most of the time the started timer will be cancelled before firing.
> > bpf_wq just followed bpf_timer api pattern.
> > But, unlike timers, wq and task_work actually expect the callback
> > to be called. It's rare to cancel wq/task_work.
> > So for them the single 'just schedule' kfunc that allocates,
> > sets callback, and schedules makes sense.
> > For wq there is no bpf_wq_cancel. So there is a difference already.
> > It's fine for bpf_timers, bpf_wq, bpf_task_work to have
> > different set of kfuncs, since the usage pattern is different.
> >
>
> agreed
>
> > Regarding state machine vs spinlock I think we should see
> > through this approach with state machine.
> > And if we convince ourselves that after all reviews it
> > looks to be bug free, we should try to convert timer/wq
> > to state machine as well to have a shared logic.
>
> yep, completely agree
>
> > Note irq_work from nmi is mandatory for timers too
> > regardless of state machine or rqspinlock,
> > since timers/wq take more locks inside,
> > We cannot rqspinlock() + hrtimer_start() unconditionally.
>
> Ack. Once we unify all this, we can invest a bit more effort trying to
> optimize away the need for irq_work when not under NMI (and maybe not
> in irq). For timers this seems more important than for task_work, as
> timers can be used significantly more frequently.

Ok, let's go with this approach. I'll take a stab at addressing timers
later on once Mykyta's set lands.

>
> But one step at a time, let's wait for Mykyta to come back from
> vacation and update the patch set.

