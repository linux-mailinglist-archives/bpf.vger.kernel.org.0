Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF7E4B2F5F
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352860AbiBKVaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 16:30:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353650AbiBKVaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 16:30:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC3C61
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:30:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEE6EB82CF9
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CFB6C340ED;
        Fri, 11 Feb 2022 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644615010;
        bh=Ph4DfRGPigMqDXpL3aN36p5tkUf9hR75wiHF2ZsoVPc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fso31rbIReVoczMaH7Lx+Lqv8ybMX2SzSm1/yDfadjPxOn71BelDLzjFGgp+izUE/
         hFIlMy1zMtVoLLTox8jr7RoRt8952bMatwihFpA7hpqmUst6AvEL4NqPVLzg2kaLLf
         7EHJyw7f7C7tPa5MbniN6Z7dJ3dHxYX4iw1236Owb/a9efl/LrE7+7oSN8Va4B/S3i
         O4ne9D/3oKHJkU+itEfKjTdy0gQw/4xkA24JXxwey3XmTLAg5v+D2wLEMGLfGBb2Y3
         H+okiIgsXADjQDuJVuAj/J6jKruyq7KHyb2gVF5LBxVEAwHhzyExNzfkx+KchRn9Qb
         422CuTqVKZWeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 559C9E6BB38;
        Fri, 11 Feb 2022 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Fix for crash due to overwrite in copy_map_value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164461501034.10199.16749469053019311648.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 21:30:10 +0000
References: <20220209070324.1093182-1-memxor@gmail.com>
In-Reply-To: <20220209070324.1093182-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
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

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  9 Feb 2022 12:33:22 +0530 you wrote:
> A fix for an oversight in copy_map_value that leads to kernel crash.
> 
> Also, a question for BPF developers:
> It seems in arraymap.c, we always do check_and_free_timer_in_array after we do
> copy_map_value in map_update_elem callback, but the same is not done for
> hashtab.c. Is there a specific reason for this difference in behavior, or did I
> miss that it happens for hashtab.c as well?
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix crash due to incorrect copy_map_value
    https://git.kernel.org/bpf/bpf/c/a8abb0c3dc1e
  - [bpf,v2,2/2] selftests/bpf: Add test for bpf_timer overwriting crash
    https://git.kernel.org/bpf/bpf/c/a7e75016a075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


