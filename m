Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261BC62FFE8
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 23:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiKRWUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 17:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKRWUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39D99EAF
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 14:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFE30B82563
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FF77C433D6;
        Fri, 18 Nov 2022 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668810017;
        bh=qwHIBfzCRwaujam2EJHCpwXq9/IRcHIqTMzvUmoZq7A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T/g2hsy5+FIUgItib/ZSqRptUwnPZEf5840dCypRBSTKS7TDKsakBRgFP7mXfy0Jp
         9XdOtHGuXoCPjYbQM4SM3pbKeTtbCMh5qaGTQ27RN+zeaT06q2/UvnaWOgeDOs+QPL
         olzJQRt5BWiZfWFJYcgRevUCvqmEDT21qvf9uli+smibEO5MmnanbkJ56iuxInzzHl
         JEZm3Xs07lzh1CNyO9fheYTTq4z9F8NQWBH+e2CPZtY+Cq4kyLRDIcjMf6a/odneAS
         oebnu9ubvPrDjFuSf1Vt5zUR8g6QTQCIbp+zLA/7VDlXzeyNWElXm6m5e2/p/frxH6
         K7mBjNxxlwO/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62913E29F43;
        Fri, 18 Nov 2022 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: ignore hashmap__find() result explicitly in
 btf_dump
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166881001739.9967.2211883202769196258.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Nov 2022 22:20:17 +0000
References: <20221117192824.4093553-1-andrii@kernel.org>
In-Reply-To: <20221117192824.4093553-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

On Thu, 17 Nov 2022 11:28:24 -0800 you wrote:
> Coverity is reporting that btf_dump_name_dups() doesn't check return
> result of hashmap__find() call. This is intentional, so make it explicit
> with (void) cast.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: ignore hashmap__find() result explicitly in btf_dump
    https://git.kernel.org/bpf/bpf-next/c/f80e16b614f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


