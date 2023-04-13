Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8902E6E0D8E
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDMMkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDMMkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 08:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5113393D6
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 05:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDBE363E0D
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 12:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EBA3C433EF;
        Thu, 13 Apr 2023 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681389618;
        bh=YXsSydUEoMb55Ox5WxLVBMAVjUtZVJ3DCNOPJCGckTo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lix0vklBIVE8KmQhb9629RRg1q3OEoV0nTgIjFoK/jQ81y5SBgBEG/gdFe2r+NGCL
         1OIayGSuCJSqTYfsloi/ZowRo9d48n3x9gUsiCFE+C0o29B8wTzSWm5u4xjFTgNcse
         ZXxG7nCRRNgG/cU/gUGnfEKgUmsgAjbqQ56Gyl7tmrMOoezHPdhYZjBDKquDyiIJia
         wSDd2NmrGG4QliCCxt7Z2EsMPfKRTr7vrecJzQenpyPXqDStwNQynK7uJD/MWTSDcm
         GnKUOUERVGWmxMCz7rr4vvio9/x/tLlnGWAzMyYba10NLBF4DVobnKEtSVfpBbqWNv
         i9ztRcpPA6ung==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09B38E4508F;
        Thu, 13 Apr 2023 12:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: remove stand-along test_verifier_log
 test binary
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168138961803.16516.15583743620232393223.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 12:40:18 +0000
References: <20230412170655.1866831-1-andrii@kernel.org>
In-Reply-To: <20230412170655.1866831-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 12 Apr 2023 10:06:55 -0700 you wrote:
> test_prog's prog_tests/verifier_log.c is superseding test_verifier_log
> stand-alone test. It cover same checks and adds more, and is also
> integrated into test_progs test runner.
> 
> Just remove test_verifier_log.c.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: remove stand-along test_verifier_log test binary
    https://git.kernel.org/bpf/bpf-next/c/ee5059a64dba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


