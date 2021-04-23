Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8B368E39
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 10:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhDWIAr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 04:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhDWIAp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 04:00:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B3F5D6145A;
        Fri, 23 Apr 2021 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619164809;
        bh=ZuoU7Dpj21I2gk03eBmKNM8A6lHCRJLE3NklndJE4GY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HpkeiUuwu6ciRmJDQ3Lojt+s18utJS0TJFwibXSitYSCSpDRr2FL4W69CV5t9nCFc
         GoYbI43ZMU5FcfXwUjiM4YYYU0eYZgz3JQUfFyJwS46bs6dBdAfoCRiHzNPfMkLZGd
         ohfQ9oKOEdE5V6/rytF/ra0PuWRlLlaIjCYF6+tK9t8EglltupDKDlaWMNUTJO0DpO
         NfylDqYmn6bM43Dx88W7TZEbeqIOaP4j2c1tNdyEI6ttmFREarZpCNPXWJ6Cd4MEMM
         2a9GXBUOwj84+SAVC+WdC2E8kSWVw6GLrUPYNPfwQ0f3XiSd3xxoO0KIQYUtzzxOSF
         9zKi70rZGyv+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA91860A52;
        Fri, 23 Apr 2021 08:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] xsk: align xdp socket batch size with dpdk
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161916480969.23462.10621703969559885966.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Apr 2021 08:00:09 +0000
References: <1618378752-4191-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1618378752-4191-1-git-send-email-lirongqing@baidu.com>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     bpf@vger.kernel.org, magnus.karlsson@intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 14 Apr 2021 13:39:12 +0800 you wrote:
> DPDK default burst size is 32, however, kernel xsk sendto
> syscall can not handle all 32 at one time, and return with
> error.
> 
> So make kernel xdp socket batch size larger to avoid
> unnecessary syscall fail and context switch which will help
> increase performance.
> 
> [...]

Here is the summary with links:
  - xsk: align xdp socket batch size with dpdk
    https://git.kernel.org/bpf/bpf-next/c/e7a1c1300891

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


