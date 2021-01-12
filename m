Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4512F3582
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 17:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406055AbhALQTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 11:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404959AbhALQPg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:36 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A39DC061786;
        Tue, 12 Jan 2021 08:14:56 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u26so5203179iof.3;
        Tue, 12 Jan 2021 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=H+V6PYGfHujj8OHzFjOm/1mBZP6vHjgBGUk7phqlIgA=;
        b=SSQCgmVpDQhM/H/nJvU42+SuigxHPfEiyvUQiViaibsmhvTgWYHxz640PwVcGX5Jgd
         WhaCQmXLAsJ+W5w43mqI0z6Ppw+kpuWVYI8ILJtZiOao75xwDgYSyvU4qsjQdGiO98hu
         NMogsVoEIX1pyHQ23wwTqIrHUH/Qz9QQMz/quY207qMZ9wxTRJqerg9rAWCmsxflsywF
         52hDIRRLAd7bd5YnLyuGjeZXYFewr+l3Oxja5/U7jS9LMopKQFDYgydnc9NyAlmWgNUG
         JXv9sfjugAY4ZMTesRoghjz2VClpxdc7Zzt3lwgBp6syDfpierrAOq5AecljI3JbxKnw
         8MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=H+V6PYGfHujj8OHzFjOm/1mBZP6vHjgBGUk7phqlIgA=;
        b=W++Tjs0Mz41RZxpOEtaNkcNL24oVLgala45SZqSCw/h0qP+negMEc+EBgw+EfLclSH
         pKXfFkAtOVmQSXWI/MfImChL4CnUWfnUPgZwTkX7tl8/b5z7MplyXGx46ODLxvghQOj3
         TplyNIHCkI9MKmOaTg+j86i+EXVKadKDoQyadhs79Mw62MwZ+vNCSSODG0u0DKNHHiXu
         Z4ZBgKEQHI3rP/BE2PiP8TXZeeLN/Drd1HEbC3kBfj71JV9wMf7Mhar9htsdz6PZmjHi
         O+DcF6SCCCLZ5xZzg+3RCxFK5W9bETlvzBtG0WgnHvVPhdlpeThuQYaHS0CGaTG6Ia6R
         m5jg==
X-Gm-Message-State: AOAM530ByoKUzFUJecyBpawjwTgdJS+vq4F4b75Uf7YiqhIeNMX8yQ2s
        uLf5C6XfuU1jiYFQWztDkJcDSl4YC6yVJLXbWGg=
X-Google-Smtp-Source: ABdhPJwNm4ujx/hWwgMOAmCtwkxb8DtQOC9C6wmbhyn4jNA5JH+hsQ3Uvyn56Kp/05Ylccu6CkeU6t5qUrpsh75ec4o=
X-Received: by 2002:a5e:d70e:: with SMTP id v14mr3836659iom.75.1610468095552;
 Tue, 12 Jan 2021 08:14:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava> <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
 <20210112104622.GA1283572@krava> <20210112131012.GA1286331@krava>
In-Reply-To: <20210112131012.GA1286331@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 12 Jan 2021 17:14:42 +0100
Message-ID: <CA+icZUXNEFyW-fKH_hNLd+s7PB3z=o+xe=B=ud7eA5T3SW6QFg@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tom Stellard <tstellar@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 2:10 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 12, 2021 at 11:46:22AM +0100, Jiri Olsa wrote:
> > On Mon, Jan 11, 2021 at 02:34:04PM -0800, Tom Stellard wrote:
> > > On 1/11/21 2:31 PM, Jiri Olsa wrote:
> > > > On Mon, Jan 11, 2021 at 10:30:22PM +0100, Sedat Dilek wrote:
> > > >
> > > > SNIP
> > > >
> > > > > > >
> > > > > > > Building a new Linux-kernel...
> > > > > > >
> > > > > > > - Sedat -
> > > > > > >
> > > > > > > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> > > > > > > [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> > > > > > > [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
> > > > > >
> > > > > > There are no significant bug fixes between pahole 1.19 and master that
> > > > > > would solve this problem, so let's try to repro this.
> > > > > >
> > > > >
> > > > > You are right pahole fom latest Git does not solve the issue.
> > > > >
> > > > > + info BTFIDS vmlinux
> > > > > + [  != silent_ ]
> > > > > + printf   %-7s %s\n BTFIDS vmlinux
> > > > >   BTFIDS  vmlinux
> > > > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > > FAILED: load BTF from vmlinux: Invalid argument
> > > >
> > > > hm, is there a .BTF section in vmlinux?
> > > >
> > > > is this working over vmlinux:
> > > >   $ bpftool btf dump file ./vmlinux
> > > >
> > > > do you have a verbose build output? I'd think pahole scream first..
> > > >
> > >
> > > It does.  For me, pahole segfaults at scripts/link-vmlinux.sh:131.  This is
> > > pretty easy for me to reproduce.  I have logs, what other information would
> > > be helpful?  How about a pahole backtrace?
> >
> > that'd be great.. I'll try to reproduce, but with the latest clang
> > it will take me some time
>
> reproduced, attached pahole patch fixes it for me,
>
> looks like gcc never left function without name,
> which does not seem to be the case for clang
>
> I'll send full patch later today
>

Thanks for the diff.

Unfortunately, it does not apply on latest pahole git.

$ git describe
v1.19-7-gb688e3597060

- Sedat -

> jirka
>
>
> ---
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c40f059580da..781fb35a2646 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -70,6 +70,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>                 return 0;
>         if (!elf_sym__value(sym))
>                 return 0;
> +       if (!elf_sym__name(sym, btfe->symtab))
> +               return 0;
>
>         if (functions_cnt == functions_alloc) {
>                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> @@ -620,9 +622,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 if (!has_arg_names(cu, &fn->proto))
>                         continue;
>                 if (functions_cnt) {
> -                       struct elf_function *func;
> +                       const char *name = function__name(fn, cu);
> +                       struct elf_function *func = NULL;
>
> -                       func = find_function(btfe, function__name(fn, cu));
> +                       if (name)
> +                               func = find_function(btfe, name);
>                         if (!func || func->generated)
>                                 continue;
>                         func->generated = true;
>
