Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C26031B1
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJRRk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJRRkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 13:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB588E0CF;
        Tue, 18 Oct 2022 10:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0ADFB8208B;
        Tue, 18 Oct 2022 17:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A3A8C433D6;
        Tue, 18 Oct 2022 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666114818;
        bh=ExrBvq02T/pMlTaOvGLaEYzZKrmnzuXHfqBA/PMlOhA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IMzmYZgP1jVDPeeUIz0rSw9v0l3KTjvIN13d9Axzv39P2a5s9mr4tTyXjMH6FAHzK
         awAT2KGxCU8ynpd8HSvgxqsIvrgCR0RWy1dqNlswCi1bJmB+j8dVBF2JELqfKoG81v
         ULg6puhhZM7jr0M5frkPbadgstXOqKrvh6qPbNp2b+XW8722+Neaj+99uo9LQX0aI9
         EJfdNLFFG5XRVzIRk6ZKuNcR3LUnU6Jsj/87EJf+jfuInjOkdFrAA5CzsOlrw5iHTp
         S6bnFSCvxU1xUVkSGJiVlcZRG5+6IGnHTeMn7DM6qfCAMSHdi2YNl/lgwH31lJpWpe
         HIrvmWXp4F0EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CB2DE4D008;
        Tue, 18 Oct 2022 17:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Remove unnecessary RCU grace period chaining
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166611481822.6047.9797387760407103080.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Oct 2022 17:40:18 +0000
References: <20221014113946.965131-1-houtao@huaweicloud.com>
In-Reply-To: <20221014113946.965131-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, andrii@kernel.org,
        songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        davem@davemloft.net, kuba@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, houtao1@huawei.com,
        paulmck@kernel.org, delyank@fb.com, rcu@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Oct 2022 19:39:42 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> Now bpf uses RCU grace period chaining to wait for the completion of
> access from both sleepable and non-sleepable bpf program: calling
> call_rcu_tasks_trace() firstly to wait for a RCU-tasks-trace grace
> period, then in its callback calls call_rcu() or kfree_rcu() to wait for
> a normal RCU grace period.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] rcu-tasks: Provide rcu_trace_implies_rcu_gp()
    https://git.kernel.org/bpf/bpf-next/c/e6c86c513f44
  - [bpf-next,v2,2/4] bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
    https://git.kernel.org/bpf/bpf-next/c/59be91e5e70a
  - [bpf-next,v2,3/4] bpf: Use rcu_trace_implies_rcu_gp() in local storage map
    https://git.kernel.org/bpf/bpf-next/c/d39d1445d377
  - [bpf-next,v2,4/4] bpf: Use rcu_trace_implies_rcu_gp() for program array freeing
    https://git.kernel.org/bpf/bpf-next/c/4835f9ee980c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


