Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80C941BA6C
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 00:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbhI1Wbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 18:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242929AbhI1Wbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 18:31:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 375A56139E;
        Tue, 28 Sep 2021 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632868207;
        bh=AsxLU1nlnkkb1N/2fVWNED6AaR4pCSegRqLDfMLW5jc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sAJeFGS92iy8O4WXtVT+aGAcyhyVJXheOPf4W3OegiYDvB9f82k5/2IoRCnQy7Kop
         WlDj7wV7xWDjenH5HOs8+u9QPsIpMS0htuErh4ytZx1lzSwp0x8Yq85NbgEUdikC2d
         Ee1mv36mDFgVZMGzEhWhYZCXa9i30TP/pBOLUN0H0HBMqj/lxJEi1APAMvy9lXzlKD
         p9Bo0bCO20mQwkI/52tuZ6NFQOOFM38Wmse9F/Yctm+GQCvXaD2LRQ2in8BIiTDFPq
         QSXMWHiHOmG3mlbeODT/G6GuqR6vczjXhFdipcq/aI0rcNFkCCoHy6gwiJUnlbHz/L
         yvhQh09y9bEXQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2E5DB60A69;
        Tue, 28 Sep 2021 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/bpftool: Avoid using "?:" in generated code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163286820718.3640.11148798241879130769.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Sep 2021 22:30:07 +0000
References: <20210928184221.1545079-1-fallentree@fb.com>
In-Reply-To: <20210928184221.1545079-1-fallentree@fb.com>
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, sunyucong@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 28 Sep 2021 11:42:21 -0700 you wrote:
> "?:" is a GNU C extension, some environment has warning flags for its
> use, or even prohibit it directly.  This patch avoid triggering these
> problems by simply expand it to its full form, no functionality change.
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/bpf/bpftool/gen.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] tools/bpftool: Avoid using "?:" in generated code
    https://git.kernel.org/bpf/bpf-next/c/09710d82c0a3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


