Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0B5767E5
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 22:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGOUAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 16:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiGOUAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 16:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8169B82FB2
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 13:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2709612D6
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 20:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39CD8C341C6;
        Fri, 15 Jul 2022 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657915213;
        bh=iIGbBi0bmV6Oo5uB9bo4no7iV0unh7sNbw3SIpi89JA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j7xjahQPxV7TK0oUvxKPCbdR5WT2Ffjm0+agl2LiUqImKXWeHHBQ4dZ3+rA7dxV2x
         BeNclb4Z/hnORA71FKbNU9Tu8qGvRWuTa8nX+Ow5+UWxaDbNPkXbww7l8zFJHy6kPR
         BK0YjrlAw9dIksLS7YHs+ZU1LlD0QzsZmznaIi7VvSbkCPwu51BKbWW3712Bv4HhhE
         FchH43p5g6Yi1UIPhCTRH4dbEE7wXAj6aEn0B2esRrnYOXM/ByE8VWdFBlLwcXtEXe
         j99gNTmwzJDNVDIypiuaQLzH3fOxuSJAW4ftcFs8wzJn6KGUPQlk5ZF4XEFlrrQ9ca
         QYv8oB2WHg1bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B047E4521F;
        Fri, 15 Jul 2022 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5] libbpf: perfbuf: Add API to get the ring buffer
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165791521310.28815.13976146551379158711.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jul 2022 20:00:13 +0000
References: <20220715181122.149224-1-arilou@gmail.com>
In-Reply-To: <20220715181122.149224-1-arilou@gmail.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, jond@wiz.io
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 15 Jul 2022 21:11:22 +0300 you wrote:
> From: Jon Doron <jond@wiz.io>
> 
> Add support for writing a custom event reader, by exposing the ring
> buffer.
> 
> With the new API perf_buffer__buffer() you will get access to the
> raw mmaped()'ed per-cpu underlying memory of the ring buffer.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5] libbpf: perfbuf: Add API to get the ring buffer
    https://git.kernel.org/bpf/bpf-next/c/9ff5efdeb089

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


