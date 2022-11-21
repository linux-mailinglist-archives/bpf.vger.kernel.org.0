Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1303632D8F
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 21:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKUUA1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 15:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiKUUAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 15:00:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D8C6D37
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 12:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6EE661388
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3629FC433C1;
        Mon, 21 Nov 2022 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669060817;
        bh=2SHc1fKyEkxbgOOo6U2pQr7rhOQYI8jcraE48nLkMpo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TN1hHzfpvY8T0sqi9vpZrEOmyYgIl3DLwO6atXUfVadv2BHiwMd32yTvC2hoF4Jpu
         byFhtSdG1xz/njgmneF8tuo9KiJUXh7wBnRp0rGkV+gW6pMwRTfS9f/jqEP35R3cXg
         Q7WMyLMLcHvROUJ6DIwNcOyTZSjsEWKUBBgso17wA3zOVu69L5vRAv+mzVDofWj/AT
         MIurqyYM05QNKX1a4xi5CkuUFpuJAubKnSe0wSvxHzSTZpo1Jge7G7qFw8wSB5Mj13
         iNtfUgjFN34ZZUm0PrSvk2D6PcJ8N5OzchLQYiyAZDkQ1CLkn8Zl1WP1O+5vdIAn7t
         zLMckI08rfxDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12B4EE29F3F;
        Mon, 21 Nov 2022 20:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] selftests/bpf: Filter out default_idle from
 kprobe_multi bench
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166906081704.30865.17096709032712849475.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Nov 2022 20:00:17 +0000
References: <20221116100228.2064612-1-jolsa@kernel.org>
In-Reply-To: <20221116100228.2064612-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Nov 2022 11:02:27 +0100 you wrote:
> Alexei hit following rcu warning when running prog_test -j.
> 
>   [  128.049567] WARNING: suspicious RCU usage
>   [  128.049569] 6.1.0-rc2 #912 Tainted: G           O
>   ...
>   [  128.050944]  kprobe_multi_link_handler+0x6c/0x1d0
>   [  128.050947]  ? kprobe_multi_link_handler+0x42/0x1d0
>   [  128.050950]  ? __cpuidle_text_start+0x8/0x8
>   [  128.050952]  ? __cpuidle_text_start+0x8/0x8
>   [  128.050958]  fprobe_handler.part.1+0xac/0x150
>   [  128.050964]  0xffffffffa02130c8
>   [  128.050991]  ? default_idle+0x5/0x20
>   [  128.050998]  default_idle+0x5/0x20
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] selftests/bpf: Filter out default_idle from kprobe_multi bench
    https://git.kernel.org/bpf/bpf/c/2b506f20af2b
  - [bpf,2/2] selftests/bpf: Make test_bench_attach serial
    https://git.kernel.org/bpf/bpf/c/8be602dadb2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


