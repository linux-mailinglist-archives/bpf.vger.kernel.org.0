Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966143BF13D
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhGGVMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhGGVMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 17:12:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 992E661209;
        Wed,  7 Jul 2021 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625692203;
        bh=vt0ESRDPTWeUGHD82MjEXKrJJ5mXfO4JyIUhjTuwNiY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oGQaLqTYLZXQrxE+7fUdcBTzd3wT5Hqjy360Tb/QBvMLHtcP+tO8K+isWFJb8EtR8
         gk/iWLPGZ6LZCqscvOM9gAZSf95SbKagoie64bnBzCk9uF5qSvi2+ZMAppDL3GvKEI
         RYfHccuhtWISmP9FfPSiTlbgztI4zU8pUhKDl2DFjZohk66Pm0NU1c/2WRIFwivm/s
         RcJJ8QLF6mcKajbxUA0JKLXYucoWvUU3W/m1tf0TVFmIXcU59IoXMBC8VZVdNMoYi7
         LIEZ2oDABqhfEQ8u6v27dLJ8RwS8FuEpZVnLDHCmz/ORDLLUPOUqIOkmMHjUtQfeeW
         MtvGZNzA8fbpg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8C339609F6;
        Wed,  7 Jul 2021 21:10:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: bpf: Fix error in 'make -C tools/ bpf_install'
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162569220356.14612.2663823878014678070.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jul 2021 21:10:03 +0000
References: <20210628030409.3459095-1-liwei391@huawei.com>
In-Reply-To: <20210628030409.3459095-1-liwei391@huawei.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 28 Jun 2021 11:04:09 +0800 you wrote:
> make[2]: *** No rule to make target 'install'.  Stop.
> make[1]: *** [Makefile:122: runqslower_install] Error 2
> make: *** [Makefile:116: bpf_install] Error 2
> 
> There is no rule for target 'install' in tools/bpf/runqslower/Makefile,
> and there is no need to install it, so just remove 'runqslower_install'.
> 
> [...]

Here is the summary with links:
  - tools: bpf: Fix error in 'make -C tools/ bpf_install'
    https://git.kernel.org/bpf/bpf/c/1d719254c139

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


