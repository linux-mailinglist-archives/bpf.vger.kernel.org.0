Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514D3326956
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 22:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZVUt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 16:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhBZVUs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 16:20:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DB63B64F13;
        Fri, 26 Feb 2021 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614374407;
        bh=dh0Te//gzE+Y13L2iee6uh6dEQPOp5QdXSt31Wl0YLo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JMwcwYoVBoC7Usa7HyzKUx10gfuS95LpCxKvbeFBd25Dl0Ms2jEL8TJvlj34h4km5
         qpUkFG87MdsFCJE/+DyzHJXNOi8abfI507r5972wt1jY80wERY6ytFazGNNjarosf8
         HrzLztUL/RpY7dNHSjaJM2/UgunB+LchNGZjolqrIeEuIR45B3TyPajztrozKLI+Ar
         Ui4kevNa3WvtWH3dO6QUEX7wv+x8/7L1PmUCU2Y0ZFLpX43RUnujzdxLkk3Ky2ch1A
         MsM5v3cph+XeFLORuJT+Giz1wC0WVHlkMqvQX/8yqiPQ1kAkWqrj7sXsnvVcSACk8u
         S9rW8yq2sR2Ow==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CFFD360A16;
        Fri, 26 Feb 2021 21:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Propagate error code of the command
 to vmtest.sh
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161437440784.26505.14457726843836860385.git-patchwork-notify@kernel.org>
Date:   Fri, 26 Feb 2021 21:20:07 +0000
References: <20210225161947.1778590-1-kpsingh@kernel.org>
In-Reply-To: <20210225161947.1778590-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, revest@chromium.org, jackmanb@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 25 Feb 2021 16:19:47 +0000 you wrote:
> From: KP Singh <kpsingh@google.com>
> 
> When vmtest.sh ran a command in a VM, it did not record or propagate the
> error code of the command. This made the script less "script-able". The
> script now saves the error code of the said command in a file in the VM,
> copies the file back to the host and (when available) uses this error
> code instead of its own.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Propagate error code of the command to vmtest.sh
    https://git.kernel.org/bpf/bpf-next/c/2854436612c4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


