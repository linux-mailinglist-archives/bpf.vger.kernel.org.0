Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE06834F9
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjAaSQe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaSQd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:16:33 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BCE10AAE
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:16:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m2so43725199ejb.8
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z18+IsLF+M26rBHIu/9mDJ6qtIKRYUf+5BL2Vy/Y2DA=;
        b=dVyeu+fuHINJwf1n7gNFj4zysWcKQluYuC71Tt2Po22CP9LEsxtAPxDDNhjEwap3GG
         2YQDeOXxBuiWVWTyfonNiW8ZTIlDAnTi/kAwlK1cB5vmeoXsgBzSkf8QlBbYxxakhJO7
         N4JG7h3F3rTb07uH4OOj/+DFhgKujq21AUNxDavyTCytZkrc9SAgpf09SzxVd0PYX0oZ
         7U1cGMMj4K4S6zHtn1mQH5+YXhziwiZ79bxLPTibtSkdpDiHLQXCJZXpKSs0tP4s48av
         eTWbETM75r9/lN01n5CNHYCmIeqkKVLW7nW0VbxpM/d6dNAr9NOJLxeeufBjnsbdFVkJ
         1JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z18+IsLF+M26rBHIu/9mDJ6qtIKRYUf+5BL2Vy/Y2DA=;
        b=bXpDEO3/Tj3WsHK8CUgcFQ7cfgxrwmp46C1+hNl2oF+sW078X88/I9SP0cQP6abWpQ
         ND6hHzojrEv6nVoPncqvPT11hTFAc+hTWVe947EZSjho9c6BAfTeBuNu/RR8Scb3E8nw
         48mPRyXMVyQ/YuJzHCz7VVbVpX6i5aiKH1qHSezFEQlL7VcPHY6o3/oPK2vW1eHdrOgu
         Kt/ovk/0ejYy5jZfMbPRTaFicgnwX3yMo0ijpVxEKbG/CIMR5WYOCGgR2Ae4qxmQHf2P
         cx+rgOc7GE4/eHW/ataFLwmhteAxiHXBNgFaCgQ9rCrmphveLi7n/wUA1NU7/O7Hm4E1
         gnuA==
X-Gm-Message-State: AO0yUKVlpXb9sXbPyHEZutyD2wcREORloBRVpxmQZRXxHY1duiiedcJK
        +El9kjA9SAZVJyONr0Q/hXwRbepMiyYHNK+dhKA=
X-Google-Smtp-Source: AK7set/QVp9J+b2ThTob8VFpv4iJpZaM2daqMjfacUi0lkvKx5g0v2Vhgh1Ju3w62H+GUgu8rzRBWyC17dX+MID6w8E=
X-Received: by 2002:a17:906:8514:b0:878:786e:8c39 with SMTP id
 i20-20020a170906851400b00878786e8c39mr5505364ejx.105.1675188990274; Tue, 31
 Jan 2023 10:16:30 -0800 (PST)
MIME-Version: 1.0
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org> <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org> <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com> <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
In-Reply-To: <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 31 Jan 2023 10:16:18 -0800
Message-ID: <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> > >>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > >>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >>>>> +++ b/dwarves.h
> > >>>>> @@ -262,6 +262,7 @@ struct cu {
> > >>>>>   uint8_t          has_addr_info:1;
> > >>>>>   uint8_t          uses_global_strings:1;
> > >>>>>   uint8_t          little_endian:1;
> > >>>>> + uint8_t          nr_register_params;
> > >>>>>   uint16_t         language;
> > >>>>>   unsigned long    nr_inline_expansions;
> > >>>>>   size_t           size_inline_expansions;
> > >>>>
> > >>
> > >>> Thanks for this, never thought of cross-builds to be honest!
> > >>
> > >>> Tested just now on x86_64 and aarch64 at my end, just ran
> > >>> into one small thing on one system; turns out EM_RISCV isn't
> > >>> defined if using a very old elf.h; below works around this
> > >>> (dwarves otherwise builds fine on this system).
> > >>
> > >> Ok, will add it and will test with containers for older distros too.
> > >
> > > Its on the 'next' branch, so that it gets tested in the libbpf github
> > > repo at:
> > >
> > > https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> > >
> > > It failed yesterday and today due to problems with the installation of
> > > llvm, probably tomorrow it'll be back working as I saw some
> > > notifications floating by.
> > >
> > > I added the conditional EM_RISCV definition as well as removed the dup
> > > iterator that Jiri noticed.
> > >
> >
> > Thanks again Arnaldo! I've hit an issue with this series in
> > BTF encoding of kfuncs; specifically we see some kfuncs missing
> > from the BTF representation, and as a result:
> >
> > WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> >
> > Not sure why I didn't notice this previously.
> >
> > The problem is the DWARF - and therefore BTF - generated for a function like
> >
> > int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > {
> >         return -EOPNOTSUPP;
> > }
> >
> > looks like this:
> >
> >    <8af83a2>   DW_AT_external    : 1
> >     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> >     <8af83a6>   DW_AT_decl_file   : 5
> >     <8af83a7>   DW_AT_decl_line   : 737
> >     <8af83a9>   DW_AT_decl_column : 5
> >     <8af83aa>   DW_AT_prototyped  : 1
> >     <8af83aa>   DW_AT_type        : <0x8ad8547>
> >     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> >  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> >     <8af83b3>   DW_AT_name        : ctx
> >     <8af83b7>   DW_AT_decl_file   : 5
> >     <8af83b8>   DW_AT_decl_line   : 737
> >     <8af83ba>   DW_AT_decl_column : 51
> >     <8af83bb>   DW_AT_type        : <0x8af421d>
> >  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> >     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> >     <8af83c4>   DW_AT_decl_file   : 5
> >     <8af83c5>   DW_AT_decl_line   : 737
> >     <8af83c7>   DW_AT_decl_column : 61
> >     <8af83c8>   DW_AT_type        : <0x8adc424>
> >
> > ...and because there are no further abstract origin references
> > with location information either, we classify it as lacking
> > locations for (some of) the parameters, and as a result
> > we skip BTF encoding. We can work around that by doing this:
> >
> > __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>
> replied in the other thread. This attr is broken and discouraged by gcc.
>
> For kfuncs where aregs are unused, please try __used and __may_unused
> applied to arguments.
> If that won't work, please add barrier_var(arg) to the body of kfunc
> the way we do in selftests.

There is also
# define __visible __attribute__((__externally_visible__))
that probably fits the best here.
