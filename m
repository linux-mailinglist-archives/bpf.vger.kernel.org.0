Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEF85E7055
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 01:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIVXuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 19:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIVXuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 19:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67305F9633
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE66BB828D5
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 23:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BF00C433D7;
        Thu, 22 Sep 2022 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663890616;
        bh=OurUZ2eWKSKLv2TtRpMHMXaiRcjgZEsx6dxAycG7A+Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XUY1ML00e6Rex3upfsWf5Jxaz3T2K4GEY012onbLtRFuDSL/GffDGuH5CFdVtDi3C
         RBgDDUvHTjd08ikmZy17h1IlFiWr0PveK/gKdC7QGNlbGaqCr8gXyHBwnTNq2BAS0c
         AZqOrfQjrzZjG5mYFHJKOooFD9Lo+gnj5nFb9vlv3pbHut3vmXFazIIf3iBI2/K/JF
         DDYULl8l22Eky+WVB7PSLCFUsYRy3uI827+J1cvpo2fs1qKYT+ypMwNYkfzSQNkHKG
         5Ob9k01QsGrrUItU/flRpJoszRVCQkruk6KYsO7LuQ8ggNRuu/UH0Z+WS7FDaCCSUn
         EQIAaWNYmswGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20C51E21ED1;
        Thu, 22 Sep 2022 23:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Fix resource leaks in test_maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166389061612.10533.9582750586961600101.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 23:50:16 +0000
References: <20220921070035.2016413-1-houtao@huaweicloud.com>
In-Reply-To: <20220921070035.2016413-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, andrii@kernel.org,
        songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        davem@davemloft.net, kuba@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, oss@lmb.io,
        houtao1@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 21 Sep 2022 15:00:33 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> It is just a tiny patch set aims to fix the resource leaks in test_maps
> after test case succeeds or is skipped. And these leaks are spotted by
> using address sanitizer and checking the content of /proc/$pid/fd.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Destroy the skeleton when CONFIG_PREEMPT is off
    https://git.kernel.org/bpf/bpf-next/c/f5eb23b91c41
  - [bpf-next,v2,2/2] selftests/bpf: Free the allocated resources after test case succeeds
    https://git.kernel.org/bpf/bpf-next/c/103d002fb7d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


