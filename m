Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F82A8882
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 22:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgKEVGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 16:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 16:06:02 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A5C0613CF;
        Thu,  5 Nov 2020 13:06:01 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id f140so2571030ybg.3;
        Thu, 05 Nov 2020 13:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8KXKdPdR56J5OIrdXGJjbqwpFhVq0I2wJnMKBptINk=;
        b=JeRbElrBCF0hrOSxwsYkRFhgEut2lr6u7fFr4npD89eipsgj9sM4sWtf8qdImfDGP9
         ZlvbS18xlh4jiS8qm9Qa+0VAxbhLS53XdNXG9yWpXrwTr1+2tQT5SoIbya9NR1165VI7
         vhUhvg9LjqVCaQXC9dBK9X38jBe2SAWTA6IQNrKYzVkQemEcw9MpMkO9VbWlywNItXwr
         ZGE3rIBhe3yWvW0NVqk0SsVwhQB2/kklorllXJHym1wGGkdYh/J49AjzvBKRdK3GFFp3
         i93mXC6NuQByfoIG1MqQiKCVqTG3lM22d+nA4GzYh401efmYoM3lSsqlVnDgzHZg7itt
         /Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8KXKdPdR56J5OIrdXGJjbqwpFhVq0I2wJnMKBptINk=;
        b=Nta1QgIfl3ImCCOTs/pUyBZRoylgTmdyjnWpkhW3plL9nr51WQWnLc7tqFCfHBx02j
         WnUl0IHHtUdsKI/d/g5cdy7YDepMpIyBrCFW6Fcr7laeJUhBYpStTVMeOqh0eDdWJr9R
         2K414WR6BSMEvZ1/FRfyh6f0PEU7UlhlRYDWBP/syxdovY7hyveMUNY4l6vXtHhtqnrt
         JknhuypqKis4S6OogxwSWKjuC3Ty5sJ3RVDiNH4rV2r03Fr/b2FTFfVHcaxF3PDcCeDG
         sMgY25vv0dXOqLfNVsn3Z1hVLEw9MPvoZqKKar1s7/+pRRq747WvrBdBOTO/PyANZT5x
         Q/Nw==
X-Gm-Message-State: AOAM5311joSF20qM2AKcrxvNfylKMB7n3a9yXMG0Dt0CyM7VvcxU4WY3
        UOBR1+hqI+A63rHaZ0muxsCiO6XCryjt3wVN6jerRBUxUJg=
X-Google-Smtp-Source: ABdhPJyN+9pRrd6GB1ND48rPtcOMtyNNFi7N5W/bELInvc3NtuvcWma8DZxt8mavE0ov1UuPX069itnedjbWbxc+OT8=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr6628525ybl.347.1604610361122;
 Thu, 05 Nov 2020 13:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20201105043936.2555804-1-andrii@kernel.org> <20201105114242.GH262228@kernel.org>
 <CAEf4BzYshEY3K=fqt2iQJaVcZeepcger0C7+uOXNhG=MLC9R-w@mail.gmail.com> <20201105202920.GJ262228@kernel.org>
In-Reply-To: <20201105202920.GJ262228@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Nov 2020 13:05:50 -0800
Message-ID: <CAEf4BzaE=B31fOc_L_ctBi_k9fdUzfHqOkWSDsJqehLJa8YsDw@mail.gmail.com>
Subject: Re: [RFC PATCH dwarves] btf: add support for split BTF loading and encoding
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 12:29 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 05, 2020 at 11:10:14AM -0800, Andrii Nakryiko escreveu:
> > On Thu, Nov 5, 2020 at 3:42 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Wed, Nov 04, 2020 at 08:39:36PM -0800, Andrii Nakryiko escreveu:
> > > > @@ -679,11 +681,11 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> > > >  {
> > > >       GElf_Shdr shdr_mem, *shdr;
> > > >       GElf_Ehdr ehdr_mem, *ehdr;
> > > > -     Elf_Data *btf_elf = NULL;
> > > > +     Elf_Data *btf_data = NULL;
>
> > > Can you please split this into two patches, one doing just the rename
> > > of btf_elf to btf_data and then moving to btf__new_empty_split()? Eases
> > > reviewing.
>
> > sure, will do in the next version
>
> Thanks!
>
> > > With this split btf code would it be possible to paralelize the encoding
> > > of the modules BTF? I have to check the other patches and how this gets
> > > used in the kernel build process... :-)
>
> > Yes, each module's BTF is generated completely independently. See some
> > numbers in [0].
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20201105045140.2589346-4-andrii@kernel.org/
>
> I saw it, very good. I wonder if we could manage to also paralelize the
> processing of DWARF compile units in the BTF encoder, like start
> processing and at the end just figure out how many types were in a CU,
> get the highest type id and bump it to + the number of types in the
> current CU, adjust the types, continue, something like that.

A big chunk is just DWARF loading. If it's possible to parallelize
that, it would be a big improvement. To parallelize BTF encoding
itself, it could be possible to generate each individual CU's types in
a separate BTF object, and then merge them together. We'd probably
need a few new APIs (like btf__append_btf() which would add all types
and strings, renumbering everything on the fly). BTF dedup itself is
unlikely to be parallelizable easily, I definitely wouldn't dare ;)
But it's also not a big portion of overall BTF encoding process. DWARF
parsing and string lookup/addition where by far biggest CPU hogs.

>
> - Arnaldo
