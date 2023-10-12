Return-Path: <bpf+bounces-11984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442C7C6275
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 03:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6636E1C20E60
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 01:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0027EE;
	Thu, 12 Oct 2023 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWOkzlQG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DB658
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 01:50:13 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC70B8;
	Wed, 11 Oct 2023 18:50:11 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1dcead29b3eso253967fac.3;
        Wed, 11 Oct 2023 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697075411; x=1697680211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXFwUyTy0U6yArCYy69m9SsGkAP6XEKpYScGP5jhuhs=;
        b=jWOkzlQGLWZ+a8QJ6UcAQRMXcv/d8GvTAt/g0zdWnXPeLd4El7QgVUhvRPt4cfXFrb
         n/ck7qFTy3RH+WuE9M8YITKFpOM89aPgSH2wy/2NE0x7/Cig6Nxbut9dpU2dS+Nk5G5j
         nLGE0k9OGJFebKp132y6tIQ7yMIwnepx/FN4o1r0jSpza6DJedDkdur2omcK8Nb0bIQe
         eOtBLgWo3vIR4eSVgU3mBkTYKDvhKhukNSzzzZu7oTKwzHhZ0P1Dnh65kMbufottL4ux
         NJdjuEl4PzVGnqGl0jiRctunG0yvvJr30QCu7p7gxI7piF0LIXfWevoSw+2nArmTp+Oe
         mcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697075411; x=1697680211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXFwUyTy0U6yArCYy69m9SsGkAP6XEKpYScGP5jhuhs=;
        b=W6/HEkjn3HedA4v2x57sdbZA/78teSkTKJJczaMOpOBj+1f9N1oQXX7yTZ7DZt25nV
         TCklmAkAzAZMcEvTKaLhJhGZciyHFQU0D8SDPJkGQqLlBdGDkV8NBTMAqnjIMlci37Yz
         wMZYvcj6ilhUronQvWsfVU6EMpcguJjWDMzWYQCDXT+0FkJvLtVGOJhYDZtOW1MwXVpU
         NF2/ZCAc5oeUJf77tkCDzvK1s3DvFqCOqt+YUDwJfyUwAItMZLYyosmTsvRBTucbEfC9
         bBQs0opAxjQJf0mJWPdUFriwGt9gFZkBW9NknJWIdF7ybH9sSMxxwfhBQzV3YxZp6eHI
         2yEQ==
X-Gm-Message-State: AOJu0Yydl/Y6wYeHzwVlRzUz8zidIug7X1NqYOYzog2UiylBdJuZhZIj
	7PjUeNrhsmHtveKQ/pkYT4DOxrgp57SOnqcELjy04uD9cZA=
X-Google-Smtp-Source: AGHT+IHwYPv4D9C+aDCX0jQunfPUbE5l8oSeYpHtedG5mrArUPIzpLaah/CPgJ0wj92ogxs5uNi0lDvC3Ax6RLIlS6c=
X-Received: by 2002:a05:6871:209:b0:1e9:b0be:d006 with SMTP id
 t9-20020a056871020900b001e9b0bed006mr1015538oad.2.1697075410743; Wed, 11 Oct
 2023 18:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009124046.74710-1-hengqi.chen@gmail.com> <20231009124046.74710-4-hengqi.chen@gmail.com>
 <202310101719.2E6AA3E@keescook>
In-Reply-To: <202310101719.2E6AA3E@keescook>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 12 Oct 2023 09:49:59 +0800
Message-ID: <CAEyhmHQ=D=sWsnFAXpP-_SocE0uLD1m3kfUszHtMyoBjhFDSZA@mail.gmail.com>
Subject: Re: [PATCH 3/4] seccomp: Introduce SECCOMP_ATTACH_FILTER operation
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net, 
	wad@chromium.org, alexyonghe@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 8:22=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Oct 09, 2023 at 12:40:45PM +0000, Hengqi Chen wrote:
