Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175D73145FC
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 03:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhBICAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 21:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhBICAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 21:00:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8052064EA1;
        Tue,  9 Feb 2021 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612836007;
        bh=0ES5u6nt4FzG4JbFR8B1V+2/AsLpStrMtudS1wgbnWQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=K8LjBVmQHRImZOHew1ura6hjW2siM2b1iS+k6yKtqjFywYjw8dCSRDYjL2Q8flFl9
         Is+SPzoVQqjuiftMq57bfOB2Evcl3czQyzvM2VXWbHGw1lM0rcapIXjaYWjgBbuei3
         bfcfkF5DybjdKH8RqL+nqAgu4tLFUfO0tvbsXi4mH6zpPDiHAHfCj6bkjXMuXuQOL2
         2ynesvVmzmzPJ+5ZF72ADt4bOfxJcDm9R6m+E8WPCCr6MJoSzfhGC6aH4sJZqWVinh
         22xSdDNJF53a/xQ3pwoVSSljBBlJgP6YuElwUv3MAoYuvhGquqV7xQLx9VfanWYUtA
         /LhiX8YYTSxNg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 770BC609D6;
        Tue,  9 Feb 2021 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add missing cleanup in
 atomic_bounds test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161283600748.4994.7610155285282056810.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Feb 2021 02:00:07 +0000
References: <20210208123737.963172-1-jackmanb@google.com>
In-Reply-To: <20210208123737.963172-1-jackmanb@google.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, kpsingh@chromium.org,
        revest@chromium.org, yhs@fb.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  8 Feb 2021 12:37:37 +0000 you wrote:
> Add missing skeleton destroy call.
> 
> Reported-by: Yonghong Song <yhs@fb.com>
> Fixes: 37086bfdc737 ("bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Add missing cleanup in atomic_bounds test
    https://git.kernel.org/bpf/bpf-next/c/1589a1fa4e38

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


