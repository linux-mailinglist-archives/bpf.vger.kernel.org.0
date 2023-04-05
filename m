Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD30F6D85D0
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 20:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjDESRq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDESRq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 14:17:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525165B7
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 11:17:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so143278059edd.1
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680718663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rLnoPbvqPSO9h2zjT7W7pYt1FqC/iaVRQbgoIsKiu8=;
        b=qoEdkrD/+3GvtYKnDvfKJIP6386LPqLG6s0+Fz/4fN/thW6izQfaAHbYU5R3xMErWp
         uOmWqMj0SkSjFmQsD4m8AiieVHJLsOIGBAnK4IF31L8w2SZCc6SF9XsoSBfDGErwXw/F
         t4Z6LkTsOMqSLP4z15QfSmPNdsh1k2s33DNIFmy72CF6seLmsVjPEVQwjQyqRZyQLeO8
         +WU3NU4bDEVq7lrlexPqn+nMed95kz0DqbIwmXRv+7vGMxQP+wpHn+eFjyxEDzh6CxjN
         dfVHk0/3ZpqQd+9gAL919gpuXXv5F/czGXCbcdZHgRvlIVHFzh8Qptu9Z0HXbadxP6Y5
         DDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680718663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rLnoPbvqPSO9h2zjT7W7pYt1FqC/iaVRQbgoIsKiu8=;
        b=mRyAB70Ci7S3l91YKqbP8EbXuPMBVJZnFCf90Np+ZewfyWem/6auCXDoHSXJi47bPk
         obPgcdwRxg173Ld9j8QL0AGGeD8J7cWzy/ExsZz+0/mgSXvF4OImZK51/r9gdGcDRBfp
         TEArhSyFnF70C9jOPAs36uozUF/xFzdQDmqMa2GDdtueVUbPnhtEoBeGUcfb5aS2PxOZ
         hnLploHwDAIRn3+EAhFew/Kk7G67dCYv5xJWDfovtQuuc+AsJeZfSoB6osWfNXM4GIKS
         UgXLfjdnEMZpiUysUPnBb7U1KpGQuBgxOrwNfm3CDCam1RL1GtoRRVgQp9UGyInuFGlX
         klPg==
X-Gm-Message-State: AAQBX9dH4M/hdFaUDuGwxw44aW1Fblrux6Ma9eo4L5cxs0VE3i0cL9y7
        QicUgDxtKD6E3pK8mKuBWF34jOr9h+55QLbdUHQ=
X-Google-Smtp-Source: AKy350bxJ/allb9e4JhgBq7fwMd1ZviNoaHyGJr6E6zdSi7E2eVeQQtveGhB4kIxVn9lZ41EIXA0LyIgJw8GkThXXy0=
X-Received: by 2002:a17:907:76dc:b0:944:70f7:6fae with SMTP id
 kf28-20020a17090776dc00b0094470f76faemr1956150ejc.5.1680718662750; Wed, 05
 Apr 2023 11:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-12-andrii@kernel.org>
 <CAN+4W8hoD9FWRz2kAkyX5HEkRcddQh0HuFBYotDWwgvDnVKA9A@mail.gmail.com> <CAEf4BzbzC8MxNsSv5iArxaTaPTqXURYMUpbAbw2JiwYqF2CYPQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbzC8MxNsSv5iArxaTaPTqXURYMUpbAbw2JiwYqF2CYPQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 11:17:30 -0700
