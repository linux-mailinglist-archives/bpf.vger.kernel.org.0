Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98F573F25
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiGMVuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 17:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGMVuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 17:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358D2D1D4
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 14:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DE5DB821F2
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 21:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3302C3411E;
        Wed, 13 Jul 2022 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657749013;
        bh=FKQlZmUpuj16VWW4ogNgyHqClK0E4wN2XQ6twD7WW3s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=esPZpaQYyfhBAd1Tw9p/REoyizobRnbIwzHSUyoq6KVUQCaKeUZzDqJTWYGSSEiv7
         01dp1nWSBT78H9FXccC88ZlV0+R90md/XwC9X/DMet58gs91SlcnQ2zumFvdZEu8PA
         WocOryEHS/TT2nyK7TGyCLqmRF/GfUWbrB3YcRX3fKZ1B5lzDnFIeoMM+odv/WQAIk
         vyKaTcHNU1+STnT4p9Rq6MsJTxBV385AI+4gMxD04Yw9B9gX9lECla84+HeDGR6FSs
         LO+2lwIgz2EN+lCumH53sXNAH6WuwwbKt/TQU4kvmJYHva3qSIsOo8OC1N6PYVm/RZ
         Ts6DcHSNoxIvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90EF6E4521F;
        Wed, 13 Jul 2022 21:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165774901358.25717.4610073010196790006.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Jul 2022 21:50:13 +0000
References: <20220712210603.123791-1-joannelkoong@gmail.com>
In-Reply-To: <20220712210603.123791-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Jul 2022 14:06:03 -0700 you wrote:
> This patch does two things:
> 
> 1. For matching against the arg type, the match should be against the
> base type of the arg type, since the arg type can have different
> bpf_type_flags set on it.
> 
> 2. Uses switch casing to improve readability + efficiency.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: Tidy up verifier check_func_arg()
    https://git.kernel.org/bpf/bpf-next/c/8ab4cdcf03d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


