Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9E4E1EEE
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 03:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbiCUCBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 22:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbiCUCBk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 22:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15C1262F
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 19:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF74B80FAE
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 02:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC531C340ED;
        Mon, 21 Mar 2022 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647828010;
        bh=LuSLRBDS21GizpqSnBQp3LNmGT2fWBzZpYV+39D2chY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fgUIVF3K4TFbEcy+/ZPQSG5qBpidpK6moQFwJ4N0QVjmm5xOeY/hoVrDc7oIX5Kwr
         dFWzGqvD9JNgQI66Lb9A4UWBBdEm9S12640lOeGnVgxgWbGLaCJ8Zv4fDxecaHUnVw
         TvwCM67MB3OAWAf1+usGg9rxoKqzshdW5StRXwl6NZJzvZBJjCDv4n5HtMW42MuBu7
         Xx6+aMnOMYJdc77slVfwN23jHem1xUDuu9LJohSkCv+WHUmsE5HhE6ImtvLFgmKS5g
         RmWyNcfbyQ2xHlMPCe25S/6TCEdiPw5+tHktrh4N6IYhQqnWGrytJc7HEmTSv+RxzI
         yL1vWVX2bfi2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90993E6D406;
        Mon, 21 Mar 2022 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] Enable non-atomic allocations in local
 storage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164782801058.32327.2805354676305440542.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Mar 2022 02:00:10 +0000
References: <20220318045553.3091807-1-joannekoong@fb.com>
In-Reply-To: <20220318045553.3091807-1-joannekoong@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, kpsingh@kernel.org,
        memxor@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, tj@kernel.org, davemarchevsky@fb.com,
        joannelkoong@gmail.com
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 17 Mar 2022 21:55:51 -0700 you wrote:
> From: Joanne Koong <joannelkoong@gmail.com>
> 
> Currently, local storage memory can only be allocated atomically
> (GFP_ATOMIC). This restriction is too strict for sleepable bpf
> programs.
> 
> In this patchset, sleepable programs can allocate memory in local
> storage using GFP_KERNEL, while non-sleepable programs always default to
> GFP_ATOMIC.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Enable non-atomic allocations in local storage
    https://git.kernel.org/bpf/bpf-next/c/b00fa38a9c1c
  - [bpf-next,v3,2/2] selftests/bpf: Test for associating multiple elements with the local storage
    https://git.kernel.org/bpf/bpf-next/c/0e790cbb1af9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


