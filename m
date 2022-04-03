Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F944F0D10
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 01:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355215AbiDCXwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 19:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376730AbiDCXwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 19:52:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B277227CF5
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 16:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A5B0B80DB7
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 23:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0040DC340F0;
        Sun,  3 Apr 2022 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649029812;
        bh=jBKg73e26vR8XYdH/ulNv+uwZWdnm6qaxtURrr8Kf6A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iPW9mMqlLJn/zsiz2w8bXtXBtZSNZEkISixSX9qa98zNX8ChmgPs8Q6qdf/Zx43Ws
         GaeYLpYBAogz3e+JQm8z36oup0SUxyjHiTzct8WHZKWTr21KxPmuTPCIQdvqgUlbnb
         nv5pVcaIng5rwpXA6jyUgeIX96aTkpSsbRUpKtqjn/3GSRJNyMidOAr33uxS5rkNJp
         H0WmlPEBXMU/C5tiNpO9siX60Wknwkf/oWBSe+JCyd2rQScOvvcnL3YxfYA5ajAd+A
         MxmJLV3DKilfewYnMLBoJuX7PyjUWJivMVjemQqgQ8ciS7uaf06aoGoIHgs5V+aWyD
         7Bh9DSlru05mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF873E85AE7;
        Sun,  3 Apr 2022 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftest/bpf: Fix vfs_link kprobe definition
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164902981184.6975.14108307744576557773.git-patchwork-notify@kernel.org>
Date:   Sun, 03 Apr 2022 23:50:11 +0000
References: <20220331140949.1410056-1-nborisov@suse.com>
In-Reply-To: <20220331140949.1410056-1-nborisov@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
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

On Thu, 31 Mar 2022 17:09:49 +0300 you wrote:
> Since commit 6521f8917082 ("namei: prepare for idmapped mounts")
> vfs_link's prototype was changed, the kprobe definition in
> profiler selftest in turn wasn't updated. The result is that all
> argument after the first are now stored in different registers. This
> means that self-test has been broken ever since. Fix it by updating the
> kprobe definition accordingly.
> 
> [...]

Here is the summary with links:
  - selftest/bpf: Fix vfs_link kprobe definition
    https://git.kernel.org/bpf/bpf-next/c/e299bcd4d16f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


