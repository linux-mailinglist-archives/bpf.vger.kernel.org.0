Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF79631E1CD
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 23:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhBQWKs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 17:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhBQWKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 17:10:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3400A64E2E;
        Wed, 17 Feb 2021 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613599807;
        bh=RTrHvcKlu4nh2Uhh5Yy4CCmThHz37p3dsD6u6sdppHU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uBEVVJ/HZ7z777vIkozNbFM/29C1elhPuwU3QdWmus+Q2QYy+MtGovMl9EDNLkj9K
         hevUVs9zP+zR1XKt7PtaRhhLvHqJvGf74BiUnBfdLEyld/Dyg5Euyq8Vutx5UH0q4q
         xeWcfb/gB0E/gqlp5I1DNY6t201sKSaaSFd68wDZzmncdmjL/nEbDeo9+3Mait1PjC
         Q3SXeeVDP8Kdiq/gWe8ERrrSTowVYli9wq9+WekMK4+wPSaduj3+UuBLMGsP2Rvp+2
         My+M+dw2DrN2dx6OOr9gv0LecvNXWMJp/7DmICwe0ZvIQDU3eiKd+ekALrRj5tNsuO
         wd+kg4O2iFsIA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 22C8560A15;
        Wed, 17 Feb 2021 22:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: fix a warning message in
 mark_ptr_not_null_reg()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161359980713.20364.16930530087071491703.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Feb 2021 22:10:07 +0000
References: <YCzJlV3hnF/t1Pk4@mwanda>
In-Reply-To: <YCzJlV3hnF/t1Pk4@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, me@ubique.spb.ru,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 17 Feb 2021 10:45:25 +0300 you wrote:
> The WARN_ON() argument is a condition, not an error message.  So this
> code will print a stack trace but will not print the warning message.
> Fix that and also change it to only WARN_ONCE().
> 
> Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: fix a warning message in mark_ptr_not_null_reg()
    https://git.kernel.org/bpf/bpf-next/c/7b1e385c9a48

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


