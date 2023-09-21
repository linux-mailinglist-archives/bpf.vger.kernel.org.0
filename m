Return-Path: <bpf+bounces-10587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B067AA13F
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA50281BF1
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA59719458;
	Thu, 21 Sep 2023 20:59:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950381802D
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 20:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA5EC433C8;
	Thu, 21 Sep 2023 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695329998;
	bh=Y1sYCIPFzVCA4id34WPULMYFBwa/vtshjit7aYHOKhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BTGxNCatA8VTxKxb+gqUbTSp7MEjwVgHCwDmB3jCWZijt2ohKgzdtoQrfIqtRoXBl
	 EsXoV9GiDh5oF97uIZLgau7L7fSess3lqcsHC0Eb/yRHgtf5JxRQo0n1HwlvmcPeEW
	 696GzGYyRhhPiwjrJfrHHd1xGdpX7qxS+XnsspRhZdh3MyA4Mv+XrP4TAcbRFmnU4s
	 9nv1BtW55Sal28uuM+RV2hv6IO7TuzCXrRMt+lYdRXonAJZ+x1f757blY5vs3hwU+e
	 qmMmNAC1rFcKh5nx3lS8xpw45eJbVClHC6mtgnPAouRJa/Y6TzKYN3ycQJnFa1JoA0
	 05+eG1mlGZIgA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5041335fb9cso2405340e87.0;
        Thu, 21 Sep 2023 13:59:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyqNc0UuOgqhUrT5zK+G/buKc0RP9U318/LBO6J3+etQWFYcQD2
	5Mk9k6hbjsl1ybfDO6DNprWhNGmAnvrj+azwamE=
X-Google-Smtp-Source: AGHT+IHeI/3aE1RRGrhYcC9JMNVOOdQF7zTXdiBHW70ZFJDTcrlSYb8qiGeSrgCwK7DVD8FuBnWnxbOeCW+mC/5I4Zs=
X-Received: by 2002:a19:6715:0:b0:501:b8dc:6c45 with SMTP id
 b21-20020a196715000000b00501b8dc6c45mr5562443lfc.18.1695329996358; Thu, 21
 Sep 2023 13:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <98b02c73-295d-baad-5c77-0c8b74826ca9@schaufler-ca.com> <202309201221.205BA18@keescook>
 <CACYkzJ6HyrK0bicq0YfeHoeBAeK4-3UZtE2XqPgC9bqmi5ui4w@mail.gmail.com>
In-Reply-To: <CACYkzJ6HyrK0bicq0YfeHoeBAeK4-3UZtE2XqPgC9bqmi5ui4w@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 13:59:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW64beWEUWaiaO6RgCF2xvJd7DwGkg567hr1+M24Sx+h2w@mail.gmail.com>
Message-ID: <CAPhsuW64beWEUWaiaO6RgCF2xvJd7DwGkg567hr1+M24Sx+h2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, daniel@iogearbox.net, ast@kernel.org, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 1:41=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Wed, Sep 20, 2023 at 9:24=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > On 9/18/2023 2:24 PM, KP Singh wrote:
> > > [...]
> > > +#define __COUNT_COMMAS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, =
_11, _12, _n, X...) _n
> > > +#define COUNT_COMMAS(a, X...) __COUNT_COMMAS(, ##X, 12, 11, 10, 9, 8=
, 7, 6, 5, 4, 3, 2, 1, 0)
> > > +#define ___COUNT_COMMAS(args...) COUNT_COMMAS(args)
> >
> > Oh! Oops, I missed that this _DOES_ already exist in Linux:
> >
> > cf14f27f82af ("macro: introduce COUNT_ARGS() macro")
> >
> > now in include/linux/args.h as COUNT_ARGS():
> >
> > #define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, =
_12, _n, X...) _n
> > #define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5,=
 4, 3, 2, 1, 0)
> >
> > I think this can be refactored to use that?

Aha, I noticed the same thing when backporting the set to 6.4 for testing. =
(Some
dependency of this set uses args.h).

>
> Thanks, yeah I was able to do this with:

With this fixed:

Acked-by: Song Liu <song@kernel.org>


>
> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> index 0c0ff3c7dddc..969b6bf60718 100644
> --- a/include/linux/lsm_count.h
> +++ b/include/linux/lsm_count.h
> @@ -7,7 +7,7 @@
>  #ifndef __LINUX_LSM_COUNT_H
>  #define __LINUX_LSM_COUNT_H
>
> -#include <linux/kconfig.h>
> +#include <linux/args.h>
>
>  #ifdef CONFIG_SECURITY
>
> @@ -79,13 +79,15 @@
>  #endif
>
>
> -#define __COUNT_COMMAS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10,
> _11, _12, _n, X...) >
> -#define COUNT_COMMAS(a, X...) __COUNT_COMMAS(, ##X, 12, 11, 10, 9, 8,
> 7, 6, 5, 4, 3, 2, >
> -#define ___COUNT_COMMAS(args...) COUNT_COMMAS(args)
> -
> +/*
> + *  There is a trailing comma that we need to be accounted for. This is =
done by
> + *  using a skipped argument in __COUNT_LSMS
> + */
> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
>
>  #define MAX_LSM_COUNT                  \
> -       ___COUNT_COMMAS(                \
> +       COUNT_LSMS(                     \
>                 CAPABILITIES_ENABLED    \
>                 SELINUX_ENABLED         \
>                 SMACK_ENABLED           \
>
>
>
> >
> > -Kees
> >
> > --
> > Kees Cook
> >

