Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5C4465BD
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 16:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhKEPcv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 11:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233534AbhKEPct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 11:32:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B7F8261245;
        Fri,  5 Nov 2021 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636126209;
        bh=xO1vtH/aB1pY9x3l6oFYwuDyZqqGOwUDt6tt1zxyz0I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m1F2syVetXmhPbLrAT3bICGw1g8DdpQwD8FyHYpDU85CR1xwu3ALVWsVoj5xMwKxq
         f0zcsGNORG75cGU2YUyp7QWn3nJ1RgZtFArHCNbfVluTXWHT+cmQq0FPFOhjfgDCxE
         GEU+m4Mr8gn5d4lrJRDJp/6TC/OSguMI6ReYMkVZe71R3W1oE9kz5W67wEuVfOFjsQ
         Vv7cYe8/t3E2KdmT8v24n8EC7a6+PgovCFP/+hY9/2NmI30vyvOc8PdJ4hGMwcN6hk
         S2OiHEVa/WpIt7v/5MK8qnDOJhoWs7wMDXRttRbeP5gUE5Y3XVMfZLekgXP0Ponk9Q
         clTlcLFZG9x3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A7BBB60A02;
        Fri,  5 Nov 2021 15:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix lookup_and_delete_elem_flags
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163612620968.29979.563625301020759868.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Nov 2021 15:30:09 +0000
References: <20211104171354.11072-1-arshad.rad@gmail.com>
In-Reply-To: <20211104171354.11072-1-arshad.rad@gmail.com>
To:     Mehrdad Arshad Rad <arshad.rad@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Nov 2021 10:13:54 -0700 you wrote:
> Added libbpf_err_errno to bpf_map_lookup_and_delete_elem_flags
> 
> Signed-off-by: Mehrdad Arshad Rad <arshad.rad@gmail.com>
> ---
>  tools/lib/bpf/bpf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - libbpf: Fix lookup_and_delete_elem_flags
    https://git.kernel.org/bpf/bpf/c/64165ddf8ea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


