Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE45A6715
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiH3POu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiH3POt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 11:14:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A03DC6E;
        Tue, 30 Aug 2022 08:14:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy31so22425654ejc.6;
        Tue, 30 Aug 2022 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=w78Op6E5EuNFAMF7+a+1TxFn1y6Nd4iLcTWfFOX96PU=;
        b=eTc5Ctjs1SZnEra5J8DQ/TxN9mxmfp5xa7KGV2mnNn+qNIrYkPV4dgkoDqkqlO9AQQ
         FivWFG7isDsVPbORdYlQ6txbgXmHNwi7mW7oYfKU/J7obCR9aZRw64J8EKQ2Z/VABGRx
         IjULF8qtcoWK4NJnfl1I55iQTW5fCwc8e5VR8VpF2Md4eZ04dePO/OE4ki1d0htR9iD4
         y2H/pkma+XvaW+wr8hw9a36/zuBPCR4ReO0nkmIqE/DuibWiUIahJKozlfOOVr0VYGHL
         NcsVXi1UYavtsBZvk33NJXdpyf3v+PijSog5loYxM1C8su7s2ru1Lb8Yo2FzFvqPqQn8
         o8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w78Op6E5EuNFAMF7+a+1TxFn1y6Nd4iLcTWfFOX96PU=;
        b=HWoIa0eIB5EA4qYB8tDko6DPWfZMHLeHTu4nh4yAcchPOcqDwmYIDD13qXh4YcsPFE
         Z0quG7ChT2yKQLfUrjEwcxHoHtMw4yd/y3S+QUyFkoWwpm2zkyjOa4jOU0JnOAbGcvZC
         gq0VCIj9j8B998K+CVroFUK/PUi998ZZRnGAN7TfFDS2Nmm0EOuh3C1XDwB2ri+imEbF
         3Um9K0OdqGa96ostCw6871Fcz3ArAU2jqASBenjbuyb/SgDizu1UEO2L2NDPxuHYHdBo
         mbR02dXiF7xsSQykJIKnRcz0s0JlA47voCN3IMnPeM8WdNGg/Avt2IodDtsDefhZnmIA
         YPYg==
X-Gm-Message-State: ACgBeo2KRSFK039VI6s1gSRnHqPQe6Es6mfQ0dXZ2FC4/TxQi8Wcf671
        4/su/j3E5biYrln4ejTS0UMOcSxbuJA9E6Xn/bTq8ptl
X-Google-Smtp-Source: AA6agR4t9c5nkIlACYpay1xL/RNeq7p8AXGmXBKzS0c/vowoef+IRnnXGk3RtBHWIyP/KN2vAFzvJF7u+FzZacSAJow=
X-Received: by 2002:a17:907:2c74:b0:741:657a:89de with SMTP id
 ib20-20020a1709072c7400b00741657a89demr8890765ejc.58.1661872483740; Tue, 30
 Aug 2022 08:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Aug 2022 08:14:32 -0700
