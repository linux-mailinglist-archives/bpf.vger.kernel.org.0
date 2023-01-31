Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC868342A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 18:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjAaRoP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 12:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjAaRoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 12:44:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A91204A
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 09:43:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ml19so20370073ejb.0
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mCOEiPgIXaP2swWMCIMKVEmHHcyLNRl+YinfmKL7XDM=;
        b=O3OGF+vKyiNlZRpzKY7ZO/5jwnReTj2Qc+xaHKD8LDtmsVxfrHjaJfNZeZGuODEnUp
         M3SR5ojwYoK31tYnVxV37DeDuKl24/tEEFWu5ntmkucmYX0rSzZKePjfHGNO3rhPe44O
         rgaIQwSX9U1v8MORkOH/jTjKMqRnMx89gF8G2xhYFVCAp+ln3kFScKe/PKCE6Rh/IRj2
         jCsyfaIth1WDBi3C/2xyMuYg4/Pzh5+5hk+AeuhVMsZanpRyVWGtoH5jkmeZTWyttxEF
         i7EgJG5QqL7WdoKueAqet1h9vfAkgZNIeIZH9iTuBh17BVR6s/0n3xFSre65NrHBKG3c
         6Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCOEiPgIXaP2swWMCIMKVEmHHcyLNRl+YinfmKL7XDM=;
        b=LK75n0jWh/GCihtvpdKXk6GzriO0pFGVm84Qb7xC+0oQw3pwJAbKvfHkBt35EEdjlc
         oFdtS5Fk4CkCVPaSEL1dyaCDhScmoj1+UOn7FgynOjAq7iMFu/RBIMo4hg0ay6ZtNVc+
         ek2r6/dc5PChRs/Xx8eKitpiOew1vBsDn08A0LikOKHZW29qmqiZueSTC0VQRodqxQE1
         pigP+ax7WfBd+IGp1w6E5HX8T8t8pbnfjpSlzceV8O6cIaqtmWFJoJMAvSUEP5R01q+b
         ZM0w8p5kS1aTsMgtMGeDVQi39q5KKMjh+FEYyO8J9FqjvskV8a/4HfeI18qF7xRv+gxA
         2Aww==
X-Gm-Message-State: AO0yUKV6pZlxjZ0cQP25r6noAzc+iHcOPDeALnFl4OospdL6KD5TnPmd
        Vyk1Q6OVvJbo66Q93/UJSRkvo1KNnt6r33qjSCk=
X-Google-Smtp-Source: AK7set8RPldpQ97Hlb2zI04IFf49CcBx56JP+DZcpXvBs/33F9+6twBgIwTOOhctz1P6giZQrg4O8y1Wi6juj4srNAA=
X-Received: by 2002:a17:906:b2d7:b0:883:8fdc:fbba with SMTP id
 cf23-20020a170906b2d700b008838fdcfbbamr2690419ejb.215.1675187036044; Tue, 31
 Jan 2023 09:43:56 -0800 (PST)
MIME-Version: 1.0
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org> <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org> <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org> <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
In-Reply-To: <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 31 Jan 2023 09:43:44 -0800
Message-ID: <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> >>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> >>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>> +++ b/dwarves.h
> >>>>> @@ -262,6 +262,7 @@ struct cu {
> >>>>>   uint8_t          has_addr_info:1;
> >>>>>   uint8_t          uses_global_strings:1;
> >>>>>   uint8_t          little_endian:1;
> >>>>> + uint8_t          nr_register_params;
> >>>>>   uint16_t         language;
> >>>>>   unsigned long    nr_inline_expansions;
> >>>>>   size_t           size_inline_expansions;
> >>>>
> >>
> >>> Thanks for this, never thought of cross-builds to be honest!
> >>
> >>> Tested just now on x86_64 and aarch64 at my end, just ran
> >>> into one small thing on one system; turns out EM_RISCV isn't
> >>> defined if using a very old elf.h; below works around this
> >>> (dwarves otherwise builds fine on this system).
> >>
> >> Ok, will add it and will test with containers for older distros too.
> >
> > Its on the 'next' branch, so that it gets tested in the libbpf github
> > repo at:
> >
> > https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> >
> > It failed yesterday and today due to problems with the installation of
> > llvm, probably tomorrow it'll be back working as I saw some
> > notifications floating by.
> >
> > I added the conditional EM_RISCV definition as well as removed the dup
> > iterator that Jiri noticed.
> >
>
> Thanks again Arnaldo! I've hit an issue with this series in
> BTF encoding of kfuncs; specifically we see some kfuncs missing
> from the BTF representation, and as a result:
>
> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>
> Not sure why I didn't notice this previously.
>
> The problem is the DWARF - and therefore BTF - generated for a function like
>
> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> {
>         return -EOPNOTSUPP;
> }
>
> looks like this:
>
>    <8af83a2>   DW_AT_external    : 1
>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
>     <8af83a6>   DW_AT_decl_file   : 5
>     <8af83a7>   DW_AT_decl_line   : 737
>     <8af83a9>   DW_AT_decl_column : 5
>     <8af83aa>   DW_AT_prototyped  : 1
>     <8af83aa>   DW_AT_type        : <0x8ad8547>
>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>     <8af83b3>   DW_AT_name        : ctx
>     <8af83b7>   DW_AT_decl_file   : 5
>     <8af83b8>   DW_AT_decl_line   : 737
>     <8af83ba>   DW_AT_decl_column : 51
>     <8af83bb>   DW_AT_type        : <0x8af421d>
>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
>     <8af83c4>   DW_AT_decl_file   : 5
>     <8af83c5>   DW_AT_decl_line   : 737
>     <8af83c7>   DW_AT_decl_column : 61
>     <8af83c8>   DW_AT_type        : <0x8adc424>
>
> ...and because there are no further abstract origin references
> with location information either, we classify it as lacking
> locations for (some of) the parameters, and as a result
> we skip BTF encoding. We can work around that by doing this:
>
> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)

replied in the other thread. This attr is broken and discouraged by gcc.

For kfuncs where aregs are unused, please try __used and __may_unused
applied to arguments.
If that won't work, please add barrier_var(arg) to the body of kfunc
the way we do in selftests.

> {
>         return -EOPNOTSUPP;
> }
>
> Should we #define some kind of "kfunc" prefix equivalent to the
> above to handle these cases in include/linux/bpf.h perhaps?
> If that makes sense, I'll send bpf-next patches to cover the
> set of kfuncs.
>
> The other thing we might want to do is bump the libbpf version
> for dwarves 1.25, what do you think? I've tested with libbpf 1.1
> and aside from the above issue all looks good (there's a few dedup
> improvements that this version will give us). I can send a patch for
> the libbpf update if that makes sense.
