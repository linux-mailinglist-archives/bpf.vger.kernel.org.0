Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1662DFDA
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKQPaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 10:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiKQPaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 10:30:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B4DFFF
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 07:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27082CE1E55
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 619F0C433C1;
        Thu, 17 Nov 2022 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668699017;
        bh=B8yiHKXMBuUNiVsCHYhK67iKUcuh8K9tIyCJLdF3lT4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W+5GmUrBpoFHlWgaD72K1V6gEhSVKkyCghO2hyO65ANxVdfmT6E+A+rEA3w5tNOmz
         MPUcI7WVZPRR8DdcBxi68XBK9c4S2dApWyOY1UO67itlJB9M+F1dYaXb+84IGKn1dA
         xowxDj9ekb3B2ucYUVgSDKis58zBj6+4KSc1QGq3ykXmSHvywEwl+jbIh0tVsxfSJC
         Kke5ejgCiUF/2w4EegvhTQwuHOEQAcaDNFk6hburIOgIzJMXexVI4AsELShdqwgvBx
         c93guHF4r1gX4YGehTc6XD0sTCd2pnvD3RQ+6hWEy8etuMj7HbzDRXUwpstGSQposO
         HvSaOjfF3RzVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40B36E270F6;
        Thu, 17 Nov 2022 15:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf/docs: Include blank lines between bullet points
 in bpf_devel_QA.rst
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166869901724.18310.7893818294368402542.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Nov 2022 15:30:17 +0000
References: <20221116174358.2744613-1-deso@posteo.net>
In-Reply-To: <20221116174358.2744613-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com,
        akiyks@gmail.com
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

On Wed, 16 Nov 2022 17:43:58 +0000 you wrote:
> Commit 26a9b433cf08 ("bpf/docs: Document how to run CI without patch
> submission") caused a warning to be generated when compiling the
> documentation:
>  > bpf_devel_QA.rst:55: WARNING: Unexpected indentation.
>  > bpf_devel_QA.rst:56: WARNING: Block quote ends without a blank line
> 
> This change fixes the problem by inserting the required blank lines.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf/docs: Include blank lines between bullet points in bpf_devel_QA.rst
    https://git.kernel.org/bpf/bpf-next/c/383f1a8df8fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


