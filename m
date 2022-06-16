Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D854EA76
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiFPUAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 16:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFPUAB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 16:00:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1C5A159
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 13:00:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so4699628ejb.11
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXKlLlg0dFIiUQrnVgKsAhtJyK6tgvF9RjrXl4uU6UU=;
        b=EqMrDKVMp3AGNMNgge94YciXGvC8Vr4VHsKQSl8Byxa8+rg+C07ZZo9TxCe/6wUgNc
         XiWVQgGuLEUvSr31VuGgLcJsRnsKGuQwe/0O4vS4+g9QFQWm5NlbENKiDpTQ4SOS1xau
         aVTbCsVpKJ52yrdFfgeyRMtrwEEZpWrpCYPY82O76jJmsrPOO+OBYJA8YgqCzSJ3D4sb
         1dcfpOnRc7kcXGnc5SpwGI8tEhKpczwDsSYlWcb3Lpc75VCM9RCXH+/5cv9lVc4jAdp9
         F2KnUu7nPrOEHyDfMUWYVo+9u5tj3pxifW2c2qkaA1lJ3CEVhndCX1MVtyTDUFJWzXr9
         Fcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXKlLlg0dFIiUQrnVgKsAhtJyK6tgvF9RjrXl4uU6UU=;
        b=TAVn26V1UqoEuPymKSRiUBuMB3P5BXrSkcowibWHQVDc+Bc3kHMhsSzxXgnTbvRrXZ
         07seM7DWk79yVANf3gnP8qnhWySMkKazeJDo3iEO2x+/EXoGgW8ycDCCxy3Ux78vY2fA
         CdplfM3O4YjHPYknvB9IDU54GY9+vMtX/r+/gQGPCyT/iqZmu2TAE+wUH2ZHffisYBKm
         rdR3u5Eu89lD9u9RoxCjosIKKfsdCR/SuM23jzZYYpSdy/GqDfzWiySIUz+w2f2u1T04
         FLfUz0bD8wNlJr7tRgq1xkWZAfS8pZsQJqNVHAi/x+8+o8ablualAIgI3J/5u3CY0Ok7
         StIQ==
X-Gm-Message-State: AJIora9Yth+/tBt+3gnOUCCtwY5eExdRhVRd680lkYEAcZjHx3T1nEKU
        NjuGf7FAAmwjfi/tPI/KQJPVQAQWLIWl2taAErklJQzy
X-Google-Smtp-Source: AGRyM1sGnGI4JBiZnmF7I/bl0bJDLixLz8Uxg0jGk9KSoLvF+B4/J4TdkeFoEWjsXibb4YAHYaHu93u4pX15MN9mmJg=
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id
 dd6-20020a1709069b8600b006fed37fb29dmr6007141ejc.327.1655409598960; Thu, 16
 Jun 2022 12:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220616055543.3285835-1-andrii@kernel.org>
In-Reply-To: <20220616055543.3285835-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Jun 2022 12:59:47 -0700
Message-ID: <CAADnVQ+OXAk8=FoyHP0pt5o_9sB7Qj=nm7xLZJYpLEczMt8i2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix internal USDT address translation
 logic for shared libraries
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jun 15, 2022 at 10:56 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Perform the same virtual address to file offset translation that libbpf
> is doing for executable ELF binaries also for shared libraries.
> Currently libbpf is making a simplifying and sometimes wrong assumption
> that for shared libraries relative virtual addresses inside ELF are
> always equal to file offsets.
>
> Unfortunately, this is not always the case with LLVM's lld linker, which
> now by default generates quite more complicated ELF segments layout.
> E.g., for liburandom_read.so from selftests/bpf, here's an excerpt from
> readelf output listing ELF segments (a.k.a. program headers):
>
>   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
>   PHDR           0x000040 0x0000000000000040 0x0000000000000040 0x0001f8 0x0001f8 R   0x8
>   LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x0005e4 0x0005e4 R   0x1000
>   LOAD           0x0005f0 0x00000000000015f0 0x00000000000015f0 0x000160 0x000160 R E 0x1000
>   LOAD           0x000750 0x0000000000002750 0x0000000000002750 0x000210 0x000210 RW  0x1000
>   LOAD           0x000960 0x0000000000003960 0x0000000000003960 0x000028 0x000029 RW  0x1000
>
> Compare that to what is generated by GNU ld (or LLVM lld's with extra
> -znoseparate-code argument which disables this cleverness in the name of
> file size reduction):
>
>   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
>   LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x000550 0x000550 R   0x1000
>   LOAD           0x001000 0x0000000000001000 0x0000000000001000 0x000131 0x000131 R E 0x1000
>   LOAD           0x002000 0x0000000000002000 0x0000000000002000 0x0000ac 0x0000ac R   0x1000
>   LOAD           0x002dc0 0x0000000000003dc0 0x0000000000003dc0 0x000262 0x000268 RW  0x1000
>
> You can see from the first example above that for executable (Flg == "R E")
> PT_LOAD segment (LOAD #2), Offset doesn't match VirtAddr columns.
> And it does in the second case (GNU ld output).
>
> This is important because all the addresses, including USDT specs,
> operate in a virtual address space, while kernel is expecting file
> offsets when performing uprobe attach. So such mismatches have to be
> properly taken care of and compensated by libbpf, which is what this
> patch is fixing.
>
> Also patch clarifies few function and variable names, as well as updates
> comments to reflect this important distinction (virtaddr vs file offset)
> and to ephasize that shared libraries are not all that different from
> executables in this regard.
>
> This patch also changes selftests/bpf Makefile to force urand_read and
> liburand_read.so to be built with Clang and LLVM's lld (and explicitly
> request this ELF file size optimization through -znoseparate-code linker
> parameter) to validate libbpf logic and ensure regressions don't happen
> in the future. I've bundled these selftests changes together with libbpf
> changes to keep the above description tied with both libbpf and
> selftests changes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/usdt.c                 | 123 ++++++++++++++-------------

What should be the Fixes tag here?
Back to the beginning of this usdt.c file?
