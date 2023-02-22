Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A763869EEBF
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 07:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBVG1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 01:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBVG1H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 01:27:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6C34C1A
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 22:26:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so25355160edd.13
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 22:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALsjcHXIgpn49++9eK6lAxQQylZmgPcE6W49SaELvOY=;
        b=aWIQsNP+WCCauxK9zPCxJ5A9pOdw1X2RQtFd/Ukf4UG+hr2KSmuw4nIW4yfFktDL3I
         Vuw8NyoMer6DPxSMDa4x088/lCsh3NeUlnsX7SkfXugACZgMLAneCsMNO/WkKqYLCt8N
         VTwr+m5rSf5ES+TGH6+O0lOTqAXjQcL1otgD5OJbFEq96XEynaaZAYXrJyt0tbUGi0vA
         Xzm+sOryh3i6ZDrTzd1mL2G2qQxlpl4ZFp9Pt8DFt7tdUmowBCxzmB2InMR49MhEaGUZ
         vffngQAlZVA+hsb8VSibTO44iCvNjYRcoIsUFDhIHOpxCQTuSKRvlW+pQFvg6KRcORvR
         8vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALsjcHXIgpn49++9eK6lAxQQylZmgPcE6W49SaELvOY=;
        b=UVuoYSVhMBn1XWu0H1mVwBWSVez10hdaYl3x60IrfveOBlBYfexFpEfm4IMgrN7yCy
         JpwDNW0Ib9ZFyzLj4+mpvZw7hkbWYBFs9Df45tO5e/Y2XmJ1zOie/PT76kouNrFZJkiI
         6d84Nx8RWJr75f2mWCe9AJoH2B/Dbyxt5T81WQAwZEWKXBzVcqyG9QqxV/DOkvbxgc1/
         o3c39Su2D5ypJi4i7qAjq2oJOx3GiPGf0lGzF0rIf/meNrfRpEfiQhAHhHRgCfOlcYNw
         evA1/VjKtGC7fO95PI61fobgQtKZNdktYPdslnI3A1D+z7XU9Xo+/xQIUYqIP9FOnphx
         e9mA==
X-Gm-Message-State: AO0yUKVOM8fJnKiyGtiE7xtEa+Sfo9e1hRIymwZdV2uPP6TGIvoLmcpf
        X3Qzw8w0hxw1R/C9nRHCNgY95bkAp2TVGJbuzXX4Yiole+7Y0Q==
X-Google-Smtp-Source: AK7set8lcgq1gG5QE7ws3N2sHnTWAKKXs218+7dhmLMAv3anORzWXMEjigDeoohJfOghLCaYoVANe2SkJUGgPLVpa4k=
X-Received: by 2002:a17:906:2e98:b0:8a6:5720:9104 with SMTP id
 o24-20020a1709062e9800b008a657209104mr7205389eji.1.1677047215101; Tue, 21 Feb
 2023 22:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20230222025048.3677315-1-chenhuacai@loongson.cn> <167704261767.377.7977555061947404632.git-patchwork-notify@kernel.org>
In-Reply-To: <167704261767.377.7977555061947404632.git-patchwork-notify@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 22 Feb 2023 14:26:43 +0800
Message-ID: <CAAhV-H4TkQ7Nf2PekGgpykzdoLtVbd7b_5UtiWMFOEZtbLDf4g@mail.gmail.com>
Subject: Re: [PATCH] BPF: Include missing nospec.h to avoid build error
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, lixuefeng@loongson.cn, yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oh, I'm sorry but the modified commit message seems broken.

Huacai

On Wed, Feb 22, 2023 at 1:10 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
>
> On Wed, 22 Feb 2023 10:50:48 +0800 you wrote:
> > Commit 74e19ef0ff8061ef55957c3a ("uaccess: Add speculation barrier to
> > copy_from_user()") defines a default barrier_nospec() and removes the
> > #ifdefs in kernel/bpf/core.c, but doesn't include nospec.h, which cause=
s
> > such a build error:
> >
> >   CC      kernel/bpf/core.o
> > kernel/bpf/core.c: In function =E2=80=98___bpf_prog_run=E2=80=99:
> > kernel/bpf/core.c:1913:3: error: implicit declaration of function =E2=
=80=98barrier_nospec=E2=80=99; did you mean =E2=80=98barrier_data=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]
> >    barrier_nospec();
> >    ^~~~~~~~~~~~~~
> >    barrier_data
> > cc1: some warnings being treated as errors
> >
> > [...]
>
> Here is the summary with links:
>   - BPF: Include missing nospec.h to avoid build error
>     https://git.kernel.org/bpf/bpf/c/345d24a91c79
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
