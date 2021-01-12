Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710882F39FB
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 20:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406659AbhALTVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 14:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406339AbhALTVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 14:21:36 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B82C061575;
        Tue, 12 Jan 2021 11:20:55 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 18so3212290ybx.2;
        Tue, 12 Jan 2021 11:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrTMphAgvKGFr3hAFtVF+wajAgM4bFVoddK5qIwsbyc=;
        b=J6yRObelgfU5yGXUdqTqomuf/z5BR4lUT7iSK6vMilj9Pq5nz9362BCeRX8uLrkKCM
         Pgr6lxRBB3LsB2aDJmhWIMZxAPT225qnotZnDv/zjUICqsiaqS8MmzgSYlRNP+T80qY1
         ST9z+qjPe1CJHKlftbvwmWAF4gPdRekb33NdRIMzVr7CwxRdxES4+B6VIQC6t+y6f0mv
         dSnaYTmK6pDLftjPjcxv+in6ABkqoUbNfk70yQl27kQkU6xP7VJ5wv+Xsqo5a+i5HI6Y
         nvX3pjkgRDyTee7ZL92iM6xQtZjog/i2I+DH1q7nqCJtppaIJOPAleLWlBNWf5p4dvLJ
         LeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrTMphAgvKGFr3hAFtVF+wajAgM4bFVoddK5qIwsbyc=;
        b=LjJmNzTNXQkvx95Kv6m6qMetM1KP18GAfI6RX9RZoX9NWd2VujfoYLnzXjDmEJPLJr
         eaHW3NQjvT7DBd+A7J9ihAg76wFwgByPDG2PazdXGLfgxmBKYOmLaaE35kBNU7qZ9m3M
         k/SV0FJPAsidd549JAN/c6biftVhna2LHy6O3cu4AsbQSm6hOiDVj6pemBDq/nxZRo3a
         KtLa0tNWz4wvAIVv7eiPjW9KFRVu+s1in0PQ8d2HOgapvLyW5ZFZB/PauNGct+9jZF4l
         GkUjOyxGGq5JdVHecAcjZxYIZ9innCKv5LzhmQsoOkwPa7S5YsARZnuChplDWwgDLLPk
         xaMg==
X-Gm-Message-State: AOAM533T6uCTJ6GEPiw8xJ2UBkdFSVz0q8My7kbl1j/7comE9Bp8KqC4
        D9/Dk087vz5j+hmwRa+ZlxVKIlj2s4sJVPXnWBI=
X-Google-Smtp-Source: ABdhPJzAQUHegCWhIDDPhnwHCb0DygblHYglh2gu4mH7P0xO7QvDuAjQ0h/ihd9erYiwJpK9SSyB8u642q8kR6e1Tik=
X-Received: by 2002:a25:854a:: with SMTP id f10mr1342097ybn.510.1610479255239;
 Tue, 12 Jan 2021 11:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org>
In-Reply-To: <20210112184004.1302879-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Jan 2021 11:20:44 -0800
Message-ID: <CAEf4BzZc0-csgmOP=eAvSP5uVYkKiYROAWtp8hwJcYA1awhVJw@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 10:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> When processing kernel image build by clang we can
> find some functions without the name, which causes
> pahole to segfault.
>
> Adding extra checks to make sure we always have
> function's name defined before using it.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
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

elf_sym__name() is called below again, so might be better to just use
local variable to store result?

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

isn't this a more convoluted way of writing:

name = function__name(fn, cu);
if (!name)
    continue;

func = find_function(btfe, name);
if (!func || func->generated)
    continue

?

>                         if (!func || func->generated)
>                                 continue;
>                         func->generated = true;
> --
> 2.26.2
>
