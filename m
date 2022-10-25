Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B860D7E9
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 01:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiJYXaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiJYXaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 19:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAF924091
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 16:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D5261C0A
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 23:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4AA7C433C1;
        Tue, 25 Oct 2022 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666740617;
        bh=bl9iO/UMuXylwTMumi5HgSShBBLXFnqos9bc04kWl54=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MIYH/zzdklVy9QY30iWnsHmmqFc2wUGvUc4vXTuOA8j9OpLmGBi2gBKlxDVDFMp2X
         B1IDL8y9ucqcyHcmcC7IGkxGorHFuBrj7rtTImkGCrpjrVTj4e+8weV0vt0kkyaF1W
         emr429Z6Oo56fubfQ7PRW9ZCQ/7R/a/UE34XEdDKZMcbeO3oxy9SYPOKgmRVmKYXae
         wpyf1r52XckbDyjsCz307Jkx5YYqYjUy2kYDmUaVwTYNUjTlQOfgj5Pq0SpV4cctXl
         Oc7Tgm9kYOg+rmROki18y9yJi74DuRK4SCLMf5dR5Mp9c16T9O5BDxNk8oVWz4eT/t
         yH5OiS7Bm1qfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A515BE45192;
        Tue, 25 Oct 2022 23:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: btf dedup identical struct test needs check for
 nested structs/arrays
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166674061767.7170.11544796321523992153.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Oct 2022 23:30:17 +0000
References: <1666622309-22289-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1666622309-22289-1-git-send-email-alan.maguire@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     andrii@kernel.org, ast@kernel.org, jolsa@kernel.org,
        acme@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 24 Oct 2022 15:38:29 +0100 you wrote:
> When examining module BTF, it is common to see core kernel structures
> such as sk_buff, net_device duplicated in the module.  After adding
> debug messaging to BTF it turned out that much of the problem
> was down to the identical struct test failing during deduplication;
> sometimes the compiler adds identical structs.  However
> it turns out sometimes that type ids of identical struct members
> can also differ, even when the containing structs are still identical.
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: btf dedup identical struct test needs check for nested structs/arrays
    https://git.kernel.org/bpf/bpf-next/c/f3c51fe02c55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


