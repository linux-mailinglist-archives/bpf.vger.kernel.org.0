Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C596587D8
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 00:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiL1XUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 18:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiL1XUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 18:20:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4013DCB;
        Wed, 28 Dec 2022 15:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEDB66155F;
        Wed, 28 Dec 2022 23:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B0FBC433EF;
        Wed, 28 Dec 2022 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672269615;
        bh=ukGYtnji64fNz0j/C9DjQzPepMfL0eVGBGYr8Mu7cYs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nipEUjUbsh4mpteGa01r31hwAv/axl6lrBS8nCs2rzW5kAvMjfjs/5RokyiprC1LC
         UZUDduRuLYyppnXY5kQ9cSMcsFqpEeYSFFAkhZd6nVZgKjDhpfFv6ZuFZ8/CFgONmf
         9IPdj2+5W66WfRMystUKbOjipLqvBpuabhpikMeU06PIEjrAHihZyQDDAR27kY1wB4
         TAbGgPfYldVrhe0y0RIYN9rZ3sh9JxPUQhgpYzruR5Ox8RvInfk5oP1SHMSxM0RXPN
         RoXJ7qAVmVXoG3l9/aYsvI61WJbsay1WtqLpmQ1PDkzpxo+Ve0guBi/7YrigEWpNbN
         FHgXabzdroMdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E34B3C395E0;
        Wed, 28 Dec 2022 23:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Always use maximal size for copy_array()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167226961492.3239.2685338674313032711.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Dec 2022 23:20:14 +0000
References: <20221223182836.never.866-kees@kernel.org>
In-Reply-To: <20221223182836.never.866-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     ast@kernel.org, v4bel@theori.io, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Dec 2022 10:28:44 -0800 you wrote:
> Instead of counting on prior allocations to have sized allocations to
> the next kmalloc bucket size, always perform a krealloc that is at least
> ksize(dst) in size (which is a no-op), so the size can be correctly
> tracked by all the various allocation size trackers (KASAN,
> __alloc_size, etc).
> 
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Link: https://lore.kernel.org/bpf/20221223094551.GA1439509@ubuntu
> Fixes: ceb35b666d42 ("bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage")
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> [...]

Here is the summary with links:
  - bpf: Always use maximal size for copy_array()
    https://git.kernel.org/bpf/bpf/c/45435d8da71f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


