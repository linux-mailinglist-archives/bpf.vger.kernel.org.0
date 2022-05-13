Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1895262F0
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbiEMNUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349165AbiEMNUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 09:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E883B2B2
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 06:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E60ABB8302F
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 13:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CA4BC34117;
        Fri, 13 May 2022 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652448013;
        bh=13hQ6EqDneH5eAKWNuC2ahm4fQVRcK6rtp+NimJWSFw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PJneBFfEUbNk1GjkpvOXt0drXIovUlBDRm3fNhlssbz63NX5yrH+RAYlnPQHx1evR
         z4Kqtz3i9HOki5sgNoHCNMcXHZyDguZBHZJgKon03uiL8akM1U4nOU5ft9Ppj3N8Il
         sR49G8f1OaVfQBmxj7NTl9026DFq7NM1dXJKCYriPgwppjM74+SSiMNJfejPuM6D40
         uzVCAe0gAnrpsfgnqjiVgp/YDj+N05S7Vi9y7bpHDSz0/bWTVaTf9gWn/9zwBeHBUj
         CD5iTx4V1TpUh1jbcUfnRMDaMew4mXL5GzgzLkqvNWOnQ4ETitDIaVbkLz/YiSN0kS
         BTAv9McAJCbRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DAA8E8DBDA;
        Fri, 13 May 2022 13:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix combination of jit blinding and
 pointers to bpf subprogs.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165244801337.11154.3266406533060749854.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 13:20:13 +0000
References: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
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

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 12 May 2022 18:10:24 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The combination of jit blinding and pointers to bpf subprogs causes:
> [   36.989548] BUG: unable to handle page fault for address: 0000000100000001
> [   36.990342] #PF: supervisor instruction fetch in kernel mode
> [   36.990968] #PF: error_code(0x0010) - not-present page
> [   36.994859] RIP: 0010:0x100000001
> [   36.995209] Code: Unable to access opcode bytes at RIP 0xffffffd7.
> [   37.004091] Call Trace:
> [   37.004351]  <TASK>
> [   37.004576]  ? bpf_loop+0x4d/0x70
> [   37.004932]  ? bpf_prog_3899083f75e4c5de_F+0xe3/0x13b
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix combination of jit blinding and pointers to bpf subprogs.
    https://git.kernel.org/bpf/bpf-next/c/4b6313cf99b0
  - [bpf-next,2/2] selftests/bpf: Check combination of jit blinding and pointers to bpf subprogs.
    https://git.kernel.org/bpf/bpf-next/c/365d519923a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


