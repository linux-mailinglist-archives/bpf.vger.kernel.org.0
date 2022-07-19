Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC457A454
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiGSQuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiGSQuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 12:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FDE43E60
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 09:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56CC7B81C3A
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 16:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0240C341CA;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658249415;
        bh=nQZTXb5MYjTruDpqpQXtpzZOe8xKLBa4ygGAVdLhYlM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pRtnkFh19IUHQb9Rn3/2HHPTIUBb7D0+vhS5vpeiW426rr6DIIuJ6JaLcXveWeTrE
         dSULoCI4KuYj8geUJCM1VQfFJqfi45vm6I26vSatJhAAiEcn2EuEm6ul32fW3XloPX
         JMbMwgzFBA5CxWwCyprhG2gg0jo9TJ2ooeViJrhESBvcpb4l7GAbyRIuXilEdtXCEh
         Aim5ZNaTgMkN4UC/nDI14eyaCUUFhuX24YoVpYWz6Eu+iOiziQHMp1yX7Y2hcmdesp
         hQpawYGXk5V2TC08Xb3DbMT7fj2BReBz3+0XEukmy7kMDmysIHslCWJdFDW46IHTEp
         yGXqDWM86kdnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2AF0E451B7;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix lsm_cgroup build errors on esoteric configs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165824941572.16633.16900941104439247615.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 16:50:15 +0000
References: <20220714185404.3647772-1-sdf@google.com>
In-Reply-To: <20220714185404.3647772-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, lkp@intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 14 Jul 2022 11:54:04 -0700 you wrote:
> This particular ones is about having the following:
>  CONFIG_BPF_LSM=y
>  # CONFIG_CGROUP_BPF is not set
> 
> Also, add __maybe_unused to the args for the !CONFIG_NET cases.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix lsm_cgroup build errors on esoteric configs
    https://git.kernel.org/bpf/bpf-next/c/3908fcddc65d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


