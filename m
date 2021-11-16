Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E9453205
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhKPMX5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 07:23:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235976AbhKPMXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 07:23:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A837761929;
        Tue, 16 Nov 2021 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637065208;
        bh=U+c5KIeg2YxwVPQD3BwDGKZY5DxfFIXVoYDybZvIbqE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nkmNXDSIeKDpIM5j65IK5hnp8x8ydxd7JLnzN3uecbAgEWTbDRxqUTnffq+cZF+EW
         bwbJDgXyrxoFJvYUapM7shj84V2DinN/CIaRZ31RjW2ufxNIkyN5oe3w1WDJXDlHIy
         mpS1kXwxdBXb/jLrrkCUtWbkbbob1M7nhviHr8HCkklGbt3KZyia00M+F56MKVoGPP
         V4tB1TcWeMkeUlIQPhD9r6cedvZ7GcVUGmtAbkqOxIarehYUC7SmA/7pJ4k7q+JC0f
         cxYTbtVY4Wuxvv9rQ79EDvh6jrlCIueU2xuC+qipjLSq1wy06AP5wuexfdLhOkwgOG
         CZAb5Jjk2vfrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9B22B60A4E;
        Tue, 16 Nov 2021 12:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: fix a couple of missed btf_type_tag
 handling in libbpf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163706520863.24878.404260748653501732.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Nov 2021 12:20:08 +0000
References: <20211115163932.3921753-1-yhs@fb.com>
In-Reply-To: <20211115163932.3921753-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Nov 2021 08:39:32 -0800 you wrote:
> Commit 2dc1e488e5cd ("libbpf: Support BTF_KIND_TYPE_TAG") added
> BTF_KIND_TYPE_TAG support. But BTF_KIND_TYPE_TAG is not handled
> properly in libbpf btf_dedup_is_equiv() which will cause pahole dedup
> failure if the kernel has the following hack:
>   #define __user __attribute__((btf_type_tag("user")))
> 
> Patch 1 fixed the issue and Patch 2 added a test for it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: fix a couple of missed btf_type_tag handling in btf.c
    https://git.kernel.org/bpf/bpf-next/c/69a055d54615
  - [bpf-next,2/2] selftests/bpf: add a dedup selftest with equivalent structure types
    https://git.kernel.org/bpf/bpf-next/c/4746158305e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


