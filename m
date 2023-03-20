Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5296C2124
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCTTSd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjCTTSM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077F7692
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464816179A
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 19:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA5A8C433D2;
        Mon, 20 Mar 2023 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679339418;
        bh=BGHMxpMTdnHUEbE7Mr7hJtybhkAAGx5jpAtkD7n+bhk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WbmdzJH+KjUcsnntYK3iRQYALt3C1sJFmdTkceC7S6YOl9znaIOfy6XnJms8KI/Uq
         VaMSCHYHBojKCMB6nZzJplzZAJ0NxlPIIdaA9OkocTjK8NOS9ZQxryDOq25gSW5vzB
         NgBELWlUy0KwLNk9vX3OPFpIjsKnN/922VGxFNrJuUkEoFy487vP78mr3oG2gB0pYO
         FyYcO3e6mlxH22cZDXGwsTIqKo0iJJPCPrtNmss3D+dNEKxR3cjSia4ojocv2DObzb
         BTwQdrlPKv7vJti+Joo2Lb972EcMzHPFTj6Z/bI7eUwAgZCqvbe3tBgeNJU6vMyEDV
         Yt4gqD814++zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F692C395F4;
        Mon, 20 Mar 2023 19:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] libbpf: Explicitly call write to append content to file
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167933941851.25214.4383383486518932414.git-patchwork-notify@kernel.org>
Date:   Mon, 20 Mar 2023 19:10:18 +0000
References: <20230320030720.650-1-patteliu@gmail.com>
In-Reply-To: <20230320030720.650-1-patteliu@gmail.com>
To:     Liu Pan <patteliu@gmail.com>
Cc:     bpf@vger.kernel.org
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

On Mon, 20 Mar 2023 11:07:20 +0800 you wrote:
> Write data to fd by calling "vdprintf", in most implementations
> of the standard library, the data is finally written by the writev syscall.
> But "uprobe_events/kprobe_events" does not allow segmented writes,
> so switch the "append_to_file" function to explicit write() call.
> 
> Signed-off-by: Liu Pan <patteliu@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v1] libbpf: Explicitly call write to append content to file
    https://git.kernel.org/bpf/bpf-next/c/01dc26c980b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


