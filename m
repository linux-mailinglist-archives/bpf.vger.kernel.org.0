Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EAD628984
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiKNTkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNTkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:40:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9037D639A
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8D461411
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 706BCC433B5;
        Mon, 14 Nov 2022 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454815;
        bh=/0kXGe2lLpBuTwOtz+d0kY6Z1WVmWOUyEVIoEzQ6Cvo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F4OKnjMv5RjLQXlxOx3Mk6ALvGazd7+qpv2wYNgVY1pA/Ak6du3Izp49dNSIOVHnz
         fx8Mn0b6iJypuzFxnUGZMOteSQ2oGNqAVcJ8K+YzuEfUYPNSAy5b6ZbYzbhp5XzOHy
         Zf3MES1uPhk9SbjWX0p1zvtvLI2gZLO7qW9NRj6VgAcJ+bm6BgcyC41UxWzy4BykLg
         nEDYj9Tp7L/aG14Owoy5Li6ROmkq/NILrCAHBc/3egQ/iZ3QdlsHpcxERG/IZwB8bv
         vPyDF3C78Ji+eHvFtqx3NLW8MSgkYYTfFvmSvXGLyKo3hawtdmIT5OU51pznAtYhve
         G8YngULcdBbQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54A25E270C2;
        Mon, 14 Nov 2022 19:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: Use correct return pointer in attach_raw_tp
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166845481534.27664.14380648484812924104.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Nov 2022 19:40:15 +0000
References: <20221114145257.882322-1-jolsa@kernel.org>
In-Reply-To: <20221114145257.882322-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 14 Nov 2022 15:52:57 +0100 you wrote:
> We need to pass '*link' to final libbpf_get_error,
> because that one holds the return value, not 'link'.
> 
> Fixes: 4fa5bcfe07f7 ("libbpf: Allow BPF program auto-attach handlers to bail out")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] libbpf: Use correct return pointer in attach_raw_tp
    https://git.kernel.org/bpf/bpf/c/5fd2a60aecf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


