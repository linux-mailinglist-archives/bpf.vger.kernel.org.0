Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2214B685D9D
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 04:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBADCm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 22:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBADCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 22:02:41 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F834327
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 19:02:35 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id h24so15599948qta.12
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 19:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CruoWb80s0M9imTMXvz+EytrJTjwSGQ/6Jbn5ARwgss=;
        b=yxuRcD89f8lzB69SQSxjnPmscHC/y0ScUpqa/jcoYB9h7SovM7dmqhFbYA30KRsTmF
         8MMfwPg49hSP3VR/tTSKNkXkpQMHuLElfjB27GQejNu8IJvY1eFBG53RGRCabmkNhdzM
         QIJKKcykRAYn3sc9SiM6GF7TjVwzMu+U0NwwVfc74swPCEtKAYgQUQaVvvz89uZD/5+/
         K0+9Vwr1/BwnQx2Q1MDBUbTLIj2zWyLiw33OCfjbfR2g5En7KQOxbdTMpoA7f/Skc3fK
         whZ0a0EVkv4KwraGmJKQ1y0G7iWmSSMK6c0znFQLq9AtnIyN90QOkg9SbZN0XWSNp7jG
         69vQ==
X-Gm-Message-State: AO0yUKWuI37F+rZWBgDP2cv7Ky72YUzvQ+d9PzKOwA5LxsLir2hGCrN0
        4ZZdoTyGwW09b7LkXmsHyJc=
X-Google-Smtp-Source: AK7set+kuRQg7RcnswJU6b2EHTIqYqt397fM7YCHrlg+dys/0vt2tSfYPsA3OoI4CfIQrG4P0H01dw==
X-Received: by 2002:ac8:5e10:0:b0:3b9:a60f:b2bb with SMTP id h16-20020ac85e10000000b003b9a60fb2bbmr1847582qtx.56.1675220554812;
        Tue, 31 Jan 2023 19:02:34 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:62fc])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8428b000000b003b63b8df24asm3505167qtl.36.2023.01.31.19.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 19:02:33 -0800 (PST)
Date:   Tue, 31 Jan 2023 21:02:31 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9nWR7mNGeGCDLYz@maniforge>
References: <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org>
 <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
