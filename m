Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C536D60D259
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJYRUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 13:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYRUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 13:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99984645F6
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 10:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A69561A36
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 17:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC33C433B5;
        Tue, 25 Oct 2022 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666718418;
        bh=Jrz7L4mVAoyzoCdJ2Bqumc0X7b0UeivLt4adE5jzpJg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M/Mh/UIRv4UbqUGGuChLUvHyp/dEFRaIsMjNL8DrORJD/8IR7+hiIx2CI7yQM60DQ
         kHLw/1VyGGr/Ykx8jpSa+FrVr4awFQrqFIqHpm97z5tmCu9QnPwWcUnGC6YbbkT2ts
         l6ZOORdKWPI2gglZRMZZxJPjbnNi/IHFYjhcJu+ozYMjtKb6V2za01wkEgHVdb/qAy
         VQgyAWxVvasWh7BLR/wq6pbWNQaxb7BsADlO1hUyFnKi9WVrNnDW+eUtpLaGLV5OgG
         bCidx1FTga/jfNID8R5YCkx/B2vE5eAgp17xbNMsP/ygQq/tqME5UEoSl1+vyvOzXk
         kyOVIo0LEJXAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7231AE270DD;
        Tue, 25 Oct 2022 17:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166671841846.6150.14342298484805840284.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Oct 2022 17:20:18 +0000
References: <20221025150329.97371-1-quentin@isovalent.com>
In-Reply-To: <20221025150329.97371-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        niklas.soderlund@corigine.com, simon.horman@corigine.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 25 Oct 2022 16:03:21 +0100 you wrote:
> To disassemble instructions for JIT-ed programs, bpftool has relied on the
> libbfd library. This has been problematic in the past: libbfd's interface
> is not meant to be stable and has changed several times, hence the
> detection of the two related features from the Makefile
> (disassembler-four-args and disassembler-init-styled). When it comes to
> shipping bpftool, this has also caused issues with several distribution
> maintainers unwilling to support the feature (for example, Debian's page
> for binutils-dev, libbfd's package, says: "Note that building Debian
> packages which depend on the shared libbfd is Not Allowed.").
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/8] bpftool: Define _GNU_SOURCE only once
    https://git.kernel.org/bpf/bpf-next/c/b3d84af7cdfc
  - [bpf-next,v4,2/8] bpftool: Remove asserts from JIT disassembler
    https://git.kernel.org/bpf/bpf-next/c/55b4de58d0e2
  - [bpf-next,v4,3/8] bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
    https://git.kernel.org/bpf/bpf-next/c/108326d6fa6c
  - [bpf-next,v4,4/8] bpftool: Group libbfd defs in Makefile, only pass them if we use libbfd
    https://git.kernel.org/bpf/bpf-next/c/2ea4d86a5093
  - [bpf-next,v4,5/8] bpftool: Refactor disassembler for JIT-ed programs
    https://git.kernel.org/bpf/bpf-next/c/e1947c750ffe
  - [bpf-next,v4,6/8] bpftool: Add LLVM as default library for disassembling JIT-ed programs
    https://git.kernel.org/bpf/bpf-next/c/eb9d1acf634b
  - [bpf-next,v4,7/8] bpftool: Support setting alternative arch for JIT disasm with LLVM
    https://git.kernel.org/bpf/bpf-next/c/ce4f66086235
  - [bpf-next,v4,8/8] bpftool: Add llvm feature to "bpftool version"
    https://git.kernel.org/bpf/bpf-next/c/08b8191ba7f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


