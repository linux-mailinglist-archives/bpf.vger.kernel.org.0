Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F3614BE8
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKANkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKANkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 09:40:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA9410579;
        Tue,  1 Nov 2022 06:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0ACCB81D8F;
        Tue,  1 Nov 2022 13:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80098C433D7;
        Tue,  1 Nov 2022 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667310015;
        bh=W7bLHmXjYrutSxRh3BKcNfArwB+U8z8j/jgA2RkevIo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RX67JP+VqncVqi+PKtU03Whkkt0NeSfVNWl2UusezFb8FlALzGOZJFuWd1VOb4ZYf
         ZqUVr68FuyM2XO9jUGrhj66xl6Kkg3LkZlj4Ii4narrelLUDpDN+uZ6Vexm0UYfdB6
         Y+AKHZdMq2L6jnLvKjPyAFL06FFPC4ZdEgbpcdoLoXsdeXSK0jYiOjEOBSsB0jbgoc
         cNTpbwjPYoosnojrtrqsz28KymQonvuiKzPaJz5A/LpNygSZuEQ2aU2XpI7eZcJ2fM
         pkM6lmkH+1cGXMHy5kQ9EnTagoEo2JYTaP/kHZBq+HhFP+G3YBOwiSwlpa2/FblVat
         ysIG1tS5tA3nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62A57E270F9;
        Tue,  1 Nov 2022 13:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf/verifier: Use kmalloc_size_roundup() to
 match ksize() usage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166731001539.11065.9599565244134793508.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Nov 2022 13:40:15 +0000
References: <20221029024444.gonna.633-kees@kernel.org>
In-Reply-To: <20221029024444.gonna.633-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 28 Oct 2022 19:54:29 -0700 you wrote:
> v2:
> - split up patch into logical changes
> - simplify copy_array, which can use ksize() directly
> v1: https://lore.kernel.org/all/20221018090550.never.834-kees@kernel.org/
> 
> Hi,
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf/verifier: Fix potential memory leak in array reallocation
    https://git.kernel.org/bpf/bpf/c/42378a9ca553
  - [bpf-next,v2,2/3] bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage
    (no matching commit)
  - [bpf-next,v2,3/3] bpf/verifier: Take advantage of full allocation sizes
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


