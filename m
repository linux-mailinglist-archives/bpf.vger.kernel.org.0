Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F105D46C7BB
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 23:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhLGWwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 17:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhLGWwL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 17:52:11 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E73C061574
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 14:48:40 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id j2so1464242ybg.9
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XunNJHFCGrApJ4vVn54kJNYlCPw3st1O4JQE8k/XVQU=;
        b=lIUq2J9PVo9xBRmAuFM7Eggm+Gnuz/23oZbAFhEB3GRniMdcQL6g5FJTpwbQENHdcp
         eup9GTAK12aOrI1H91mr12KxMVS7BP9tYypdkm2ZfjfPZCVek13ysPcySKeBgKqIp8fS
         ESQI+Bd4eML7A3dx3Hl6pWmlh28KPZpB0CaGrLx1jYHPUSCVOFNOdDSsmrQPvYi88HRF
         20v3wBihDGfMjeUwCCtCElN68OkrESLGFSfur8U3+AygblFaehQeF7bXJU2HiYPymOe8
         0vBbQQC0zNsY+SXxtAtRHMf3X/buVjNYRddktb3bPciXjbmsUzJGsloDuHfanC4lUlz5
         fJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XunNJHFCGrApJ4vVn54kJNYlCPw3st1O4JQE8k/XVQU=;
        b=EiUeAhyujMpjWWBujRzhLqCJZCyvveTm/c3BwtV+Ebtd4l1SLmQb6BHPWqLJXltOcs
         rWYvka0B6wI1m8S1QBVSyRH+z0jOMyba3BILuuWjfo7cRloYujKSDJRerfIeoqS78Jw2
         a5u9qAfWoTNZP+zA1thN0a0TDtOjWBva9asljjpOEWAcampOwD9OGTqUA6AmiQH0LKK6
         fnTPgrkllRpNrB9ZfO19U3e+zFwAD6UmtmNi3nPVrQzgz5fkmpApLsMuOrqe5uk5MfEw
         PYBTFw9BdwsGCz7mt0ZrDV/JBdXUQM8l8YeulE7pWXBU54bSTcvvyXBusY6TuY3qhGbl
         kMHA==
X-Gm-Message-State: AOAM533u8qm23JzkS4O6JeCpklbxNLOaoaKxhuzikKVpvrdN6HVeywnh
        3/57YrYlDxQ3rLJRpcuJ1TtxCLRHtM2W9e35jtc=
X-Google-Smtp-Source: ABdhPJwUvq6s2SAkQgFh20PxQ8RCakx2ERqo+2Jacr+qJpTK8K2dNESNSRCIi34Ch20Oh5MHwUxsA6neiqJQpWj+1eI=
X-Received: by 2002:a25:3c9:: with SMTP id 192mr55708538ybd.766.1638917319593;
 Tue, 07 Dec 2021 14:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20211205203234.1322242-1-andrii@kernel.org> <20211205203234.1322242-7-andrii@kernel.org>
 <20211207194120.2qfa5i6s43djdeqy@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211207194120.2qfa5i6s43djdeqy@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Dec 2021 14:48:28 -0800
