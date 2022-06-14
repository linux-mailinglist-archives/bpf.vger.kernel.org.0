Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46DA54BE3E
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiFNXUQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFNXUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F319F326C0
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90922618CA
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 23:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD7A7C3411F;
        Tue, 14 Jun 2022 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655248813;
        bh=C1D2fMP+rYXMzlLYlD1d6B14nfJZHBPAfKHEI3zKwHU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nx/M5xeYr0mrl1I9aEBoEWSz2AWjFghfcjdLOuiCpiGAGprILlK86Wp8Dqt92CglJ
         5AYRChCEnjnuyNAqWP/8LKm735LyGwCh2cRKjyN7I9E91lFmrQcBZCPZ0oFUwgIpOE
         JOG4ctTJ3y4KEhtk2DxPr2i5sIXo9bN5dqz+EBmZweInXAC7FScQE9N3LAcc93oLMS
         mZr4lBonFcaInxyMVKwN7AFW/KBHzwPVrrL5i275AHq65UZODKHiHZIA/eyD4nB45P
         v4cAtptZHLiZl83M+YPuyBxMQesbzcGucRVXC0xNXZvbmKWGHgfuzr7juJLtxfIPG5
         2ooEGoKy3sutA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2E23FD99FF;
        Tue, 14 Jun 2022 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Avoid skipping certain subtests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165524881379.32165.10337534534143714007.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 23:20:13 +0000
References: <20220614055526.628299-1-yhs@fb.com>
In-Reply-To: <20220614055526.628299-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Jun 2022 22:55:26 -0700 you wrote:
> Commit 704c91e59fe0 ('selftests/bpf: Test "bpftool gen min_core_btf"')
> added a test test_core_btfgen to test core relocation with btf
> generated with 'bpftool gen min_core_btf'. Currently,
> among 76 subtests, 25 are skipped.
> 
>   ...
>   #46/69   core_reloc_btfgen/enumval:OK
>   #46/70   core_reloc_btfgen/enumval___diff:OK
>   #46/71   core_reloc_btfgen/enumval___val3_missing:OK
>   #46/72   core_reloc_btfgen/enumval___err_missing:SKIP
>   #46/73   core_reloc_btfgen/enum64val:OK
>   #46/74   core_reloc_btfgen/enum64val___diff:OK
>   #46/75   core_reloc_btfgen/enum64val___val3_missing:OK
>   #46/76   core_reloc_btfgen/enum64val___err_missing:SKIP
>   ...
>   #46      core_reloc_btfgen:SKIP
>   Summary: 1/51 PASSED, 25 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Avoid skipping certain subtests
    https://git.kernel.org/bpf/bpf-next/c/3831cd1f9ff6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


