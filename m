Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61E6DC985
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDJQuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDJQuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 12:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63A199E
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 09:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5495661A74
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 16:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA153C433EF;
        Mon, 10 Apr 2023 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681145417;
        bh=ysodW62cW+/yfTDIssbltUzq8hw+RuOlork/QP7+IF4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HRVW50KBwhU308gjbKAb2ZSiV96LR+kvmkm/MmoY/2E1MWSSAVH0jli4fn2Kcy3Nu
         UaMqv8l/dfAFPDtCakqRki2Wfw3WUO1VpTtA+lxHYEIxEB90U5z/A86/aoRXXoGPgR
         iOe4S2mSmOVbLs7Kcdwr2x+jkbzWn2RftWnsbGjUXbXJWz3SGuKHDBkzn6+KBvvi7k
         QSIJWxLBQUKEuaH3oxbn4wplGrYz8tJsWTDf4cI+cXYYf1iFKj3RDcSL9rjXsIz5Rc
         vepjrOMqrH1tP7fwp/JK7muB3ThsY7MGk4JCn+MY2+fUDTinMvEyVl6tJ9DtvAK0b4
         im0OL4JqebgoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A601E21EEE;
        Mon, 10 Apr 2023 16:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Reset err when symbol name already exist in
 kprobe_multi_test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168114541756.32510.13001527318099007411.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Apr 2023 16:50:17 +0000
References: <20230408022919.54601-1-chantr4@gmail.com>
In-Reply-To: <20230408022919.54601-1-chantr4@gmail.com>
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, xukuohai@huawei.com, eddyz87@gmail.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  7 Apr 2023 19:29:19 -0700 you wrote:
> When trying to add a name to the hashmap, an error code of EEXIST is
> returned and we continue as names are possibly duplicated in the sys
> file.
> 
> If the last name in the file is a duplicate, we will continue to the
> next iteration of the while loop, and exit the loop with a value of err
> set to EEXIST and enter the error label with err set, which causes the
> test to fail when it should not.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Reset err when symbol name already exist in kprobe_multi_test
    https://git.kernel.org/bpf/bpf-next/c/c4d3b488a90b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


