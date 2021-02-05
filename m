Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D93101A5
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhBEAas (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 19:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhBEAas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 19:30:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C76B364FB0;
        Fri,  5 Feb 2021 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612485007;
        bh=/DKlslXPCHPpLByP3fREj55+OyEglLMYSLXcDXiHGqU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X8totJgCo21/Gq6kRQ+MD6oKz65IN6e1Va4u/aQwnriTmwAkHBOtjT8G6xb6mEiS7
         UIp7Cbk/cV8TUG4Ahfvwsd6riA9UhRoQ1CAZ8k5pLadyVN3k0MX4gHjCAgzsxkR7zH
         voIDGhpI9Gi9qoaM9C0G7tTlK/DVwIdHEePfB1wUxkw8GdshMMlYbp+lfHPNlkxOGs
         EU4a8+BBguKBJEPn/u+y9Hw4gfi2nVfF1BgaBxtSrv05eMJyuynGePI9X+RsPDfFFH
         hjlRUiSToilLb9DI0ZYFf98ZGkYBgF+cyc/vrJ245HlTF8GO6/t6zJroHkuNQ4FH23
         0BD6pVznqe/EA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A87AA609F1;
        Fri,  5 Feb 2021 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] BPF selftest helper script
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161248500768.20841.13446215833465898316.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Feb 2021 00:30:07 +0000
References: <20210204194544.3383814-1-kpsingh@kernel.org>
In-Reply-To: <20210204194544.3383814-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, revest@chromium.org, jackmanb@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  4 Feb 2021 19:45:42 +0000 you wrote:
> # v4 -> v5
> 
> - Use %Y (modification time) instead of %W (creation time) of the local
>   copy of the kernel config to check for newer upstream config.
> - Rename the script to vmtest.sh
> 
> # v3 -> v4
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Helper script for running BPF presubmit tests
    https://git.kernel.org/bpf/bpf-next/c/c9709f52386d
  - [bpf-next,v5,2/2] bpf/selftests: Add a short note about vmtest.sh in README.rst
    https://git.kernel.org/bpf/bpf-next/c/881949f770bf

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


