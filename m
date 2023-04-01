Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A3F6D3287
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjDAQKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAQKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 12:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591CD1C1DE
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 09:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD57560F11
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 16:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E6C5C433D2;
        Sat,  1 Apr 2023 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680365418;
        bh=2ZiSBkSa25uepABMyvo9Yv2Bt5sobBvkvUvSPse0TTo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TJ027lMNNWR4RnVz9lTGWxgoT44JHbVUfP49ThzRmUuOG1PP81EdZsoMWbvPlJD8o
         Te31NWhMK82GljNWHNiyGxbCvCJXbzj5VjPmouO3cZ1CUvUYS2vThdaqU62lysB1Oo
         fO2CBE7qqiMJWDtz0FtFebXGgNTfCGQGtI7rJUdLVQlNBoyttfDIrZPXnGPqfa2gJR
         V2qX1PbNYGIW5QnWzjiS1hN0loJ2Ua9RkPq5VTbVwJd4m4frEurAV4F0D8vv160NmO
         anGzaSK0OLPd85TCeq1x/ZULxnEmNG18FFxMKskrq4BCrKmIJ+STnrc3e6n8TzR0ap
         9+l5JE7CrdjyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21891E21EDD;
        Sat,  1 Apr 2023 16:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/4] Prepare veristat for packaging
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168036541813.11449.2467991013604082293.git-patchwork-notify@kernel.org>
Date:   Sat, 01 Apr 2023 16:10:18 +0000
References: <20230331222405.3468634-1-andrii@kernel.org>
In-Reply-To: <20230331222405.3468634-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 31 Mar 2023 15:24:01 -0700 you wrote:
> This patch set relicenses veristat.c to dual GPL-2.0/BSD-2 license and
> prepares it to be mirrored to Github at libbpf/veristat repo.
> 
> Few small issues in the source code are fixed, found during Github sync
> preparetion.
> 
> v2->v3:
>   - fix few warnings about uninitialized variable uses;
> v1->v2:
>   - drop linux/compiler.h and define own ARRAY_SIZE macro;
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/4] veristat: relicense veristat.c as dual GPL-2.0-only or BSD-2-Clause licensed
    https://git.kernel.org/bpf/bpf-next/c/3ed85ae80283
  - [v3,bpf-next,2/4] veristat: improve version reporting
    https://git.kernel.org/bpf/bpf-next/c/71c8c39f5177
  - [v3,bpf-next,3/4] veristat: avoid using kernel-internal headers
    https://git.kernel.org/bpf/bpf-next/c/e3b65c0c1a5b
  - [v3,bpf-next,4/4] veristat: small fixed found in -O2 mode
    https://git.kernel.org/bpf/bpf-next/c/ebf390c9d013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


