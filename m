Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD465854F7
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 20:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiG2SUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 14:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiG2SUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 14:20:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339FA6397
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ADA1DCE2919
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E66A7C433D7;
        Fri, 29 Jul 2022 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659118813;
        bh=TVt2tHvl5UxVkDZrWQKSiQ5C3j4UuuKHFWGJP/+vJtA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DCkpCbGQhTsUOCR6LxeXoa9XQpxv3yQr9dKg0rBIJwE6E4QcGPfVZSegW3WEwrGn9
         /RoVutzj991H2CODke3COXuzIER8oFmIrVwJNBP0bGzJWLZ1PS3cBTeUux9QnTysnu
         YcFZ63b0YMw3Zvt0dtZshGNO+drfXJyd9EhGlgwjRleJ0Nb623xrq+JWiY8zPEdypi
         D1hEGjyIVc4KGFrEczKNaQm5HkM2wcKtre27gwindY5RDK7SpgaHgKZiFclgFmKLS3
         YRBVQKoGl4N+mk+JkHFHd/tJzdYWYeh3P7NVjFN1Cniu+R4sMwpIDyPts/7poHFUUJ
         9FQxvgxWAG+vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0B47C43143;
        Fri, 29 Jul 2022 18:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Bump internal
 send_signal/send_signal_tracepoint timeout
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165911881285.26283.6636866788044775865.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 18:20:12 +0000
References: <20220727182955.4044988-1-deso@posteo.net>
In-Reply-To: <20220727182955.4044988-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 27 Jul 2022 18:29:55 +0000 you wrote:
> The send_signal/send_signal_tracepoint is pretty flaky, with at least
> one failure in every ten runs on a few attempts I've tried it:
>   > test_send_signal_common:PASS:pipe_c2p 0 nsec
>   > test_send_signal_common:PASS:pipe_p2c 0 nsec
>   > test_send_signal_common:PASS:fork 0 nsec
>   > test_send_signal_common:PASS:skel_open_and_load 0 nsec
>   > test_send_signal_common:PASS:skel_attach 0 nsec
>   > test_send_signal_common:PASS:pipe_read 0 nsec
>   > test_send_signal_common:PASS:pipe_write 0 nsec
>   > test_send_signal_common:PASS:reading pipe 0 nsec
>   > test_send_signal_common:PASS:reading pipe error: size 0 0 nsec
>   > test_send_signal_common:FAIL:incorrect result unexpected incorrect result: actual 48 != expected 50
>   > test_send_signal_common:PASS:pipe_write 0 nsec
>   > #139/1   send_signal/send_signal_tracepoint:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Bump internal send_signal/send_signal_tracepoint timeout
    https://git.kernel.org/bpf/bpf-next/c/639de43ef0dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


