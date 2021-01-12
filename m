Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD12F3410
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbhALPUt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbhALPUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:20:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B91A523110;
        Tue, 12 Jan 2021 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610464808;
        bh=q0kYcPhTuGCwCpFDXCcX8McWJv/3S0TLTqVJlqZp5eY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ljNvzb7yZLlCEgAZO4MJTpTSNVUjWawBBuLPlXHZe7wmWbj+2DpbH3PeKnzmSrXgF
         excpT0GxmcDciCbS/BytqoWUIBthY2IbS8+YEr3DeDMwyknk2AinjDE+OhE2eV4Svs
         ZueXNUt8O7eVsUXq5QV5OBW7h+AlAPdPttazCMSwy/OodN+yKhx0ERisFcSVIbC4fU
         0zoKviYCWBcPRK4lBNmw1SdIKHDLejMdfdVSW8IxfxHGGzFDqnRqX6xB4i8iuPGB8B
         EFrXXX/g6cS2GNI0kKiGuIp8ZrxDX4eRilXNqvOndhWcOhKRIPQuvSRo6pPiyP2939
         BWrxP8WqIO6eQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id A8DE660116;
        Tue, 12 Jan 2021 15:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] Fix local storage helper OOPs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161046480868.31401.17966144833412187769.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Jan 2021 15:20:08 +0000
References: <20210112075525.256820-1-kpsingh@kernel.org>
In-Reply-To: <20210112075525.256820-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Tue, 12 Jan 2021 07:55:22 +0000 you wrote:
> # v2 -> v3
> 
> * Checking the return value of mkdtemp intead of errno
> * Added Yonghong's Acks
> 
> It was noted in
> https://lore.kernel.org/bpf/CACYkzJ55X8Tp2q4+EFf2hOM_Lysoim1xJY1YdA3k=T3woMW6mg@mail.gmail.com/T/#t
> that the local storage helpers do not handle null owner pointers
> correctly. This patch fixes the task and inode storage helpers with a
> null check. In order to keep the check explicit, it's kept in the body
> of the helpers similar to sk_storage and also fixes a minor typo in
> bpf_inode_storage.c [I did not add a fixes and reported tag to the
> patch that fixes the typo since it's a non-functional change].
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] bpf: update local storage test to check handling of null ptrs
    https://git.kernel.org/bpf/bpf/c/2f94ac191846
  - [bpf,v3,2/3] bpf: local storage helpers should check nullness of owner ptr passed
    https://git.kernel.org/bpf/bpf/c/1a9c72ad4c26
  - [bpf,v3,3/3] bpf: Fix typo in bpf_inode_storage.c
    https://git.kernel.org/bpf/bpf/c/84d571d46c70

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


