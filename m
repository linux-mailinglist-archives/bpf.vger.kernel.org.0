Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1214C2128
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 02:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiBXBku (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 20:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBXBkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 20:40:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C9E62
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 17:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B586CB8235C
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 01:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60A8FC340F0;
        Thu, 24 Feb 2022 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645666813;
        bh=ci1rRZwwZza4xEVvh31Lq1ufSkbrXNuVBpqm1eLOv6g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UY22vIApEQxvvD4c2f9UzttFgJ9tG2ICs5LhDrNcpQE76RDKen7SvuoD0dJ041xGu
         TS469KVCf9VQsbkTkLH8W0LL8vie9ZA0fJ5Z07blpWG4ktG5IE6Bvtz0OH8dm9p9UA
         iyBYLol0SOhYEY+LsCi0twDp7erpB2PlrEH1I/tHhdcHKC6ZzOhW23X8E20Hv46Eks
         E4ZV5JhtDvyRC8rxkafunEUPqAxOmKoEDADkTIniSSFM1hGLbB17/S5a84eoLvreMb
         PvFU9O8kxQOuWZ7xECTUeKBJWkyYDLZ3AJyvIgw1NX2yaXuFh/PiQmnr9ZihJ30MGY
         XUr8NNbEJ2gag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49F25EAC097;
        Thu, 24 Feb 2022 01:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpftool: bpf skeletons assert type sizes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164566681329.3224.5652929904826304029.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Feb 2022 01:40:13 +0000
References: <f562455d7b3cf338e59a7976f4690ec5a0057f7f.camel@fb.com>
In-Reply-To: <f562455d7b3cf338e59a7976f4690ec5a0057f7f.camel@fb.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org
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

On Wed, 23 Feb 2022 22:01:58 +0000 you wrote:
> When emitting type declarations in skeletons, bpftool will now also emit
> static assertions on the size of the data/bss/rodata/etc fields. This
> ensures that in situations where userspace and kernel types have the same
> name but differ in size we do not silently produce incorrect results but
> instead break the build.
> 
> This was reported in [1] and as expected the repro in [2] fails to build
> on the new size assert after this change.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpftool: bpf skeletons assert type sizes
    https://git.kernel.org/bpf/bpf-next/c/08d4dba6ae77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


