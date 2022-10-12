Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7455FC062
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 08:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJLGAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 02:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJLGAv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 02:00:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB12178AE;
        Tue, 11 Oct 2022 23:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 091E6B81977;
        Wed, 12 Oct 2022 06:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5DD1C433D6;
        Wed, 12 Oct 2022 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665554415;
        bh=2v9Ep06R0/4dxQ/Rx5DCQswoxl0HeMVWry6onwhLxpc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TPCBlwOUHUynEvsmnM8Y+QVSMlKcDyP1L0u6bvLD6BGZ+yEkyKXAcTv5tkFX8hwBm
         BIjywUXmdmzhGrv/hGGqq1SIAQa2PsKXxCLkTZhn9L8Iu8RCTHGBaBn7Puw8xnw7r4
         4jCtFmchQDHr6g/aobK7zR5TNPoxxZsod6T1tilDoWYywfSbgprxUxQ7zt+PTMtzgR
         zQzLAvmLn6o0Oq5GSxZLC4Meve/NPKq1sHJJhO2LiAzf8Fzy7amrESL28tjaT6B7bg
         v/sv2KwN+BQdOAClAtI0ILnBRKMyl8Ex6pD8Lp8ef1N/Ti1cXNi0AxVqqKe2dEBWl1
         DyDXWXrItBavg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 961B8E50D94;
        Wed, 12 Oct 2022 06:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Alphabetize DENYLISTs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166555441561.26034.2414138003607989249.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Oct 2022 06:00:15 +0000
References: <20221011165255.774014-1-void@manifault.com>
In-Reply-To: <20221011165255.774014-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        sdf@google.com, song@kernel.org, yhs@fb.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 11 Oct 2022 11:52:55 -0500 you wrote:
> The DENYLIST and DENYLIST.s390x files are used to specify testcases
> which should not be run on CI. Currently, testcases are appended to the
> end of these files as needed. This can make it a pain to resolve merge
> conflicts. This patch alphabetizes the DENYLIST files to ease this
> burden.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Alphabetize DENYLISTs
    https://git.kernel.org/bpf/bpf-next/c/d31ada3b5111

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


