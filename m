Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9029F6317C9
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 01:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiKUAdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 19:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKUAc7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 19:32:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA04451310
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 16:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F43B60C3F
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 00:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9201DC433B5;
        Mon, 21 Nov 2022 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668990619;
        bh=ERyGlOT90sSUHLDIX29ps3o1qBQqMyGZxKeMXJMHIQw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=teK073FI1+WhdqFkOY3C2twhq4h+1nn2/aAB4fDg91E5wnTU4LnOesgrzo5xIhwa/
         ILMresI081CC46+Wwaja9R0Zf4bMtizTcOljxAk/1Eu9T5HSZckyfSFcbA+BRxxedL
         tUTiqvrdMKi1m8UvRZyd2OmCj5VOHpqIzlxQC0yVsiMzpQyef5HLuomb0V3StHT7Ms
         ujdGkHagM1DDQArFzR5bXqEQ7sXYJTqv0gn8VnUvvVtjT2V/g/VBGuTWNuPTe3i+zq
         Nxvs9dlQiWSUTQ38KcjPBxPo3rFK7vk4aRLLSmXeo25HVDLYH1jNyEAfsb8Snxi579
         E76o0Xv7z0YpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 753C9C395F0;
        Mon, 21 Nov 2022 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/5] clean-up bpftool from legacy support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166899061947.20533.8436347774688840570.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Nov 2022 00:30:19 +0000
References: <20221120112515.38165-1-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221120112515.38165-1-sahid.ferdjaoui@industrialdiscipline.com>
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 20 Nov 2022 11:25:46 +0000 you wrote:
> As part of commit 93b8952d223a ("libbpf: deprecate legacy BPF map
> definitions") and commit bd054102a8c7 ("libbpf: enforce strict libbpf
> 1.0 behaviors") The --legacy option is not relevant anymore. #1 is
> removing it. #4 is cleaning the code from using libbpf_get_error().
> 
> About patches #2 and #3 They are changes discovered while working on
> this series (credits to Quentin Monnet). #2 is cleaning-up usage of an
> unnecessary PTR_ERR(NULL), finally #3 is fixing an invalid value
> passed to strerror().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/5] bpftool: remove support of --legacy option for bpftool
    https://git.kernel.org/bpf/bpf-next/c/9b8107553424
  - [bpf-next,v4,2/5] bpftool: replace return value PTR_ERR(NULL) with 0
    https://git.kernel.org/bpf/bpf-next/c/989f285159b8
  - [bpf-next,v4,3/5] bpftool: fix error message when function can't register struct_ops
    https://git.kernel.org/bpf/bpf-next/c/d2973ffd25c2
  - [bpf-next,v4,4/5] bpftool: clean-up usage of libbpf_get_error()
    https://git.kernel.org/bpf/bpf-next/c/d1313e01271d
  - [bpf-next,v4,5/5] bpftool: remove function free_btf_vmlinux()
    https://git.kernel.org/bpf/bpf-next/c/52df1a8aabad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


