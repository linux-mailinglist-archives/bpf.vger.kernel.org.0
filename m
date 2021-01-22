Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593DE2FFA4A
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 03:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhAVCIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 21:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbhAVCIS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 21:08:18 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D10DC06174A;
        Thu, 21 Jan 2021 18:07:38 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e22so8226324iom.5;
        Thu, 21 Jan 2021 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OdNdvLohokUOuia5XaMR5TfQIGTzr9SxkYC3Ls0vPbU=;
        b=kwdx4G6v68AANGSyBfLCrKw017uEaM6GnJ/a67F5aTZwf6dicBR4KTEPgGzSeksgvu
         KRrTKZZ0BF0CkXMPztq9D9uIPsJfZnWT7TKR0Tijp/5Z1M9kXbUcUiG+hWp6fx6slWBw
         Nhht/t15tFGeDwbWS+hOPwoL0UwNe1pb4w2+aY6rVZUY5zc2FWberEwReITFUut7qxc3
         D3BJBBm48jjSCMpHhKx8Odv/BHHVN5QKBJv7kMqIRrmb/Kb/yg0/ORK406CKRbUMuBmF
         JrAuEVkydIuRC8AF9rYcIQU7KsUb57+bnlbL7g1cBx+z+b4LlpRGq1v/1EcX3zMTHum3
         ogNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OdNdvLohokUOuia5XaMR5TfQIGTzr9SxkYC3Ls0vPbU=;
        b=NhDGJsNkD+S08GzoHBpH17FD2q32tvUXkwqLPp3d05sxmyzNE5UswKHhF9n2wEyUG4
         zQA5wb2vcg/7gPiAu+aQBJ7aMwhhqobA4ExAfnBnW1QP6faLFwditfBOjG4zNhMQK3bq
         vSbkHTnniQ8LcCDIOcgTNpYaVbGznCoAcxZ7veASX3RlseyfYnSFWgj+CahvpV7emSv/
         uqm3Hb4xHmshH+YTQt82jo6d3Th5Y+5W1m5Zt9Ew8JU+tb8GIu+pg71bnGbMAUNo1nps
         pEgSG/H8EkjY9pQmYBqAc+Y/2y8mS+JMXrXdpMlFLP143NrewW9h1av1jk285bJ6Rr8n
         Q3yg==
X-Gm-Message-State: AOAM530HKe6l5WPu27INFIxLWbvZT5+f0hXBBpvqNy5dvUiYBvZx0tSK
        Hd2snCSJrjU839+ohWXqAQodRzAOjPiV4SZr7Y4=
X-Google-Smtp-Source: ABdhPJyCIWtYQh4q6ajXgFMcxIDWrpyJxNYvo8SKpbGP0zv5cXoa0ZmcwWdjISEN1KMRkghEOQflGs/0hAYiXvbrGmk=
X-Received: by 2002:a92:c5c8:: with SMTP id s8mr2216613ilt.186.1611281257335;
 Thu, 21 Jan 2021 18:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
In-Reply-To: <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 22 Jan 2021 03:07:25 +0100
Message-ID: <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 21, 2021 at 9:53 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 8:09 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Jan 21, 2021 at 2:38 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Tue, Jan 12, 2021 at 04:27:59PM -0800, Tom Stellard escreveu:
> > > > On 1/12/21 10:40 AM, Jiri Olsa wrote:
> > > > > When processing kernel image build by clang we can
> > > > > find some functions without the name, which causes
> > > > > pahole to segfault.
> > > > >
> > > > > Adding extra checks to make sure we always have
> > > > > function's name defined before using it.
> > > > >
> > > >
> > > > I backported this patch to pahole 1.19, and I can confirm it fixes the
> > > > segfault for me.
> > >
> > > I'm applying v2 for this patch and based on your above statement I'm
> > > adding a:
> > >
> > > Tested-by: Tom Stellard <tstellar@redhat.com>
> > >
> > > Ok?
> > >
> > > Who originally reported this?
> > >
> >
> > The origin was AFAICS the thread where I asked initially [1].
> >
> > Tom reported in the same thread in [2] that pahole segfaults.
> >
> > Later in the thread Jiri offered a draft of this patch after doing some tests.
> >
> > I have tested all diffs and v1 and v2 of Jiri's patch.
> > ( Anyway, latest pahole ToT plus Jiri's patch did not solve my origin problem. )
>
> Your original problem was with DWARF5 or DWARF4? I think you mentioned
> both at some point, but I remember I couldn't repro DWARF4 problems.
> If you still have problems, can you start a new thread with steps to
> repro (including Kconfig, tooling versions, etc). And one for each
> problem, no all at the same time, please. I honestly lost track of
> what's still not working among those multiple intertwined email
> threads, sorry about that.
>

I love people saying "I have a (one) problem." :-).

The origin was Debian kernel-team enabled BTF-debuginfo Kconfig.

My main focus is to be as close to Debian's kernel-config and if this
works well with (experimental) Linux DWARF v5 support I am a happy
guy.

Do you want Nick's DWARF v5 patch-series as a base?
Thinking of DWARF-v4?
Use Nick's patchset or DWARF-v4 what is in Linux upstream means Linux
v5.11-rc4+?
What Git tree to use - Linus or one of your BPF/BTF folks?

What version of pahole (latest Git) etc.?

- Sedat -

> >
> > So up to you Arnaldo for the credits.
> >
> > - Sedat -
> >
> > [1] https://marc.info/?t=161036949500004&r=1&w=2
> > [2] https://marc.info/?t=161036949500004&r=1&w=2
> >
> > > - Arnaldo
> > >
> > > > -Tom
> > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >   btf_encoder.c | 8 ++++++--
> > > > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > > index 333973054b61..17f7a14f2ef0 100644
> > > > > --- a/btf_encoder.c
> > > > > +++ b/btf_encoder.c
> > > > > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> > > > >     if (elf_sym__type(sym) != STT_FUNC)
> > > > >             return 0;
> > > > > +   if (!elf_sym__name(sym, btfe->symtab))
> > > > > +           return 0;
> > > > >     if (functions_cnt == functions_alloc) {
> > > > >             functions_alloc = max(1000, functions_alloc * 3 / 2);
> > > > > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > > >             if (!has_arg_names(cu, &fn->proto))
> > > > >                     continue;
> > > > >             if (functions_cnt) {
> > > > > -                   struct elf_function *func;
> > > > > +                   const char *name = function__name(fn, cu);
> > > > > +                   struct elf_function *func = NULL;
> > > > > -                   func = find_function(btfe, function__name(fn, cu));
> > > > > +                   if (name)
> > > > > +                           func = find_function(btfe, name);
> > > > >                     if (!func || func->generated)
> > > > >                             continue;
> > > > >                     func->generated = true;
> > > > >
> > > >
> > >
> > > --
> > >
> > > - Arnaldo
