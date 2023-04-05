Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4041D6D86BD
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDETUj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDETUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 15:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8F527F
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 12:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA7063F12
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B8DC433D2;
        Wed,  5 Apr 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680722418;
        bh=liiFugCEvqMx+FR/82jWqy4SHHT/j7+iJBAjE789VbM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=awkb9ryZY6ZH38uK5jkh9lfwwnE1XELVFyyJHZ0j+Ijs9K/5z9bwcyWn6Nrgkg6iY
         5XKgYlLj1AJxtuZmxDlyLhtnviie3zVNKEoyaYh+KFLeO/kXPWAdSAFvTMabEXyK02
         wOBbBJThS3FmfIV+ClVyu3ZmDBLmbn+ELSiXE0r8Pfp2xhx1dqLjox38HrMVQzQ7IQ
         24yajfvBfx28RreIP1KaxM5V4nOBZXDDNdRRBjTaybj15/hXIfHqbiLNBIIfzScaZ6
         /yPGIDoUk2Aqncwqw6GsgI/f3wNMGtX5q62F6BmwzEZNfDINEXGqFPSDGikehBRJBr
         gdjgHipEYmc7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F01AE29F4E;
        Wed,  5 Apr 2023 19:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] selftests: xsk: Add test case for packets at end
 of UMEM
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168072241858.12939.4882404272620837331.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Apr 2023 19:20:18 +0000
References: <20230403145047.33065-1-kal.conley@dectris.com>
In-Reply-To: <20230403145047.33065-1-kal.conley@dectris.com>
To:     Kal Conley <kal.conley@dectris.com>
Cc:     bpf@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  3 Apr 2023 16:50:45 +0200 you wrote:
> This patchset fixes a minor bug in xskxceiver.c then adds a test case
> for valid packets at the end of the UMEM.
> 
> Kal Conley (2):
>   selftests: xsk: Use correct UMEM size in testapp_invalid_desc
>   selftests: xsk: Add test case for packets at end of UMEM
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests: xsk: Use correct UMEM size in testapp_invalid_desc
    https://git.kernel.org/bpf/bpf-next/c/7a2050df244e
  - [bpf-next,2/2] selftests: xsk: Add test case for packets at end of UMEM
    https://git.kernel.org/bpf/bpf-next/c/ccd1b2933f8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


