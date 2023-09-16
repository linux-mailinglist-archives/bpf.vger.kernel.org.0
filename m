Return-Path: <bpf+bounces-10193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD07A2CC4
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 02:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E89B1C22B3E
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 00:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFA136B;
	Sat, 16 Sep 2023 00:54:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D216A2A
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 00:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC755C433C7
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 00:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694825681;
	bh=sMIRUgAz3TYjvXj3nt8cWKXj4GnlPtpw5NrtaT5M9Vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pXocS2qv8pF+G4w13HTtKVQre4xxHfrK/x52f8rkJ460HbJpxQ/4UlMj4YFuL0g5l
	 U2sbvo1XS5vSAJPW/WoWQ0C2EH97QLPLgwelaA3lAm1YizAQayj6Ng3DcYjmAzNLx+
	 BxOc43vx2xQj7RGbfxQr5zfZTYJHlYMKtUtJJh6vNwdVPJQGp2PrgWX9u4NzBlQyy5
	 kCMFQTuwTtczyCmig2QbBHqULCi6TTY6z5QOYy5sJWWZOb4juG5mJlitH604OgmiQZ
	 zlh4zbyV+SsfFGcEuMKX7PKGjgEaCLt6yGoZc1lxHWCNMTU+IyLN8xkNRDTsBC0JDb
	 7inzxKpIQNOtQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso3185052a12.3
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:54:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YzEoB6Wjw9apq9QqkT/L3gor4t3Q7hFLka0LipreIZ/TKaK8c+a
	qg3wcHDw5UtuoAI2CwhFraDzHD+PgofhS65Nnt8XlA==
X-Google-Smtp-Source: AGHT+IGnQSbEnSvvwFlJPLtSWWk1YNhH0ZYobCmvCxVohsU+XdeWzj2CYr6ERYF8pZl/d01CPoksBnpjg6SyOmbilko=
X-Received: by 2002:a05:6402:22b1:b0:530:bea1:9e9c with SMTP id
 cx17-20020a05640222b100b00530bea19e9cmr369956edb.41.1694825680274; Fri, 15
 Sep 2023 17:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-3-kpsingh@kernel.org>
 <72bd13a2-a5b3-328e-a751-87102107293e@schaufler-ca.com> <CAEf4BzYuurXCTfqkfLc3RvWZiUzJ2am2GwcYgZgiEb91cGGZaw@mail.gmail.com>
