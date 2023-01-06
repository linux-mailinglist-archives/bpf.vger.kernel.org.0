Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E363660405
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjAFQK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 11:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjAFQKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 11:10:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A276232;
        Fri,  6 Jan 2023 08:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E8361E18;
        Fri,  6 Jan 2023 16:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCBD7C433EF;
        Fri,  6 Jan 2023 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673021416;
        bh=M8N+XKuGKQndYPL2a1a4lFpAAxVF9zECu4baNF6lBrU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t6jJra6Ydakr5HlyeFeYGOmYkhFi2KSEuOBRCHJZx+nC9E2rN0p9HUvkI5+jcMMvU
         CNlqzJOWRDg74nKhw249mBCsrjfbkNkh7SMvy474rYMFSdbMu4b3BpO7LaADVp+geY
         hna69vl/l1Hy1B6AldsSHsD0eD33vxkt/5n0KoSP56LRrIOZxKEMux67DdGnMbcvv1
         Yu942XIsstun+/u5x6jsRJgyoIgGUHuui2KZ6pUzezP7OFv6aLBRUpoQ5U0EIcqM1q
         noqj2XrhnhuAYGZS+fj4+FTtwTkPPYkXoMDZicTw/YxkvYZbaJRhOiR45iieiBrZ+/
         Q3NkNEQHcAe7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0E12E57254;
        Fri,  6 Jan 2023 16:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: poison strlcpy()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167302141678.26939.16929188298412905917.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Jan 2023 16:10:16 +0000
References: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
In-Reply-To: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, rongtao@cestc.cn, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu,  5 Jan 2023 22:36:33 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Since commit 9fc205b413b3("libbpf: Add sane strncpy alternative and use
> it internally") introduce libbpf_strlcpy(), thus add strlcpy() to a poison
> list to prevent accidental use of it.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: poison strlcpy()
    https://git.kernel.org/bpf/bpf-next/c/6d0c4b11e743

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


