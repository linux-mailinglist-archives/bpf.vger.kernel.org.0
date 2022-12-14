Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479F264D305
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 00:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLNXKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 18:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNXKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 18:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0C29832
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 657BC61C5B
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 23:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3868C433F0;
        Wed, 14 Dec 2022 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671059417;
        bh=kPEvysOt03Ksj5GRNm9yxtICdYBt2AorVohilxq3cYM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ToE0NrWd6bRDnOUxvOWYgRklzgexREB2Ty+2MntqqZcOCggh8selfreohm1DUiVvw
         MVcimEYXp9p28zodc3puYTw7++7PxJ2Rtunz5KjFP6rGEusDBQKpBg0c32ZNmDWs0i
         vhbi52NaEpgCQzZZ/9XBiHBixEDktyIqVWMOGyoKgxXYfLdJQNnD5G+DchF7d77yXH
         /HLSG7Gf0DQA5kaYumClVgdITRED9WgsrJ7kUIvKcZwN6nJ5J69zE6zxeum1/RZHZ5
         zWiG0qXoFJFKfm+ET0bMpg2/D7JFk0zjtHwODCKEHW9vMM17qGk/WAeD2HjjxVv+P6
         4dAngJFzXlTpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94386C41612;
        Wed, 14 Dec 2022 23:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/6] BTF-to-C dumper fixes and improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167105941758.13017.10011652519415863225.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Dec 2022 23:10:17 +0000
References: <20221212211505.558851-1-andrii@kernel.org>
In-Reply-To: <20221212211505.558851-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, eddyz87@gmail.com,
        per.xp.sundstrom@ericsson.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 12 Dec 2022 13:14:59 -0800 you wrote:
> Fix few tricky issues in libbpf's BTF-to-C converter, discovered thanks to
> Per's reports and his randomized testing script.
> 
> Most notably there is a much improved and correct padding handling.  But also
> it turned out that some corner cases with enums weren't handled correctly
> (mode(byte) attribute was a new discovery for me). See respective patches for
> more details.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/6] libbpf: fix single-line struct definition output in btf_dump
    https://git.kernel.org/bpf/bpf-next/c/872aec4b5f63
  - [v2,bpf-next,2/6] libbpf: handle non-standardly sized enums better in BTF-to-C dumper
    https://git.kernel.org/bpf/bpf-next/c/21a9a1bcccaa
  - [v2,bpf-next,3/6] selftests/bpf: add non-standardly sized enum tests for btf_dump
    https://git.kernel.org/bpf/bpf-next/c/9d2349740e43
  - [v2,bpf-next,4/6] libbpf: fix btf__align_of() by taking into account field offsets
    https://git.kernel.org/bpf/bpf-next/c/25a4481b4136
  - [v2,bpf-next,5/6] libbpf: fix BTF-to-C converter's padding logic
    https://git.kernel.org/bpf/bpf-next/c/ea2ce1ba99aa
  - [v2,bpf-next,6/6] selftests/bpf: add few corner cases to test padding handling of btf_dump
    https://git.kernel.org/bpf/bpf-next/c/b148c8b9b926

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


