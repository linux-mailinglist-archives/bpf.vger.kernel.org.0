Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE59397297
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 13:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFALlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 07:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhFALlo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 07:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8DDF9613C8;
        Tue,  1 Jun 2021 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622547603;
        bh=9epvEB+4UOCKxVbv6swmLvdXdCFcmTLxvY2xT1/f56Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rSv8SpcXZdW48gMyWVQCsyx/nYwpqIRV7vqCu/f1/cNe+cnH1vR8AghdhEf1GSKm3
         dkhL+MYBJhfEnAx47njTwONRF9LyhJX31TyLnzin9gAzp2p9emshVXRgBzLi4juL1x
         kPZqLakMVAe6PrFqBmDFMyWWzvcB+VEjtCKU7w2flzOqZkgIQ1xLZISY34YEtzfdWk
         Ban8PhVDUO/UblgAoQnD3V1pDqcTsQAxGtejkeaixli+leZwXz4mxSonoUjtg9QBxP
         puG5eJ3KhpItkEzM0gBGYTb0QuLwMafYajb+e1RuoPJtAlf5g0xbsYkzoC73qTaKM+
         tys11HHZAXbuA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 80C2660A5C;
        Tue,  1 Jun 2021 11:40:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: tnums: Provably sound, faster,
 and more precise algorithm for tnum_mul
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162254760352.13469.8265184561226766194.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Jun 2021 11:40:03 +0000
References: <20210531020157.7386-1-harishankar.vishwanathan@rutgers.edu>
In-Reply-To: <20210531020157.7386-1-harishankar.vishwanathan@rutgers.edu>
To:     HARISHANKAR VISHWANATHAN <hv90@scarletmail.rutgers.edu>
Cc:     ast@kernel.org, bpf@vger.kernel.org, ecree@solarflare.com,
        harishankar.vishwanathan@rutgers.edu, m.shachnai@rutgers.edu,
        srinivas.narayana@rutgers.edu, santosh.nagarakatte@rutgers.edu
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sun, 30 May 2021 22:01:57 -0400 you wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
> 
> This patch introduces a new algorithm for multiplication of tristate
> numbers (tnums) that is provably sound. It is faster and more precise when
> compared to the existing method.
> 
> Like the existing method, this new algorithm follows the long
> multiplication algorithm. The idea is to generate partial products by
> multiplying each bit in the multiplier (tnum a) with the multiplicand
> (tnum b), and adding the partial products after appropriately bit-shifting
> them. The new algorithm, however, uses just a single loop over the bits of
> the multiplier (tnum a) and accumulates only the uncertain components of
> the multiplicand (tnum b) into a mask-only tnum. The following paper
> explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: tnums: Provably sound, faster, and more precise algorithm for tnum_mul
    https://git.kernel.org/bpf/bpf-next/c/05924717ac70

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


