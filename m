Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E34A5095
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 21:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbiAaUxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 15:53:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45986 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347931AbiAaUxn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 15:53:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 527A8614F0
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 20:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2FBEC340ED;
        Mon, 31 Jan 2022 20:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643662422;
        bh=IAuUO+FqYs6JeEalMVdtQu/KDTer9XjU1cI4bXangLQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t6DizV+OSrUW2PR3/z0FKVAwDD+ROHCsjbAXKg/WgYvPhD6JCP3gWVte4oqrLUBUe
         U+OYjU2zGh0V92xl+MSgAV8yR0+X6evxQCdFH9gCANm5e8ZgNSxorisHBNOV/nc2Ax
         uvdAsqFWqIB6f3CRAi8M96B/Tqagzv6zwYjK2xQ2B1+twleR0J5L/BQLhWB/35+D5h
         f6PEaPbvrhRYwMYKKpp6W3mx1syXEOyijQ8oOFLo0s5AsSJOAVkQI0L//sJC5UyDmN
         jzUkm6CaSvc4stvfVPARbS/8sXbLqQjQMCGTveJnqmMcjW1KvJmGPw4RH1DqAu7e7o
         SxCdmhn4ubSww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98824E5D098;
        Mon, 31 Jan 2022 20:53:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: make bpf_copy_from_user_task() gpl only
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164366242261.17453.10021693037089390544.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jan 2022 20:53:42 +0000
References: <20220128170906.21154-1-Kenta.Tada@sony.com>
In-Reply-To: <20220128170906.21154-1-Kenta.Tada@sony.com>
To:     Kenta Tada <Kenta.Tada@sony.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kennyyu@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 29 Jan 2022 02:09:06 +0900 you wrote:
> access_process_vm() is exported by EXPORT_SYMBOL_GPL().
> 
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: make bpf_copy_from_user_task() gpl only
    https://git.kernel.org/bpf/bpf-next/c/0407a65f356e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


