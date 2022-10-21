Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCDC606D6C
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 04:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJUCKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 22:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJUCKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 22:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3B11876B
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 19:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E922461D99
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 02:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C8C5C433D7;
        Fri, 21 Oct 2022 02:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666318217;
        bh=AVTl01TocOJcPmPGCD57pQ7lNnHuT9LkpxdGoKAYQZI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T3q8Mcnd9fSC2Dj2Ew1lEK6wE3U30K/2J8Ew8kIZoRJ3bVaJ325aTfh7syZ7rZjZu
         54aM+h2MFh9bMFBJfHqyTTKqF1UtgSHz25ovooa5O0hek/iaJcF7YwRbYJ7l+U5rvA
         ADpSH2/Adn3vNYZ6R65kCEhNKOeocL2K4kQNDuge8dOvdQvosDE1+GRiTJ62WY7Uu1
         iWNk2VnQ1NF2yrENABHnmsn0nWKic8b8lExfjeW/Pp6t/zEGqz1ga/zuH7dAxibZiP
         X7HEyxa69mbLmGqgfI+i8EqFxxMMb7gT7yTr63/L5eUxuTlCn/1PnGw8j8w5UNX6CB
         xIb24e06fJSYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19EF1E270E5;
        Fri, 21 Oct 2022 02:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix dispatcher patchable function entry to 5 bytes
 nop
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166631821710.26286.14324493023868146396.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 02:10:17 +0000
References: <20221018075934.574415-1-jolsa@kernel.org>
In-Reply-To: <20221018075934.574415-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        peterz@infradead.org, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Oct 2022 09:59:34 +0200 you wrote:
> The patchable_function_entry(5) might output 5 single nop
> instructions (depends on toolchain), which will clash with
> bpf_arch_text_poke check for 5 bytes nop instruction.
> 
> Adding early init call for dispatcher that checks and change
> the patchable entry into expected 5 nop instruction if needed.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix dispatcher patchable function entry to 5 bytes nop
    https://git.kernel.org/bpf/bpf/c/dbe69b299884

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


