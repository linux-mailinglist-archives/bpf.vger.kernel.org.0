Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982AA352439
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 02:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDBAA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 20:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDBAA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 20:00:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13732C0613E6;
        Thu,  1 Apr 2021 17:00:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ay2so1785498plb.3;
        Thu, 01 Apr 2021 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CZehGQt3kA23ZrhfhHAJYF7GmYpe6W0wkBz5j2xmTo=;
        b=torGvGieSpV3lJHRBMjFmPoybygOyVZjjd06cQLRiYWReJYayBRYAriMqi97crHueK
         vhEMt6bGFMjvL768HKFO8S7Ngc1JhaP/fmyjvvQrMB7IKn6JKNMwQV6XRQsm8alLujvw
         mFmHJfXaPTwa+oKcixWryBceP5ZUDW6Dv7xOWRrGxxeqkXmOcySuZ3QSeyYo4pxkMcG+
         RBt9zp82XbmmtsrpThCWCgNHevoTkqxqhJ+ZhxvVh+zXog/KTxyQinAhAmP4NAWj3A/i
         sD4Rbrov7qgc2g4lhNn9dIE47ZrbceDNDdUn/2dtCYSkkZbTqx/Xqs8BZYouJ+C5afJt
         u+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CZehGQt3kA23ZrhfhHAJYF7GmYpe6W0wkBz5j2xmTo=;
        b=VSeRxD3GLqvWtxjdFEDdJoNH2VbVkQbSFQs27w3XQrzM01mY4Eh9JGXxBfVtVVFRvi
         ZJz7GTHQhORKfkX0Pcw0XRtPKLq1Esip9V500ODXxYELVDzGZWUUUQexnuxjThSA4oCQ
         clI33WsDDCLmjKScXAonEjL4dXJ6lr4/aGtI3YpNmEpfnZBT0XXnwTYQ1+MK4C7WL74o
         7rUTLim/RmR8pOgsPaX/7nCewhafd2FekuuiuUZAh94wqPmwFBDX2+q6vXzxhlhNS1CO
         A3RNsKVEsg+HXpfsUub9ZDAFkchMtTm1JjGLj7dC4EDTROkCoegu/lBAg6JC7f6OINIc
         nQKA==
X-Gm-Message-State: AOAM530QPhUMkV0bKm6Aq/RsRrz+uumMkK4opG3x6L6ewa4wtJmqThYq
        tO8rzDCSlsN+fc8acr0n+QQmSX2wEa8n148zMcM=
X-Google-Smtp-Source: ABdhPJyE0/BSXTyfqxZ9GVOONK8GldPVbUz6/Xn0JHvdtD5IxVPIuUoD39GMMFCm/tkXZXhZuuWQBYs7MeuCofFAwSE=
X-Received: by 2002:a17:902:dac2:b029:e6:30a6:4c06 with SMTP id
 q2-20020a170902dac2b02900e630a64c06mr10279990plx.65.1617321657531; Thu, 01
 Apr 2021 17:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210401213620.3056084-1-yhs@fb.com> <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com> <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
