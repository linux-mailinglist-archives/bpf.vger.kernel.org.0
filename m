Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6974C5048
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 22:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiBYVAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 16:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiBYVAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 16:00:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B709532C7
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 13:00:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EB1AB83391
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 21:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85752C340E8;
        Fri, 25 Feb 2022 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645822812;
        bh=bI7YVDKNBAfL8Da7yIKg5OXIqVqWryJ3PdebESkevuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UT8Axnl2y1kGbHyQzP/JPjOtYSK+6c9yOjXYp/EnHw0qS5NnFP7jtc9t2Ecn0gX0F
         YAGvLxj4u5MlRVs2IWGcdDX77CXJKrz5XrpFBpCAil7TydrwEuE/nimXRGT+bf8qaS
         Bxb9XxhKhc93eswnFSPN9SiqFfPh4KjiEKW9b40m8MJH7/SGtEvG+U/Zsp3mt/WfGT
         995SA8teArlkRgIa3iYQHN5dTpNte+C0qjnzOfeTwTy1kwL39aA2u2HYfZNLUMOinW
         j3hPNPpGQ0/Ye3V67JhkhNSaCQCiGn0ArltiIokmyOsOGqZkRRSaSN2Gltdt6hl508
         gv9JPFxKvy2/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D07FE6D453;
        Fri, 25 Feb 2022 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164582281244.5121.11798369109469658699.git-patchwork-notify@kernel.org>
Date:   Fri, 25 Feb 2022 21:00:12 +0000
References: <20220225185923.2535519-1-fallentree@fb.com>
In-Reply-To: <20220225185923.2535519-1-fallentree@fb.com>
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        sunyucong@gmail.com, kernel-team@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 25 Feb 2022 10:59:24 -0800 you wrote:
> In a previous commit (1), BPF preload process was switched from user mode
> process to use in-kernel light skeleton instead. However, in the kernel context
> the available FD starts from 0, instead of normally 3 for user mode process.
> The preload process also left two FDs open, taking over FD 0 and 1. This later
> caused issues when kernel trys to setup stdin/stdout/stderr for init process,
> assuming FD 0,1,2 are available.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Fix issue with bpf preload module taking over stdout/stdin of kernel.
    https://git.kernel.org/bpf/bpf-next/c/80bebebdac93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


