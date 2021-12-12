Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A1471CC6
	for <lists+bpf@lfdr.de>; Sun, 12 Dec 2021 20:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhLLTqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Dec 2021 14:46:44 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:41776 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhLLTqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Dec 2021 14:46:44 -0500
Received: by mail-yb1-f182.google.com with SMTP id v138so33670858ybb.8
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SDkMrf6FVyV+N8LvQW9R6sXmXRdOyXWu//BQMjikS5A=;
        b=OI3AizEM7GeVOHXptHH58WgwsnRaokZdaIT2L3LQrSPFEzJ7y8qqEaTgVB9F2lGtWi
         hQ6vz12ZGxwqvJr6yLmBXQmgGVl3IGWGOKELGbDdDDf+7rdolxHQKZ/EPHlU5Tn77qCi
         DX+htVmNjVG3L6/IqYPDyot+vt0hG7ESqW31eo3L+90wpp7HZ65D1Wdry9ocrm0pTGzw
         AcIKe7D48RzSxRZAusi0oi35Rp8Z4eRw2t+qqjj+vo+q4hzL48+JukTnKAibL9vlX9AQ
         85cMemCggTqMlNrocwYFy0fkOxaaiS4RIJxFLlUWvbE70a+k9AHVNwvNZ+CflJ0neYRx
         TqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SDkMrf6FVyV+N8LvQW9R6sXmXRdOyXWu//BQMjikS5A=;
        b=rQpG55K+dm/K3LPmOpHgjPB59c2RESh1LLYisBLDXjKvdxfbqnwEeyLhHYn+GZPY0c
         gB+yD0fg4W6DzOHjDw/li1TWvZksWuEA5pTPSu4SX7bNkZ8jcgfuFyrwg7R6Fscc7OEy
         CBd5KKFTaErOHAwMmksMuYpSSCW3c5Q4r2m8UlHlAbybCDSxB+AY1tG0vLSLM9E88jTm
         JrAAIlinR+fnTbVxEM4+pObPhbkh/+YrXfjyGGdpDxnagTkvYo9A/oW9yTfZFxr61NUB
         gyIeyLaKeySgFXNXxdIR+7XjG11W79pvODrdEGyiDOy9jpu+ZS6AMYPrYuBopG7PuRCP
         fEVw==
X-Gm-Message-State: AOAM531oYUkyKlxHEhP7B5O2ZXbKmEeeBEGtV1G/rhLf3Q1ZhWwV1Zi8
        LlIm/fY0pwaKYqa7jYxIG+EOWb+B5vo1Fs4cqes=
X-Google-Smtp-Source: ABdhPJzfm5L/F2cxMrz6MuORFE3xnMEqrRe8mtzsVBs3PIrLTtHUtYGSQCETzhUGAiAgg8YP1rtEccE32+hzf0dwLbA=
X-Received: by 2002:a25:2a89:: with SMTP id q131mr31322385ybq.436.1639338343593;
 Sun, 12 Dec 2021 11:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20211210201333.896276-1-andrii@kernel.org> <20211210201333.896276-2-andrii@kernel.org>
 <87ilvvue6a.fsf@toke.dk> <CAADnVQKrOC0Qm8gNrxOk715Kg_iUK2F8PmyN2DvgWOze9Xq0KA@mail.gmail.com>
In-Reply-To: <CAADnVQKrOC0Qm8gNrxOk715Kg_iUK2F8PmyN2DvgWOze9Xq0KA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 12 Dec 2021 11:45:32 -0800
Message-ID: <CAEf4BzaT1uHD8qA=Vfq_OJpFcrzbdpcHBoCd2tWMeXE-z77fLw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 11, 2021 at 6:23 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Dec 11, 2021 at 11:36 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >
> > Andrii Nakryiko <andrii@kernel.org> writes:
> >
> > > The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
> > > one of the first extremely frustrating gotchas that all new BPF users=
 go
