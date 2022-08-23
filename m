Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949A359EFB9
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 01:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiHWXaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiHWXaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 19:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827E16D562
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F136B82237
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 23:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0FB6C433D6;
        Tue, 23 Aug 2022 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661297417;
        bh=NEy3ii9Kz5XLdZJIoXvC+uELX/FTehNc7KqNprvvbEM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ailXZ5JrcUg+zsX3nUXafWfxAxIu20CDlaQr0kBfPfUt9jiEDuHC8jwSKk0qQcf2o
         TfaPCY/x0YuPhZ6FDjdqFexg+jIuzvfLw5OrA8RpaRymYvg48VD8vjEo7XMPUoeeOH
         iXaHB1m/8Db9uNes6iSxGreoOWB+UDzYwe4AMbpQet/FxVIGqFV55gP4/uZy0RuvhN
         xD9Tf1dITghtKE6WZPI593HQI8Rs65KIP+tWfMxPv+/h13YtIj0rV44Nz8/OTB4H8u
         Gmj/xJO2oBsShEybbPleMzR/1dz/xIqerjX3ku27JLtvGGpsK2MEAcMq8RLML7PQrH
         X+SefivSsRhXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB60BC004EF;
        Tue, 23 Aug 2022 23:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/3] Fix reference state management for synchronous
 callbacks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166129741676.15279.2242567262096963454.git-patchwork-notify@kernel.org>
Date:   Tue, 23 Aug 2022 23:30:16 +0000
References: <20220823012759.24844-1-memxor@gmail.com>
In-Reply-To: <20220823012759.24844-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, yhs@fb.com, andrii@kernel.org,
        daniel@iogearbox.net
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
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Aug 2022 03:27:56 +0200 you wrote:
> This is patch 1, 2 + their individual tests split into a separate series from
> the RFC, so that these can be taken in, while we continue working towards a fix
> for handling stack access inside the callback.
> 
> Changelog:
> ----------
> v1 -> v2:
> v1: https://lore.kernel.org/bpf/20220822131923.21476-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/3] bpf: Move bpf_loop and bpf_for_each_map_elem under CAP_BPF
    https://git.kernel.org/bpf/bpf-next/c/5679ff2f138f
  - [bpf,v2,2/3] bpf: Fix reference state management for synchronous callbacks
    https://git.kernel.org/bpf/bpf-next/c/2e5e0e8ede02
  - [bpf,v2,3/3] selftests/bpf: Add tests for reference state fixes for callbacks
    https://git.kernel.org/bpf/bpf-next/c/3cf7e7d8685c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


