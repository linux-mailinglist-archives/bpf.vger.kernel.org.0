Return-Path: <bpf+bounces-10990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E97B0EF7
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E7B63282273
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322011C6A9;
	Wed, 27 Sep 2023 22:37:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E7746A
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 22:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CE4C433CD
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695854267;
	bh=B0S2n6HCp+FeFWR6Fny0wbL6CcXc6eGDsU9YyqjQlDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lk90xudp6/8jNffKHL0+ctBHAh2C+7MErHcFEykSY8gKo1VbBhlSutF8ESPm0c2xP
	 WlU906JtcQINTY45c/ArpqmWXFopWHhpmXgol8/6t0T++LZ1Ikmf5QXPm1roTEDtlW
	 LGbyIvYsWfuxDlSDJNEog2d32jqc1LqrBsUSCneJf9pwKP1IjMKhoPORuUFe0v8FQl
	 owluvSmhphiW1OGU1pPnqsyPeVgXa9LX188JErBqpdfQCMQIb3oHrG0lr+8mTXUHrN
	 jYY6OtgiiWUrSmWt7EFdhbfm4L+hRWds4s1B2yqH9vvyf0Fb9kqgwmAPQwqjqg5cY9
	 PRgrTvjuh3kHA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-504b84d59cbso1550750e87.3
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 15:37:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWJn1FGyBcSAeuVYrEymWDk05Rm0FL/JLbMYT+oFrsO8KyvNg6
	Qa/+bo5qxJosgXS0s53f8eRFDX6Ad0DSt+LOpNAzrA==
X-Google-Smtp-Source: AGHT+IFOdQVmyavPxMnA/9OYQyOmx+BCIQjxi2syAwTxGcpfr9IvvpQAP08ajlezmoqX2DNS8flu/11a5lqqfyIKKz8=
X-Received: by 2002:ac2:58e7:0:b0:504:3c1f:cbd1 with SMTP id
 v7-20020ac258e7000000b005043c1fcbd1mr2785491lfo.12.1695854265473; Wed, 27 Sep
 2023 15:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922145505.4044003-3-kpsingh@kernel.org>
 <202309220848.010A198E7@keescook> <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
In-Reply-To: <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 28 Sep 2023 00:37:34 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5Th50nOsgxxNqJNMjWZBSPPD9wxRX7YLui5_LHbc43vw@mail.gmail.com>
Message-ID: <CACYkzJ5Th50nOsgxxNqJNMjWZBSPPD9wxRX7YLui5_LHbc43vw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] security: Count the LSMs enabled at compile time
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	Kui-Feng Lee <sinquersw@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 6:07=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Fri, Sep 22, 2023 at 5:50=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > On Fri, Sep 22, 2023 at 04:55:02PM +0200, KP Singh wrote:
> > > These macros are a clever trick to determine a count of the number of
> > > LSMs that are enabled in the config to ascertain the maximum number o=
f
> > > static calls that need to be configured per LSM hook.
> > >
> > > Without this one would need to generate static calls for the total
> > > number of LSMs in the kernel (even if they are not compiled) times th=
e
> > > number of LSM hooks which ends up being quite wasteful.
> > >
> > > Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Acked-by: Song Liu <song@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> >
> > Thought below, but regardless of result:
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> >
> > > ---
> > >  include/linux/lsm_count.h | 107 ++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 107 insertions(+)
> > >  create mode 100644 include/linux/lsm_count.h
> > >
> > > diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> > > new file mode 100644
> > > index 000000000000..4d6dac6efb75
> > > --- /dev/null
> > > +++ b/include/linux/lsm_count.h
> > > @@ -0,0 +1,107 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (C) 2023 Google LLC.
> > > + */
> > > +
> > > +#ifndef __LINUX_LSM_COUNT_H
> > > +#define __LINUX_LSM_COUNT_H
> > > +
> > > +#include <linux/args.h>
> > > +
> > > +#ifdef CONFIG_SECURITY
> > > +
> > > +/*
> > > + * Macros to count the number of LSMs enabled in the kernel at compi=
le time.
> > > + */
> > > +
> > > +/*
> > > + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> > > + */
> > > +#if IS_ENABLED(CONFIG_SECURITY)
> > > +#define CAPABILITIES_ENABLED 1,
> > > +#else
> > > +#define CAPABILITIES_ENABLED
> > > +#endif
> >
> > We're in an #ifdef CONFIG_SECURITY, so CAPABILITIES_ENABLED will always
> > be set. As such, we could leave off the trailing comma and list it
> > _last_ in the macro, and then ...
> >
> > > +/*
> > > + *  There is a trailing comma that we need to be accounted for. This=
 is done by
> > > + *  using a skipped argument in __COUNT_LSMS
> > > + */
> > > +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
> > > +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
> >
> > This wouldn't be needed...
>
> Slight preference for explicitly having the capabilities listed than
> implicitly over counting. But no strong opinion, fine with either
> approches.

Actually it's not just a preference but really required. When the
CAPABILITIES is absent and all other LSMs are disabled it leads to
COUNT_ARGS() which evaluates to 0

This also happens here:

https://lore.kernel.org/bpf/202309271206.d7fb60f9-oliver.sang@intel.com/

and to fix this we need:

-#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
+#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)

And I checked the edge cases with a simple c file

int test(void) {
   int count =3D MAX_LSM_COUNT;
}

and make security/count.i:

for just CONFIG_SECURITY enabled:

int test(void) {
  int count =3D 1;
}

with another LSM:

int test(void) {
  int count =3D 2;
}


- KP
>
> >
> > > +
> > > +#define MAX_LSM_COUNT                        \
> > > +     COUNT_LSMS(                     \
> > > +             CAPABILITIES_ENABLED    \
> > > +             SELINUX_ENABLED         \
> > > +             SMACK_ENABLED           \
> > > +             APPARMOR_ENABLED        \
> > > +             TOMOYO_ENABLED          \
> > > +             YAMA_ENABLED            \
> > > +             LOADPIN_ENABLED         \
> > > +             LOCKDOWN_ENABLED        \
> > > +             BPF_LSM_ENABLED         \
> > > +             LANDLOCK_ENABLED)
> >
> >
> >         COUNT_ARGS(                     \
> >                 SELINUX_ENABLED         \
> >                 SMACK_ENABLED           \
> >                 ...
> >                 CAPABILITIES_ENABLED)
> >
> > -Kees
> >
> > --
> > Kees Cook

