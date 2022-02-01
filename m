Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11074A684E
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 00:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiBAXAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 18:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiBAXAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 18:00:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C7C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 15:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DBF6B8241E
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 23:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B8FDC340ED;
        Tue,  1 Feb 2022 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643756411;
        bh=wV3peNLO4kqZ0pZtGIiKLma+VDtdCPQBKIuF9r5zNuc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iWiZf1TsFCZQ3x4+a5dsssdQb9JTU0lhRTzdaqHLEm0pdNysXozCIQzjrdMD0bbjs
         Yq/aRFBIhKu1MtekVbYUZ7vokvcrDz3Wt4MFPD54JcQtJVP5MWgF18WERYqFnwA6cS
         RCvzaRFiOoCaaf16SfCHOlW8lUxG5pkmUcXLR6ojk0Dt9UzS4XoLOzwzfTyJmWd8bw
         iTPbUjl0RG6k9MCUvPisfUnvzUcKzM19DdFUqbnLeSjt/gf1v426wZjfo1VuaLqRGx
         sL8bI2xMgjFW1YwGNswq6I88++lU4Q0t1q8b+96thMTBvJJmNpdN3B4ymSx5898pPE
         zeaTXwr/YdEIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AEAFE6BB30;
        Tue,  1 Feb 2022 23:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] bpf: drop libbpf from bpf preload.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164375641130.5554.16675850401091381766.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Feb 2022 23:00:11 +0000
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 31 Jan 2022 14:05:21 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> CO-RE in the kernel support allows bpf preload to switch to light skeleton
> and remove libbpf dependency.
> This reduces the size of bpf_preload_umd from 300kbyte to 19kbyte and
> eventually will make "kernel skeleton" possible.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] libbpf: Add support for bpf iter in light skeleton.
    https://git.kernel.org/bpf/bpf-next/c/42d1d53fedc9
  - [bpf-next,2/7] libbpf: Open code low level bpf commands.
    https://git.kernel.org/bpf/bpf-next/c/e981f41fd029
  - [bpf-next,3/7] libbpf: Open code raw_tp_open and link_create commands.
    https://git.kernel.org/bpf/bpf-next/c/c69f94a33d12
  - [bpf-next,4/7] bpf: Remove unnecessary setrlimit from bpf preload.
    https://git.kernel.org/bpf/bpf-next/c/1ddbddd70651
  - [bpf-next,5/7] bpf: Convert bpf preload to light skeleton.
    https://git.kernel.org/bpf/bpf-next/c/79b203926d18
  - [bpf-next,6/7] bpf: Open code obj_get_info_by_fd in bpf preload.
    https://git.kernel.org/bpf/bpf-next/c/18ef5dac934a
  - [bpf-next,7/7] bpf: Drop libbpf, libelf, libz dependency from bpf preload.
    https://git.kernel.org/bpf/bpf-next/c/e96f2d64c812

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


