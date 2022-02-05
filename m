Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42E4AA5BF
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 03:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356009AbiBECaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 21:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352163AbiBECaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 21:30:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE526C061346
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 18:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACE4FB83999
        for <bpf@vger.kernel.org>; Sat,  5 Feb 2022 02:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 469EEC340E9;
        Sat,  5 Feb 2022 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644028209;
        bh=Q6JLuU7E3M3I/76/RFoClzzEWlibC+zxsbqo3Z53/4I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F3yv5oogye0qGJfCOqPODz6vHdNd7ff2a7kIt/jiivre+CuXeg5QmZzEsG8jkDhlt
         h5489O6Ok0XWAooLc2Ruy7jULI/63DI+PKSezBFxlj3EchZ4gtUMnShe1mocCjl+K3
         f5B15/jF2Fp/0aZTOVws769iwSLJtR+WnpYaBnVdFIiTUiVO6ABkDaUouis9Ojd1LH
         U0otWltdpKNLzikCGCalg0FBMzsnnN7d7WluSsKMEWPPBlX01ry0ZcVEJYJtMGWjdA
         BhR2br3NC2/NLChwoJOD9qirHg/eJDE/wIqzJeDKTrRWDN6o1wOu2/+qnnQlgkMzvv
         O6eQW4mU1vu5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2918DE5D09D;
        Sat,  5 Feb 2022 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: fix build issue with llvm-readelf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164402820916.25870.14873294297899632402.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Feb 2022 02:30:09 +0000
References: <20220204214355.502108-1-yhs@fb.com>
In-Reply-To: <20220204214355.502108-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, delyank@fb.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 4 Feb 2022 13:43:55 -0800 you wrote:
> There are cases where clang compiler is packaged in a way
> readelf is a symbolic link to llvm-readelf. In such cases,
> llvm-readelf will be used instead of default binutils readelf,
> and the following error will appear during libbpf build:
> 
>   Warning: Num of global symbols in
>    /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o (367)
>    does NOT match with num of versioned symbols in
>    /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so libbpf.map (383).
>    Please make sure all LIBBPF_API symbols are versioned in libbpf.map.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: fix build issue with llvm-readelf
    https://git.kernel.org/bpf/bpf-next/c/0908a66ad112

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


