Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87E4A7FAD
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 08:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbiBCHUK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 02:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiBCHUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 02:20:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F06C061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 23:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135D1617C9
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 07:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76AD7C340EC;
        Thu,  3 Feb 2022 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643872809;
        bh=BIP1XK9S4GRCnxu/PXStr3bolCnlaCSHg2JnoAnfe0A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hGEgH9mx6Bn3LDcWUeHUkcg6zHy++YQUD52cfGPOFAGvpOm76+HKQsvutVwf4rIyV
         /31eyLNVGCA3vBETaFk8Em1+O7Ey9AGJS94I8f2yV+c0lroAqA9ghFEaKnJgXAH6iw
         4OP+KYZTVV4s5eyc1KyAnEa8ULV1NC56i/4p94+StJ3cz945sRhw6RL4011b/3MMEy
         sjuqt1BUoNxIj5JLRczPb88BUqFj2vy+Eo9QyuYQ/BCQLtgus8yVyeil7zaiSgbBZ1
         0jb23tpTqU8ZAQTOgUc4KmOfqZGTHDA8yuPMSKp5/CagTDTcgJiaLr2JCjjxRhsa6Y
         o4GxnhwQRrzSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64256E5D09D;
        Thu,  3 Feb 2022 07:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] migrate from bpf_prog_test_run{,_xattr}
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164387280940.12689.14794056106613700107.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Feb 2022 07:20:09 +0000
References: <20220202235423.1097270-1-delyank@fb.com>
In-Reply-To: <20220202235423.1097270-1-delyank@fb.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 2 Feb 2022 15:54:19 -0800 you wrote:
> Fairly straight-forward mechanical transformation from bpf_prog_test_run
> and bpf_prog_test_run_xattr to the bpf_prog_test_run_opts goodness.
> 
> I did a fair amount of drive-by CHECK/CHECK_ATTR cleanups as well, though
> certainly not everything possible. Primarily, I did not want to just change
> arguments to CHECK calls, though I had to do a bit more than that
> in some cases (overall, -119 CHECK calls and all CHECK_ATTR calls).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] selftests/bpf: migrate from bpf_prog_test_run
    https://git.kernel.org/bpf/bpf-next/c/04fcb5f9a104
  - [bpf-next,v3,2/4] selftests/bpf: migrate from bpf_prog_test_run_xattr
    https://git.kernel.org/bpf/bpf-next/c/393161837845
  - [bpf-next,v3,3/4] bpftool: migrate from bpf_prog_test_run_xattr
    https://git.kernel.org/bpf/bpf-next/c/9cce53138dd9
  - [bpf-next,v3,4/4] libbpf: Deprecate bpf_prog_test_run_xattr and bpf_prog_test_run
    https://git.kernel.org/bpf/bpf-next/c/3e1ab843d2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


