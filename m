Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5135A190D
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiHYSuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiHYSuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 14:50:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE4E61B2E
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEC6EB82A2E
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 18:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E250C433D7;
        Thu, 25 Aug 2022 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661453414;
        bh=iYiDU+pAxnCfis/zsG2hbudQFaPIkmRgl457Nr4Kh6k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QAfAoO+ZaOD+M/2/4B3PpCwx3MHt7Gk2cmspkTbTV7LiEAb4s3LbTXZiy88cpaQrh
         lsQxKGP3kf14cKTsviMliJCaQF1fIyAjy+9GM75m6QuwGXEd22ifK+Zy0+zpmLrMl/
         MC8KpownrTu3o6RKMuFUDYY35NHHJmD9a2MGADeBd9KMMrahVcdidfKIG3/uLJU38v
         9sHMDcTY/6fiDodPfqzoWj1sYkFpdkZ3fjw0qWAvpRtPDP/0JpjUyJKQIcU7RK4Fiy
         mUgLEMST2Dl5sXR+x6io0UrY/zQhY/wpZRa4nEEsHKRwUoZJ8KdQrwm92sS///5y3h
         53q5fPV/DkHqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78C0EE2A03C;
        Thu, 25 Aug 2022 18:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: fix a wrong type cast in btf_dumper_int
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166145341449.1683.135861062095794396.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Aug 2022 18:50:14 +0000
References: <20220824225859.9038-1-lamthai@arista.com>
In-Reply-To: <20220824225859.9038-1-lamthai@arista.com>
To:     Lam Thai <lamthai@arista.com>
Cc:     bpf@vger.kernel.org
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

On Wed, 24 Aug 2022 15:59:00 -0700 you wrote:
> When `data` points to a boolean value, casting it to `int *` is problematic
> and could lead to a wrong value being passed to `jsonw_bool`. Change the
> cast to `bool *` instead.
> 
> Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
> Signed-off-by: Lam Thai <lamthai@arista.com>
> 
> [...]

Here is the summary with links:
  - bpftool: fix a wrong type cast in btf_dumper_int
    https://git.kernel.org/bpf/bpf-next/c/7184aef9c0f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


