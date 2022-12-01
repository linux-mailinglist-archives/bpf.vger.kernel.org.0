Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74963E716
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiLABaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiLABaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:30:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23249801F
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6449961976
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 01:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86E82C433B5;
        Thu,  1 Dec 2022 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669858216;
        bh=UC1JNVp9rojVdp24jwAFRUlTqOlgs/R0ILTFO5U9Wag=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WKEY4ggZpIefbU4Jdo1Tek67/tlcGWlW09igGh8nshmN1dy/qBZIgGZW43jNUiqlx
         A3KplZjgOotUb66W76WX9GPO8v2IsLQ7AWBfw43b4Q8uQ7zbiwGjuE/0HlkD1pDnjD
         v7QxnX9d5mOdL2nyo4WZzKXodFSJV+oztzemj8W5ur5TbVdG6fUay4O6jJVwevqxqY
         aZSZXqVWdDlXphryHNbFGFKIryuK/h8fbY1z4x6gs0jXjiONqvg8wXyg5tujZ3Q5FL
         CUeNCWUymDIMVO6HeO0Mn8eFS9uNGzXpC+d5RUxsGZRiAAUfYUxIN3H0PORokjuIZ9
         oQVhpzjZ4zZrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F006E21EFC;
        Thu,  1 Dec 2022 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix a compilation failure with clang lto build
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166985821645.1204.887509424985027882.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Dec 2022 01:30:16 +0000
References: <20221130052147.1591625-1-yhs@fb.com>
In-Reply-To: <20221130052147.1591625-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 29 Nov 2022 21:21:47 -0800 you wrote:
> When building the kernel with clang lto (CONFIG_LTO_CLANG_FULL=y), the
> following compilation error will appear:
> 
>   $ make LLVM=1 LLVM_IAS=1 -j
>   ...
>   ld.lld: error: ld-temp.o <inline asm>:26889:1: symbol 'cgroup_storage_map_btf_ids' is already defined
>   cgroup_storage_map_btf_ids:;
>   ^
>   make[1]: *** [/.../bpf-next/scripts/Makefile.vmlinux_o:61: vmlinux.o] Error 1
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix a compilation failure with clang lto build
    https://git.kernel.org/bpf/bpf-next/c/3144bfa5078e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


