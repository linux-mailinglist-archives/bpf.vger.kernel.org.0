Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1762B494013
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbiASSkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 13:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346884AbiASSkM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 13:40:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CFC061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B2CB81B00
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 18:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5A0EC340E1;
        Wed, 19 Jan 2022 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642617609;
        bh=efULN279u6y/mMt8ft85K/Ky0wcjdDxmUOc3wTFB++A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fOprhlhOttgtsC2znnhyPFut7NQr4Xh5uXRDp06icFw8He6dhjmSyNBgKwdkoNx9A
         jtu/RusB3Tb6SKacX+22HsNo7KV2Wh+Rx1rY2Ovlp86MOo8euDUwJ9E2Xi5pNpaPWl
         rRPCgSA7+tnTbVJaBkkxKpCZwaHFS7Jhl4ogqYWs1sxEPVet489RuyKUIk6UtXQ7fd
         n5D9tEHK20rNbpJZlukHMdh/e3dY+r05IbcbHAV7bFXpBgxXi8bG0zT4pIcF6RhPJV
         4vF7GRVwy+wpVyzoZ8uh4XzAuivUiQfO2ADytaNEELrDocTiuVDaf5NW8IZVD0HsyC
         pVhVCDud5qShw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA2FAF6079B;
        Wed, 19 Jan 2022 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/3] uapi/bpf: Add missing description and returns
 for helper documentation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164261760975.14405.8285375089710473745.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jan 2022 18:40:09 +0000
References: <20220119114442.1452088-1-usama.arif@bytedance.com>
In-Reply-To: <20220119114442.1452088-1-usama.arif@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        fam.zheng@bytedance.com, cong.wang@bytedance.com, song@kernel.org,
        quentin@isovalent.com, andrii.nakryiko@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Jan 2022 11:44:40 +0000 you wrote:
> Both description and returns section will become mandatory
> for helpers and syscalls in a later commit to generate man pages.
> 
> This commit also adds in the documentation that BPF_PROG_RUN is
> an alias for BPF_PROG_TEST_RUN for anyone searching for the
> syscall in the generated man pages.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] uapi/bpf: Add missing description and returns for helper documentation
    https://git.kernel.org/bpf/bpf-next/c/e40fbbf0572c
  - [bpf-next,v3,2/3] bpf/scripts: Make description and returns section for helpers/syscalls mandatory
    https://git.kernel.org/bpf/bpf-next/c/f1f3f67fd8ed
  - [bpf-next,v3,3/3] bpf/scripts: Raise an exception if the correct number of sycalls are not generated
    https://git.kernel.org/bpf/bpf-next/c/0ba3929e5b3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


