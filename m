Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543545FE296
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJMTUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJMTUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 15:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750A2637
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 12:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9787A617AB
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 19:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E48E2C433C1;
        Thu, 13 Oct 2022 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665688815;
        bh=jM+ZeJ/i6gMTa9Xv180APo/RcHLNJeSX7NYK0BkarZE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BdLpfm3frIVCCs7vn7xQXQJETzsZ6f249InbolY8ytcPFGu8AQ6GOTZouhlv+7LMv
         RcwSI7wTZLcVU81wRudp9roo6JIjBfaa5QCeT/6Dj4WIAcpYsOzDEgcMth4J1yM3Zs
         +XTTqQ+BnDr9ktd1unGsrV5g0aNrX63PvZi98MsWjn4yhS095KbIouRm4vPt4JqkoN
         uc2nwwWPkWIMDi49XFJ5EGxG/nhUi7lqMEjsTXSB+ZVt2Igpb1lIBSeFc40t11jh1j
         jFsWs9wDv94ylQ65BKb/c/SKzPXU8DCImLfmZawpzHPExPYKqcR0bVRyBWz6myYR0H
         8J08rOBVV+YwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6E60E4D00C;
        Thu, 13 Oct 2022 19:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Use sys_pidfd_open() helper when
 possible
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166568881480.839.9685292948102950876.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Oct 2022 19:20:14 +0000
References: <20221011071249.3471760-1-houtao@huaweicloud.com>
In-Reply-To: <20221011071249.3471760-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, andrii@kernel.org,
        songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        davem@davemloft.net, kuba@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, houtao1@huawei.com
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

On Tue, 11 Oct 2022 15:12:49 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> SYS_pidfd_open may be undefined for old glibc, so using sys_pidfd_open()
> helper defined in task_local_storage_helpers.h instead to fix potential
> build failure.
> 
> And according to commit 7615d9e1780e ("arch: wire-up pidfd_open()"), the
> syscall number of pidfd_open is always 434 except for alpha architure,
> so update the definition of __NR_pidfd_open accordingly.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Use sys_pidfd_open() helper when possible
    https://git.kernel.org/bpf/bpf-next/c/62c69e89e81b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


