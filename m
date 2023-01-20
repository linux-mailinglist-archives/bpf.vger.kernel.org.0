Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1022675ECB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjATUP6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 15:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjATUP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:15:57 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38A893CD
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:15:56 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 203so8111674yby.10
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SttUTJP8U9N4V2Fvv0U8GzKYs42n6qlFvW0XY0wmEY=;
        b=XVff+7MC8Y4ys60IARKh4+lxsPvx8Ea+jf/4OWWsxmnVI7JksTaug+ClqdJ0W/pQ9k
         TwKGrPgjWqW++UAIDn+P6gijEGrix6/p/TezpyZja7ZI0LGhSXjujCwcfGidQJMQMG2u
         aqCn4d105E+kFHpBpsqcZv85c4CtDyOR/dZAOWYJML5wDiql/yf5pVMo+jx5Y+E3qoUO
         E13YlOafPNfTaOOFSuH9xP2lsi/k/HKHBwZ6k4AVpY673vn32KxoREI0/CchwM5Qm39k
         fNIhkyOEYFfHWavuhAogCPO+tF2j99ZTELGUNzR57aOtsR8oI6ERu15av1QT/aQZ016m
         CcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SttUTJP8U9N4V2Fvv0U8GzKYs42n6qlFvW0XY0wmEY=;
        b=yg/QHfPVdV31PPvSjfMBrQZxi/oFArlKYRW7dnLPKoUnNSAfcLKEQXMb7zc6Gsc3vv
         xm54L/36/JaBAJYvsQCJYkpLlI3aoL1wq0gchIJ+/qw6d+3ABj2xUmyHQz9HtLU6SFxm
         CMqTAByhkLLnzR8kVrX8xfUivlPS9MNSwMfHnWMMPE4YIHoJKhmR3zDgl7j4gV1eoEsC
         j+SA1PEsLwpnWsiys4LTH4KQG4bXbCmsa9+EctpIuPMMQ7k1oV+ESGyf86MGNldTz69x
         FjeckYvsHqgbuPrGJlkU8vQbsedqBLbeIvMqChvpvvKjIsFI7CLabLCK98sK+EWhAw7M
         i5Xg==
X-Gm-Message-State: AFqh2krC1h5VUGmJeqIo0BkJUJHR3ZbAIH3ifZ1aHMw+DpWkhDFxe+3g
        nxC8xX/t4UVo2GRosBkwY1VaVb2gMDNX2zHygoQ=
X-Google-Smtp-Source: AMrXdXtO5ZMPDqEHX3UhEGijoKRIgKnvNSIp16Dw362TPRe2u5hiOoS1Fw5MlV8sMnJyCrNs48/mA3O68YmoywuQFE8=
X-Received: by 2002:a25:c00a:0:b0:733:4dbc:7215 with SMTP id
 c10-20020a25c00a000000b007334dbc7215mr1922970ybf.636.1674245756054; Fri, 20
 Jan 2023 12:15:56 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVbv2T7SExVULn6Bh1mB=VpmYGbH-4U63PKrHPyi6uULQ@mail.gmail.com>
 <b4182459-3fcb-e3d4-09ba-69039a0bdbca@meta.com>
In-Reply-To: <b4182459-3fcb-e3d4-09ba-69039a0bdbca@meta.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 20 Jan 2023 21:15:17 +0100
Message-ID: <CA+icZUWRk44KR_dh+vme5MZa3aF=fjCZ6HtN2hjC-bjhWr2TEw@mail.gmail.com>
Subject: Re: pahole: New version 1.25 release?
To:     Yonghong Song <yhs@meta.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
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

On Fri, Jan 20, 2023 at 8:15 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 1/20/23 9:40 AM, Sedat Dilek wrote:
> > Hi Arnaldo,
> >
> > I use CONFIG_DEBUG_INFO_BTF=y with LLVM-15.
> >
> > Darkly, I remember I needed some post-v1.24 fixes.
> >
> > Currently, I use:
> >
> > $ git describe
> > v1.24-26-gb72f5188856d
> >
> > commit b72f5188856d
> > "dwarves: Zero-initialize struct cu in cu__new() to prevent incorrect BTF types"
> >
> > Any plans to release a pahole version 1.25?
> >
> > Thanks.
> >
> > Best regards,
> > -Sedat-
> >
> > P.S.: I still carry this diff around (attached as diff as Gmail might
> > truncate the following lines):
> >
> > $ cd /path/to/pahole.git
> >
> > $ git diff dwarf_loader.c
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index 5a74035c5708..96ce5db4f5bc 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -2808,8 +2808,8 @@ static int __cus__load_debug_types(struct
> > conf_load *conf, Dwfl_Module *mod, Dwa
> >         return 0;
> > }
> >
> > -/* Match the define in linux:include/linux/elfnote.h */
> > -#define LINUX_ELFNOTE_BUILD_LTO                0x101
> > +/* Match the define in linux:include/linux/elfnote-lto.h */
> > +#define LINUX_ELFNOTE_LTO_INFO         0x101
> >
> > static bool cus__merging_cu(Dwarf *dw, Elf *elf)
> > {
> > @@ -2827,7 +2827,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
> >                         size_t name_off, desc_off, offset = 0;
> >                         GElf_Nhdr hdr;
> >                         while ((offset = gelf_getnote(data, offset,
> > &hdr, &name_off, &desc_off)) != 0) {
> > -                               if (hdr.n_type != LINUX_ELFNOTE_BUILD_LTO)
> > +                               if (hdr.n_type != LINUX_ELFNOTE_LTO_INFO)
> >                                         continue;
> >
> >                                 /* owner is Linux */
>
> Ya, LINUX_ELFNOTE_BUILD_LTO is initially proposed macro name but later
> the formal kernel patch used LINUX_ELFNOTE_LTO_INFO. Could you submit
> a pahole for this so it is consistent with kernel? Thanks!
>

Patch sent, see:

https://lore.kernel.org/all/20230120201203.10785-1-sedat.dilek@gmail.com/

-Sedat-

> >
> > $ cd /path/to/linux.git
> >
> > $ git describe
> > v6.2-rc4-77-gd368967cb103
> >
> > $ git grep LINUX_ELFNOTE_LTO_INFO include/linux/elfnote-lto.h
> > include/linux/elfnote-lto.h:#define LINUX_ELFNOTE_LTO_INFO      0x101
> > include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
> > ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
> > include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
> > ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
> > dileks@iniza:~/src/linux/git$ git describe
> > v6.2-rc4-195-gf609936e078d
> >
> > -EOT-
