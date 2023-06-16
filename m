Return-Path: <bpf+bounces-2772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F9733C68
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 00:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419251C2104F
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90179EA;
	Fri, 16 Jun 2023 22:27:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936C6FB5
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 22:27:22 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0B2D6B;
	Fri, 16 Jun 2023 15:27:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a3f911135so1272032a12.2;
        Fri, 16 Jun 2023 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686954439; x=1689546439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgNYOZdyMOwSHnpOJ7lvM3rZtCedpFSxafavg3976zw=;
        b=AolVwGPNkzPMFPI3MMGklY2inBtrhVzGKISimrIuwyDPVLgdWZarAN9G9CszVtFqR4
         /FonPVGxZsGyxqOrWnOevLiIL2zF8iNZo0NKANzEIWAHx+iM033GNzI552PFZ5FUFpNn
         m3O3fdqQ7rX7Eo5T9iBPiNm8lQ7fkflJF8fFzb1TlinC+noOLpIxx9fnU9nYfP9ywU+r
         kFnMRXJ3sBUR+SdlOlSPS6tsSoApVptQ3t03OxU9j0HKtPEEojQk49fo/1ShDLv0HRiB
         3Y3Ora1yb7Kmb0IxzdAVefxfgEHUfISUVvy4rScI8lI762XPJ6zNYPigRVQKRPPK7ELn
         O4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954439; x=1689546439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgNYOZdyMOwSHnpOJ7lvM3rZtCedpFSxafavg3976zw=;
        b=G4L61vlYo9iwZPTdf8RGn18Fbtt8rLhv/64LRL6aG//d58A9eAuDVqamTnY7ocWquL
         P34Q9bBhlC8MvPDJrWRThxWTwmTiPqBZH8c2u07PMWiE3bPlbKcZzqBMf5M8KAQBFjpZ
         QDJkyT+APBzmyu99H0URGZr/0RLyTdmYCs0EhnWEGhdddsBZGb5d72St4S0ONBeWSApc
         BOU7z9C1KmwyIsIvBDqp3TYJM661S6/osofPdDcUuAEgpx+U3YxZKeYI8lJiSizmTmVr
         QNaiFQZIeVCVF8yYzXC6bdktlXYLFXyMCxSBqUu9avDNXYDfZrvw4dVy4Dt0Q3XzjNG2
         APZw==
X-Gm-Message-State: AC+VfDx7zj1Ye5iwGijdUA2U35oWwejVuoaw4N2repzT2Z3x1wE6nmQg
	LE3w1bAU8qAw1Wt2Evj7V3FGCO87Xvti/zf4rjvCIpqF489zGg==
X-Google-Smtp-Source: ACHHUZ6Ba/HBPWlSZGi+4owH5RtCSL4uNeN8wzM8KHp6yrt2IXy39aFYOC0YN+lrzvU107VFUUx6fDS1FX4abrsBrXU=
X-Received: by 2002:aa7:d287:0:b0:518:7bc3:4cec with SMTP id
 w7-20020aa7d287000000b005187bc34cecmr2137472edq.22.1686954438566; Fri, 16 Jun
 2023 15:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-3-kpsingh@kernel.org>
 <72bd13a2-a5b3-328e-a751-87102107293e@schaufler-ca.com>
