Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B012C3927
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 07:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKYGkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 01:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgKYGkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 01:40:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606286405;
        bh=6eErYdnx0gf2MUOcVHAQD0zOVWGr2xWNUI69v6XmvEg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=xrEWqyEMmvr0rkd3BRq3Udtjb0U9p4xjInn1jwmz+uA33ZF/XI8eMhOj2OCmfwJUs
         P/mMWhAWtzdmmG0/X5u3SV58c3R7fWX1fo5kcpAurRyC60xbgXCgqVp4SsgRMtIZgW
         K25mg/46VXtrq59rHerbo+eSZ72tjzHMjCSngu4E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Refactor check_cfg to use a structured loop.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160628640579.28615.11585037315162851613.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Nov 2020 06:40:05 +0000
References: <20201121015509.3594191-1-wedsonaf@google.com>
In-Reply-To: <20201121015509.3594191-1-wedsonaf@google.com>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 21 Nov 2020 01:55:09 +0000 you wrote:
> The current implementation uses a number of gotos to implement a loop
> and different paths within the loop, which makes the code less readable
> than it would be with an explicit while-loop. This patch also replaces a
> chain of if/if-elses keyed on the same expression with a switch
> statement.
> 
> No change in behaviour is intended.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Refactor check_cfg to use a structured loop.
    https://git.kernel.org/bpf/bpf-next/c/59e2e27d227a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


