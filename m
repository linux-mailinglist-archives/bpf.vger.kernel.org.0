Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA74487EB7
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 23:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiAGWAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 17:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiAGWAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 17:00:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AFCC061574
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 14:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 683FA61F5F
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 22:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD47AC36AED;
        Fri,  7 Jan 2022 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641592810;
        bh=rgb81Tfy5vFXWwgI/SSx2GhlqgBA4TeqnxL1rlYtiYg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rF+Q57sPyzqC6p02LJ+Hzl6OTdVJbQMCSKC3dCxUeAZ7TNeNIdlU8E8yx8tiEo80Z
         ZWTiYn1tLFSu0Xcxr0jsqcWd1Nov9Cd01KOsJB1/sUTj7uYOX1PtQcTa00+7mLJn1o
         TUvFGcf8qefeSh9WKk3yp0/5AYxD0q0Ty8rasUSKnIEqjMyHrCjC4Ee3ISlr6IaQ5R
         tlyokuIC6MO2+oX3kOBMXGpZxINmaOOSp1gtsvsTf50ITxIXOhcaOGoDH3qeS7owFW
         PwlF3Vy/qrbfD6/hbXQ1pQw+KYXx43k+BJBPCdTuBxwsOEtUNeQ5nmvlX8+rmNaa7L
         Mv2glBmctUd9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B155CF7940C;
        Fri,  7 Jan 2022 22:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] libbpf: rename bpf_prog_attach_xattr to
 bpf_prog_attach_opts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164159281072.23296.8741938559163917542.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jan 2022 22:00:10 +0000
References: <20220107184604.3668544-1-christylee@fb.com>
In-Reply-To: <20220107184604.3668544-1-christylee@fb.com>
To:     Christy Lee <christylee@fb.com>
Cc:     andrii@kernel.org, acme@kernel.org, christyc.y.lee@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 7 Jan 2022 10:46:02 -0800 you wrote:
> All xattr APIs are being dropped, mark bpf_prog_attach_opts() as deprecated
> and rename to bpf_prog_attach_xattr(). Replace all usages of the deprecated
> function with the new function name.
> 
>   [0] Closes: https://github.com/libbpf/libbpf/issues/285
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] libbpf: rename bpf_prog_attach_xattr() to bpf_prog_attach_opts()
    https://git.kernel.org/bpf/bpf-next/c/88cbd9222e88
  - [bpf-next,v3,2/2] selftests/bpf: change bpf_prog_attach_xattr() to bpf_prog_attach_opts()
    https://git.kernel.org/bpf/bpf-next/c/f12363ec5a38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


