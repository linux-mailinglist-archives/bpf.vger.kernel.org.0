Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD0531D95
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiEWVUQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiEWVUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:20:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFEE8FD64
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 204FEB8163A
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 21:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5B9FC34116;
        Mon, 23 May 2022 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653340811;
        bh=RkhECVO1ONiqd4rokxVoG70uVxgBV9HWCiJtjjGpfVE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YM1+Ncp0VET5SNZku3yihF1AzYncAbRS25Z7D8+5/jPWCtqHAzn6LREjELvqCXEtV
         M3JTUsUvqoKyC1j79/p4xNUbLxMoXIk30Nmds+ZM4kuoEV7awyv0AmMfV4hHu/Y1qy
         tAMVVzJXQUiaHcY1lsTacpc7qihVm1TCagQUqBAAPwKjywh68o3G45oHmyDfADDlWQ
         fGnRVwNlZEgtnoDxuTI5I5smCjHQzDGtF4+OvnpgJOcalnwaqTLw+qOrzP6ayTabbw
         Zq8R6KbaELLoYusb3wgQmFPSYXEeD03oKltcgk3K/wG6pI8oTJnqS0H3LR1rnolQ1I
         Z89NhnRnbkvqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AA76F03943;
        Mon, 23 May 2022 21:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Suppress 'passing zero to PTR_ERR' warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165334081149.9921.6815781113204640532.git-patchwork-notify@kernel.org>
Date:   Mon, 23 May 2022 21:20:11 +0000
References: <20220521132620.1976921-1-memxor@gmail.com>
In-Reply-To: <20220521132620.1976921-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, lkp@intel.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 21 May 2022 18:56:20 +0530 you wrote:
> Kernel Test Robot complains about passing zero to PTR_ERR for the said
> line, suppress it by using PTR_ERR_OR_ZERO.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Suppress 'passing zero to PTR_ERR' warning
    https://git.kernel.org/bpf/bpf-next/c/1ec5ee8c8a5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


