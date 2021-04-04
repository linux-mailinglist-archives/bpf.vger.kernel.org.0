Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAB35392F
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhDDRac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDRa0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Apr 2021 13:30:26 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18445C061756;
        Sun,  4 Apr 2021 10:30:22 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id f5so4522216ilr.9;
        Sun, 04 Apr 2021 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7mGuzG5DzQ7O+PZijgu93NzF1xytAhcFWtQwujNRV9I=;
        b=soj1U/j6XTEnGJ3sgdcp2u84tvSc95h3lCn8kLu2Wk/2gLixmjhv4COnpC2BSA+N5T
         3dyAEK+r4hc+sKihiwOiUMkit+VBmYNx3skFonSHoXWU95w5I044ij6hLqo+GEAmn9+v
         NURqZUsUK8w7Y52tv58coB+hyrKmk9xhquJOrxal7eSDVn4OPYwamvMwh4eOWmNg5mwi
         gOzGc5V3H3/XE4HUCOX2ZcAtm9YzPPI9+47E2YXeY8D22xToYOOaQF9AV4o8/uH9VELX
         YJu2CjyAaxYt5VJkFNaQo+RA3htEt4LTxhcunqMzVSZvUo5wtP9JHhd9MLS06RZUBQ/V
         fhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7mGuzG5DzQ7O+PZijgu93NzF1xytAhcFWtQwujNRV9I=;
        b=eCimVVmDeP3HALoRjRLaP+4H5372ryYq3cL6k4at1/5xXZ2AdmZRCluVHLelq5yVse
         jRn4s+Nb+7DfalWyXl3910p8IjHvnkksBnBuEtB4JuJH3H58FTNSoAiCULjUijm5fYDo
         GQTqBUE6W8KY0HOekC2Sz5FUfuEdfwbqHKSGgpXz+FDKOrQo0Ba0qdgyQQFI9fZXP+hI
         8xg0knMtny11CWaLIEmTcjT6agquIqydJjc77MQh8VftbikEF8aaELNnxfi3Ya73PPSz
         iahBxzLb+dpA28W0cVRqfQTBBVTuCLKptxMYZKWmj8pDTO5Bxmc1FroXl7hfMhg1AqYL
         6l+Q==
X-Gm-Message-State: AOAM5323SXg+71PuYRyu7zcBYLhAXr5q2NJ2NNAqa6UcNKpMxbZqZSOA
        A4g6tNtKRvLP7KFH5J6xbgxoBX6yl7srfiR9dbWsj+AX/pafbg==
X-Google-Smtp-Source: ABdhPJw11XpCMHvtulWoJWIkPcCbbHhpRgTNhTDI+Wpsf98nqzs1ZzKTLUbA5UtpHGB1GucVjZNIcZqxGrmfRqZ7jNU=
X-Received: by 2002:a05:6e02:12cc:: with SMTP id i12mr17722312ilm.10.1617557421543;
 Sun, 04 Apr 2021 10:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <d4786dab-b35c-c8f4-a848-3fc9f93228a0@fb.com>
