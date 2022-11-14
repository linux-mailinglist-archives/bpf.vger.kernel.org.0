Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFED6287EC
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 19:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiKNSK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 13:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiKNSKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 13:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D2DF55
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 10:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B59F86131C
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A2C4C433C1;
        Mon, 14 Nov 2022 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668449416;
        bh=PtGfA82f3d8b5KhIjcY7jLIlkIbEUqsQfIfy50CKB08=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t6YYqUy64Dlq2zgDEmebr9+AaFYMI31svYz6azo24+nBhMjtiMX0zW8EMA6+11ycN
         J5UilbW+whjikqfp8ciDVbfY/4Un/WL2neCDEhqd3wpJUVDIB6Egs0USvAt689FfEr
         087Zc5B8vTMBhAQc+rgSehLtAEpNdAbHg+/NIBEWrBDvvymDL0LaWM7Zm9TW0GflFi
         Mq7AhzSq4NiwXVmDcwg8aUpHSo8ljmuWo0o55t9rKxHtbFY/DaLon9vZUY/27uNl2p
         xcq6f0bFiKzPPfzH1eyCYUjvcrnKp32myjrE4zaM1IP3UqsIhhmK6HkEFsWxiy94WJ
         uF/lZLDCkx7hQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1FD8C395FE;
        Mon, 14 Nov 2022 18:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix uninitialized warning in btf_dump_dump_type_data
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166844941598.9787.7733977878486335129.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Nov 2022 18:10:15 +0000
References: <87zgcu60hq.fsf@gmail.com>
In-Reply-To: <87zgcu60hq.fsf@gmail.com>
To:     David Michael <fedora.dm0@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 13 Nov 2022 15:52:17 -0500 you wrote:
> GCC 11.3.0 fails to compile btf_dump.c due to the following error,
> which seems to originate in btf_dump_struct_data where the returned
> value would be uninitialized if btf_vlen returns zero.
> 
> btf_dump.c: In function ‘btf_dump_dump_type_data’:
> btf_dump.c:2363:12: error: ‘err’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  2363 |         if (err < 0)
>       |            ^
> 
> [...]

Here is the summary with links:
  - libbpf: Fix uninitialized warning in btf_dump_dump_type_data
    https://git.kernel.org/bpf/bpf-next/c/dfd0afbf151d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


