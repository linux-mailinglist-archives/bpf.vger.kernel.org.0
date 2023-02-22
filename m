Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1169EE2D
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 06:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBVFKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 00:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVFKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 00:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC04130E8D
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 21:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4A5610A2
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 05:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2157C4339B;
        Wed, 22 Feb 2023 05:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677042617;
        bh=qykS3jAu2mqixdVEIV7SamTA5wiqS2G9iytXEFIm4GY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RXEk/I263iGDz/o+JzJRinvugqabg9cztxT2vKFK9SKS74+fG+uyrUo3Ytso/Qyx5
         drHLyjwtwSBSJPsYpWuWMkawEl5jYDjmXcvEgspk2C9VdLG3sIyHczFxiwH7r6FrwU
         CUO6A0tPWMGQlKz/VXLXfX+rijxJnyI1XfJ1glz6hHYcaSsf0tFVuBjjZ4mmZdrsPf
         4Dtgp2wqm8sR13rogoKHqP6aFa0vUTWHz4o7BgiINRI5Vc04763G+7X5aaCnxKX8D8
         85bWxq3aiUKXLBDacWSF7uhlhGn3fmD8DRO9h1GPQbYsVfugSl4nBOYiG+8GgEYN74
         Aa64d6rTbnKeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6DD1C395DF;
        Wed, 22 Feb 2023 05:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] BPF: Include missing nospec.h to avoid build error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167704261767.377.7977555061947404632.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 05:10:17 +0000
References: <20230222025048.3677315-1-chenhuacai@loongson.cn>
In-Reply-To: <20230222025048.3677315-1-chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, lixuefeng@loongson.cn, yangtiezhu@loongson.cn,
        chenhuacai@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 22 Feb 2023 10:50:48 +0800 you wrote:
> Commit 74e19ef0ff8061ef55957c3a ("uaccess: Add speculation barrier to
> copy_from_user()") defines a default barrier_nospec() and removes the
> #ifdefs in kernel/bpf/core.c, but doesn't include nospec.h, which causes
> such a build error:
> 
>   CC      kernel/bpf/core.o
> kernel/bpf/core.c: In function ‘___bpf_prog_run’:
> kernel/bpf/core.c:1913:3: error: implicit declaration of function ‘barrier_nospec’; did you mean ‘barrier_data’? [-Werror=implicit-function-declaration]
>    barrier_nospec();
>    ^~~~~~~~~~~~~~
>    barrier_data
> cc1: some warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - BPF: Include missing nospec.h to avoid build error
    https://git.kernel.org/bpf/bpf/c/345d24a91c79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


