Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3910C312379
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 11:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBGKcx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 05:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBGKcw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Feb 2021 05:32:52 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A1C06174A;
        Sun,  7 Feb 2021 02:32:12 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y15so10093204ilj.11;
        Sun, 07 Feb 2021 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jO76zYRdGeX4URZ1jojueHJVMIdVLqOunE3xX8+8+s4=;
        b=EIncGUvtGifx6OKamTwhloPkFQeG8MX+6vwk7NuMcwzr8mBACl6KEV9FPosd89vOe/
         1HdYEtFDxHzNX+izAh9l/Yh3/marxkuAQ8DkMeQoGxnCgpZsc8qS+AfFoBQm6rWT4gp3
         7FEgCeWN7UkiehUJdoRt2LTWeQJZUP5zh75RS5rlYkycLy9JcTNPJWTfS7sDB0LdFudA
         cmSO+jtLSwXEGvsVJQ33yo0y9nKPnpC323ZUolhr+4PHWRpDSo1HczEH/t5FY6lJtxfK
         tFOSedmE9TUKLmvew3gYr9/oIV3qsIybUOqZZzoubPeO8HpUMe3y66rLmr48mBut8TTx
         /vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jO76zYRdGeX4URZ1jojueHJVMIdVLqOunE3xX8+8+s4=;
        b=puhqdjhE0qhXN6wtY6SN0gD8D2Sj5kHzEG59XdXF9wQfbIG+GeEo8E5uzeR5+hjTf6
         G+VJe/Le3CnoFCawqm8raFbiHr4pb0/GcJKr+4aTdwV/ic+hUBo5wIDG6D1dTgwC1NqH
         7YkzQqgPACuVZCU7O/QWMOet3nBOIlt0ymP8Le8N3srqS4HnVM8sOB9endIPvKDpXPR8
         4JawIOh+xRSXBGDooueZ6+tye97Pvii2s0Lu+K000WkbJUwHN3KsE+Sm/ZB2dDVQNiC2
         ysIhdlfedVyyTjXsdscdea9UYR2hNznS7fkTKzWom9bjViSMTJg0OOSXZMWMoCJUlee4
         umqQ==
X-Gm-Message-State: AOAM530sMLxwo5d93w9scwTPTFn2h5ROSWaYURkwQsRDTURk6bMXv9vq
        K8VpCeEM+0Zp3MUs5FteSpQmw+nU+e1TAimB7Y0=
X-Google-Smtp-Source: ABdhPJzy0eNhHdb9ZM6IAbV3gGpv98A8+9VoV0cw2Ys5skmo1Qr49vtAKh9FQxr1fe07cH1DtAAntOI1T815k6QAjNE=
X-Received: by 2002:a05:6e02:d0:: with SMTP id r16mr11079138ilq.112.1612693931237;
 Sun, 07 Feb 2021 02:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com>
In-Reply-To: <20210207071726.3969978-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 7 Feb 2021 11:32:00 +0100
Message-ID: <CA+icZUVwz+OroPfsqtOxAstWGeRxf=KYMUY5LCDPzyPLJFmZmg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Yonghong Song <yhs@fb.com>
Cc:     acme@kernel.org, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        andriin@fb.com, mark@klomp.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 7, 2021 at 8:17 AM Yonghong Song <yhs@fb.com> wrote:
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

Thanks for v2.

For both v1 and v2:

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
   Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

My development and testing environment:

1. Debian/testing AMD64
2. Linux v5.11-rc6+ with custom mostly Clang fixes
3. Debug-Info: BTF + DWARF-v5 enabled
4. Compiler and tools (incl. Clang's Integrated ASsembler IAS):
LLVM/Clang v12.0.0-rc1 (make LLVM=1 LLVM_IAS=1)

Build and boot on bare metal.

- Sedat -

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 9f76283..5843200 100644
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
> +               name = "__SANITIZED_FAKE_INT__";
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
