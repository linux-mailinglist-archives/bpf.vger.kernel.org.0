Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080754717D2
	for <lists+bpf@lfdr.de>; Sun, 12 Dec 2021 03:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhLLCW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 21:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhLLCW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Dec 2021 21:22:59 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DBBC061714
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 18:22:58 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g19so11919733pfb.8
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 18:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hzocIsdIK8c5gtpe8pGKNmN6LrACE326h1GjJIZQljM=;
        b=ejmhQBWLaOLu0SChLXz8lb1nMhOggC639fw2nKvn+BnTohuRC5n+eKy/1W+Pcr0zwx
         ZMDXhTN/9hgqc7Jr8T/9pslpfFcBxwIECZuClW3/OJZqTAr6IkGFG+AaPchEwJxUe69h
         Fan+iVxGl03PgkKFAnQWKANCHfzkI30Gw68X1zh7gAI6mYQcRjxWrf4vARxRyxAHu0ht
         U5g+99oY81iqRB0sUHSwRa4ETrJZbTcH3UPLo6/WAPHGazolrlb91ttbXgzdexKbMLLh
         e69hGRlrxbbap0h4WUT5JCCVT5v5YP8crbjD3MxGpyw3LsrnnQqJo5uA4R9UC8Jv8bwO
         M36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hzocIsdIK8c5gtpe8pGKNmN6LrACE326h1GjJIZQljM=;
        b=YpXtT5LjwspsimULYLwoGBDmGR+vR/iEhroJjQnCxRchrtIuWm76XGuKMiNcjYjUqj
         2oqJYdaIY1Sw1Lfkayt8Y4AS+voSUgXfg3U5ZePepgzyruAUI4lTvBWOKEQ3LI6O23s+
         a5k9xi8IwDbBunMFwKiTg6hC98Yc5WOCTTqk12HhQZZuWeUWxt6aw75KEhIM9eyjrQAh
         24GSAB64FOZL46pMS3pUdWV2R2OW1jm2bAXa5f5+jxz2JsScO2AcSwOpisZtmfkz9+05
         1I4blU/y4W4/b4zvra5oJQUHHIsKHd3MIYIsMhDnunmS3Kz4h+vvPmWXfXNByk5kbPvL
         PzEw==
X-Gm-Message-State: AOAM531PGKXNFtdPEi6xZeWDvOfHrF41txAjvRU9t+nwMf5CjJUDSVw7
        CavR2XxQAcKZkMFT9kteelQ+FdbCE0i9VTw8SufisEAS4eE=
X-Google-Smtp-Source: ABdhPJyAfQ9OInOma7ZmJb2B9h0O9OUv/ts1ATyugYAynUh9oWKQKV6hqumlFQq/j18YNIwF+EAV3h8w6C43nPyAJyA=
X-Received: by 2002:a63:6881:: with SMTP id d123mr44697385pgc.497.1639275777241;
 Sat, 11 Dec 2021 18:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20211210201333.896276-1-andrii@kernel.org> <20211210201333.896276-2-andrii@kernel.org>
 <87ilvvue6a.fsf@toke.dk>
In-Reply-To: <87ilvvue6a.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 11 Dec 2021 18:22:46 -0800
Message-ID: <CAADnVQKrOC0Qm8gNrxOk715Kg_iUK2F8PmyN2DvgWOze9Xq0KA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 11, 2021 at 11:36 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
> > one of the first extremely frustrating gotchas that all new BPF users g=
o
> > through and in some cases have to learn it a very hard way.
> >
> > Luckily, starting with upstream Linux kernel version 5.11, BPF subsyste=
m
> > dropped the dependency on memlock and uses memcg-based memory accountin=
g
> > instead. Unfortunately, detecting memcg-based BPF memory accounting is
> > far from trivial (as can be evidenced by this patch), so in practice
> > most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
> >
> > As we move towards libbpf 1.0, it would be good to allow users to forge=
t
> > about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
> > automatically. This patch paves the way forward in this matter. Libbpf
> > will do feature detection of memcg-based accounting, and if detected,
> > will do nothing. But if the kernel is too old, just like BCC, libbpf
> > will automatically increase RLIMIT_MEMLOCK on behalf of user
> > application ([0]).
> >
> > As this is technically a breaking change, during the transition period
> > applications have to opt into libbpf 1.0 mode by setting
> > LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
> > libbpf_set_strict_mode().
> >
> > Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
> > with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
> > nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
> > called before the first bpf_prog_load(), bpf_btf_load(), or
> > bpf_object__load() call, otherwise it has no effect and will return
> > -EBUSY.
> >
> >   [0] Closes: https://github.com/libbpf/libbpf/issues/369
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> The probing approach breaks with out-of-order backports, I suppose.
> Hopefully no one will do those for that particular patch, though (it's
> not really a bugfix), and at least for RHEL we did backport them
> together.
>
> Can't think of any better ways of doing the detection either, but maybe
> something to be aware of in the future (i.e., "don't change things in a
> way that can't be detected from userspace")?
>
> Anyway, with the nits below:
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 6b2407e12060..7c82136979bf 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
>
> [...]
>
> > +     /* attempt loading freplace trying to use custom BTF */
> > +     memset(&attr, 0, bpf_load_attr_sz);
> > +     attr.prog_type =3D BPF_PROG_TYPE_TRACING;
> > +     attr.expected_attach_type =3D BPF_TRACE_FENTRY;
>
> This comment also seems to be disagreeing with the code it's commenting
> on?
>
> [...]
>
> > +static bool memlock_bumped;
> > +static rlim_t memlock_rlim_max =3D RLIM_INFINITY;
> > +
> > +int libbpf_set_memlock_rlim_max(size_t memlock_max)
> > +{
> > +     if (memlock_bumped)
> > +             return libbpf_err(-EBUSY);
> > +
> > +     memlock_rlim_max =3D memlock_max;
> > +     return 0;
> > +}
> > +
> > +int bump_rlimit_memlock(void)
> > +{
> > +     struct rlimit rlim;
> > +
> > +     /* this the default in libbpf 1.0, but for now user has to opt-in=
 explicitly */
> > +     if (!(libbpf_mode & LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK))
> > +             return 0;
> > +
> > +     /* if kernel supports memcg-based accounting, skip bumping RLIMIT=
_MEMLOCK */
> > +     if (memlock_bumped || kernel_supports(NULL, FEAT_MEMCG_ACCOUNT))
> > +             return 0;
> > +
> > +     memlock_bumped =3D true;
> > +
> > +     /* zero memlock_rlim_max disables auto-bumping RLIMIT_MEMLOCK */
> > +     if (memlock_rlim_max =3D=3D 0)
> > +             return 0;
> > +
> > +     rlim.rlim_cur =3D rlim.rlim_max =3D memlock_rlim_max;
> > +     if (setrlimit(RLIMIT_MEMLOCK, &rlim))
> > +             return -errno;
> > +
> > +     return 0;
> > +}
> > +
>
> "rlim_max" seems to imply this will only ever increase the limit, but if
> I'm reading the code correctly it could actually end up lowering the
> effective limit?

_max suffix is confusing to me as well.
libbpf_set_memlock_rlim() would be more accurate.

The other part of the patch:
+               /* assume memcg accounting is supported if we get -ENOTSUPP=
 */
+               err =3D errno =3D=3D 524 /* ENOTSUPP */ ? 1 : 0;

is dangerous.
ENOTSUPP is not a standard error code.
The kernel returns it from a few places, but we might fix
all of them eventually and return EOPNOTSUPP everywhere.
In other words user space cannot rely on this 524 error code number.
