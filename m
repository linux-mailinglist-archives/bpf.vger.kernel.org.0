Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60975191BE9
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 22:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCXV1J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 17:27:09 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42070 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXV1I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 17:27:08 -0400
Received: by mail-qv1-f67.google.com with SMTP id ca9so10048958qvb.9;
        Tue, 24 Mar 2020 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VEJoT2ftN3/J+JzBUUMUSAFQV5uekS8p6QQqfLbkw4A=;
        b=oFV80YsDBCCQS0H4uydp2GAraoKy7ypaOl2OlD8XbZYroGuz5VpxBZxfoVMgGBvuQc
         TAiLpIF5hcEfbtGLKjdqpM7ILoJvZ77DINUgNK+ljR2xi72jnvWddbKxIvlaEAkzGQz0
         jfbHfUrL7KAIm2RBEoyYfRUy6GRc4G6BwQbOgsHunw7c4GDpx1tXhGWJ2efEdhX1JEve
         PXSCvO38IkqekjcBSShUg+QPHwEeWr8xAO1AejfTANdqvPGSRfWKYyGa9mR98hazvVGe
         asS4dfkNHeWJgd8fNvwgSRQQNONdT8/31nSsRRJVI8wvjD8QwQmKmJltOXDL6R8+WyQA
         AwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VEJoT2ftN3/J+JzBUUMUSAFQV5uekS8p6QQqfLbkw4A=;
        b=RUf/ivsbbPqhMBIMgV3NBq72E8Lt0ykepGzQPT11t0Njbi+OkgF8IuLYGKrxQn7tF+
         cLMCEMo8txjKQxoOBV8JAkHj+uDEgrK5uzN1L4JTijtmQRFZRgLeJo6T5QtGEBf62bxi
         xUQReLHqbvn6KoXdqB2+RlWksKsGIyVWvZq0NYWiXpffchLX/GzAr7p3I5pUdIo+2oSU
         kwrMSvmcrnovd1xX/Z8+FojJ/ziWESKhLFifDg60E/ezMx9Sl43/eNxYVAPqpIU8PAIX
         RtskwiR4A6yV1ODAmhURTvSVwTHWU6FM58QjtkCVYM//6iwxXxLiE9VMpFE12WKVoWhM
         Qb8w==
X-Gm-Message-State: ANhLgQ3BvvZiOXX2bu7AnJyFcVpqMkZj83qIygsIFUv6itlUI5LktzSz
        J9fPTiQahaQRvNzCZ87vYx5VegRRNEH5KkTon10=
X-Google-Smtp-Source: ADFU+vvnlC2tuBiX08DOSzyNzyZRiEDqPSX5ECF8NjcPaR1qvgPpgcPX+NbxgqdXH4UO5KxsSJRb91QXeEmgiswfoFM=
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr178148qvs.196.1585085226618;
 Tue, 24 Mar 2020 14:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-4-kpsingh@chromium.org>
 <CAEf4BzbRivYO=gVjuQw8Z8snN+RFwXswvNxs67c=5g6U3o9rmw@mail.gmail.com>
 <20200324103910.GA7135@chromium.org> <20200324161211.GA11227@chromium.org>
In-Reply-To: <20200324161211.GA11227@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 24 Mar 2020 14:26:55 -0700
Message-ID: <CAEf4BzZZLBf3xRsV4khGCFdTxDFV61KbFfV1mHwM5yiCr4P37w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 24, 2020 at 9:12 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 24-M=C3=A4r 11:39, KP Singh wrote:
> > On 23-M=C3=A4r 12:59, Andrii Nakryiko wrote:
> > > On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote=
:
> > > >
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>=
, are
> > > > generated for each LSM hook. These nops are initialized as LSM hook=
s in
> > > > a subsequent patch.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > > > Reviewed-by: Florent Revest <revest@google.com>
> > > > ---
> > > >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> > > >  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
> > > >  2 files changed, 40 insertions(+)
> > > >  create mode 100644 include/linux/bpf_lsm.h
> > > >
> > > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > > new file mode 100644
> > > > index 000000000000..c6423a140220
> > > > --- /dev/null
> > > > +++ b/include/linux/bpf_lsm.h
> > > > @@ -0,0 +1,21 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +/*
> > > > + * Copyright (C) 2020 Google LLC.
> > > > + */
> > > > +
> > > > +#ifndef _LINUX_BPF_LSM_H
> > > > +#define _LINUX_BPF_LSM_H
> > > > +
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/lsm_hooks.h>
> > > > +
> > > > +#ifdef CONFIG_BPF_LSM
> > > > +
> > > > +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> > > > +#include <linux/lsm_hook_names.h>
> > > > +#undef LSM_HOOK
> > > > +
> > > > +#endif /* CONFIG_BPF_LSM */
> > > > +
> > > > +#endif /* _LINUX_BPF_LSM_H */
> > > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > index 82875039ca90..530d137f7a84 100644
> > > > --- a/kernel/bpf/bpf_lsm.c
> > > > +++ b/kernel/bpf/bpf_lsm.c
> > > > @@ -7,6 +7,25 @@
> > > >  #include <linux/filter.h>
> > > >  #include <linux/bpf.h>
> > > >  #include <linux/btf.h>
> > > > +#include <linux/lsm_hooks.h>
> > > > +#include <linux/bpf_lsm.h>
> > > > +
> > > > +/* For every LSM hook  that allows attachment of BPF programs, dec=
lare a NOP
> > > > + * function where a BPF program can be attached as an fexit trampo=
line.
> > > > + */
> > > > +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> > > > +
> > > > +#define LSM_HOOK_int(NAME, ...)                        \
> > > > +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)        \
> > > > +{                                              \
> > > > +       return 0;                               \
> > > > +}
> > > > +
> > > > +#define LSM_HOOK_void(NAME, ...) \
> > > > +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > > > +
> > >
> > > Could unify with:
> > >
> > > #define LSM_HOOK(RET, NAME, ...) noinline __weak RET bpf_lsm_##NAME(_=
_VA_ARGS__)
> > > {
> > >     return (RET)0;
> > > }
> > >
> > > then you don't need LSM_HOOK_int and LSM_HOOK_void.
> >
> > Nice.
> >
> > But, given that we are adding default values and that
> > they are only needed for int hooks, we will need to keep the macros
> > separate for int and void. Or, Am I missing a trick here?
> >
> > - KP
>
> Actually, was able to get it work. not setting a default for void
> hooks makes the macros messier. So i just set it void. For example:
>
>   LSM_HOOK(void, void, bprm_committing_creds, struct linux_binprm *bprm)

surprised this works, was going to propose to specify `(void)0` as
default value :)

>
> This also allows me to use the cleanup you suggested and not having
> to split every usage into int and void.
>

Nice, one of the reasons for proposing this.

> - KP
>
> >
> > >
> > > > +#include <linux/lsm_hook_names.h>
> > > > +#undef LSM_HOOK
> > > >
> > > >  const struct bpf_prog_ops lsm_prog_ops =3D {
> > > >  };
> > > > --
> > > > 2.20.1
> > > >
