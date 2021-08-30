Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2444D3FBD71
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 22:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhH3UbA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 16:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232906AbhH3Ua7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 16:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8D20660F5E;
        Mon, 30 Aug 2021 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630355405;
        bh=RMWCgQ4h9cA6/9cRy5YJvUYIGQVrtAraQUybGCFdpx0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SinsSYPlBgwmK6Y57LyuJw3gdkQTQV1Xy4bM0GZ652cwqSJuLMw1fd16sG09mzUm/
         cw4EMqrJr1UC7c/3YBSofql84uiRXWuR0+eXvvC/YlxytD5vQuRkaVQIXdzLPOpBw1
         c/AQwQz3Zd+Psil6kl58Qyd8RWs5Paq2MHBXIk7zoskWo9HeI6oGv8pKz1aP5vB/SY
         EDIUT6dVxRWZddUfj5ADuh8D3+w//V/7HKRyQWldqIdhy4HEZ07zIhhKWpX8ciYElE
         3NKJCR9L8xn4TMJ4d7Ocdc/iCEjTdjFyw9TsuUo4HeaLorFepdgTrOvVUNpRp0RewZ
         DB6LIGUZbscBQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 80AD960A6C;
        Mon, 30 Aug 2021 20:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Remove self from powerpc BPF JIT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163035540552.23714.6864750324468366107.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Aug 2021 20:30:05 +0000
References: <20210827111905.396145-1-sandipan@linux.ibm.com>
In-Reply-To: <20210827111905.396145-1-sandipan@linux.ibm.com>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, naveen.n.rao@linux.ibm.com, mpe@ellerman.id.au
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 27 Aug 2021 16:49:05 +0530 you wrote:
> Stepping down as I haven't had a chance to look into the
> powerpc BPF JIT compilers for a while.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: Remove self from powerpc BPF JIT
    https://git.kernel.org/bpf/bpf-next/c/fca35b11e18a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