Message-ID: <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/7] Add support for generating BTF for all variables
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 11:54 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hello everyone,
>
> BTF offers some exciting new possibilities beyond its original intent;
> one of these is making the kernel more self-describing for debug tools.
> Kallsyms contains symbol table data, and ORC (for x86_64) contains
> information to help unwind stacks. Now, BTF can provide type information
> for functions and variables. Taken together, this data is enough to
> power the basic (read-only) functions of a postmortem or live debugger,
> without falling back on the heavier debugging information formats like
> DWARF. What's more, all of these data sources are contained within the
> kernel image itself, and are thus available on live systems and within
> crash dumps, without consulting any external debug information files.
>
> However, currently BTF generation emits information only for percpu
> variables. This patch series removes that limitation, allowing
> generating BTF for all variables, thus providing complete type
> information for debuggers.
>
> Of course, generating additional BTF means that more data must be stored
> in the kernel image, and that may not be okay for everyone. Thus, the
> new behavior must be explicitly enabled by a flag.
>
> Testing
> -------
>
> To verify this change and illustrate the additional space required, I
> built v5.19-rc7 on x86_defconfig, with the following additionally
> enabled:
>
> enable DEBUG_INFO_DWARF4
> enable BPF_SYSCALL
> enable DEBUG_INFO_BTF
>
> I then ran pahole to generate BTF from the built vmlinux in three
> configurations, and recorded the size of the BTF for each:
>
> 1) using the current master branch
>    size: 5505315 bytes
> 2) using this patched version, without enabling --encode_all_btf_vars
>    size: 5505315 bytes
> 3) using this patched version, with --encode_all_btf_vars enabled
>    size: 6811291 bytes
>
> A total increase of 1.25 MiB, or a 23.7% increase. This is definitely
> notable, but not unreasonable for many use cases such as desktop or
> server applications. I also verified that the data generated by cases 1
> and 2 are byte-for-byte identical: that is, there are no changes to the
> generated BTF unless --encode_all_btf_vars is enabled.
>
> I also verified that the output variables makes sense. I created an
> application which parses the output BTF and dumps the
> declarations (BTF_KIND_VAR and BTF_KIND_FUNC), and then diffed its
> output between configuration 2 and 3. I'm happy to provide a link to
> that diff (it's of course too big to include in the email).
>
> End-to-end test
> ---------------
>
> To show this is not just theory, I've created an end-to-end test which
> combines BTF generated via this patch series, along with a kernel patch
> necessary to expose the kallsyms data [1], and a branch of the drgn
> debugger[2] which implements kallsyms and BTF parsing. Core dumps
> generated on the resulting kernel can be loaded by the drgn debugger,
> and the it can read out variables from the dump with full type
> information without needing to consult a DWARF debuginfo file.
>
> Future Work
> -----------
>
> If this proves acceptable, I'd like to follow-up with a kernel patch to
> add a configuration option (default=n) for generating BTF with all
> variables, which distributions could choose to enable or not.
>
> There was previous discussion[3] about leveraging split BTF or building
> additional kernel modules to contain the extra variables. I believe with
> this patch series, it is possible to do that. However, I'd argue that
> simpler is better here: the advantage for using BTF is having it all
> available in the kernel/module image. Storing extra BTF on the
> filesystem would break that advantage, and at that point, you'd be
> better off using a debuginfo format like CTF, which is lightweight and
> expected to be found on the filesystem.

With all or nothing approach the distros would have a hard choice
to make whether to enable that kconfig, increase BTF and consume
extra memory without any obvious reason or just don't do it.
Majority probably is not going to enable it.
So the feature will become a single vendor only and with
inevitable bit-rot.

Whereas with split BTF and extra kernel module approach
we can enable BTF with all global vars by default.
The extra module will be shipped by all distros and tools
like bpftrace might start using it.

>
> [1]: https://lore.kernel.org/lkml/20220517000508.777145-3-stephen.s.brennan@oracle.com/T/
>      (The above series is already in the 6.0 RC's)
> [2]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
> [3]: https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/
>
> Stephen Brennan (7):
>   dutil: return ELF section name when looked up by index
>   btf_encoder: Rename percpu structures to variables
>   btf_encoder: cache all ELF section info
>   btf_encoder: make the variable array dynamic
>   btf_encoder: record ELF section for collected variables
>   btf_encoder: collect all variables
>   btf_encoder: allow encoding all variables
>
>  btf_encoder.c      | 196 +++++++++++++++++++++++++++------------------
>  btf_encoder.h      |   8 +-
>  dutil.c            |  10 ++-
>  dutil.h            |   2 +-
>  man-pages/pahole.1 |   6 +-
>  pahole.c           |  31 +++++--
>  6 files changed, 165 insertions(+), 88 deletions(-)
>
> --
> 2.34.1
>
