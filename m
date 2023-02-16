Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51A698956
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 01:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBPAkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 19:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPAkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 19:40:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735542DEA
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 16:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55A6C61E19
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 00:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A02F5C433EF;
        Thu, 16 Feb 2023 00:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676508019;
        bh=iT0vRrkhFwpkGUrs4iMrGRxRMwZQsATo05gIixrbc/s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D9iMESCkL2WF6jW1qOieNK9OTsJGrXpzAi+hLr6ltMPeTP2xWrbzSbIPJ94ZTJUsB
         6E685poCN4CEgVeBo+zY7XRqKNxQMijCEbz5aECkuDRTLgkhA2Wx/oX6G8HamNFXL6
         U7gnrvkdS3tkG3+vu4ZKFSUi1lcaYP+KYqhOhJa9oCUdV3sp90O57sBuu4nyW/tCDz
         XsKqKkuUUrEUd3dZoSpZuawGbzQl7h/gre+LQQ+XcU80oznmR0LLopdEV6EE5xrxFk
         f74Yd2xTz2azD1e+Z6f+Udux7ckhikVY+GgrwJKM3y46wc3EKknbYQtr+X6IPrLtf4
         kqaAXDt7SOx+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A919C4166F;
        Thu, 16 Feb 2023 00:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] New benchmark for hashmap lookups
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167650801929.17484.16570791858939648263.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Feb 2023 00:40:19 +0000
References: <20230213091519.1202813-1-aspsk@isovalent.com>
In-Reply-To: <20230213091519.1202813-1-aspsk@isovalent.com>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 13 Feb 2023 09:15:12 +0000 you wrote:
> Add a new benchmark for hashmap lookups and fix several typos.
> 
> In commit 3 I've patched the bench utility so that now command line options
> can be reused by different benchmarks.
> 
> The benchmark itself is added in the last commit 7. I was using this benchmark
> to test map lookup productivity when using a different hash function [1]. When
> run with --quiet, the results can be easily plotted [2].  The results provided
> by the benchmark look reasonable and match the results of my different
> benchmarks (requiring to patch kernel to get actual statistics on map lookups).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] selftest/bpf/benchs: fix a typo in bpf_hashmap_full_update
    https://git.kernel.org/bpf/bpf-next/c/4db98ab445c5
  - [bpf-next,v2,2/7] selftest/bpf/benchs: make a function static in bpf_hashmap_full_update
    https://git.kernel.org/bpf/bpf-next/c/2f1c59637fb1
  - [bpf-next,v2,3/7] selftest/bpf/benchs: enhance argp parsing
    https://git.kernel.org/bpf/bpf-next/c/22ff7aeaa9e3
  - [bpf-next,v2,4/7] selftest/bpf/benchs: remove an unused header
    https://git.kernel.org/bpf/bpf-next/c/9644546260ea
  - [bpf-next,v2,5/7] selftest/bpf/benchs: make quiet option common
    https://git.kernel.org/bpf/bpf-next/c/90c22503cd89
  - [bpf-next,v2,6/7] selftest/bpf/benchs: print less if the quiet option is set
    https://git.kernel.org/bpf/bpf-next/c/a237dda05e91
  - [bpf-next,v2,7/7] selftest/bpf/benchs: Add benchmark for hashmap lookups
    https://git.kernel.org/bpf/bpf-next/c/f371f2dc53d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


