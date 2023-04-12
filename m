Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C36DFF70
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDLUKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDLUKf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 16:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBC38A51;
        Wed, 12 Apr 2023 13:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB7E638F2;
        Wed, 12 Apr 2023 20:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17D38C4339C;
        Wed, 12 Apr 2023 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681330218;
        bh=RD4RF2uZdHI4CvIrdmaNhTSPbBeYayVeeCWT8r198UA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QZPfrApSnAwwn9TnZ9yoYH/OnVTWddfgLyVrknenpuH2UJrr3I6SkMfT29yvvc8GJ
         KnV7EytVHmgYPWFtEZQPmkYKwLvm3Hy8A/BgqCVhoJH76dmxUorH2EiNWCMCVJ9CCL
         ohmh9g98BYyBgn//izkIu7fSPgd3k09odYWbCBWTuX41NCNEFQIisLtm3Q1vWNNCVS
         e8bqgPjvKclWIbeQU8NBcaLhG0TNo21eBh1jcy81LZIEdOnwx3ta8ly2LYXKVnz3yk
         lNlbGbtSdvi1X18aZpNfaEZIAU7smXpw9Br/Em41RnGCYR0V8e1Te095Kd38f3x1Ik
         YD63K0jabDi7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7C57E5244C;
        Wed, 12 Apr 2023 20:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/3] bpf: Make bpf_cgroup_acquire() KF_RCU |
 KF_RET_NULL
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168133021794.9201.3978988070249625694.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Apr 2023 20:10:17 +0000
References: <20230411041633.179404-1-void@manifault.com>
In-Reply-To: <20230411041633.179404-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Apr 2023 23:16:31 -0500 you wrote:
> struct cgroup is already an RCU-safe type in the verifier. We can
> therefore update bpf_cgroup_acquire() to be KF_RCU | KF_RET_NULL, and
> subsequently remove bpf_cgroup_kptr_get(). This patch does the first of
> these by updating bpf_cgroup_acquire() to be KF_RCU | KF_RET_NULL, and
> also updates selftests accordingly.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Make bpf_cgroup_acquire() KF_RCU | KF_RET_NULL
    https://git.kernel.org/bpf/bpf-next/c/1d71283987c7
  - [bpf-next,2/3] bpf: Remove bpf_cgroup_kptr_get() kfunc
    https://git.kernel.org/bpf/bpf-next/c/6499fe6edc4f
  - [bpf-next,3/3] bpf,docs: Remove references to bpf_cgroup_kptr_get()
    https://git.kernel.org/bpf/bpf-next/c/ec48599abee3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


