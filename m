Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7EC383BF6
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 20:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhEQSL3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 14:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243847AbhEQSL0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 14:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E860C61263;
        Mon, 17 May 2021 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621275010;
        bh=rM/jmWfpHeJNnA0KiHCdJu/vO2ZA4b2sS/q3L2ev8Xs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EVz5FJOvkVvmWNQOFp7DfXImHHknEP/+BsXwbH/hesdMnSEMmBsKzpcPnowYbSJ6D
         eP6ZBjFVW+45cgbK5FdMbNE+hGm0IJsejgy3ljKkkT5t0W1w7teUjz7az+39nv0ZAJ
         QCr8jFmbTG0SWgUIrEozqhZVcbGoxoN+Q/lmX5JMWXSzyPdKKma/3bJh03hOBkQIbe
         xV+Si+nxdjWfg1z4KsspTzyXlR0UE1YTQiGg6W0fRJzfAsbW/XcEgjK/hmR2dLMM8H
         hfSsUXkTYEW2GOSXGck3anCbQagL+pO6baVNApstF0/0iLnGmhtRUZJqNVGfrH3H1w
         SQQIL5M9f9bAA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DCB8B60972;
        Mon, 17 May 2021 18:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Clarify a bpf_bprintf_prepare macro
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162127500989.31294.344588997595875629.git-patchwork-notify@kernel.org>
Date:   Mon, 17 May 2021 18:10:09 +0000
References: <20210517092830.1026418-1-revest@chromium.org>
In-Reply-To: <20210517092830.1026418-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Mon, 17 May 2021 11:28:29 +0200 you wrote:
> The per-cpu buffers contain bprintf data rather than printf arguments.
> The macro name and comment were a bit confusing, this rewords them in a
> clearer way.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/bpf/helpers.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf,1/2] bpf: Clarify a bpf_bprintf_prepare macro
    https://git.kernel.org/bpf/bpf/c/8ba1030385e3
  - [bpf,2/2] bpf: Avoid using ARRAY_SIZE on an uninitialized pointer
    https://git.kernel.org/bpf/bpf/c/d0c0fe10ce6d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


