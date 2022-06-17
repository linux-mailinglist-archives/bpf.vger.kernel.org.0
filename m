Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7454EFAE
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 05:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiFQCkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 22:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiFQCkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 22:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D764D18
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 19:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A9A61D0E
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 02:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A2CC3411F;
        Fri, 17 Jun 2022 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655433614;
        bh=5iw4Q4y9LlGZJBVdpmFl3FlN7RYk7M4/NBaVy4uJH44=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FxwcdU2E4FrtoNfJ4lapKptTYw7rvsFAL9jeGoojmLnj0qSM/USGHV1PL9nwx2UQr
         1A1/XyVkJFlE8Y4npfLFXioVqie7+qB3dbj3B2GnEi1V/+mmOsSbHw0iI9V+c1D8Ey
         yeKx1X6ql5kM+LYDKMMcsi7gL4viBYLZmwif+zmtT4gmkZD9Jf9F/x2ART3Zy5X5HK
         xy5i0ffHkhdMH3kw1s8HnLOPx34gkgD7w7wJWr2P3bYaUSNFRSkBEiSjgHN7Ev4uEY
         4TIkFrPezvrAtlEMmXdHYTS2qbZVf/BQQpz89Qa4LOfl0QjL85yjOkZSva6dQ79rJ5
         w4q4CJI9Gbi+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5384E73858;
        Fri, 17 Jun 2022 02:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/5] sleepable uprobe support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165543361467.3693.12822289754642314492.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 02:40:14 +0000
References: <cover.1655248075.git.delyank@fb.com>
In-Reply-To: <cover.1655248075.git.delyank@fb.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Jun 2022 23:10:45 +0000 you wrote:
> This series implements support for sleepable uprobe programs.
> Key work is in patches 2 and 3, the rest is plumbing and tests.
> 
> The main observation is that the only obstacle in the way of sleepable uprobe
> programs is not the uprobe infrastructure, which already runs in a user-like
> context, but the rcu usage around bpf_prog_array.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/5] bpf: move bpf_prog to bpf.h
    https://git.kernel.org/bpf/bpf-next/c/d687f621c518
  - [bpf-next,v4,3/5] bpf: allow sleepable uprobe programs to attach
    https://git.kernel.org/bpf/bpf-next/c/64ad7556c75e
  - [bpf-next,v4,5/5] selftests/bpf: add tests for sleepable (uk)probes
    https://git.kernel.org/bpf/bpf-next/c/cb3f4a4a462b
  - [bpf-next,v4,2/5] bpf: implement sleepable uprobes by chaining gps
    https://git.kernel.org/bpf/bpf-next/c/8c7dcb84e3b7
  - [bpf-next,v4,4/5] libbpf: add support for sleepable uprobe programs
    https://git.kernel.org/bpf/bpf-next/c/c4cac71fc8a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


