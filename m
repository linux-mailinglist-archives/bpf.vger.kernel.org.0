Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE503B3041
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhFXNmX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 09:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhFXNmW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 09:42:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B37C0613DC;
        Thu, 24 Jun 2021 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624542003;
        bh=8200jJar8YhGhKF5JuraOSmsv2NeCaSFWxQjEgXS1rs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jxbuHlMEVW7BI0PNQOJgwYPGhgUb+KC+g1Qd3Jv3101L7aXpRdQ1BU1ljR57QmpNB
         ODiyD8bPvY/mVXE2b1QCQ5hyW7hvc3C5kqeIfisFqXJFhpX8jLhGYHfNmJvoWopvfv
         UXo0ySMDPPbLl2KKVkHy/k74lzyZsEVc+q09a1HeN11dKRlYhhGxdtBzT1G4VhgY1l
         bribe6PGj7aDgKve+mVAcjK04DwpXLrypKpWRZY2nrFQawB0vRrXx8TXhFZYjexuNl
         QzNGzPrdaj8hICKEBY9N0MUodLiIbASddrCHLxgVk9K7/koMGL7AEGLD3CIxwbSy2r
         yt2261FHdgQZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A443E60978;
        Thu, 24 Jun 2021 13:40:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] media: bpf: do not copy more entries than user space
 requested
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162454200366.13710.10179869349829486025.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Jun 2021 13:40:03 +0000
References: <20210623213754.632-1-sean@mess.org>
In-Reply-To: <20210623213754.632-1-sean@mess.org>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 23 Jun 2021 22:37:54 +0100 you wrote:
> The syscall bpf(BPF_PROG_QUERY, &attr) should the prog_cnt field to see
> how many entries user space provided and return ENOSPC if there are
> more programs than that. Before this patch, this is not checked and
> ENOSPC is never returned.
> 
> Note that one lirc device is limited to 64 bpf programs, and user space
> I'm aware of -- ir-keytable -- always gives enough space for 64 entries
> already. However, we should not copy program ids than are requested.
> 
> [...]

Here is the summary with links:
  - media: bpf: do not copy more entries than user space requested
    https://git.kernel.org/bpf/bpf-next/c/647d446d66e4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


