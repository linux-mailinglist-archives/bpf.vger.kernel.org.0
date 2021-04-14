Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B68A35FD9A
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhDNWOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhDNWON (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 18:14:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEEFC061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 15:13:49 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z1so23868953ybf.6
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hcFNhfCPuiPp0Zw1rcJthyvw70wB45+iiHa2uoLrR/s=;
        b=iwau7NMvDhFPUTfj3XKwevx9TDcmUXTYEFyaK4BOvlZxv7O9ulCQO+1dR0RuiaVBio
         7AIzaY4WvtwAn/eExrw7QEDtu4hhWilLimM/QvqOwHh1frU6/nf3h5QBy3JCxF36Znxa
         e+1UzDYKKkObMWgD4iIrMwVt+1kPa/HmqNLwOwdlf2kTiC4gP6mMv2GjAQvdUX8DKZKC
         41cIljVnrCLciODzwmjGkMfe0O14ZvxlhEIZmQZsaYAMVyEp64kHCerDhaSGXC61DYPy
         Gb0infALqCMejll33YNcLgHZgHZPYBaDTBp6uMogWvFUa+DVFy+iEMeu+ka86c46pmad
         Dl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hcFNhfCPuiPp0Zw1rcJthyvw70wB45+iiHa2uoLrR/s=;
        b=GH5NgAsQEfsCLMwrn32gl4TyevJ5vEhkLNesCsP2ig5Zu3RmHKW4iMXh2a8nvw0w2B
         NZckKz3AEoPLjstF2yLsBSSBscunHDwpSiuYukyKFHcHKzfoW/4/TNzj6NT4jAwZn1zu
         Y5fmWqkEgm6Xzaf5vnw3LQEOf7i/5hnsA5AEJQitjVQ2lveaoVmSjUbcA8DAGPb1fnpU
         gOluEoFcFXLOVd7Vy+ztKqcb11ov81gmAMgwoBUjrMPWhLcQDDLGpWpySBP6v1vq0r3r
         AGxxJvE96WCm0wTY3iRfFx8EmwdCf4RIY8R5Jt4CL1+OFGSHeAbS6jlz3ZAu3f9UqbWF
         AgLQ==
X-Gm-Message-State: AOAM531cY3NjQ0Yi0JOnDsmMyRxbYsnn1MOAPP5vAjq871zWF6B8zQqg
        dUZNxsWl6Gy5WfDOT7AeMnjl2Tk+tf2z+5HNXnc=
X-Google-Smtp-Source: ABdhPJyWQlMd+4yquZ9q03+VZ2aBIaA38mLPZgVU7sqQfVwH0D9gDN8+IVSehMiN8+dh9DRRVlt3gMb6s0TuKyRubRM=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr199223ybf.425.1618438429081;
 Wed, 14 Apr 2021 15:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk> <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1> <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
 <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1> <87czuwlnhz.fsf@toke.dk>
 <20210414184133.GW4510@paulmck-ThinkPad-P17-Gen-1> <87a6q0llou.fsf@toke.dk> <20210414212502.GX4510@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210414212502.GX4510@paulmck-ThinkPad-P17-Gen-1>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 15:13:38 -0700
Message-ID: <CAEf4BzZ=oFbTaS2DPOry8jbunb2Qtu4omF3VsYMNJ5_8VNHoQw@mail.gmail.com>
Subject: Re: Selftest failures related to kern_sync_rcu()
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 2:25 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Wed, Apr 14, 2021 at 09:18:09PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> >
> > > On Wed, Apr 14, 2021 at 08:39:04PM +0200, Toke H=C3=B8iland-J=C3=B8rg=
ensen wrote:
> > >> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > >>
> > >> > On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrote=
:
> > >> >> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >> >> >
> > >> >> > > > > >                 if (num_online_cpus() > 1)
> > >> >> > > > > >                         synchronize_rcu();
> > >> >> >
> > >> >> > In CONFIG_PREEMPT_NONE=3Dy and CONFIG_PREEMPT_VOLUNTARY=3Dy ker=
nels, this
> > >> >> > synchronize_rcu() will be a no-op anyway due to there only bein=
g the
> > >> >> > one CPU.  Or are these failures all happening in CONFIG_PREEMPT=
=3Dy kernels,
> > >> >> > and in tests where preemption could result in the observed fail=
ures?
> > >> >> >
> > >> >> > Could you please send your .config file, or at least the releva=
nt portions
> > >> >> > of it?
> > >> >>
> > >> >> That's my understanding as well. I assumed Toke has preempt=3Dy.
> > >> >> Otherwise the whole thing needs to be root caused properly.
> > >> >
> > >> > Given that there is only a single CPU, I am still confused about w=
hat
> > >> > the tests are expecting the membarrier() system call to do for the=
m.
> > >>
> > >> It's basically a proxy for waiting until the objects are freed on th=
e
> > >> kernel side, as far as I understand...
> > >
> > > There are in-kernel objects that are freed via call_rcu(), and the id=
ea
> > > is to wait until these objects really are freed?  Or am I still missi=
ng
> > > out on what is going on?
> >
> > Something like that? Although I'm not actually sure these are using
> > call_rcu()? One of them needs __put_task_struct() to run, and the other
> > waits for map freeing, with this comment:
> >
> >
> >       /* we need to either wait for or force synchronize_rcu(), before
> >        * checking for "still exists" condition, otherwise map could sti=
ll be
> >        * resolvable by ID, causing false positives.
> >        *
> >        * Older kernels (5.8 and earlier) freed map only after two
> >        * synchronize_rcu()s, so trigger two, to be entirely sure.
> >        */
> >       CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
> >       CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
>
> OK, so the issue is that the membarrier() system call is designed to forc=
e
> ordering only within a user process, and you need it in the kernel.
>
> Give or take my being puzzled as to why the membarrier() system call
> doesn't do it for you on a CONFIG_PREEMPT_NONE=3Dy system, this brings
> us back to the question Alexei asked me in the first place, what is the
> best way to invoke an in-kernel synchronize_rcu() from userspace?
>
> You guys gave some reasonable examples.  Here are a few others:
>
> o       Bring a CPU online, then force it offline, or vice versa.
>         But in this case, sys_membarrier() would do what you need
>         given more than one CPU.
>
> o       Use the membarrier() system call, but require that the tests
>         run on systems with at least two CPUs.
>
> o       Create a kernel module whose init function does a
>         synchronize_rcu() and then returns failure.  This will
>         avoid the overhead of removing that kernel module.
>
> o       Create a sysfs or debugfs interface that does a
>         synchronize_rcu().
>
> But I am still concerned that you are needing more than synchronize_rcu()
> can do.  Otherwise, the membarrier() system call would work just fine
> on a single CPU on your CONFIG_PREEMPT_VOLUNTARY=3Dy kernel.

Selftests know internals of kernel implementation and wait for some
objects to be freed with call_rcu(). So I think at this point the best
way is just to go back to map-in-map or socket local storage.
Map-in-map will probably work on older kernels, so I'd stick with that
(plus all the code is there in the referenced commit). The performance
and number of syscalls performed doesn't matter, really.

>
>                                                         Thanx, Paul
