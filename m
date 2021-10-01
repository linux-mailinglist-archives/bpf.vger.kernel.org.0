Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9006941F695
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhJAVBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhJAVBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 17:01:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9DABA61A10;
        Fri,  1 Oct 2021 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633122007;
        bh=EJiG5IBMExtRsXTByU6kQOvFk0Hcko4NzNCq/LQRFlo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MAP9O5zmEkcdP93ghzm54rcJ/WQiaAxFGhujNtzUSGCbrFPO4PA0ZHOhYkQttVWRT
         tsQOrGkLIimJW0gqhgO++YzYaPyUtZJPexJwh4YsMhzi7IAosmGX/HPUw8+SwqEjBC
         BnpjhDuGmpr4kKJsaMoIMGwhW/Q6DAaLrHzhgYQZ4trvmaWqb+QwIXwwt3DF9cg2BG
         mXJN4P5RBW1pwlQ7SDUsh4YqglsAXhdNX4xUSy1k1WEHk/QpmCnCI5AIb4Niuq4MQ3
         GJmzGBz3YSr5UB08BrBDzgojvi4RIuxFS/Nr2EgveJYNxlSiPEEKc+NWPoGWsKLafA
         FB4h6V8hfr0/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 90DC760A69;
        Fri,  1 Oct 2021 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: fix memory leak in strset
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163312200758.4646.10047712788730385423.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Oct 2021 21:00:07 +0000
References: <20211001185910.86492-1-andrii@kernel.org>
In-Reply-To: <20211001185910.86492-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Fri,  1 Oct 2021 11:59:10 -0700 you wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Free struct strset itself, not just its internal parts.
> 
> Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructure APIs")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: fix memory leak in strset
    https://git.kernel.org/bpf/bpf/c/b0e875bac0fa

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


