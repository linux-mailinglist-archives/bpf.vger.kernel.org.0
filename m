Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E294AC522
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 17:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiBGQMs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 11:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiBGQKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 11:10:24 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D04C0401D9
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 08:10:23 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o10so11516183ilh.0
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 08:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDLxqZkHN4JXO4ICHalGFfw/1vRBaVSgYXaeX+CFcTM=;
        b=Y21ZN6VbwJb03yZy6NTQBiaMdLM8FU2A4AjzHy4w61kUBv83wNdXBu9ZYy6ahItTgH
         hWyuhy+E7Q6DAQYw7Ql7CoQzhKJaokXY6twqbNwDyu/vHu7RVX/6z4uPJVvx+YYEWYgv
         OP5bPOitU5l/LjyUDJqKgYbwitVkyi3U3HbTX8hb4Y31opGHOYrX95kU5eBFID517MJi
         5VfQOgTAM5pvRzxASsVWrP5LNpC7GvXxSacu96+5+Pi53NsiiLY5TVBLvqKQ46F662q7
         EXA0SdDZbdtZgGfHawtQTe1l7sAbO7d28Lq5xMN7ATlod1WaLUNe+1vcRf6/bHOJygkc
         bZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDLxqZkHN4JXO4ICHalGFfw/1vRBaVSgYXaeX+CFcTM=;
        b=ppiuPuYtjs0v5C9VZdxzG/+3/pS7X+77WRq+YU1585asCrcBHOoYoc2Z0inHNzQAJS
         XHWIXN1WQchNzfhtShPQCs16booZ0PPuK4UrdP/XncsVxvHSnh/wNZDwuterXYgrMptN
         3i2tNT2Rcpi/pCa1V4WC/0Ol8SDbmf5Lmrac2xT2DC6XdYBw0K9anqz2xnoXQ0JKHswa
         /irNQMmka+r3y12CNhkfsA9QuQPlzPqrGKsDaS0NP3jGjTgRtgycBbOz2o4K4jYZviap
         XYFa5rUmf0QwISvG3nBJagmk5ehdaOWUxESgDlYLAKH3+CLABVkGlbg9ZrpX1J+y28kn
         O4/g==
X-Gm-Message-State: AOAM5327G24S8gqrBTXhYaWRgj1bNpxFIOofBicO5iuQKMBcv2w92GtB
        QargVKYlzwfNWV+MM9BKbLDwSWgPlZjKYi6itdM=
X-Google-Smtp-Source: ABdhPJyPIrXXqpiy+Rmz4RTZwyWFcqT6JT8zP4AIFzSyWp48qSQp8mInHE4H6vk4Y0j1ZKPuBWtxojCdRoXAx0wSe6A=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr120133ilv.252.1644250222762;
 Mon, 07 Feb 2022 08:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20220204145018.1983773-1-iii@linux.ibm.com> <164409301110.21063.11730421603542210576.git-patchwork-notify@kernel.org>
In-Reply-To: <164409301110.21063.11730421603542210576.git-patchwork-notify@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 08:10:11 -0800
Message-ID: <CAEf4Bzb=YEGdDyB+8uFJ1OcSRVR11D9oqwJK=RYi9Jg+B2uhZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/11] libbpf: Fix accessing syscall arguments
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        bpf <bpf@vger.kernel.org>
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

On Sat, Feb 5, 2022 at 12:30 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Fri,  4 Feb 2022 15:50:07 +0100 you wrote:
> > libbpf now has macros to access syscall arguments in an
> > architecture-agnostic manner, but unfortunately they have a number of
> > issues on non-Intel arches, which this series aims to fix.
> >
> > v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
> > v1 -> v2:
> > * Put orig_gpr2 in place of args[1] on s390 (Vasily).
> > * Fix arm64, powerpc and riscv (Heiko).
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v3,01/11] arm64/bpf: Add orig_x0 to user_pt_regs
>     https://git.kernel.org/bpf/bpf-next/c/d473f4062165
>   - [bpf-next,v3,02/11] s390/bpf: Add orig_gpr2 to user_pt_regs
>     https://git.kernel.org/bpf/bpf-next/c/61f88e88f263
>   - [bpf-next,v3,03/11] selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
>     https://git.kernel.org/bpf/bpf-next/c/a936c141cbe4
>   - [bpf-next,v3,04/11] libbpf: Add __PT_PARM1_REG_SYSCALL macro
>     https://git.kernel.org/bpf/bpf-next/c/3a9d84aafb8c
>   - [bpf-next,v3,05/11] libbpf: Add PT_REGS_SYSCALL_REGS macro
>     https://git.kernel.org/bpf/bpf-next/c/b62a862d42f5
>   - [bpf-next,v3,06/11] selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
>     https://git.kernel.org/bpf/bpf-next/c/730809c15ac2
>   - [bpf-next,v3,07/11] libbpf: Fix accessing the first syscall argument on arm64
>     https://git.kernel.org/bpf/bpf-next/c/8b9b06ad4726
>   - [bpf-next,v3,08/11] libbpf: Fix accessing syscall arguments on powerpc
>     https://git.kernel.org/bpf/bpf-next/c/f5af16d0ae28
>   - [bpf-next,v3,09/11] libbpf: Fix accessing program counter on riscv
>     https://git.kernel.org/bpf/bpf-next/c/27870c91b5c7
>   - [bpf-next,v3,10/11] libbpf: Fix accessing syscall arguments on riscv
>     https://git.kernel.org/bpf/bpf-next/c/5860b82236c6
>   - [bpf-next,v3,11/11] libbpf: Fix accessing the first syscall argument on s390
>     https://git.kernel.org/bpf/bpf-next/c/088d6aafd5bb
>

I've backed out this patch set from bpf-next for now while we are
deciding the best way to deal with s390x and arm64 arches without
breaking UAPIs.

> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
