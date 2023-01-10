Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646CE664EA4
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjAJWUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 17:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjAJWUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 17:20:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93285D88A;
        Tue, 10 Jan 2023 14:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87C4561776;
        Tue, 10 Jan 2023 22:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B0FC433F1;
        Tue, 10 Jan 2023 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673389216;
        bh=e2KXMfeCUsy88kY1AtG2SpevSBk1HRL7c3Mu2VWEfGY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HFQLoDmn4XEv516NOKsHCJxwh7/cGlItfX1uajvCDDQP57VWuEotc/D5ule4EWpDh
         gI6NtNNxfxz6wxsNjf/dvNDz7A4irC/NTVDG+qLTjZwpK8xhmOyG4M8od9vM1lcw5b
         ZbJOnnKneXiRENQFTO+lo+g8aO0GAWoH5qKlgh/ZLLde4CjHmwL0B2eMgnLmqTIkFu
         xxcd4z7wlWdwbLGphV4K+sB1AhiIYCOeEJ54crWrP0HbY7bzgyEDKmszTtg3IR5RJJ
         prppSsxBuyggkrjuID+2wHy+7keHEbn6RvfgynH8yL80T8GIM1s64FusaMTrBZeBuk
         C//qfXcw1yrqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4ECCE524EE;
        Tue, 10 Jan 2023 22:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Add missing quotes to libbpf bootstrap
 submake vars
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167338921673.701.12107538921325787327.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Jan 2023 22:20:16 +0000
References: <20230110014504.3120711-1-james.hilliard1@gmail.com>
In-Reply-To: <20230110014504.3120711-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, quentin@isovalent.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
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

On Mon,  9 Jan 2023 18:45:04 -0700 you wrote:
> When passing compiler variables like CC=$(HOSTCC) to a submake
> we must ensure the variable is quoted in order to handle cases
> where $(HOSTCC) may be multiple binaries.
> 
> For example when using ccache $HOSTCC may be:
> "/usr/bin/ccache /usr/bin/gcc"
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Add missing quotes to libbpf bootstrap submake vars
    https://git.kernel.org/bpf/bpf-next/c/af0e26beaa69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


