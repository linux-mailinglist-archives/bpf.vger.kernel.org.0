Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186D86CADE7
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjC0Suv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjC0Sug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:50:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D193C11
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39978B8070D
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 18:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02F97C4339C;
        Mon, 27 Mar 2023 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679943018;
        bh=572GL67cs6ab1QUecCsTXZaDILMuUMnzBhWCvK9h6xs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lS868eoHUq6ABKCQr2XtQPwB+FFUEDrV6zMXMfT6GXdIH3LynGqKj5WbDtMWMadEY
         /hw9Uz30Zgvm3QCsjpY7Ig0Z2AW/A2G+zCloG9ptsLEmw5tsKv/1hjL1kLdmjSjR1z
         pNiwA6IGV5xXv5EPat1cHJRQdE5ng2M+g5ibqfUhyrOrwSAy86X4KYlxu+hMuQ+bl5
         qo+8gvW1seOuvZ/jXtM0w5YBxfwNpZDOfyrFkiDlBAgKheXsi8qa2px8VEpSmFnPHL
         IhXxOafTcdaIHWRTd1pP7bRQayCUrOiggDfAA8E0g3mJuKxsmIWe9mSWwwPO6NiQZh
         wwJuOnyIAgM5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCD60C41612;
        Mon, 27 Mar 2023 18:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Don't assume page size is 4096
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167994301790.26701.11310541166684776849.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 18:50:17 +0000
References: <20230326095341.816023-1-hengqi.chen@gmail.com>
In-Reply-To: <20230326095341.816023-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 26 Mar 2023 09:53:41 +0000 you wrote:
> The verifier test creates BPF ringbuf maps using hard-coded
> 4096 as max_entries. Some tests will fail if the page size
> of the running kernel is not 4096. Use getpagesize() instead.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Don't assume page size is 4096
    https://git.kernel.org/bpf/bpf-next/c/7283137a7622

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


