Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F16859C4
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 01:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBAAOr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 19:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjBAAOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 19:14:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6845F5E
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:14:26 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mf7so27898691ejc.6
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8N0eRHO3Rt3sWZc2fU+GMbPkacredV3obfra9hQJ6AE=;
        b=YDlU9w3RjTVmWoBQn7J9yB0bejMLi2veqBlWsqf9GlRQsH2ZIBGhU1dr9rrGpx3WPB
         ELWXgZy+2fnQdfASq14q3UuQlQ1r2GodquWm0HOy5goXpar9RT7zSasxFqiuW/hslqbi
         5+hVxvPw2zyswu3s0SwSiZxjIMpN9U34okz461CnfHYxEHzWXCQY+JkbtmW5xE9AlPlK
         pWaJ3bDdFJLGQYpjaD7D/bMYhxf9I8ts4SWSelNZN3ffO+7WeWqsU/Sn1iNsTB8jqr3I
         1jzCq2BmzkB4uInHGqwvDG39akX8pqygbwm4guf/kPqCrSkIsOfVtsx2fTZ+d4CxHudM
         L/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8N0eRHO3Rt3sWZc2fU+GMbPkacredV3obfra9hQJ6AE=;
        b=iYbD7QWTg9p8EePq6L1/on2UsV/j++3M2gdSaPTQVWP4maQPZjzXtMWY3TmXp39RVL
         aFPjdnrJiAWI7I1fVbTZfwX0kFYUk7D2Al/QtSUsbsBLdtA4ijRFApUxioPbut988xCe
         5B708TF199FEmysEvxTg5dFAp2UHoHSdko9G4gbODfUGDMoz83ejEfZKTh4H4Cl70ln7
         B0M0zjoTcrq6rzY0W63qNuSJAN8A1kej9zEhlf9jL+p1MZIDgPBOlLB/y9b9dGG+XsRQ
         +avK5EEHk7wtddIUziR1aUptqp55+syMpN5xn4zwrg9NdnxTP0PVb+0D5odfTYNDc22/
         FwDg==
X-Gm-Message-State: AO0yUKWtaHNg4SbRQckI9k0dFNg8E/92jIiG5FVzmZC5XvrozbYWvLud
        epAl7UPsmuN3z9BtqyZUktTQVqw1cCX7G0QxxU4=
X-Google-Smtp-Source: AK7set/tjWod5V0p+7zm9DRwKKDA8fTn1yF0tL/X+5OVuQ2XEdFMVHLgsQSN+vKG1UENGjAn2SgK0Nf56EdrNtaKA4s=
X-Received: by 2002:a17:906:4b57:b0:878:74d0:c173 with SMTP id
 j23-20020a1709064b5700b0087874d0c173mr66664ejv.264.1675210464456; Tue, 31 Jan
 2023 16:14:24 -0800 (PST)
