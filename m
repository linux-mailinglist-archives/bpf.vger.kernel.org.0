Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC957507EC3
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 04:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbiDTCXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 22:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 22:23:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BD240AA
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 19:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8FCBB81A37
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 02:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D6B2C385A7;
        Wed, 20 Apr 2022 02:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650421214;
        bh=F30Y4gFEIEbwRBb/Hz0eZ3hKOIJgfR0i0sj9R0Upo3E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CJ/x2wG9tGAhH3UhYxnEY6UVuSv4Cb/EjMyleFYEyBI9IibAPM99btVS8YUB70l7+
         ojgLSF8Ui/8goz+kFLqQDIrP/4vqO5veuXj242+WIxfk5t5YE8rmoSj22qx0mN5TOL
         Ym1/Cxu5hvpzHE1KNmxGuJxuTohUyVikN+DkqGYoLjKjxPErPrBjDbdOZht59KL7MB
         wqWB6WRM3uh70drgEF+UG5D9vr1U359qbFv/ojgL26paXI5C1hLj8bOx2YCwQkl1sJ
         2hJYckhhta25ZR+HK3DMs9xTOhonJi5mfD/tr2jiY5wO3NW8pV5Pscz/8nu4J2qAOP
         A7zCenlFKimsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4197BE8DD85;
        Wed, 20 Apr 2022 02:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Fix usage of trace RCU in local storage.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165042121426.6220.2629850433776945235.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 02:20:14 +0000
References: <20220418155158.2865678-1-kpsingh@kernel.org>
In-Reply-To: <20220418155158.2865678-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, sdf@google.com,
        edumazet@google.com
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

On Mon, 18 Apr 2022 15:51:58 +0000 you wrote:
> bpf_{sk,task,inode}_storage_free() do not need to use
> call_rcu_tasks_trace as no BPF program should be accessing the owner
> as it's being destroyed. The only other reader at this point is
> bpf_local_storage_map_free() which uses normal RCU.
> 
> The only path that needs trace RCU are:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Fix usage of trace RCU in local storage.
    https://git.kernel.org/bpf/bpf-next/c/dcf456c9a095

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


