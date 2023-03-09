Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3D6B2DEE
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 20:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCITuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 14:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCITuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 14:50:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E16F6938
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 11:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2ECDBCE25C3
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 19:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EA85C433EF;
        Thu,  9 Mar 2023 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678391419;
        bh=F21XcFqdJ5ya4i4Tmx0BNZyEYLaClX8o+XuZDvbOzsI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A0Uy76kksPFdBece0tNxxlJagG/hNvX4zXcl1g6UdwJ1gb7lygPf+OXSIt1eKIkye
         heQu9LTPMh/GyNntvjdRzi9ntTuXVGNbKdk3o5PVltHWMp0fwmFIIM8D8wQiX6Dwrd
         V5thTCNavJhkVCtlKiIAoE9XniMU3Yf7yNpSpKFKFaMbTXbV8QwLyMlu13SJwEvEAq
         15bB2yb1d9pFR3BB8cHruOcL4XgCxEeuKmLcgPqYAcJcrpjHNeovRCd3c8bw02clUW
         1qXZyYvLPLC0owOChPSfhdzYKubZuYl+Z9ukobly3T5m9Xqtkt631JqOfNo+2YpQDZ
         vgerdo+KUuMsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CCF7E61B61;
        Thu,  9 Mar 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fixed a typo for BPF_F_ANY_ALIGNMENT in bpf.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167839141924.24485.10011926159092493419.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Mar 2023 19:50:19 +0000
References: <20230309133823.944097-1-michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20230309133823.944097-1-michael.weiss@aisec.fraunhofer.de>
To:     =?utf-8?q?Michael_Wei=C3=9F_=3Cmichael=2Eweiss=40aisec=2Efraunhofer=2Ede=3E?=@ci.codeaurora.org
Cc:     ast@kernel.org, bpf@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  9 Mar 2023 14:38:23 +0100 you wrote:
> Fixed s/BPF_PROF_LOAD/BPF_PROG_LOAD/ typo in the documentation
> comment for BPF_F_ANY_ALIGNMENT in bpf.h.
> 
> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> ---
>  include/uapi/linux/bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpf: fixed a typo for BPF_F_ANY_ALIGNMENT in bpf.h
    https://git.kernel.org/bpf/bpf-next/c/5a70f4a63000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


