Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DB45FDD52
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJMPmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 11:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJMPlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 11:41:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273AA122743;
        Thu, 13 Oct 2022 08:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5D00B81ED7;
        Thu, 13 Oct 2022 15:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BF72C43470;
        Thu, 13 Oct 2022 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665675616;
        bh=J/lwPJ5WiIjf30qtkle/UiARXMiDCL/Vgen5+KfB8RY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YBwixWrzs29BZ3t0lHmymJ9Myibanwt+BNSKxIfWAXODfxzbVodPWVxR8QBImvcPq
         E+/Sa9STOHbY5SBa+0Lk5sA5q00flLyU66uaSo1mk30pnR/ohw9M++chA+PlL+QvZo
         O8i3CdEcbdsUVKqeR+eJB6N9YvgIRB9uoTTskr7u8dHwrIchEOK+W0C0jW+T+JhXCB
         TvUAYoAzitBK5ZJVYbZo8EUVrU91Fy/ZEqVj+mjZoyzwjKZnCJ3V27ED4VbOwwSFCL
         U9zK/fAvc2ZNbBjo5up94Xkt7EQSc1p+36Y+f+8gtIfA5tQ+o8hwj7pq01P0vKgD9h
         HZU9kKNaHpjyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 176DEE4D00C;
        Thu, 13 Oct 2022 15:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Allow bpf_user_ringbuf_drain() callbacks to return 1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166567561608.22924.7276455354921254094.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Oct 2022 15:40:16 +0000
References: <20221012232015.1510043-1-void@manifault.com>
In-Reply-To: <20221012232015.1510043-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.lau@linux.dev, daniel@iogearbox.net, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 12 Oct 2022 18:20:13 -0500 you wrote:
> The bpf_user_ringbuf_drain() helper function allows a BPF program to
> specify a callback that is invoked when draining entries from a
> BPF_MAP_TYPE_USER_RINGBUF ring buffer map. The API is meant to allow the
> callback to return 0 if it wants to continue draining samples, and 1 if
> it's done draining. Unfortunately, bpf_user_ringbuf_drain() landed shortly
> after commit 1bfe26fb0827 ("bpf: Add verifier support for custom
> callback return range"), which changed the default behavior of callbacks
> to only support returning 0, and the corresponding necessary change to
> bpf_user_ringbuf_drain() callbacks was missed.
> 
> [...]

Here is the summary with links:
  - [1/2] bpf: Allow bpf_user_ringbuf_drain() callbacks to return 1
    https://git.kernel.org/bpf/bpf/c/c92a7a522438
  - [2/2] selftests/bpf: Make bpf_user_ringbuf_drain() selftest callback return 1
    https://git.kernel.org/bpf/bpf/c/6e44b9f375a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