In-Reply-To: <d4786dab-b35c-c8f4-a848-3fc9f93228a0@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 4 Apr 2021 19:29:44 +0200
Message-ID: <CA+icZUU29Le+9uZvyO0UyC1uoHbV+HvP02EvZDoBy_QHZEJ2cw@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        David Blaikie <dblaikie@gmail.com>, kernel-team@fb.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 4, 2021 at 6:45 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/3/21 11:41 AM, Yonghong Song wrote:
> > Currently, when DWARF5 is enabled in kernel, DEBUG_INFO_BTF
> > needs to be disabled. I hacked the kernel to enable DEBUG_INFO_BTF
> > like:
> >    --- a/lib/Kconfig.debug
> >    +++ b/lib/Kconfig.debug
> >    @@ -286,7 +286,6 @@ config DEBUG_INFO_DWARF5
> >            bool "Generate DWARF Version 5 debuginfo"
> >            depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> >            depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> >    -       depends on !DEBUG_INFO_BTF
> >            help
> > and tried DWARF5 with latest trunk clang, thin-lto and no lto.
> > In both cases, I got a few additional failures like:
> >    $ ./test_progs -n 55/2
> >    ...
> >    libbpf: extern (var ksym) 'bpf_prog_active': failed to find BTF ID in kernel BTF(s).
> >    libbpf: failed to load object 'kfunc_call_test_subprog'
> >    libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
> >    test_subprog:FAIL:skel unexpected error: 0
> >    #55/2 subprog:FAIL
> >
> > Here, bpf_prog_active is a percpu global variable and pahole is supposed to
> > put into BTF, but it is not there.
> >
> > Further analysis shows this is due to encoding difference between
> > DWARF4 and DWARF5. In DWARF5, a new section .debug_addr
> > and several new ops, e.g. DW_OP_addrx, are introduced.
> > DW_OP_addrx is actually an index into .debug_addr section starting
> > from an offset encoded with DW_AT_addr_base in DW_TAG_compile_unit.
> >
> > For the above 'bpf_prog_active' example, with DWARF4, we have
> >    0x02281a96:   DW_TAG_variable
> >                    DW_AT_name      ("bpf_prog_active")
> >                    DW_AT_decl_file ("/home/yhs/work/bpf-next/include/linux/bpf.h")
> >                    DW_AT_decl_line (1170)
> >                    DW_AT_decl_column       (0x01)
> >                    DW_AT_type      (0x0226d171 "int")
> >                    DW_AT_external  (true)
> >                    DW_AT_declaration       (true)
> >
> >    0x02292f04:   DW_TAG_variable
> >                    DW_AT_specification     (0x02281a96 "bpf_prog_active")
> >                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
> >                    DW_AT_decl_line (45)
> >                    DW_AT_location  (DW_OP_addr 0x28940)
> > For DWARF5, we have
> >    0x0138b0a1:   DW_TAG_variable
> >                    DW_AT_name      ("bpf_prog_active")
> >                    DW_AT_type      (0x013760b9 "int")
> >                    DW_AT_external  (true)
> >                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
> >                    DW_AT_decl_line (45)
> >                    DW_AT_location  (DW_OP_addrx 0x16)
> >
> > This patch added support for DW_OP_addrx. With the patch, the above
> > failing bpf selftest and other similar failed selftests succeeded.
>
> Arnaldo, sorry, I just found that I forgot signed-off. Here it is,
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
>
> If no further change is needed for this patch, maybe you can help add
> it? Otherwise, I can add it in v2. Thanks!
>

I see a S-o-b when using b4 tool:

link="https://lore.kernel.org/bpf/20210403184158.2834387-1-yhs@fb.com"
b4 -d am $link

$ grep Signed-off-by:
20210403_yhs_dwarf_loader_handle_dwarf5_dw_op_addrx_properly.mbx
71:Signed-off-by: Yonghong Song <yhs@fb.com>

- Sedat -
> > ---
> >   dwarf_loader.c | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > NOTE: with this patch, at least for clang trunk, all bpf selftests
> >        are fine for DWARF5 w.r.t. compiler and pahole. Hopefully
> >        after pahole 1.21 release, we can remove DWARF5 dependence
> >        with !DEBUG_INFO_BTF.
> >
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index 82d7131..49336ac 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -401,8 +401,19 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
> >   {
> >       Dwarf_Attribute attr;
> >       if (dwarf_attr(die, DW_AT_location, &attr) != NULL) {
> > -             if (dwarf_getlocation(&attr, expr, exprlen) == 0)
> > +             if (dwarf_getlocation(&attr, expr, exprlen) == 0) {
> > +                     /* DW_OP_addrx needs additional lookup for real addr. */
> > +                     if (*exprlen != 0 && expr[0]->atom == DW_OP_addrx) {
> > +                             Dwarf_Attribute addr_attr;
> > +                             dwarf_getlocation_attr(&attr, expr[0], &addr_attr);
> > +
> > +                             Dwarf_Addr address;
> > +                             dwarf_formaddr (&addr_attr, &address);
> > +
> > +                             expr[0]->number = address;
> > +                     }
> >                       return 0;
> > +             }
> >       }
> >
> >       return 1;
> > @@ -626,6 +637,7 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
> >               Dwarf_Op *expr = location->expr;
> >               switch (expr->atom) {
> >               case DW_OP_addr:
> > +             case DW_OP_addrx:
> >                       scope = VSCOPE_GLOBAL;
> >                       *addr = expr[0].number;
> >                       break;
> >
