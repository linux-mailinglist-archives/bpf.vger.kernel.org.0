Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0001915C9
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 17:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgCXQMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 12:12:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34294 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgCXQMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 12:12:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so5497657wrl.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6s+JUpZZOeulwwQp3hTdTer/dFhcYZR33uwW9/Pdmj8=;
        b=SggCZsD1MrTRy4N8yYgCYH48EYAh1jPTaqstdjfJmC1qrv87NVo4Pg4S2ZxTvxznBP
         1et1wVMZn2T1Va6fNb9fpoMZOF9c4yGcHHrHTIO9FIakp+uewzN24xryCxMz8BpF0A5k
         Wxu82j5SMx2RDgnEf0rvZHa9ZB+onHB2wwcGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6s+JUpZZOeulwwQp3hTdTer/dFhcYZR33uwW9/Pdmj8=;
        b=CFTDNta2BKi6LDfdSp3nZ/7gXHtZkN2AGazvDTVowZyiH8yz2BEhuM+cpBs6a0qEAx
         6mQlA1vPSu4RN0plTUpgA6Ak5fzVQXmLBY9cEsLDlxf2LIecmg4+8gljH7jiyAr1jyQO
         0FLxdJt+FkM8Rzclrs5DNhhIaaz7c0vEd9Ab7HpzaOS3lvgnxKiBB8EM1GRO63USl5d8
         G5BaCX8+sMg+GTVo3qhsMMAHl1aa/BHvmqcHL/3IM/K0Vjtp/+0a8ofWGvathSHd04gz
         k0lsBIovK6hIitvTwNBrRxDfnVCNdCH2pRf6ednkmiLZt2EYZtO8EG/kqb0W2wjDrmyU
         M1Pw==
X-Gm-Message-State: ANhLgQ32arOOnHRVqJ3c0wzIstYV0YiVOObe/K4Tfexs56NM+IWSV7cx
        iFR1r5iZsspZBnNS0cXVfpn1rg==
X-Google-Smtp-Source: ADFU+vuvN4rP+Kw/5KMx38ZbYgcOIc+Am32bNafbVVbJjxFCaDUxwfDZcgFtKLY10ged/UtQTzp9Rw==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr8491178wrn.14.1585066334052;
        Tue, 24 Mar 2020 09:12:14 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id i19sm4864977wmb.44.2020.03.24.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:12:13 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 17:12:11 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200324161211.GA11227@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-4-kpsingh@chromium.org>
 <CAEf4BzbRivYO=gVjuQw8Z8snN+RFwXswvNxs67c=5g6U3o9rmw@mail.gmail.com>
 <20200324103910.GA7135@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324103910.GA7135@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24-Mär 11:39, KP Singh wrote:
> On 23-Mär 12:59, Andrii Nakryiko wrote:
> > On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> > > generated for each LSM hook. These nops are initialized as LSM hooks in
> > > a subsequent patch.
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > > Reviewed-by: Florent Revest <revest@google.com>
> > > ---
> > >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > >  create mode 100644 include/linux/bpf_lsm.h
> > >
> > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > new file mode 100644
> > > index 000000000000..c6423a140220
> > > --- /dev/null
> > > +++ b/include/linux/bpf_lsm.h
> > > @@ -0,0 +1,21 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (C) 2020 Google LLC.
> > > + */
> > > +
> > > +#ifndef _LINUX_BPF_LSM_H
> > > +#define _LINUX_BPF_LSM_H
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <linux/lsm_hooks.h>
> > > +
> > > +#ifdef CONFIG_BPF_LSM
> > > +
> > > +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> > > +#include <linux/lsm_hook_names.h>
> > > +#undef LSM_HOOK
> > > +
> > > +#endif /* CONFIG_BPF_LSM */
> > > +
> > > +#endif /* _LINUX_BPF_LSM_H */
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 82875039ca90..530d137f7a84 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -7,6 +7,25 @@
> > >  #include <linux/filter.h>
> > >  #include <linux/bpf.h>
> > >  #include <linux/btf.h>
> > > +#include <linux/lsm_hooks.h>
> > > +#include <linux/bpf_lsm.h>
> > > +
> > > +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > > + * function where a BPF program can be attached as an fexit trampoline.
> > > + */
> > > +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> > > +
> > > +#define LSM_HOOK_int(NAME, ...)                        \
> > > +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)        \
> > > +{                                              \
> > > +       return 0;                               \
> > > +}
> > > +
> > > +#define LSM_HOOK_void(NAME, ...) \
> > > +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > > +
> > 
> > Could unify with:
> > 
> > #define LSM_HOOK(RET, NAME, ...) noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)
> > {
> >     return (RET)0;
> > }
> > 
> > then you don't need LSM_HOOK_int and LSM_HOOK_void.
> 
> Nice.
> 
> But, given that we are adding default values and that
> they are only needed for int hooks, we will need to keep the macros
> separate for int and void. Or, Am I missing a trick here?
> 
> - KP

Actually, was able to get it work. not setting a default for void
hooks makes the macros messier. So i just set it void. For example:

  LSM_HOOK(void, void, bprm_committing_creds, struct linux_binprm *bprm)

This also allows me to use the cleanup you suggested and not having
to split every usage into int and void.

- KP

> 
> > 
> > > +#include <linux/lsm_hook_names.h>
> > > +#undef LSM_HOOK
> > >
> > >  const struct bpf_prog_ops lsm_prog_ops = {
> > >  };
> > > --
> > > 2.20.1
> > >
