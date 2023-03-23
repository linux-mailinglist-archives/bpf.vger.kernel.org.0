Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334F6C5B71
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 01:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCWAkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCWAko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 20:40:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D82FCD2
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 17:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66281B81E9F
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 00:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E88FCC4339B;
        Thu, 23 Mar 2023 00:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679532019;
        bh=kTxoVeE9QtDVEX82Jemts3pQseEwscltrebrSbVgazM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sIIW12XDNn8VF1vStFAOMd9siqvRLbpqCfgmcxJAumK0jagp/Mgu7xatezFd0yowm
         gp5vFtzY9ETqHyzZx9/TL+ucy2TypxdEZkxRCCn7CYI14SsHzVJKDqIBUDUy/qThJR
         FQBNRvO/Ae8o5U7dMKIE4NzeUob/BCUysqp6cabIhXiLkherOXxE/gDudtDIfdwXsD
         oBaoRwjGRcYinbmGx4GeELWGqsvWeYjF7K46fYRCeiaFGUDF6+Cp2G0ordE/78+W8X
         xxys4i9OUiiwXFfVQ8H/a8iFOwlrH6yKy1GC9c+b/0AZrTibZfCgjbBbHVJGLhUzbM
         HPH8EMI4OyilQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB79BE4F0DA;
        Thu, 23 Mar 2023 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: remember meta->iter info only for initialized
 iters
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167953201882.8757.12072310215576608930.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Mar 2023 00:40:18 +0000
References: <20230322232502.836171-1-andrii@kernel.org>
In-Reply-To: <20230322232502.836171-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com, error27@gmail.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 22 Mar 2023 16:25:02 -0700 you wrote:
> For iter_new() functions iterator state's slot might not be yet
> initialized, in which case iter_get_spi() will return -ERANGE. This is
> expected and is handled properly. But for iter_next() and iter_destroy()
> cases iter slot is supposed to be initialized and correct, so -ERANGE is
> not possible.
> 
> Move meta->iter.{spi,frameno} initialization into iter_next/iter_destroy
> handling branch to make it more explicit that valid information will be
> remembered in meta->iter block for subsequent use in process_iter_next_call(),
> avoiding confusingly looking -ERANGE assignment for meta->iter.spi.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: remember meta->iter info only for initialized iters
    https://git.kernel.org/bpf/bpf-next/c/b63cbc490e18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


