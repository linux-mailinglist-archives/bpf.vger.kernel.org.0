Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9A353546
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhDCSwb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhDCSwb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Apr 2021 14:52:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2FCC0613E6;
        Sat,  3 Apr 2021 11:52:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h25so5587974pgm.3;
        Sat, 03 Apr 2021 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m7J9VfSu///sbCD7GK/QgJoybOXbwEwKIF318rLoPI=;
        b=B3rSqbr+p0TAFAO+iaXnWzVRkjH46sVMhjj6rC9LzPGpmtEhHNVZlVWBZTDLKOWBaV
         xpkBfn8qKt3FqZAToWX9Qf7p4GukGOb5pRkRHpxmjIQ3y2DBM8D3XvJ/SmWHweKtW5mj
         nEBp5+fU8EpgTjKmYV2VtUfydnwfHFqW5qorACG71UznSZZXpbH6zLkHSnUeN41Wv+Xi
         z90OuuNklJp8MlyBMpWW4xpi/+ZNQFwQwPT2GGDcc8CJ6fm7nT3o4HxMMkckC2tyKbzj
         ksq3hCErn+gl+c1c9Yw6gIspILJd/jxXH6151iKVxk1Tio+Wf7jjhnGcALw0Eeo6jMvv
         k0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m7J9VfSu///sbCD7GK/QgJoybOXbwEwKIF318rLoPI=;
        b=fEsbxH8B13zGGaQnJaw9vs/ZW60LKAScxUzb/Ds8/Yy0sQd71zyw/o2c/ydE+p2NcD
         FS+u8BLxuJcYCR7T54CblXUbkW3KhY6KI/UaG4ntFcbkf2VzFsDgrLCSl8agSM1H5rID
         7SR6MbitjZ3DFVOheetYlMF6FFqBl//+vjEW+M0ZaTgrGjKG4wbUEnZQLtulXK59j8e8
         D/IRmGRr64ey9TI6Ul2u7X3OdMo8c3XC303mtNNL+SyROwuMq7kqXIuCrb0Qa0KisZnp
         ozKdzUaHt+AxZVXJC+LQwU3n0q8X0kDvohjIsauC03BcEODHSVY3fCPAHFiYOAfwhrkz
         MZgA==
X-Gm-Message-State: AOAM530krqfLYLTqwfh9khjKPzVesGnFctWXDajRtgG9esS5S2dfbHzr
        n2ny0uXrUWkblhfFTEar7FnAbnX0GkcD+t22q7c=
X-Google-Smtp-Source: ABdhPJzl12BV8YI/tGxqa2hzZ7fEU0RgOufmlDbTWa6FioJ7TyIAf3JSAPVAgXFACo99XVH3F8a5PNKnfgln9++JDQY=
X-Received: by 2002:a62:380d:0:b029:218:66f7:f7cf with SMTP id
 f13-20020a62380d0000b029021866f7f7cfmr17259065pfa.30.1617475947227; Sat, 03
 Apr 2021 11:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com>
