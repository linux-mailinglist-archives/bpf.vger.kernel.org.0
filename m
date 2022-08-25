Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D95A1962
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbiHYTUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243629AbiHYTUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 15:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394571737
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 12:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7963E61D9F
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D04A3C433D7;
        Thu, 25 Aug 2022 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661455215;
        bh=0raw5PtksygdXIpgCakpWVF5dUG+xSI2QMiWtXtxsWE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b2NLp1sgdnXdoLHOlVD4YTDkSO9kjiMK2fT08fdDi3Y6SkZG0lSXMERUSDIEUpbY1
         1AewiSAQxm9j0H4hmwKcpgjHEpv8LiXI+x1bXzZgnSNLCctxDw4Rmx7OwCgiUKN3Ia
         PV0+oaQQ6Ehb0Yr6MTWbCpyszASgc0WfgV7U9NjY6RNr7mP9LNTymzu1nuz64LnzeL
         2MDhB8mjIjXUx6xjPOPkKpkHWfFK9dl3zBJefC7e3D5aB8+TBJAIAYFhw7A7iVWfM2
         G3ukdYPFp8WDR8umpXoZSJyHFRFd0v5oyqcGkotEtN63aFlJyoJGjrjCurXEDnVmGD
         0Iwoi9oseKKoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6F1EE2A03C;
        Thu, 25 Aug 2022 19:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/2] Fix incorrect pruning for
 ARG_CONST_ALLOC_SIZE_OR_ZERO
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166145521574.16425.11217278749845848299.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Aug 2022 19:20:15 +0000
References: <20220823185300.406-1-memxor@gmail.com>
In-Reply-To: <20220823185300.406-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Aug 2022 20:52:58 +0200 you wrote:
> A fix for a missing mark_chain_precision call that leads to eager pruning and
> loading of invalid programs when the more permissive case is in the straight
> line exploration. Please see the commit log for details, and selftest for an
> example.
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
>   selftests/bpf: Add regression test for pruning fix
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/2] bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
    https://git.kernel.org/bpf/bpf/c/2fc31465c537
  - [bpf,v1,2/2] selftests/bpf: Add regression test for pruning fix
    https://git.kernel.org/bpf/bpf/c/1800b2ac96d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


