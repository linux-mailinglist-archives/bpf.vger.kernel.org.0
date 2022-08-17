Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E437B597865
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiHQVAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242111AbiHQVAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:00:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34E44577
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB73EB81F6B
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 21:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98BECC433D7;
        Wed, 17 Aug 2022 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660770016;
        bh=9y42iHAZAne97KeBKLMNxKPoZQxVAWYHxZZRd4Cvh10=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ltk1w81KaMp7ILJTq9sTL3Zl4fTfwD65+W2KKeqyN2kP8x+pkhhNPZ0as58CgoDNd
         39METg1JYZ7kATXRFZtjJlioFFuViw4DNFe69ju99HUWDlSrJ4ty9l7Ls88TWLPZ7i
         GNzC05zZW4+gsKUfW5q2MxrndOMM2j7WGojDQBLiDtMBwDIXVBX9AbuTnb5AXSvjuK
         Xa2UYExmorWiE8+23TIMzm3kDAtkEBatcfT4kpOrLxPCW0NnVRR6ERTEsXlUWdniHn
         DdqYKUDdMcqoHSQHNagPHg+odRPSdPONyve9MbexEAojWMqISqyzgzX1A8QD8citSq
         v4JWoBASDW/Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7380EE2A053;
        Wed, 17 Aug 2022 21:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] Preparatory libbpf fixes and clean ups
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166077001646.24755.9118958959698337211.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Aug 2022 21:00:16 +0000
References: <20220816001929.369487-1-andrii@kernel.org>
In-Reply-To: <20220816001929.369487-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Aug 2022 17:19:25 -0700 you wrote:
> Few fixes and clean up in preparation for finalizing libbpf 1.0.
> 
> Main change is switching libbpf to initializing only relevant portions of
> union bpf_attr for any given BPF command. This has been on a wishlist for
> a while, so finally this is done. While cleaning this up, I've also cleaned up
> few other placed were we didn't use explicit memset() with kernel UAPI structs
> (perf_event_attr, bpf_map_info, bpf_prog_info, etc).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] libbpf: fix potential NULL dereference when parsing ELF
    https://git.kernel.org/bpf/bpf-next/c/d4e6d684f3be
  - [bpf-next,2/4] libbpf: streamline bpf_attr and perf_event_attr initialization
    https://git.kernel.org/bpf/bpf-next/c/813847a31447
  - [bpf-next,3/4] libbpf: clean up deprecated and legacy aliases
    https://git.kernel.org/bpf/bpf-next/c/abf84b64e36b
  - [bpf-next,4/4] selftests/bpf: few fixes for selftests/bpf built in release mode
    https://git.kernel.org/bpf/bpf-next/c/df78da27260c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


