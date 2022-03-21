Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9016B4E2C09
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348584AbiCUPWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbiCUPWM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 11:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798524F1A
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 08:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 726C560F7F
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 15:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5794C340F0;
        Mon, 21 Mar 2022 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647876009;
        bh=BUVAzhJcMLkTJspxWiiFOSQHUEHGhYmldJW6g+u5E3o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U4UZ/OoIyZdTZJdeSAWGBuw/PZvD7q/HgXDRvRnRYJn5jVWAuL8UzZ0GP+bHTQMS6
         FpT7tYtT4usBKBd5w+r5mlXAwfoliO/2HNq7IMSOp90b7Z7W+3Xda531f2N74ULYZz
         NuS5qLaGPVaDmmQH91ACQiN2LNNJKpRER5OfMW9WACy8iU5gjOn2VdTEV8JK9I956m
         WIb5I+Oa/7O3FaYVRPyy5x3DKiAHAsl+EKjWq3fDqsAk1oIu81L43fzMA5CJIL0634
         nBVWkAzKd8gF6J/z+VeTbOse0b423c1GhyLwO2bcsRKQmISkuIlGNDSRg5WsO6/v7X
         uGDu1w0ttpbvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD3D3E6D44B;
        Mon, 21 Mar 2022 15:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: Close fd in bpf_object__reuse_map
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164787600977.20941.4773407661485029217.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Mar 2022 15:20:09 +0000
References: <20220319030533.3132250-1-hengqi.chen@gmail.com>
In-Reply-To: <20220319030533.3132250-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 19 Mar 2022 11:05:33 +0800 you wrote:
> pin_fd is dup-ed and assigned in bpf_map__reuse_fd. Close it
> in bpf_object__reuse_map after reuse.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: Close fd in bpf_object__reuse_map
    https://git.kernel.org/bpf/bpf-next/c/d0f325c34c2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


