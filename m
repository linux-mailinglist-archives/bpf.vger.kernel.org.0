Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7246B168
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 04:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhLGDXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 22:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhLGDXm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 22:23:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C7C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 19:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB72CCE19B6
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 03:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 002BAC341C8;
        Tue,  7 Dec 2021 03:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638847209;
        bh=HUeakxxwYP7TsF8cfnA1FCiRnVqfDVhp21jIWH2tDJA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j248xYi/h6R+Um+RHKXtG7T/5mE6+8DM6ZhD0CroMizOwhCjlXgZNfIMJ+vPpoJ8x
         5mNVpqLn6DiIrXnDshYFY5Synr+In5Asw9VZblUHrUHjToSvJafnkmoh07+lGzAqIj
         Qahbw5pzzIzhYFtSBPimapuLZ2Z5I5NuU+yMLPjWapnPwgj0zshtANFeBowGxJ+hkA
         J8dJmNBC5XqZeMVBdGXe0AUfH3cYsrCXNEP8QjXKr0pw0KPElN2VDR2NGLc3Gi5hLK
         s1RxL+JISGXmTTwWR2KGpB8QpQyCUB8Yw7/lSWSOXsiAQjkjQxuOMrDyWp3p6vWgjC
         9sbH1ECFYofxg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DBD98608FB;
        Tue,  7 Dec 2021 03:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Silence purge_cand_cache build warning.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163884720889.12606.11250325638596833161.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Dec 2021 03:20:08 +0000
References: <20211207014839.6976-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20211207014839.6976-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  6 Dec 2021 17:48:39 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> When CONFIG_DEBUG_INFO_BTF_MODULES is not set
> the following warning can be seen:
> kernel/bpf/btf.c:6588:13: warning: 'purge_cand_cache' defined but not used [-Wunused-function]
> Fix it.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Silence purge_cand_cache build warning.
    https://git.kernel.org/bpf/bpf-next/c/29f2e5bd9439

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