In-Reply-To: <72bd13a2-a5b3-328e-a751-87102107293e@schaufler-ca.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 15:27:06 -0700
Message-ID: <CAEf4BzYuurXCTfqkfLc3RvWZiUzJ2am2GwcYgZgiEb91cGGZaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] security: Count the LSMs enabled at compile time
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, paul@paul-moore.com, keescook@chromium.org, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, jannh@google.com, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 5:38=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 6/15/2023 5:04 PM, KP Singh wrote:
> > These macros are a clever trick to determine a count of the number of
> > LSMs that are enabled in the config to ascertain the maximum number of
> > static calls that need to be configured per LSM hook.
> >
> > Without this one would need to generate static calls for (number of
> > possible LSMs * number of LSM hooks) which ends up being quite wasteful
> > especially when some LSMs are not compiled into the kernel.
> >
> > Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/lsm_count.h | 131 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644 include/linux/lsm_count.h
> >
> > diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> > new file mode 100644
> > index 000000000000..818f62ffa723
> > --- /dev/null
> > +++ b/include/linux/lsm_count.h
> > @@ -0,0 +1,131 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (C) 2023 Google LLC.
> > + */
> > +
> > +#ifndef __LINUX_LSM_COUNT_H
> > +#define __LINUX_LSM_COUNT_H
> > +
> > +#include <linux/kconfig.h>
> > +
> > +/*
> > + * Macros to count the number of LSMs enabled in the kernel at compile=
 time.
> > + */
> > +
> > +#define __LSM_COUNT_15(x, y...) 15
> > +#define __LSM_COUNT_14(x, y...) 14
> > +#define __LSM_COUNT_13(x, y...) 13
> > +#define __LSM_COUNT_12(x, y...) 12
> > +#define __LSM_COUNT_11(x, y...) 11
> > +#define __LSM_COUNT_10(x, y...) 10
> > +#define __LSM_COUNT_9(x, y...) 9
> > +#define __LSM_COUNT_8(x, y...) 8
> > +#define __LSM_COUNT_7(x, y...) 7
> > +#define __LSM_COUNT_6(x, y...) 6
> > +#define __LSM_COUNT_5(x, y...) 5
> > +#define __LSM_COUNT_4(x, y...) 4
> > +#define __LSM_COUNT_3(x, y...) 3
> > +#define __LSM_COUNT_2(x, y...) 2
> > +#define __LSM_COUNT_1(x, y...) 1
> > +#define __LSM_COUNT_0(x, y...) 0
> > +
> > +#define __LSM_COUNT1_15(x, y...) __LSM_COUNT ## x ## _15(y)
> > +#define __LSM_COUNT1_14(x, y...) __LSM_COUNT ## x ## _14(y)
> > +#define __LSM_COUNT1_13(x, y...) __LSM_COUNT ## x ## _13(y)
> > +#define __LSM_COUNT1_12(x, y...) __LSM_COUNT ## x ## _12(y)
> > +#define __LSM_COUNT1_10(x, y...) __LSM_COUNT ## x ## _11(y)
> > +#define __LSM_COUNT1_9(x, y...) __LSM_COUNT ## x ## _10(y)
> > +#define __LSM_COUNT1_8(x, y...) __LSM_COUNT ## x ## _9(y)
> > +#define __LSM_COUNT1_7(x, y...) __LSM_COUNT ## x ## _8(y)
> > +#define __LSM_COUNT1_6(x, y...) __LSM_COUNT ## x ## _7(y)
> > +#define __LSM_COUNT1_5(x, y...) __LSM_COUNT ## x ## _6(y)
> > +#define __LSM_COUNT1_4(x, y...) __LSM_COUNT ## x ## _5(y)
> > +#define __LSM_COUNT1_3(x, y...) __LSM_COUNT ## x ## _4(y)
> > +#define __LSM_COUNT1_2(x, y...) __LSM_COUNT ## x ## _3(y)
> > +#define __LSM_COUNT1_1(x, y...) __LSM_COUNT ## x ## _2(y)
> > +#define __LSM_COUNT1_0(x, y...) __LSM_COUNT ## x ## _1(y)
> > +#define __LSM_COUNT(x, y...) __LSM_COUNT ## x ## _0(y)
> > +
> > +#define __LSM_COUNT_EXPAND(x...) __LSM_COUNT(x)
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY)
> > +#define CAPABILITIES_ENABLED 1,
> > +#else
> > +#define CAPABILITIES_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
> > +#define SELINUX_ENABLED 1,
> > +#else
> > +#define SELINUX_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_SMACK)
> > +#define SMACK_ENABLED 1,
> > +#else
> > +#define SMACK_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_APPARMOR)
> > +#define APPARMOR_ENABLED 1,
> > +#else
> > +#define APPARMOR_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_TOMOYO)
> > +#define TOMOYO_ENABLED 1,
> > +#else
> > +#define TOMOYO_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_YAMA)
> > +#define YAMA_ENABLED 1,
> > +#else
> > +#define YAMA_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_LOADPIN)
> > +#define LOADPIN_ENABLED 1,
> > +#else
> > +#define LOADPIN_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM)
> > +#define LOCKDOWN_ENABLED 1,
> > +#else
> > +#define LOCKDOWN_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_BPF_LSM)
> > +#define BPF_LSM_ENABLED 1,
> > +#else
> > +#define BPF_LSM_ENABLED
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_BPF_LSM)
> > +#define BPF_LSM_ENABLED 1,
> > +#else
> > +#define BPF_LSM_ENABLED
> > +#endif

duplicate that redefined BPF_LSM_ENABLED unnecessarily

> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
> > +#define LANDLOCK_ENABLED 1,
> > +#else
> > +#define LANDLOCK_ENABLED
> > +#endif
> > +
> > +#define MAX_LSM_COUNT                        \
> > +     __LSM_COUNT_EXPAND(             \
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
> > +
>
> Wouldn't the following be simpler? It's from my LSM syscall patchset.

Of course it would be, but unfortunately it doesn't work with the
UNROLL() macro. This MAX_LSM_COUNT has to evaluate a compile-time
integer *literal* (not any sort of expression), so that UNROLL(N,...)
can do its magic.


KP, this __LSM_COUNT_EXPAND() is actually doing exactly what already
existing COUNT_ARGS() macro from linux/kernel.h does, which is
implemented way more succinctly:

#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11,
_12, _n, X...) _n
#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6,
5, 4, 3, 2, 1, 0)


The only problem is that:

#define ___COUNT_ARGS(args...) COUNT_ARGS(args)
#define MAX_LSM_COUNT                   \
        ___COUNT_ARGS(                  \
                CAPABILITIES_ENABLED    \
                SELINUX_ENABLED         \
                SMACK_ENABLED           \
                APPARMOR_ENABLED        \
                TOMOYO_ENABLED          \
                YAMA_ENABLED            \
                LOADPIN_ENABLED         \
                LOCKDOWN_ENABLED        \
                BPF_LSM_ENABLED         \
                LANDLOCK_ENABLED)

overcounts by one, because of that trailing command within each
XXX_ENABLED definition.


But still, instead of a multi-line __LSM_COUNT{,1}_N set of macros, it
might be better to use the COUNT_ARGS trick, but just account for
those trailing commas? E.g., maybe just do a COUNT_COMMAS() macro
which will adjust all the return values by 1 down, except when there
is no comma (still 0).

It's pretty minor in the grand scheme of things, but just something
for you to be aware of.


> It certainly takes up fewer lines and would be easier to maintain
> than the set of macros you've proposed.
>
> +#define LSM_COUNT ( \
> +       (IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
>
>
> > +#endif  /* __LINUX_LSM_COUNT_H */
>

