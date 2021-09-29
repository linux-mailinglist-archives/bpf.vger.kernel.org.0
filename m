Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE79341C9D1
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344482AbhI2QME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 12:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345737AbhI2QLr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 12:11:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A5B5A615A7;
        Wed, 29 Sep 2021 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632931806;
        bh=/ptdvfEiN8K3rp/cuu9j/cz3lCVfvtVQ13O8tt5Kohc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DVwdpKSQmgCE9PmJd2EGp7jiRN5AyWR/pMXSIWM4WnethFLX/KOLXKmi1LWV9kOyA
         J10wrTrJHCVVv9qnWRh7CVfK9P9AoEB0OcnHLpmXpZAqmvDFBrYgiaqwZwcDLJdSoM
         Y7f2Tep6a4rS53GEdIs+PnXifYRH0mKG2CY7BLObyUl+mAwI204SkFwM+OZpKaZh0p
         D4qWuApQ2m6F33dYnvuPiWQypE3I+deWRn2F15rk0poTUzGJo8esA+FTkqO75aCQNt
         U68Zy0Kq6b8pEoz2EZLPyITJR25Vbjs7qgJE6rqhaOr8D2b2hx+QLFYvE9oANoHYF3
         IRtYTnhzJop+g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9AAD3609D6;
        Wed, 29 Sep 2021 16:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163293180662.13147.6555296992871982703.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Sep 2021 16:10:06 +0000
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
In-Reply-To: <20210923000540.47344-1-luca.boccassi@gmail.com>
To:     Luca Boccassi <luca.boccassi@gmail.com>
Cc:     bpf@vger.kernel.org, bjorn.topel@intel.com, jackmanb@google.com,
        jiong.wang@netronome.com, jakub.kicinski@netronome.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, daniel@zonque.org,
        fengc@google.com, joe@ovn.org, jbacik@fb.com, bluca@debian.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu, 23 Sep 2021 01:05:40 +0100 you wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> libbpf and bpftool have been dual-licensed to facilitate inclusion in
> software that is not compatible with GPL2-only (ie: Apache2), but the
> samples are still GPL2-only.
> 
> Given these files are samples, they get naturally copied around. For example
> it is the case for samples/bpf/bpf_insn.h which was copied into the systemd
> tree: https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h
> 
> [...]

Here is the summary with links:
  - samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR BSD-2-Clause
    https://git.kernel.org/bpf/bpf/c/d75fe9cb1dd0

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


