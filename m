Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58D8191CF7
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 23:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgCXWjR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 18:39:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41844 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgCXWjR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 18:39:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so620527wrc.8
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CsJTvGpVPmav8scr1f+8vGqJnRDlYhqVnGsY3dWNugM=;
        b=eFbp7iaJn1hT6hxrzF9p2+uV+G3iYIs+RbR8w+oGK0SWl0M4CdoFe9D5CI8MNBfLsT
         FhwxLc9CyARUimd4HUlZZOKRqVlcuOlFSP9Za+9D9NKccTdhiyawFfOKdUwa0n4aVQut
         bdVmJFSTEIUwO6Of5kw0HNRVyFy7EgOsn8Cy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CsJTvGpVPmav8scr1f+8vGqJnRDlYhqVnGsY3dWNugM=;
        b=q5oumPECbe5wwKf5nwqwlh3D0Osjrlm0Hfa+MMjpxf/pueiwasohSyA/Y8aPJk2qYB
         70Ka4iEaJU6DtDsrFlVrT61cZ8Esyx9QqReguuKcYhrMx5H75iywHa2W6DAOfp3izGPL
         MWJ6Sr/NNFjvfaeR+m66SjSd4qrRgwEuJ8jr4QyoPW35pG/1K5jtZoZ6Qzo3wwjhIOcL
         6sTl9XPr1drUCnXjrdjBCcawVwupOr7ClNT0bGYAF1dbSbMgHMHGLO6qo8D4mA4jR6si
         aoKV4zUB1BTjQSni7yas8llpVOER2tBAdQRwlraMTB1VXY9bEodQFMQKUEe5gBwn+sVP
         EjiQ==
X-Gm-Message-State: ANhLgQ1zKjpH2YMXQqg1/4UWhPw6tIyqldSL6LkWo8OKb7PC4S8Jhbvs
        zGi5oUYRZg4c/3Wf5HtRkNTPEw==
X-Google-Smtp-Source: ADFU+vvmq9phB+TJsSu5PlZjdZhx430KLaniYgGVncHAKBv0pYcKZqkSfT8jbwXzYfaMKem6odSqdQ==
X-Received: by 2002:adf:9322:: with SMTP id 31mr39623063wro.297.1585089553456;
        Tue, 24 Mar 2020 15:39:13 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id c21sm5509329wmb.13.2020.03.24.15.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 15:39:12 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 23:39:10 +0100
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
Message-ID: <20200324223910.GA5448@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-4-kpsingh@chromium.org>
 <CAEf4BzbRivYO=gVjuQw8Z8snN+RFwXswvNxs67c=5g6U3o9rmw@mail.gmail.com>
 <20200324103910.GA7135@chromium.org>
 <20200324161211.GA11227@chromium.org>
 <CAEf4BzZZLBf3xRsV4khGCFdTxDFV61KbFfV1mHwM5yiCr4P37w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZZLBf3xRsV4khGCFdTxDFV61KbFfV1mHwM5yiCr4P37w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24-Mär 14:26, Andrii Nakryiko wrote:
> On Tue, Mar 24, 2020 at 9:12 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 24-Mär 11:39, KP Singh wrote:
> > > On 23-Mär 12:59, Andrii Nakryiko wrote:
> > > > On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> > > > >
> > > > > From: KP Singh <kpsingh@google.com>
> > > > >
> > > > > When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> > > > > generated for each LSM hook. These nops are initialized as LSM hooks in
> > > > > a subsequent patch.
> > > > >
> > > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > > > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > > > > Reviewed-by: Florent Revest <revest@google.com>
> > > > > ---
> > > > >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> > > > >  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
> > > > >  2 files changed, 40 insertions(+)
> > > > >  create mode 100644 include/linux/bpf_lsm.h
> > > > >
> > > > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > > > new file mode 100644
> > > > > index 000000000000..c6423a140220
> > > > > --- /dev/null
> > > > > +++ b/include/linux/bpf_lsm.h
> > > > > @@ -0,0 +1,21 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +
> > > > > +/*
> > > > > + * Copyright (C) 2020 Google LLC.
> > > > > + */
> > > > > +
> > > > > +#ifndef _LINUX_BPF_LSM_H
> > > > > +#define _LINUX_BPF_LSM_H
> > > > > +
> > > > > +#include <linux/bpf.h>
> > > > > +#include <linux/lsm_hooks.h>
> > > > > +
> > > > > +#ifdef CONFIG_BPF_LSM
> > > > > +
> > > > > +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> > > > > +#include <linux/lsm_hook_names.h>
> > > > > +#undef LSM_HOOK
> > > > > +
> > > > > +#endif /* CONFIG_BPF_LSM */
> > > > > +
> > > > > +#endif /* _LINUX_BPF_LSM_H */
> > > > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > > index 82875039ca90..530d137f7a84 100644
> > > > > --- a/kernel/bpf/bpf_lsm.c
> > > > > +++ b/kernel/bpf/bpf_lsm.c
> > > > > @@ -7,6 +7,25 @@
> > > > >  #include <linux/filter.h>
> > > > >  #include <linux/bpf.h>
> > > > >  #include <linux/btf.h>
> > > > > +#include <linux/lsm_hooks.h>
> > > > > +#include <linux/bpf_lsm.h>
> > > > > +
> > > > > +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > > > > + * function where a BPF program can be attached as an fexit trampoline.
> > > > > + */
> > > > > +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> > > > > +
> > > > > +#define LSM_HOOK_int(NAME, ...)                        \
> > > > > +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)        \
> > > > > +{                                              \
> > > > > +       return 0;                               \
> > > > > +}
> > > > > +
> > > > > +#define LSM_HOOK_void(NAME, ...) \
> > > > > +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > > > > +
> > > >
> > > > Could unify with:
> > > >
> > > > #define LSM_HOOK(RET, NAME, ...) noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)
> > > > {
> > > >     return (RET)0;
> > > > }
> > > >
> > > > then you don't need LSM_HOOK_int and LSM_HOOK_void.
> > >
> > > Nice.
> > >
> > > But, given that we are adding default values and that
> > > they are only needed for int hooks, we will need to keep the macros
> > > separate for int and void. Or, Am I missing a trick here?
> > >
> > > - KP
> >
> > Actually, was able to get it work. not setting a default for void
> > hooks makes the macros messier. So i just set it void. For example:
> >
> >   LSM_HOOK(void, void, bprm_committing_creds, struct linux_binprm *bprm)
> 
> surprised this works, was going to propose to specify `(void)0` as
> default value :)

Yeah, you are right that does not work. so I added:

  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)

and as you suggested defined LSM_RET_VOID in lsm_hooks.h:

  /* LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
   * for void LSM hooks (in include/linux/lsm_hook_defs.h).
   */
  #define LSM_RET_VOID ((void) 0)

I also noticed a few other hooks that were passing an initial return
value to call_int_hook which were missed in this revision. Have fixed
these for the next one.

- KP

> 
> >
> > This also allows me to use the cleanup you suggested and not having
> > to split every usage into int and void.
> >
> 
> Nice, one of the reasons for proposing this.
> 
> > - KP
> >
> > >
> > > >
> > > > > +#include <linux/lsm_hook_names.h>
> > > > > +#undef LSM_HOOK
> > > > >
> > > > >  const struct bpf_prog_ops lsm_prog_ops = {
> > > > >  };
> > > > > --
> > > > > 2.20.1
> > > > >
