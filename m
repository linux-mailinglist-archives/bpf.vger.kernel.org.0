Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCCC3935C9
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE0TBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 15:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235610AbhE0TBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 15:01:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1C4166139A;
        Thu, 27 May 2021 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622142010;
        bh=TmxPCYQSORbslCrNHAtsQU6J8HqGLZDhGfjOWxvH3D4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RThOd9X0HQZIUcsYQicB1BgnGsRmlfquZEj0A/sHBa8OJgzVrcbWXGaZS+Z33NCpu
         yJCCyd/rIpwpPcFob50joXZ/tnloQS5mJCgvD9pnR2nLmjF8zA+FBNjfksqwm1nOwP
         u59mMU90U2QwS4b6mfe8rH1b7jwE+0ri1H4jm04ci1wwfokKURccTIj/CNcdOLND6r
         Tt50N8XQrX61kG1TFp0quSG62/4601ynSf93sRzeVl5uMQngY4+K07LqhBBrgiPyf4
         zH8P4v+Upn0am40NgXVb4pMDj9JgpPpLGzbQqxiMBhmOgMP1bJzaTtSlvz6wa96UKT
         3DM+OG8pgSkyQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0F95760CE1;
        Thu, 27 May 2021 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] kbuild: quote OBJCOPY var to avoid a pahole call break the
 build
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162214201005.13306.13681434176517015104.git-patchwork-notify@kernel.org>
Date:   Thu, 27 May 2021 19:00:10 +0000
References: <20210526215228.3729875-1-javierm@redhat.com>
In-Reply-To: <20210526215228.3729875-1-javierm@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com, ast@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 26 May 2021 23:52:28 +0200 you wrote:
> The ccache tool can be used to speed up cross-compilation, by calling the
> compiler and binutils through ccache. For example, following should work:
> 
>     $ export ARCH=arm64 CROSS_COMPILE="ccache aarch64-linux-gnu-"
> 
>     $ make M=drivers/gpu/drm/rockchip/
> 
> [...]

Here is the summary with links:
  - [v2] kbuild: quote OBJCOPY var to avoid a pahole call break the build
    https://git.kernel.org/bpf/bpf/c/ff2e6efda0d5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