MIME-Version: 1.0
References: <Y9gOGZ20aSgsYtPP@kernel.org> <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org> <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com> <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com> <Y9mrQkfRFfCNuf+v@maniforge>
In-Reply-To: <Y9mrQkfRFfCNuf+v@maniforge>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 31 Jan 2023 16:14:13 -0800
Message-ID: <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     David Vernet <void@manifault.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
>
> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
> > On 31/01/2023 18:16, Alexei Starovoitov wrote:
> > > On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > >>
> > >> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >>>
> > >>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> > >>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> > >>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > >>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >>>>>>>> +++ b/dwarves.h
> > >>>>>>>> @@ -262,6 +262,7 @@ struct cu {
> > >>>>>>>>   uint8_t          has_addr_info:1;
> > >>>>>>>>   uint8_t          uses_global_strings:1;
> > >>>>>>>>   uint8_t          little_endian:1;
> > >>>>>>>> + uint8_t          nr_register_params;
> > >>>>>>>>   uint16_t         language;
> > >>>>>>>>   unsigned long    nr_inline_expansions;
> > >>>>>>>>   size_t           size_inline_expansions;
> > >>>>>>>
> > >>>>>
> > >>>>>> Thanks for this, never thought of cross-builds to be honest!
> > >>>>>
> > >>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
> > >>>>>> into one small thing on one system; turns out EM_RISCV isn't
> > >>>>>> defined if using a very old elf.h; below works around this
> > >>>>>> (dwarves otherwise builds fine on this system).
> > >>>>>
> > >>>>> Ok, will add it and will test with containers for older distros too.
> > >>>>
> > >>>> Its on the 'next' branch, so that it gets tested in the libbpf github
> > >>>> repo at:
> > >>>>
> > >>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> > >>>>
> > >>>> It failed yesterday and today due to problems with the installation of
> > >>>> llvm, probably tomorrow it'll be back working as I saw some
> > >>>> notifications floating by.
> > >>>>
> > >>>> I added the conditional EM_RISCV definition as well as removed the dup
> > >>>> iterator that Jiri noticed.
> > >>>>
> > >>>
> > >>> Thanks again Arnaldo! I've hit an issue with this series in
> > >>> BTF encoding of kfuncs; specifically we see some kfuncs missing
> > >>> from the BTF representation, and as a result:
> > >>>
> > >>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > >>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > >>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> > >>>
> > >>> Not sure why I didn't notice this previously.
> > >>>
> > >>> The problem is the DWARF - and therefore BTF - generated for a function like
> > >>>
> > >>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > >>> {
> > >>>         return -EOPNOTSUPP;
> > >>> }
> > >>>
> > >>> looks like this:
> > >>>
> > >>>    <8af83a2>   DW_AT_external    : 1
> > >>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> > >>>     <8af83a6>   DW_AT_decl_file   : 5
> > >>>     <8af83a7>   DW_AT_decl_line   : 737
> > >>>     <8af83a9>   DW_AT_decl_column : 5
> > >>>     <8af83aa>   DW_AT_prototyped  : 1
> > >>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
> > >>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> > >>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> > >>>     <8af83b3>   DW_AT_name        : ctx
> > >>>     <8af83b7>   DW_AT_decl_file   : 5
> > >>>     <8af83b8>   DW_AT_decl_line   : 737
> > >>>     <8af83ba>   DW_AT_decl_column : 51
> > >>>     <8af83bb>   DW_AT_type        : <0x8af421d>
> > >>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> > >>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> > >>>     <8af83c4>   DW_AT_decl_file   : 5
> > >>>     <8af83c5>   DW_AT_decl_line   : 737
> > >>>     <8af83c7>   DW_AT_decl_column : 61
> > >>>     <8af83c8>   DW_AT_type        : <0x8adc424>
> > >>>
> > >>> ...and because there are no further abstract origin references
> > >>> with location information either, we classify it as lacking
> > >>> locations for (some of) the parameters, and as a result
> > >>> we skip BTF encoding. We can work around that by doing this:
> > >>>
> > >>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > >>
> > >> replied in the other thread. This attr is broken and discouraged by gcc.
> > >>
> > >> For kfuncs where aregs are unused, please try __used and __may_unused
> > >> applied to arguments.
> > >> If that won't work, please add barrier_var(arg) to the body of kfunc
> > >> the way we do in selftests.
> > >
> > > There is also
> > > # define __visible __attribute__((__externally_visible__))
> > > that probably fits the best here.
> > >
> >
> > testing thus for seems to show that for x86_64, David's series
> > (using __used noinline in the BPF_KFUNC() wrapper and extended
> > to cover recently-arrived kfuncs like cpumask) is sufficient
> > to avoid resolve_btfids warnings.
>
> Nice. Alexei -- lmk how you want to proceed. I think using the
> __bpf_kfunc macro in the short term (with __used and noinline) is
> probably the least controversial way to unblock this, but am open to
> other suggestions.

Sounds good to me, but sounds like __used and noinline are not
enough to address the issues on aarch64?

> Yeah, I tend to think we should try to avoid using hidden / visible
> attributes given that (to my knowledge) they're really more meant for
> controlling whether a symbol is exported from a shared object rather
> than controlling what the compiler is doing when it creates the
> compilation unit. One could imagine that in an LTO build, the compiler
> would still optimize the function regardless of its visibility for that
> reason, though it's possible I don't have the full picture.

__visible is specifically done to prevent optimization of
functions that are externally visible. That should address LTO concerns.
We haven't seen LTO messing up anything. Just something to keep in mind.
