Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C566029917D
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784511AbgJZPyg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 11:54:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43670 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784513AbgJZPyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 11:54:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so10719456ljg.10
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9BpXZd1dePTO41DoQrRpftD/OWsykwv67IUek0mRlE=;
        b=ds1ibtfW9ahR96Tlz4l3O2V/NUXaipvZr+aslTh6VXSfEM3kHadDmcLxHX3+fim6vJ
         XY0aMB/b/crNHJ+KYUBJZ9iGD5uXLpL3GlW/LXPeqfuahvJ/oHJALa+ujnz4qCr+aF3G
         r3YPp5iqz7DHWZi7sVTcnGmjsSpbh0UvP+A1D/jSGedwgiDcEzQA2CCrlL6Pp0TOOfRR
         YMZcHkmybCLa/INJ/1vhYw0788bYvORlLQPrQTIeXQW7YGQIcVcM1gEQN52jutOBxAoP
         ZwBh7dYIIgqLz9FcZRZd4P1UVyI45sguGjVKNUDIESjDnNWyFcFcsZjbvjMRfKowcfFd
         EtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9BpXZd1dePTO41DoQrRpftD/OWsykwv67IUek0mRlE=;
        b=ALd95UmbRX/iUZ767jHNYekCWYsqCVU5WUaeZYQ3AvN6NalZENr1jUI94ijJovk6zI
         8SduA9f8+9su+06GHtR3VcGYoEFv29Yw8ZKkYyBXpExkeFkmuU/Kn4GVtQ0TGfqHZdyy
         J9V09mSTHEK4gZkPDW8BEpo8ySQPnLdJyHlIZGWqDConYZ1tFUYuonq6ra/BiDDTdEfR
         0/iJJ1YW6wKbK5DtYEQ3iSdLVQdOGupmEKy9ShsMuJqLxeJjwUMRPlQlrnlWd6OwbHYi
         DrNeS1oS1dKLUeliwbjStHjX8Y5oSlJO3mo9tJSn8cJesfg4kX6BhZDhOG9/KD2YYUFQ
         OE6w==
X-Gm-Message-State: AOAM532EwByebPrK5GtbNt/5rXlfjh+BqwVrnFuXL1VLYsEn1qrxQiFZ
        X5QvnQS5GQQMkazhuMSh9TpcBPA8TLNfpRdVmJ9CsA==
X-Google-Smtp-Source: ABdhPJyfsg6Pn+1Y835UYicEETWbwyo+C5rrlUHlNo3ycyK5+vUjxRkzYBMWwSKKTQZitV4IVanOMj2G237Mp8vT7As=
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr5972527lji.326.1603727672694;
 Mon, 26 Oct 2020 08:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com> <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com>
In-Reply-To: <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 26 Oct 2020 16:54:05 +0100
Message-ID: <CAG48ez2Uy8=Tz9k1hcr0suLPHjbJi1qUviSGzDQ-XWEGsdNU+A@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 25, 2020 at 5:32 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/1/20 4:14 AM, Jann Horn wrote:
> > On Thu, Oct 1, 2020 at 3:52 AM Jann Horn <jannh@google.com> wrote:
> >> On Thu, Oct 1, 2020 at 1:25 AM Tycho Andersen <tycho@tycho.pizza> wrot=
e:
> >>> On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
> >>>> On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza> wr=
ote:
> >>>>> On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-page=
s) wrote:
> >>>>>> On 9/30/20 5:03 PM, Tycho Andersen wrote:
> >>>>>>> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pa=
ges) wrote:
> >>>>>>>>        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >>>>>>>>        =E2=94=82FIXME                                           =
     =E2=94=82
