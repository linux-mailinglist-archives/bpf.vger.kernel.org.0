Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7FC4A678E
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiBAWKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 17:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiBAWKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 17:10:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C0C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 14:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27DF860B28
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 22:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 871C4C340EC;
        Tue,  1 Feb 2022 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643753409;
        bh=/kxPn70+aiTjThAhlwHInFCWXGg5+ihQn61++eepcp8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dz9Tlqg0+IQmJw8P9oGgVOZ89FOG7fUGy4Y0JyNJhMNieQJ4CFGDxG2U+uEont+/5
         tENRiJosbvYsTk46kjETLcNKWlM7B7pL2InhFAVEiLEySpO6R9vARTcYvO+SEKuCLj
         3FojIJnLerkDysCgErBOG50iI0F8IqMl8RKHd4PbhIABuaCOSr5tOHb82BPIhfyygB
         W1fkuXp9Wr+rD39m3A5xC0UF/+K6xMbR3p8NlAl6KpPvjRqF5YtWhEDPHS7wSTaXWL
         IRzakWGbpik7MxwuAK99Jv4aVuT4ZFTx78iz3iQW3p6zUaGD1tpNYpP+khUKb4Ey34
         tQLPdbhjFmHgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F433E5D07D;
        Tue,  1 Feb 2022 22:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: Ignore errors from `which' when searching a GCC
 toolchain
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164375340944.14402.9754013878528437003.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Feb 2022 22:10:09 +0000
References: <20220201093119.1713207-1-jean-philippe@linaro.org>
In-Reply-To: <20220201093119.1713207-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     nathan@kernel.org, ndesaulniers@google.com, llvm@lists.linux.dev,
        bpf@vger.kernel.org, andrii@kernel.org, quentin@isovalent.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  1 Feb 2022 09:31:20 +0000 you wrote:
> When cross-building tools with clang, we run `which $(CROSS_COMPILE)gcc`
> to detect whether a GCC toolchain provides the standard libraries. It is
> only a helper because some distros put libraries where LLVM does not
> automatically find them. On other systems, LLVM detects the libc
> automatically and does not need this. There, it is completely fine not
> to have a GCC at all, but some versions of `which' display an error when
> the command is not found:
> 
> [...]

Here is the summary with links:
  - tools: Ignore errors from `which' when searching a GCC toolchain
    https://git.kernel.org/bpf/bpf/c/b7892f7d5cb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


