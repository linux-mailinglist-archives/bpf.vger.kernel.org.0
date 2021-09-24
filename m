Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269F4417D0F
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 23:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbhIXVll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 17:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhIXVll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 17:41:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 98E4861250;
        Fri, 24 Sep 2021 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632519607;
        bh=IkkhMR9dl0fbJr8XYUtXWlDpeFNyOMc0k0uq3TVn3zw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MccyCGul4MXqsffdu6G8GDcjyTQ9oOBsoEy8qAFlEL77pOegDvEGDGIqZvS0e3uo3
         ERbA0mSXrvDILBo09XMpuVeufZE55k2LXrF2HaQ9wfH23e7TCCC3KBlDFczg7NQWXE
         6tPyiq+BYpqQFsfz3YhBXhzWfInt1Z5t/NURxvEgItd1P7fww5fg+qj5K2EuWPbcPh
         UpmvJ0BFVJgyRuqqIvSEPECXVGoZ5CU0u9N6ZqfwLuClsIMfSh2HJIieoKzm8XGgoB
         T4ZtlgwoclFATI+vnlcRvPeQ9n5A/h8urYVLH6tRs/141/acb4oPpyI3SdihUfAiee
         CDw3ncfiEOqrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8861960AA4;
        Fri, 24 Sep 2021 21:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: add btf headers to BPF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163251960755.21780.2555014983290061724.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Sep 2021 21:40:07 +0000
References: <20210924193557.3081469-1-davemarchevsky@fb.com>
In-Reply-To: <20210924193557.3081469-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Fri, 24 Sep 2021 12:35:57 -0700 you wrote:
> BPF folks maintain these and they're not picked up by the current
> MAINTAINERS entries.
> 
> Files caught by the added globs:
>   include/linux/btf.h
>   include/linux/btf_ids.h
>   include/uapi/linux/btf.h
> 
> [...]

Here is the summary with links:
  - [bpf-next] MAINTAINERS: add btf headers to BPF
    https://git.kernel.org/bpf/bpf/c/199715243f72

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