In-Reply-To: <CAEf4BzYuurXCTfqkfLc3RvWZiUzJ2am2GwcYgZgiEb91cGGZaw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 16 Sep 2023 02:54:29 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4B=hcOgz_C3jYQzRYchXQGCbSQym6a2aQEM7OXbdho7w@mail.gmail.com>
Message-ID: <CACYkzJ4B=hcOgz_C3jYQzRYchXQGCbSQym6a2aQEM7OXbdho7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] security: Count the LSMs enabled at compile time
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, paul@paul-moore.com, keescook@chromium.org, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, jannh@google.com, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 17, 2023 at 12:27=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 15, 2023 at 5:38=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > On 6/15/2023 5:04 PM, KP Singh wrote:
> > > These macros are a clever trick to determine a count of the number of
> > > LSMs that are enabled in the config to ascertain the maximum number o=
f
> > > static calls that need to be configured per LSM hook.
> > >
> > > Without this one would need to generate static calls for (number of
> > > possible LSMs * number of LSM hooks) which ends up being quite wastef=
ul
> > > especially when some LSMs are not compiled into the kernel.
> > >
> > > Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  include/linux/lsm_count.h | 131 ++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 131 insertions(+)
> > >  create mode 100644 include/linux/lsm_count.h
> > >
> > > diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> > > new file mode 100644
> > > index 000000000000..818f62ffa723
> > > --- /dev/null
> > > +++ b/include/linux/lsm_count.h
> > > @@ -0,0 +1,131 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (C) 2023 Google LLC.
> > > + */
> > > +
> > > +#ifndef __LINUX_LSM_COUNT_H
> > > +#define __LINUX_LSM_COUNT_H
> > > +
> > > +#include <linux/kconfig.h>
> > > +
> > > +/*
> > > + * Macros to count the number of LSMs enabled in the kernel at compi=
le time.
> > > + */
> > > +
> > > +#define __LSM_COUNT_15(x, y...) 15
> > > +#define __LSM_COUNT_14(x, y...) 14
> > > +#define __LSM_COUNT_13(x, y...) 13
> > > +#define __LSM_COUNT_12(x, y...) 12
> > > +#define __LSM_COUNT_11(x, y...) 11
> > > +#define __LSM_COUNT_10(x, y...) 10
> > > +#define __LSM_COUNT_9(x, y...) 9
> > > +#define __LSM_COUNT_8(x, y...) 8
> > > +#define __LSM_COUNT_7(x, y...) 7
> > > +#define __LSM_COUNT_6(x, y...) 6
> > > +#define __LSM_COUNT_5(x, y...) 5
> > > +#define __LSM_COUNT_4(x, y...) 4
> > > +#define __LSM_COUNT_3(x, y...) 3
> > > +#define __LSM_COUNT_2(x, y...) 2
> > > +#define __LSM_COUNT_1(x, y...) 1
> > > +#define __LSM_COUNT_0(x, y...) 0
> > > +
> > > +#define __LSM_COUNT1_15(x, y...) __LSM_COUNT ## x ## _15(y)
> > > +#define __LSM_COUNT1_14(x, y...) __LSM_COUNT ## x ## _14(y)
> > > +#define __LSM_COUNT1_13(x, y...) __LSM_COUNT ## x ## _13(y)
> > > +#define __LSM_COUNT1_12(x, y...) __LSM_COUNT ## x ## _12(y)
> > > +#define __LSM_COUNT1_10(x, y...) __LSM_COUNT ## x ## _11(y)
> > > +#define __LSM_COUNT1_9(x, y...) __LSM_COUNT ## x ## _10(y)
> > > +#define __LSM_COUNT1_8(x, y...) __LSM_COUNT ## x ## _9(y)
> > > +#define __LSM_COUNT1_7(x, y...) __LSM_COUNT ## x ## _8(y)
> > > +#define __LSM_COUNT1_6(x, y...) __LSM_COUNT ## x ## _7(y)
> > > +#define __LSM_COUNT1_5(x, y...) __LSM_COUNT ## x ## _6(y)
> > > +#define __LSM_COUNT1_4(x, y...) __LSM_COUNT ## x ## _5(y)
> > > +#define __LSM_COUNT1_3(x, y...) __LSM_COUNT ## x ## _4(y)
> > > +#define __LSM_COUNT1_2(x, y...) __LSM_COUNT ## x ## _3(y)
> > > +#define __LSM_COUNT1_1(x, y...) __LSM_COUNT ## x ## _2(y)
> > > +#define __LSM_COUNT1_0(x, y...) __LSM_COUNT ## x ## _1(y)
> > > +#define __LSM_COUNT(x, y...) __LSM_COUNT ## x ## _0(y)
> > > +
> > > +#define __LSM_COUNT_EXPAND(x...) __LSM_COUNT(x)
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY)
> > > +#define CAPABILITIES_ENABLED 1,
> > > +#else
> > > +#define CAPABILITIES_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
> > > +#define SELINUX_ENABLED 1,
> > > +#else
> > > +#define SELINUX_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_SMACK)
> > > +#define SMACK_ENABLED 1,
> > > +#else
> > > +#define SMACK_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_APPARMOR)
> > > +#define APPARMOR_ENABLED 1,
> > > +#else
> > > +#define APPARMOR_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_TOMOYO)
> > > +#define TOMOYO_ENABLED 1,
> > > +#else
> > > +#define TOMOYO_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_YAMA)
> > > +#define YAMA_ENABLED 1,
> > > +#else
> > > +#define YAMA_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_LOADPIN)
> > > +#define LOADPIN_ENABLED 1,
> > > +#else
> > > +#define LOADPIN_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM)
> > > +#define LOCKDOWN_ENABLED 1,
> > > +#else
> > > +#define LOCKDOWN_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_BPF_LSM)
> > > +#define BPF_LSM_ENABLED 1,
> > > +#else
> > > +#define BPF_LSM_ENABLED
> > > +#endif
> > > +
> > > +#if IS_ENABLED(CONFIG_BPF_LSM)
> > > +#define BPF_LSM_ENABLED 1,
> > > +#else
> > > +#define BPF_LSM_ENABLED
> > > +#endif
>
> duplicate that redefined BPF_LSM_ENABLED unnecessarily
>
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
> > > +#define LANDLOCK_ENABLED 1,
> > > +#else
> > > +#define LANDLOCK_ENABLED
> > > +#endif
> > > +
> > > +#define MAX_LSM_COUNT                        \
> > > +     __LSM_COUNT_EXPAND(             \
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
> > > +
> >
> > Wouldn't the following be simpler? It's from my LSM syscall patchset.
>
> Of course it would be, but unfortunately it doesn't work with the
> UNROLL() macro. This MAX_LSM_COUNT has to evaluate a compile-time
> integer *literal* (not any sort of expression), so that UNROLL(N,...)
> can do its magic.
>
>
> KP, this __LSM_COUNT_EXPAND() is actually doing exactly what already
> existing COUNT_ARGS() macro from linux/kernel.h does, which is
> implemented way more succinctly:
>
> #define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11,
> _12, _n, X...) _n
> #define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6,
> 5, 4, 3, 2, 1, 0)
>
>
> The only problem is that:
>
> #define ___COUNT_ARGS(args...) COUNT_ARGS(args)
> #define MAX_LSM_COUNT                   \
>         ___COUNT_ARGS(                  \
>                 CAPABILITIES_ENABLED    \
>                 SELINUX_ENABLED         \
>                 SMACK_ENABLED           \
>                 APPARMOR_ENABLED        \
>                 TOMOYO_ENABLED          \
>                 YAMA_ENABLED            \
>                 LOADPIN_ENABLED         \
>                 LOCKDOWN_ENABLED        \
>                 BPF_LSM_ENABLED         \
>                 LANDLOCK_ENABLED)
>
> overcounts by one, because of that trailing command within each
> XXX_ENABLED definition.
>
>
> But still, instead of a multi-line __LSM_COUNT{,1}_N set of macros, it
> might be better to use the COUNT_ARGS trick, but just account for
> those trailing commas? E.g., maybe just do a COUNT_COMMAS() macro
> which will adjust all the return values by 1 down, except when there
> is no comma (still 0).
>
> It's pretty minor in the grand scheme of things, but just something
> for you to be aware of.

I am back and revving this up again (after a hiatus due to health
stuff and then ramping back at work). Apologies for the radio silence
here.

I agree, Also if you notice CAPABILITIES_ENABLED is kinda bogus, and
CONFIG_SECURITY is used as a proxy, overcounting by 1 is actually what
I need. So, thanks, this makes it much simpler.

^^
(I realized I had replied the above to Andrii and not replied back to the l=
ist).

>
>
> > It certainly takes up fewer lines and would be easier to maintain
> > than the set of macros you've proposed.
> >
> > +#define LSM_COUNT ( \
> > +       (IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> > +       (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> >
> >
> > > +#endif  /* __LINUX_LSM_COUNT_H */
> >

