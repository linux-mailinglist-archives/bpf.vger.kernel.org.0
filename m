Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A602D7000
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 07:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393382AbgLKGLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 01:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390445AbgLKGKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 01:10:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607667006;
        bh=wwJ7hg/RxZRVZ8J7t4t++u4PaC1wvJaYb3ZZk8MYU20=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bk00jS3LukFx8xNqwxNwTvzX5qgN9er4DSs7bESuWoTxZWAKBxKu7aEdfeaB7OaSS
         FXVopOGFL22qU2i/KRonyG433O1rV4X7uCHy4bN3PJTfEL/iF8rSXPkyKdDTgC/Zq5
         4jI22yQ1K9q0qxOEq2IorAD2nMeHVYiIfeMsTa8cZoi6e+EZUcVEZDEqLM74jf+AWF
         FOpV+QMvPcncNdfDnSyIF6KBXAISr5Gr7IFjhK4J4BG4Hi0sW2cyFU6wpCLuSYpKWP
         FqzCqZ/dm5echVEBhXa9kvBcggKjBNHQsHRKhOG61t6UTFu0J7AbMwYje1u4uQv2Ad
         TNY+HwCpdp90g==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Drop the need for LLVM's llc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160766700661.11568.14135729459303174794.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Dec 2020 06:10:06 +0000
References: <20201211004344.3355074-1-adelg@google.com>
In-Reply-To: <20201211004344.3355074-1-adelg@google.com>
To:     Andrew Delgadillo <adelg@google.com>
Cc:     yhs@fb.com, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 11 Dec 2020 00:43:44 +0000 you wrote:
> LLC is meant for compiler development and debugging. Consequently, it
> exposes many low level options about its backend. To avoid future bugs
> introduced by using the raw LLC tool, use clang directly so that all
> appropriate options are passed to the back end.
> 
> Additionally, simplify the Makefile by removing the
> CLANG_NATIVE_BPF_BUILD_RULE as it is not being use, stop passing
> dwarfris attr since elfutils/libdw now supports the bpf backend (which
> should work with any recent pahole), and stop passing alu32 since
> -mcpu=v3 implies alu32.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Drop the need for LLVM's llc
    https://git.kernel.org/bpf/bpf-next/c/89ad7420b25c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