> > The SECCOMP_ATTACH_FILTER operation is used to attach
> > a loaded filter to the current process. The loaded filter
> > is represented by a fd which is either returned by the
> > SECCOMP_LOAD_FILTER operation or obtained from bpffs using
> > bpf syscall.
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  include/uapi/linux/seccomp.h |  1 +
> >  kernel/seccomp.c             | 68 +++++++++++++++++++++++++++++++++---
> >  2 files changed, 64 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.=
h
> > index ee2c83697810..fbe30262fdfc 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -17,6 +17,7 @@
> >  #define SECCOMP_GET_ACTION_AVAIL     2
> >  #define SECCOMP_GET_NOTIF_SIZES              3
> >  #define SECCOMP_LOAD_FILTER          4
> > +#define SECCOMP_ATTACH_FILTER                5
> >
> >  /* Valid flags for SECCOMP_SET_MODE_FILTER */
> >  #define SECCOMP_FILTER_FLAG_TSYNC            (1UL << 0)
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 3ae43db3b642..9f9d8a7a1d6e 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -523,7 +523,10 @@ static inline pid_t seccomp_can_sync_threads(void)
> >  static inline void seccomp_filter_free(struct seccomp_filter *filter)
> >  {
> >       if (filter) {
> > -             bpf_prog_destroy(filter->prog);
> > +             if (filter->prog->type =3D=3D BPF_PROG_TYPE_SECCOMP)
> > +                     bpf_prog_put(filter->prog);
> > +             else
> > +                     bpf_prog_destroy(filter->prog);
> >               kfree(filter);
> >       }
> >  }
> > @@ -894,7 +897,7 @@ static void seccomp_cache_prepare(struct seccomp_fi=
lter *sfilter)
> >  #endif /* SECCOMP_ARCH_NATIVE */
> >
> >  /**
> > - * seccomp_attach_filter: validate and attach filter
> > + * seccomp_do_attach_filter: validate and attach filter
> >   * @flags:  flags to change filter behavior
> >   * @filter: seccomp filter to add to the current process
> >   *
> > @@ -905,8 +908,8 @@ static void seccomp_cache_prepare(struct seccomp_fi=
lter *sfilter)
> >   *     seccomp mode or did not have an ancestral seccomp filter
> >   *   - in NEW_LISTENER mode: the fd of the new listener
> >   */
> > -static long seccomp_attach_filter(unsigned int flags,
> > -                               struct seccomp_filter *filter)
> > +static long seccomp_do_attach_filter(unsigned int flags,
> > +                                  struct seccomp_filter *filter)
> >  {
> >       unsigned long total_insns;
> >       struct seccomp_filter *walker;
> > @@ -2001,7 +2004,7 @@ static long seccomp_set_mode_filter(unsigned int =
flags,
> >               goto out;
> >       }
> >
> > -     ret =3D seccomp_attach_filter(flags, prepared);
> > +     ret =3D seccomp_do_attach_filter(flags, prepared);
> >       if (ret)
> >               goto out;
> >       /* Do not free the successfully attached filter. */
> > @@ -2058,6 +2061,51 @@ static long seccomp_load_filter(const char __use=
r *filter)
> >               bpf_prog_put(prog);
> >       return ret;
> >  }
> > +
> > +static long seccomp_attach_filter(const char __user *ufd)
> > +{
> > +     const unsigned long seccomp_mode =3D SECCOMP_MODE_FILTER;
> > +     struct seccomp_filter *sfilter;
> > +     struct bpf_prog *prog;
> > +     int flags =3D 0;
> > +     int fd, ret;
> > +
> > +     if (copy_from_user(&fd, ufd, sizeof(fd)))
> > +             return -EFAULT;
> > +
> > +     prog =3D bpf_prog_get_type(fd, BPF_PROG_TYPE_SECCOMP);
> > +     if (IS_ERR(prog))
> > +             return PTR_ERR(prog);
> > +
> > +     sfilter =3D kzalloc(sizeof(*sfilter), GFP_KERNEL | __GFP_NOWARN);
> > +     if (!sfilter) {
> > +             bpf_prog_put(prog);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     sfilter->prog =3D prog;
> > +     refcount_set(&sfilter->refs, 1);
> > +     refcount_set(&sfilter->users, 1);
> > +     mutex_init(&sfilter->notify_lock);
> > +     init_waitqueue_head(&sfilter->wqh);
> > +
> > +     spin_lock_irq(&current->sighand->siglock);
> > +
> > +     ret =3D -EINVAL;
> > +     if (!seccomp_may_assign_mode(seccomp_mode))
> > +             goto out;
> > +
> > +     ret =3D seccomp_do_attach_filter(flags, sfilter);
> > +     if (ret)
> > +             goto out;
> > +
> > +     sfilter =3D NULL;
> > +     seccomp_assign_mode(current, seccomp_mode, flags);
> > +out:
> > +     spin_unlock_irq(&current->sighand->siglock);
> > +     seccomp_filter_free(sfilter);
> > +     return ret;
> > +}
>
> This is duplicating part of seccomp_set_mode_filter() but without
> handling flags at all. This isn't really workable, since we need things
> like TSYNC, etc. I think it would be better to adjust
> SECCOMP_SET_MODE_FILTER to take a new flag that indicates that the user
> arg is an fd, not a filter. Then the middle of seccomp_set_mode_filter()
> can choosen between seccomp_prepare_user_filter() and a wrapped call to
> bpf_prog_get_type() on the fd, etc.
>

Great, that would make things easier. Thanks.

> --
> Kees Cook

