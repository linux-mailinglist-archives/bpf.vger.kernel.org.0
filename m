Return-Path: <bpf+bounces-10649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6E7AB58E
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C7CBD2822E0
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C941772;
	Fri, 22 Sep 2023 16:08:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0941233
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 16:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2695FC433CC
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695398888;
	bh=TyyKrSNDOmitK8LSKeEIonhNFxYjDi/94RCTzvIMmEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GXQkKuqUu3Z5gvhsYGDHVvI8o7UacQ3HyHy3dSNgO44egNasLsvvF9JuI5FCxdt5W
	 kiAHZbEVE/Dr10HDXZj132JuPk2n2O3CzQ9YZR6UEzEul+EHExdPAh+GSXDXty0AKt
	 kUUsdp8mJBhJTBGvfGStfCl7+A1A53TilmQiYsfJ4SAFmgU003k2UcQfaQl1RSA/11
	 ayfUKGDcDiTArzh8ft7hTI5t5trLZiuulYqsN7ypwcWAz8vbSYAV4CS2ozxxXgwGbw
	 6BQD7pRRJ70641UtD2jZiYDHIGjO90ksEKUu4jSB4meuWUDAxlUYHE/jBboVQN+7kp
	 mFVzDOj/QH8xw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso40059531fa.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 09:08:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzd99AzkgbjQMOes3te2IOi6f7tcWW+L2AdVkJCpKPUsYUn1NC0
	NEEeH/DQ+D6tcgDBOWmJ+JDYIhPCfZPvdgLagrxtMQ==
X-Google-Smtp-Source: AGHT+IG8yfS18kbASIPfqp05uIy0ygNKMUUzhZa3mAoNqBfG5E+3atLD7Rczz4cq0b1TbAJTO0PjMe7mAl0y0XyqR+I=
X-Received: by 2002:ac2:44ce:0:b0:4fe:db6:cb41 with SMTP id
 d14-20020ac244ce000000b004fe0db6cb41mr7769508lfm.39.1695398886289; Fri, 22
 Sep 2023 09:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922145505.4044003-3-kpsingh@kernel.org>
 <202309220848.010A198E7@keescook>
In-Reply-To: <202309220848.010A198E7@keescook>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 22 Sep 2023 18:07:55 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
Message-ID: <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] security: Count the LSMs enabled at compile time
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	Kui-Feng Lee <sinquersw@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 5:50=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Sep 22, 2023 at 04:55:02PM +0200, KP Singh wrote:
> > These macros are a clever trick to determine a count of the number of
> > LSMs that are enabled in the config to ascertain the maximum number of
> > static calls that need to be configured per LSM hook.
> >
> > Without this one would need to generate static calls for the total
> > number of LSMs in the kernel (even if they are not compiled) times the
> > number of LSM hooks which ends up being quite wasteful.
> >
> > Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Thought below, but regardless of result:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>
> > ---
> >  include/linux/lsm_count.h | 107 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 include/linux/lsm_count.h
> >
> > diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> > new file mode 100644
> > index 000000000000..4d6dac6efb75
> > --- /dev/null
> > +++ b/include/linux/lsm_count.h
> > @@ -0,0 +1,107 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (C) 2023 Google LLC.
> > + */
> > +
> > +#ifndef __LINUX_LSM_COUNT_H
> > +#define __LINUX_LSM_COUNT_H
> > +
> > +#include <linux/args.h>
> > +
> > +#ifdef CONFIG_SECURITY
> > +
> > +/*
> > + * Macros to count the number of LSMs enabled in the kernel at compile=
 time.
> > + */
> > +
> > +/*
> > + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> > + */
> > +#if IS_ENABLED(CONFIG_SECURITY)
> > +#define CAPABILITIES_ENABLED 1,
> > +#else
> > +#define CAPABILITIES_ENABLED
> > +#endif
>
> We're in an #ifdef CONFIG_SECURITY, so CAPABILITIES_ENABLED will always
> be set. As such, we could leave off the trailing comma and list it
> _last_ in the macro, and then ...
>
> > +/*
> > + *  There is a trailing comma that we need to be accounted for. This i=
s done by
> > + *  using a skipped argument in __COUNT_LSMS
> > + */
> > +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
> > +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
>
> This wouldn't be needed...

Slight preference for explicitly having the capabilities listed than
implicitly over counting. But no strong opinion, fine with either
approches.

>
> > +
> > +#define MAX_LSM_COUNT                        \
> > +     COUNT_LSMS(                     \
> > +             CAPABILITIES_ENABLED    \
> > +             SELINUX_ENABLED         \
> > +             SMACK_ENABLED           \
> > +             APPARMOR_ENABLED        \
> > +             TOMOYO_ENABLED          \
> > +             YAMA_ENABLED            \
> > +             LOADPIN_ENABLED         \
> > +             LOCKDOWN_ENABLED        \
> > +             BPF_LSM_ENABLED         \
> > +             LANDLOCK_ENABLED)
>
>
>         COUNT_ARGS(                     \
>                 SELINUX_ENABLED         \
>                 SMACK_ENABLED           \
>                 ...
>                 CAPABILITIES_ENABLED)
>
> -Kees
>
> --
> Kees Cook

