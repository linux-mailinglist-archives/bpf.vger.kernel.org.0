Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5333947DE
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE1UVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 16:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhE1UVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 16:21:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A1996613B5;
        Fri, 28 May 2021 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622233203;
        bh=fG/auPjbxRSpUCaBJqRKU2KsDQjeG9JxJfi4TUhFCb4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IaMwYhGxih4a2ul8AlVDWiqQZozyuIn0i7+8I41EZLFDUrRLkclgpPIHQOteieZkq
         +NF4Xs6ADemfHOfENESyR2Az8s500Na0UfkPqYa+AiAMwrf0X3FhjVbPoec8g93sgU
         r7RkIB8fvn95vuvpeLYjWOQ6YZbGPpy6F5BwvPgl82k6crNTpCW0YnyOJnpBItU6nK
         pQlbcTM93m00y1KHyBEmsj7rErLMg5WObfPYbZBpUK8TAp9ckaGgzIPsy1xOUd98s0
         3h5HYEbHIypcyEWyGGJEualRrv9i6uRe0y2+zAs7+UR0qOzJFVFFjkKI/ZRFeCbLck
         EJrBDdkmPMlQw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 94CF8609EA;
        Fri, 28 May 2021 20:20:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] docs/bpf: add llvm_reloc.rst to explain llvm bpf
 relocations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162223320360.3755.9806905798325331756.git-patchwork-notify@kernel.org>
Date:   Fri, 28 May 2021 20:20:03 +0000
References: <20210526152457.335210-1-yhs@fb.com>
In-Reply-To: <20210526152457.335210-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, maskray@google.com, kernel-team@fb.com,
        john.fastabend@gmail.com, lmb@cloudflare.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 26 May 2021 08:24:57 -0700 you wrote:
> LLVM upstream commit https://reviews.llvm.org/D102712
> made some changes to bpf relocations to make them
> llvm linker lld friendly. The scope of
> existing relocations R_BPF_64_{64,32} is narrowed
> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> are introduced.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] docs/bpf: add llvm_reloc.rst to explain llvm bpf relocations
    https://git.kernel.org/bpf/bpf-next/c/fc8c262e0eb5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


