Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4D4578DE
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 23:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhKSWnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 17:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232763AbhKSWnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 17:43:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8A0AF61A8A;
        Fri, 19 Nov 2021 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637361609;
        bh=/FD9gL/7vWvswKvvwmwRhKM0kNBuDEilzi6stNqQDto=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AhfRX57YVq39dNmAfFs61qoqMFjxHIC58jzwMOML2Hoj8lsm/wlQ2cHJkk9p20PW1
         JSpVRstDe/bdCqqkb8clrgDdvWPFd8h9ZXLy3USgpF/FFD8u/S8gRXrtKP/DWpw64z
         bYxN4k07NaySTylP7fVAA103R5zfF6xyPHIrRJKVu2PU1u41IJngfVrv6zGkytemBS
         41U/CoOi4ozRXZFMYQvKZg+h2wRXU/yIEdhMxKaDMm/IXSLz0EKZB3RLH5x7ArphvA
         Fppo9YfI5K7A8CdXmXm3dXzkhsmkS+9qXArUdPyW/lasNQkdFMsZvzCdhbBG+hzIw9
         nFXrovaWTJhRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 73E2E60A0F;
        Fri, 19 Nov 2021 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Change bpf_program__set_extra_flags to
 bpf_program__set_flags
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163736160946.15591.12308965377784659441.git-patchwork-notify@kernel.org>
Date:   Fri, 19 Nov 2021 22:40:09 +0000
References: <20211119180035.1396139-1-revest@chromium.org>
In-Reply-To: <20211119180035.1396139-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kpsingh@kernel.org,
        jackmanb@google.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 19 Nov 2021 19:00:35 +0100 you wrote:
> bpf_program__set_extra_flags has just been introduced so we can still
> change it without breaking users.
> 
> This new interface is a bit more flexible (for example if someone wants
> to clear a flag).
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Change bpf_program__set_extra_flags to bpf_program__set_flags
    https://git.kernel.org/bpf/bpf-next/c/8cccee9e91e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


