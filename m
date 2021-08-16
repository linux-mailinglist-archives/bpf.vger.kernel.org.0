Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214F63EE03B
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhHPXKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 19:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhHPXKk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 19:10:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BAA9C60F35;
        Mon, 16 Aug 2021 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629155408;
        bh=xrZgcaLptoQh7ZTztlfvoEJkFZ9Fms5H9PZazkxMHdg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Yptk4WdS9SgV0Lw1zaemhNIpfgoSjG55RUjlsuS4TyJ4FSfoHyAfQ16TvZ2Ini0zf
         uJycFCnW1p5sTbSXaJYmgG73KDoe/Cfv992kZq/w2QEQ32Ak/qk8AtTU6Y0j0r/ot6
         8MSKzIH24h3HTIJVHr5rMuRbBCSqDgNpIriGcJ+7FEvl/rD00ClCp9/rv/jxUQ3+IP
         vY/3mMU/PEnYhkmbn8iDQper1nsVw2UM0V1dkJJCFvKLq2pjneC8TeXXbuSCRx3r8J
         /+fM9sVxNouAFZbti25yzATzYxSOSQfdxGpnaf1rUDeAKP72pIzoLCahy/gIgvnczD
         d+4dXSLodsKxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AC132600AB;
        Mon, 16 Aug 2021 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 00/16] BPF perf link and user-provided bpf_cookie
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162915540869.13624.15422048649808157567.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Aug 2021 23:10:08 +0000
References: <20210815070609.987780-1-andrii@kernel.org>
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Sun, 15 Aug 2021 00:05:53 -0700 you wrote:
> This patch set implements an ability for users to specify custom black box u64
> value for each BPF program attachment, bpf_cookie, which is available to BPF
> program at runtime. This is a feature that's critically missing for cases when
> some sort of generic processing needs to be done by the common BPF program
> logic (or even exactly the same BPF program) across multiple BPF hooks (e.g.,
> many uniformly handled kprobes) and it's important to be able to distinguish
> between each BPF hook at runtime (e.g., for additional configuration lookup).
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,01/16] bpf: refactor BPF_PROG_RUN into a function
    https://git.kernel.org/bpf/bpf-next/c/fb7dd8bca013
  - [v5,bpf-next,02/16] bpf: refactor BPF_PROG_RUN_ARRAY family of macros into functions
    https://git.kernel.org/bpf/bpf-next/c/7d08c2c91171
  - [v5,bpf-next,03/16] bpf: refactor perf_event_set_bpf_prog() to use struct bpf_prog input
    https://git.kernel.org/bpf/bpf-next/c/652c1b17b85b
  - [v5,bpf-next,04/16] bpf: implement minimal BPF perf link
    https://git.kernel.org/bpf/bpf-next/c/b89fbfbb854c
  - [v5,bpf-next,05/16] bpf: allow to specify user-provided bpf_cookie for BPF perf links
    https://git.kernel.org/bpf/bpf-next/c/82e6b1eee6a8
  - [v5,bpf-next,06/16] bpf: add bpf_get_attach_cookie() BPF helper to access bpf_cookie value
    https://git.kernel.org/bpf/bpf-next/c/7adfc6c9b315
  - [v5,bpf-next,07/16] libbpf: re-build libbpf.so when libbpf.map changes
    https://git.kernel.org/bpf/bpf-next/c/61c7aa5020e9
  - [v5,bpf-next,08/16] libbpf: remove unused bpf_link's destroy operation, but add dealloc
    https://git.kernel.org/bpf/bpf-next/c/d88b71d4a916
  - [v5,bpf-next,09/16] libbpf: use BPF perf link when supported by kernel
    https://git.kernel.org/bpf/bpf-next/c/668ace0ea5ab
  - [v5,bpf-next,10/16] libbpf: add bpf_cookie support to bpf_link_create() API
    https://git.kernel.org/bpf/bpf-next/c/3ec84f4b1638
  - [v5,bpf-next,11/16] libbpf: add bpf_cookie to perf_event, kprobe, uprobe, and tp attach APIs
    https://git.kernel.org/bpf/bpf-next/c/47faff371755
  - [v5,bpf-next,12/16] selftests/bpf: test low-level perf BPF link API
    https://git.kernel.org/bpf/bpf-next/c/f36d3557a132
  - [v5,bpf-next,13/16] selftests/bpf: extract uprobe-related helpers into trace_helpers.{c,h}
    https://git.kernel.org/bpf/bpf-next/c/a549aaa67395
  - [v5,bpf-next,14/16] selftests/bpf: add bpf_cookie selftests for high-level APIs
    https://git.kernel.org/bpf/bpf-next/c/0a80cf67f34c
  - [v5,bpf-next,15/16] libbpf: add uprobe ref counter offset support for USDT semaphores
    https://git.kernel.org/bpf/bpf-next/c/5e3b8356de36
  - [v5,bpf-next,16/16] selftests/bpf: add ref_ctr_offset selftests
    https://git.kernel.org/bpf/bpf-next/c/4bd11e08e0bb

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


