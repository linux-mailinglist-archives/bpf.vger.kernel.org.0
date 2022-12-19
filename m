Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E26514A7
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiLSVKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 16:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiLSVKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 16:10:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0115F1276C
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 13:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90BBF61174
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 21:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3E1CC433A1;
        Mon, 19 Dec 2022 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671484219;
        bh=ZWSzrIi8H7HsdKKt6N8NrJEMZ493MXc6PdbgeFy6uog=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PhFjMrmdbnvAr0YXGIKfyodMpOCtF/Dc049N1kQB5bJ2TtF0RK8qEE8eHSONr+lHK
         xXqbK6sSSdAr2Z2EtMl4SiqR+OggAkWezID+ja4OHU4X+Ay2ZmJoMnx6iM3g3PUTBq
         szN46Rb+Tdjyr3f52Z5fa6ugeE1iPVzZTWnDP10GiLpS7RwYJ9iv4cKd1T6XokXc+4
         ufEgyOjEb0Aafe7N+JUVgixIxgLfS9+j269S0i21uqExmezUoJyBQNvYYlRDbgdktq
         owy38pM+qkAkfWF+MOWXAxq4QT9Xr6FSYOwSBUui7ru3Yoc3syaOheq5kBLY1LxDWF
         ui/aNzlO7hK7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAD70E29F4C;
        Mon, 19 Dec 2022 21:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/3] bpf: Get rid of trace_printk_lock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167148421882.25912.2818674096499754269.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Dec 2022 21:10:18 +0000
References: <20221215214430.1336195-1-jolsa@kernel.org>
In-Reply-To: <20221215214430.1336195-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com, revest@chromium.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 15 Dec 2022 22:44:27 +0100 you wrote:
> hi,
> In the last revision Andrii suggested we could have the buffer
> provided by bpf_bprintf_prepare [1]. It's bit more changes but
> it looks like more compact solution.
> 
> v3 changes:
>   - added struct to hold return data in bpf_bprintf_prepare
>   - fix bug in bpf_bprintf_cleanup
>   - adjust printk helpers to use new bpf_bprintf_prepare
>     data argument
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/3] bpf: Add struct for bin_args arg in bpf_bprintf_prepare
    https://git.kernel.org/bpf/bpf-next/c/78aa1cc94043
  - [PATCHv3,bpf-next,2/3] bpf: Do cleanup in bpf_bprintf_cleanup only when needed
    https://git.kernel.org/bpf/bpf-next/c/f19a4050455a
  - [PATCHv3,bpf-next,3/3] bpf: Remove trace_printk_lock
    https://git.kernel.org/bpf/bpf-next/c/e2bb9e01d589

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


