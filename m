Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB7657204
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 03:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiL1CKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 21:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiL1CKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 21:10:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2EE15
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 18:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F47ECE111A
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 02:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DA3C433D2;
        Wed, 28 Dec 2022 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672193416;
        bh=7KVjj67UUcXd7RAEzpX795fM9FUBosK+NS55F+WPKI4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t8RF9k1Tis/65WBAoWGW3tSDimDENorBjvj8TiKWgv0MR7XVxUbCoGyDsf/WtnmH6
         CmjaAW6i8WYblHfsQ8WUSewYJeQhJdzranh1mM98QWesjD/MJXbvQXfzPlBlNeiLtq
         L5hfQbacpUsN7l2CmAPChrqcFzMwsIw+8EQYez3WzWCEZoV2ll4VHjNKJvlbOc0Yr2
         hvSnuIwr3oqyYfGEpcbe9yfz6+zcom4c5avT6XdNhmaLpoUbUDgoY4sn07o8Jf+Cal
         vPDBKJqDBN0fFVXZVDnxrrKHCKLVBFvepuzglYHUz2FP8GK/R2VO+SERBR09iqCL1f
         CRhp24xVhMtpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12FACE50D70;
        Wed, 28 Dec 2022 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] BPF verifier state equivalence checks
 improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167219341607.26190.4724859434610356280.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Dec 2022 02:10:16 +0000
References: <20221223054921.958283-1-andrii@kernel.org>
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Dec 2022 21:49:14 -0800 you wrote:
> This patch set fixes, improves, and refactors parts of BPF verifier's state
> equivalence checks.
> 
> Patch #1 fixes refsafe(), making it take into account ID map when comparing
> reference IDs. See patch for details.
> 
> Patches #2-#7 refactor regsafe() function which compares two register states
> across old and current states. regsafe() is critical piece of logic, so to
> make it easier to review and validate refactorings and logic fixes and
> improvements, each patch makes a small change, explaining why the change is
> correct and makes sense. Please see individual patches for details.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] bpf: teach refsafe() to take into account ID remapping
    https://git.kernel.org/bpf/bpf-next/c/e8f55fcf7779
  - [bpf-next,2/7] bpf: reorganize struct bpf_reg_state fields
    https://git.kernel.org/bpf/bpf-next/c/a73bf9f2d969
  - [bpf-next,3/7] bpf: generalize MAYBE_NULL vs non-MAYBE_NULL rule
    https://git.kernel.org/bpf/bpf-next/c/7f4ce97cd5ed
  - [bpf-next,4/7] bpf: reject non-exact register type matches in regsafe()
    https://git.kernel.org/bpf/bpf-next/c/910f69996674
  - [bpf-next,5/7] bpf: perform byte-by-byte comparison only when necessary in regsafe()
    https://git.kernel.org/bpf/bpf-next/c/4a95c85c9948
  - [bpf-next,6/7] bpf: fix regs_exact() logic in regsafe() to remap IDs correctly
    https://git.kernel.org/bpf/bpf-next/c/4633a0068258
  - [bpf-next,7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with default case in regsafe()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


