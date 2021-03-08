Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E3331658
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCHSkO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 13:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhCHSkH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 13:40:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8025C6521D;
        Mon,  8 Mar 2021 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615228807;
        bh=E3ivQYbanreAqZByVqNRhjNX9eY2vCqpBh4CQ+9n+YM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vOxwrkvDQdOoyrrXTRGeeWBQSTCLgc9zY6roxoMOE6sMuacxo8opz2XgQMaMIr8O0
         iss2d29dJCNzoHtgZcvNY+l3TUwkXw3apf3jcbromVnNUWd+tnKJXeTQ8jw3v3hnuo
         26+jZk9+DTuFU5Maae+cPLz5xLSE7qFpzzLlgvCkfNEaTBxcUDQ01K8gAU4AaaFeD3
         23xbNcA5vTgGHSORc3r564ctjFPuR/bptvLRM6eIdN+EgnzbPgQ6DtBZVoZtwE+vWh
         izcC7yj0IaUh8PRtVfmL8fnPkUajE+CAEudCiSidXaK/MnWGOC5IulumBIqd8MLI5I
         QrGB1a1u5E/WQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 769FD609DA;
        Mon,  8 Mar 2021 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix arm64 build
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161522880748.17587.18109795982121902155.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Mar 2021 18:40:07 +0000
References: <20210308182521.155536-1-jean-philippe@linaro.org>
In-Reply-To: <20210308182521.155536-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, bjorn@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  8 Mar 2021 19:25:22 +0100 you wrote:
> The macro for libbpf_smp_store_release() doesn't build on arm64, fix it.
> 
> Fixes: 60d0e5fdbdf6 ("libbpf, xsk: Add libbpf_smp_store_release libbpf_smp_load_acquire")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/lib/bpf/libbpf_util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: Fix arm64 build
    https://git.kernel.org/bpf/bpf-next/c/a6aac408c561

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


