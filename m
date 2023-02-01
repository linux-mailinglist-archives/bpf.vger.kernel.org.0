Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC936869F0
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 16:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjBAPUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 10:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjBAPTg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 10:19:36 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89677618E
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 07:19:15 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id s4so17223154qtx.6
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 07:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJYfjcJSIe7z0gY+GGjnQ8LMXwLXXp1lX1rHsUEQzbo=;
        b=0y1CkizdX1DXuJdkMvoSTdn+XCNPhREhclAhFbVSZlYUYqWpJFcXL8xLi4THaNvvVo
         duKLgnk4jfokR5D/i+KEC3IgOsZj7wU0v7PKw5RJ1TbIMtLHxte8b0UfxfPn/Lq6eoFa
         WjP3dhvzp1XEF3uPknxdg/SW2Toj+JQTonMGF0GrwOdfWto+MssQmm6ZLGJUmje55eGH
         58/kz154jzCTmVPXCrwf0uT5JO9yG6KJUPAwrF9bsAYnLTDw7rnzPvf4jr197B2wpE2o
         OvGCDwvK/pQ02ihaAU4v04HIgrvVoPpzBoFBdYQ0fFb+kLotSNTDIFxi5s0ryZUKfR4U
         CnKg==
X-Gm-Message-State: AO0yUKWAlRdc1EI2tMy9/+c5pEX/UJ03xbpHIi4FVOgcRhQtLnYGx7ep
        V1Rknv5so92DxdQ7wR+NWjI=
X-Google-Smtp-Source: AK7set+4hxjg6ElFGqhKStC8/YgTwKjaeu8T3U/oCwErWLge3TVqHdg7Sbcb/sRfwCfBdkE/J0j1lQ==
X-Received: by 2002:a05:622a:511:b0:3b6:35cc:a5c1 with SMTP id l17-20020a05622a051100b003b635cca5c1mr4284556qtx.20.1675264745307;
        Wed, 01 Feb 2023 07:19:05 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:1971])
        by smtp.gmail.com with ESMTPSA id c5-20020ac80085000000b003b323387c1asm2079078qtg.18.2023.02.01.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:19:03 -0800 (PST)
Date:   Wed, 1 Feb 2023 09:19:01 -0600
From:   David Vernet <void@manifault.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <Y9qC5UQaw9g6cPwz@maniforge>
References: <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
 <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9p+70RzH7QiO2Mw@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 12:02:07PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 01, 2023 at 01:59:30PM +0000, Alan Maguire escreveu:
