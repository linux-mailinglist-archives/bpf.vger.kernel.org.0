Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559C14D9F87
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 17:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349012AbiCOQBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiCOQBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 12:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB4056221
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 09:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9649B61371
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 16:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3143C340ED;
        Tue, 15 Mar 2022 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647360010;
        bh=OmWwmTdWbvTJDm9pcvztWPwUTwCquRzORY97mXE6iJk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ghexaJjWu+VT/ObywHuppZW4M9BuqpLtNTgtRZp6WE9FDqOQAnL3AavHsh/lQIbGR
         +qTNmlznv47g2dQYf0fz+wcLN2a8yzj3EGWd+mQZUJ4KtfX3mLlUGWXzsx+xdMVJmx
         7g+21y/XwXXQHi2qQVQpx5uyr7VztCgbhfh3EvZiClGqCsv1BdctxoP8s6qTRU0Tl6
         bIcxb2dfu3/LbHpEeGH9eGi7KXNb3vZmfngmgS/ZlvfPwdKi7Ua3LVH9qoZUe0BCoR
         /yIjoX1MsgdGOeUO+fkJeLpC2Rry+RlexYAwwPL18FdLpnAfmvs8S4T84XcscRB7/N
         Gd9qst5Jy9BFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C252FE6BBCA;
        Tue, 15 Mar 2022 16:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next] samples/bpf: xdpsock: Fix race when running for fix
 duration of time
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164736001078.10194.6138869870948326446.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Mar 2022 16:00:10 +0000
References: <20220315102948.466436-1-niklas.soderlund@corigine.com>
In-Reply-To: <20220315102948.466436-1-niklas.soderlund@corigine.com>
To:     =?utf-8?q?Niklas_S=C3=B6derlund_=3Cniklas=2Esoderlund=40corigine=2Ecom=3E?=@ci.codeaurora.org
Cc:     bjorn@kernel.org, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, louis.peens@corigine.com,
        simon.horman@corigine.com, bpf@vger.kernel.org,
        oss-drivers@corigine.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 15 Mar 2022 11:29:48 +0100 you wrote:
> When running xdpsock for a fix duration of time before terminating
> using --duration=<n>, there is a race condition that may cause xdpsock
> to terminate immediately.
> 
> When running for a fixed duration of time the check to determine when to
> terminate execution is in is_benchmark_done() and is being executed in
> the context of the poller thread,
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: xdpsock: Fix race when running for fix duration of time
    https://git.kernel.org/bpf/bpf-next/c/8fa42d78f635

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


