Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA34698FB
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbhLFOdk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 09:33:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48904 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242092AbhLFOdj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 09:33:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E75EDB810EE;
        Mon,  6 Dec 2021 14:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9586CC341C2;
        Mon,  6 Dec 2021 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638801008;
        bh=jjnF6WfMx11qf6a05qyEgaVAkDfWWwe+75bjHsdGf9A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mahBsa0Ek1KA8EQxhWxLkePTbtGIB+5u1iK34nse0t0uZO/nP6gtbxY48fQGu1271
         HMIUBfju9z765B+fVkV0Lm8ttCD6nLgtq5bNkS/TZPlVmmBwxrHrL9Mf5D9FM2gOx/
         /tn50O0pDrTwtomi02jXV2+Mib50wAa2XcUpcLNyA8y/rwYnvF7X9AQN+2mfPHyTPe
         IDIh1a8mgCksG1Guq0sdxGgrfcDRSyI9zPsOvKCgfx5N3PpCEKsJ7gw+X57QcNSDpn
         rLhPjcSSgjXoayCHuHEFBeeXzagJIIS4G7/NWwCYchCUkOavlz4CBGSlDwYDWD5SA3
         c/f+NZ1wCtxFQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 78F29604EB;
        Mon,  6 Dec 2021 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] bpf: Remove config check to enable bpf support for branch
 records
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163880100849.9978.9385858982566868204.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Dec 2021 14:30:08 +0000
References: <20211206073315.77432-1-kjain@linux.ibm.com>
In-Reply-To: <20211206073315.77432-1-kjain@linux.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        peterz@infradead.org, songliubraving@fb.com, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com, andrii.nakryiko@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  6 Dec 2021 13:03:15 +0530 you wrote:
> Branch data available to bpf programs can be very useful to get
> stack traces out of userspace application.
> 
> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
> added bpf support to capture branch records in x86. Enable this feature
> for other architectures as well by removing check specific to x86.
> 
> [...]

Here is the summary with links:
  - [v4] bpf: Remove config check to enable bpf support for branch records
    https://git.kernel.org/bpf/bpf-next/c/db52f57211b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