In-Reply-To: <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
From:   David Blaikie <dblaikie@gmail.com>
Date:   Thu, 1 Apr 2021 17:00:46 -0700
Message-ID: <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 1, 2021 at 4:41 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/1/21 3:27 PM, David Blaikie wrote:
> > On Thu, Apr 1, 2021 at 2:41 PM Yonghong Song <yhs@fb.com
> > <mailto:yhs@fb.com>> wrote:
> >  >
> >  >
> >  >
> >  > On 4/1/21 2:36 PM, Yonghong Song wrote:
> >  > > With latest bpf-next built with clang lto (thin or full), I hit one
> > test
> >  > > failures:
> >  > >    $ ./test_progs -t tcp
> >  > >    ...
> >  > >    libbpf: extern (func ksym) 'tcp_slow_start': func_proto [23]
> > incompatible with kernel [115303]
> >  > >    libbpf: failed to load object 'bpf_cubic'
> >  > >    libbpf: failed to load BPF skeleton 'bpf_cubic': -22
> >  > >    test_cubic:FAIL:bpf_cubic__open_and_load failed
> >  > >    #9/2 cubic:FAIL
> >  > >    ...
> >  > >
> >  > > The reason of the failure is due to bpf program 'tcp_slow_start'
> >  > > func signature is different from vmlinux BTF. bpf program uses
> >  > > the following signature:
> >  > >    extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked);
> >  > > which is identical to the kernel definition in linux:include/net/tcp.h:
> >  > >    u32 tcp_slow_start(struct tcp_sock *tp, u32 acked);
> >  > > While vmlinux BTF definition like:
> >  > >    [115303] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
> >  > >            'tp' type_id=39373
> >  > >            'acked' type_id=18
> >  > >    [115304] FUNC 'tcp_slow_start' type_id=115303 linkage=static
> >  > > The above is dumped with `bpftool btf dump file vmlinux`.
> >  > > You can see the ret_type_id is 0 and this caused the problem.
> >  > >
> >  > > Looking at dwarf, we have:
> >  > >
> >  > > 0x11f2ec67:   DW_TAG_subprogram
> >  > >                  DW_AT_low_pc    (0xffffffff81ed2330)
> >  > >                  DW_AT_high_pc   (0xffffffff81ed235c)
> >  > >                  DW_AT_frame_base        ()
> >  > >                  DW_AT_GNU_all_call_sites        (true)
> >  > >                  DW_AT_abstract_origin   (0x11f2ed66 "tcp_slow_start")
> >  > > ...
> >  > > 0x11f2ed66:   DW_TAG_subprogram
> >  > >                  DW_AT_name      ("tcp_slow_start")
> >  > >                  DW_AT_decl_file
> > ("/home/yhs/work/bpf-next/net/ipv4/tcp_cong.c")
> >  > >                  DW_AT_decl_line (392)
> >  > >                  DW_AT_prototyped        (true)
> >  > >                  DW_AT_type      (0x11f130c2 "u32")
> >  > >                  DW_AT_external  (true)
> >  > >                  DW_AT_inline    (DW_INL_inlined)
> >  >
> >  > David,
> >  >
> >  > Could you help confirm whether DW_AT_abstract_origin at a
> >  > DW_TAG_subprogram always points to another DW_TAG_subprogram,
> >  > or there are possible other cases?
> >
> > That's correct, so far as I understand the spec, specifically DWARFv5
> > <http://dwarfstd.org/doc/DWARF5.pdf>
> > 3.3.8.3 says:
> >
> > "The root entry for a concrete out-of-line instance of a given inlined
> > subroutine has the same tag as does its associated (abstract) inlined
> > subroutine entry (that is, tag DW_TAG_subprogram rather than
> > DW_TAG_inlined_subroutine)."
>
> Thanks. That means that some of my codes in the patch is
> dead code.
>
> >
> > Though people may come up with novel uses of DWARF features. What would
> > happen if this constraint were violated/what's your motivation for
> > asking (I don't quite understand the connection between test_progs
> > failure description, and this question)
>
> I have some codes to check the tag associated with abstract_origin
> for a subprogram must be a subprogram. Through experiment, I didn't
> see a violation, so I wonder that I can get confirmation from you
> and then I may delete that code.
>
> The test_progs failure exposed the bug, that is all.
>
> pahole cannot handle all weird usages of dwarf, so I think pahole
> is fine only to support well-formed dwarf.

Sounds good. Thanks for the context!

