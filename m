Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65B7474559
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 15:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhLNOkL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 09:40:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50894 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhLNOkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 09:40:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55ABAB819E2
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 14:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28A25C34606;
        Tue, 14 Dec 2021 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639492809;
        bh=PwYEZEfT5JVVLFWpOxeigBBVWocBV1lbnd9X8q5jzNQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eBiOu5dF1N0Ab+24uIZY+YHelcivNfFtpoQ6YIzK7O4jtK80UQYYi6QeKZYCnhRfo
         7hqpoep3s7a8DnzCq+X8hvBDX2Eml1G0X/UkNu2HuXMMD3vVl+2CnyrU5Zw25F6TVg
         nh+Nhd2SiwwTGKi0ACGWUfgA7A1x3YTMyUFzAX+RXqilHy4tEDq8U/RL7oJpyVFzu4
         Ab7Qbc26biWTfY6tG8jIaKinefBnHSm+M6quruPqWf7H59bzaOjnkKooS6cCjQQDJz
         h0dLD4vFXMJev9yOZQxCXoxrf98FuPl29LdlnRrFgZv+PfVXXyk/isRa8GDZQDLcXr
         4VESyveIcBl7Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0C4BA609BA;
        Tue, 14 Dec 2021 14:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix potential uninit memory read
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163949280904.1632.11298824485639622358.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Dec 2021 14:40:09 +0000
References: <20211214010032.3843804-1-andrii@kernel.org>
In-Reply-To: <20211214010032.3843804-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 13 Dec 2021 17:00:32 -0800 you wrote:
> In case of BPF_CORE_TYPE_ID_LOCAL we fill out target result explicitly.
> But targ_res itself isn't initialized in such a case, and subsequent
> call to bpf_core_patch_insn() might read uninitialized field (like
> fail_memsz_adjust in this case). So ensure that targ_res is
> zero-initialized for BPF_CORE_TYPE_ID_LOCAL case.
> 
> This was reported by Coverity static analyzer.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix potential uninit memory read
    https://git.kernel.org/bpf/bpf-next/c/4581e676d3be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


