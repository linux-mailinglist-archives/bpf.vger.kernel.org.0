Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BC03241BF
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhBXQIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 11:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235537AbhBXPuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 10:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 51C1B64EC4;
        Wed, 24 Feb 2021 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614181807;
        bh=BYToIXM71CMKSR1D7DI/0UdPyJL+YvSFifWHVgSPG5I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kjev7EEw4gx6f1bUHogXrfyjOfWWAyTf9cx8Zo2AK8Iej0dlYrahNWCjF8m30ilWU
         vF+Vx7PzNpMxnt/Uje/v1xAdf4Q1jmIrhkDYK58li2bhb+blKZEyHm/KUdx3Eui180
         k3HKEe/Ug8mI/FY/IKRTBUfGtM1cdtkFZ2cpzzDRpfAbxPquv3ZAoVmZNjfJWjo5l+
         qc0W67ugGv7K9Hnq0OKtbjJOC/mCokzYeOO2zhGSm9d0jsqaXkCdUWW6MjGrWImVyt
         jEQ7nQqqtf3ymZdCiR9aUt+y3UsPt6bzgidUHqZAunuUVxymBqVkp4aBYXX4koJbSu
         /5Pxjl4hZBzEg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 41067609F5;
        Wed, 24 Feb 2021 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Drop imprecise log message
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161418180726.1820.13683950814687200129.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Feb 2021 15:50:07 +0000
References: <20210223090416.333943-1-me@ubique.spb.ru>
In-Reply-To: <20210223090416.333943-1-me@ubique.spb.ru>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, rdna@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Tue, 23 Feb 2021 13:04:16 +0400 you wrote:
> Now it is possible for global function to have a pointer argument that
> points to something different than struct. Drop the irrelevant log
> message and keep the logic same.
> 
> Fixes: e5069b9c23b3 ("bpf: Support pointers in global func args")
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Drop imprecise log message
    https://git.kernel.org/bpf/bpf/c/f4eda8b6e4a5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


