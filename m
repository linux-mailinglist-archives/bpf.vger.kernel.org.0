Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1415C644D38
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 21:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiLFUaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 15:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFUaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 15:30:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686CD31DDB;
        Tue,  6 Dec 2022 12:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C1EAB81AAC;
        Tue,  6 Dec 2022 20:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2E48C433C1;
        Tue,  6 Dec 2022 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670358615;
        bh=rwtS7TrbnGFZTV7HvM6QLJMZYbYg/Tk5+r11OUjxQmg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rfIHja+550dyNG6FsaU2+PILGkh2CY/KWiWiybG208P9jrcE/AMSe8GdTmqmnGlVA
         SP+ctR/1SqHBZ0wv2a4YInwC4gxs8d0Ie6/Cdv6mfChKaF8EZY0IU+J/SV2LA0cLZK
         zudeAtu3XSF78kDO4YjtmsO8u3xfMEWaHRwU9o960EhJXvB3Qjbkdq78b9tb+wu8MD
         6Hccojcn5Lbe5dZX3disW42EHp57r89dhqniGQmikNBS6r3eXHcvOUfKmkq3Nz+Sac
         YxtqY546qA825kCDYVdQSgFHEYbjhUK6RuknZkGB+pSnJUFNUcHl4FzCH7/o7iEpWz
         PiUm7GVoaT2kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A92BFC395E5;
        Tue,  6 Dec 2022 20:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool: Fix memory leak in do_build_table_cb
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167035861568.14782.9211162392289846084.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Dec 2022 20:30:15 +0000
References: <20221206071906.806384-1-linmq006@gmail.com>
In-Reply-To: <20221206071906.806384-1-linmq006@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
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

On Tue,  6 Dec 2022 11:19:06 +0400 you wrote:
> strdup() allocates memory for path. We need to release the memory in
> the following error path. Add free() to avoid memory leak.
> 
> Fixes: 8f184732b60b ("bpftool: Switch to libbpf's hashmap for pinned paths of BPF objects")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - move free(path); into error branch.
> 
> [...]

Here is the summary with links:
  - [v2] bpftool: Fix memory leak in do_build_table_cb
    https://git.kernel.org/bpf/bpf-next/c/fa55ef14ef4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


