Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0064BEFF
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 23:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiLMWCS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 17:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiLMWBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 17:01:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD385F71;
        Tue, 13 Dec 2022 14:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC85A61745;
        Tue, 13 Dec 2022 22:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22635C433F2;
        Tue, 13 Dec 2022 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968817;
        bh=c7NQwUHD8mv5j/vpuyEPTKkX2njMoVjr9Iw3J+9RtzU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mIuTUnRc2wSatw0i/1uXf7E7+jOCKVEsPp7WeM10ihiQtqc3HznsW+Bc7ydUhLMRJ
         5J88uQ55zzuBZvRaBC0P7xfqZQL8qR4Z97XYb93G2Ljr7I43yBMLJCMgWLuZttAJok
         6iTfxwmGzsWFIaDvqsggIMyC7YGuhK5MQq32UTZWCBRWChuVcvbj4ZbXnDN05JcZOu
         7D2ED68vEOR2EQBWpzbMRP5H25CmCcsGqFQXf6CuT3RjI9QXScCegyvt3yGh+duJv6
         nqTDx0FOQg43893cQ7/k0jp/PXskAMn68YB93WU3Q/2vUtF8RC5EZpKsFWBO9qNtxv
         YG5XCDKoe9aRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03A9DC41612;
        Tue, 13 Dec 2022 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libbpf: Optimized return value in libbpf_strerror
 when errno is libbpf errno
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167096881701.16694.14250332414378810386.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Dec 2022 22:00:17 +0000
References: <20221210082045.233697-1-liuxin350@huawei.com>
In-Reply-To: <20221210082045.233697-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
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

On Sat, 10 Dec 2022 16:20:45 +0800 you wrote:
> This is a small improvement in libbpf_strerror. When libbpf_strerror
> is used to obtain the system error description, if the length of the
> buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
> ERANGE.
> 
> However, this processing is not performed when the error code
> customized by libbpf is obtained. Make some minor improvements here,
> return -ERANGE and set errno to ERANGE when buf is not enough for
> custom description.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libbpf: Optimized return value in libbpf_strerror when errno is libbpf errno
    https://git.kernel.org/bpf/bpf-next/c/c2614f627941

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


