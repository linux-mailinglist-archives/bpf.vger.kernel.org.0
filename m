Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD4426403
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 07:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhJHFWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 01:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhJHFWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 01:22:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 03F4561073;
        Fri,  8 Oct 2021 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633670407;
        bh=EJQTs1ZXRRGjKN7aNvpJkjRBFCTGpbkj8Jt4fkPvcuo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lhMQIjuc8/8QZslz0X4A7HkaiiOPTEPnbzr1C+sPvqO3wNcUGPNhVrSPUU2Qb9oJ5
         2s4ZuMTc27dpytu1U1A3omvKVS00iC7aXmAEIv+4+XjFbF118jvc+V3gbFp168drhT
         Umc+0vpVeRQFLVPVGmpzya1PBGreurA7idcM2W5dG4/zfSt82gB+a/wuyUS7a2GeXX
         iANwLOEerRfS4NCDubrusvW6OJWyM4sWJNMyE5KeDKxpMRBZwOk7b8E8ffYZos/etU
         XyYq+pYZ1i4oMhrE9zal8i4cX0jH/wTdKgRxgjDTQnvr0Wv86Iahlw2jDcsjNT33sL
         bl/iDXui5xtBw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E6CFF60A38;
        Fri,  8 Oct 2021 05:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: remove SEC("version") from test
 progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163367040694.11900.7333932215969301935.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Oct 2021 05:20:06 +0000
References: <20211007231234.2223081-1-davemarchevsky@fb.com>
In-Reply-To: <20211007231234.2223081-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 7 Oct 2021 16:12:34 -0700 you wrote:
> Since commit 6c4fc209fcf9d ("bpf: remove useless version check for prog
> load") these "version" sections, which result in bpf_attr.kern_version
> being set, have been unnecessary.
> 
> Remove them so that it's obvious to folks using selftests as a guide that
> "modern" BPF progs don't need this section.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: remove SEC("version") from test progs
    https://git.kernel.org/bpf/bpf-next/c/dd65acf72d0e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


