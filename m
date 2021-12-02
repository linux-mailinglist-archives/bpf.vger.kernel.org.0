Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFD466CB6
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 23:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbhLBWdq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 17:33:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349556AbhLBWde (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 17:33:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9B47B823B4
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 22:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68F0BC53FCC;
        Thu,  2 Dec 2021 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638484209;
        bh=Me4BcOUBdkRKumacOI2mGu5Ii6teJhXznFi2L0yGS+c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T3UdGGNq5twRk926mj+ohz4gXwvlLKMuNXmLr64seUD8CJAOUwRMaKS7YgGW1Cqrt
         19S26I/ih9Dz+mXXz+lQ8OFhMzbXy3cs0lX5MyMMtV21v2Z2KBEDqomKfJ/La7+GEs
         AT5cdsGyrkefqFrAV6vF0MToi+4xvFhjSk8q7kwMjFgZv1plfNnP3iBJiEfPMICQ5d
         4MEZVkUcM308KCqKC/veXSFWfI5zy6OqieMrkQ2JWE3DUtANTe9GvkCxwYU+MDsy+d
         8pYJc2q4C6RfyFQTZxyigzQlm4fgbmyjoOr50ysmp6P3Mjjjuuq57ZIJDz4ehEgCor
         ePzMnUEWZJ8Dg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4B5A260A90;
        Thu,  2 Dec 2021 22:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/3] Fixes for kfunc-mod regressions and warnings
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163848420930.10462.16137132346374553687.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Dec 2021 22:30:09 +0000
References: <20211122144742.477787-1-memxor@gmail.com>
In-Reply-To: <20211122144742.477787-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 22 Nov 2021 20:17:39 +0530 you wrote:
> This set includes fixes for two regressions and one build warning introduced by
> the kfunc for modules series.
> 
> Changelog:
> ----------
> 
> v1 -> v2:
> v1: https://lore.kernel.org/bpf/20211115191840.496263-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/3] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
    https://git.kernel.org/bpf/bpf/c/d9847eb8be3d
  - [bpf,v2,2/3] bpf: Fix bpf_check_mod_kfunc_call for built-in modules
    https://git.kernel.org/bpf/bpf/c/b12f03104324
  - [bpf,v2,3/3] tools/resolve_btfids: Skip unresolved symbol warning for empty BTF sets
    https://git.kernel.org/bpf/bpf/c/3345193f6f3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


