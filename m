Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E805BB360
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 22:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIPUUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 16:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiIPUUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 16:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1438B580A0;
        Fri, 16 Sep 2022 13:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46B962D91;
        Fri, 16 Sep 2022 20:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0980DC433B5;
        Fri, 16 Sep 2022 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663359616;
        bh=nRLV12Mb0YiipccVdbD4fD+/s41J01u+MTPMkL8uEHw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rNow7IWEtKu45jLz8tknCNlcqG+XDyoqf8ccLCDHisIV2O9YQaVkLiWhlL0oS50ME
         QO1MjiIH7l9axIHErFpRLeKG8g01Gm1oP1rbz4co9sLO1Oqrcm0JF2+wzGKy9B7IjH
         C3X7PBlnTQ7kDlnAATiowhE4CBlYonhmm71CLZpBKyCrVPZiXwhSerqimzVJ+TdIUy
         fPLNJJFjC3TRiIX8n0kFx5QzpYKMAzMXBi6ye4JgN1yHXoeT7Edv4vxjzUCXcxoD5o
         4OL/8IMz35IfYe8nDb7Vu6+Htidzg5AZuna2RHZpiPq8wo1acAY3DlBrr5FamcXvmq
         FiJ15jEtmIDNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D98EAC73FFD;
        Fri, 16 Sep 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for
 blinding decision
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166335961587.27465.6441988777317672518.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Sep 2022 20:20:15 +0000
References: <20220905090149.61221-1-ykaliuta@redhat.com>
In-Reply-To: <20220905090149.61221-1-ykaliuta@redhat.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org,
        alexei.starovoitov@gmail.com, jbenc@redhat.com,
        daniel@iogearbox.net, serge@hallyn.com,
        linux-security-module@vger.kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  5 Sep 2022 12:01:49 +0300 you wrote:
> The full CAP_SYS_ADMIN requirement for blining looks too strict
> nowadays. These days given unpriv eBPF is disabled by default, the
> main users for constant blinding coming from unpriv in particular
> via cBPF -> eBPF migration (e.g. old-style socket filters).
> 
> Discussion: https://lore.kernel.org/bpf/20220831090655.156434-1-ykaliuta@redhat.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for blinding decision
    https://git.kernel.org/bpf/bpf-next/c/bfeb7e399bac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


