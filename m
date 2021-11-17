Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFB945507D
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 23:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbhKQWdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 17:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241325AbhKQWdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 17:33:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 81DF261B6F;
        Wed, 17 Nov 2021 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188209;
        bh=6vxEXFjgewG5ccuP4uVCK55N317B0UCtA9hzS6812dc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dI4LKHDZEDFSAa27pPPq9MriPoSHE0E9K7yBTvRHXEHndCLYVeqLlW/b7HwsP4be5
         OoCDC/PXJAMPQe9BPiwUMRP9x3uxKw9p9VbGR5XIGdjelRRZUL3VNxMkGOqkxHEn22
         uE0fLu2SYGLjcb5t4/UEmxaDHLolWi2ClZ6/yRxlKEPgHJ4zIT3AunD4SQ9ufRzD5b
         4rSTkI3EBOnAIqqpcBsaUTPyDk+CvIl6B3IuFljRewlRst+ar6RuSmrhzOWCsXuKec
         OPJp7Xzg8h5fUKVFvdRLdJuJfT/VlFwUUFjrOw+cAgyWjT6Z2sZUpitqB41ahbB16v
         7JRwDtbfCOi7Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7013560A54;
        Wed, 17 Nov 2021 22:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Fix Navigation Issues in Docs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163718820945.31720.370225106624918698.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Nov 2021 22:30:09 +0000
References: <cover.1636749493.git.dave@dtucker.co.uk>
In-Reply-To: <cover.1636749493.git.dave@dtucker.co.uk>
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf@vger.kernel.org, corbet@lwn.net, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Nov 2021 21:17:21 +0000 you wrote:
> This patch set fixes a couple of documentation issues that was causing
> some strange behaviour when the sidebar was rendered in the HTML docs.
> 
> 1. The underlines in the BTF document weren't following the docs
> guidelines, which I believe caused an issue rendering the TOC with my
> other patches applied
> 2. Mixing the Sphix toctree with named sections was causing name stutter
> in the sidebar navigation. For example:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] docs: change underline in btf to match style guide
    https://git.kernel.org/bpf/bpf-next/c/3ff36bffaf35
  - [bpf-next,2/3] docs: Rename bpf_lsm.rst to prog_lsm.rst
    https://git.kernel.org/bpf/bpf-next/c/f5b1c2ef43d7
  - [bpf-next,3/3] docs: fix ordering of bpf documentation
    https://git.kernel.org/bpf/bpf-next/c/5931d9a3d052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


