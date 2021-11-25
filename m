Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A167145E30D
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 23:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhKYWpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 17:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236021AbhKYWnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 17:43:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EA4F261139;
        Thu, 25 Nov 2021 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637880010;
        bh=TFyhzubAptXvaHRJcHJ2W+iocjKrDqZO/XaKPTKaEVs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bi9VphC8O+A5GGoyi0PcNbOX8O4FdjI8DjbDgg8L3Bcsdo59s3MbXX9cWI2L/mQkx
         Ujm3qNzE/bNm/XCYFr4GpMR6zqLJNI+UpWB4sxO0SrpxoWDGjQUkx/YNoB5Z30NcFD
         i/xyM1qQUDp/IUcX5QMOAKeUhxqbz2LaAXtNHy6NWy6w6hE+5zzQvzjaMlyswJ10Pb
         9BXFPvcvcQd/WeV/THQF09cPnnUBqrNTW/GNsxWFDZWiDqn7r3KAYnDuGG6aKfUJ8s
         aZTsQqvdM5iLjeycDGgwu3rVXD3ivrpaXqQ0gXXlpXsxPOH4Dq+XmfX4qiHqKeDmXq
         kQ12kB2/Xzzow==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D4C7E609D5;
        Thu, 25 Nov 2021 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] libbpf: unify low-level map creation APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163788000986.19276.14107161216296070091.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Nov 2021 22:40:09 +0000
References: <20211124193233.3115996-1-andrii@kernel.org>
In-Reply-To: <20211124193233.3115996-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 24 Nov 2021 11:32:29 -0800 you wrote:
> Add new OPTS-based bpf_map_create() API. Schedule deprecation of 6 (!)
> existing non-extensible variants. Clean up both internal libbpf use of
> to-be-deprecated APIs as well as selftests/bpf.
> 
> Thankfully, as opposed to bpf_prog_load() and few other *_opts structs
> refactorings, this one is very straightforward and doesn't require any macro
> magic.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] libbpf: unify low-level map creation APIs w/ new bpf_map_create()
    https://git.kernel.org/bpf/bpf-next/c/992c4225419a
  - [v2,bpf-next,2/4] libbpf: use bpf_map_create() consistently internally
    https://git.kernel.org/bpf/bpf-next/c/a9606f405f2c
  - [v2,bpf-next,3/4] libbpf: prevent deprecation warnings in xsk.c
    https://git.kernel.org/bpf/bpf-next/c/99a12a32fee4
  - [v2,bpf-next,4/4] selftests/bpf: migrate selftests to bpf_map_create()
    https://git.kernel.org/bpf/bpf-next/c/2fe256a429cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


