Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779BB63FF41
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 04:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiLBDuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 22:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiLBDuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 22:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3176ACCFF5
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 19:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8378621EF
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 03:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17DE2C433D7;
        Fri,  2 Dec 2022 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669953016;
        bh=LnS/AiZHj9N0L9piPnOfqf9oHgnl6QzCHnFA4zjdio8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ekgm2TijvYXHUY0qS5K+Syvqu9MOmdPUpCSaxSq+0y3pe84Hs31rZ4tmE3UqT3YdW
         XhXVulwZEcnAHWE7KbVVt+4m1FmV/gYfAzfXbygWujZ8ClCdZ8/goUx8AdD7uAkN1L
         aIAhDeE7xzHUpz0FYctbOaQlP2l3vPyguVTVBTVeBgN0ileFbKevo5mwUgBSo7cDzn
         z+8f/7dAz7aUkA4PMAeM/he7WkuEZhPNN1/0ShpK2Eywi/hM8gN6t1HbSgsnipdsH3
         mbxzhdXne74hFCkYQoIx7fBXuiK020WYZV15PKS2fSVd7omQ5/3kMDELsWpMgi1sBQ
         TIo5crw1a2kKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2141C395EC;
        Fri,  2 Dec 2022 03:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix release_on_unlock release logic for
 multiple refs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166995301598.8499.11538019809348261735.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Dec 2022 03:50:15 +0000
References: <20221201183406.1203621-1-davemarchevsky@fb.com>
In-Reply-To: <20221201183406.1203621-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@meta.com, yhs@fb.com,
        memxor@gmail.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 1 Dec 2022 10:34:05 -0800 you wrote:
> Consider a verifier state with three acquired references, all with
> release_on_unlock = true:
> 
>             idx  0 1 2
>   state->refs = [2 4 6]
> 
> (with 2, 4, and 6 being the ref ids).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Fix release_on_unlock release logic for multiple refs
    https://git.kernel.org/bpf/bpf-next/c/1f82dffc10ff
  - [v2,bpf-next,2/2] selftests/bpf: Validate multiple ref release_on_unlock logic
    https://git.kernel.org/bpf/bpf-next/c/78b037bd402d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


