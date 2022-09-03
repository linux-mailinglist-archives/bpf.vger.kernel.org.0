Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B35ABD99
	for <lists+bpf@lfdr.de>; Sat,  3 Sep 2022 09:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiICHM2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Sep 2022 03:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiICHM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Sep 2022 03:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F234B0CF
        for <bpf@vger.kernel.org>; Sat,  3 Sep 2022 00:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB2F60EEA
        for <bpf@vger.kernel.org>; Sat,  3 Sep 2022 07:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E498EC433D6
        for <bpf@vger.kernel.org>; Sat,  3 Sep 2022 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662189144;
        bh=Kn2yc6CZQiAttDW9UyZZ39zS4Btyq23PdHxhiou4+y0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elP9R+TmpGolZkm7MWI6ZLV8zmL6Ya2zSA54mzrO8/Jk/8yjZEy75N5/JPlXkYPBQ
         qUoTqLEQtEEMUEwOZCz0S8igX5Sf/2TrR5YhG0tsDxCvhOyKTmK4BrI0icuD21ioGF
         Hlu3KoAnJMp8BC3aVeZ5ABcli4a1lg7nEYBzr0CY8/Bj4OYQMHGkeojuxSpw4DR1hK
         sNnlfG63No8aE5df1uddycMVY/ppLjw2O28aSrkXMrEOPE7cei52Iyg1JOEJHVPnxk
         CP9mZoiLK/pHDjBl+2QAV1/KI31fZQ+kf166cVMgzuC2vO3lQ65YgvVp3PkUJnaOp2
         sx7bN0A7OaJcg==
Received: by mail-vs1-f52.google.com with SMTP id i12so4097401vsr.10
        for <bpf@vger.kernel.org>; Sat, 03 Sep 2022 00:12:24 -0700 (PDT)
X-Gm-Message-State: ACgBeo0VIGYcQOXKDZdAp9dAZuKhKILIDyTPwxJSYvrgY03z2lD3+wgs
        xN5Jr534oREnPwKQOhDzsgoYe0j5r7FmlgFZP0g=
X-Google-Smtp-Source: AA6agR51C/qOFX3VjAto+WXDA9tjQR4pxUxhyqemSBEGEodQm1lsY2CxLq3boFfRbj7cUEPoRx5vrxokdlPpQg8IBHE=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr12129636vsu.43.1662189143886; Sat, 03
 Sep 2022 00:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn> <2219694c-5e4c-2b81-ee39-367467ac0733@iogearbox.net>
In-Reply-To: <2219694c-5e4c-2b81-ee39-367467ac0733@iogearbox.net>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 3 Sep 2022 15:12:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5FK0NvPgzNGNqz9edUQ44uQbOgsLSaqfoqq007ZuLzKg@mail.gmail.com>
Message-ID: <CAAhV-H5FK0NvPgzNGNqz9edUQ44uQbOgsLSaqfoqq007ZuLzKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] Add BPF JIT support for LoongArch
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Daniel,

On Fri, Sep 2, 2022 at 9:34 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/1/22 4:27 AM, Tiezhu Yang wrote:
> > The basic support for LoongArch has been merged into the upstream Linux
> > kernel since 5.19-rc1 on June 5, 2022, this patch series adds BPF JIT
> > support for LoongArch.
> >
> > Here is the LoongArch documention:
> > https://www.kernel.org/doc/html/latest/loongarch/index.html
> >
> > With this patch series, the test cases in lib/test_bpf.ko have passed
> > on LoongArch.
> >
> >    # echo 1 > /proc/sys/net/core/bpf_jit_enable
> >    # modprobe test_bpf
> >    # dmesg | grep Summary
> >    test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
> >    test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> >    test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> >
> > It seems that this patch series can not be applied cleanly to bpf-next
> > which is not synced to v6.0-rc3.
>
> For bpf-next tree this doesn't apply cleanly. Huacai, probably easier if you
> take it in. Otherwise this needs rebase (and your Ack as arch maintainer), but
> then there'll be merge conflict later anyway.
This series can be cleanly applied on loongarch-next. So if this
series is good to you, please give an Acked-by, and I will apply them
to loongarch-next, thanks.

Huacai

>
> [...]
> Applying: LoongArch: Move {signed,unsigned}_imm_check() to inst.h
> Applying: LoongArch: Add some instruction opcodes and formats
> error: patch failed: arch/loongarch/include/asm/inst.h:18
> error: arch/loongarch/include/asm/inst.h: patch does not apply
> Patch failed at 0002 LoongArch: Add some instruction opcodes and formats
> [...]
>
> Thanks,
> Daniel
>
> > v3:
> >    -- Remove CONFIG_TEST_BPF in loongson3_defconfig
> >
> > v2:
> >    -- Rebased series on v6.0-rc3
> >    -- Make build_epilogue() static
> >    -- Use alsl.d, bstrpick.d, [ld/st]ptr.[w/d] to save some instructions
> >    -- Replace move_imm32() and move_imm64() with move_imm() and optimize it
> >    -- Add code comments to explain the considerations of conditional jump
> >    https://lore.kernel.org/bpf/1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn/
> >
> > v1:
> >    -- Rebased series on v6.0-rc1
> >    -- Move {signed,unsigned}_imm_check() to inst.h
> >    -- Define the imm field as "unsigned int" in the instruction format
> >    -- Use DEF_EMIT_*_FORMAT to define the same kind of instructions
> >    -- Use "stack_adjust += sizeof(long) * 8" in build_prologue()
> >    https://lore.kernel.org/bpf/1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn/
> >
> > RFC:
> >    https://lore.kernel.org/bpf/1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn/
> >
> > Tiezhu Yang (4):
> >    LoongArch: Move {signed,unsigned}_imm_check() to inst.h
> >    LoongArch: Add some instruction opcodes and formats
> >    LoongArch: Add BPF JIT support
> >    LoongArch: Enable BPF_JIT in default config
> >
> >   arch/loongarch/Kbuild                      |    1 +
> >   arch/loongarch/Kconfig                     |    1 +
> >   arch/loongarch/configs/loongson3_defconfig |    1 +
> >   arch/loongarch/include/asm/inst.h          |  383 ++++++++-
> >   arch/loongarch/kernel/module.c             |   10 -
> >   arch/loongarch/net/Makefile                |    7 +
> >   arch/loongarch/net/bpf_jit.c               | 1160 ++++++++++++++++++++++++++++
> >   arch/loongarch/net/bpf_jit.h               |  282 +++++++
> >   8 files changed, 1830 insertions(+), 15 deletions(-)
> >   create mode 100644 arch/loongarch/net/Makefile
> >   create mode 100644 arch/loongarch/net/bpf_jit.c
> >   create mode 100644 arch/loongarch/net/bpf_jit.h
> >
>
