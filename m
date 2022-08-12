Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5D591438
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiHLQuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbiHLQuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 12:50:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903E5FAB
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 09:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03891B82476
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4BB0C433D7;
        Fri, 12 Aug 2022 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660323014;
        bh=QSmSsjCijdrl13JsaW8tnoBT7pKXi4T8Nu+no25W640=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g288IfhH0w7g/UX7EU8Immm6rEiSYq4n16AdVJptNlOb6jTiwfI6p34QrJdiIgujn
         lp1ynlMCfEkes6Oybf64QO84VOkq1rIk2HIzY0J/HW9hwE28HYUPyzrJuPUqC5qzIL
         w2wU8meHSc72tmN0neSNzacFbTYdKC/yw5VAwjf05kEgGqni3zxKZnMCnelrLH6oMG
         EwTnDg7WmkmRFJKPGct89GW08V/6IR2WZa01/3YWQEDAWt4QTIzu1AcTSIHYpB9tCt
         sntmrAU/8JdU3GiyvVDupEbnvADjf3qbY/UFePMGnN6qoUcc3cmrwqLkoIdNtctkfq
         ZY8w/XQFfP6Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A06BC43141;
        Fri, 12 Aug 2022 16:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Add lru_bug to s390x deny list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166032301462.8174.3605479061639065308.git-patchwork-notify@kernel.org>
Date:   Fri, 12 Aug 2022 16:50:14 +0000
References: <20220810200710.1300299-1-deso@posteo.net>
In-Reply-To: <20220810200710.1300299-1-deso@posteo.net>
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

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Aug 2022 20:07:10 +0000 you wrote:
> The lru_bug BPF selftest is failing execution on s390x machines. The
> failure is due to program attachment failing in turn, similar to a bunch
> of other tests. Those other tests have already been deny-listed and with
> this change we do the same for the lru_bug test, adding it to the
> corresponding file.
> 
> Fixes: de7b9927105b ("selftests/bpf: Add test for prealloc_lru_pop bug")
> Signed-off-by: Daniel Müller <deso@posteo.net>
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Add lru_bug to s390x deny list
    https://git.kernel.org/bpf/bpf/c/27e23836ce22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


