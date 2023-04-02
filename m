Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB06D38E5
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDBPuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjDBPuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 11:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A2191F6
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 08:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374DE61268
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 15:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89E13C433EF;
        Sun,  2 Apr 2023 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680450616;
        bh=NlgVCKdwY5JKc05sXI6QrRlrHwLKy1BhIdw+w44eVa4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cHj0ifdZBjQ/gN/AdWuIcOYG+mRkJJAdncNjHsm171ah7pz30NGiqcaNo7IN2arAy
         UPHtyhtc12oIL4CLMCFLyLpqtGZYFIofty60QrjgG1OQznHZBevBYRNRdlIZ9XWlme
         TQVdvAHLBOHvkBYQZX8Vg5Kjcw7Mle5nIXLaJfcEu6CFSVnMg/cXWKCF2QJmldWqa4
         LTfLqadnk8KEbL12y8zkkqw6G1uV1eDaJX1n3khwKi7Z6ArFegR8GZXb/LiP9G1ZzW
         4pmNeuCZW3XbxiQOjfENmC1VaT6e6/zIPtONFi8TEeFNFvc8mA0SUzoLsPaQbjIIeK
         HULArxEA9JbMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74B6CE2A035;
        Sun,  2 Apr 2023 15:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: compute hashes in bloom filter similar to
 hashmap
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168045061647.22275.9880533946456398482.git-patchwork-notify@kernel.org>
Date:   Sun, 02 Apr 2023 15:50:16 +0000
References: <20230402114340.3441-1-aspsk@isovalent.com>
In-Reply-To: <20230402114340.3441-1-aspsk@isovalent.com>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  2 Apr 2023 11:43:40 +0000 you wrote:
> If the value size in a bloom filter is a multiple of 4, then the jhash2()
> function is used to compute hashes. The length parameter of this function
> equals to the number of 32-bit words in input. Compute it in the hot path
> instead of pre-computing it, as this is translated to one extra shift to
> divide the length by four vs. one extra memory load of a pre-computed length.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: compute hashes in bloom filter similar to hashmap
    https://git.kernel.org/bpf/bpf-next/c/92b2e810f0d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


