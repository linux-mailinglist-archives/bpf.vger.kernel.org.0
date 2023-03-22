Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51BF6C505D
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCVQU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVQUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 12:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AF33A843
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 09:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC235621C2
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39E85C433EF;
        Wed, 22 Mar 2023 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679502018;
        bh=hPFs4K5xHmp5uC5mONk/WITakJnzOLknJVz8W9yaS58=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rBLI8NYz7P5dmCfEhnv7LDfsDUhmOq3VfWoONEh/RGHnmXrbJ9JUIkc32maavJKdY
         L2Zpj7Fk9p9Q/ouvTKiPxm1J1lBfYjY53aieY5DrwEf7Nek6clkb9QEL/t47sqlDry
         PdqgptE+vjAcc69eODP4SSCvGUMyxBWe7mJz2OUT8tZaovjiNz4dqUv+sjQfY0ob8C
         zmfeSXdPsfyS72VscDKOr3Fgw+gYkaxyZwPxuV4brwzZ1gZ98lU4exDYz/q9T63FKt
         cOAoAhUilQIvmz10qG+jZSgk5Yx1ssMj1MnOk5ldR7MCjLiAdAJtDxQ428a9rVhZBg
         Ixs/04ahmAdKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 191CEE52513;
        Wed, 22 Mar 2023 16:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/xsk: add xdp populate metadata test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167950201809.3589.15088500629053553158.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Mar 2023 16:20:18 +0000
References: <20230320102705.306187-1-tushar.vyavahare@intel.com>
In-Reply-To: <20230320102705.306187-1-tushar.vyavahare@intel.com>
To:     Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, tirthendu.sarkar@intel.com,
        maciej.fijalkowski@intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Mar 2023 15:57:05 +0530 you wrote:
> Add a new test in copy-mode for testing the copying of metadata from the
> buffer in kernel-space to user-space. This is accomplished by adding a
> new XDP program and using the bss map to store a counter that is written
> to the metadata field. This counter is incremented for every packet so
> that the number becomes unique and should be the same as the payload. It
> is store in the bss so the value can be reset between runs.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/xsk: add xdp populate metadata test
    https://git.kernel.org/bpf/bpf-next/c/9a321fd3308e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


