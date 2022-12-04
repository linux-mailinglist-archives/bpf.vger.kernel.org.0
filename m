Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C14641FB3
	for <lists+bpf@lfdr.de>; Sun,  4 Dec 2022 22:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLDVAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 16:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiLDVAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 16:00:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC1612A9A
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 13:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D60DB80C03
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 21:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99592C433D7;
        Sun,  4 Dec 2022 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670187615;
        bh=oY+wE7OtYAI3Lm0sGWWz0MQFh2bYtSYOUB2Po3Wa/9Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PhC3NTSS7kQ8U20h/EPE1GoxZxJN5TBSwMxnUO2MstFh4j0ksxUf89SLP91Geu9AU
         du2baH8n++j0a6GCbwZHHLcW4u69XQcnRrC3wzWkjHz2O1X/5h/BuoJJ/Ak6g+MUU0
         shSsyQhliCs13TQb8SAEvERUZK1fS6GK2d9X9k7+LIEoj6OTVWcv0AYkDAxCyipCcX
         UF6SJErzYXLbkIBEVNswqXKDIB3qv/vx1TAubwglhz2NG6l4OSWEvaQAJqogp68hse
         Lrj+QjQn9w8Y04EpZPznnHjqvBXRN3bto+4uJ9FxVzHcC2cYt2yie0zKTwGaUD1bPw
         a9N8aKdYhkY8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70F6DE21EF9;
        Sun,  4 Dec 2022 21:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Handle MEM_RCU type properly
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167018761545.21113.14652815039544773708.git-patchwork-notify@kernel.org>
Date:   Sun, 04 Dec 2022 21:00:15 +0000
References: <20221203184557.476871-1-yhs@fb.com>
In-Reply-To: <20221203184557.476871-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 3 Dec 2022 10:45:57 -0800 you wrote:
> Patch set [1] added rcu support for bpf programs. In [1], a rcu
> pointer is considered to be trusted and not null. This is actually
> not true in some cases. The rcu pointer could be null, and for non-null
> rcu pointer, it may have reference count of 0. This small patch set
> fixed this problem. Patch 1 is the kernel fix. Patch 2 adjusted
> selftests properly. Patch 3 added documentation for newly-introduced
> KF_RCU flag.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Handle MEM_RCU type properly
    https://git.kernel.org/bpf/bpf-next/c/fca1aa75518c
  - [bpf-next,v2,2/3] selftests/bpf: Fix rcu_read_lock test with new MEM_RCU semantics
    https://git.kernel.org/bpf/bpf-next/c/8723ec22a31d
  - [bpf-next,v2,3/3] docs/bpf: Add KF_RCU documentation
    https://git.kernel.org/bpf/bpf-next/c/f53625649888

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


