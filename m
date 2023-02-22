Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6F69FDA2
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjBVVUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBVVUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C6532CD8
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 13:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C525B818A4
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 21:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B82E8C433EF;
        Wed, 22 Feb 2023 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677100817;
        bh=oyxuhIHv3FBe5K2sL8MSKk8QNDzkC5AC0XosKjis1EI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qb1GxWmt6SVPLuX5x4m7Kcfx/agDPlTOGo7mF2pb76w83Ls7Vc34PpUxx1NG+/fQy
         rJHgmoW5h4HcRQk1Xv4KkLQvbXeUdG6Jd4m7JFi+zAJm3byNoTOu4zvA2rHKdTzKkO
         nuJbUHQYNSK9Kp5EAtoSxRIzssxuBLK6JccNO8ud584oYPf1ng00dCToSmjUZbUu7H
         aZseijD/NNMLAD6p4xpGJyGkum2o9elBeU2U4Nefi9UQadxy9ZOZbZjLiBaEviBsNK
         Xhz1HTRvpLzITaQ0wiUhDhAqfAguvTz93jriZ+JH5famkeHtj4YSr+PWUmM/tQdmGy
         Pq0Cjr49n9B3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D4AAC59A4C;
        Wed, 22 Feb 2023 21:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix
 BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
 for empty flow label
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167710081764.15608.7258281028764839300.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 21:20:17 +0000
References: <20230221180518.2139026-1-sdf@google.com>
In-Reply-To: <20230221180518.2139026-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 21 Feb 2023 10:05:18 -0800 you wrote:
> Kernel's flow dissector continues to parse the packet when
> the (optional) IPv6 flow label is empty even when instructed
> to stop (via BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL). Do
> the same in our reference BPF reimplementation.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL for empty flow label
    https://git.kernel.org/bpf/bpf-next/c/9fa02892857a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


