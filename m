Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81325312204
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 07:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBGGhk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 01:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGGhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Feb 2021 01:37:32 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5935C06174A;
        Sat,  6 Feb 2021 22:36:52 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id b187so11290902ybg.9;
        Sat, 06 Feb 2021 22:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jIGB9qLLpXYfcZQJrn6stVqpV6L+ZUNPuXCy/jLKHE=;
        b=kaXXygiR9EtfeO3jtvBLVKHMWT9HCOuzOtiRAplNCeYMaWXAX20pH71LeCWFW2R/lB
         gmR3tc235G1WZLAQxIlzAqsLCuATcc/iAoMY2n+ngQwXLujDAZ0OsX6WL9EXQPqUxhIb
         SfDaXbB7XdD3JKGKGxJSz6NGsM5zN+dtQEtgO1lwR1xnt6DX5MdeoLh/MjXbnllXPbEi
         DL+wp/9Bb2vFPbycQA9MOk/fmQbgxHjiz3yzYQDB80loLMtK64SaoAnKI+LUf5j9tTaN
         b1LEarHS+/klmen63Zu+Q1gBqz0RJLZvACdEn3f2+wzunSSGZgSxKiYDdKeMoe9KZeZj
         GFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jIGB9qLLpXYfcZQJrn6stVqpV6L+ZUNPuXCy/jLKHE=;
        b=AbUyJm9Y4zCjm27sJobzfXyF7zzC5BWnAbRE8MJIhVHRSOZL+1AYK06/V7RDWvWOzJ
         Z4Lp2y9n2hxLxQXEPCp1A4P/Ky7IFgTrbChO8ZD02mGgoJPI17+5nIyS5QmjnKTOt+8S
         vXtU+jc4ZuH6HyQbSg4iouE/4msRvW4RqQiIP7oCfngDRzXToo4YeqEGukgHId/c0OSI
         3EJTB1Rt/ahOMKHDm5tfeRKNBnUTigfTgy9qvamw8IKsgqbR0HUI53YV6fXFTaG5hmjl
         GWWVQ5Toay9IOmjXd+kzo7PP+AzfOHZWispEbrp4PGI9/YR7faa3RJpt2yK+zL74DJaV
         8V3g==
X-Gm-Message-State: AOAM532IIzJbBl5ythHeGZ469xIoYe6H4o8y05/7aFejPWqssw9q9iXG
        0KiaXgisETK8tw/bpI1DRQhmLXiEWxTr54rVjqU=
X-Google-Smtp-Source: ABdhPJzYKJ03VioOZa/Zes8wRmO1K7EhsXtd1lrCSW1Jcjf137fp5cwZPFeh3wuHFvaV568sVmWASktn+XhHUWM7oNY=
X-Received: by 2002:a25:a183:: with SMTP id a3mr16897639ybi.459.1612679811365;
 Sat, 06 Feb 2021 22:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20210206191350.830616-1-yhs@fb.com>
In-Reply-To: <20210206191350.830616-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 6 Feb 2021 22:36:40 -0800
Message-ID: <CAEf4Bzb-Rqz=+pJYaVNzr8jEEAHQ-ZForsfRpNo4e=t84BRWKg@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: sanitize non-regular int base type
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wielaard <mark@klomp.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 11:21 AM Yonghong Song <yhs@fb.com> wrote:
>
> clang with dwarf5 may generate non-regular int base type,
> i.e., not a signed/unsigned char/short/int/longlong/__int128.
> Such base types are often used to describe
> how an actual parameter or variable is generated. For example,
>
> 0x000015cf:   DW_TAG_base_type
>                 DW_AT_name      ("DW_ATE_unsigned_1")
>                 DW_AT_encoding  (DW_ATE_unsigned)
>                 DW_AT_byte_size (0x00)
>
> 0x00010ed9:         DW_TAG_formal_parameter
>                       DW_AT_location    (DW_OP_lit0,
>                                          DW_OP_not,
>                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
>                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
>                                          DW_OP_stack_value)
>                       DW_AT_abstract_origin     (0x00013984 "branch")
>
> What it does is with a literal "0", did a "not" operation, and the converted to
> one-bit unsigned int and then 8-bit unsigned int.
>
> Another example,
>
> 0x000e97e4:   DW_TAG_base_type
>                 DW_AT_name      ("DW_ATE_unsigned_24")
>                 DW_AT_encoding  (DW_ATE_unsigned)
>                 DW_AT_byte_size (0x03)
>
> 0x000f88f8:     DW_TAG_variable
>                   DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
>                      [0xffffffff82808812, 0xffffffff82808817):
>                          DW_OP_breg0 RAX+0,
>                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>                          DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
>                          DW_OP_stack_value,
>                          DW_OP_piece 0x1,
>                          DW_OP_breg0 RAX+0,
>                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>                          DW_OP_lit8,
>                          DW_OP_shr,
>                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>                          DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
>                          DW_OP_stack_value,
>                          DW_OP_piece 0x3
>                      ......
>
> At one point, a right shift by 8 happens and the result is converted to
> 32-bit unsigned int and then to 24-bit unsigned int.
>
> BTF does not need any of these DW_OP_* information and such non-regular int
> types will cause libbpf to emit errors.
> Let us sanitize them to generate BTF acceptable to libbpf and kernel.
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 9f76283..93fe185 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -373,6 +373,7 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>         struct btf *btf = btfe->btf;
>         const struct btf_type *t;
>         uint8_t encoding = 0;
> +       uint16_t byte_sz;
>         int32_t id;
>
>         if (bt->is_signed) {
> @@ -384,7 +385,43 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>                 return -1;
>         }
>
> -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encoding);
> +       /* dwarf5 may emit DW_ATE_[un]signed_{num} base types where
> +        * {num} is not power of 2 and may exceed 128. Such attributes
> +        * are mostly used to record operation for an actual parameter
> +        * or variable.
> +        * For example,
> +        *     DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> +        *         [0xffffffff82808812, 0xffffffff82808817):
> +        *             DW_OP_breg0 RAX+0,
> +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> +        *             DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> +        *             DW_OP_stack_value,
> +        *             DW_OP_piece 0x1,
> +        *             DW_OP_breg0 RAX+0,
> +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> +        *             DW_OP_lit8,
> +        *             DW_OP_shr,
> +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> +        *             DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> +        *             DW_OP_stack_value, DW_OP_piece 0x3
> +        *     DW_AT_name    ("ebx")
> +        *     DW_AT_decl_file       ("/linux/arch/x86/events/intel/core.c")
> +        *
> +        * In the above example, at some point, one unsigned_32 value
> +        * is right shifted by 8 and the result is converted to unsigned_32
> +        * and then unsigned_24.
> +        *
> +        * BTF does not need such DW_OP_* information so let us sanitize
> +        * these non-regular int types to avoid libbpf/kernel complaints.
> +        */
> +       byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> +       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> +               name = "sanitized_int";

DWARF never stops causing issues :( How about making this name stand
out a bit more: __SANITIZED_FAKE_INT__ ? Similar in style to
__ARRAY_INDEX_TYPE__?

Otherwise looks good to me, even though it's a bit sketchy to just
"fix up" any integer that doesn't conform to our idea of "normal
integer". But as I said, DWARF is DWARF...

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +               byte_sz = 4;
> +       }
> +
> +       id = btf__add_int(btf, name, byte_sz, encoding);
>         if (id < 0) {
>                 btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF type");
>         } else {
> --
> 2.24.1
>
