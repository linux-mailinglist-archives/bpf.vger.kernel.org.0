Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDADC6AC500
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCFPaw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 10:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCFPar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 10:30:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5C34C18;
        Mon,  6 Mar 2023 07:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0436B80EB7;
        Mon,  6 Mar 2023 15:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 699C2C4339B;
        Mon,  6 Mar 2023 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678116618;
        bh=HOpsDZsOcso8IDxE/fbpZ4usqtnB4a5y0458fKs59ck=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XVk76NkPuKDiBZK5DNN7hYQrU4ImKWmxzfugI1mLfxzeQL5fLeu6d3+j3QTzw4R8c
         xjC8scZ9d3FuVMNHBXhHh1SHR1VyxcO7icn+2gqDI2HU+Od05dC49+XfsMyyD6LEnX
         m9sQNKq2V7wO7lg3xaEVYpTXsvZJTedbEzPjNOZT+5c/v8CTNPQuOwXcIGA112Lzjp
         gSjHPOeTVkxRewdiMZ4PPku9PjAvr6i3TNzBurw9L9nHsb9LMCkbRCk8i7ku5Go8xJ
         sk3F6F4CWPoPPjlzS6vMQmL1awns+6badmK1897iycElBKMSRos/dgivUyJiiC6wCI
         QDsg5OAy+70/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36DC6E4D009;
        Mon,  6 Mar 2023 15:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Add /libsubcmd to .gitignore
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167811661821.1914.15417377597561138524.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Mar 2023 15:30:18 +0000
References: <tencent_F13D670D5D7AA9C4BD868D3220921AAC090A@qq.com>
In-Reply-To: <tencent_F13D670D5D7AA9C4BD868D3220921AAC090A@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat,  4 Mar 2023 23:17:04 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> After compiling the kernel:
> 
>     # bpf-next...bpf-next/master
>     ?? tools/bpf/resolve_btfids/libsubcmd/
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/resolve_btfids: Add /libsubcmd to .gitignore
    https://git.kernel.org/bpf/bpf-next/c/fd4cb29f2a3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


