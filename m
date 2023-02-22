Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAC69FE1E
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBVWKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVWKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:10:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE524497
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40916CE1EFB
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 22:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A824C433EF;
        Wed, 22 Feb 2023 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677103817;
        bh=ZhdQRffPNPYSdRulAQPKRFE5YjykSPTjVE4jc5jlgAo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EpDty4hDnmk2RdMjCRNVm5vFVZJEhNmLc6ynw58/YJBScDAORxAucQ5+8UUjtuRdi
         1B+Ax1t8JYDgT3n5NbJLqfQ25m2u1+yP062Eloxm75X1kh2+hddvQMcLHh8yhLDjIZ
         82aMNuZRyesXeECJauQW4Rot/3a0ogioAyyzaXlGfCyR508/QB47B9dNvK6+LQuwjz
         cpV3yaemEQtojOxhnGPuxZdA1F0FdD3OJIpY96WKwOCYMe38rfRqQkYQ7MMLM/MI/6
         6tEfKcM6/jlj64hYnlnBhk1pNldu5WBNRkJHpZGHdVr/XbJ7wH8fsrlrd4ATmRsiin
         v09LUtHDn9LEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DA38C43151;
        Wed, 22 Feb 2023 22:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf, docs: Add explanation of endianness
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167710381737.10987.14706189590676732683.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 22:10:17 +0000
References: <20230220223742.1347-1-dthaler1968@googlemail.com>
In-Reply-To: <20230220223742.1347-1-dthaler1968@googlemail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com,
        void@manifault.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Feb 2023 22:37:42 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Document the discussion from the email thread on the IETF bpf list,
> where it was explained that the raw format varies by endianness
> of the processor.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, docs: Add explanation of endianness
    https://git.kernel.org/bpf/bpf-next/c/746ce7671285

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