Message-ID: <CAEf4Bzav6Xk0oNUv2_nVqyc4v7_Gd8=kEyZSHv=r1QayKPWd-g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 11/19] bpf: keep track of total log content
 size in both fixed and rolling modes
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 10:50=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 5, 2023 at 10:29=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> =
wrote:
> >
> > On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > With these changes, it's now possible to do this sort of determinatio=
n of
> > > log contents size in both BPF_LOG_FIXED and default rolling log mode.
> > > We need to keep in mind bpf_vlog_reset(), though, which shrinks log
> > > contents after successful verification of a particular code path. Thi=
s
> > > log reset means that log->end_pos isn't always increasing, so to retu=
rn
> > > back to users what should be the log buffer size to fit all log conte=
nt
> > > without causing -ENOSPC even in the presenec of log resetting, we nee=
d
> >
> > Just for you :) Nit: presence
> >
> > > to keep maximum over "lifetime" of logging. We do this accounting in
> > > bpf_vlog_update_len_max() helper.
> >
> > Ah, this is interesting! The way I conceived of this working is that
> > the kernel gives me the buffer size required to avoid truncation at
> > the final copy out _given the same flags_. From a user space POV I
> > don't care about the intermediate log that was truncated away, since I
> > in a way asked the kernel to not give me this information. Can we drop
> > the len_max logic and simply use end_pos?
>
> No, we can't, because if we don't take into account this max, then
> you'll get -ENOSPC. This has all to do with verifier position
> resetting. In log_level=3D1 log can grow while we process some code path
> branch, and as soon as we get to EXIT successfully, verifier will
> "forget" relevant parts of the log to go back to parent state. This
> was done a while ago to only leave verifier history from beginning to
> failure, without all the successfully verified (and thus irrelevant
> for debugging) information. This was a huge usability boost and I
> don't think we want to go back.
>
> But it does mean that even if final log content is small, required log
> buffer size at some point might have been much bigger. And it's pretty
> much always the case for successfully verified programs. They end up
> having a small verifier stats summary and no log of what verifier did
> for state verification.
>
> So, no, we can't just use final end_pos, otherwise we get a useless featu=
re.
>
> >
> > > Another issue to keep in mind is that we limit log buffer size to 32-=
bit
> > > value and keep such log length as u32, but theoretically verifier cou=
ld
> > > produce huge log stretching beyond 4GB. Instead of keeping (and later
> > > returning) 64-bit log length, we cap it at UINT_MAX. Current UAPI mak=
es
> > > it impossible to specify log buffer size bigger than 4GB anyways, so =
we
> > > don't really loose anything here and keep everything consistently 32-=
bit
> > > in UAPI. This property will be utilized in next patch.
> > > These changes do incidentally fix one small issue with previous loggi=
ng
> > > logic. Previously, if use provided log buffer of size N, and actual l=
og
> > > output was exactly N-1 bytes + terminating \0, kernel logic coun't
> > > distinguish this condition from log truncation scenario which would e=
nd
> > > up with truncated log contents of N-1 bytes + terminating \0 as well.
> > >
> > > But now with log->end_pos being logical position that could go beyond
> > > actual log buffer size, we can distinguish these two conditions, whic=
h
> > > we do in this patch. This plays nicely with returning log_size_actual
> > > (implemented in UAPI in the next patch), as we can now guarantee that=
 if
