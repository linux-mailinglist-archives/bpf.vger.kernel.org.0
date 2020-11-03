Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430622A4F7E
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgKCS7M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 13:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCS7M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 13:59:12 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BCC0613D1;
        Tue,  3 Nov 2020 10:59:10 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id s89so15740582ybi.12;
        Tue, 03 Nov 2020 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fqIMy9vXApfUFcPxd191BrCKM+CJUMN+VBtwVSq+qI=;
        b=brpxZ7taVQmaLlgHbb8JhBG12PfPip+0Xo9lKO/+GrdkpmGUSLeC2TijLvKmuklKoY
         4wbrbyA1C7Nv/TV5l/P5U7QEFCweRiIl4h/2wrRDGkvbP+nYPKyijVkgMiLYvPArPQbG
         ruc9IGq/rqDIJwFefTyVgGUF03GPDH1shBJHV+SYFQ7MrS7EcWNDV8RdYhHp+6O5UxtU
         vXkvpQlIW2x/VuwU2d5kvAuVDOUtMblE7hE5mCGb1Cozo4WYtBiKp/yJ7Xq9PUy2/nST
         f2N1w6+A9zK0iA1zod6B+3M2ZZekNoHzZ4yZ41mhCVDNpBO5OUSrW7H/LH3kQdXJko8u
         YEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fqIMy9vXApfUFcPxd191BrCKM+CJUMN+VBtwVSq+qI=;
        b=E63TkItj6bQDD+lVFy+e5fO6iLauVXvxGR/YYKR8xGAdNMSaRWJ4ZUmtUTXt0v99Tw
         baSILt8mKFdrZmBEo0S4CTapJLLl/CbTAT5uI8QODMwSboLFEGIikBJDp0nFD4kWYXmJ
         tF0c+E+lhI+Dvf5sf94q8nY0eECgRHe6V7b4JntATv7QYc6yq+VWV+7ELF6WAF0K8gk6
         8dGtpSYMHAJZ5PWc22BOURMhmep0+YabOOjFehA5MZuuGTcZYIqqylLl4NDg5AubSYUy
         e9MwG5PSkrZ4EL8/HRSoU1hUw9BT2fAUbVjYj2I/HG9vbArqDMZBQxmJpYSe6ZagRKd1
         7c2g==
X-Gm-Message-State: AOAM532g7YOk8acqXAJb/bNxI9Jb2yAE0YyJ3SDgP1Nqat+nYxzsx978
        AXTIH5o73t+ts5G6Gk+oijDyPLW7a9mUlJS5Ogo=
X-Google-Smtp-Source: ABdhPJy66Dum8Vfeq/PZJbd2yxqSd9YmDMUPuKHPPHRoSxrWOzgIiHgh3BOkkjiRMVxVw0Qriz0cdZlaIrQr5CHcGWI=
X-Received: by 2002:a25:bdc7:: with SMTP id g7mr31548206ybk.260.1604429949816;
 Tue, 03 Nov 2020 10:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20201031223131.3398153-1-jolsa@kernel.org> <20201031223131.3398153-3-jolsa@kernel.org>
 <20201102215908.GC3597846@krava> <20201102225658.GD3597846@krava>
In-Reply-To: <20201102225658.GD3597846@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Nov 2020 10:58:58 -0800
Message-ID: <CAEf4BzbdGwogFQiLE2eH9ER67hne7NgW4S8miYBM4CRb8NDPvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken dwarf
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 2, 2020 at 2:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Nov 02, 2020 at 10:59:08PM +0100, Jiri Olsa wrote:
> > On Sat, Oct 31, 2020 at 11:31:31PM +0100, Jiri Olsa wrote:
> > > We need to generate just single BTF instance for the
> > > function, while DWARF data contains multiple instances
> > > of DW_TAG_subprogram tag.
> > >
> > > Unfortunately we can no longer rely on DW_AT_declaration
> > > tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
> > >
> > > Instead we apply following checks:
> > >   - argument names are defined for the function
> > >   - there's symbol and address defined for the function
> > >   - function is generated only once
> > >
> > > Also because we want to follow kernel's ftrace traceable
> > > functions, this patchset is adding extra check that the
> > > function is one of the ftrace's functions.
> > >
> > > All ftrace functions addresses are stored in vmlinux
> > > binary within symbols:
> > >   __start_mcount_loc
> > >   __stop_mcount_loc
> >
> > hum, for some reason this does not pass through bpf internal
> > functions like bpf_iter_bpf_map.. I learned it hard way ;-)

what's the exact name of the function that was missing?
bpf_iter_bpf_map doesn't exist. And if it's __init function, why does
it matter, it's not going to be even available at runtime, right?


> > will check
>
> so it gets filtered out because it's __init function
> I'll check if the fix below catches all internal functions,
> but I guess we should do something more robust
>
> jirka
>
>
> ---
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0a378aa92142..3cd94280c35b 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -143,7 +143,8 @@ static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
>                 /* Do not enable .init section functions. */
>                 if (init_filter &&
>                     func->addr >= ms->init_begin &&
> -                   func->addr <  ms->init_end)
> +                   func->addr <  ms->init_end &&
> +                   strncmp("bpf_", func->name, 4))

this looks like a very wrong way to do this? Can you please elaborate
on what's missing and why it shouldn't be missing?

>                         continue;
>
>                 /* Make sure function is within mcount addresses. */
>
