Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1575A9FFD
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiIATaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 15:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiIATaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 15:30:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2741D308
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 12:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45D71B8290A
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4AC8C433D6;
        Thu,  1 Sep 2022 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662060617;
        bh=RzHIvPaHg2E0cc7xpOyNLvV9s43JKoMb1mYuFzPlknk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oBOah8Xn7YvWZjWwB+oAjKw5WiwKDL+TYhdIMz4qD/cUzm568PT8uF4S+vjuTAb39
         t761DScoIfWfaN+BcyLCbjlTWcbxnXEQZF4G5SNfFsUqGCOC0AI1dKo+C0C+jTryT9
         I/n5ARluQbYEBTgL48HgpTIQOA9/XzznN6toeA9OylOueRg7KiV0KkClXipwk88GbW
         dAKc47dZqhj1WlwpR3VoL0TGTw2BQM5O275tKlRnkllLhTWcLi6k4gKC3sgGnZNm9t
         J66dgjwY17752pQ2CXSqCIXMU3sIS0QXlyqbGyxd3+QP+4UmfJmPmFJFz7BbdMT6he
         G9qo7UB1zDo1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB4C9E924D5;
        Thu,  1 Sep 2022 19:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Use this_cpu_xxx for preemption-safety
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166206061682.25790.4241340434100093956.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Sep 2022 19:30:16 +0000
References: <20220901061938.3789460-1-houtao@huaweicloud.com>
In-Reply-To: <20220901061938.3789460-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, songliubraving@fb.com, bigeasy@linutronix.de,
        sunhao.th@gmail.com, haoluo@google.com, andrii@kernel.org,
        yhs@fb.com, ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        kpsingh@kernel.org, davem@davemloft.net, kuba@kernel.org,
        sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        oss@lmb.io, houtao1@huawei.com
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

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  1 Sep 2022 14:19:34 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset aims to make the update of per-cpu prog->active and per-cpu
> bpf_task_storage_busy being preemption-safe. The problem is on same
> architectures (e.g. arm64), __this_cpu_{inc|dec|inc_return} are neither
> preemption-safe nor IRQ-safe, so under fully preemptible kernel the
> concurrent updates on these per-cpu variables may be interleaved and the
> final values of these variables may be not zero.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: Use this_cpu_{inc|dec|inc_return} for bpf_task_storage_busy
    https://git.kernel.org/bpf/bpf-next/c/197827a05e13
  - [bpf-next,v2,2/4] bpf: Use this_cpu_{inc_return|dec} for prog->active
    https://git.kernel.org/bpf/bpf-next/c/c89e843a11f1
  - [bpf-next,v2,3/4] selftests/bpf: Move sys_pidfd_open() into task_local_storage_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/c710136e8774
  - [bpf-next,v2,4/4] selftests/bpf: Test concurrent updates on bpf_task_storage_busy
    https://git.kernel.org/bpf/bpf-next/c/73b97bc78b32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


