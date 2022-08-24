Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD785A0066
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiHXRaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiHXRaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 13:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE015C9FB
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 10:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF178612F4
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB661C433C1;
        Wed, 24 Aug 2022 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661362216;
        bh=hS3v1C2QhdUOqIzNUkEsrNRMKvjxlLz/+pTcf+xK2S0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YGzYIkGFLXBVLRHdCyqdi+5IX7N7mVSmzlIM5IEPOq9UUDnubMTggrA8NqzgjkLhd
         A+NeP59FITWeCGvd2FpIzwQOzDuyHUpaQdsQ5H0UYSAZiazTA5CjSy5ALisj/cAmw/
         rCD/83h0kprL5HPwLC/IJHO4ee3zFfgp5GCOkrHU+d78joAv9XHP4sMWQN2fJxr5qT
         gjYBGvXxcVXjdzgWBv7Vg1rpriHqAINpcEwnxCgrQsySkUikyklkYvt5l0aZDRkWWV
         JU9ptZTlojdMFWxKWFl0EBIjQp8u5g+sPutJFf9SdVKafIh7EXeo5I02jTvZt+E8iR
         xNiC2aovZBDVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4E6FC04E59;
        Wed, 24 Aug 2022 17:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add cb_refs test to s390x deny list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166136221579.27290.16425008980107506575.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Aug 2022 17:30:15 +0000
References: <20220824163906.1186832-1-deso@posteo.net>
In-Reply-To: <20220824163906.1186832-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 24 Aug 2022 16:39:06 +0000 you wrote:
> The cb_refs BPF selftest is failing execution on s390x machines. This is
> a newly added test that requires a feature not presently supported on
> this architecture.
> Denylist the test for this architecture.
> 
> Fixes: 3cf7e7d8685c ("selftests/bpf: Add tests for reference state fixes for callbacks")
> Signed-off-by: Daniel Müller <deso@posteo.net>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add cb_refs test to s390x deny list
    https://git.kernel.org/bpf/bpf-next/c/092e67772728

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


