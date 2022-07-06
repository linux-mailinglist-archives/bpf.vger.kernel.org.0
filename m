Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40C567D10
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 06:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGFEUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 00:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiGFEUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 00:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA931834E
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 21:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6EEFB81AA0
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 04:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97511C341DB;
        Wed,  6 Jul 2022 04:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657081214;
        bh=AssaLb3Lrxb6cNcFSuiADzXeCzHJrz+TkdV4Ivr8QqM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vf4HClIF/1cdl8DCd/Ds3vrTdruTA9j4IO2Wf3fCmxs96RLqQErJl9VOAkIcZgsLs
         fZmH/MeUiyxpVGgJpDXv+uMVKENmBT3mZEyPwf2DF2B+bwvsQIQOcEhKM/OxsVbFpJ
         5/+z4vA1yAot4zahYaTSTTE0bI6wExeetD4Xlp191+2SeBKDLqQhOlmzGO1Sm+qCMq
         k0Nyq3DpwwRVHof8hErL39SieyGh/pBZoRY74LWHw8HiZCbDaw+RJabTIdvHCnKFtK
         APUI/2S62ZucLGi+tu8BCH6lQ2uf7s0SN0KV+EnhIX1ip40Ef3bJoqU5zlRxm7vFcC
         V2I+bNn+cZ/1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AC4BE45BDD;
        Wed,  6 Jul 2022 04:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/10] Introduce type match support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165708121449.4919.13204634393477172905.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Jul 2022 04:20:14 +0000
References: <20220628160127.607834-1-deso@posteo.net>
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, joannelkoong@gmail.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Jun 2022 16:01:17 +0000 you wrote:
> This patch set proposes the addition of a new way for performing type queries to
> BPF. It introduces the "type matches" relation, similar to what is already
> present with "type exists" (in the form of bpf_core_type_exists).
> 
> "type exists" performs fairly superficial checking, mostly concerned with
> whether a type exists in the kernel and is of the same kind (enum/struct/...).
> Notably, compatibility checks for members of composite types is lacking.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/10] bpf: Introduce TYPE_MATCH related constants/macros
    https://git.kernel.org/bpf/bpf-next/c/3c660a5d86f4
  - [bpf-next,v3,02/10] bpftool: Honor BPF_CORE_TYPE_MATCHES relocation
    https://git.kernel.org/bpf/bpf-next/c/633e7ceb2cbb
  - [bpf-next,v3,03/10] bpf: Introduce btf_int_bits() function
    (no matching commit)
  - [bpf-next,v3,04/10] libbpf: Add type match support
    https://git.kernel.org/bpf/bpf-next/c/ec6209c8d42f
  - [bpf-next,v3,05/10] bpf: Add type match support
    (no matching commit)
  - [bpf-next,v3,06/10] libbpf: Honor TYPE_MATCH relocation
    (no matching commit)
  - [bpf-next,v3,07/10] selftests/bpf: Add type-match checks to type-based tests
    https://git.kernel.org/bpf/bpf-next/c/67d8ed429525
  - [bpf-next,v3,08/10] selftests/bpf: Add test checking more characteristics
    https://git.kernel.org/bpf/bpf-next/c/bed56a6dd4cb
  - [bpf-next,v3,09/10] selftests/bpf: Add nested type to type based tests
    https://git.kernel.org/bpf/bpf-next/c/537905c4b68f
  - [bpf-next,v3,10/10] selftests/bpf: Add type match test against kernel's task_struct
    https://git.kernel.org/bpf/bpf-next/c/950b34778722

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


