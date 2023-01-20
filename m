Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D4675BE6
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjATRqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 12:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjATRqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 12:46:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161CE518D1
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 09:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA863B829B2
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 17:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E56C433EF;
        Fri, 20 Jan 2023 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674236788;
        bh=axk4Q29thU+/2qOWoJvqnkruSHK8wbJBV2o6Qc9n6nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7zTUSMp5DLb5y7gvaWzY6j3Hu8wrRIfMxCbD8/r8KoWEZa8qMCnaUsx93HGztcGQ
         gt6c/ErGOhZ0AcyFnz59XM+/fcrWhXm7NhfHBcj0z4ztJ6DbqLjmXsAqb7npn49kn6
         GLUXc6e0/D6oTCiXT2b0DkjMR5AxJXgxl+OKW86sF/Ckx0Hqph1WzYL9mMITYSAkr8
         1CAlivJ6Aam/CYBrACQvxvHyTGKiVxvMZEXEE/hIRTf9Gte0muCNoMVAl7rRF4j6Gq
         H7xwwMY3MXw1Fvi+hTiU53DR4a2ko/1HarDDvi9tkE+ZB/yjM96kZkSufrwLRRKtTo
         4xy5knsWtW40A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E824405BE; Fri, 20 Jan 2023 14:46:25 -0300 (-03)
Date:   Fri, 20 Jan 2023 14:46:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
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
Subject: Re: pahole: New version 1.25 release?
Message-ID: <Y8rTcfB78f0G7C1j@kernel.org>
References: <CA+icZUVbv2T7SExVULn6Bh1mB=VpmYGbH-4U63PKrHPyi6uULQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVbv2T7SExVULn6Bh1mB=VpmYGbH-4U63PKrHPyi6uULQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jan 20, 2023 at 06:40:38PM +0100, Sedat Dilek escreveu:
> Hi Arnaldo,
> 
> I use CONFIG_DEBUG_INFO_BTF=y with LLVM-15.
> 
> Darkly, I remember I needed some post-v1.24 fixes.
> 
> Currently, I use:
> 
> $ git describe
> v1.24-26-gb72f5188856d
> 
> commit b72f5188856d
> "dwarves: Zero-initialize struct cu in cu__new() to prevent incorrect BTF types"
> 
> Any plans to release a pahole version 1.25?

Probably next week, I just have to differentiate a file with split dwarf
to remove a slight hack I have right now.

- Arnaldo
 
> Thanks.
> 
> Best regards,
> -Sedat-
> 
> P.S.: I still carry this diff around (attached as diff as Gmail might
> truncate the following lines):

Ok, that is in the same function I have to differentiate if the file
makes reference to another DWARF file (the split dwarf, .dwz thing),
I'll check this patch, thanks!
 
> $ cd /path/to/pahole.git
> 
> $ git diff dwarf_loader.c
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 5a74035c5708..96ce5db4f5bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2808,8 +2808,8 @@ static int __cus__load_debug_types(struct
> conf_load *conf, Dwfl_Module *mod, Dwa
>        return 0;
> }
> 
> -/* Match the define in linux:include/linux/elfnote.h */
> -#define LINUX_ELFNOTE_BUILD_LTO                0x101
> +/* Match the define in linux:include/linux/elfnote-lto.h */
> +#define LINUX_ELFNOTE_LTO_INFO         0x101
> 
> static bool cus__merging_cu(Dwarf *dw, Elf *elf)
> {
> @@ -2827,7 +2827,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
>                        size_t name_off, desc_off, offset = 0;
>                        GElf_Nhdr hdr;
>                        while ((offset = gelf_getnote(data, offset,
> &hdr, &name_off, &desc_off)) != 0) {
> -                               if (hdr.n_type != LINUX_ELFNOTE_BUILD_LTO)
> +                               if (hdr.n_type != LINUX_ELFNOTE_LTO_INFO)
>                                        continue;
> 
>                                /* owner is Linux */
> 
> $ cd /path/to/linux.git
> 
> $ git describe
> v6.2-rc4-77-gd368967cb103
> 
> $ git grep LINUX_ELFNOTE_LTO_INFO include/linux/elfnote-lto.h
> include/linux/elfnote-lto.h:#define LINUX_ELFNOTE_LTO_INFO      0x101
> include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
> ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
> include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
> ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
> dileks@iniza:~/src/linux/git$ git describe
> v6.2-rc4-195-gf609936e078d
> 
> -EOT-

> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 5a74035c5708..96ce5db4f5bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2808,8 +2808,8 @@ static int __cus__load_debug_types(struct conf_load *conf, Dwfl_Module *mod, Dwa
>  	return 0;
>  }
>  
> -/* Match the define in linux:include/linux/elfnote.h */
> -#define LINUX_ELFNOTE_BUILD_LTO		0x101
> +/* Match the define in linux:include/linux/elfnote-lto.h */
> +#define LINUX_ELFNOTE_LTO_INFO		0x101
>  
>  static bool cus__merging_cu(Dwarf *dw, Elf *elf)
>  {
> @@ -2827,7 +2827,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
>  			size_t name_off, desc_off, offset = 0;
>  			GElf_Nhdr hdr;
>  			while ((offset = gelf_getnote(data, offset, &hdr, &name_off, &desc_off)) != 0) {
> -				if (hdr.n_type != LINUX_ELFNOTE_BUILD_LTO)
> +				if (hdr.n_type != LINUX_ELFNOTE_LTO_INFO)
>  					continue;
>  
>  				/* owner is Linux */


-- 

- Arnaldo
