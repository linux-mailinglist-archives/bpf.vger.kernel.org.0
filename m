Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0802815BE
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbgJBOuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 10:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388002AbgJBOuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 10:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601650202;
        bh=/oi4t6O4+8UbXf5rf8wLnbq+N0Rp5nNDrAwKT7wdmPI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M18on/MAK7m+a6Tk68VEKmahJCdKY4bWb36YZ8NPOj8gPVNQtWZQPRHw/+/CgPR00
         JjGWC3AJzitpNLP8gZBCgmBHOmS1lFVuGQgEgUsoQ8vZ+sXtmDxK7x77Jl4pmnNumN
         Fm7cbSSMvyHYUO5b7MNiKisUm8/3ABc41c74N92E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: initialize duration in xdp_noinline.c
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160165020271.24758.13755402807472066757.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Oct 2020 14:50:02 +0000
References: <20201001225440.1373233-1-sdf@google.com>
In-Reply-To: <20201001225440.1373233-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  1 Oct 2020 15:54:40 -0700 you wrote:
> Fixes clang error:
> tools/testing/selftests/bpf/prog_tests/xdp_noinline.c:35:6: error: variable 'duration' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (CHECK(!skel, "skel_open_and_load", "failed\n"))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: initialize duration in xdp_noinline.c
    https://git.kernel.org/bpf/bpf-next/c/cffcdbff70a3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


