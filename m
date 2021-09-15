Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B963340CD6C
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 21:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhIOTv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 15:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhIOTv0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 15:51:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 01B89610A4;
        Wed, 15 Sep 2021 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631735407;
        bh=7joLEVkfVCyk85jIthNyqQZfna0EhItSjZo3OBAQ4jw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LcPRUB0k+8vF/8bl7iEj7LXZMLNYiZBSL79bLuommB+AysorCF1edhNcKtWvQslcf
         adDnDKrKOrzJNwEx1bhq67eNVWJ+9HxfYWm/BVHimUZ9CXJXN+bfv6y/U7mQrpx4cI
         nBV76l59WwPR0Ze2J6lFYqd+bdYy5vjjq4woa7Ht4BtZx9aC4HQErl148MtKLYxq4P
         ZVXLFrzrGvHNxV58bxz/KhOvRXDwu4lhI1Dd4G44gicHjKhpCUaWOM+duFV2AccpTh
         Ot38zGHUd6lKrn/6eexJ9tZx9ci4eyd3kcm+Q9jd21vI7yRADmk9nMuLb1QzvY+jU1
         Ug/LUO1Y7j/4g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E1BC160A9E;
        Wed, 15 Sep 2021 19:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, mips: Validate conditional branch offsets
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163173540691.23489.15401014246279305631.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Sep 2021 19:50:06 +0000
References: <20210915160437.4080-1-piotras@gmail.com>
In-Reply-To: <20210915160437.4080-1-piotras@gmail.com>
To:     Piotr Krysiuk <piotras@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, paulburton@kernel.org,
        johan.almbladh@anyfinetworks.com, tsbogend@alpha.franken.de
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 15 Sep 2021 17:04:37 +0100 you wrote:
> The conditional branch instructions on MIPS use 18-bit signed offsets
> allowing for a branch range of 128 KBytes (backward and forward).
> However, this limit is not observed by the cBPF JIT compiler, and so
> the JIT compiler emits out-of-range branches when translating certain
> cBPF programs. A specific example of such a cBPF program is included in
> the "BPF_MAXINSNS: exec all MSH" test from lib/test_bpf.c that executes
> anomalous machine code containing incorrect branch offsets under JIT.
> 
> [...]

Here is the summary with links:
  - bpf, mips: Validate conditional branch offsets
    https://git.kernel.org/bpf/bpf/c/37cb28ec7d3a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


