Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E155A376
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiFXVaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiFXVaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F8E5DC03
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB2C62380
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 21:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F200C3411C;
        Fri, 24 Jun 2022 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656106213;
        bh=ThqGJ+53oOnzZjHFNVQRwB3WMDGPuyMulEVi9YcEumA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TXqVLNYQmyjraLtSUuGVXqZ3lETEGToBVdDEkfneR2SlXab8ve+2MWN/k/EVtNvHB
         V9lg4foDgStVKE5ayFKMZm2DpiK0fkjz/KE3xAKBtYMLaBzpG8DoQleNNUYZzpULyK
         LqW1NTYpk8sMwxY76NRjouKU6LXN1ETikyxunEwBJDociTx9DC40+BXunoslvgVvf1
         5xlPmSIyoVYFd3PHpU4Ww2QEiGwjjQo7pk+b1upQmrk/Tbu6/EnJGwmV+vwWnJCs5l
         X9sAuV9Eb4o1xTNuBgj6dp2GwvU/1gRGdR9cs+TKq6m3XidVPlWv6JSpqaOsCb5OeU
         rCnsHI+nx2fgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 430B6E574DA;
        Fri, 24 Jun 2022 21:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Merge "types_are_compat" logic into
 relo_core.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165610621327.23875.11181851605708534492.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Jun 2022 21:30:13 +0000
References: <20220623182934.2582827-1-deso@posteo.net>
In-Reply-To: <20220623182934.2582827-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 23 Jun 2022 18:29:34 +0000 you wrote:
> BPF type compatibility checks (bpf_core_types_are_compat()) are
> currently duplicated between kernel and user space. That's a historical
> artifact more than intentional doing and can lead to subtle bugs where
> one implementation is adjusted but another is forgotten.
> 
> That happened with the enum64 work, for example, where the libbpf side
> was changed (commit 23b2a3a8f63a ("libbpf: Add enum64 relocation
> support")) to use the btf_kind_core_compat() helper function but the
> kernel side was not (commit 6089fb325cf7 ("bpf: Add btf enum64
> support")).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Merge "types_are_compat" logic into relo_core.c
    https://git.kernel.org/bpf/bpf-next/c/fd75733da2f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


