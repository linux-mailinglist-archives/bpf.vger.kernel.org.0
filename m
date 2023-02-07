Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A868E328
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 22:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBGVvE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 16:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBGVuv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 16:50:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA199EF4
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 13:50:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3548FB81AD0
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 21:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA631C433D2;
        Tue,  7 Feb 2023 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675806617;
        bh=UwTtZ7MZarnOsAM6+r8ScvT3rU282hvu4yK6wZ6ZkVc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vpin4+4jkEvINr7YvhRku8VeC80UQZUYv8vkYl2eKEkVQm2NGbYxL3f6s1Vjusm0e
         602pyRYRReOSfb9fyDudvgykM2GHvCF6LsWcaugN5I4LLAuAScL+sOuIUI/zshcqcL
         5H/Q0qvbtAVKQoASKRBARX8SWbeYUM6BDRlAE8WZoJmLFsCPU9ymkLwioC7kjjpvQt
         M+aaNawA0sDLZQaWYLZ9YDWfVoEEKAvJLIhvhfSzZsaoCnZw4TUlEqfmAxVLGx4PWa
         i5xS4KId/Clkca0FvWHo6R95Wl0gawjXzZm+VsPUZFOeMiYix8sEWSJDzXJlmxbmet
         FcejQNpy5+EDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF02EE55EFD;
        Tue,  7 Feb 2023 21:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Compile resolve_btfids as host
 program
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167580661771.11027.13109053225318741637.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Feb 2023 21:50:17 +0000
References: <20230202112839.1131892-1-jolsa@kernel.org>
In-Reply-To: <20230202112839.1131892-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        irogers@google.com, nathan@kernel.org, bpf@vger.kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com
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

On Thu,  2 Feb 2023 12:28:39 +0100 you wrote:
> Making resolve_btfids to be compiled as host program so
> we can avoid cross compile issues as reported by Nathan.
> 
> Also we no longer need HOST_OVERRIDES for BINARY target,
> just for 'prepare' targets.
> 
> Cc: Ian Rogers <irogers@google.com>
> Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/resolve_btfids: Compile resolve_btfids as host program
    https://git.kernel.org/bpf/bpf-next/c/56a2df7615fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


