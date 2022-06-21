Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70315528B8
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 02:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiFUAuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 20:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiFUAuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 20:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA96566
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 17:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C592B81646
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 00:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB53BC3411C;
        Tue, 21 Jun 2022 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655772613;
        bh=zGTMu10jYofspnu5csA5temWzxJ48mVIHTCogRsBHrk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BHsE18YmsTR2HLUaEl2zlQJ2dwgiRCaWr4Iy6wCbkfX4dJ0ROcPujsPY2RFFB5+Sk
         W9W/lNxHI0Z2FC11IShdrt0IoeObXGzmc1as2daIvFEiMSbrDuKEOEplE51mNCWUMH
         4F7AIHiELrcdPAkY76bupJLzofbm3KQEvjWodPiDdXXi4QEFH0D9E4BFHN/mbbHOQL
         /hz/8LahM7gXyKzr8OyQ/WFdTsvYHmSMs34v+OvhQOXptEBBon+qlPEZafVysA94ez
         d0k/iTDZcaw67O7fIwYw1ADIW9NhYS8tkEy0/bCnuIbroUXVjJYIdjG4MMNayCTLRG
         HAOAIam+dMq7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDC2DE73875;
        Tue, 21 Jun 2022 00:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/5] bpf_loop inlining
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165577261377.6414.17748447759450199467.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Jun 2022 00:50:13 +0000
References: <20220620235344.569325-1-eddyz87@gmail.com>
In-Reply-To: <20220620235344.569325-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 21 Jun 2022 02:53:39 +0300 you wrote:
> Hi Everyone,
> 
> This is the next iteration of the patch. It includes changes suggested
> by Song, Joanne and Alexei. Please find updated intro message and
> change log below.
> 
> This patch implements inlining of calls to bpf_loop helper function
> when bpf_loop's callback is statically known. E.g. the rewrite does
> the following transformation during BPF program processing:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/5] selftests/bpf: specify expected instructions in test_verifier tests
    https://git.kernel.org/bpf/bpf-next/c/933ff53191eb
  - [bpf-next,v8,2/5] selftests/bpf: allow BTF specs and func infos in test_verifier tests
    https://git.kernel.org/bpf/bpf-next/c/7a42008ca5c7
  - [bpf-next,v8,3/5] bpf: Inline calls to bpf_loop when callback is known
    https://git.kernel.org/bpf/bpf-next/c/1ade23711971
  - [bpf-next,v8,4/5] selftests/bpf: BPF test_verifier selftests for bpf_loop inlining
    https://git.kernel.org/bpf/bpf-next/c/f8acfdd04410
  - [bpf-next,v8,5/5] selftests/bpf: BPF test_prog selftests for bpf_loop inlining
    https://git.kernel.org/bpf/bpf-next/c/0e1bf9ed2000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


