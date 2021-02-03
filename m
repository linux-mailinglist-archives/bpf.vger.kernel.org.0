Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AF730E764
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 00:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBCXas (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 18:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233353AbhBCXar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 18:30:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C196864E49;
        Wed,  3 Feb 2021 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612395006;
        bh=gtcZIzYHKdHLypnVN4aiPuEX1180RcVtHz+AuQNPCW0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J7lV4pfT280S1/+P55kRC1mCDABOeMAyVie9FutgV9/tBUNYcq3FhCe10V6dT6w61
         iB2jsFv2gAg8JEQIxGTSFADCgk/5EK8Zmt5GhLcGnXhVm8z/tdLB+Oaq2Ia99/4W9F
         RpJ9mx9b1ptvyB2Ct6TkNKLhtcMt555IywBoe2ynn30kn+Km5fEnxghteU8OM1e7bR
         nsHQQ+VLkdHE3tzjCkPMZcUjhNDnpAFjR848xW7xYuMLG+Xn9UI0jTYdtYG6B3LEJv
         JjJMSHlc37Qa8iSPDjkj0pY6L+dUv8ycdRG75XV0BZDK1kfb+GkaVvmRXyFv55vu9M
         BALahYfl8OBRg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B53D9609E3;
        Wed,  3 Feb 2021 23:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftest/bpf: testing for multiple logs on REJECT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161239500673.24728.11168194942696623869.git-patchwork-notify@kernel.org>
Date:   Wed, 03 Feb 2021 23:30:06 +0000
References: <20210130220150.59305-1-andreimatei1@gmail.com>
In-Reply-To: <20210130220150.59305-1-andreimatei1@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 30 Jan 2021 17:01:50 -0500 you wrote:
> This patch adds support to verifier tests to check for a succession of
> verifier log messages on program load failure. This makes the
> errstr field work uniformly across REJECT and VERBOSE_ACCEPT checks.
> 
> This patch also increases the maximum size of a message in the series of
> messages to test from 80 chars to 200 chars. This is in order to keep
> existing tests working, which sometimes test for messages larger than 80
> chars (which was accepted in the REJECT case, when testing for a single
> message, but not in the VERBOSE_ACCEPT case, when testing for possibly
> multiple messages).
> And example of such a long, checked message is in bounds.c:
> "R1 has unknown scalar with mixed signed bounds, pointer arithmetic with
> it prohibited for !root"
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftest/bpf: testing for multiple logs on REJECT
    https://git.kernel.org/bpf/bpf-next/c/060fd1035880

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


