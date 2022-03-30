Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCF4EC5A9
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbiC3NcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 09:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346054AbiC3Nb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 09:31:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047B37A94
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 06:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB841B81ACC
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 13:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B05CC34111;
        Wed, 30 Mar 2022 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648647011;
        bh=JktdeNgsCfPOibKWgTTiwnF0tFIIx4KUV9D6KhRuCZA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NL/VjyvbYnw+SWXY5P7Ws4iNvZfpKnQaRWkcMFGNw4EdcJmhopRiUGgGt7khBiz3I
         tByRU5Oz6w3MOUSBAi4UjM8Cxgrj1cG8BpiIBKq9V22GRcLTgNed4Nt7aW/mAAkTbF
         NsQ1ugXmqKKF+a1vr+O9KEytyMLOFZw7hQbwA5kmxrRvaBrw31dnbtglP4SMKAN+b0
         kCuAp2x2binX+AeIl8hydabDGHGQVDmi9tZeHwiGM1j/kLxzTprz3CBUzTadJ76GiT
         bbt5JSwQdk+FxtCH+sBzKndKIicCIrVNNO3xSQi7N7dlRkiDLUnRKhAjjELueZud/Q
         V3m2/APSxdzFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BD6AE6BBCA;
        Wed, 30 Mar 2022 13:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: explicit errno handling in skeletons
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164864701143.1602.9317565462778370541.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Mar 2022 13:30:11 +0000
References: <3b6bfbb770c79ae64d8de26c1c1bd9d53a4b85f8.camel@fb.com>
In-Reply-To: <3b6bfbb770c79ae64d8de26c1c1bd9d53a4b85f8.camel@fb.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, yhs@fb.com
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

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 21 Mar 2022 23:29:18 +0000 you wrote:
> Andrii noticed that since f97b8b9bd630 (bpftool: Fix a bug in subskeleton code generation)
> the subskeleton code allows bpf_object__destroy_subskeleton to overwrite
> the errno that subskeleton__open would return with. While this is not
> currently an issue, let's make it future-proof.
> 
> This patch explicitly tracks err in subskeleton__open and skeleton__create
> (i.e. calloc failure is explicitly ENOMEM) and ensures that errno
> is -err on the error return path. The skeleton code had to be changed
> since maps and progs codegen is shared with subskeletons.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: explicit errno handling in skeletons
    https://git.kernel.org/bpf/bpf/c/522574fd7864

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


