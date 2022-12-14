Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC564D139
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 21:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLNUcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 15:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLNUbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 15:31:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFD49B45
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 12:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40468B81A2A
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFCD9C43396;
        Wed, 14 Dec 2022 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671049215;
        bh=WFDkqM33DkBH4cS9HPY8dgusjuWTu/hJZ6WnjFB7fkA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DggwOjVMdbKE8mAV8/QiYqdBKWIwJq5ZGOhHwn7EAIWsMcL32IvH6V6DNLJAq6rUx
         ywvUwgfdoR+BdGvxryVbfqETppNBV1CGw9CQ5ru1dFac50/8oLk28jQiwR2EcokaXf
         elOFXQLpQenx8T2XHwlfTM7RgtX3J6UnIicrQQMiDJ2LCnnW/xJ2uNOv6Srfkz6Rg2
         /B+gQH9LKyiqYv15sjfOxUNodDBflmF5umBlodWNJ7gs1/ACTlrNpcm42dSJSfCX0T
         krE80aT0zqzdt0xvWIocuJUP+4N5az9jKlXniD5P7U8u3GuQM0gdcPTSqie1J9qEID
         T42YdMRcReNFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3468E29F4D;
        Wed, 14 Dec 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Synchronize dispatcher update with
 bpf_dispatcher_xdp_func
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167104921573.24735.12743388812676342828.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Dec 2022 20:20:15 +0000
References: <20221214123542.1389719-1-jolsa@kernel.org>
In-Reply-To: <20221214123542.1389719-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        sunhao.th@gmail.com, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        paulmck@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 14 Dec 2022 13:35:42 +0100 you wrote:
> Hao Sun reported crash in dispatcher image [1].
> 
> Currently we don't have any sync between bpf_dispatcher_update and
> bpf_dispatcher_xdp_func, so following race is possible:
> 
>  cpu 0:                               cpu 1:
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Synchronize dispatcher update with bpf_dispatcher_xdp_func
    https://git.kernel.org/bpf/bpf/c/4121d4481b72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


