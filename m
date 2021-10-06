Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3A423F8A
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJFNmB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 09:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhJFNmA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 09:42:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3D852610E5;
        Wed,  6 Oct 2021 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633527608;
        bh=v2+xepJRs/ccwYYIMgmtUAI9KudhKbMORK4zIsnhIzg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JL/MxMdm/TodAvNHdwKvE+/0vfNWexwpxLpz8KMn2kU+dRCTZCr4s4kat0xj1JbjC
         ugmdUtCpO7AY0eV5IKcSLrvQBmzbrcpSMcTIAWPRdg3Ho+d7RcLtB8jlyELwky3CC0
         mV8HEnL/FlIKgLCp5vhtLfL054sW2nr+uceULjIOn3/BvYnrOzEV+D4O2osJqXRZ27
         JewLhTJaSYlMozir9Yd9A+Ica8sEMCCvLGx7RQalSTpzmpj6po5kM28oGkxEwUwPVZ
         JrnIiU2giyIgeWU+nPCjMhslLX0quL+Q//SZNkmUNXn0Q2RVUW6+utW7BohA5RvXcG
         sayZ3UNMYjxXQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3158D6094F;
        Wed,  6 Oct 2021 13:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] libbpf: add bulk BTF type copying API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163352760819.24726.8658555431382002389.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Oct 2021 13:40:08 +0000
References: <20211006051107.17921-1-andrii@kernel.org>
In-Reply-To: <20211006051107.17921-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, acme@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue,  5 Oct 2021 22:11:04 -0700 you wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Add bulk BTF type data copying API, btf__add_btf(), to libbpf. This API is
> useful for tools that are manipulating BPF, such as pahole. They abstract away
> the details of implementing a pretty mundane, but important to get right,
> details of handling all possible BTF kinds, as well as, importantly, adjusting
> BTF type IDs and copying/deduplicating strings and string offsets, referenced
> from copied BTF types.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] libbpf: add API that copies all BTF types from one BTF object to another
    https://git.kernel.org/bpf/bpf-next/c/7ca611215983
  - [v2,bpf-next,2/3] selftests/bpf: refactor btf_write selftest to reuse BTF generation logic
    https://git.kernel.org/bpf/bpf-next/c/c65eb8082d4c
  - [v2,bpf-next,3/3] selftests/bpf: test new btf__add_btf() API
    https://git.kernel.org/bpf/bpf-next/c/9d0578722391

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


