Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38553522C8
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 00:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhDAWbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 18:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhDAWbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 18:31:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8159C0613E6;
        Thu,  1 Apr 2021 15:31:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j25so2459199pfe.2;
        Thu, 01 Apr 2021 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iieyhfxFzSunIm68V0GaAga+HoZGLZOJ1KVMEPftwM=;
        b=ALSwpaj0t28/79f+eFI+mJ6CmuS1amzoBNOL9rAoMRn/wwNIVwyFZO3zQz26dWvKH0
         OW7zYC6xt9zt1BXG2Bw04TRF50CmxEsWLOMhUBGniehPszIRMyEVrX4xxE4ovFvq7Ah6
         PMVf2NskyO+UsW+6M7zfeOQdTTq9xtRbQvK1DYS2ciUBzldIorbvQUobALKURbHLcQNr
         BhPFGyED297HcaG9+Sq1b6ezfpYGbY7zz8E4rxPPVBiP8ePZa6zVHhNurKK8Ndsw2o6P
         wSECwDQPeQNDv1M3eIITRYebgkSulX1CWAb0s+VthRUYQ5r1Z0uijgfjwyRkKSnHI3b0
         fqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iieyhfxFzSunIm68V0GaAga+HoZGLZOJ1KVMEPftwM=;
        b=eIEbT103idi8nBTmoEPpJl6GMIaO0Bzf6g/9KqwMncV4g7XitSTlCjeo4UfC/tUw8A
         A6Z/rGqpQd1mC73TZjRqAI3jknr/P1cx7FYFG0ZztYuP+3NV3iQyes/sY9g2B3zSg0J6
         ao4d7a/gBm+NGqgVE4cwnBeXkCYeRvmsri57hHoqFQ2xqXzKsss79lBGkhQdUwHVXtVE
         8UHOKSr8INQ5wYgp627F96oiSiFyLEeVzZUMdArenJODy7zTlij/tva1kfV4uIkU3ck+
         N0KvZkWFXIJn448Lr/p+mGlRFvM20sNy+6ust1xgDSlXvTZHlrPbDrJhk51ZEVvzxjml
         sNig==
X-Gm-Message-State: AOAM530Oe4AsbF9Gn7bM/2ofdxji334JCq77LUfVZfP/cqczkP+U8I71
        LzwtOQdCA9FjS+gHfargdMhGONF/wKfxeZzdwq0=
X-Google-Smtp-Source: ABdhPJx1PybQ5dXA4IUGL4CecM73Uz1OqpMn8PaTSP0p/+GSxwV3O9XlugpUbm15DTetY32tCb9mAwOW6n2rqSxo0zc=
X-Received: by 2002:a63:d7:: with SMTP id 206mr9416198pga.30.1617316266333;
 Thu, 01 Apr 2021 15:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210401213620.3056084-1-yhs@fb.com> <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
In-Reply-To: <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
From:   David Blaikie <dblaikie@gmail.com>
Date:   Thu, 1 Apr 2021 15:30:55 -0700
Message-ID: <CAENS6Evad9Z77BUCHmtrRMO8k-fX=7VTH1YamntNtrC1xGphQw@mail.gmail.com>
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

On Thu, Apr 1, 2021 at 2:41 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/1/21 2:36 PM, Yonghong Song wrote:
> > With latest bpf-next built with clang lto (thin or full), I hit one test
> > failures:
> >    $ ./test_progs -t tcp
> >    ...
> >    libbpf: extern (func ksym) 'tcp_slow_start': func_proto [23] incompatible with kernel [115303]
> >    libbpf: failed to load object 'bpf_cubic'
> >    libbpf: failed to load BPF skeleton 'bpf_cubic': -22
> >    test_cubic:FAIL:bpf_cubic__open_and_load failed
> >    #9/2 cubic:FAIL
> >    ...
> >
> > The reason of the failure is due to bpf program 'tcp_slow_start'
> > func signature is different from vmlinux BTF. bpf program uses
> > the following signature:
> >    extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked);
> > which is identical to the kernel definition in linux:include/net/tcp.h:
> >    u32 tcp_slow_start(struct tcp_sock *tp, u32 acked);
> > While vmlinux BTF definition like:
> >    [115303] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
> >            'tp' type_id=39373
> >            'acked' type_id=18
> >    [115304] FUNC 'tcp_slow_start' type_id=115303 linkage=static
> > The above is dumped with `bpftool btf dump file vmlinux`.
> > You can see the ret_type_id is 0 and this caused the problem.
> >
> > Looking at dwarf, we have:
> >
> > 0x11f2ec67:   DW_TAG_subprogram
> >                  DW_AT_low_pc    (0xffffffff81ed2330)
> >                  DW_AT_high_pc   (0xffffffff81ed235c)
> >                  DW_AT_frame_base        ()
> >                  DW_AT_GNU_all_call_sites        (true)
> >                  DW_AT_abstract_origin   (0x11f2ed66 "tcp_slow_start")
> > ...
> > 0x11f2ed66:   DW_TAG_subprogram
> >                  DW_AT_name      ("tcp_slow_start")
> >                  DW_AT_decl_file ("/home/yhs/work/bpf-next/net/ipv4/tcp_cong.c")
> >                  DW_AT_decl_line (392)
> >                  DW_AT_prototyped        (true)
> >                  DW_AT_type      (0x11f130c2 "u32")
> >                  DW_AT_external  (true)
> >                  DW_AT_inline    (DW_INL_inlined)
>
> David,
>
> Could you help confirm whether DW_AT_abstract_origin at a
> DW_TAG_subprogram always points to another DW_TAG_subprogram,
> or there are possible other cases?

