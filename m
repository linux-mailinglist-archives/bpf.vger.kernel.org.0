Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EAC2D6070
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 16:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392027AbgLJPu4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 10:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391507AbgLJPur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 10:50:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607615406;
        bh=66J5LD59jfrsjXby6GJDX06e6pE+1qY4KggREgOz0xc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BvZIUA57zGXwSsq4/0tPLgmPmOJg3inFv2+4b6VBZVnlX7SmOXDJFCGjRVl9n1u5I
         nTXYsSjqL4NzjmY9hfo7GoAF+PDa2zRTH/m1OMb//F/ZQR3bj2LQKovfSQZrdUBb+M
         XBBKzQcPj6We4v887Qh/Yx4dyzAAaUBZBZd84Bz6v8yoVB0vfPL3EV/xsI26rGzn+i
         ySPZ3pf4Pic06tQtESZh3QT/Im4BnzRgrc6P6uLtySfDRSXzsz78qUl4s3DO1FK0T4
         qL5XRGNYyfTVdN59wJNAnakZNEaypIIv6KGqA4V1wXhGn3OOpXwpI5Vl1eKAx9ETFy
         7G4WsfH5gwbVw==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Drop tcp-{client,server}.py from Makefile
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160761540646.22459.17218098992412746366.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Dec 2020 15:50:06 +0000
References: <20201210120134.2148482-1-vkabatov@redhat.com>
In-Reply-To: <20201210120134.2148482-1-vkabatov@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     bpf@vger.kernel.org, jolsa@redhat.com, brouer@redhat.com,
        alexanderduyck@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 10 Dec 2020 13:01:34 +0100 you wrote:
> The files don't exist anymore so this breaks generic kselftest builds
> when using "make install" or "make gen_tar".
> 
> Fixes: 247f0ec361b7 ("selftests/bpf: Drop python client/server in favor of threads")
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - selftests/bpf: Drop tcp-{client,server}.py from Makefile
    https://git.kernel.org/bpf/bpf-next/c/a5b7b1194a57

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


