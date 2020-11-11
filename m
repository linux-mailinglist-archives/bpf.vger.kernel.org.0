Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66662AF9D5
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 21:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgKKUhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 15:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgKKUhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 15:37:07 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CA3C0613D1;
        Wed, 11 Nov 2020 12:37:07 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id g6so1923537ybm.7;
        Wed, 11 Nov 2020 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=og6jg+WzcwFdyx8K2EaLlWAtE28tBTo2SuQIP+faRHQ=;
        b=Qg48dzHpn2sznoD8e9PxO7GhO8d+oJjIof7u0afkK/eU+D40AueyXPMQJMe+CTH9QQ
         hvy0DDSIDv2dky6gNfD/m438gHPVL8t03DUp2Dd11n2vq+q9QAWAa+N3+z3CJP2QLzjx
         Vo0CDMtEJAVZKhM4bk96B4uC0DMzEq/oZJwmxBd4maUkKCbWNRo24m4gXFXtQloBa0a3
         CfEcUKw2ijJwIwRwqYtRFbZPw4DiwNb9CkVQL29Pdzw4QDmekJbaiwqDll9ss9xXm8gt
         nP913Z66S12ZFdrSeI7qX/xJ+Kg+WH+R8H+P8NgLIg0+3YaZJj4e8xk50goa8YftVCmy
         9mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=og6jg+WzcwFdyx8K2EaLlWAtE28tBTo2SuQIP+faRHQ=;
        b=RlnSerNKUyoZVLmyGoU4LcB34FYm48iP3WvbMeOVaRTikjf4jQlWCATrTU55U6NaU7
         EL6t1Dd4XqvguSROSpwE78IFTsZ4OPXUa7Sol5JJjYkoUdBJoTE6UBfmsDisN4dhjMNv
         O+IIafIkP2MohOAqS+KLQJEmFdthBdRB/qjSHZOfoI2GYQP6Dlp27DwXw8WuflIE7YL5
         FYuloAD5QpKXqd+sI1Z4XxbHp6JPu/rvrtt7OkPt+bTuBydGZXwFpntPMUqSwnwcedUU
         dTSnJTJVo5+lBDeIwUrg1JmlA3HMxgQzttQ6YenZ4wtSdxt7LZ8Kwrf08iMv6eMXoFV3
         0PsQ==
X-Gm-Message-State: AOAM532zGoM78nbFxH15rZxoZHdZAzIxfBDZoSSoakMTihtlTYvxGid4
        I12rzuCZxFgAFRiQloQr7eq+RsApnylEPdpiQeE=
X-Google-Smtp-Source: ABdhPJzfReu5zwWiAT1o7vrPdw5jaJXbeVye3aK9wWhHgRwkRBWCAdK/W9HMx1hKkuKy12IXB4qwd+W3B1Xqe+1D5hU=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr23980844ybd.27.1605127026620;
 Wed, 11 Nov 2020 12:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20201106222512.52454-1-jolsa@kernel.org> <20201106222512.52454-4-jolsa@kernel.org>
 <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com>
 <20201111201929.GB619201@krava> <20201111203130.GC619201@krava>
In-Reply-To: <20201111203130.GC619201@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 12:36:55 -0800
Message-ID: <CAEf4BzZ089_ECxY_tFBMUc5c-rwtD9Mw8n7anUsdgpzgoipsPg@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken dwarf
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 12:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 11, 2020 at 09:19:29PM +0100, Jiri Olsa wrote:
> > On Wed, Nov 11, 2020 at 11:59:20AM -0800, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > > +       if (!fl->init_bpf_begin &&
> > > > +           !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
> > > > +               fl->init_bpf_begin = sym->st_value;
> > > > +
> > > > +       if (!fl->init_bpf_end &&
> > > > +           !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
> > > > +               fl->init_bpf_end = sym->st_value;
> > > > +}
> > > > +
> > > > +static int has_all_symbols(struct funcs_layout *fl)
> > > > +{
> > > > +       return fl->mcount_start && fl->mcount_stop &&
> > > > +              fl->init_begin && fl->init_end &&
> > > > +              fl->init_bpf_begin && fl->init_bpf_end;
> > >
> > > See below for what seems to be the root cause for the immediate problem.
> > >
> > > But me, Alexei and Daniel had a discussion offline, and we concluded
> > > that this special bpf_preserve_init section is probably not the right
> > > approach overall. We should roll back the bpf patch and instead adjust
> > > pahole's approach. I think we should just drop the __init check and
> > > include all the __init functions into BTF. There could be cases where
> > > we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
> > > security cases), so having BTFs for those FUNCs are necessary as well.
> > > Ftrace currently disallows that, but it's only because no user-space
> > > application has a way to attach probes early enough. This might change
> > > in the future, so there is no need to invent special mechanisms now
> > > for bpf_iter function preservation. Let's just include all __init
> > > functions in BTF. Can you please do that change and check how much
> > > more functions we get in BTF? Thanks!
> >
> > sure, not problem to keep all init functions, will give you the count
>
> with pahole change below (on top of current master) and kernel
> without the special init section, I'm getting over ~2000 functions
> more on my .config:
>
>   $ bpftool btf dump file ./vmlinux | grep 'FUNC ' | wc -l
>   41505
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep 'FUNC ' | wc -l
>   39256

That's a very small percentage increase, let's just do this.

>
> jirka
>
>

[...]
