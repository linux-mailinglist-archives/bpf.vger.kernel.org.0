Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB154852F1
	for <lists+bpf@lfdr.de>; Wed,  5 Jan 2022 13:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiAEMkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 07:40:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51434 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiAEMkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 07:40:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 921ECB81AAE
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 12:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41932C36AEB;
        Wed,  5 Jan 2022 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641386416;
        bh=5X0mcBQQvtUnQDJTVSbnQ/LITXP0ujO2OP74iNQ+6HI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IHx9N8Q8U7uaFrrBYf+3YICfgv6kDiZNo7TrrGP20y9QEKqAVy+/iiaO/WIlx2U0m
         dstu2rZqkHs4YsoyjpvRxezqsauP0lTAsaMKdLK6HhVw+tR8XQg4IjrSKB/QG+5yjJ
         cp52SJAN74Xk8o4uH4R43/0EFjdLC7J3ATq6RN6jw8U1DB8n7iVgQA8AH1XTJ7C1WP
         mxL9qPBG6nnceYEmchzBSWcyCw40KnMcCpnXTUvd0yVT6CIJct2BV6ssTxzQRjZL2I
         o6oisrrW3cHw6vlJlXPmE+reJGN62krIl0rSo04UjYNWaJnR/xJbAlZyu0PkrD1t00
         DCuxFKCOLBp3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26647F79408;
        Wed,  5 Jan 2022 12:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpftool: Probes for bounded loops and
 instruction set extensions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164138641615.6231.4937030135518900608.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jan 2022 12:40:16 +0000
References: <cover.1641314075.git.paul@isovalent.com>
In-Reply-To: <cover.1641314075.git.paul@isovalent.com>
To:     Paul Chaignon <paul@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, quentin@isovalent.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 4 Jan 2022 18:57:54 +0100 you wrote:
> This patchset adds feature probes for bounded loops and instruction set
> extensions. The first patch refactors the existing miscellaneous probe
> to avoid code duplication in subsequent patches.
> 
> The four miscellaneous probes were tested on kernels 4.9, 4.19, and 5.4.
> 
> The feature probe for bounded loops was previously submitted as part of
> patchset https://lore.kernel.org/bpf/20211217211135.GA42088@Mem/T/.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpftool: Refactor misc. feature probe
    https://git.kernel.org/bpf/bpf-next/c/b22bf1b9979a
  - [bpf-next,2/3] bpftool: Probe for bounded loop support
    https://git.kernel.org/bpf/bpf-next/c/c04fb2b0bd92
  - [bpf-next,3/3] bpftool: Probe for instruction set extensions
    https://git.kernel.org/bpf/bpf-next/c/0fd800b2456c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


