Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927715B4B2C
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiIKBUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 21:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIKBUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 21:20:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CB27B0C
        for <bpf@vger.kernel.org>; Sat, 10 Sep 2022 18:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A1E1B80AFD
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18069C43145;
        Sun, 11 Sep 2022 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662859215;
        bh=4i6ZPnl9V/2gQZxHnTVJmPtatkS2rretsZxfXu3b5po=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Jt+TODKCMOtBjouFaHQwjBZn7OS6nyfFP8swrTq6iQWke/LdyPpZ6qYJe8HMjTvw3
         IjluO8EAVtV8w59jZhZokqbYy5kr/N+gfgmbXhCn8g0A7WzujJay62ZtlUgn0bGCIZ
         tRBbRI9tWXHxSAhZT2ILxlKIQvNF+sgZS105dZmbiA2ao6cPnIyYFCDtkS7waFmypY
         euYED7rg5DpGBTuIQ+quJTuEVQUSoajzs/ONvLImri4WBDRbWFn6O3Q9/l/DnAdIwE
         Tvz/MWQF8Rw2ZeZB/uBxOx16PzdstFvTHP+HF0fUQ+TVE8DKcjtrJWZ2A6RPXeAQwQ
         EjuJb14QpTuuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03C1EC73FE7;
        Sun, 11 Sep 2022 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add verifier support for custom callback return
 range
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166285921501.4256.11659975514776593626.git-patchwork-notify@kernel.org>
Date:   Sun, 11 Sep 2022 01:20:15 +0000
References: <20220908230716.2751723-1-davemarchevsky@fb.com>
In-Reply-To: <20220908230716.2751723-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, joannelkoong@gmail.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 8 Sep 2022 16:07:16 -0700 you wrote:
> Verifier logic to confirm that a callback function returns 0 or 1 was
> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
> At the time, callback return value was only used to continue or stop
> iteration.
> 
> In order to support callbacks with a broader return value range, such as
> those added in rbtree series[0] and others, add a callback_ret_range to
> bpf_func_state. Verifier's helpers which set in_callback_fn will also
> set the new field, which the verifier will later use to check return
> value bounds.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add verifier support for custom callback return range
    https://git.kernel.org/bpf/bpf-next/c/1bfe26fb0827

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