>
> >
> > - David
> >
> >  >
> >  > Thanks,
> >  >
> >  > >
> >  > > We have a subprogram which has an abstract_origin pointing to
> >  > > the subprogram prototype with return type. Current one pass
> >  > > recoding cannot easily resolve this easily since
> >  > > at the time recoding for 0x11f2ec67, the return type in
> >  > > 0x11f2ed66 has not been resolved.
> >  > >
> >  > > To simplify implementation, I just added another pass to
> >  > > go through all functions after recoding pass. This should
> >  > > resolve the above issue.
> >  > >
> >  > > With this patch, among total 250999 functions in vmlinux,
> >  > > 4821 functions needs return type adjustment from type id 0
> >  > > to correct values. The above failed bpf selftest passed too.
> >  > >
> >  > > Signed-off-by: Yonghong Song <yhs@fb.com <mailto:yhs@fb.com>>
> >  > > ---
> >  > >   dwarf_loader.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  > >   1 file changed, 46 insertions(+)
> >  > >
> >  > > Arnaldo, this is the last known pahole bug in my hand w.r.t. clang
> >  > > LTO. With this, all self tests are passed except ones due
> >  > > to global function inlining, static variable promotion etc, which
> >  > > are not related to pahole.
> >  > >
> >  > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> >  > > index 026d137..367ac06 100644
> >  > > --- a/dwarf_loader.c
> >  > > +++ b/dwarf_loader.c
> >  > > @@ -2198,6 +2198,42 @@ out:
> >  > >       return 0;
> >  > >   }
> >  > >
> >  > > +static int cu__resolve_func_ret_types(struct cu *cu)
> >  > > +{
> >  > > +     struct ptr_table *pt = &cu->functions_table;
> >  > > +     uint32_t i;
> >  > > +
> >  > > +     for (i = 0; i < pt->nr_entries; ++i) {
> >  > > +             struct tag *tag = pt->entries[i];
> >  > > +
> >  > > +             if (tag == NULL || tag->type != 0)
> >  > > +                     continue;
> >  > > +
> >  > > +             struct function *fn = tag__function(tag);
> >  > > +             if (!fn->abstract_origin)
> >  > > +                     continue;
> >  > > +
> >  > > +             struct dwarf_tag *dtag = tag->priv;
> >  > > +             struct dwarf_tag *dfunc;
> >  > > +             dfunc = dwarf_cu__find_tag_by_ref(cu->priv,
> > &dtag->abstract_origin);
> >  > > +             if (dfunc == NULL) {
> >  > > +                     tag__print_abstract_origin_not_found(tag);
> >  > > +                     return -1;
> >  > > +             }
> >  > > +
> >  > > +             /*
> >  > > +              * Based on what I see it should be a subprogram,
> >  > > +              * but double check anyway to ensure I won't mess up
> >  > > +              * now and in the future.
> >  > > +              */
> >  > > +             if (dfunc->tag->tag != DW_TAG_subprogram)
> >  > > +                     continue;
> >  > > +
> >  > > +             tag->type = dfunc->tag->type;
> >  > > +     }
> >  > > +     return 0;
> >  > > +}
> >  > > +
> >  > >   static int cu__recode_dwarf_types_table(struct cu *cu,
> >  > >                                       struct ptr_table *pt,
> >  > >                                       uint32_t i)
> >  > > @@ -2637,6 +2673,16 @@ static int cus__merge_and_process_cu(struct
> > cus *cus, struct conf_load *conf,
> >  > >       /* process merged cu */
> >  > >       if (cu__recode_dwarf_types(cu) != LSK__KEEPIT)
> >  > >               return DWARF_CB_ABORT;
> >  > > +
> >  > > +     /*
> >  > > +      * for lto build, the function return type may not be
> >  > > +      * resolved due to the return type of a subprogram is
> >  > > +      * encoded in another subprogram through abstract_origin
> >  > > +      * tag. Let us visit all subprograms again to resolve this.
> >  > > +      */
> >  > > +     if (cu__resolve_func_ret_types(cu) != LSK__KEEPIT)
> >  > > +             return DWARF_CB_ABORT;
> >  > > +
> >  > >       if (finalize_cu_immediately(cus, cu, dcu, conf)
> >  > >           == LSK__STOP_LOADING)
> >  > >               return DWARF_CB_ABORT;
> >  > >
