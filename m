Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20162B0C2
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 02:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKPBuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 20:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPBuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 20:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40AC25E9D
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F1F3B81BAF
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 01:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21E1DC433B5;
        Wed, 16 Nov 2022 01:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668563416;
        bh=FdY+p+iuGvWKNmOl3Ff7SJddYdjkv3dcj3tumfwOs1E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ac4Bs17rL801X0qs6uZcRcl+VXmuRK1Y2vKP7VcNN/Y6+GnEZ05iNap6rJ3tNjOIb
         STADmH0aHZUJn+bmNjZ6wfIZeOYLIe8UCd9nt1iX8DL5RlkdoU4NvLUDnNKJEWZfbX
         tK8tKrA4dwtGP/arUov2S+ycc1F7yFNaAYv8DbE4vQ0YtmQ0YoL1VRotuWcOjkmuxr
         cquz+i0SOqvklPZwr44Hn+xYOKtx0hkK8JQLN4/MaidfpDWCCYVf0GS8ctPXyaLhB9
         cJIw/OxvdPc6IRBwVuO3jjhbuf8wbfzzIxbDgfduoth8vQYApzRiJEHDOG6WrIXCkv
         F69nWDPUdg/+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01715E21EFA;
        Wed, 16 Nov 2022 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] propagate nullness information for reg to reg
 comparisons
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166856341600.14321.8341346662749617432.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Nov 2022 01:50:16 +0000
References: <20221115224859.2452988-1-eddyz87@gmail.com>
In-Reply-To: <20221115224859.2452988-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, shung-hsi.yu@suse.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Nov 2022 00:48:57 +0200 you wrote:
> This patchset adds ability to propagates nullness information for
> branches of register to register equality compare instructions. The
> following rules are used:
>  - suppose register A maybe null
>  - suppose register B is not null
>  - for JNE A, B, ... - A is not null in the false branch
>  - for JEQ A, B, ... - A is not null in the true branch
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: propagate nullness information for reg to reg comparisons
    https://git.kernel.org/bpf/bpf-next/c/befae75856ab
  - [bpf-next,v3,2/2] selftests/bpf: check nullness propagation for reg to reg comparisons
    https://git.kernel.org/bpf/bpf-next/c/4741c371aa08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


