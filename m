Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8589D61A3C6
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKDWAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKDWAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 18:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15335383;
        Fri,  4 Nov 2022 15:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1E81B82FF0;
        Fri,  4 Nov 2022 22:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CD6FC433B5;
        Fri,  4 Nov 2022 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667599216;
        bh=knNHN94eaRctWPLNdav1x0QZF0vD2JKY+q8uDxxpXrg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KVFnCPQNAE1wRFSO5ac/t7NiGOZA5gk+bnOF86K0VYWCLxMS/+GolHR/2NYlYjaEg
         5wMiaaMrTVFuZZwrh3AjxiMj+teAxvGS8Zg7VRgsCL/bdnjspvQDnygWVfe4U3TXhf
         hIKCL0F3vET3Hogm2OcmT6zpSN62VkNUqz0nPvaTlSeUGuJg1m3WHZgDk5ytFHo89S
         d6DPdTDLMr2t3u8bgfpahYNNGR2Ov1dHPdStuh8Xm204ENda/tZtJB7/gwZ7R2QlOf
         1eWHx9vM1cvv42cttcL98ALg1kUppoxzlXl4V4Fnue6LEt9LOHxalnMG8CnCimdGMC
         H4aCXpejb8AjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D8B6E270FB;
        Fri,  4 Nov 2022 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: Fix tracex2 error: No such file or
 directory
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166759921624.32033.15327405753171549306.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Nov 2022 22:00:16 +0000
References: <tencent_0F0DAE84C0B3C42E0B550E5E9F47A9114D09@qq.com>
In-Reply-To: <tencent_0F0DAE84C0B3C42E0B550E5E9F47A9114D09@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 29 Oct 2022 17:11:13 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> since commit c504e5c2f964("net: skb: introduce kfree_skb_reason()")
> kfree_skb() is replaced by kfree_skb_reason() and kfree_skb() is set to
> the inline function. So, we replace kprobe/kfree_skb with
> kprobe/kfree_skb_reason to solve the tracex2 error.
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: Fix tracex2 error: No such file or directory
    https://git.kernel.org/bpf/bpf-next/c/1baa7e380021

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


