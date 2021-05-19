Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA00388F4D
	for <lists+bpf@lfdr.de>; Wed, 19 May 2021 15:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbhESNla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 May 2021 09:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233980AbhESNl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 May 2021 09:41:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B5E156135A;
        Wed, 19 May 2021 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621431609;
        bh=yFID/DaRQEopILCuU0uUoCTrLdZd9bT/CAWygvniS84=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H6Qb3UOpMfEj1/UJakj6YPs8FcN/V/PvuzcMG410MCLmOcLVkwNGCngx1GV6szaFe
         uzq+9+AbGsAfbts4YCtRN0YTZkj9odxt0wimw/9tcm9x7HrJeyPpIx6UR2jr5gdp7X
         miF92xZ3nR5ji7NGxf2PH5YHRed+O9AREbAxnklhUHYcgasIQ5D87HUUVJGwPZ9Slh
         HBhK1WZbp6qxrq423q1bNqrHCpkd8Mv/6dgzEroLK7FH2Lr8h8igcom7Eon4VsLU0o
         xbUlctRKaMGLSl5mwkI2ORA5de0WlKubugObmKZehbC7F0xQkNuyr8kwDeJOaCNnbp
         iQSskMARnkF6w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A54B1609F7;
        Wed, 19 May 2021 13:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add cmd alias BPF_PROG_RUN
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162143160967.496.12382728967559496510.git-patchwork-notify@kernel.org>
Date:   Wed, 19 May 2021 13:40:09 +0000
References: <20210519014032.20908-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210519014032.20908-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 18 May 2021 18:40:32 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Add BPF_PROG_RUN command as an alias to BPF_RPOG_TEST_RUN to better
> indicate the full range of use cases done by the command.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add cmd alias BPF_PROG_RUN
    https://git.kernel.org/bpf/bpf-next/c/5d67f349590d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