> > > user takes such log_size_actual and provides log buffer of that exact
> > > size, they will not get -ENOSPC in return.
> > >
> > > All in all, all these changes do conceptually unify fixed and rolling
> > > log modes much better, and allow a nice feature requested by users:
> > > knowing what should be the size of the buffer to avoid -ENOSPC.
> > >
> > > We'll plumb this through the UAPI and the code in the next patch.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf_verifier.h | 12 ++-----
> > >  kernel/bpf/log.c             | 68 +++++++++++++++++++++++++---------=
--
> > >  2 files changed, 50 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 4c926227f612..98d2eb382dbb 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -504,6 +504,7 @@ struct bpf_verifier_log {
> > >         char __user *ubuf;
> > >         u32 level;
> > >         u32 len_total;
> > > +       u32 len_max;
> > >         char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
> > >  };
> > >
> > > @@ -517,23 +518,16 @@ struct bpf_verifier_log {
> > >  #define BPF_LOG_MIN_ALIGNMENT 8U
> > >  #define BPF_LOG_ALIGNMENT 40U
> > >
> > > -static inline u32 bpf_log_used(const struct bpf_verifier_log *log)
> > > -{
> > > -       return log->end_pos - log->start_pos;
> > > -}
> > > -
> > >  static inline bool bpf_verifier_log_full(const struct bpf_verifier_l=
og *log)
> > >  {
> > >         if (log->level & BPF_LOG_FIXED)
> > > -               return bpf_log_used(log) >=3D log->len_total - 1;
> > > +               return log->end_pos >=3D log->len_total;
> > >         return false;
> > >  }
> > >
> > >  static inline bool bpf_verifier_log_needed(const struct bpf_verifier=
_log *log)
> > >  {
> > > -       return log &&
> > > -               ((log->level && log->ubuf && !bpf_verifier_log_full(l=
og)) ||
> > > -                log->level =3D=3D BPF_LOG_KERNEL);
> > > +       return log && log->level;
> > >  }
> > >
> > >  #define BPF_MAX_SUBPROGS 256
> > > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > > index 14dc4d90adbe..acfe8f5d340a 100644
> > > --- a/kernel/bpf/log.c
> > > +++ b/kernel/bpf/log.c
> > > @@ -16,10 +16,26 @@ bool bpf_verifier_log_attr_valid(const struct bpf=
_verifier_log *log)
> > >                log->level && log->ubuf && !(log->level & ~BPF_LOG_MAS=
K);
> > >  }
> > >
> > > +static void bpf_vlog_update_len_max(struct bpf_verifier_log *log, u3=
2 add_len)
> > > +{
> > > +       /* add_len includes terminal \0, so no need for +1. */
> > > +       u64 len =3D log->end_pos + add_len;
> > > +
> > > +       /* log->len_max could be larger than our current len due to
> > > +        * bpf_vlog_reset() calls, so we maintain the max of any leng=
th at any
> > > +        * previous point
> > > +        */
> > > +       if (len > UINT_MAX)
> > > +               log->len_max =3D UINT_MAX;
> > > +       else if (len > log->len_max)
> > > +               log->len_max =3D len;
> > > +}
> > > +
> > >  void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt=
,
> > >                        va_list args)
> > >  {
> > > -       unsigned int n;
> > > +       u64 cur_pos;
> > > +       u32 new_n, n;
> > >
> > >         n =3D vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, a=
rgs);
> > >
> > > @@ -33,21 +49,28 @@ void bpf_verifier_vlog(struct bpf_verifier_log *l=
og, const char *fmt,
> > >                 return;
> > >         }
> > >
> > > +       n +=3D 1; /* include terminating zero */
> >
> > So above we WARN_ONCE if n >=3D BPF_VERIFIER_TMP_LOG_SIZE - 1, but here
> > we add 1 anyways. Doesn't that mean we may read 1 byte past the end of
> > kbuf?
>
> Nice catch! I guess I have to do `n =3D min(n, BPF_VERIFIER_TMP_LOG_SIZE
> - 1)` before that, will fix it, thanks!
>

Ok, so looking at your comment about vscnprintf and checking the
source code, no, we don't have a problem here. vscnprintf() will at
most return buf size - 1, and will still put zero into the last byte.
So we can never read past buffer end.

> >
> >
> > >         if (log->level & BPF_LOG_FIXED) {
> > > -               n =3D min(log->len_total - bpf_log_used(log) - 1, n);
> > > -               log->kbuf[n] =3D '\0';
> > > -               n +=3D 1;
> > > -
> > > -               if (copy_to_user(log->ubuf + log->end_pos, log->kbuf,=
 n))
> > > -                       goto fail;
> > > +               /* check if we have at least something to put into us=
er buf */
> > > +               new_n =3D 0;
> > > +               if (log->end_pos < log->len_total - 1) {
> > > +                       new_n =3D min_t(u32, log->len_total - log->en=
d_pos, n);
> > > +                       log->kbuf[new_n - 1] =3D '\0';
> > > +               }
> > >
> > > +               bpf_vlog_update_len_max(log, n);
> > > +               cur_pos =3D log->end_pos;
> > >                 log->end_pos +=3D n - 1; /* don't count terminating '=
\0' */
> > > +
> > > +               if (log->ubuf && new_n &&
> > > +                   copy_to_user(log->ubuf + cur_pos, log->kbuf, new_=
n))
> > > +                       goto fail;
>
> [...]