In-Reply-To: <20210403184158.2834387-1-yhs@fb.com>
From:   David Blaikie <dblaikie@gmail.com>
Date:   Sat, 3 Apr 2021 11:52:16 -0700
Message-ID: <CAENS6EtcOH-Sr0Ct09qzzXb9qBMNyM7Dj9vScffvaz_o=wcvJg@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 3, 2021 at 11:42 AM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, when DWARF5 is enabled in kernel, DEBUG_INFO_BTF
> needs to be disabled. I hacked the kernel to enable DEBUG_INFO_BTF
> like:
>   --- a/lib/Kconfig.debug
>   +++ b/lib/Kconfig.debug
>   @@ -286,7 +286,6 @@ config DEBUG_INFO_DWARF5
>           bool "Generate DWARF Version 5 debuginfo"
>           depends on GCC_VERSION >= 50000 || CC_IS_CLANG
>           depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
>   -       depends on !DEBUG_INFO_BTF
>           help
> and tried DWARF5 with latest trunk clang, thin-lto and no lto.
> In both cases, I got a few additional failures like:
>   $ ./test_progs -n 55/2
>   ...
>   libbpf: extern (var ksym) 'bpf_prog_active': failed to find BTF ID in kernel BTF(s).
>   libbpf: failed to load object 'kfunc_call_test_subprog'
>   libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
>   test_subprog:FAIL:skel unexpected error: 0
>   #55/2 subprog:FAIL
>
> Here, bpf_prog_active is a percpu global variable and pahole is supposed to
> put into BTF, but it is not there.
>
> Further analysis shows this is due to encoding difference between
> DWARF4 and DWARF5. In DWARF5, a new section .debug_addr
> and several new ops, e.g. DW_OP_addrx, are introduced.
> DW_OP_addrx is actually an index into .debug_addr section starting
> from an offset encoded with DW_AT_addr_base in DW_TAG_compile_unit.
>
> For the above 'bpf_prog_active' example, with DWARF4, we have
>   0x02281a96:   DW_TAG_variable
>                   DW_AT_name      ("bpf_prog_active")
>                   DW_AT_decl_file ("/home/yhs/work/bpf-next/include/linux/bpf.h")
>                   DW_AT_decl_line (1170)
>                   DW_AT_decl_column       (0x01)
>                   DW_AT_type      (0x0226d171 "int")
>                   DW_AT_external  (true)
>                   DW_AT_declaration       (true)
>
>   0x02292f04:   DW_TAG_variable
>                   DW_AT_specification     (0x02281a96 "bpf_prog_active")
>                   DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
>                   DW_AT_decl_line (45)
>                   DW_AT_location  (DW_OP_addr 0x28940)
> For DWARF5, we have
>   0x0138b0a1:   DW_TAG_variable
>                   DW_AT_name      ("bpf_prog_active")
>                   DW_AT_type      (0x013760b9 "int")
>                   DW_AT_external  (true)
>                   DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
>                   DW_AT_decl_line (45)
>                   DW_AT_location  (DW_OP_addrx 0x16)
>
> This patch added support for DW_OP_addrx. With the patch, the above
> failing bpf selftest and other similar failed selftests succeeded.
> ---
>  dwarf_loader.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> NOTE: with this patch, at least for clang trunk, all bpf selftests
>       are fine for DWARF5 w.r.t. compiler and pahole. Hopefully
>       after pahole 1.21 release, we can remove DWARF5 dependence
>       with !DEBUG_INFO_BTF.
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 82d7131..49336ac 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -401,8 +401,19 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
>  {
>         Dwarf_Attribute attr;
>         if (dwarf_attr(die, DW_AT_location, &attr) != NULL) {
> -               if (dwarf_getlocation(&attr, expr, exprlen) == 0)
> +               if (dwarf_getlocation(&attr, expr, exprlen) == 0) {
> +                       /* DW_OP_addrx needs additional lookup for real addr. */
> +                       if (*exprlen != 0 && expr[0]->atom == DW_OP_addrx) {


^ this change is probably overly narrow. DW_OP_addrx could appear at
other locations in a DWARF expression. So whatever code is responsible
for doing general evaluation of DWARF expressions should probably be
the place to handle this so it can deal with the full generality of
expressions, not only this specific case of a DW_OP_addrx as being the
first operation in the expression?

>
> +                               Dwarf_Attribute addr_attr;
> +                               dwarf_getlocation_attr(&attr, expr[0], &addr_attr);
> +
> +                               Dwarf_Addr address;
> +                               dwarf_formaddr (&addr_attr, &address);
> +
> +                               expr[0]->number = address;
> +                       }
>                         return 0;
> +               }
>         }
>
>         return 1;
> @@ -626,6 +637,7 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
>                 Dwarf_Op *expr = location->expr;
>                 switch (expr->atom) {
>                 case DW_OP_addr:
> +               case DW_OP_addrx:
>                         scope = VSCOPE_GLOBAL;
>                         *addr = expr[0].number;
>                         break;
> --
> 2.30.2
>
