Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3316D2F3CDF
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437130AbhALVhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436999AbhALUks (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 15:40:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DC04523123;
        Tue, 12 Jan 2021 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610484007;
        bh=LhSbB26USd4jZppIoRtiy8MxTFLgmHV0osHDg6Z2+hY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qnbcKrU9nJA3ioXXJ9k6wQbB0oIJnflXu0zJYHweA8dSs71E3T73eR1dhcPW/uShK
         ai8rJJofb5RIoixQrap7o0K1rbJ9XeqlCqkJ/P5eS8SZqbYWUJreuZfMikC0572TGv
         ap6nYOEHcC/avJOx21tw2hiRllnlWSXHn4mknf5TB/Zwp89zRglOKGPQSWFAhDi3O/
         K3djW8jTXH0LdRQ3XrkvvKmC1LESTiNA/4q1aOU8GB+8VJAgk88kkz26a6Ts1j/6fj
         3vZ/3CrRlc9A8FlQ1RPhpT4X3dcoqhhLw3+nao3pqSpHeI2GT7CRaUfQSuGx7tjCjD
         ToifraN1bl91A==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id D3BA860354;
        Tue, 12 Jan 2021 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Clarify return value of probe str helpers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161048400786.9454.10492933379744564309.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Jan 2021 20:40:07 +0000
References: <20210112123422.2011234-1-jackmanb@google.com>
In-Reply-To: <20210112123422.2011234-1-jackmanb@google.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, kpsingh@chromium.org,
        revest@chromium.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 12 Jan 2021 12:34:22 +0000 you wrote:
> When the buffer is too small to contain the input string, these
> helpers return the length of the buffer, not the length of the
> original string. This tries to make the docs totally clear about
> that, since "the length of the [copied ]string" could also refer to
> the length of the input.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Clarify return value of probe str helpers
    https://git.kernel.org/bpf/bpf-next/c/c6458e72f6fd

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


