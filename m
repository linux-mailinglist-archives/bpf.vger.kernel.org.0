Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F9967C0B5
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 00:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjAYXUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAYXUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 18:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A7B465
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 15:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F4D8B81C5C
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 23:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26F16C433EF;
        Wed, 25 Jan 2023 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674688817;
        bh=/X8/oa36s/Is9tqIWyAgx3RVsT8ruBZlwuf4S0WbyzU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HbnqHsLT6vIchuiDKEqff4fN/5AE7NonYHMS0fpRSgw0eccU5oAjDOsY4Q1BQFMc8
         gLgCQWTWGmS07FxXgCBRLf2m1najaBgRssrT5Vjt2Vy6YFxvU8HQ9VstgjNqS9bKYG
         mUml3zOSEKRf6VW/WApOIVGKwdUbp2ToMQuP0UyGxip6cY1CuXOs6xOieD/bbHOl19
         tURf/c0s1FeGhLLKLOWs+ouFQ7NQhIUO0AS5ktYzBCI2NPlpzOwFq8L2Bf+/7fgHQU
         RC04hWA826UB74tAYgzqqJtYqDHmVLe4koFTMBBmhcZLtjQF7qDbX2s9y2DFlFURZp
         pJ6pXhLfMM4BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08034F83ED2;
        Wed, 25 Jan 2023 23:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] Enable bpf_setsockopt() on ktls enabled
 sockets.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167468881702.27315.585615973493315531.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 23:20:17 +0000
References: <20230125201608.908230-1-kuifeng@meta.com>
In-Reply-To: <20230125201608.908230-1-kuifeng@meta.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 25 Jan 2023 12:16:06 -0800 you wrote:
> This patchset implements a change to bpf_setsockopt() which allows
> ktls enabled sockets to be used with the SOL_TCP level. This is
> necessary as when ktls is enabled, it changes the function pointer of
> setsockopt of the socket, which bpf_setsockopt() checks in order to
> make sure that the socket is a TCP socket. Checking sk_protocol
> instead of the function pointer will ensure that bpf_setsockopt() with
> the SOL_TCP level still works on sockets with ktls enabled.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Check the protocol of a sock to agree the calls to bpf_setsockopt().
    https://git.kernel.org/bpf/bpf-next/c/2ab42c7b871f
  - [bpf-next,v3,2/2] selftests/bpf: Calls bpf_setsockopt() on a ktls enabled socket.
    https://git.kernel.org/bpf/bpf-next/c/d1246f936023

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


