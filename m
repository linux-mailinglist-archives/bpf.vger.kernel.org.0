Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0640FD93
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhIQQLc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 12:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240185AbhIQQLb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 12:11:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DB64061212;
        Fri, 17 Sep 2021 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631895008;
        bh=VRsQBviTr6s946tbfZg17fNfnUqHErYSmRigkoPwBPI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NM/0WeudiYnqrEimRHM0YN6R09Zg2EOiwHgzuqeXUkaAsOCUPp4OKSsS2YE9V67BR
         eAge2JhV5VT/wG5MttEEjT8K08Xh5MtkAfUL2xuC5c3TZ9+q1CC34t2RrAWRQyhv/m
         v3PWYXk/mWWzyybqDMmOo0ch03V/Xa5p1RLJVv+7A58QfuKdIgb2iWMUDbDnajZRH5
         gmRIHTLYCzA5k6kCy6mg7RWfUhAeb4V7/AJI8MNH8RIj7UAxRCsIR2WI3d4Wu9vqzd
         JbugbaA+nnM2IlwwNbNUWgKngGUOhKcIYx8IMFljytvcKVNVB0+K1g5DzFPILBvqGh
         PWgkZldvWkP3g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D21E4609AD;
        Fri, 17 Sep 2021 16:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] Improve set_attach_target() and deprecate
 open_opts.attach_prog_fd
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163189500885.20217.13882482710541336384.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Sep 2021 16:10:08 +0000
References: <20210916015836.1248906-1-andrii@kernel.org>
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 15 Sep 2021 18:58:29 -0700 you wrote:
> This patch set deprecates bpf_object_open_opts.attach_prog_fd (in libbpf 0.7+)
> by extending bpf_program__set_attach_target() to support some more flexible
> scenarios. Existing fexit_bpf2bpf selftest is updated accordingly to not use
> deprecated APIs.
> 
> While at it, also deprecate no-op relaxed_core_relocs option (they are always
> "relaxed").
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] libbpf: use pre-setup sec_def in libbpf_find_attach_btf_id()
    https://git.kernel.org/bpf/bpf-next/c/f11f86a3931b
  - [bpf-next,2/7] selftests/bpf: stop using relaxed_core_relocs which has no effect
    https://git.kernel.org/bpf/bpf-next/c/23a7baaa9388
  - [bpf-next,3/7] libbpf: deprecated bpf_object_open_opts.relaxed_core_relocs
    https://git.kernel.org/bpf/bpf-next/c/277641859e83
  - [bpf-next,4/7] libbpf: allow skipping attach_func_name in bpf_program__set_attach_target()
    https://git.kernel.org/bpf/bpf-next/c/2d5ec1c66e25
  - [bpf-next,5/7] selftests/bpf: switch fexit_bpf2bpf selftest to set_attach_target() API
    https://git.kernel.org/bpf/bpf-next/c/60aed22076b0
  - [bpf-next,6/7] libbpf: schedule open_opts.attach_prog_fd deprecation since v0.7
    https://git.kernel.org/bpf/bpf-next/c/91b555d73e53
  - [bpf-next,7/7] libbpf: constify all high-level program attach APIs
    https://git.kernel.org/bpf/bpf-next/c/942025c9f37e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