Message-ID: <CAEf4Bza6CZyPLN=KxjxjwV4RHqMOLqCNwxouo85+weiuGu4-4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/11] libbpf: add per-program log buffer setter
 and getter
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 7, 2021 at 11:41 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Dec 05, 2021 at 12:32:29PM -0800, Andrii Nakryiko wrote:
> >
> > +     ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
> >       if (ret >= 0) {
> > -             if (log_buf && load_attr.log_level) {
> > +             if (log_level && own_log_buf) {
> >                       pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
> >                                prog->name, log_buf);
> >               }
> > @@ -6690,19 +6720,20 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
> >               goto out;
> >       }
> >
> > -     if (!log_buf || errno == ENOSPC) {
> > -             log_buf_size = max((size_t)BPF_LOG_BUF_SIZE,
> > -                                log_buf_size << 1);
> > -             free(log_buf);
> > +     if (log_level == 0) {
> > +             log_level = 1;
> >               goto retry_load;
> >       }
>
> I think the new log_level semantics makes sense,
> but can we do it only in one layer?
> The above piece of bpf_object_load_prog_instance() will change log_level,
> but then bpf_prog_load_v0_6_0() will do it again
> when log_buf != NULL.
> The latter will not malloc log_buf, but the former will.
> Though both change log_level.
> Can we somehow unify this logic and only do log_level adjustment and log_buf
> alloc in bpf_object_load_prog_instance() only ?

Ok, so I'm trying to understand what you are proposing. log_buf is
allocated only in bpf_object_load_prog_instance, so the "alloc in
bpf_object_load_prog_instance()" already works like that, right?

As for log_level, that bump from log_level 0 to log_level 1 on error
is already part of bpf_prog_load() behavior. But it only happens if
you pass log_level=0 and non-NULL log_buf. Which
bpf_object_load_prog_instance() won't do, so
bpf_object_load_prog_instance() doesn't rely on bpf_prog_load()'s
retry logic.

Speaking of which, though, bpf_prog_load()'s logic is kind of broken
as well, as log_level=0 and log_buf != NULL will be immediately
rejected by kernel with -EINVAL.

So I think the right change here would be to adjust bpf_prog_load()
such that it doesn't pass log_buf if log_level == 0 and on error
retries with log_level = 1 and log_buf passed. With that it will be
consistent between low-level and high-level logging behavior.

Is this what you are proposing?

>
> > +     /* on ENOSPC, increase log buffer size, unless custom log_buf is specified */
> > +     if (own_log_buf && errno == ENOSPC && log_buf_size < UINT_MAX / 2)
> > +             goto retry_load;
>
> The kernel allows buf_size <= UINT_MAX >> 2.
> Above condition will probably get to the same value, but it's not obvious.
> Maybe make it exactly as kernel?

UINT_MAX >> 2 isn't specified as part of UAPI, so it can change in the
future. Why hard-coding unspecified limit if the logic will work for
any supported value (within 32 bits). And given the kernel limit is
smaller, we'll get -EINVAL (not -ENOSPC) before we try to allocate a
way too big buffer that has no chance of working.

>
> > -     if (log_buf && log_buf[0] != '\0') {
> > +     if (own_log_buf && log_buf && log_buf[0] != '\0') {
> >               pr_warn("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
> >                       prog->name, log_buf);
> >       }
> > @@ -6712,7 +6743,8 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
> >       }
> >
> >  out:
> > -     free(log_buf);
> > +     if (own_log_buf)
> > +             free(log_buf);
>
> For lksel I'm thinking to pass allocated log_buf back.
> lskel has no ability to printf from inside of it, so log_buf has to be passed back.
> I wonder whether it would make sense for libbpf as well?
> The own_log_buf flag can be kept in bpf_program and caller can
> examine the log_buf instead of doing bpf_program__set_log_buf() below...

If user doesn't set log_buf explicitly, libbpf's behavior is to emit
log through print callback. In the solution you are proposing, it's
not clear how libbpf should decide whether to allocate and keep local
log_buf or emit everything through print callback.

>
> > +int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
> > +{
> > +     if (log_size && !log_buf)
> > +             return -EINVAL;
> > +     if (prog->log_size > UINT_MAX)
> > +             return -EINVAL;
> > +     if (prog->obj->loaded)
> > +             return -EBUSY;
> > +
> > +     prog->log_buf = log_buf;
> > +     prog->log_size = log_size;
> > +     return 0;
> > +}
>
> The problem with this helper is that the user would have to malloc
> always even though the prog might load just fine.
> But there is a chance of load failure even in production,
> so the user would have to rely on libbpf printfs and override print func
> or do prog_load without bpf_program__set_log_buf() and then do it again on error
> or always do bpf_program__set_log_buf() with giant malloc.
> All of these 3 options are not that great.

"libbpf printfs and override print func" is what happens right now and
it actually works very well and is super useful. I expect in most
cases people will keep doing just that, as it's a no-brainer. I've
added bpf_program__set_log_buf() mostly for local development use
cases, when it's useful to investigate how the program is verified and
what BPF assembly code is generated before it goes into production. So
I disagree about "not that great".

As for addressing giant malloc. If that's really a problem for
someone, I'd recommend to allocate a big static uninitialized buffer
(16MB or so) that is passed to bpf_program__set_log_buf() or
bpf_object_open_opts.kernel_log_buf. If there are no failures, this
buffer won't ever be touched, which means that that memory won't be
even paged in by the kernel and won't count against process memory
footprint.

> The 4th option is for libbpf to do a malloc in case of error and return it.
> That's the most convenient:
> err = ...prog_load(..)
> if (err) // user will check what's in the log.
> No need to override libbpf print, unconditionally allocated or do double load.

I'm not optimizing for "no need to override libbpf print", that's what
essentially every BPF application is doing anyways to control
verboseness of libbpf log output. It works great and is no problem at
all. With auto-allocated and kept log_buf the problem is that it's not
really obvious that there is such a log buf at all . And if that log
isn't emitted through libbpf's print callback by default, there will
be more cases in production where we don't even capture any details
about load failure.

I understand you'd like to align libbpf's API with lskel's API, but I
think that's not the case where they have to match 100%. With lskel
there is no standard library log output interface that you can use. If
you had, I'd argue that emitting the verifier log through it would be
the best default as well.
