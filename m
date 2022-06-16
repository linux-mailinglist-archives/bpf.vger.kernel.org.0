Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718A854EDE9
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 01:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379384AbiFPXaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiFPXaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 19:30:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF93360041
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 16:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CBA2B82684
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 23:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45D52C3411C;
        Thu, 16 Jun 2022 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655422213;
        bh=CTWNvAtNecLjEtreg0TddeurtcPXXRgLeZJrFOPPmTM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DVLI8CVir3JMTGBJ9Xh99Xoz0y4QV193xOlrHwTm7ighVhtqvpol3ncRNC33MBUEp
         qCMGo40OsgL/RqGXN2U3Z7uWkeKznQQWyFCSKTLK9lnuoj7+oInU7pnOLOJoG9dp9y
         JODGFsfav/68sIvS6MzcFdNcrzwVNWm5zqQoJ/vX1qWI7ytC29DoEr+Y+AvuyZ46F4
         Y6jeVAmn6SN1d7BqpmBi5IHQv0d9cgXZ8/3GTAsXZvoSx03rUuBsTQxZMfDTFXGutp
         kCYxHOtOTdQ9hjXV09zpru1XS2tn2PNFMpfHxODowv4GpraqYDnlYtrXcPu5zalcis
         0F+RImDKP+5Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27F2FE7385C;
        Thu, 16 Jun 2022 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix internal USDT address translation logic
 for shared libraries
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165542221315.19703.5480668751425967007.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Jun 2022 23:30:13 +0000
References: <20220616055543.3285835-1-andrii@kernel.org>
In-Reply-To: <20220616055543.3285835-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 15 Jun 2022 22:55:43 -0700 you wrote:
> Perform the same virtual address to file offset translation that libbpf
> is doing for executable ELF binaries also for shared libraries.
> Currently libbpf is making a simplifying and sometimes wrong assumption
> that for shared libraries relative virtual addresses inside ELF are
> always equal to file offsets.
> 
> Unfortunately, this is not always the case with LLVM's lld linker, which
> now by default generates quite more complicated ELF segments layout.
> E.g., for liburandom_read.so from selftests/bpf, here's an excerpt from
> readelf output listing ELF segments (a.k.a. program headers):
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix internal USDT address translation logic for shared libraries
    https://git.kernel.org/bpf/bpf-next/c/3e6fe5ce4d48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