> >>>>>>>>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >>>>>>>>        =E2=94=82From my experiments,  it  appears  that  if  a  =
SEC=E2=80=90 =E2=94=82
> >>>>>>>>        =E2=94=82COMP_IOCTL_NOTIF_RECV   is  done  after  the  ta=
rget =E2=94=82
> >>>>>>>>        =E2=94=82process terminates, then the ioctl()  simply  bl=
ocks =E2=94=82
> >>>>>>>>        =E2=94=82(rather than returning an error to indicate that=
 the =E2=94=82
> >>>>>>>>        =E2=94=82target process no longer exists).               =
     =E2=94=82
> >>>>>>>
> >>>>>>> Yeah, I think Christian wanted to fix this at some point,
> >>>>>>
> >>>>>> Do you have a pointer that discussion? I could not find it with a
> >>>>>> quick search.
> >>>>>>
> >>>>>>> but it's a
> >>>>>>> bit sticky to do.
> >>>>>>
> >>>>>> Can you say a few words about the nature of the problem?
> >>>>>
> >>>>> I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("secco=
mp:
> >>>>> notify about unused filter"). So maybe there's a bug here?
> >>>>
> >>>> That thing only notifies on ->poll, it doesn't unblock ioctls; and
> >>>> Michael's sample code uses SECCOMP_IOCTL_NOTIF_RECV to wait. So that
> >>>> commit doesn't have any effect on this kind of usage.
> >>>
> >>> Yes, thanks. And the ones stuck in RECV are waiting on a semaphore so
> >>> we don't have a count of all of them, unfortunately.
> >>>
> >>> We could maybe look inside the wait_list, but that will probably make
> >>> people angry :)
> >>
> >> The easiest way would probably be to open-code the semaphore-ish part,
> >> and let the semaphore and poll share the waitqueue. The current code
> >> kind of mirrors the semaphore's waitqueue in the wqh - open-coding the
> >> entire semaphore would IMO be cleaner than that. And it's not like
> >> semaphore semantics are even a good fit for this code anyway.
> >>
> >> Let's see... if we didn't have the existing UAPI to worry about, I'd
> >> do it as follows (*completely* untested). That way, the ioctl would
> >> block exactly until either there actually is a request to deliver or
> >> there are no more users of the filter. The problem is that if we just
> >> apply this patch, existing users of SECCOMP_IOCTL_NOTIF_RECV that use
> >> an event loop and don't set O_NONBLOCK will be screwed. So we'd
> >> probably also have to add some stupid counter in place of the
> >> semaphore's counter that we can use to preserve the old behavior of
> >> returning -ENOENT once for each cancelled request. :(
> >>
> >> I guess this is a nice point in favor of Michael's usual complaint
> >> that if there are no man pages for a feature by the time the feature
> >> lands upstream, there's a higher chance that the UAPI will suck
> >> forever...
> >
> > And I guess this would be the UAPI-compatible version - not actually
> > as terrible as I thought it might be. Do y'all want this? If so, feel
> > free to either turn this into a proper patch with Co-developed-by, or
> > tell me that I should do it and I'll try to get around to turning it
> > into something proper.
>
> Thanks for taking a shot at this.
>
> I tried applying the patch below to vanilla 5.9.0.
> (There's one typo: s/ENOTCON/ENOTCONN).
>
> It seems not to work though; when I send a signal to my test
> target process that is sleeping waiting for the notification
> response, the process enters the uninterruptible D state.
> Any thoughts?

Ah, yeah, I think I was completely misusing the wait API. I'll go change th=
at.

(Btw, in general, for reports about hangs like that, it can be helpful
to have the contents of /proc/$pid/stack. And for cases where CPUs are
spinning, the relevant part from the output of the "L" sysrq, or
something like that.)

Also, I guess we can probably break this part of UAPI after all, since
the only user of this interface seems to currently be completely
broken in this case anyway? So I think we want the other
implementation without the ->canceled_reqs logic after all.

I'm a bit on the fence now on whether non-blocking mode should use
ENOTCONN or not... I guess if we returned ENOENT even when there are
no more listeners, you'd have to disambiguate through the poll()
revents, which would be kinda ugly?

I'll try to turn this into a proper patch submission...
