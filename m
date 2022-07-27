Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE9582954
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiG0PKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 11:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiG0PKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 11:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87D5F79
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 08:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04533B8219F
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 15:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE58C433D7;
        Wed, 27 Jul 2022 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658934613;
        bh=HxCoxcQcmPywRO1BKNxlzgoHCtLvbB8ebmil2YFEGbI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NfxhPyN4jwOl7nfTGSuCu1p/DiyqRWCEmAC8teoCf2qzyovSm2TM/YHCmBZ5qKo1c
         r2shpEKURaETxcPhIkcVajCra6vgBUOJoU+imfAigmEAJyrSiFHsm0wp5LnY6e1WQ+
         +NUpMWkaOCg+OoWcNzeotcvu11zTDjPoSezL4oAKrsqj1Y/JHgmWQvPBwWW0GSviqV
         YuqGFTDqDkkMgS9OciScX+HW4XcjmB3tcG+LdvGNDroFEEbHH/IDM649FoU58HrCCv
         bPR9hw218TD1+HjYMVN5M1YHyu1I9/1I55qDalV+P7ZUptoXvLK0JRH4q1JzJNbyfp
         0uMjo5Pks38FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90FCFC43143;
        Wed, 27 Jul 2022 15:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Maintain selftest configuration in-tree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165893461358.29339.11641967418379627671.git-patchwork-notify@kernel.org>
Date:   Wed, 27 Jul 2022 15:10:13 +0000
References: <20220727001156.3553701-1-deso@posteo.net>
In-Reply-To: <20220727001156.3553701-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, mykolal@fb.com,
        kafai@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 27 Jul 2022 00:11:53 +0000 you wrote:
> BPF selftests mandate certain kernel configuration options to be present in
> order to pass. Currently the "reference" config files containing these options
> are hosted in a separate repository [0]. From there they are picked up by the
> BPF continuous integration system as well as the in-tree vmtest.sh helper
> script, which allows for running tests in a VM-based setup locally.
> 
> But it gets worse, as "BPF CI" is really two CI systems: one for libbpf
> (mentioned above) and one for the bpf-next kernel repository (or more precisely:
> family of repositories, as bpf-rc is using the system). As such, we have an
> additional -- and slightly divergent -- copy of these configurations.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] selftests/bpf: Sort configuration
    https://git.kernel.org/bpf/bpf-next/c/aee993bbd05c
  - [bpf-next,v4,2/3] selftests/bpf: Copy over libbpf configs
    https://git.kernel.org/bpf/bpf-next/c/cbd620fc18ca
  - [bpf-next,v4,3/3] selftests/bpf: Adjust vmtest.sh to use local kernel configuration
    https://git.kernel.org/bpf/bpf-next/c/40b09653b197

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


