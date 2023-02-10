Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E03692AEE
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 00:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBJXAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 18:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBJXAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 18:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D53A0AD
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 15:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A5BB82615
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 527BAC433EF;
        Fri, 10 Feb 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676070018;
        bh=4vapFFSMPM33RJ/1ba2pDDWeC07snffcoaTNhHg8pZ8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I+tavmmJpX6UorC7j2cVHlIYhhQ/kxHN20aHBM4kOY0tyZG3TsO02G++8jk1XXspu
         3j55OvWkeBl67tdjzFZXxBUWUWxJQu6gooOvSIXzlxRrpwYuIsUSkF3rIP8J4hhqS7
         lcA88M95filb1w5WAiyRi40hgm4bNN6wGzgShvJHOZMcKaORP39j/zMKsC5AFaC3mK
         ZpfAzKLqGmrFJ/K9W55tgg+j9nXAICOcdZ5OKynaqxNRq9ROycaC/SKrFxLpvY1Mgz
         TKcI/JuJu9PlmyZhPakt3ZHJuIEIqgzOqg1PMTQZwLSKrNYpQYj7YFvskdj8HNCJ97
         vErmM27KSBzaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22C05E55F00;
        Fri, 10 Feb 2023 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Pass HOSTCFLAGS as
 EXTRA_CFLAGS to prepare targets
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167607001813.18910.4122270985476270538.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Feb 2023 23:00:18 +0000
References: <20230209143735.4112845-1-jolsa@kernel.org>
In-Reply-To: <20230209143735.4112845-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux@leemhuis.info, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        irogers@google.com
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

On Thu,  9 Feb 2023 15:37:35 +0100 you wrote:
> Thorsten reported build issue with command line that defined extra
> HOSTCFLAGS that were not passed into 'prepare' targets, but were
> used to build resolve_btfids objects.
> 
> This results in build fail when these objects are linked together:
> 
>   /usr/bin/ld: /build.../tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o):
>   relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE \
>   object; recompile with -fPIE
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/resolve_btfids: Pass HOSTCFLAGS as EXTRA_CFLAGS to prepare targets
    https://git.kernel.org/bpf/bpf-next/c/2531ba0e4ae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


