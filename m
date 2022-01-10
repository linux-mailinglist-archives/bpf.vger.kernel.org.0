Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8BD488E97
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 03:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiAJCKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Jan 2022 21:10:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40834 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbiAJCKN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Jan 2022 21:10:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2EB6CE1258;
        Mon, 10 Jan 2022 02:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC263C36AEF;
        Mon, 10 Jan 2022 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641780609;
        bh=zBuFSL/tlo/kGDtU6AYsmMls/4da+oq+NcCGlkXPWA4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RT1NqQVS/+HvtX8b7/SBreG6kau5GsyJcqNtcTWbwuzTVFM+1hLixNGjD4EgcjT8E
         S47ev99CdOs0dK9Iurp772Ghp1oqg0vAiNxd2c3Tirl6DxWm1iZsBt5GoFDZ3fQsVF
         kf9LLV04RNRfRnKhDH1j9jHclIuFSMQpsy4Ko0O3upyeC8TPVK3GBAAlmn11eQjlPO
         9NrAnGiFvWgWqzOWC/O5UVQpYNrKOmWrMCTKE8abHdaXH6ZVxrG3C3bVgam309HC8i
         WyujNVcUwMQ/l1Do/t7fDaId8iW0D6+bWr6Hm4TwpoHN35E9AI6WsoNErdvKUmEcbz
         gyxklbj902FBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C270F6078A;
        Mon, 10 Jan 2022 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] libbpf 1.0: deprecate bpf_map__def() API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164178060963.18256.8098134045355307256.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Jan 2022 02:10:09 +0000
References: <20220108004218.355761-1-christylee@fb.com>
In-Reply-To: <20220108004218.355761-1-christylee@fb.com>
To:     Christy Lee <christylee@fb.com>
Cc:     andrii@kernel.org, acme@kernel.org, christyc.y.lee@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com,
        linux-perf-users@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 7 Jan 2022 16:42:13 -0800 you wrote:
> bpf_map__def() is rarely used and non-extensible. bpf_map_def fields
> can be accessed with appropriate map getters and setters instead.
> Deprecate bpf_map__def() API and replace use cases with getters and
> setters.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] samples/bpf: stop using bpf_map__def() API
    https://git.kernel.org/bpf/bpf-next/c/fcaf77640892
  - [bpf-next,v2,2/5] bpftool: stop using bpf_map__def() API
    https://git.kernel.org/bpf/bpf-next/c/567df3b14606
  - [bpf-next,v2,3/5] perf: stop using bpf_map__def() API
    https://git.kernel.org/bpf/bpf-next/c/ad60db9aabb1
  - [bpf-next,v2,4/5] selftests/bpf: stop using bpf_map__def() API
    https://git.kernel.org/bpf/bpf-next/c/f8b287530aef
  - [bpf-next,v2,5/5] libbpf: deprecate bpf_map__def() API
    https://git.kernel.org/bpf/bpf-next/c/b95533311a0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


