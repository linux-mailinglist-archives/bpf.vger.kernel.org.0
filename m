Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8A4270A6
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 20:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhJHSWD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 14:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhJHSWC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 14:22:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2AA7060F92;
        Fri,  8 Oct 2021 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633717207;
        bh=2Aw3jCxutyi5r0vKlGaS0hmgoCo3pK2qBb3DUlNnANM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FL3LZwGTUwgH2PpTxRsBWQJc6oRjvhJvtvIYWt/bsXB7x23yPCjjjVe6FcvWXgLBS
         TTs2Y7zsSBwC4IL9ZDzy3zkh5UWC9n8rNNXkVvmM2HpDHEVKAP7dIsuR+BDp+V0CN4
         hQ7xzOlBmwDO6rXKcG3eW9W6FNiHLW6RV11rR1hJooa4XJaK9DFm2OYCvwLHjCAvSJ
         6gaFzJbBDOCf9eMoa0xEmLLz79T7XxHoHtRC0Xtm6PiZEObEhLpZUlShvNx56gqaF3
         hQTfWukNhf29d6AOQZQQwKglCUX68XzODGGLQ7E2zJurFcjKVuo/KD+5tsKQMEVSVj
         jrwbvkEcihP6w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1D47760985;
        Fri,  8 Oct 2021 18:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftest/bpf: fix btf_dump test under new clang
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163371720711.14753.14665860779410270143.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Oct 2021 18:20:07 +0000
References: <20211008173139.1457407-1-fallentree@fb.com>
In-Reply-To: <20211008173139.1457407-1-fallentree@fb.com>
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, sunyucong@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 8 Oct 2021 10:31:39 -0700 you wrote:
> From: Yucong Sun <sunyucong@gmail.com>
> 
> New clang version changed type name in dwarf from "long int" to "long",
> this is causing btf_dump tests to fail.
> 
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftest/bpf: fix btf_dump test under new clang
    https://git.kernel.org/bpf/bpf-next/c/7e3cbd3405cb

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


