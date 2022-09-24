Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250645E8700
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 03:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiIXBaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 21:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiIXBaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 21:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5CA50DD
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 18:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D9C460B2C
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 01:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEB10C433D7;
        Sat, 24 Sep 2022 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663983015;
        bh=jY1Y5EXF5BIwtWytMffzn5MhkcOmRzBBJvvBHxNzfjI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PN2zG4ACTn5z8Qow8euyujVq4qKFKlS1lJ5g2w/ErjX3cORKC62zmutkfmhEcrfbY
         ezhbZsGdVa9ncX3AbIPb95EaeGdWboBFomZeWsAP7f2QFScdUEmMCOYoh9gXzs0sCI
         jDgKa4293Ivv9sqTbbozYv/+NneEN4O89OeHDt/AImMpm+9ktvOXgAorsvdBQxQ9eN
         5fVFoAnc7FoU2eUk5rmKwhlovHmSAV302LTFZU6fnlVTKSALcD6RRFvpX65B5c6EU9
         PkaJLWV4Px6wWGxOsbaSjaxS1r6Hz4wCFuJuAJI5L1o8Jp5eVDtC7q0vBLA008DtEb
         O62MP2oevPDLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A00BAE4D03A;
        Sat, 24 Sep 2022 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/5] veristat: further usability improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166398301565.30254.11053885434889690149.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Sep 2022 01:30:15 +0000
References: <20220923175913.3272430-1-andrii@kernel.org>
In-Reply-To: <20220923175913.3272430-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Sep 2022 10:59:08 -0700 you wrote:
> A small patch set adding few usability improvements and features making
> veristat a more convenient tool to be used for work on BPF verifier:
> 
>   - patch #2 speeds up and makes stats parsing from BPF verifier log more
>     robust;
> 
>   - patch #3 makes veristat less strict about input object files; veristat
>     will ignore non-BPF ELF files;
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/5] selftests/bpf: add sign-file to .gitignore
    https://git.kernel.org/bpf/bpf-next/c/067f4f291c20
  - [v2,bpf-next,2/5] selftests/bpf: make veristat's verifier log parsing faster and more robust
    https://git.kernel.org/bpf/bpf-next/c/c2488d70ceee
  - [v2,bpf-next,3/5] selftests/bpf: make veristat skip non-BPF and failing-to-open BPF objects
    https://git.kernel.org/bpf/bpf-next/c/518fee8bfaf2
  - [v2,bpf-next,4/5] selftests/bpf: emit processing progress and add quiet mode to veristat
    https://git.kernel.org/bpf/bpf-next/c/c511d009ceb8
  - [v2,bpf-next,5/5] selftests/bpf: allow to adjust BPF verifier log level in veristat
    https://git.kernel.org/bpf/bpf-next/c/e310efc5ddde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


