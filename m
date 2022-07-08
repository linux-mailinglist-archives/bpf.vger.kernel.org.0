Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3D56B9B7
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiGHMaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiGHMaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 08:30:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A9E32063
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 05:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 397ECB826A6
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 12:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1DBCC341C6;
        Fri,  8 Jul 2022 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657283413;
        bh=xvYSx7M2XOAdBfMMzkLnfzgN2nvf/UZ+Dc8LVh2/ipw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xb/efqlGUgLM/EFKqvIFR9Bzud0NPvrLKbefUQDBcWHkTxOYgrBOpL4/QOkVvc2g4
         yiQGI4ubtBr/e6cMq1IIuS97eKoSxE4HSBve0aADR6yo68E0Rhodujz1NEB0KJdBFb
         PVuOAimip8y135Yl3Oxn2MMbzhXst8warkEucUGB358t8tSuS5sa9JKB9OuwqGGQmc
         x2dG79LgFdDyOWQ3qrcRxHPJjo9km6hpzOdnNv1iGrOJl90VGIhSXUbXdQWxb8/zRC
         jNUBvdYYozns2QxN3BSzTUyneK7u7qTm8lmJ8bawgCIi5Wim8X0jfijh9phPx74HML
         ZWOLiH1PQ0WDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6034E45BDB;
        Fri,  8 Jul 2022 12:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Add KIND_RESTRICT support to bpftool
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165728341380.9693.240247319448145589.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Jul 2022 12:30:13 +0000
References: <20220706212855.1700615-1-deso@posteo.net>
In-Reply-To: <20220706212855.1700615-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, quentin@isovalent.com, kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed,  6 Jul 2022 21:28:53 +0000 you wrote:
> As pointed out in an earlier discussion [0] not all paths in bpftool's
> minimization logic handle the restrict type qualifier properly. Specifically,
> the gen min_core_btf command fails when encountering the corresponding BTF kind
> for a TYPE_EXISTS relocation (TYPE_MATCHES support was added earlier):
>   > Error: unsupported kind: restrict (26)
> 
> This patch set fixes this short coming.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpftool: Add support for KIND_RESTRICT to gen min_core_btf command
    https://git.kernel.org/bpf/bpf-next/c/aad53f17f0ad
  - [bpf-next,2/2] selftests/bpf: Add test involving restrict type qualifier
    https://git.kernel.org/bpf/bpf-next/c/32e0d9b31048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