That's correct, so far as I understand the spec, specifically DWARFv5
3.3.8.3 says:

"The root entry for a concrete out-of-line instance of a given inlined
subroutine has the same tag as does its associated (abstract) inlined
subroutine entry (that is, tag DW_TAG_subprogram rather than
DW_TAG_inlined_subroutine)."

Though people may come up with novel uses of DWARF features. What
would happen if this constraint were violated/what's your motivation
for asking (I don't quite understand the connection between test_progs
failure description, and this question)

- David

>
> Thanks,
>
> >
> > We have a subprogram which has an abstract_origin pointing to
> > the subprogram prototype with return type. Current one pass
> > recoding cannot easily resolve this easily since
> > at the time recoding for 0x11f2ec67, the return type in
> > 0x11f2ed66 has not been resolved.
> >
> > To simplify implementation, I just added another pass to
> > go through all functions after recoding pass. This should
> > resolve the above issue.
> >
> > With this patch, among total 250999 functions in vmlinux,
> > 4821 functions needs return type adjustment from type id 0
> > to correct values. The above failed bpf selftest passed too.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >   dwarf_loader.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 46 insertions(+)
> >
> > Arnaldo, this is the last known pahole bug in my hand w.r.t. clang
> > LTO. With this, all self tests are passed except ones due
> > to global function inlining, static variable promotion etc, which
> > are not related to pahole.
> >
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index 026d137..367ac06 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -2198,6 +2198,42 @@ out:
> >       return 0;
> >   }
> >
> > +static int cu__resolve_func_ret_types(struct cu *cu)
> > +{
> > +     struct ptr_table *pt = &cu->functions_table;
> > +     uint32_t i;
> > +
> > +     for (i = 0; i < pt->nr_entries; ++i) {
> > +             struct tag *tag = pt->entries[i];
> > +
> > +             if (tag == NULL || tag->type != 0)
> > +                     continue;
> > +
> > +             struct function *fn = tag__function(tag);
> > +             if (!fn->abstract_origin)
> > +                     continue;
> > +
> > +             struct dwarf_tag *dtag = tag->priv;
> > +             struct dwarf_tag *dfunc;
> > +             dfunc = dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
> > +             if (dfunc == NULL) {
> > +                     tag__print_abstract_origin_not_found(tag);
> > +                     return -1;
> > +             }
> > +
> > +             /*
> > +              * Based on what I see it should be a subprogram,
> > +              * but double check anyway to ensure I won't mess up
> > +              * now and in the future.
> > +              */
> > +             if (dfunc->tag->tag != DW_TAG_subprogram)
> > +                     continue;
> > +
> > +             tag->type = dfunc->tag->type;
> > +     }
> > +     return 0;
> > +}
> > +
> >   static int cu__recode_dwarf_types_table(struct cu *cu,
> >                                       struct ptr_table *pt,
> >                                       uint32_t i)
> > @@ -2637,6 +2673,16 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
> >       /* process merged cu */
> >       if (cu__recode_dwarf_types(cu) != LSK__KEEPIT)
> >               return DWARF_CB_ABORT;
> > +
> > +     /*
> > +      * for lto build, the function return type may not be
> > +      * resolved due to the return type of a subprogram is
> > +      * encoded in another subprogram through abstract_origin
> > +      * tag. Let us visit all subprograms again to resolve this.
> > +      */
> > +     if (cu__resolve_func_ret_types(cu) != LSK__KEEPIT)
> > +             return DWARF_CB_ABORT;
> > +
> >       if (finalize_cu_immediately(cus, cu, dcu, conf)
> >           == LSK__STOP_LOADING)
> >               return DWARF_CB_ABORT;
> >
