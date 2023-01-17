Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C166E3CF
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjAQQkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 11:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjAQQkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 11:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CD793;
        Tue, 17 Jan 2023 08:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14DDDB81909;
        Tue, 17 Jan 2023 16:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADCFBC433F1;
        Tue, 17 Jan 2023 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673973616;
        bh=Vbn4P8wdciA7LCo7ARdqkmCi6s1Bf6rlENph14XWrDc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G/EPjiYgZaDPXwpA07TjDK3j1XuK6TRsUcUn4/gwMs8IQMOqkoX/5m+f6CRiQghJ6
         sD7XqQmP2Z/UxpOLgG4Frs39qhOQaqm8h8fuc5PfVfPOzXVNCgL7SWDdD60uJ3FoTZ
         VBgEy9bFmQZ94AlBVS8vwt1yK2VFMPPYw3yFZEvpyy5juVfPjt7OlfXkgLTi6b1AfY
         AocuW/6yH/bnsWB9IO3kDUvz6xPh0M1ZwgxQw7PgxTrUUNtTEeJL6abF1K8wbkLRWD
         o6/mvUwmumPNnR/+K6Yug5Coh3S53y5eV+JHcZXfToyj22qZ8eiRGi5FSnh6SJlrK9
         4dCrkw9FlycXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D3A1C43159;
        Tue, 17 Jan 2023 16:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167397361656.26150.7048566316074687510.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Jan 2023 16:40:16 +0000
References: <20230111152050.559334-1-yakoyoku@gmail.com>
In-Reply-To: <20230111152050.559334-1-yakoyoku@gmail.com>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, neal@gompa.dev,
        ecurtin@redhat.com, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
        yhs@fb.com, miguel.ojeda.sandonis@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 11 Jan 2023 12:20:50 -0300 you wrote:
> Version 1.24 of pahole has the capability to exclude compilation units
> (CUs) of specific languages [1] [2]. Rust, as of writing, is not
> currently supported by pahole and if it's used with a build that has
> BTF debugging enabled it results in malformed kernel and module
> binaries [3]. So it's better for pahole to exclude Rust CUs until
> support for it arrives.
> 
> [...]

Here is the summary with links:
  - [v3] scripts: Exclude Rust CUs with pahole
    https://git.kernel.org/bpf/bpf-next/c/c1177979af9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


