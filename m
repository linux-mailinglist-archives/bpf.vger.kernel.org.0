Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4506F3535EC
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 01:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhDCXcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 19:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhDCXcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Apr 2021 19:32:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3DFC061756;
        Sat,  3 Apr 2021 16:32:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x126so873829pfc.13;
        Sat, 03 Apr 2021 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHMhzbtk1CUDUh7fHcDuI2S0RI2ZLi5jpX67VD+AbM8=;
        b=aSdtmFQb9sNCJVUviog4xCj7HxS6Z2/gb4hCHYvm4QJCqo/nrGobcCJqqVitXJNl7Z
         Nxow0jbLaSqDX4BPAA0uoPyu1maVHoOlWWbBBe41rNLTpKb6l3WSZ+YI2JOwKz7cSV5w
         k2lvyNMY5E1opj/bzQw34MmnPnbafkBGfXsPKIGkBkXWsqS5+mj271ucZJlBC94qgkTS
         qK1+3oti9JgqzoKtwAZGRCdXkLxpv9RGf+ZklZpl871zVTU/uv+031VwLz9lYQ4VAay1
         Y1PqRhJL4V5TPcAsznPk2yfNu7HxI97+A9E5OqNq9GDm8CA6un807AMSkVpwGkVJAZ1C
         xugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHMhzbtk1CUDUh7fHcDuI2S0RI2ZLi5jpX67VD+AbM8=;
        b=m+mibL/OyEw6hMkjgvQ0Hqu5VihLR5y8P5+HoEiw0ZVx/LlLp0/YSuwobSja5DgFQg
         jXVg2uDjmyFOZ8cz0pkOnkONJv1G4yjncb/JjJLp+36oqyl/b6/KFfZR0O8jejSu8g9I
         VmyOEDvzVaBvh0FVhAn3re5rPxZ3YSV8QxztzUHhnsmRwtoTf997eHAgL2sFCfYmuWnj
         RzROcKVhDOLEBj0++DngrZkHUXAWRbwOTyp4lMk95bM0qy6tWldD4sr9W25Ebqvx5TvG
         p0yiSDttRRBc/BfG/t7aF4HPusXs7d7XDm3u9pMjDHuj0QawMQTvre01TWQduaHf5uM6
         YT/g==
X-Gm-Message-State: AOAM533FLKjoGaOn6Vuh71G+lfzC78JRVSG5RooREhDKTN83LFcvh4Fb
        KoqNwXcspt3wUmlU+nVLa9rPZmb2j1xZE1efmSs=
X-Google-Smtp-Source: ABdhPJwoonCKxmzf/tUECN844T0+j1DgE51si239IaHaOVGfOjRGC8zQKtdtLeOIlOf4EAwMcjk065pHXjjOpJVWEJQ=
X-Received: by 2002:a63:d7:: with SMTP id 206mr17294971pga.30.1617492723066;
 Sat, 03 Apr 2021 16:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CAENS6EtcOH-Sr0Ct09qzzXb9qBMNyM7Dj9vScffvaz_o=wcvJg@mail.gmail.com>
 <3661a919-17e8-7511-5f63-5b93ee84fe60@fb.com>
In-Reply-To: <3661a919-17e8-7511-5f63-5b93ee84fe60@fb.com>
From:   David Blaikie <dblaikie@gmail.com>
Date:   Sat, 3 Apr 2021 16:31:51 -0700
Message-ID: <CAENS6EvFFaxpgkpas+22Mfj3eiuBH_K_=UZHeN_GeP9+wNxmuw@mail.gmail.com>
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

