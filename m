Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B953B494043
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 20:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiASTAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 14:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiASTAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 14:00:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D20C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 11:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8FA6616C4
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 19:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C073C340E1;
        Wed, 19 Jan 2022 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642618810;
        bh=O6mThkA4C0xmBbtstod2gPCwgGyTpjzeAN0C2uiZy0U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MC0YhY9kMJm4SXG8+FiOw/MIDyNltYwmwylCxTcBwHLEJkoDZ7qWPK9Mh0CnqmkVf
         FBbvp2vzHRx3lbIQqQ/Lao74xa85WP4O9Q2OSvuzufcPShHTb1wXao1R+YKsbgoPKi
         K8uq4PtT9dbVw8TiO+7FmGYF/6GuLHS0s1ndeCLI6DA1YqotECC3mFSO9qkTxv2iKn
         YQrZ2JyH9Xc1kc46exFhWkSEiupu4cw3JUmDjgxWNHtx2xaNv1sjDnvUZz38TEDoDB
         nKPeqRmA+3mkMGFI+uGgaP1VL+rglETyIhfM4EyeUxrWWSLCbM6HyBaMdbL1C705pe
         +ZTta3Gmm2/hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0872FF6079B;
        Wed, 19 Jan 2022 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next] libbpf: Improve btf__add_btf() with an additional
 hashmap for strings.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164261881003.24332.18299919716165407701.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jan 2022 19:00:10 +0000
References: <20220119180214.255634-1-kuifeng@fb.com>
In-Reply-To: <20220119180214.255634-1-kuifeng@fb.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Jan 2022 10:02:14 -0800 you wrote:
> Add a hashmap to map the string offsets from a source btf to the
> string offsets from a target btf to reduce overheads.
> 
> btf__add_btf() calls btf__add_str() to add strings from a source to a
> target btf.  It causes many string comparisons, and it is a major
> hotspot when adding a big btf.  btf__add_str() uses strcmp() to check
> if a hash entry is the right one.  The extra hashmap here compares
> offsets of strings, that are much cheaper.  It remembers the results
> of btf__add_str() for later uses to reduce the cost.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next] libbpf: Improve btf__add_btf() with an additional hashmap for strings.
    https://git.kernel.org/bpf/bpf-next/c/d81283d27266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