> > > through and in some cases have to learn it a very hard way.
> > >
> > > Luckily, starting with upstream Linux kernel version 5.11, BPF subsys=
tem
> > > dropped the dependency on memlock and uses memcg-based memory account=
ing
> > > instead. Unfortunately, detecting memcg-based BPF memory accounting i=
s
> > > far from trivial (as can be evidenced by this patch), so in practice
> > > most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
> > >
> > > As we move towards libbpf 1.0, it would be good to allow users to for=
get
> > > about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustme=
nt
> > > automatically. This patch paves the way forward in this matter. Libbp=
f
> > > will do feature detection of memcg-based accounting, and if detected,
> > > will do nothing. But if the kernel is too old, just like BCC, libbpf
> > > will automatically increase RLIMIT_MEMLOCK on behalf of user
> > > application ([0]).
> > >
> > > As this is technically a breaking change, during the transition perio=
d
> > > applications have to opt into libbpf 1.0 mode by setting
> > > LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
> > > libbpf_set_strict_mode().
> > >
> > > Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
> > > with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
> > > nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
> > > called before the first bpf_prog_load(), bpf_btf_load(), or
> > > bpf_object__load() call, otherwise it has no effect and will return
> > > -EBUSY.
> > >
> > >   [0] Closes: https://github.com/libbpf/libbpf/issues/369
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > The probing approach breaks with out-of-order backports, I suppose.
> > Hopefully no one will do those for that particular patch, though (it's
> > not really a bugfix), and at least for RHEL we did backport them
> > together.
> >
> > Can't think of any better ways of doing the detection either, but maybe
> > something to be aware of in the future (i.e., "don't change things in a
> > way that can't be detected from userspace")?

Initial version of memcg changes was supposed to return 0 memlock
value, when queried for BPF map. But it was decided to output some
approximation instead, so that one convenient way to detect this was
removed. I agree that kernel changes should show more care for
user-space detection in cases like this.

> >
> > Anyway, with the nits below:
> >
> > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >
> > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > index 6b2407e12060..7c82136979bf 100644
> > > --- a/tools/lib/bpf/bpf.c
> > > +++ b/tools/lib/bpf/bpf.c
> >
> > [...]
> >
> > > +     /* attempt loading freplace trying to use custom BTF */
> > > +     memset(&attr, 0, bpf_load_attr_sz);
> > > +     attr.prog_type =3D BPF_PROG_TYPE_TRACING;
> > > +     attr.expected_attach_type =3D BPF_TRACE_FENTRY;
> >
> > This comment also seems to be disagreeing with the code it's commenting
> > on?
> >

That's what I get for writing comments. Will fix it up, thanks for spotting=
.

> > [...]
> >
> > > +static bool memlock_bumped;
> > > +static rlim_t memlock_rlim_max =3D RLIM_INFINITY;
> > > +
> > > +int libbpf_set_memlock_rlim_max(size_t memlock_max)
> > > +{
> > > +     if (memlock_bumped)
> > > +             return libbpf_err(-EBUSY);
> > > +
> > > +     memlock_rlim_max =3D memlock_max;
> > > +     return 0;
> > > +}
> > > +
> > > +int bump_rlimit_memlock(void)
> > > +{
> > > +     struct rlimit rlim;
> > > +
> > > +     /* this the default in libbpf 1.0, but for now user has to opt-=
in explicitly */
> > > +     if (!(libbpf_mode & LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK))
> > > +             return 0;
> > > +
> > > +     /* if kernel supports memcg-based accounting, skip bumping RLIM=
IT_MEMLOCK */
> > > +     if (memlock_bumped || kernel_supports(NULL, FEAT_MEMCG_ACCOUNT)=
)
> > > +             return 0;
> > > +
> > > +     memlock_bumped =3D true;
> > > +
> > > +     /* zero memlock_rlim_max disables auto-bumping RLIMIT_MEMLOCK *=
/
> > > +     if (memlock_rlim_max =3D=3D 0)
> > > +             return 0;
> > > +
> > > +     rlim.rlim_cur =3D rlim.rlim_max =3D memlock_rlim_max;
> > > +     if (setrlimit(RLIMIT_MEMLOCK, &rlim))
> > > +             return -errno;
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> > "rlim_max" seems to imply this will only ever increase the limit, but i=
f
> > I'm reading the code correctly it could actually end up lowering the
> > effective limit?
>
> _max suffix is confusing to me as well.
> libbpf_set_memlock_rlim() would be more accurate.

The thinking was that we bump rlim_max value with setrlimit(), but
yeah, I'm totally fine naming it as libbpf_set_memlock_rlim(), I'll
update in the next revision.

>
> The other part of the patch:
> +               /* assume memcg accounting is supported if we get -ENOTSU=
PP */
> +               err =3D errno =3D=3D 524 /* ENOTSUPP */ ? 1 : 0;
>
> is dangerous.
> ENOTSUPP is not a standard error code.
> The kernel returns it from a few places, but we might fix
> all of them eventually and return EOPNOTSUPP everywhere.
> In other words user space cannot rely on this 524 error code number.

I can check both ENOTSUPP and EOPNOTSUPP, if the error code is the
concern. Worst case, even if this check breaks, we'll just do
setrlimit() unnecessarily, which the user can prevent with
libbpf_set_memlock_rlim(0), if they know that all supported systems
they expect to run on have memcg accounting for BPF. If not, they
should be fine with setrlimit() anyways (or prevent it explicitly, for
libbpf 1.0 mode).
