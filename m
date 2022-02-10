Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F54B185B
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 23:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiBJWkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 17:40:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiBJWkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 17:40:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D00126E7
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 381FF61CEC
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 22:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 948CFC340ED;
        Thu, 10 Feb 2022 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644532815;
        bh=zo84Y3JHwu4NDkrDPdMAjZdBQR+dY/AOCkoBT9jKihU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d1pR5hGSTiOK4xd38+Dd6bQcbj+NeDwbLeeoXpxXpgtMHJuYMAsffW2D59dd+S2/7
         AM1AieNilJkh0C7Owyh1eQ49vo3M2pUqiXm3iohkI2Te/7ndfRjmEkJY4xGcnZ0nLW
         QOzZY/5ibS4aDYt5cutUtx0Hvq/VyL4h3ZNzL/kTEtE5pz7HPS7TThLMfW1GLJsHo/
         4cuMh8rHH2l1jkN7opAxujtVZRTbW2zxGcCNNX4LvbyD/2Slvwc9nFhgBXTgdGIBbo
         IQksdphLbes3705TIeTZ3M5RkRIWDjzAvfIsEPY/ZJaqbYVgk/2A3+Jc67bHWduVHV
         JuZL7lHeXK5Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B943E6D447;
        Thu, 10 Feb 2022 22:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/5] bpf: Light skeleton for the kernel.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164453281549.22296.16610007194821340491.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Feb 2022 22:40:15 +0000
References: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  9 Feb 2022 15:19:56 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The libbpf performs a set of complex operations to load BPF programs.
> With "loader program" and "CO-RE in the kernel" the loading job of
> libbpf was diminished. The light skeleton became lean enough to perform
> program loading and map creation tasks without libbpf.
> It's now possible to tweak it further to make light skeleton usable
> out of user space and out of kernel module.
> This allows bpf_preload.ko to drop user-mode-driver usage,
> drop host compiler dependency, allow cross compilation and simplify the code.
> It's a building block toward safe and portable kernel modules.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/5] bpf: Extend sys_bpf commands for bpf_syscall programs.
    https://git.kernel.org/bpf/bpf-next/c/b1d18a7574d0
  - [v4,bpf-next,2/5] libbpf: Prepare light skeleton for the kernel.
    https://git.kernel.org/bpf/bpf-next/c/6fe65f1b4db3
  - [v4,bpf-next,3/5] bpftool: Generalize light skeleton generation.
    https://git.kernel.org/bpf/bpf-next/c/28d743f67127
  - [v4,bpf-next,4/5] bpf: Update iterators.lskel.h.
    https://git.kernel.org/bpf/bpf-next/c/d7beb3d6aba3
  - [v4,bpf-next,5/5] bpf: Convert bpf_preload.ko to use light skeleton.
    https://git.kernel.org/bpf/bpf-next/c/cb80ddc67152

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