> >
> > On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
> > > On 31/01/2023 18:16, Alexei Starovoitov wrote:
> > > > On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > >>
> > > >> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >>>
> > > >>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> > > >>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > >>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> > > >>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > > >>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > >>>>>>>> +++ b/dwarves.h
> > > >>>>>>>> @@ -262,6 +262,7 @@ struct cu {
> > > >>>>>>>>   uint8_t          has_addr_info:1;
> > > >>>>>>>>   uint8_t          uses_global_strings:1;
> > > >>>>>>>>   uint8_t          little_endian:1;
> > > >>>>>>>> + uint8_t          nr_register_params;
> > > >>>>>>>>   uint16_t         language;
> > > >>>>>>>>   unsigned long    nr_inline_expansions;
> > > >>>>>>>>   size_t           size_inline_expansions;
> > > >>>>>>>
> > > >>>>>
> > > >>>>>> Thanks for this, never thought of cross-builds to be honest!
> > > >>>>>
> > > >>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
> > > >>>>>> into one small thing on one system; turns out EM_RISCV isn't
> > > >>>>>> defined if using a very old elf.h; below works around this
> > > >>>>>> (dwarves otherwise builds fine on this system).
> > > >>>>>
> > > >>>>> Ok, will add it and will test with containers for older distros too.
> > > >>>>
> > > >>>> Its on the 'next' branch, so that it gets tested in the libbpf github
> > > >>>> repo at:
> > > >>>>
> > > >>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> > > >>>>
> > > >>>> It failed yesterday and today due to problems with the installation of
> > > >>>> llvm, probably tomorrow it'll be back working as I saw some
> > > >>>> notifications floating by.
> > > >>>>
> > > >>>> I added the conditional EM_RISCV definition as well as removed the dup
> > > >>>> iterator that Jiri noticed.
> > > >>>>
> > > >>>
> > > >>> Thanks again Arnaldo! I've hit an issue with this series in
> > > >>> BTF encoding of kfuncs; specifically we see some kfuncs missing
> > > >>> from the BTF representation, and as a result:
> > > >>>
> > > >>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > > >>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > > >>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> > > >>>
> > > >>> Not sure why I didn't notice this previously.
> > > >>>
> > > >>> The problem is the DWARF - and therefore BTF - generated for a function like
> > > >>>
> > > >>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > > >>> {
> > > >>>         return -EOPNOTSUPP;
> > > >>> }
> > > >>>
> > > >>> looks like this:
> > > >>>
> > > >>>    <8af83a2>   DW_AT_external    : 1
> > > >>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> > > >>>     <8af83a6>   DW_AT_decl_file   : 5
> > > >>>     <8af83a7>   DW_AT_decl_line   : 737
> > > >>>     <8af83a9>   DW_AT_decl_column : 5
> > > >>>     <8af83aa>   DW_AT_prototyped  : 1
> > > >>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
> > > >>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> > > >>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> > > >>>     <8af83b3>   DW_AT_name        : ctx
> > > >>>     <8af83b7>   DW_AT_decl_file   : 5
> > > >>>     <8af83b8>   DW_AT_decl_line   : 737
> > > >>>     <8af83ba>   DW_AT_decl_column : 51
> > > >>>     <8af83bb>   DW_AT_type        : <0x8af421d>
> > > >>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> > > >>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> > > >>>     <8af83c4>   DW_AT_decl_file   : 5
> > > >>>     <8af83c5>   DW_AT_decl_line   : 737
> > > >>>     <8af83c7>   DW_AT_decl_column : 61
> > > >>>     <8af83c8>   DW_AT_type        : <0x8adc424>
> > > >>>
> > > >>> ...and because there are no further abstract origin references
> > > >>> with location information either, we classify it as lacking
> > > >>> locations for (some of) the parameters, and as a result
> > > >>> we skip BTF encoding. We can work around that by doing this:
> > > >>>
> > > >>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > > >>
> > > >> replied in the other thread. This attr is broken and discouraged by gcc.
> > > >>
> > > >> For kfuncs where aregs are unused, please try __used and __may_unused
> > > >> applied to arguments.
> > > >> If that won't work, please add barrier_var(arg) to the body of kfunc
> > > >> the way we do in selftests.
> > > >
> > > > There is also
> > > > # define __visible __attribute__((__externally_visible__))
> > > > that probably fits the best here.
> > > >
> > >
> > > testing thus for seems to show that for x86_64, David's series
> > > (using __used noinline in the BPF_KFUNC() wrapper and extended
> > > to cover recently-arrived kfuncs like cpumask) is sufficient
> > > to avoid resolve_btfids warnings.
> >
> > Nice. Alexei -- lmk how you want to proceed. I think using the
> > __bpf_kfunc macro in the short term (with __used and noinline) is
> > probably the least controversial way to unblock this, but am open to
> > other suggestions.
> 
> Sounds good to me, but sounds like __used and noinline are not
> enough to address the issues on aarch64?

Indeed, we'll have to make sure that's also addressed. Alan -- did you
try Alexei's suggestion to use __weak? Does that fix the issue for
aarch64? I'm still confused as to why it's only complaining for a small
subset of kfuncs, which include those that have external linkage.

> 
> > Yeah, I tend to think we should try to avoid using hidden / visible
> > attributes given that (to my knowledge) they're really more meant for
> > controlling whether a symbol is exported from a shared object rather
> > than controlling what the compiler is doing when it creates the
> > compilation unit. One could imagine that in an LTO build, the compiler
> > would still optimize the function regardless of its visibility for that
> > reason, though it's possible I don't have the full picture.
> 
> __visible is specifically done to prevent optimization of
> functions that are externally visible. That should address LTO concerns.
> We haven't seen LTO messing up anything. Just something to keep in mind.

Ah, fair enough. I was conflating that with the visibility("...")
attribute. As you pointed out, __visible is something else entirely, and
is meant to avoid possible issues with LTO.

One other option we could consider is enforcing that kfuncs must have
global linkage and can't be static. If we did that, it seems like
__visible would be a viable option. Though we'd have to verify that it
addresses the issue w/ aarch64.
