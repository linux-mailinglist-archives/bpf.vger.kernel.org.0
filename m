Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A0326993
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 22:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBZVav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 16:30:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhBZVat (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 16:30:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E1DAB64F13;
        Fri, 26 Feb 2021 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614375008;
        bh=UDDxPTz23Y3Om7u1JDJ1PlqFhnm+0H4jUKKZxz6uXY0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mxkq4e8kQI8Bcv10oARvX6KqFnQgrWfVsitfpZSD5cjR0Zwe8n9s7JaS4mAuz1fqw
         LTv93WSksUJ+ek2L2xGrmf/hU4tHdGkRYiSc76uFgRar55LTIMI7+IrpXM21X1eOB1
         IWLl0b5MOxWOiCkfuiPQT592bkpQ0d7pDQkXHF6rCFRIVz8be5GOx7TQz+ZeVLJhnj
         TMXtrgu8ccrHcg+QlpRnXbZUMgk578W7QXWB9GSA7h4E2CLUMWtMpbncHfj7ivfxIf
         0/9B1wniOS+EJpMuesHM0AOTyGtWFP+yO3FSaH2eT3TS9zgi5Kj2WTG5t+yWO4n1zB
         noGwilbzwjIJw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D487260A16;
        Fri, 26 Feb 2021 21:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Copy extras in out-of-srctree
 builds
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161437500886.30840.1095312840725845768.git-patchwork-notify@kernel.org>
Date:   Fri, 26 Feb 2021 21:30:08 +0000
References: <20210224111445.102342-1-iii@linux.ibm.com>
In-Reply-To: <20210224111445.102342-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 24 Feb 2021 12:14:45 +0100 you wrote:
> Building selftests in a separate directory like this:
> 
>     make O="$BUILD" -C tools/testing/selftests/bpf
> 
> and then running:
> 
>     cd "$BUILD" && ./test_progs -t btf
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Copy extras in out-of-srctree builds
    https://git.kernel.org/bpf/bpf-next/c/86fd166575c3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


