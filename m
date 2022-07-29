Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC45856E3
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 00:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiG2WkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiG2WkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 18:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C737F59C;
        Fri, 29 Jul 2022 15:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E3F6206B;
        Fri, 29 Jul 2022 22:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57793C433D7;
        Fri, 29 Jul 2022 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659134413;
        bh=DjpMjDYex2G7pKdd+dC6ubQonyPPKqP5ucACj1mGqFA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=omNdc5n0Qjw3Rp64yk5XF7uRaYZ1NVpgbOlpjF3LFyVe4yiyzlxiVfwwL6Vtyc2O2
         s4Zv71g3uh1Y/k9EwIbvvfjB1OJHQR6j7JG5uxYnDV2tYNiMtnTvZY2wkE/UvKvdjM
         ZtGIh93wTghL29mNznfhuH+MRySS2w/bxJyMSDGcZx/hGiwN6aa0xTklnGK/oyfh59
         nMTS1kerNGamPzaUN4SSj/rOmwfNQv/6qr7XOqiarnb5vdkE10Mgfwhj6ET8p3Haqx
         5MBNyi/qUmIdFXE/LE2hTTjxpwuIi6B0g4E92koP1uZtAgj5e5EBu/Hno/blWCirow
         c24wCNQX7WJAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B67AC43143;
        Fri, 29 Jul 2022 22:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] libbpf: Add bpf_obj_get_opts()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165913441324.29361.10814985299552532195.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 22:40:13 +0000
References: <20220729202727.3311806-1-jevburton.kernel@gmail.com>
In-Reply-To: <20220729202727.3311806-1-jevburton.kernel@gmail.com>
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, jevburton@google.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 29 Jul 2022 20:27:27 +0000 you wrote:
> From: Joe Burton <jevburton@google.com>
> 
> Add an extensible variant of bpf_obj_get() capable of setting the
> `file_flags` parameter.
> 
> This parameter is needed to enable unprivileged access to BPF maps.
> Without a method like this, users must manually make the syscall.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] libbpf: Add bpf_obj_get_opts()
    https://git.kernel.org/bpf/bpf-next/c/395fc4fa33e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


