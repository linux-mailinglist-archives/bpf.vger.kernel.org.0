Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FAE333106
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 22:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCIViE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 16:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhCIVhm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Mar 2021 16:37:42 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48635C06174A;
        Tue,  9 Mar 2021 13:37:42 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c131so15514382ybf.7;
        Tue, 09 Mar 2021 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUTKFUkpxhc9e1+up74+YS6CfVctVBYX90u6KfCtM5Y=;
        b=H1QbLrVehyAvXO2kDeit1FQie0gIOSHVUGNgNLMFT51frraARLHNpxgwWVKlOz6EBY
         FxMGaYyNj539nfOnR2culcWv+XRPguKMTqzn6kid1Bwqt5WzdLaTurIL5GQaKL84O1hL
         LH1e+ikewCBvXwLt5ghYM1mOdd9gDoCtjLYjNJ0dhEn4JROzOYRBClMFv2YBZqFjXtR9
         EHQE5L32uMkg2xk8n4vFED8IdGLIEmiWivIy80P65Z8bTdxOKHk0ZReD9ENtxq7bB7hm
         Z3EdOMosTveu16tW959FGzUiOnPncwvLQJejNVKq7jX6me1mS13sj1v1FpSAge9cc0KN
         6o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUTKFUkpxhc9e1+up74+YS6CfVctVBYX90u6KfCtM5Y=;
        b=qDHVcEaBRClaVca58mZkJgTy1jdBQLOnlgzvpe6xOk+hNS8stZNzq/0pPkeN4QNbDG
         /T25/3j6FSWwqZDR4n4r1prLnO+YhUf0NeXR/G1iwy9GHUqW5AYZuY9Pw9Vtmj7A+krO
         1fYwQBY2F4TpYtNFk1VH2CN0PeZ9RRZR5yUlEmAZTY3ISSUQa4n67YaJVOfxutnKCfii
         f1kqLWW15bpP2wn9fdGsdAXETxYifoNkRaKQvewsJSOVKj4SpGsnJ58jawlpv+P5zoix
         xhmeyVAFDOOPmrxSD0nl3A4orOAedMJvrNNc9vgOwB8Y2WXIn8CJ9F4EmiVdjccGXKZ7
         7Rwg==
X-Gm-Message-State: AOAM532JnRG7ku7ouBA85FbeGHoIpGlO/AZM7Gx/Jy9K5kKnch9XuRFK
        kKVIjtVQ55WnT2qT4wZnqIHIlvwtYLGbgFox382gZ5r+wl0=
X-Google-Smtp-Source: ABdhPJxyA5RGnVqGROakBdw+DE3Nu2Fv1IUM1YVmJIk921tLCMV1EoyDQ0VwGmeEuC3gP9b1MrLia/1zSsiiPk5oswo=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr45061967yba.347.1615325861536;
 Tue, 09 Mar 2021 13:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20210308235913.162038-1-iii@linux.ibm.com> <YEdglMDZvplD6ELk@kernel.org>
In-Reply-To: <YEdglMDZvplD6ELk@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Mar 2021 13:37:30 -0800
Message-ID: <CAEf4BzaN0XwrAaTNe4TojT8UfStvGUfQSJuSQ8CcMtLAgOu9iw@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf: Add support for the floating-point types
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 9, 2021 at 3:48 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Mar 09, 2021 at 12:59:13AM +0100, Ilya Leoshkevich escreveu:
> > Some BPF programs compiled on s390 fail to load, because s390
> > arch-specific linux headers contain float and double types.
> >
> > Fix as follows:
> >
> > - Make the DWARF loader fill base_type.float_type.
> >
> > - Introduce libbpf compatibility level command-line parameter, so that
> >   pahole could be used to build both the older and the newer kernels.
> >
> > - libbpf introduced the support for the floating-point types in commit
> >   986962fade5, so update the libbpf submodule to that version and use
> >   the new btf__add_float() function in order to emit the floating-point
> >   types when not in the compatibility mode and base_type.float_type is
> >   set.
> >
> > - Make the BTF loader recognize the new BTF kind.
> >
> > Example of the resulting entry in the vmlinux BTF:
> >
> >     [7164] FLOAT 'double' size=8
> >
> > when building with:
> >
> >     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --libbpf_compat=0.4.0
>
> I'm testing it now, and added as a followup patch the man page entry,
> please check that the wording is appropriate.
>
> Thanks,
>
> - Arnaldo
>
> [acme@five pahole]$ vim man-pages/pahole.1
> [acme@five pahole]$ git diff
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 352bb5e45f319da4..787771753d1933b1 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -199,6 +199,12 @@ Path to the base BTF file, for instance: vmlinux when encoding kernel module BTF
>  This may be inferred when asking for a /sys/kernel/btf/MODULE, when it will be autoconfigured
>  to "/sys/kernel/btf/vmlinux".
>
> +.TP
> +.B \-\-libbpf_compat=LIBBPF_VERSION
> +Produce output compatible with this libbpf version. For instance, specifying 0.4.0 as
> +the version would encode BTF_KIND_FLOAT entries in systems where the vmlinux DWARF
> +information has float types.

TBH, I think it's not exactly right to call out libbpf version here.
It's BTF "version" (if we had such a thing) that determines the set of
supported BTF kinds. There could be other libraries that might want to
parse BTF. So I don't know what this should be called, but
libbpf_compat is probably a wrong name for it.

If we do want to teach pahole to not emit some parts of BTF, it should
probably be a set of BPF features, not some arbitrary library
versions.


> +
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
>  Show first biggest size base_type member.
> [acme@five pahole]$
