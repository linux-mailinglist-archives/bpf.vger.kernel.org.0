Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF14C04C4
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 23:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiBVWkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 17:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiBVWkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 17:40:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E21275C4
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 14:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4C6760AFA
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 22:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AB4FC340EF;
        Tue, 22 Feb 2022 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645569610;
        bh=dt5IKw3nwD+fGVNbz38TktRMrHAHi40v21Uo2X0lEyE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U74PREwi/e2VCS85omlou9u2O09bvgoW8+P2duO+jM94LGG/l+CSASaoOSC0SgT12
         fiifl7uIw/qXBoVNkS9u9VVcmFPbNLV6NaLxT5wYshe8PAdeiU7J7NjyOHYu2Q3XcO
         JEbz5gmIUn3DD/PgRQDz0hHDM6JltjI98M6d2FsVlT4HyKAE1r/BcP6CjKZ/BFYt8u
         /uSDOS50Rp9NLEz13/jmZRyEvBUoGL4mEFAzflwbAD3QkGnZlNWHAiQVBoquCINFQN
         IRJ0DFcOMumG6rgkWf2tRs++aWVC8grkV2AsjXBcpB605ZdO81xILOm2/CvFPZ2UFY
         VhE0uZNYD/uBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F332FE73590;
        Tue, 22 Feb 2022 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Remove redundant check in
 btf_fixup_datasec()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164556960999.25883.2769876686293413359.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Feb 2022 22:40:09 +0000
References: <20220220072750.209215-1-ytcoode@gmail.com>
In-Reply-To: <20220220072750.209215-1-ytcoode@gmail.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 20 Feb 2022 15:27:50 +0800 you wrote:
> The check 't->size && t->size != size' is redundant because if t->size
> compares unequal to 0, we will just skip straight to sorting variables.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: Remove redundant check in btf_fixup_datasec()
    https://git.kernel.org/bpf/bpf-next/c/6966d4c4425b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


