Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72A5BD4B1
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiISSUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISSUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 14:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103693BC7E
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 11:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D29C61867
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F25FBC433D7;
        Mon, 19 Sep 2022 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663611614;
        bh=86F6q10oRbMIBjLJca9y5ymoiPFds+lblqvKoD31vlg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A2No6hA5A0tADFfSlvq0sPLEEU7xC3jSW7gYZBZrAlGCqHJtxQygP9YGq5l1ES7rg
         vt2WtihZCA+zRKcQkrTRRJYOjgtyPqJRLf1nxHM72G+pPByrWdT3Bf0OK7W6KC0ZEu
         w1+SBWGTRFOV86j7gtxc+IC81pMAtyKV4Q+mylp149yVR3Uq7RzHU79vS48Ggx8HxT
         wVzttOciEDYloBFPZcmFsYO/uAG10Jmk7RELPfVrV5G4+aCPI09XT7W2MCiW+yfJhy
         O6brBfzZa+no4QB2N5BInakipmnpWY6rAV2O14vkWsiBq9U6gsPu7AEbcEay4D4qJu
         nwdy30rAYn5dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6434E21ED4;
        Mon, 19 Sep 2022 18:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test result messages for
 test_task_storage_map_stress_lookup
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166361161387.27084.6620131163975291841.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 18:20:13 +0000
References: <20220919035714.2195144-1-houtao@huaweicloud.com>
In-Reply-To: <20220919035714.2195144-1-houtao@huaweicloud.com>
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

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 19 Sep 2022 11:57:14 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Add test result message when test_task_storage_map_stress_lookup()
> succeeds or is skipped. The test case can be skipped due to the choose
> of preemption model in kernel config, so export skips in test_maps.c and
> increase it when needed.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add test result messages for test_task_storage_map_stress_lookup
    https://git.kernel.org/bpf/bpf-next/c/fe8152a0f964

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


