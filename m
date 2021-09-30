Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798741E360
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 23:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhI3Vbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 17:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhI3Vbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 17:31:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6CB8C61A54;
        Thu, 30 Sep 2021 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633037407;
        bh=gQ3faKtuCFRgD3As8auc+6rTn9Oy2O8L9iXuAocWKns=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CUJ0Qj7mzf7h8lBzXAtJ/DwLO/zw4doX3vjNl1U/OlrGx9GHcpLJQ79gK2QF3Wv5H
         jY3O9hpq51UKBMrEkG+y00YpQcHeSleQ84Dl04/5yhB7JZbksjlrxEECja4gYzcPz6
         asWy0nPDQz7bAqYGT+aBpQrbFTMDAoR/KRnmxoHgN3x3/B6CQsUMavBgS8Qijg9bXa
         vaK8YGRU7VCL8NVkMdBLiMpWQ0vxiqgI94CfBYLpS8rKasyVKpaelXhzEexusoYko+
         09fAllZ13nnq17yGuV7knCqeaIeayUA2BPovfCGTNWroXJqAPuZDwNUaGNj6rAkrmF
         +po2EmEGtHtmg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 62A2C60C16;
        Thu, 30 Sep 2021 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Trivial: docs: correct some English grammar and
 spelling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163303740739.3160.9646843238209736664.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Sep 2021 21:30:07 +0000
References: <YVVaWmKqA8l9Tm4J@kev-VirtualBox>
In-Reply-To: <YVVaWmKqA8l9Tm4J@kev-VirtualBox>
To:     Kev Jackson <foamdino@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        gregkh@linuxfoundation.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 30 Sep 2021 07:34:02 +0100 you wrote:
> Header DOC on include/net/xdp.h contained a few English
>  grammer and spelling errors.
> 
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Kev Jackson <foamdino@gmail.com>
> ---
>  include/net/xdp.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next] Trivial: docs: correct some English grammar and spelling
    https://git.kernel.org/bpf/bpf-next/c/6bbc7103738f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


