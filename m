Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DE6CB48E
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 05:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjC1DKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 23:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjC1DKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 23:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485322114
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 20:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2C456159C
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 03:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12395C433EF;
        Tue, 28 Mar 2023 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679973019;
        bh=vNnzBfTAmo0XCyCIk8N+NFwENg1oGxRKDOjlnPqIBr0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KrkK/TdGFe/jk0qBuOLEOp5FChCF+m3dt1X0kxpP35AolDB6R4oYFCW3MDiP8e3VL
         Jg1ZKP/XYZorgwvidNYT5LLKwNww6x4GIEtqLm19JmT1tW/IputBOA/6lucilXjvtl
         NrLD45Z20E3t1DXnS3y3LA+xisZY4cPnGJc6OikZKwdWs+KHdZLp5QjWAbP5x1Sn/Z
         ohmRI9tB6oiQTQ7u2QX7kVF24NUI0SMJLtBy35yqFJjpUpV4OR5b+whkRIQBIAvFDk
         FzLx9fkY1MHmGniAi1H5lnVznFtZkNqzkz7Z9cjn6ilBc9zLay4THtwSp3M+DXeOr9
         LupWAjhCoq+rQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E52C0E2A038;
        Tue, 28 Mar 2023 03:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Fix double-free when linker processes empty
 sections
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167997301892.22360.4778739036016937514.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Mar 2023 03:10:18 +0000
References: <20230328004738.381898-1-eddyz87@gmail.com>
In-Reply-To: <20230328004738.381898-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, james.hilliard1@gmail.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Mar 2023 03:47:36 +0300 you wrote:
> Fixes double-free error in linker.c:bpf_linker__free() caused by
> realloc(..., 0) call in linker.c:extend_sec() (such a call "frees"
> memory every second time :). The error is triggered when object files
> with empty sections of the same name are processed by linker.
> 
> - The first patch extends progs/linked_funcs[12].c to trigger the
>   error upon tests compilation;
> - The second patch contains detailed description of the error, fix and
>   appropriate attributions.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Test if bpftool linker handles empty sections
    (no matching commit)
  - [bpf-next,2/2] libbpf: Fix double-free when linker processes empty sections
    https://git.kernel.org/bpf/bpf-next/c/d08ab82f59d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


