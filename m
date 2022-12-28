Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D070658745
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 23:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiL1WUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 17:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiL1WUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 17:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C848113D1B;
        Wed, 28 Dec 2022 14:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EA9CB81916;
        Wed, 28 Dec 2022 22:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20B39C4339E;
        Wed, 28 Dec 2022 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672266016;
        bh=xMaNAb1FUv8D+sZj81FOtz1pnJUnx4Buj3qF4vimjKM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e4jNZp2DjxmzX03Av36dUeyd6wtMEbEmK/gYoMk7kKzCoh21JW50qLewNWZmOzdmW
         K899zDXd+A8mkhXsr1RF/C3PCZn8LjL2suRzDQUk+KzKbjhoztSDlO79mb1OFEGauq
         Tab2TTxUdNGtxMlApjQQeE6C5U/Xj7LsLQSyDoFg89/w8R0IrvZyV7ZyjlZzKWO3RS
         mfzc/yCA5UKf1BTvtCatmHJEtmi2KTADJCpDJx92/LF7driZOqjuCV4zVyO6eQdvE2
         djKjNLJJn3s79PFYSvctFZ6eYkdSYg3+NO2Qr2Nptef9T90/Rwq6MmjHbmG5idZ6Lc
         I/5WxZRinmVFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0456AC395DF;
        Wed, 28 Dec 2022 22:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix errno is overwritten after being closed.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167226601601.12161.9126166797569940873.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Dec 2022 22:20:16 +0000
References: <20221223133618.10323-1-liuxin350@huawei.com>
In-Reply-To: <20221223133618.10323-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Dec 2022 21:36:18 +0800 you wrote:
> In the ensure_good_fd function, if the fcntl function succeeds but
> the close function fails, ensure_good_fd returns a normal fd and
> sets errno, which may cause users to misunderstand. The close
> failure is not a serious problem, and the correct FD has been
> handed over to the upper-layer application. Let's restore errno here.
> 
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix errno is overwritten after being closed.
    https://git.kernel.org/bpf/bpf-next/c/07453245620c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


