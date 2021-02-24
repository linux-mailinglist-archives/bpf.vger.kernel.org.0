Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129A03241BE
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhBXQIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 11:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236139AbhBXPuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 10:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 480CC64EDB;
        Wed, 24 Feb 2021 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614181807;
        bh=hF8y1Q0WdYmCbljW0PLTqueblBj4/bdI2PclHVaY09A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fAGEJP2ZhauS5CqTmarNuw9LFM9k7rxn91ijV19bAYe983NuB2ET5KyGSNaJqpviy
         kLP0bgS8afonSrT7ehl4UmTW47PN2O5uNMIcIH58Mm4Ro3XDaS+hgPSnOlZRUE8fJD
         HIMPchp3i9R80FfGjgbV25/TUC2gUxl1XvNYQzj/vcIxd9NEVi6NcC3HKoI8cqlUu6
         I4sQHHjM/chF4TUTvWGt4MEuk1sTdz+slMeidHpwpJdoSUERbu33kRFCK5WFQracf6
         8ojXlD7EHSxpvmvoXzeWw0O3RXCIx0YjhBwRWDDE4i3qwV4JIkDmiTlBKdrSn1p/2b
         H+4hHorKQKMgQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 374B8609C5;
        Wed, 24 Feb 2021 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix a compiler warning in global func test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161418180722.1820.14305388274490973593.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Feb 2021 15:50:07 +0000
References: <20210223082211.302596-1-me@ubique.spb.ru>
In-Reply-To: <20210223082211.302596-1-me@ubique.spb.ru>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, rdna@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Tue, 23 Feb 2021 12:22:11 +0400 you wrote:
> Add an explicit 'const void *' cast to pass program ctx pointer type into
> a global function that expects pointer to structure.
> 
> warning: incompatible pointer types
> passing 'struct __sk_buff *' to parameter of type 'const struct S *'
> [-Wincompatible-pointer-types]
>         return foo(skb);
>                    ^~~
> progs/test_global_func11.c:10:36: note: passing argument to parameter 's' here
> __noinline int foo(const struct S *s)
>                                    ^
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix a compiler warning in global func test
    https://git.kernel.org/bpf/bpf/c/c41d81bfbb45

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


