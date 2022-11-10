Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E416623B17
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 06:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiKJFAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 00:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKJFAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 00:00:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D613D03
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 21:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93EE5CE2146
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 05:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82586C433D7;
        Thu, 10 Nov 2022 05:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668056416;
        bh=1JTds1a061S4VRludt7gyYKP688V9YX0qr7zV2ehN84=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C2D24KMt9cBjvAF4CbFPNqMFUrmLjQdrB4FMJViBOGHfPBwpLloS8EuwTOHP8d9S2
         MF0R9EWOgb1a15c0oE9vzN0St16YbFYxOUPGg05oWSXSoxz+VkW+691Z2dLuZ5DDOL
         AutIXxK1/d/a2fScARc/8f0aygZbt+WCwUQUXTm4dd4bJh24GeQLlvKX6KPtFyKehQ
         O6x8HjrnJ7nZFvqE4Pgmjvu8nhEd7Pjhu34MyLfYMPRRwaTrNJLf1UYRCImziN3ocd
         C3QbPQiNJKTkonXl4YrjZUQL2FQ9437qE8V+7IjMy5pmdzTBIzK7buOtILmuxKseQW
         39bkGGiChxiSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AA2AC395F6;
        Thu, 10 Nov 2022 05:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] libbpf: Resolve unambigous forward
 declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166805641643.4596.8079204594664124141.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Nov 2022 05:00:16 +0000
References: <20221109142611.879983-1-eddyz87@gmail.com>
In-Reply-To: <20221109142611.879983-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com, acme@kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Nov 2022 16:26:08 +0200 you wrote:
> The patch-set is consists of the following parts:
> - An update for libbpf's hashmap interface from void* -> void* to a
>   polymorphic one, allowing to use both long and void* keys and values
>   w/o additional casts. Interface functions are hidden behind
>   auxiliary macro that add casts as necessary.
> 
>   This simplifies many use cases in libbpf as hashmaps there are
>   mostly integer to integer and required awkward looking incantations
>   like `(void *)(long)off` previously. Also includes updates for perf
>   as it copies map implementation from libbpf.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] libbpf: hashmap interface update to allow both long and void* keys/values
    https://git.kernel.org/bpf/bpf-next/c/c302378bc157
  - [bpf-next,v4,2/3] libbpf: Resolve unambigous forward declarations
    https://git.kernel.org/bpf/bpf-next/c/082108fd6932
  - [bpf-next,v4,3/3] selftests/bpf: Tests for btf_dedup_resolve_fwds
    https://git.kernel.org/bpf/bpf-next/c/99e18fad5ff7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


