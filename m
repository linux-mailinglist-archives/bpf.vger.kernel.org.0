Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4250633A
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 06:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345612AbiDSEc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 00:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiDSEcz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 00:32:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E020BD9
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2382B81125
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 04:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63668C385AA;
        Tue, 19 Apr 2022 04:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650342611;
        bh=QWb76ai54PQuxt69PjrZB+CaTqSFAEF59S5w8GjYK3U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BqBElNC1AxuYp1wW8Tus+4wNnpZVdlY3j9OKAbufKUpu2rsJO0ZjfrjPF6wm3ycHD
         mnnUYl8MdffuhCFuUQ+jxL+8MW8uUgciBKNd1Viu/6pGrSR94HtvK0dta0pqBI6Prw
         wT/bmBg+X3hHSm8s1ARPKHCPhbWl5RqTMUoh7btsGSeTwuhoATPaExcDH7i5H1toG7
         UVdUKsF/RWAecQ3iY7JgI7ucI6ibXWA/RTNgFooQua7Gu7OG2MKZBwcjNAYJR6Zms/
         QGU09ZT+wIqJ0rA9a9pNLccmGD041hw9KBKJo/Fwnjm18wGOfI0HM27B04CPNhSHgH
         tJuC4RPN/JQKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4311FEAC09C;
        Tue, 19 Apr 2022 04:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: refactor prog_tests logging and
 test execution
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165034261127.2677.996654647949648125.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 04:30:11 +0000
References: <20220418222507.1726259-1-mykolal@fb.com>
In-Reply-To: <20220418222507.1726259-1-mykolal@fb.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 18 Apr 2022 15:25:07 -0700 you wrote:
> This is a pre-req to add separate logging for each subtest in
> test_progs.
> 
> Move all the mutable test data to the test_result struct.
> Move per-test init/de-init into the run_one_test function.
> Consolidate data aggregation and final log output in
> calculate_and_print_summary function.
> As a side effect, this patch fixes double counting of errors
> for subtests and possible duplicate output of subtest log
> on failures.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: refactor prog_tests logging and test execution
    https://git.kernel.org/bpf/bpf-next/c/2324257dbd68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


