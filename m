Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4E44EE5B
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 22:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhKLVM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 16:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235619AbhKLVM6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 16:12:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1B1C660F42;
        Fri, 12 Nov 2021 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636751407;
        bh=vCdub3yQIwLyBPqVIF93PHJsv30+nq9GlbAjhpdKCao=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WIEh1s6Ks7UsBOQVB/+VWEtrYAdrHVOqwYNNOvS/MuFja+tBG94xCXX7QUlFlq2MY
         52hjlgeurJZPEN+3uOW5P337V5oPwGwDHro2BYVYeJrgRbxOK9Z9GuIcNVmfK7Q/kp
         PmAaXWlQ3ZwX771tJ0e97X/nEugx91Pzu33/0iHwOWgDJTWOlnDFGpT00zE2MrB3MP
         N74g6RbszSQiz3YCFpobV2yqMITpFb2K33myeEYzgRCybXkdUg4yLgXjyMNJ5x2LUH
         CO1NPPWYqKBeIQYWLX8sF8vgrTo+P6TRwpJKH1TORCEcQvNTNbAx0fi4qVCyBM4ds6
         cUDlM+gvV5HRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0C2F4608FE;
        Fri, 12 Nov 2021 21:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix incorrect use of strlen in xdp_redirect_cpu
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163675140704.22228.8160589380637311123.git-patchwork-notify@kernel.org>
Date:   Fri, 12 Nov 2021 21:10:07 +0000
References: <20211112020301.528357-1-memxor@gmail.com>
In-Reply-To: <20211112020301.528357-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Nov 2021 07:33:01 +0530 you wrote:
> Commit b599015f044d tried to fix a bug where sizeof was incorrectly
> applied to a pointer instead of the array string was being copied to, to
> find the destination buffer size, but ended up using strlen, which is
> still incorrect. However, on closer look ifname_buf has no other use,
> hence directly use optarg.
> 
> Fixes: b599015f044d ("samples/bpf: Fix application of sizeof to pointer")
> Fixes: e531a220cc59 ("samples: bpf: Convert xdp_redirect_cpu to XDP samples helper")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix incorrect use of strlen in xdp_redirect_cpu
    https://git.kernel.org/bpf/bpf/c/ed95f45142fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


