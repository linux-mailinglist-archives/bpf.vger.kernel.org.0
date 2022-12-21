Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC6E652A19
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 01:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiLUAAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 19:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiLUAAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 19:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F06201AA;
        Tue, 20 Dec 2022 16:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C356162C;
        Wed, 21 Dec 2022 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C262CC433F1;
        Wed, 21 Dec 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671580816;
        bh=qQ4IcbVLw5s4Oqm5OaatPo8clNjq2F9Y1dV/ChuZegk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eU8aUDPmBCeo/OkQG9Rl9bCuZSmUGCjSfh5G9ZQ/5x0HA3tHLr85ssbw8ffXiQAEs
         H5rjCroebOsQK1LeCRVgs6BL4vIL71h+4aZ6z90iktQU+fCnhr9jLPwY03gtrmnQqM
         iubWMGGPxKlID3IJIYUIdHLz/mffNQN72dEga/n41HM1VFvWR/+8iAryDKApkQYlCD
         rlRrOmFcUnnLHy7bN8zpSWBgkSzRaUHgtletI/7DDuiwXYzqpPMXwfySoDFLv3RfIL
         jT1z2tE4mnFEqFY6V+ZmtBgWaYXuQpjevRGHhvjqqc7rBxYb3JT0rc/89JSGY5+uEk
         pxDrJvVq9U0lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4365C43159;
        Wed, 21 Dec 2022 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167158081666.32440.14232598328127480222.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Dec 2022 00:00:16 +0000
References: <20221219095512.26534-1-mtahhan@redhat.com>
In-Reply-To: <20221219095512.26534-1-mtahhan@redhat.com>
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, dthaler@microsoft.com,
        bagasdotme@gmail.com, john.fastabend@gmail.com, void@manifault.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 19 Dec 2022 09:55:12 +0000 you wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
> including kernel versions introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Acked-by: David Vernet <void@manifault.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
    https://git.kernel.org/bpf/bpf-next/c/cafb92d719e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


