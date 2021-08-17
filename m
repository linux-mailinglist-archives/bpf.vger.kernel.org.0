Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAD3EE169
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 02:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhHQAkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 20:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236610AbhHQAki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 20:40:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BED5C60240;
        Tue, 17 Aug 2021 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629160805;
        bh=5vTwb3thMounKV5San9j43N96GxmOjUZsXOwFW4/U0w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J0zyB/QQ8dRbQEADWMPTQJbyPI6tp9lfUt/N/xLhrt5g3hynm/RB5aHJgGpWd+iEB
         jLS342GBXXAP3/+zRndvYx+TV8Be5lwX/Z1egz+WALzyIerm/QZdRTTTg7ws6Ogsdl
         P2+BqQ6wfPVal95XRW9YuWLXAUrKwMv1phqhTbcseCU6ePX5LVtFflvcCKJs7aAlcr
         tHkQUC0Rw38tBYYhjmoxkmHNW66fYtggKSpF1MLY6iYH0LzYvdLyz+2Amv0Rb7bhm1
         EG/4BmyZI4N8PjA+JtO43vCXSj6Rk5i/C2D9xV6g664TwZYAgdTIQIS8GqFQK3FlON
         tsDnnnWfLO/xA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2A4460989;
        Tue, 17 Aug 2021 00:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: Reconfigure libbpf docs to remove
 unversioned API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162916080572.22028.5435416406707924221.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Aug 2021 00:40:05 +0000
References: <20210810020508.280639-1-grantseltzer@gmail.com>
In-Reply-To: <20210810020508.280639-1-grantseltzer@gmail.com>
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  9 Aug 2021 22:05:08 -0400 you wrote:
> This removes the libbpf_api.rst file from the kernel documentation.
> The intention for this file was to pull documentation from comments
> above API functions in libbpf. However, due to limitations of the
> kernel documentation system, this API documentation could not be
> versioned, which is counterintuative to how users expect to use it.
> There is also currently no doc comments, making this a blank page.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: Reconfigure libbpf docs to remove unversioned API
    https://git.kernel.org/bpf/bpf-next/c/bb57164920d7

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


