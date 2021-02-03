Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142A230D314
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 06:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBCFau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 00:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhBCFat (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 00:30:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8CDCF64F68;
        Wed,  3 Feb 2021 05:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612330208;
        bh=kFm9eg7t+co0bNyLPe6N2TpuUTpYZ37UxH4h4HkrhiE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pSpJ8sW2h4jVqgeNKMbz41XNN7qN3+9EExB7YE7N3gDDfrMJNs8DaQkhIkDvdPLB7
         k3SvaxBIkCEf+BpaIyYUjMlaw3K9VjywRymcmT7+zxF20Azk5dBt+gevO+9Mi6XU7y
         mgklrCsNriuooi9/q8rejLhuG1row9oXlNmbx0EfxxKy3XwpK74LRNHZVNHYLwXZF9
         p6bLlfAO8aIiFKSeUWuaMxa/fRMctQbku8QDNLW5JjnupAnG11XvtbrMUGIyPQ0eWR
         LybgVWod+jUkj1ySl4prClSMFGO/0nF0h7YVtZtb2UUBCi5u4/VnXmycsASf0Fosyt
         yBGvzDRwvqCJQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7A2B6609CE;
        Wed,  3 Feb 2021 05:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Fix a compiler warning in local_storage
 test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161233020849.23363.1881396301735012274.git-patchwork-notify@kernel.org>
Date:   Wed, 03 Feb 2021 05:30:08 +0000
References: <20210202213730.1906931-1-kpsingh@kernel.org>
In-Reply-To: <20210202213730.1906931-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, revest@chromium.org, jackmanb@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue,  2 Feb 2021 21:37:30 +0000 you wrote:
> Some compilers trigger a warning when tmp_dir_path is allocated
> with a fixed size of 64-bytes and used in the following snprintf:
> 
>   snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
> 	   tmp_dir_path);
> 
>   warning: ‘/copy_of_rm’ directive output may be truncated writing 11
>   bytes into a region of size between 1 and 64 [-Wformat-truncation=]
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Fix a compiler warning in local_storage test
    https://git.kernel.org/bpf/bpf-next/c/15075bb7228a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


