Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC7536C8D0
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhD0Pkw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 11:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhD0Pkw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 11:40:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8FB806115C;
        Tue, 27 Apr 2021 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619538008;
        bh=Zh4YL3p6gNj3osIPMmgJqkZIDPqOgtBo+K5Ovvj2gVE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ElcobintHHdqAJ/RN28iD4mKuWsAVH4aapg7Oj9vvCGiAi2HHtUduv/O7Fp6l9NGi
         BdK0STuBu7wUn/IFFG1oiwHlml7vwgNHseBFl20a6nxYcxBLrDq4VWHEyjyg2aRKDs
         jM69HJElW9H9uNfrO2midWQioeGpf2S8mFSmv6vy36qm39MdOGokd8gK7YN/RugGEr
         Win2dUMnmx/1QLcp+Yh/H+Pu/sQwPQJZsgq7ovH8a8fyao6WxNLAu3fLEXu8eWWHdt
         +BgdnA+ZKVZF7eJmMLNEHO8ONhWLJFjp919fv0bhHSM7BoAnCe92zapqZKjG7NTVcJ
         V85nEFjncPs1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84789609CC;
        Tue, 27 Apr 2021 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] docs: bpf: Fix literal block
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161953800853.25842.5867813619345155071.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Apr 2021 15:40:08 +0000
References: <20210424021208.832116-1-hengqi.chen@gmail.com>
In-Reply-To: <20210424021208.832116-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 24 Apr 2021 10:12:08 +0800 you wrote:
> Add a missing colon so that the code block followed can be rendered
> properly.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  Documentation/networking/filter.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] docs: bpf: Fix literal block
    https://git.kernel.org/bpf/bpf-next/c/2551c2d19c04

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


