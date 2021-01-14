Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE72F634E
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 15:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbhANOjz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 09:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbhANOjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 09:39:54 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723ACC061574;
        Thu, 14 Jan 2021 06:39:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r9so11526138ioo.7;
        Thu, 14 Jan 2021 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QEZ6JBeaIgDcN7t6oNKQCXdkFzUPqoK0yMQUL2XI0w0=;
        b=ECICRZs76+7IiAMY/Qtdk8cQZ+lqt1tOroPjKL7jwqc+BY7bbEciJEv8GyMuwrx7j4
         sW9v9tEyPXV8wsa3QBCAMpeyQDfatA6P0LQmVy7h6U+6/988bUT0z6QgnXExOyf1mWu7
         XvgVcrjiyiLPLCPkfXJBoHZURJgI9iqATjlM8vRnxWpYcXLRUJeVriU9tt+0z9KaqGfY
         Y/bPd+u0y9D+fpuutP1TmRtl6E/80QwDHKvC4vV9Ho8odMVqK+lbvj3rbzNaHxfiuTda
         uKvEY+9UUToMOMYfnzkNCe6le9VO4C89E8s006kCauBBjHtazUqAo0RcZdsZd/RLifm7
         CEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=QEZ6JBeaIgDcN7t6oNKQCXdkFzUPqoK0yMQUL2XI0w0=;
        b=FA1Dl2R2K0p9L7K1BlYOQTUe/0xNju3DDX095d4jveOoBZuvjpbkWFjTge2rYAiCpt
         HG0oicgV8mPrxA8NbwtuGpLsPVjTco19LzCiMzEC2aKWsfo1kcNAEUvRSQf2tnfNkboe
         hmbYHbcODOaS3cscxXodOtfQ91+9OUzkPlAxJrtLH/a0zeFZ4Sd/iafS03bE9aydoNDu
         9+0mb6Xid6q1wGzYkI6Z4ay3bg3GtK8XMTPlnbNrmKKBbpDPVCqZu8CSG8EY/7iVdzNN
         z0C7KiTfx9kNQzUOCf5ifVoCYta8xz22MCXDRorc8mYifjkMqkh3UsLIOc71A/xbldUx
         Wvgg==
X-Gm-Message-State: AOAM531mT3ZP+ImDb1irzXUY66F2Omw3ynaZJxoisKvYQRCRol7aZut6
        ZJXdb1FfdZlOrCcjzTMXYBxWQ0D7HFr6IOv5B/A=
X-Google-Smtp-Source: ABdhPJzhEZcTyXB6qgc1PGEKigvgJ/1uLwHzcloVmfcT98OlCfHl4aVr6JXBIAgoFbPyvnSb8tDcbOqBVxZCUSVAnRw=
X-Received: by 2002:a92:c692:: with SMTP id o18mr7007089ilg.215.1610635153877;
 Thu, 14 Jan 2021 06:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <CA+icZUV9rdRuswqDa9u=VFcqgHp1x+jmz565QCFi=yC0D7hhVQ@mail.gmail.com> <dae1ec1e-7d19-e4c6-891b-ab774486dbee@redhat.com>
In-Reply-To: <dae1ec1e-7d19-e4c6-891b-ab774486dbee@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 15:39:02 +0100
Message-ID: <CA+icZUU3mHTbEHg3bVNNQCsiukE-JTepxEWmCF+XadN+-Kcr2A@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     tstellar@redhat.com
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 3:33 PM Tom Stellard <tstellar@redhat.com> wrote:
>
> On 1/13/21 11:50 PM, Sedat Dilek wrote:
> > On Wed, Jan 13, 2021 at 1:28 AM Tom Stellard <tstellar@redhat.com> wrote:
> >>
> >> On 1/12/21 10:40 AM, Jiri Olsa wrote:
> >>> When processing kernel image build by clang we can
> >>> find some functions without the name, which causes
> >>> pahole to segfault.
> >>>
> >>> Adding extra checks to make sure we always have
> >>> function's name defined before using it.
> >>>
> >>
> >> I backported this patch to pahole 1.19, and I can confirm it fixes the
> >> segfault for me.
> >>
> >
> > Thanks for testing.
> >
> > Can you give me Git commit-id of LLVM-12 you tried?
> >
>
> I was building with LLVM 11.0.1
>

Thanks Tom.

- Sedat -

> -Tom
>
> > - Sedat -
> >
> >> -Tom
> >>
> >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>> ---
> >>>    btf_encoder.c | 8 ++++++--
> >>>    1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/btf_encoder.c b/btf_encoder.c
> >>> index 333973054b61..17f7a14f2ef0 100644
> >>> --- a/btf_encoder.c
> >>> +++ b/btf_encoder.c
> >>> @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> >>>
> >>>        if (elf_sym__type(sym) != STT_FUNC)
> >>>                return 0;
> >>> +     if (!elf_sym__name(sym, btfe->symtab))
> >>> +             return 0;
> >>>
> >>>        if (functions_cnt == functions_alloc) {
> >>>                functions_alloc = max(1000, functions_alloc * 3 / 2);
> >>> @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >>>                if (!has_arg_names(cu, &fn->proto))
> >>>                        continue;
> >>>                if (functions_cnt) {
> >>> -                     struct elf_function *func;
> >>> +                     const char *name = function__name(fn, cu);
> >>> +                     struct elf_function *func = NULL;
> >>>
> >>> -                     func = find_function(btfe, function__name(fn, cu));
> >>> +                     if (name)
> >>> +                             func = find_function(btfe, name);
> >>>                        if (!func || func->generated)
> >>>                                continue;
> >>>                        func->generated = true;
> >>>
> >>
> >
>
