Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC2C6E0D8D
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 14:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDMMkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 08:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDMMkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 08:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA4593D1
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 05:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC67E63E07
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 12:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16562C4339B;
        Thu, 13 Apr 2023 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681389618;
        bh=Q19ttfOh42dMDZ0fuxhXbRiA+HGoWiabEeMSYGWDTAs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jXqNiaps1fk0UEva3r9CUaPd4tDhJbJBYU5/18jYDbtNydMPk+YIP1ddiNJeqWRbN
         DFNeztbxJ4Ah1Cqf/O3cxC5S2oSiOTL0rjcihCpItFFL2m3Mqvo65UyUR5zUx3hrB1
         GxVR80pzupzh2tMdkrZiVBegbo+gUa92SUiWjv7ov3BCes4xksKQ8PNL5hnm7OedYZ
         LJaNQm0guQrDOAepSxz5AG1tVvNY6r1DTN3JPwd48vWleFLOXPW40py/qJlW9du59p
         Q9nJbe7bmnHk7cWz7CavVmXsTrKDMOZ5YdNtTZtm8vtvn4qkQtu6ORJP53MWdU2GPg
         z1Hsvt97UrfNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2E52E52443;
        Thu, 13 Apr 2023 12:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Fix a few BPF selftests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168138961799.16516.15133201435348786204.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 12:40:17 +0000
References: <20230412210423.900851-1-song@kernel.org>
In-Reply-To: <20230412210423.900851-1-song@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@meta.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 12 Apr 2023 14:04:20 -0700 you wrote:
> Fix a few BPF selftests. Please see each patch for details of these fixes.
> 
> Song Liu (3):
>   selftests/bpf: Use read_perf_max_sample_freq() in perf_event_stackmap
>   selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach
>   selftests/bpf: Keep the loop in bpf_testmod_loop_test
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Use read_perf_max_sample_freq() in perf_event_stackmap
    https://git.kernel.org/bpf/bpf-next/c/de6d014a09bf
  - [bpf-next,2/3] selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach
    https://git.kernel.org/bpf/bpf-next/c/c1e07a80cf23
  - [bpf-next,3/3] selftests/bpf: Keep the loop in bpf_testmod_loop_test
    https://git.kernel.org/bpf/bpf-next/c/2995f9a8d427

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


