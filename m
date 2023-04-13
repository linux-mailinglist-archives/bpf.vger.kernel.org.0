Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B36E031F
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDMAW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMAW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:22:57 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4FB61AB;
        Wed, 12 Apr 2023 17:22:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54f21cdfadbso200794197b3.7;
        Wed, 12 Apr 2023 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqR6GP81+VxurjfUaGVgvFq58Z4rUxFQOCQjBjCHfDo=;
        b=bR4SIyC3GMEfcOekHd0wX+c9lZb4gqichUBRNLyRn3iRRtSgFsq/2Oo6hPBL6vYanO
         TYVLoJm7hqObeC5IapE16yDXHU+E5zZ81wL+53xqoZBxkyZYtLWZqxRuHsennEdA1eQT
         ZdBHD6ojBeclxW0qyChCCKT3gq5jy87lRpWBMRIQUt44Uoc3dAIyReb8oiXOUvcSA9x2
         xjEfFD3kfRcDOQQBqA8kMh0RktecGL5YZhUagafagdpdrNwbMbv50cK2KswTm9XGywUa
         lWumt1543Y4qJOfaQepw7EVctcXe+zoH1UUWE0m6cP+kojJP+qQGBdB+IlF/tS/02W6n
         3Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqR6GP81+VxurjfUaGVgvFq58Z4rUxFQOCQjBjCHfDo=;
        b=flhpY8tNFGmplBM5YdKsl9EtizU/asqYONwnuwMuubIGZuHkfnrUREWWBVCwnsRcLt
         gT5Fdz0wEvVQuPj1d+mKGJts0zwoTNFyAu9Rc5xFWiEjKcsRRLRBWJlWeOBSKl1oiR1x
         p5AyLj5kZWdps9DMQZ2HPEVjl8MB0iAeWxMM9Xr6IRRpcve6b2Qq6OyTXv26cxP4DNaM
         6mwDwxswtNJzXzDUtwWqzaJL4fiyML4upvzG0eVif8Xo+2z25Ig7VAsax1m4EL6qCGvn
         U68DK+xVanInwKILGBbd9D0dfrGzLgoQDjWU9EdEpOlbIA4gZkxK7dmk0HlzzE8+wL4e
         nL2w==
X-Gm-Message-State: AAQBX9cFXXu8dgqCnTbfALOQDlBtVwRomKN6vZgZQ/ku8qOfvNmwr/Dz
        agDDgBjae/1jKsdZt75GHcslXIqxiJjL7qLywaI0GY1+
X-Google-Smtp-Source: AKy350a9FxHZMDYyVST/3m4dhpegtS/8XnKoQrXBbJ40j5wABlmuoKDZYnxOx5EnaSoaUhXzszpOcV+UMW+on/bb9Q0=
X-Received: by 2002:a81:7613:0:b0:54f:b9f8:70ae with SMTP id
 r19-20020a817613000000b0054fb9f870aemr274359ywc.7.1681345375758; Wed, 12 Apr
 2023 17:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-2-andrii@kernel.org>
 <6436ef37.170a0220.d660b.33fe@mx.google.com>
In-Reply-To: <6436ef37.170a0220.d660b.33fe@mx.google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 17:22:36 -0700
Message-ID: <CAEf4BzaY4mFyYyb6FO5dYetH4TUWhqOmLtmwRb0C+_Cjn4E=0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: move unprivileged checks into
 map_create() and bpf_prog_load()
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 10:49=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 11, 2023 at 09:32:53PM -0700, Andrii Nakryiko wrote:
> > Make each bpf() syscall command a bit more self-contained, making it
> > easier to further enhance it. We move sysctl_unprivileged_bpf_disabled
> > handling down to map_create() and bpf_prog_load(), two special commands
> > in this regard.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 37 ++++++++++++++++++++++---------------
> >  1 file changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 6d575505f89c..c1d268025985 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1130,6 +1130,17 @@ static int map_create(union bpf_attr *attr)
> >       int f_flags;
> >       int err;
> >
> > +     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > +      * creation commands for unprivileged users; other actions depend
> > +      * of fd availability and access to bpffs, so are dependent on
> > +      * object creation success.  Capabilities are later verified for
> > +      * operations such as load and map create, so even with unprivile=
ged
> > +      * BPF disabled, capability checks are still carried out for thes=
e
> > +      * and other operations.
> > +      */
> > +     if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> > +             return -EPERM;
>
> This appears to be a problem in the original code, but capability checks
> should be last, so that audit doesn't see a capability as having been
> used when it wasn't. i.e. if bpf_capable() passes, but
> sysctl_unprivileged_bpf_disabled isn't true, it'll look like a
> capability got used, and the flag gets set. Not a big deal at the end of
> the day, but the preferred ordering should be:
>
>         if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
>                 ...
>

makes sense, I'll change the order



> > +
> >       err =3D CHECK_ATTR(BPF_MAP_CREATE);
> >       if (err)
> >               return -EINVAL;
> > @@ -2512,6 +2523,17 @@ static int bpf_prog_load(union bpf_attr *attr, b=
pfptr_t uattr, u32 uattr_size)
> >       char license[128];
> >       bool is_gpl;
> >
> > +     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > +      * creation commands for unprivileged users; other actions depend
> > +      * of fd availability and access to bpffs, so are dependent on
> > +      * object creation success.  Capabilities are later verified for
> > +      * operations such as load and map create, so even with unprivile=
ged
> > +      * BPF disabled, capability checks are still carried out for thes=
e
> > +      * and other operations.
> > +      */
> > +     if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> > +             return -EPERM;
> > +
> >       if (CHECK_ATTR(BPF_PROG_LOAD))
> >               return -EINVAL;
> >
> > @@ -5008,23 +5030,8 @@ static int bpf_prog_bind_map(union bpf_attr *att=
r)
> >  static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
> >  {
> >       union bpf_attr attr;
> > -     bool capable;
> >       int err;
> >
> > -     capable =3D bpf_capable() || !sysctl_unprivileged_bpf_disabled;
> > -
> > -     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > -      * creation commands for unprivileged users; other actions depend
> > -      * of fd availability and access to bpffs, so are dependent on
> > -      * object creation success.  Capabilities are later verified for
> > -      * operations such as load and map create, so even with unprivile=
ged
> > -      * BPF disabled, capability checks are still carried out for thes=
e
> > -      * and other operations.
> > -      */
> > -     if (!capable &&
> > -         (cmd =3D=3D BPF_MAP_CREATE || cmd =3D=3D BPF_PROG_LOAD))
> > -             return -EPERM;
> > -
> >       err =3D bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
> >       if (err)
> >               return err;
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
