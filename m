Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1237E2F5B87
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 08:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbhANHqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 02:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhANHqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 02:46:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC6C0617A3;
        Wed, 13 Jan 2021 23:45:37 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n4so9344646iow.12;
        Wed, 13 Jan 2021 23:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XVqXJ+WBObsoLPtbCrvIN/youZenxFlxTfL1u8ghOFM=;
        b=ERIbUTYttvj4OxNIuQKJPEDCpPIskPs/hbz3fcJl9+mJXrGpUiJp02I81eBW0PaPJv
         IECbmrX9dWfbA3fw8Hndfc6FO5sm03Y7fL9YoJmJxU6mpzpBx7i4ncr6ULtZ7Ua5Y/Sq
         /TyFmuYL6fY4gjXdyu9q/Mx77Cz3I9Wh9khQ2/8lE5tKvIxxczOI1LGxvyiXNWpuiNYC
         uKLaLJf7KfkmJ7AHaFykGjTDSEbOZevA3FozSMD2FSN6DYNHuwHdwka8/swJAEV1Yfbi
         oyw8i3q7hfqUgmvb7+8Mva4IgP3BuaGtguvkm4YWTg6YiHDX80vfPDUHLMjFgg1FcwgR
         zwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XVqXJ+WBObsoLPtbCrvIN/youZenxFlxTfL1u8ghOFM=;
        b=Yn+xkVCQaVu3PUbbJMh06LmtY6FuCwoF0JABhqMaSuTUSfZN2AotHQQthyhLs4F8JL
         pdeyAPhglNtzRta2QNGPPXj/oM/cHxw6NZbiMVQtnSVvOmJ/GYvzCxLyEujitgKIE/lY
         U+0xsqXD7qHvnHKc2ABno4BrFT63JgYC6LHSNykNkJC4WOTFDT8qK2Z1ud1ttMnKO7o/
         gSFE+lIjF40iAOuqLuEWBwGT5IshihcZokLasIhVdJin65UnQ5kP2ynzbA4FoLniifR4
         fkJIYRh9AtzEO/R+IxcAMe3JGR94PecSYZWvXcnOlIvaujS+H39HP3NvzHAvBJ32hMA2
         NuUw==
X-Gm-Message-State: AOAM533B242Av3Tee8OMU5xGw1aZ47lzLoyFgHEdlVLwguJGoXHpeytm
        SaCdv6VTqy+4ISlkNOnw2V3FY+uSd2YP49e/bcI=
X-Google-Smtp-Source: ABdhPJwTvaKT4qjsk1mbRHm04N2/lR44rKTW0zQJkoWdReT/+m9o7SoDROT9HtT9Uky9RamSe6HmvgIR0UZjysOJOEQ=
X-Received: by 2002:a02:2ace:: with SMTP id w197mr5463450jaw.132.1610610336612;
 Wed, 13 Jan 2021 23:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20210113102509.1338601-1-jolsa@kernel.org>
In-Reply-To: <20210113102509.1338601-1-jolsa@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 08:45:25 +0100
Message-ID: <CA+icZUU-7_SDv3AB5WiNk1i7vKd6HQtmG3gi5N1Gqy-8RuoZFg@mail.gmail.com>
Subject: Re: [PATCHv2] btf_encoder: Add extra checks for symbol names
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 11:25 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> When processing kernel image build by clang we can
> find some functions without the name, which causes
> pahole to segfault.
>
> Adding extra checks to make sure we always have
> function's name defined before using it.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Applied on top of latest pahole Git.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>   v2 changes:
>     - reorg the code based on Andrii's suggestion
>
>  btf_encoder.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 333973054b61..5557c9efd365 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -68,10 +68,14 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>         struct elf_function *new;
>         static GElf_Shdr sh;
>         static int last_idx;
> +       const char *name;
>         int idx;
>
>         if (elf_sym__type(sym) != STT_FUNC)
>                 return 0;
> +       name = elf_sym__name(sym, btfe->symtab);
> +       if (!name)
> +               return 0;
>
>         if (functions_cnt == functions_alloc) {
>                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> @@ -94,7 +98,7 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>                 last_idx = idx;
>         }
>
> -       functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> +       functions[functions_cnt].name = name;
>         functions[functions_cnt].addr = elf_sym__value(sym);
>         functions[functions_cnt].sh_addr = sh.sh_addr;
>         functions[functions_cnt].generated = false;
> @@ -731,8 +735,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                         continue;
>                 if (functions_cnt) {
>                         struct elf_function *func;
> +                       const char *name;
> +
> +                       name = function__name(fn, cu);
> +                       if (!name)
> +                               continue;
>
> -                       func = find_function(btfe, function__name(fn, cu));
> +                       func = find_function(btfe, name);
>                         if (!func || func->generated)
>                                 continue;
>                         func->generated = true;
> --
> 2.26.2
>
