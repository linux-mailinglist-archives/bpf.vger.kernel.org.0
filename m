Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC182E7152
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 15:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL2OUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Dec 2020 09:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgL2OUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Dec 2020 09:20:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3EC8C207D1;
        Tue, 29 Dec 2020 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609251606;
        bh=ppFpc8YpWiFuiGCE+BmBJKur35Hz2jpCudL4Gvg0byc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CrcjYf6oT5DIZi4+xkKsUv61G3D4kNJStq58ZZm9Tck3Q0EQGMOd+2W6R2I+5dnmP
         gRc8A0wQk8JiRMdVeWCtX2o7UIaUoy/yteDVIhPQ64aO2M/zn4iIaFwXoZdSJq1FR0
         QWvQWeqNxTaVp5pDXytyu6U1Dq7rel7x8n2SAXHVd6W2jNd0u9TQTRQXoS7nAS2jQ+
         tg31hSubY7xrlrjVqQzOLRxhKql5QVeYFlZUaVQGUN5u6DdUrravG+bmZ82KflFuLq
         7huJ+uwJM1MyVV3YPernjh7G49CWJEZH7Ez8Ikp9oFbDPtJgrbuQP2Vodd29wTLvgF
         PcKvhxoaZSAKg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 34009604D7;
        Tue, 29 Dec 2020 14:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Remove unnecessary <argp.h> include from
 preload/iterators
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160925160620.2585.17801325123968170711.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Dec 2020 14:20:06 +0000
References: <20201216100306.30942-1-leah@vuxu.org>
In-Reply-To: <20201216100306.30942-1-leah@vuxu.org>
To:     Leah Neukirchen <leah@vuxu.org>
Cc:     bpf@vger.kernel.org, hayashi.kunihiko@socionext.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 16 Dec 2020 11:03:06 +0100 you wrote:
> This program does not use argp (which is a glibcism).
> Instead include <errno.h> directly, which was pulled in by <argp.h>.
> 
> Signed-off-by: Leah Neukirchen <leah@vuxu.org>
> ---
>  kernel/bpf/preload/iterators/iterators.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpf: Remove unnecessary <argp.h> include from preload/iterators
    https://git.kernel.org/bpf/bpf-next/c/1bcf3a740aa5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


