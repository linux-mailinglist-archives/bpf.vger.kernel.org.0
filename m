Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A128D474D2B
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 22:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhLNVUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 16:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhLNVUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 16:20:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31CC061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 13:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10824B81668
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 21:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD6DBC34604;
        Tue, 14 Dec 2021 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639516808;
        bh=GQvM3lz25EmfgJato4UVRf7vuVmMnxpT/N4wgqlweBo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AHRZvjYgxj4qgs18lFsO2ot0cpoOns2rbqaGD/8M2O0t+XnadOj+VRuQzGu5Uk/p/
         8/DCrrPJQFHyuxEG7ofaTgNnfj6QMU05vuxL2XvdPNKCwMFTL74J3/Bit8jq0DKvVv
         ZvlGXgPwxFIMy2lVVncnAjk5MeY9ALBpihpAeYqopiUm1aHJ7kP8yTD915OdF+jIq9
         btJmtiVBLuczOTyq7EszC3IYWKU0WHxhf3b5NwHES0If7FJVaizO//sy4IsQTYsV9g
         X01kGtULoOqR/VY7NeweBLbNtZJbqwfaMob1CkfhqITDgxBiDQSW2GkMMMxuK74DJA
         H8dzucDI2BcCQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ABDBC609FE;
        Tue, 14 Dec 2021 21:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/2] libbpf: auto-bump RLIMIT_MEMLOCK on old
 kernels
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163951680869.11582.9681434664679508271.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Dec 2021 21:20:08 +0000
References: <20211214195904.1785155-1-andrii@kernel.org>
In-Reply-To: <20211214195904.1785155-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 14 Dec 2021 11:59:02 -0800 you wrote:
> Make libbpf bump RLIMIT_MEMLOCK, similarly to BCC, if kernel is old enough to
> use memcg-based memory accounting for BPF. Patch #2 drops explicit
> setrlimi(RLIMIT_MEMLOCK) calls in test_progs, test_maps, and test_verifier.
> 
> v3->v4:
>   - use detection based on bpf_ktime_get_coarse_ns() helper (Daniel);
> v2->v3:
>   - use difference in fdinfo's memlock reporting to detect memcg;
> v1->v2:
>   - fix up out-of-sync comments (Toke).
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/2] libbpf: auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF
    https://git.kernel.org/bpf/bpf-next/c/e542f2c4cd16
  - [v4,bpf-next,2/2] selftests/bpf: remove explicit setrlimit(RLIMIT_MEMLOCK) in main selftests
    https://git.kernel.org/bpf/bpf-next/c/c164b8b40422

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


