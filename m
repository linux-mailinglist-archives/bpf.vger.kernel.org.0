Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE5754F2B0
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 10:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380689AbiFQIUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380805AbiFQIUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 04:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EBD68339
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 01:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFED661FCC
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 08:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 561CCC3411C;
        Fri, 17 Jun 2022 08:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655454019;
        bh=PisZaR7INviAxSVBFS68RPIx3CSnV3jhT6alRRkI+rQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qXbULmd2ucdMxLdXiV72fVeBHHYGZrLaB5D75Uhhaqj9n9qaLNl009udjAR1OeIgx
         48pvVKp0sj9agBDijIp1sq9CETs5hb24jz3K57LAy1/UE3ssUqpgdUM3XONTtxxM2g
         fDGMGLsHqZ7aODoo7A7D4l8UkQ5dUsV6RAqQDjHUnNHNoNW1u6Ss5aY6AlbMpEi0kM
         umniDRtNvaocZAJI17tRdF4szuWSqiFxTPHVKnzeO1NggChWf3DxAltWHW7HbwbPWe
         NJamY1NuN/iEYKoCEtBtIwAc/vJ9pSBU/ESORvXl/icr9rkGAG6nd1Ej2lycIFZreC
         tfldMVI1vfD1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4369BE56ADF;
        Fri, 17 Jun 2022 08:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: don't force lld on non-x86
 architectures
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165545401927.26881.3602712890358836747.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 08:20:19 +0000
References: <20220617045512.1339795-1-andrii@kernel.org>
In-Reply-To: <20220617045512.1339795-1-andrii@kernel.org>
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

On Thu, 16 Jun 2022 21:55:12 -0700 you wrote:
> LLVM's lld linker doesn't have a universal architecture support (e.g.,
> it definitely doesn't work on s390x), so be safe and force lld for
> urandom_read and liburandom_read.so only on x86 architectures.
> 
> This should fix s390x CI runs.
> 
> Fixes: 3e6fe5ce4d48 ("libbpf: Fix internal USDT address translation logic for shared libraries")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: don't force lld on non-x86 architectures
    https://git.kernel.org/bpf/bpf-next/c/08c79c9cd67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


