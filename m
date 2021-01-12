Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F32F3CF5
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436947AbhALVhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 16:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437043AbhALUus (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 15:50:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D4BB52311F;
        Tue, 12 Jan 2021 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610484607;
        bh=0YEmzDOMnvTqrqLfgLY4y0hKwNvcY5DzN9rDYiXnhmg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tCBs8jVbnPeNZ5P73ToDiO+R425PUBJootf90ftRosrjXt2IK6JK39y83SlU6Qhkn
         IWA1sNzXqh42nGrEdlv+a7bOI3TEAgzRw2awG0pg4F3kOkVgSDsBdb2CBEUwhxfz5v
         fi4U0jFxJ0WFw2KI2RLrIlHSUSnnZvXIGhM2MMhgoP9fTPETLU4xa9USfEnxtnmh2a
         XOK0KMKLZ7CF0bfTLmbvr5N5yyDt9F2N8y96wH8sC8EVmOrIzXGDMvxvskd7Pvc0CL
         psKQD8rLuB1NpCv/3nrGZEKFWBjFFZ5IpURfE1AqDFrDLb7jL5mwZVWwn2sapcdrwP
         L/HZJC2DvAZ6Q==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id CA01F60354;
        Tue, 12 Jan 2021 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix a verifier message for alloc size helper
 arg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161048460782.12742.11835000205533148789.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Jan 2021 20:50:07 +0000
References: <20210112123913.2016804-1-jackmanb@google.com>
In-Reply-To: <20210112123913.2016804-1-jackmanb@google.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, kpsingh@chromium.org,
        revest@chromium.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 12 Jan 2021 12:39:13 +0000 you wrote:
> The error message here is misleading, the argument will be rejected
> unless it is a known constant.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix a verifier message for alloc size helper arg
    https://git.kernel.org/bpf/bpf-next/c/28a8add64181

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


