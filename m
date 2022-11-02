Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70061617D
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKBLNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKBLNH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1730527B09;
        Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B9A2B81AF4;
        Wed,  2 Nov 2022 11:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCC37C433D7;
        Wed,  2 Nov 2022 11:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667387415;
        bh=otPC0Z8ehZO+mCX6BTVk8Fpd1N5cWu1SFQSouS/RYAg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qi2Us5WI90cVYAvlCzud3HL0Pp7yjUkx4UsrI2CPJx/ajM6zHLuwlrUEtxWuiGh1L
         tjpEn2uyznkppiuo/DIOYZhc+nKgMP3HpwYd1NTWieJvXKfuMMfRqEbAgxhUuiPQ2y
         Tnxsf6rJBiH1LwFRWyyeCFz6Cc+2w7TmyAUrAqLkTteAeNcrN/RKVyD3c+0m5GXf6R
         tGDmr/1zZ1RD1sD9fqaqHtGzqIZGFXpa5BbU3Zsq0cB/I4kUvr1JQWID6wFXCVyBdZ
         cd/Np262pH7KgKQxxwDsmajqQGKTmqRxjXNMb0YgzlErrg6r/bxAp/0I9PrkG/ziIz
         8QeZC4+tw4Nww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1D14E270D5;
        Wed,  2 Nov 2022 11:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpftool: Fix NULL pointer dereference when pin {PROG,
 MAP, LINK} without FILE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166738741565.14695.12146940150736935990.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Nov 2022 11:10:15 +0000
References: <20221102084034.3342995-1-pulehui@huaweicloud.com>
In-Reply-To: <20221102084034.3342995-1-pulehui@huaweicloud.com>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        pulehui@huawei.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  2 Nov 2022 16:40:34 +0800 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When using bpftool to pin {PROG, MAP, LINK} without FILE,
> segmentation fault will occur. The reson is that the lack
> of FILE will cause strlen to trigger NULL pointer dereference.
> The corresponding stacktrace is shown below:
> 
> [...]

Here is the summary with links:
  - [bpf] bpftool: Fix NULL pointer dereference when pin {PROG, MAP, LINK} without FILE
    https://git.kernel.org/bpf/bpf/c/34de8e6e0e1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


