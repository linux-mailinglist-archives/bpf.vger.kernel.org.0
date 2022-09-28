Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6A5EEA3E
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiI1Xkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiI1XkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 19:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591210F7
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 16:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A23D5B82260
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 23:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 584DEC433C1;
        Wed, 28 Sep 2022 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664408417;
        bh=dFMKTvZ1Jlosy1dCug2Me6vlqKmyuW/f3/tD4lX4dwI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QFoeMV5YrFx2XH7x5pnlkTcL48Gi7NU4kTzXPb5YfH+umByktw5qTC1EXhrnp+Trc
         A+buEiFVgkDgw5uFhs6pkIXFwG7sg3xnsjsq2UvOD348gOVRTMysKXLzukQg+KPBx5
         TNzk10ShGbdM/PGd4cRmg1Hg6L5PPeJGIj5kwHErehPDe04LY0wysqopzIZdaU1Pfs
         6cHp03rDjt/qKcdhhocuCeR88+/1yl2y9fQnm76V6/K9MRNDxjjXBZ5OgvJtlgqcmD
         Nrok5/wdF2e5SI5zneROgfWERsNQJqEL2TB0+/PeMsFN+q586FOlsVnJUhZVits971
         aY/yapmczo5bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E425E21EC6;
        Wed, 28 Sep 2022 23:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v11 0/5] Parameterize task iterators.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166440841724.5658.15753092600635265807.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Sep 2022 23:40:17 +0000
References: <20220926184957.208194-1-kuifeng@fb.com>
In-Reply-To: <20220926184957.208194-1-kuifeng@fb.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 26 Sep 2022 11:49:52 -0700 you wrote:
> Allow creating an iterator that loops through resources of one task/thread.
> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested in only the
> resources of a specific task or process.  Passing the additional
> parameters, people can now create an iterator to go through all
> resources or only the resources of a task.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v11,1/5] bpf: Parameterize task iterators.
    https://git.kernel.org/bpf/bpf-next/c/f0d74c4da1f0
  - [bpf-next,v11,2/5] bpf: Handle bpf_link_info for the parameterized task BPF iterators.
    https://git.kernel.org/bpf/bpf-next/c/21fb6f2aa389
  - [bpf-next,v11,3/5] bpf: Handle show_fdinfo for the parameterized task BPF iterators
    https://git.kernel.org/bpf/bpf-next/c/2c4fe44fb020
  - [bpf-next,v11,4/5] selftests/bpf: Test parameterized task BPF iterators.
    https://git.kernel.org/bpf/bpf-next/c/b3e1331eb925
  - [bpf-next,v11,5/5] bpftool: Show parameters of BPF task iterators.
    https://git.kernel.org/bpf/bpf-next/c/6bdb6d6be019

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


