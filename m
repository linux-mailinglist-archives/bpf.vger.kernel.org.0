Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EAE4CE652
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiCERvE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 12:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiCERvE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 12:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500D214F92
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 09:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ED74B800C1
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 17:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17F97C340F0;
        Sat,  5 Mar 2022 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646502611;
        bh=+kswrFrRjyp4XTNLVOLYR6x1ivXx5zzR+J8uzgrgH/A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Il/iuWwOFH/Sp6D8QxT/FqST6z1X5YqS2ETlUhKqtbf2IL8f9WYnDm5k4ARqKGGd3
         Q6JttCtNpM3RP7lgs2nNwhPS9k4JT3VLgLFa2ZIi+Kfwnv9kQ0bpcTbWA50ohzN4qE
         FKfLgOJ3rq4qoI3rBXXi5V33LPf84iKewryOEh6bz78rQqj+5eMx1q5N90MJH0Ximt
         wgFk2wj5gnzHso2Xh/dhpHHDF8BtZaXMEf/6xf7EIz3BclPeaO1kcK74IeaIqns0nI
         FMH8RkAHS3pok1Xuh7+SBxXyenj4hq+wxf3vMP9OoGb2vkzMVFHjA1+FaH+rmqJ0FC
         AwOytdwcHNsug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4C8EF03839;
        Sat,  5 Mar 2022 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/3] libbpf: support custom SEC() handlers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164650261093.19324.13192928606287006737.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Mar 2022 17:50:10 +0000
References: <20220305010129.1549719-1-andrii@kernel.org>
In-Reply-To: <20220305010129.1549719-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, alan.maguire@oracle.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 4 Mar 2022 17:01:26 -0800 you wrote:
> Add ability for user applications and libraries to register custom BPF program
> SEC() handlers. See patch #2 for examples where this is useful.
> 
> Patch #1 does some preliminary refactoring to allow exponsing program
> init, preload, and attach callbacks as public API. It also establishes
> a protocol to allow optional auto-attach behavior. This will also help the
> case of sometimes auto-attachable uprobes.
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/3] libbpf: allow BPF program auto-attach handlers to bail out
    https://git.kernel.org/bpf/bpf-next/c/4fa5bcfe07f7
  - [v5,bpf-next,2/3] libbpf: support custom SEC() handlers
    https://git.kernel.org/bpf/bpf-next/c/697f104db8a6
  - [v5,bpf-next,3/3] selftests/bpf: add custom SEC() handling selftest
    https://git.kernel.org/bpf/bpf-next/c/aa963bcb0adc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


