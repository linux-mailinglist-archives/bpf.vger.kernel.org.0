Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DD31C428
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 23:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBOWus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 17:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhBOWus (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 17:50:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D32F364DEB;
        Mon, 15 Feb 2021 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613429406;
        bh=wberMFEnSGaF2kj2ZWq/YVi2Gab4GSTZKJc2EH06e/Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HN2HYuhVm6k4/8G358EAI/pShNM/IDnxvNUuanosR3HPCeaCYjZ006jcrK05wkGUG
         EdhkVaxyL+sadDEHkOGcksemY4vNVqKrCINmqEmL1iDrdC6owy1vl/PHibIsluh+0a
         5POkFPOHzsx5F28PXY+eJQFG/kvpSsSjFr8Hdk4REvnJ5Nq0gQrf8K3CjqEX8swMwc
         9mYBimkxSqYOxSPme3WL0dWqrhU4s+kue2eV1pAlMadHw6bPq+jAxrx59+HIy0zuGU
         bHObjg8L023VQyc61PoyrukEopLUymeQNMBy8f3DrOwpQ+KNcIvo6uszWMdERIDSlI
         BQQHZHmBz3DUg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C7A25609CD;
        Mon, 15 Feb 2021 22:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Clear subreg_def for global function return
 values
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161342940681.30268.15062715415233728366.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Feb 2021 22:50:06 +0000
References: <20210212040408.90109-1-iii@linux.ibm.com>
In-Reply-To: <20210212040408.90109-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        yauheni.kaliuta@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 12 Feb 2021 05:04:08 +0100 you wrote:
> test_global_func4 fails on s390 as reported by Yauheni in [1].
> 
> The immediate problem is that the zext code includes the instruction,
> whose result needs to be zero-extended, into the zero-extension
> patchlet, and if this instruction happens to be a branch, then its
> delta is not adjusted. As a result, the verifier rejects the program
> later.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Clear subreg_def for global function return values
    https://git.kernel.org/bpf/bpf-next/c/45159b27637b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


