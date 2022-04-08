Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F524F9EE8
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiDHVLq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 17:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiDHVLo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 17:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE5B13DC0
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 14:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B6461FF5
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 21:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02617C385AE;
        Fri,  8 Apr 2022 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649452179;
        bh=bw+wwOVluT6VbBfatXAAmx6U7J2ZW45sKFXbrEa0Jtc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A6+mj2YfPZHTIHThUxHUdhcTT7B+NR3MouoMx7vbDvX6lCzjFMX80TdRBLBEjB05P
         ozt/z99iufS9poQut5keo0oIZMU6H6bwo9rAvN9nCYiJyM0NeBgEnMwFpDlNM7hTYu
         pSEg+pnhoq/oiqhx38m2W3R+D04TayWeg3l/18IvsjUm/QOD46HKWiUQXc+lbVBhQ1
         hSrGzRQybYZbzw9GZQy7R1XYhZ6zuJ8Z0Y0258ABmkgoq7tka4pl2+jvIxgKDhj48u
         FOTCOLZ7DGBfUWNPcyPDTzdmvgxDxbnyKzJA4q7TrTju2HDvXCtspwXyTM1Z9AeaE9
         ZSJxwhXhflzFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2774E8DD18;
        Fri,  8 Apr 2022 21:09:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples: bpf: xdp_router_ipv4: move routes monitor
 in a dedicated thread
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164945217892.693.14111454866072100440.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 21:09:38 +0000
References: <e364b817c69ded73be24b677ab47a157f7c21b64.1649167911.git.lorenzo@kernel.org>
In-Reply-To: <e364b817c69ded73be24b677ab47a157f7c21b64.1649167911.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, andrii@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue,  5 Apr 2022 16:15:14 +0200 you wrote:
> In order to not miss any netlink message from the kernel, move routes
> monitor to a dedicated thread.
> 
> Fixes: 85bf1f51691c ("samples: bpf: Convert xdp_router_ipv4 to XDP samples helper")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  samples/bpf/Makefile               |  2 +-
>  samples/bpf/xdp_router_ipv4_user.c | 86 +++++++++++++++++++-----------
>  2 files changed, 55 insertions(+), 33 deletions(-)

Here is the summary with links:
  - [bpf-next] samples: bpf: xdp_router_ipv4: move routes monitor in a dedicated thread
    https://git.kernel.org/bpf/bpf-next/c/587323cf6a6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


