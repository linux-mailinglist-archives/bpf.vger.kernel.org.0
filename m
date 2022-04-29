Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84851410E
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiD2DXe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 23:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiD2DXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 23:23:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1495A16B
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 20:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CDE4B832B0
        for <bpf@vger.kernel.org>; Fri, 29 Apr 2022 03:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13833C385AC;
        Fri, 29 Apr 2022 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651202412;
        bh=XreGJRAGNWzOn6jLfgjBnF8HFswEeW+6d8uAN0Tf7Xo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NzA53EW0Vxt7xURuBXaU1qIrqOVLf3MsjsHaG02T8v3UbAtlMHzvaDCgihbf5k2Gt
         DIvCK+dWn/8X3IzARUZKx5p3x1lddNcH47zez1bvRhucMeCw9Cf7pKlrsaccc1PfOV
         9R5QU0Iz4t7O1cSjRoEtbLnQA33WKMkh6RxlFnr/j1IdstQmT2QGnI3+8XpbMg9H0t
         yiBWrDDliG/bOrn6JoPYOBFipCraoxTDB/SBW/8dtnEwfOO5DwU/Bg/ZYEz9zcE2yU
         W7jSUsBkOaRQZc4+0EV8MoY6KONrLEh6yS2HS8DuZQB+tdFP1Yj9BkFbhiGoCz62P0
         9dgX9VyNOQ0aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECBE8F03848;
        Fri, 29 Apr 2022 03:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] libbpf: allow to opt-out from BPF map creation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165120241196.28026.9393761391052858735.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Apr 2022 03:20:11 +0000
References: <20220428041523.4089853-1-andrii@kernel.org>
In-Reply-To: <20220428041523.4089853-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 27 Apr 2022 21:15:19 -0700 you wrote:
> Add bpf_map__set_autocreate() API which is a BPF map counterpart of
> bpf_program__set_autoload() and serves similar goal of allowing to build more
> flexible CO-RE applications. See patch #3 for example scenarios in which the
> need for such API came up previously.
> 
> Patch #1 is a follow-up patch to previous patch set adding verifier log fixup
> logic, making sure bpf_core_format_spec()'s return result is used for
> something useful.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] libbpf: append "..." in fixed up log if CO-RE spec is truncated
    https://git.kernel.org/bpf/bpf-next/c/b198881d4b4c
  - [bpf-next,2/4] libbpf: use libbpf_mem_ensure() when allocating new map
    https://git.kernel.org/bpf/bpf-next/c/69721203b1f3
  - [bpf-next,3/4] libbpf: allow to opt-out from creating BPF maps
    https://git.kernel.org/bpf/bpf-next/c/ec41817b4af5
  - [bpf-next,4/4] selftests/bpf: test bpf_map__set_autocreate() and related log fixup logic
    https://git.kernel.org/bpf/bpf-next/c/68964e155677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