> > On 01/02/2023 03:02, David Vernet wrote:
> > > On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
> > >> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
> > >>>
> > >>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
> > >>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
> > >>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
> > >>>>> <alexei.starovoitov@gmail.com> wrote:
> > >>>>>>
> > >>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >>>>>>>
> > >>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> > >>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> > >>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > >>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >>>>>>>>>>>> +++ b/dwarves.h
> > >>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
> > >>>>>>>>>>>>   uint8_t          has_addr_info:1;
> > >>>>>>>>>>>>   uint8_t          uses_global_strings:1;
> > >>>>>>>>>>>>   uint8_t          little_endian:1;
> > >>>>>>>>>>>> + uint8_t          nr_register_params;
> > >>>>>>>>>>>>   uint16_t         language;
> > >>>>>>>>>>>>   unsigned long    nr_inline_expansions;
> > >>>>>>>>>>>>   size_t           size_inline_expansions;
> > >>>>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
> > >>>>>>>>>
> > >>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
> > >>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
> > >>>>>>>>>> defined if using a very old elf.h; below works around this
> > >>>>>>>>>> (dwarves otherwise builds fine on this system).
> > >>>>>>>>>
> > >>>>>>>>> Ok, will add it and will test with containers for older distros too.
> > >>>>>>>>
> > >>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
> > >>>>>>>> repo at:
> > >>>>>>>>
> > >>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> > >>>>>>>>
> > >>>>>>>> It failed yesterday and today due to problems with the installation of
> > >>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
> > >>>>>>>> notifications floating by.
> > >>>>>>>>
> > >>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
> > >>>>>>>> iterator that Jiri noticed.
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
> > >>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
> > >>>>>>> from the BTF representation, and as a result:
> > >>>>>>>
> > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> > >>>>>>>
> > >>>>>>> Not sure why I didn't notice this previously.
> > >>>>>>>
> > >>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
> > >>>>>>>
> > >>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > >>>>>>> {
> > >>>>>>>         return -EOPNOTSUPP;
> > >>>>>>> }
> > >>>>>>>
> > >>>>>>> looks like this:
> > >>>>>>>
> > >>>>>>>    <8af83a2>   DW_AT_external    : 1
> > >>>>>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> > >>>>>>>     <8af83a6>   DW_AT_decl_file   : 5
> > >>>>>>>     <8af83a7>   DW_AT_decl_line   : 737
> > >>>>>>>     <8af83a9>   DW_AT_decl_column : 5
> > >>>>>>>     <8af83aa>   DW_AT_prototyped  : 1
> > >>>>>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
> > >>>>>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> > >>>>>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> > >>>>>>>     <8af83b3>   DW_AT_name        : ctx
> > >>>>>>>     <8af83b7>   DW_AT_decl_file   : 5
> > >>>>>>>     <8af83b8>   DW_AT_decl_line   : 737
> > >>>>>>>     <8af83ba>   DW_AT_decl_column : 51
> > >>>>>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
> > >>>>>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> > >>>>>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> > >>>>>>>     <8af83c4>   DW_AT_decl_file   : 5
> > >>>>>>>     <8af83c5>   DW_AT_decl_line   : 737
> > >>>>>>>     <8af83c7>   DW_AT_decl_column : 61
> > >>>>>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
> > >>>>>>>
> > >>>>>>> ...and because there are no further abstract origin references
> > >>>>>>> with location information either, we classify it as lacking
> > >>>>>>> locations for (some of) the parameters, and as a result
> > >>>>>>> we skip BTF encoding. We can work around that by doing this:
> > >>>>>>>
> > >>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > >>>>>>
> > >>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
> > >>>>>>
> > >>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
> > >>>>>> applied to arguments.
> > >>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
> > >>>>>> the way we do in selftests.
> > >>>>>
> > >>>>> There is also
> > >>>>> # define __visible __attribute__((__externally_visible__))
> > >>>>> that probably fits the best here.
> > >>>>>
> > >>>>
> > >>>> testing thus for seems to show that for x86_64, David's series
> > >>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
> > >>>> to cover recently-arrived kfuncs like cpumask) is sufficient
> > >>>> to avoid resolve_btfids warnings.
> > >>>
> > >>> Nice. Alexei -- lmk how you want to proceed. I think using the
> > >>> __bpf_kfunc macro in the short term (with __used and noinline) is
> > >>> probably the least controversial way to unblock this, but am open to
> > >>> other suggestions.
> > >>
> > >> Sounds good to me, but sounds like __used and noinline are not
> > >> enough to address the issues on aarch64?
> > > 
> > > Indeed, we'll have to make sure that's also addressed. Alan -- did you
> > > try Alexei's suggestion to use __weak? Does that fix the issue for
> > > aarch64? I'm still confused as to why it's only complaining for a small
> > > subset of kfuncs, which include those that have external linkage.
> > > 
> > 
> > I finally got to the bottom of the aarch64 issues; there was a 1-line bug
> > in the changes I made to the DWARF handling code which leads to BTF generation;
> > it was excluding a bunch of functions incorrectly, marking them as optimized out.
> > The fix is:
> > 
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index dba2d37..8364e17 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -1074,7 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> >                         Dwarf_Op *expr = loc.expr;
> >  
> >                         switch (expr->atom) {
> > -                       case DW_OP_reg1 ... DW_OP_reg31:
> > +                       case DW_OP_reg0 ... DW_OP_reg31:
> >                         case DW_OP_breg0 ... DW_OP_breg31:
> >                                 break;
> >                         default:
> > 
> > ..and because reg0 is the first parameter for aarch64, we were
> > incorrectly landing in the "default:" of the switch statement
> > and marking a bunch of functions as optimized out
> > because we thought the first argument was. Sorry about this,
> > and thanks for all the suggestions!

Great, so inline and __used with __bpf_kfunc sounds like the way forward
in the short term. Arnaldo / Alexei -- how do you want to resolve the
dependency here? Going through bpf-next is probably a good idea so that
we get proper CI coverage, and any kfuncs added to bpf-next after this
can use the macro. Does that work for you?

> > 
> > Arnaldo, will I send a v3 series incorporating the above fix
> > to patch 1?
> 
> I can fix it here. Done, I;ll force push it to the 'next' branch.
> 
> Also I noted the index_idx usage in parameter__new(), it can be -1 when
> processing:
> 
>  <1><2eb2>: Abbrev Number: 18 (DW_TAG_subroutine_type)
>     <2eb3>   DW_AT_prototyped  : 1
>     <2eb3>   DW_AT_sibling     : <0x2ec2>
>  <2><2eb7>: Abbrev Number: 3 (DW_TAG_formal_parameter)
>     <2eb8>   DW_AT_type        : <0x414>
>  <2><2ebc>: Abbrev Number: 3 (DW_TAG_formal_parameter)
>     <2ebd>   DW_AT_type        : <0x69>
>  <2><2ec1>: Abbrev Number: 0
> 
>  And in that case we don't have the location expression:
> 
>   <1><af36>: Abbrev Number: 77 (DW_TAG_subprogram)
>     <af37>   DW_AT_external    : 1
>     <af37>   DW_AT_name        : (indirect string, offset: 0x4ff7): startup_64_setup_env
>     <af3b>   DW_AT_decl_file   : 1
>     <af3b>   DW_AT_decl_line   : 592
>     <af3d>   DW_AT_decl_column : 13
>     <af3e>   DW_AT_prototyped  : 1
>     <af3e>   DW_AT_low_pc      : 0xffffffff81000570
>     <af46>   DW_AT_high_pc     : 0x6d
>     <af4e>   DW_AT_frame_base  : 1 byte block: 9c       (DW_OP_call_frame_cfa)
>     <af50>   DW_AT_call_all_calls: 1
>     <af50>   DW_AT_sibling     : <0xb11f>
>  <2><af54>: Abbrev Number: 67 (DW_TAG_formal_parameter)
>     <af55>   DW_AT_name        : (indirect string, offset: 0x2a50d): physbase
>     <af59>   DW_AT_decl_file   : 1
>     <af59>   DW_AT_decl_line   : 592
>     <af5b>   DW_AT_decl_column : 48
>     <af5c>   DW_AT_type        : <0x4c>
>     <af60>   DW_AT_location    : 0x10 (location list)
>     <af64>   DW_AT_GNU_locviews: 0xc
> 
> I.e. its just a function _type_, not an actual function, so I'm applying
> this on top of that first patch, ok?
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 7e05fde8a5c3ac26..253c5efaf3b55a93 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1035,7 +1035,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
>  
> -		if (param_idx >= cu->nr_register_params)
> +		if (param_idx >= cu->nr_register_params || param_idx < 0)
>  			return parm;
>  		/* Parameters which use DW_AT_abstract_origin to point at
>  		 * the original parameter definition (with no name in the DIE)
> 
> 
> - Arnaldo
>  
> > With this fix in place, prefixing the kfunc functions with
> > 
> > __used noinline
> > 
> > ...did the trick to ensure kfuncs were not excluded on x86_64
> > and aarch64.

[...]

Thanks,
David