On Sat, Apr 3, 2021 at 1:20 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/3/21 11:52 AM, David Blaikie wrote:
> > On Sat, Apr 3, 2021 at 11:42 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Currently, when DWARF5 is enabled in kernel, DEBUG_INFO_BTF
> >> needs to be disabled. I hacked the kernel to enable DEBUG_INFO_BTF
> >> like:
> >>    --- a/lib/Kconfig.debug
> >>    +++ b/lib/Kconfig.debug
> >>    @@ -286,7 +286,6 @@ config DEBUG_INFO_DWARF5
> >>            bool "Generate DWARF Version 5 debuginfo"
> >>            depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> >>            depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> >>    -       depends on !DEBUG_INFO_BTF
> >>            help
> >> and tried DWARF5 with latest trunk clang, thin-lto and no lto.
> >> In both cases, I got a few additional failures like:
> >>    $ ./test_progs -n 55/2
> >>    ...
> >>    libbpf: extern (var ksym) 'bpf_prog_active': failed to find BTF ID in kernel BTF(s).
> >>    libbpf: failed to load object 'kfunc_call_test_subprog'
> >>    libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
> >>    test_subprog:FAIL:skel unexpected error: 0
> >>    #55/2 subprog:FAIL
> >>
> >> Here, bpf_prog_active is a percpu global variable and pahole is supposed to
> >> put into BTF, but it is not there.
> >>
> >> Further analysis shows this is due to encoding difference between
> >> DWARF4 and DWARF5. In DWARF5, a new section .debug_addr
> >> and several new ops, e.g. DW_OP_addrx, are introduced.
> >> DW_OP_addrx is actually an index into .debug_addr section starting
> >> from an offset encoded with DW_AT_addr_base in DW_TAG_compile_unit.
> >>
> >> For the above 'bpf_prog_active' example, with DWARF4, we have
> >>    0x02281a96:   DW_TAG_variable
> >>                    DW_AT_name      ("bpf_prog_active")
> >>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/include/linux/bpf.h")
> >>                    DW_AT_decl_line (1170)
> >>                    DW_AT_decl_column       (0x01)
> >>                    DW_AT_type      (0x0226d171 "int")
> >>                    DW_AT_external  (true)
> >>                    DW_AT_declaration       (true)
> >>
> >>    0x02292f04:   DW_TAG_variable
> >>                    DW_AT_specification     (0x02281a96 "bpf_prog_active")
> >>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
> >>                    DW_AT_decl_line (45)
> >>                    DW_AT_location  (DW_OP_addr 0x28940)
> >> For DWARF5, we have
> >>    0x0138b0a1:   DW_TAG_variable
> >>                    DW_AT_name      ("bpf_prog_active")
> >>                    DW_AT_type      (0x013760b9 "int")
> >>                    DW_AT_external  (true)
> >>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
> >>                    DW_AT_decl_line (45)
> >>                    DW_AT_location  (DW_OP_addrx 0x16)
> >>
> >> This patch added support for DW_OP_addrx. With the patch, the above
> >> failing bpf selftest and other similar failed selftests succeeded.
> >> ---
> >>   dwarf_loader.c | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> NOTE: with this patch, at least for clang trunk, all bpf selftests
> >>        are fine for DWARF5 w.r.t. compiler and pahole. Hopefully
> >>        after pahole 1.21 release, we can remove DWARF5 dependence
> >>        with !DEBUG_INFO_BTF.
> >>
> >> diff --git a/dwarf_loader.c b/dwarf_loader.c
> >> index 82d7131..49336ac 100644
> >> --- a/dwarf_loader.c
> >> +++ b/dwarf_loader.c
> >> @@ -401,8 +401,19 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
> >>   {
> >>          Dwarf_Attribute attr;
> >>          if (dwarf_attr(die, DW_AT_location, &attr) != NULL) {
> >> -               if (dwarf_getlocation(&attr, expr, exprlen) == 0)
> >> +               if (dwarf_getlocation(&attr, expr, exprlen) == 0) {
> >> +                       /* DW_OP_addrx needs additional lookup for real addr. */
> >> +                       if (*exprlen != 0 && expr[0]->atom == DW_OP_addrx) {
> >
> >
> > ^ this change is probably overly narrow. DW_OP_addrx could appear at
> > other locations in a DWARF expression. So whatever code is responsible
> > for doing general evaluation of DWARF expressions should probably be
> > the place to handle this so it can deal with the full generality of
> > expressions, not only this specific case of a DW_OP_addrx as being the
> > first operation in the expression?
>
> We really have a narrow usage here. This code path (DW_OP_addr and
> DW_OP_addrx) is triggered and later on only used when converting
> dwarf to BTF for certain category of global variables and that is
> why address is needed. The above code is only called for
> DW_TAG_variable.
>
> The previous code to handle DW_OP_addr also only took the first expression.
>
>          if (attr_location(die, &location->expr, &location->exprlen) != 0)
>                  scope = VSCOPE_OPTIMIZED;
>          else if (location->exprlen != 0) {
>                  Dwarf_Op *expr = location->expr;
>                  switch (expr->atom) {
>                  case DW_OP_addr:
>                          scope = VSCOPE_GLOBAL;
>                          *addr = expr[0].number;
>                          break;
>         ......

Fair enough - if it's that limited, as you say - this is nothing new then.

> Do you think we could have multiple OPs for an *external* variable location?

With LTO I believe Clang can merge globals, but looks like only
internal linkage variables & I can't quite tickle the codepath at a
quick glance right now.




>
> >
> >>
> >> +                               Dwarf_Attribute addr_attr;
> >> +                               dwarf_getlocation_attr(&attr, expr[0], &addr_attr);
> >> +
> >> +                               Dwarf_Addr address;
> >> +                               dwarf_formaddr (&addr_attr, &address);
> >> +
> >> +                               expr[0]->number = address;
> >> +                       }
> >>                          return 0;
> >> +               }
> >>          }
> >>
> >>          return 1;
> >> @@ -626,6 +637,7 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
> >>                  Dwarf_Op *expr = location->expr;
> >>                  switch (expr->atom) {
> >>                  case DW_OP_addr:
> >> +               case DW_OP_addrx:
> >>                          scope = VSCOPE_GLOBAL;
> >>                          *addr = expr[0].number;
> >>                          break;
> >> --
> >> 2.30.2
> >>
