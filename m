Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD436D3C6
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhD1IS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 04:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhD1IS5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 04:18:57 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EAC06138A
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 01:18:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k25so62305323oic.4
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YTrfob6P6zzC8aXEunzXLUOwk7qpHbcRbQ3sHEGAGI=;
        b=KcF92B5WtEXaqweynQ3beawG/4jC+fJUKiBJErUOLSrVTR7P/T3+noJZGR9sfZHfeE
         rCwoFVOXaUuPdSFjs9G0zBF8QlI9brCPN1jHJlCgIfJjdW13hPkhOjBepQ0F6vblyosE
         Fi6wuv6B7QP1SfQqh12985hzP7/bGDMx1inwfrQxdVMibui/oBYRbpNzeSJLx8l4eDPj
         w8AZfzOhhUryHMsaVuP9Eom4CuoZ4wTSHeft1SzuEEzau6shOwyZohMWsC0p/jR57Vm5
         xQCrM0paYd31A7UOQNIverysqYeuCeiYjAv4C84AG5TfuQ81/QN1TuJPOCNmgPNXiore
         f5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YTrfob6P6zzC8aXEunzXLUOwk7qpHbcRbQ3sHEGAGI=;
        b=qObKNPm1wg23pi48UoLgakGXXcH8fhtuZwgtxWjSMMMEBLEqkqC5hhqAlrIHEq4Cwh
         KiA2rXxEqs/tAimgK7PQ1YBOLWirEpJMUaXBDt0A3ibpSLF3n++ex0WLSFQs5AyLb/0L
         G85MVf1uL5taFPqoz8JnDCcs2XK21OSCVc3cwd46DFBbCfaMP0ciCoEjePcWKuE/qxyU
         5l+AS6n8o4wnWmMeZKDcCos4yAZZhLGzLwI24AJB/JP+b8OH4/c+ubUJ/r+gLx2C9uCI
         CPRG23tl9v+L7cdyYmg49UKr8o2lVKK+vX/c8rOGCSfTQ4Yas9+4ErB4e8IeYozPUKE0
         ffzg==
X-Gm-Message-State: AOAM5309HJ2xi6sTqm0MTEGNq+t/MyDHhFOlZPsk56VBl62MMAykXGeI
        dBErf7gvPk14xO22AKAwTWyB+sNGK1gMTD5tn34KebSnyaGSCA==
X-Google-Smtp-Source: ABdhPJxgVKIvTbSoIhoIhmCiQYRpY9snoNmhchOKqCzYss7z2RuFwwa/Rhr/Dp9oFpDYlCTffC2s96FRGc3rZsRselU=
X-Received: by 2002:a54:4704:: with SMTP id k4mr1876288oik.127.1619597891309;
 Wed, 28 Apr 2021 01:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210427170859.579924-1-jackmanb@google.com> <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
 <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com> <CAEf4Bzb+OGZrvmgLk3C1bGtmyLU9JiJKp2WfgGkWq0nW0Tq32g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+OGZrvmgLk3C1bGtmyLU9JiJKp2WfgGkWq0nW0Tq32g@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 28 Apr 2021 10:18:00 +0200
Message-ID: <CA+i-1C2bNk0Mx_9KkuyOjvQh_y7KFrHBU-869P+8oTFq8HdVcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 28 Apr 2021 at 01:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 4:05 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Tue, Apr 27, 2021 at 11:34 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Apr 27, 2021 at 10:09 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > >
> > > > One of our benchmarks running in (Google-internal) CI pushes data
> > > > through the ringbuf faster than userspace is able to consume
> > > > it. In this case it seems we're actually able to get >INT_MAX entries
> > > > in a single ringbuf_buffer__consume call. ASAN detected that cnt
> > > > overflows in this case.
> > > >
> > > > Fix by just setting a limit on the number of entries that can be
> > > > consumed.
> > > >
> > > > Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
> > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > ---
> > > >  tools/lib/bpf/ringbuf.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > > index e7a8d847161f..445a21df0934 100644
> > > > --- a/tools/lib/bpf/ringbuf.c
> > > > +++ b/tools/lib/bpf/ringbuf.c
> > > > @@ -213,8 +213,8 @@ static int ringbuf_process_ring(struct ring* r)
> > > >         do {
> > > >                 got_new_data = false;
> > > >                 prod_pos = smp_load_acquire(r->producer_pos);
> > > > -               while (cons_pos < prod_pos) {
> > > > +               /* Don't read more than INT_MAX, or the return vale won't make sense. */
> > > > +               while (cons_pos < prod_pos && cnt < INT_MAX) {
> > >
> > > ring_buffer__pool() is assumed to not return until all the enqueued
> > > messages are consumed. That's the requirement for the "adaptive"
> > > notification scheme to work properly. So this will break that and
> > > cause the next ring_buffer__pool() to never wake up.

Ah yes, good point, thanks.

> > > We could use __u64 internally and then cap it to INT_MAX on return
> > > maybe? But honestly, this sounds like an artificial corner case, if
> > > you are producing data faster than you can consume it and it goes
> > > beyond INT_MAX, something is seriously broken in your application and

Yes it's certainly artificial but IMO it's still highly desirable for
libbpf to hold up its side of the bargain even when the application is
behaving very strangely like this.

[...]

> I think we have two alternatives here:
> 1) consume all but cap return to INT_MAX
> 2) consume all but return long long as return result
>
> Third alternative is to have another API with maximum number of
> samples to consume. But then user needs to know what they are doing
> (e.g., they do FORCE on BPF side, or they do their own epoll_wait, or
> they do ring_buffer__poll with timeout = 0, etc).
>
> I'm just not sure anyone would want to understand all the
> implications. And it's easy to miss those implications. So maybe let's
> do long long (or __s64) return type instead?

Wouldn't changing the API to 64 bit return type break existing users
on some ABIs?

I think capping the return value to INT_MAX and adding a note to the
function definition comment would also be fine, it doesn't feel like a
very complex thing for the user to understand: "Returns number of
records consumed (or INT_MAX, whichever is less)".
