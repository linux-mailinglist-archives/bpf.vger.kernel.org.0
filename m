Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AD56EAD47
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjDUOli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjDUOlY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 10:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559615616
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 07:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C41EE6513A
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A261C4339B;
        Fri, 21 Apr 2023 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682088021;
        bh=D2E5AvRaqZapJU9OzOA5P16raYhzJ7PigAaTtVuarzw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Yt8ysP49PI3NBnpGDx77blRpC25L5rQzZCGrZpCKnCIXH4Ic1atm/u2rxts11lqpy
         mkoUZcBAwI93mKWUYzy12Ggu3K0Pn1jEJ02vcBaoYXI5Zfrz6MKJaQLtREQcEiGwSa
         qDeQxDNXvi0lx5Z09H2Y2Ssff3gECzDuDXLFkXO35BtZHZMwn2CMKQib6XwDEUUeUI
         q0H1OKlKqrkpCHd2XUI+D4e2V2jBSlrTL95dyaVFno/87Sa07J4+7m2rlfmsnA1eWf
         aDhjpFflsnRzCMu1oEft7ICOxMk5Avu3iWjIL7czKV/wILRvPmOvaDRrJzu/ol2Y4N
         4e7UlMlGx1y2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 093DDC395EA;
        Fri, 21 Apr 2023 14:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_refcount_acquire's refcount_t address
 calculation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168208802103.4759.10849441890270501771.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Apr 2023 14:40:21 +0000
References: <20230421074431.3548349-1-davemarchevsky@fb.com>
In-Reply-To: <20230421074431.3548349-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
        fw@strlen.de, eddyz87@gmail.com
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 21 Apr 2023 00:44:31 -0700 you wrote:
> When calculating the address of the refcount_t struct within a local
> kptr, bpf_refcount_acquire_impl should add refcount_off bytes to the
> address of the local kptr. Due to some missing parens, the function is
> incorrectly adding sizeof(refcount_t) * refcount_off bytes. This patch
> fixes the calculation.
> 
> Due to the incorrect calculation, bpf_refcount_acquire_impl was trying
> to refcount_inc some memory well past the end of local kptrs, resulting
> in kasan and refcount complaints, as reported in [0]. In that thread,
> Florian and Eduard discovered that bpf selftests written in the new
> style - with __success and an expected __retval, specifically - were not
> actually being run. As a result, selftests added in bpf_refcount series
> weren't really exercising this behavior, and thus didn't unearth the
> bug.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix bpf_refcount_acquire's refcount_t address calculation
    https://git.kernel.org/bpf/bpf-next/c/4ab07209d5cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


