Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBDB53AC19
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355099AbiFARkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 13:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiFARkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 13:40:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B8A8BD0B;
        Wed,  1 Jun 2022 10:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88A76B81BDE;
        Wed,  1 Jun 2022 17:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1136CC3411A;
        Wed,  1 Jun 2022 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654105212;
        bh=oTUuML0O/1hr8HWgqfJsC1FnDd3KKlXzLKJgVCi8EnQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KxiMsn3RAujdZiMgUXHtt2Pvo9+qXlsoIwRGN0OWtIvDHXToxxbQnExMo8WYs3OOA
         c3QqXB1zW1uNm4mPPc0xb8wai6/HC5XSctlhpvvgrvHemTYcaGCP1eH9iR9FktqLeU
         pv+b1AT+Z8fg0MkRTVtCYceIl09Hqy97tsjwd8543oZKtPfoCNha7NXZseUhVDyeSY
         dl2SvS0yfVtam4ZiLE8CqhoawjrRv+Of35idPxhtspaPWvXRPBRvp+tFs6ZmtK7b4K
         nDez6n5k/y/KdC2/PyM/qmVUg1Q4lKRxeemRcva1VcspJtI/B8imGMhZoX+vv3k8hp
         qPPolfvdBw56w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6F26F03944;
        Wed,  1 Jun 2022 17:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Use safer kvmalloc_array() where possible
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165410521194.30201.11937018315611831076.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Jun 2022 17:40:11 +0000
References: <Yo9VRVMeHbALyjUH@kili>
In-Reply-To: <Yo9VRVMeHbALyjUH@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     rostedt@goodmis.org, jolsa@kernel.org, mingo@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 26 May 2022 13:24:05 +0300 you wrote:
> The kvmalloc_array() function is safer because it has a check for
> integer overflows.  These sizes come from the user and I was not
> able to see any bounds checking so an integer overflow seems like a
> realistic concern.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [...]

Here is the summary with links:
  - bpf: Use safer kvmalloc_array() where possible
    https://git.kernel.org/bpf/bpf-next/c/dafd0f870eae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


