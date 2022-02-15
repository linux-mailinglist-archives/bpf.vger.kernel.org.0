Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BDF4B75C9
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 21:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiBOSKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 13:10:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbiBOSKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 13:10:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C08119439
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 10:10:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49086B81C1C
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 18:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9F01C340F4;
        Tue, 15 Feb 2022 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644948610;
        bh=Te9DHjiO7emLJHKbUlKu/cyvT30gyoQ3bFDIVTGoa8Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=byXQ7tGRSUKKt7OrBuwzFxkxixf4141p7Kq7ezatFVLZOU+8rgGyj/ZmyNpE8Wy62
         PUQ080E/Hoef9/iaV+plN31THCbRQlW0p0/OIU4XgL/hM0Q+1obBT2O9HX7zMO3RQa
         ej0kVtJbEdMiIq9i1SN8lGzjRpwRxrBcjby7WXFsXny5QxUi2ZM8gPXprHwSNI36OH
         xpwr5AZFB8mjdT/dCLRMMVdMw2xun+JXpjr3JPmLByeFcQcE0JzvV3E1CkFyuE0t2H
         Wg/mmCk0g9xiq+yxmMIWTM+//JtG0XLUEmmBYkq5hIpktIlP9f8ikojq0YgCb/uVym
         P+WyDGvBMD38g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2526E6D458;
        Tue, 15 Feb 2022 18:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix GCC11 compiler warnings in -O2
 mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164494860985.24331.12560439773483115932.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Feb 2022 18:10:09 +0000
References: <20220211190927.1434329-1-andrii@kernel.org>
In-Reply-To: <20220211190927.1434329-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Feb 2022 11:09:27 -0800 you wrote:
> When compiling selftests in -O2 mode with GCC1, we get three new
> compilations warnings about potentially uninitialized variables.
> 
> Compiler is wrong 2 out of 3 times, but this patch makes GCC11 happy
> anyways, as it doesn't cost us anything and makes optimized selftests
> build less annoying.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix GCC11 compiler warnings in -O2 mode
    https://git.kernel.org/bpf/bpf-next/c/d3b0b80064e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


