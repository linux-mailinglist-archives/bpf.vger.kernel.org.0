Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB91606D6D
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 04:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJUCKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 22:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJUCKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 22:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A910F8AA
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 19:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E079CB82A2F
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 02:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C005C43142;
        Fri, 21 Oct 2022 02:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666318217;
        bh=bayBvAf9e/M2S04n+FrZtdXKeetIdwLi4NKZZqTKnpY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hpBOY7Z7/LfdZnGHJrqqfOuYHl4DkxUhiAyThUgHrkdJJk5Ix5kDWcEwN6rUIxY/W
         ISdYDoYAsM/eI+NPK1GiY9v5190BxmRUVRUwu5udRkMs4dMGjlWcCjCSax65ar6gwH
         vgEuTENAHzAxoQkxPjEYU5piNZ9jWZtb01aHV0+JGoGBeNLqgyK2xqf2sfPxaPGOxb
         DPscwQ9yiLEeZAYiUlcD7hHuUEajThsnD7XXaw7mmq77zULEZsofuudbFiNQXqQxy0
         4OljMACa8q87B+ZDgGxOpxrYXoOrZDTOPdRSW3bmZ6rTqaNhFriIwwoPygieVLPI3r
         YF21hpZyodGmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A581E270E5;
        Fri, 21 Oct 2022 02:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next] selftests/bpf: fix missing BPF object files
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166631821756.26286.5120355181761714410.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 02:10:17 +0000
References: <1666235134-562-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1666235134-562-1-git-send-email-wangyufen@huawei.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        martin.lau@linux.dev, ast@kernel.org, deso@posteo.net
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 20 Oct 2022 11:05:34 +0800 you wrote:
> After commit afef88e65554 ("selftests/bpf: Store BPF object files with
> .bpf.o extension"), we should use *.bpf.o instead of *.o.
> 
> In addition, use the BPF_FILE variable to save the BPF object file name,
> which can be better identified and modified.
> 
> Fixes: afef88e65554 ("selftests/bpf: Store BPF object files with .bpf.o extension")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix missing BPF object files
    https://git.kernel.org/bpf/bpf-next/c/98af3746026c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


