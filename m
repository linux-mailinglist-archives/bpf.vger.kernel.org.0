Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB52F36E7
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbhALRTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 12:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389699AbhALRTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 12:19:03 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C24C061575;
        Tue, 12 Jan 2021 09:18:22 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p187so5653730iod.4;
        Tue, 12 Jan 2021 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=srqt6Y89qTW4mBwwHjfq+IKr5DmD2opHzm/3uiqckvk=;
        b=JFCDeNlVTvDIVdKIghnAFx7UhqXWOH7cwkJYicmKYAcvQXSCc+zb+PR32cqNKH4SHe
         p3WpumJZvxd4zvq/iogpeARPdZpOdRC1GmW5Xkq7b3eCJYu3UF1D0tdNMGqZcTLUICOx
         xcJCCARk2nQvqS9v/zj3Xp86fp+Q0Lx/9O7+hA3qbDyXEiZovUx2fEQb/Z/tzKbBrgCT
         C/MKKpkdf/Cuc9tVsDqgBXgfXTZuRrRQ8oS4W5C2El8TlBrp6jPoKkapw9Xo34WdE36r
         wkeBM/blFucXhGIUn7U+TlP0r4B728IGPHMLXGHFGXqBQtH4TFtZbG9kO59FAQHm3bVI
         fTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=srqt6Y89qTW4mBwwHjfq+IKr5DmD2opHzm/3uiqckvk=;
        b=QCSwrgraUQBoOVp2LrRTUm1T07MrwuHxCAvTQSlMglaBDXmyNOi9RzwLc9ATlqqtft
         QcRwTklGRWt2OcDsdhwBJHbQaVTp7ufz7xg1ZsKhEocTZaK9ZpQ0rjt4KRfhLnpqJgqQ
         eXzShpepnLT1sTWxFqPBTU3SlImRxV5hcoq8oiLyTiBunPICJluKJPYKJPJayEChpOkd
         KKE454ObBz4IUyrnstMV48APRvIzeG4a2vSc4i6wEbC1VeCQvG9twkroO94NXzI2Ikwd
         bmYafyKC4kzzezSoeSU8qnkRZhxrLZ9R/oR5+n8EY2M7qub2OFauorGtPezlZl1bC5kD
         +k3A==
X-Gm-Message-State: AOAM530A0aR1KbuUOUGFQeu9YyVcvZ9Pm5GQ/Pj4hvaSe11D6ZwJ6umo
        aZaONLhvi+b5+QSGYFAeXMajtRIZIXZ7D+hcl0dTaKQ39LqkUg==
X-Google-Smtp-Source: ABdhPJwH1BzwamyJmOWv6FNyQGND5iJaBQJ8GrNM1KqTjpX1t+Kc36FjxmJYITTNuvZlECHZvoxf5+r5YX8kr+TeOr4=
X-Received: by 2002:a92:c692:: with SMTP id o18mr5030404ilg.215.1610471902079;
 Tue, 12 Jan 2021 09:18:22 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava> <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
 <20210112104622.GA1283572@krava> <20210112131012.GA1286331@krava>
 <CA+icZUXNEFyW-fKH_hNLd+s7PB3z=o+xe=B=ud7eA5T3SW6QFg@mail.gmail.com> <20210112162156.GA1291051@krava>
In-Reply-To: <20210112162156.GA1291051@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 12 Jan 2021 18:18:10 +0100
Message-ID: <CA+icZUXMqh81O0daap3gRHPUKL6VgfdDEiwqUO8igA0m45n-1w@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 5:22 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 12, 2021 at 05:14:42PM +0100, Sedat Dilek wrote:
> > On Tue, Jan 12, 2021 at 2:10 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 11:46:22AM +0100, Jiri Olsa wrote:
> > > > On Mon, Jan 11, 2021 at 02:34:04PM -0800, Tom Stellard wrote:
> > > > > On 1/11/21 2:31 PM, Jiri Olsa wrote:
> > > > > > On Mon, Jan 11, 2021 at 10:30:22PM +0100, Sedat Dilek wrote:
> > > > > >
> > > > > > SNIP
> > > > > >
> > > > > > > > >
> > > > > > > > > Building a new Linux-kernel...
> > > > > > > > >
> > > > > > > > > - Sedat -
> > > > > > > > >
> > > > > > > > > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> > > > > > > > > [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> > > > > > > > > [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
> > > > > > > >
> > > > > > > > There are no significant bug fixes between pahole 1.19 and master that
> > > > > > > > would solve this problem, so let's try to repro this.
> > > > > > > >
> > > > > > >
> > > > > > > You are right pahole fom latest Git does not solve the issue.
> > > > > > >
> > > > > > > + info BTFIDS vmlinux
> > > > > > > + [  != silent_ ]
> > > > > > > + printf   %-7s %s\n BTFIDS vmlinux
> > > > > > >   BTFIDS  vmlinux
> > > > > > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > > > > FAILED: load BTF from vmlinux: Invalid argument
> > > > > >
> > > > > > hm, is there a .BTF section in vmlinux?
> > > > > >
> > > > > > is this working over vmlinux:
> > > > > >   $ bpftool btf dump file ./vmlinux
> > > > > >
> > > > > > do you have a verbose build output? I'd think pahole scream first..
> > > > > >
> > > > >
> > > > > It does.  For me, pahole segfaults at scripts/link-vmlinux.sh:131.  This is
> > > > > pretty easy for me to reproduce.  I have logs, what other information would
> > > > > be helpful?  How about a pahole backtrace?
> > > >
> > > > that'd be great.. I'll try to reproduce, but with the latest clang
> > > > it will take me some time
> > >
> > > reproduced, attached pahole patch fixes it for me,
> > >
> > > looks like gcc never left function without name,
> > > which does not seem to be the case for clang
> > >
> > > I'll send full patch later today
> > >
> >
> > Thanks for the diff.
> >
> > Unfortunately, it does not apply on latest pahole git.
> >
> > $ git describe
> > v1.19-7-gb688e3597060
>
> sry wrong master.. how about this one
>

I have applied the previous diff on top of tagsv1.19.

Thanks for the follow-up.

Please CC me on the patch you wanted to send later.

- Sedat -

> jirka
>
>
> ---
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 333973054b61..17f7a14f2ef0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>
>         if (elf_sym__type(sym) != STT_FUNC)
>                 return 0;
> +       if (!elf_sym__name(sym, btfe->symtab))
> +               return 0;
>
>         if (functions_cnt == functions_alloc) {
>                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
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
> --
> 2.26.2
>
