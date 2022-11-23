Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14D1636C9A
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiKWVuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiKWVuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:50:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57D391DC;
        Wed, 23 Nov 2022 13:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 324A0CE27AF;
        Wed, 23 Nov 2022 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EA87C433B5;
        Wed, 23 Nov 2022 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669240216;
        bh=3LSSRgZSld/tV8zacrq4t/+3c7qpcv4KkJalQ0f9+eo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DatZu5ZS9k931BvNVNRSYDbE99rIQ7H+/5MRu6O7wQQC4/XUEOzAszQX+kuoT5CQA
         42twU8ytY/56HvI67cXbXJgzFbbtgXGb/m9MjBxTlnu8unFYGbqrVcAxGRScR6hIe7
         TZuAsduCErJljB+5ZwwXqLqH+vp758E0t0SHPl+gEzCH0GdwQDtyAQ2KdkG4YjtAwv
         L3Q1bZ4y69z54aVao7Jy0Ecg4rrmjOf0PajnDRkH3kS8K1NDNUY8e8/zUUPaAp1TIb
         FT3FELLjyQtLDfoDBDG3i4XKQGwca0LpoSgnodoeLs1hcSsro1XrUJkW9+pCwGDfDw
         0G6s53M3T313w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBCBAE21EFD;
        Wed, 23 Nov 2022 21:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf, docs: Document BPF_MAP_TYPE_BLOOM_FILTER
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166924021596.18548.15812705164474691942.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Nov 2022 21:50:15 +0000
References: <20221123141151.54556-1-donald.hunter@gmail.com>
In-Reply-To: <20221123141151.54556-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
        joannelkoong@gmail.com
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

On Wed, 23 Nov 2022 14:11:51 +0000 you wrote:
> Add documentation for BPF_MAP_TYPE_BLOOM_FILTER including
> kernel BPF helper usage, userspace usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Acked-by: Joanne Koong <joannelkoong@gmail.com>
> ---
> v2 -> v3:
> - Use NULL instead of 0 and show use of bpf_map__fd()
>   as suggested by Joanne Koong
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf, docs: Document BPF_MAP_TYPE_BLOOM_FILTER
    https://git.kernel.org/bpf/bpf-next/c/264c21867a0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


