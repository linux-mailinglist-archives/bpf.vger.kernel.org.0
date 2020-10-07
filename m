Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0530E28668E
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJGSKD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 14:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgJGSKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 14:10:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602094202;
        bh=iv0BZvfd7Iqr4e2ttdddrvkmVqMF7S9tvdticLu8KiQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BLJhl4IOOwPyA61azY0CNMEKqPMm7qDovnpFCeQK2oHihYI3O9KFsRB0ceA3wIMbc
         Za5/87h7WGxdCUXxqUis/0YhzPRixHUH1mvm4EMjFrzBCQgynTBC/6Zk3lzVZFNn64
         ATwLbEW2X1zoZRrz0Wcz0dp1sQVszwQl2XnkN/XU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix typo in uapi/linux/bpf.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160209420276.11533.2443861869389376855.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Oct 2020 18:10:02 +0000
References: <20201007055717.7319-1-jwilk@jwilk.net>
In-Reply-To: <20201007055717.7319-1-jwilk@jwilk.net>
To:     Jakub Wilk <jwilk@jwilk.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        ferivoz@riseup.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 7 Oct 2020 07:57:17 +0200 you wrote:
> Reported-by: Samanta Navarro <ferivoz@riseup.net>
> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
> ---
>  include/uapi/linux/bpf.h       | 2 +-
>  tools/include/uapi/linux/bpf.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - bpf: Fix typo in uapi/linux/bpf.h
    https://git.kernel.org/bpf/bpf-next/c/49f3d12b0f70

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


